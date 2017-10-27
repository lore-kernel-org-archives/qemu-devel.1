Received: from eggs.gnu.org ([2001:4830:134:3::10]:58182)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zachriggle@gmail.com>) id 1e89yx-0001tH-1s
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 15:07:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zachriggle@gmail.com>) id 1e89yv-0000w3-GA
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 15:07:51 -0400
MIME-Version: 1.0
In-Reply-To: <CAMP9c5mm7icy06goXr3iiOEgqPbzyaWDt775+9+L=oxnqwRhpA@mail.gmail.com>
References: <20171024230758.31779-1-riggle@google.com>
	<20171025033442.44872-1-zachriggle@gmail.com>
	<CAMP9c5=whCgR4qkOPDRKZ+adpWEPiVM=BwZp_r7qCAR7UAsWAQ@mail.gmail.com>
	<20171027093600.GA29513@kos.to>
	<CAMP9c5mm7icy06goXr3iiOEgqPbzyaWDt775+9+L=oxnqwRhpA@mail.gmail.com>
From: Zach Riggle <zachriggle@gmail.com>
Date: Fri, 27 Oct 2017 14:07:24 -0500
Message-ID: <CAMP9c5kTQmKd7GVE8DZzvY8tTtWV=tLsgV1ptWPKhEAh=J-maQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2] linux-user: fix is_proc_myself to check
 the paths via realpath
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Riku Voipio <riku.voipio@iki.fi>
Cc: qemu-trivial@nongnu.org, Laurent Vivier <laurent@vivier.eu>, "open list:All patches CC here" <qemu-devel@nongnu.org>

Another case that may be more relevant for general QEMU use, is that the
current code fails if the software under test has poor path-handling code.
For example, any of

- //proc/self/maps
- /proc//self/maps
- /proc/self//maps

Will all return the non-emulated results.  Those examples are just path
canonicalization issues and could be resolved with e.g.
canonicalize_file_name, but I'm not sure if QEMU allows GNU extensions --
and realpath() is portable.




*Zach Riggle*

On Fri, Oct 27, 2017 at 12:05 PM, Zach Riggle <zachriggle@gmail.com> wrote:

> The symlink was just an easy test case.  Doing cd proc && cat ./self/maps
> will achieve the same thing.
>
> One instance where this matters is for testing IoT device firmware
> exploits, where one might do a GET request against
> ../../../../../../proc/self/maps in order to bypass ASLR.  Currently,
> this will return the memory layout of QEMU, not the emulated memory layout
> of the software under test.
>
>
> *Zach Riggle*
>
> On Fri, Oct 27, 2017 at 4:36 AM, Riku Voipio <riku.voipio@iki.fi> wrote:
>
>> On Thu, Oct 26, 2017 at 04:06:22PM -0500, Zach Riggle wrote:
>> > Friendly ping :)
>> >
>> > I've updated the patch with v2 which addresses the style issue
>>
>> I'll have a look at it soon.
>>
>> >
>> > *Zach Riggle*
>> >
>> > On Tue, Oct 24, 2017 at 10:34 PM, Zach Riggle <zachriggle@gmail.com>
>> wrote:
>> >
>> > > Previously, it was possible to get a handle to the "real"
>> /proc/self/mem
>> > > by creating a symlink to it and opening the symlink, or opening e.g.
>> > > "./mem" after chdir'ing to "/proc/self"
>>
>> When is this a problem? Symlinking to /proc/self seems to be a quite
>> weird usecase.
>>
>> > >
>> > >     $ ln -s /proc/self self
>> > >     $ cat self/maps
>> > >     60000000-602bc000 r-xp 00000000 fc:01 270375
>> > >    /usr/bin/qemu-arm-static
>> > >     604bc000-6050f000 rw-p 002bc000 fc:01 270375
>> > >    /usr/bin/qemu-arm-static
>> > >     ...
>> > >
>> > > Signed-off-by: Zach Riggle <zachriggle@gmail.com>
>> > > ---
>> > >  linux-user/syscall.c | 47 ++++++++++++++++++++++++++++--
>> -----------------
>> > >  1 file changed, 28 insertions(+), 19 deletions(-)
>> > >
>> > > diff --git a/linux-user/syscall.c b/linux-user/syscall.c
>> > > index 9bf901fa11..6c1f28a1f7 100644
>> > > --- a/linux-user/syscall.c
>> > > +++ b/linux-user/syscall.c
>> > > @@ -7496,26 +7496,35 @@ static int open_self_auxv(void *cpu_env, int
>> fd)
>> > >
>> > >  static int is_proc_myself(const char *filename, const char *entry)
>> > >  {
>> > > -    if (!strncmp(filename, "/proc/", strlen("/proc/"))) {
>> > > -        filename += strlen("/proc/");
>> > > -        if (!strncmp(filename, "self/", strlen("self/"))) {
>> > > -            filename += strlen("self/");
>> > > -        } else if (*filename >= '1' && *filename <= '9') {
>> > > -            char myself[80];
>> > > -            snprintf(myself, sizeof(myself), "%d/", getpid());
>> > > -            if (!strncmp(filename, myself, strlen(myself))) {
>> > > -                filename += strlen(myself);
>> > > -            } else {
>> > > -                return 0;
>> > > -            }
>> > > -        } else {
>> > > -            return 0;
>> > > -        }
>> > > -        if (!strcmp(filename, entry)) {
>> > > -            return 1;
>> > > -        }
>> > > +    char proc_self_entry[PATH_MAX + 1];
>> > > +    char proc_self_entry_realpath[PATH_MAX + 1];
>> > > +    char filename_realpath[PATH_MAX + 1];
>> > > +
>> > > +    if (PATH_MAX < snprintf(proc_self_entry,
>> > > +                            sizeof(proc_self_entry),
>> > > +                            "/proc/self/%s",
>> > > +                            entry)) {
>> > > +        /* Full path to "entry" is too long to fit in the buffer */
>> > > +        return 0;
>> > >      }
>> > > -    return 0;
>> > > +
>> > > +    if (!realpath(filename, filename_realpath)) {
>> > > +        /* File does not exist, or can't be canonicalized */
>> > > +        return 0;
>> > > +    }
>> > > +
>> > > +    if (!realpath(proc_self_entry, proc_self_entry_realpath)) {
>> > > +        /* Procfs entry does not exist */
>> > > +        return 0;
>> > > +    }
>> > > +
>> > > +    if (strcmp(filename_realpath, proc_self_entry_realpath) != 0) {
>> > > +        /* Paths are different */
>> > > +        return 0;
>> > > +    }
>> > > +
>> > > +    /* filename refers to /proc/self/<entry> */
>> > > +    return 1;
>> > >  }
>> > >
>> > >  #if defined(HOST_WORDS_BIGENDIAN) != defined(TARGET_WORDS_BIGENDIAN)
>> > > --
>> > > 2.14.3
>> > >
>> > >
>>
>
>
