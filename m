Received: from eggs.gnu.org ([2001:4830:134:3::10]:52733)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zachriggle@gmail.com>) id 1eDKud-0004Vu-BO
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 20:48:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zachriggle@gmail.com>) id 1eDKua-0001Ht-Q1
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 20:48:47 -0500
MIME-Version: 1.0
In-Reply-To: <CAMP9c5m6GK_Xwt6z3Bj+1WauHzHffzFb1cVD9ojeh2m8gA-D8w@mail.gmail.com>
References: <20171024230758.31779-1-riggle@google.com>
	<20171025033442.44872-1-zachriggle@gmail.com>
	<fac44468-7869-57fa-fb5f-fbd98828489f@vivier.eu>
	<CAMP9c5m6GK_Xwt6z3Bj+1WauHzHffzFb1cVD9ojeh2m8gA-D8w@mail.gmail.com>
From: Zach Riggle <zachriggle@gmail.com>
Date: Fri, 10 Nov 2017 19:48:09 -0600
Message-ID: <CAMP9c5kG9m-swMJBtdQPzPkjLy7zq9sEdRA-PGcdeFDAT-DH9w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
To: Laurent Vivier <laurent@vivier.eu>
Cc: QEMU Trivial <qemu-trivial@nongnu.org>, Riku Voipio <riku.voipio@iki.fi>, "open list:All patches CC here" <qemu-devel@nongnu.org>

I wrote up a quick example to show that this should work specifically for
/proc/self/exe:

#define _GNU_SOURCE
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <unistd.h>
int main(int argc, char** argv) {
    int fd =3D open("/proc/self/exe", O_NOFOLLOW | O_PATH);
    system("ls -la /proc/$PPID/fd/");
}


*Zach Riggle*

On Fri, Nov 10, 2017 at 7:47 PM, Zach Riggle <zachriggle@gmail.com> wrote:

> Good catch.  Relying on realpath() for *exe* does cause issues.
>
> A better general solution (which handles the "exe" case) is to use open(2=
)
> with O_PATH | O_NOFOLLOW for the candidate path (e.g. /proc/self/exe) and
> to do the same for the path we're testing along with readlink().
>
> If, in the process of link resolution via the readlink() loop, we end up
> with the same path as our candidate, we can return true.  This avoids the
> need to rely on any libc implementation of realpath(), since we're just
> relying on the host kernel.
>
>
> *Zach Riggle*
>
> On Fri, Nov 10, 2017 at 5:44 PM, Laurent Vivier <laurent@vivier.eu> wrote=
:
>
>> Le 25/10/2017 =C3=A0 05:34, Zach Riggle a =C3=A9crit :
>> > Previously, it was possible to get a handle to the "real" /proc/self/m=
em
>> > by creating a symlink to it and opening the symlink, or opening e.g.
>> > "./mem" after chdir'ing to "/proc/self".
>> >
>> >     $ ln -s /proc/self self
>> >     $ cat self/maps
>> >     60000000-602bc000 r-xp 00000000 fc:01 270375
>>      /usr/bin/qemu-arm-static
>> >     604bc000-6050f000 rw-p 002bc000 fc:01 270375
>>      /usr/bin/qemu-arm-static
>> >     ...
>> >
>> > Signed-off-by: Zach Riggle <zachriggle@gmail.com>
>> > ---
>> >  linux-user/syscall.c | 47 ++++++++++++++++++++++++++++--
>> -----------------
>> >  1 file changed, 28 insertions(+), 19 deletions(-)
>> >
>> > diff --git a/linux-user/syscall.c b/linux-user/syscall.c
>> > index 9bf901fa11..6c1f28a1f7 100644
>> > --- a/linux-user/syscall.c
>> > +++ b/linux-user/syscall.c
>> > @@ -7496,26 +7496,35 @@ static int open_self_auxv(void *cpu_env, int f=
d)
>> >
>> >  static int is_proc_myself(const char *filename, const char *entry)
>> >  {
>> > -    if (!strncmp(filename, "/proc/", strlen("/proc/"))) {
>> > -        filename +=3D strlen("/proc/");
>> > -        if (!strncmp(filename, "self/", strlen("self/"))) {
>> > -            filename +=3D strlen("self/");
>> > -        } else if (*filename >=3D '1' && *filename <=3D '9') {
>> > -            char myself[80];
>> > -            snprintf(myself, sizeof(myself), "%d/", getpid());
>> > -            if (!strncmp(filename, myself, strlen(myself))) {
>> > -                filename +=3D strlen(myself);
>> > -            } else {
>> > -                return 0;
>> > -            }
>> > -        } else {
>> > -            return 0;
>> > -        }
>> > -        if (!strcmp(filename, entry)) {
>> > -            return 1;
>> > -        }
>> > +    char proc_self_entry[PATH_MAX + 1];
>> > +    char proc_self_entry_realpath[PATH_MAX + 1];
>> > +    char filename_realpath[PATH_MAX + 1];
>> > +
>> > +    if (PATH_MAX < snprintf(proc_self_entry,
>> > +                            sizeof(proc_self_entry),
>> > +                            "/proc/self/%s",
>> > +                            entry)) {
>> > +        /* Full path to "entry" is too long to fit in the buffer */
>> > +        return 0;
>> >      }
>> > -    return 0;
>> > +
>> > +    if (!realpath(filename, filename_realpath)) {
>> > +        /* File does not exist, or can't be canonicalized */
>> > +        return 0;
>> > +    }
>> > +
>> > +    if (!realpath(proc_self_entry, proc_self_entry_realpath)) {
>> > +        /* Procfs entry does not exist */
>> > +        return 0;
>> > +    }
>> > +
>> > +    if (strcmp(filename_realpath, proc_self_entry_realpath) !=3D 0) {
>> > +        /* Paths are different */
>>
>> I think it doesn't work with /proc/map/exe (or other soft link in
>> /proc/self) as realpath will give the path of the executable and not the
>> path inside /proc so it will be true for any process with the same
>> executable (which in our case is qemu for all).
>>
>> Thanks,
>> Laurent
>>
>>
>
