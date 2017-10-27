Received: from eggs.gnu.org ([2001:4830:134:3::10]:41051)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <voipio@kos.to>) id 1e813h-0004pk-NQ
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 05:36:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <voipio@kos.to>) id 1e813d-0004Nt-Me
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 05:36:09 -0400
Date: Fri, 27 Oct 2017 09:36:00 +0000
From: Riku Voipio <riku.voipio@iki.fi>
Message-ID: <20171027093600.GA29513@kos.to>
References: <20171024230758.31779-1-riggle@google.com>
	<20171025033442.44872-1-zachriggle@gmail.com>
	<CAMP9c5=whCgR4qkOPDRKZ+adpWEPiVM=BwZp_r7qCAR7UAsWAQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMP9c5=whCgR4qkOPDRKZ+adpWEPiVM=BwZp_r7qCAR7UAsWAQ@mail.gmail.com>
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
To: Zach Riggle <zachriggle@gmail.com>
Cc: qemu-trivial@nongnu.org, Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org

On Thu, Oct 26, 2017 at 04:06:22PM -0500, Zach Riggle wrote:
> Friendly ping :)
> 
> I've updated the patch with v2 which addresses the style issue

I'll have a look at it soon.
 
> 
> *Zach Riggle*
> 
> On Tue, Oct 24, 2017 at 10:34 PM, Zach Riggle <zachriggle@gmail.com> wrote:
> 
> > Previously, it was possible to get a handle to the "real" /proc/self/mem
> > by creating a symlink to it and opening the symlink, or opening e.g.
> > "./mem" after chdir'ing to "/proc/self"

When is this a problem? Symlinking to /proc/self seems to be a quite weird usecase.

> >
> >     $ ln -s /proc/self self
> >     $ cat self/maps
> >     60000000-602bc000 r-xp 00000000 fc:01 270375
> >    /usr/bin/qemu-arm-static
> >     604bc000-6050f000 rw-p 002bc000 fc:01 270375
> >    /usr/bin/qemu-arm-static
> >     ...
> >
> > Signed-off-by: Zach Riggle <zachriggle@gmail.com>
> > ---
> >  linux-user/syscall.c | 47 ++++++++++++++++++++++++++++-------------------
> >  1 file changed, 28 insertions(+), 19 deletions(-)
> >
> > diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> > index 9bf901fa11..6c1f28a1f7 100644
> > --- a/linux-user/syscall.c
> > +++ b/linux-user/syscall.c
> > @@ -7496,26 +7496,35 @@ static int open_self_auxv(void *cpu_env, int fd)
> >
> >  static int is_proc_myself(const char *filename, const char *entry)
> >  {
> > -    if (!strncmp(filename, "/proc/", strlen("/proc/"))) {
> > -        filename += strlen("/proc/");
> > -        if (!strncmp(filename, "self/", strlen("self/"))) {
> > -            filename += strlen("self/");
> > -        } else if (*filename >= '1' && *filename <= '9') {
> > -            char myself[80];
> > -            snprintf(myself, sizeof(myself), "%d/", getpid());
> > -            if (!strncmp(filename, myself, strlen(myself))) {
> > -                filename += strlen(myself);
> > -            } else {
> > -                return 0;
> > -            }
> > -        } else {
> > -            return 0;
> > -        }
> > -        if (!strcmp(filename, entry)) {
> > -            return 1;
> > -        }
> > +    char proc_self_entry[PATH_MAX + 1];
> > +    char proc_self_entry_realpath[PATH_MAX + 1];
> > +    char filename_realpath[PATH_MAX + 1];
> > +
> > +    if (PATH_MAX < snprintf(proc_self_entry,
> > +                            sizeof(proc_self_entry),
> > +                            "/proc/self/%s",
> > +                            entry)) {
> > +        /* Full path to "entry" is too long to fit in the buffer */
> > +        return 0;
> >      }
> > -    return 0;
> > +
> > +    if (!realpath(filename, filename_realpath)) {
> > +        /* File does not exist, or can't be canonicalized */
> > +        return 0;
> > +    }
> > +
> > +    if (!realpath(proc_self_entry, proc_self_entry_realpath)) {
> > +        /* Procfs entry does not exist */
> > +        return 0;
> > +    }
> > +
> > +    if (strcmp(filename_realpath, proc_self_entry_realpath) != 0) {
> > +        /* Paths are different */
> > +        return 0;
> > +    }
> > +
> > +    /* filename refers to /proc/self/<entry> */
> > +    return 1;
> >  }
> >
> >  #if defined(HOST_WORDS_BIGENDIAN) != defined(TARGET_WORDS_BIGENDIAN)
> > --
> > 2.14.3
> >
> >
