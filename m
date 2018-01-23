Received: from eggs.gnu.org ([2001:4830:134:3::10]:48392)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <agx@sigxcpu.org>) id 1ee1QO-0005ZM-1L
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 11:27:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <agx@sigxcpu.org>) id 1ee1QH-0007Ly-Ds
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 11:27:52 -0500
Date: Tue, 23 Jan 2018 17:27:18 +0100
From: Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>
Message-ID: <20180123162718.GA9252@bogon.m.sigxcpu.org>
References: <20180123145222.2487-1-f4bug@amsat.org>
	<20180123152339.GA23245@bogon.m.sigxcpu.org>
	<6d55a3e7-9d70-1ea1-2d22-65e136bda06b@vivier.eu>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="J2SCkAp4GZ/dPZZf"
Content-Disposition: inline
In-Reply-To: <6d55a3e7-9d70-1ea1-2d22-65e136bda06b@vivier.eu>
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] linux-user/syscall: let recvfrom(struct
 sockaddr *) use abi_ulong
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>
Cc: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>, Riku Voipio <riku.voipio@iki.fi>, qemu-devel@nongnu.org, qemu-arm@nongnu.org


--J2SCkAp4GZ/dPZZf
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,
On Tue, Jan 23, 2018 at 05:12:26PM +0100, Laurent Vivier wrote:
> Le 23/01/2018 =E0 16:23, Guido G=FCnther a =E9crit=A0:
> > Hi,
> > Thanks for having a look!
> >=20
> > On Tue, Jan 23, 2018 at 11:52:22AM -0300, Philippe Mathieu-Daud=E9 wr=
ote:
> >> Currently recvfrom() is restricted to handle 32-bit pointers,
> >> remove this limit for 64-bit hosts.
> >>
> >> This fixes:
> >>
> >>   31572 socket(AF_NETLINK, SOCK_RAW, NETLINK_AUDIT) =3D 3
> >>   ...
> >>   31572 sendto(3, {{len=3D124, type=3D0x454 /* NLMSG_??? */, flags=3D=
NLM_F_REQUEST|NLM_F_ACK, seq=3D1, pid=3D0}, "op=3Dtest:message acct=3D\"?=
\" exe=3D\"/tmp/nl-bad-addr\" hostname=3Dlocalhost addr=3D? terminal=3D/d=
ev/pts/2 res=3Dsuccess\0\0\0"}, 124, 0, 0xfffffa3897d0, 0) =3D 124
> >>   31572 ppoll([{fd=3D3, events=3DPOLLIN}], 1, {tv_sec=3D0, tv_nsec=3D=
500000000}, NULL, 0) =3D 1 ([{fd=3D3, revents=3DPOLLIN}], left {tv_sec=3D=
0, tv_nsec=3D499993180})
> >>   31572 recvfrom(3, 0x112a50eb4, 8988, MSG_PEEK|MSG_DONTWAIT, 0xffff=
fa3897e0, 0x42) =3D -1 EFAULT (Bad address)
> >>
> >> Reported-by: Guido G=FCnther <agx@sigxcpu.org>
> >> Message-id: 20180123120541.GA14216@bogon.m.sigxcpu.org
> >> Signed-off-by: Philippe Mathieu-Daud=E9 <f4bug@amsat.org>
> >> ---
> >>  linux-user/syscall.c | 4 ++--
> >>  1 file changed, 2 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> >> index 11c9116c4a..28805b1785 100644
> >> --- a/linux-user/syscall.c
> >> +++ b/linux-user/syscall.c
> >> @@ -4032,7 +4032,7 @@ static abi_long do_recvfrom(int fd, abi_ulong =
msg, size_t len, int flags,
> >>      if (!host_msg)
> >>          return -TARGET_EFAULT;
> >>      if (target_addr) {
> >> -        if (get_user_u32(addrlen, target_addrlen)) {
> >> +        if (get_user_ual(addrlen, target_addrlen)) {
> >>              ret =3D -TARGET_EFAULT;
> >>              goto fail;
> >>          }
> >> @@ -4053,7 +4053,7 @@ static abi_long do_recvfrom(int fd, abi_ulong =
msg, size_t len, int flags,
> >>          }
> >>          if (target_addr) {
> >>              host_to_target_sockaddr(target_addr, addr, addrlen);
> >> -            if (put_user_u32(addrlen, target_addrlen)) {
> >> +            if (put_user_ual(addrlen, target_addrlen)) {
> >>                  ret =3D -TARGET_EFAULT;
> >>                  goto fail;
> >>              }
> >=20
> > Ahh...I saw these and was wondering how this would work on
> > 64bit. Unfortunately the patch doesn't change things:
> >=20
> >     4824  recvfrom(3, 0x1401f8eb4, 8988, MSG_PEEK|MSG_DONTWAIT, 0xfff=
fe10a8620, 0x42) =3D -1 EFAULT (Bad address)
> >=20
> > If you want me to report qemu -strace or s.th. please let me know.
> > Cheers,
> >  -- Guido
> >=20
>=20
> Could you try:
>=20
> strace -f chroot . /usr/bin/qemu-arm-static tmp/nl-bad-addr
>=20
> to see if the fault comes from the kernel or from QEMU.

Full strace is attached of

    strace -f -s2048 -onl-bad-addr.strace chroot armhf-chroot/ tmp/qemu-a=
rm-static tmp/a.out

is attched. The error is at the very end.
Cheers,
 -- Guido

--J2SCkAp4GZ/dPZZf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="nl-bad-addr.strace"
Content-Transfer-Encoding: quoted-printable

9559  execve("/usr/sbin/chroot", ["chroot", "armhf-chroot/", "tmp/qemu-arm-=
static", "tmp/a.out"], [/* 20 vars */]) =3D 0
9559  brk(NULL)                         =3D 0xaaaae718a000
9559  faccessat(AT_FDCWD, "/etc/ld.so.nohwcap", F_OK) =3D -1 ENOENT (No suc=
h file or directory)
9559  mmap(NULL, 12288, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1=
, 0) =3D 0xffff8e8a4000
9559  faccessat(AT_FDCWD, "/etc/ld.so.preload", R_OK) =3D -1 ENOENT (No suc=
h file or directory)
9559  openat(AT_FDCWD, "/etc/ld.so.cache", O_RDONLY|O_CLOEXEC) =3D 3
9559  fstat(3, {st_mode=3DS_IFREG|0644, st_size=3D16129, ...}) =3D 0
9559  mmap(NULL, 16129, PROT_READ, MAP_PRIVATE, 3, 0) =3D 0xffff8e8a0000
9559  close(3)                          =3D 0
9559  faccessat(AT_FDCWD, "/etc/ld.so.nohwcap", F_OK) =3D -1 ENOENT (No suc=
h file or directory)
9559  openat(AT_FDCWD, "/lib/aarch64-linux-gnu/libc.so.6", O_RDONLY|O_CLOEX=
EC) =3D 3
9559  read(3, "\177ELF\2\1\1\0\0\0\0\0\0\0\0\0\3\0\267\0\1\0\0\0\270\364\1\=
0\0\0\0\0@\0\0\0\0\0\0\0Xd\23\0\0\0\0\0\0\0\0\0@\0008\0\n\0@\0K\0J\0\6\0\0\=
0\5\0\0\0@\0\0\0\0\0\0\0@\0\0\0\0\0\0\0@\0\0\0\0\0\0\0000\2\0\0\0\0\0\0000\=
2\0\0\0\0\0\0\10\0\0\0\0\0\0\0\3\0\0\0\4\0\0\0\370\16\22\0\0\0\0\0\370\16\2=
2\0\0\0\0\0\370\16\22\0\0\0\0\0\33\0\0\0\0\0\0\0\33\0\0\0\0\0\0\0\10\0\0\0\=
0\0\0\0\1\0\0\0\5\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\354=
\377\22\0\0\0\0\0\354\377\22\0\0\0\0\0\0\0\1\0\0\0\0\0\1\0\0\0\6\0\0\0\200\=
f\23\0\0\0\0\0\200\f\24\0\0\0\0\0\200\f\24\0\0\0\0\0\0I\0\0\0\0\0\0 \206\0\=
0\0\0\0\0\0\0\1\0\0\0\0\0\2\0\0\0\6\0\0\0\210;\23\0\0\0\0\0\210;\24\0\0\0\0=
\0\210;\24\0\0\0\0\0\260\1\0\0\0\0\0\0\260\1\0\0\0\0\0\0\10\0\0\0\0\0\0\0\4=
\0\0\0\4\0\0\0p\2\0\0\0\0\0\0p\2\0\0\0\0\0\0p\2\0\0\0\0\0\0D\0\0\0\0\0\0\0D=
\0\0\0\0\0\0\0\4\0\0\0\0\0\0\0\7\0\0\0\4\0\0\0\200\f\23\0\0\0\0\0\200\f\24\=
0\0\0\0\0\200\f\24\0\0\0\0\0\20\0\0\0\0\0\0\0x\0\0\0\0\0\0\0\10\0\0\0\0\0\0=
\0P\345td\4\0\0\0\24\17\22\0\0\0\0\0\24\17\22\0\0\0\0\0\24\17\22\0\0\0\0\0\=
244\32\0\0\0\0\0\0\244\32\0\0\0\0\0\0\4\0\0\0\0\0\0\0Q\345td\6\0\0\0\0\0\0\=
0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\2=
0\0\0\0\0\0\0\0R\345td\4\0\0\0\200\f\23\0\0\0\0\0\200\f\24\0\0\0\0\0\200\f\=
24\0\0\0\0\0\2003\0\0\0\0\0\0\2003\0\0\0\0\0\0\1\0\0\0\0\0\0\0\4\0\0\0\24\0=
\0\0\3\0\0\0GNU\0\212\363\247\366\340\374D\0\246\3012\327\20\246\4)\307\274=
\251\371\4\0\0\0\20\0\0\0\1\0\0\0GNU\0\0\0\0\0\3\0\0\0\7\0\0\0\0\0\0\0\0\0\=
0\0\363\3\0\0\v\0\0\0\0\1\0\0\16\0\0\0\0000\20D\240 \2\1\210\3\346\220\305E=
\214\0\304\0\10\0\5\204\0`\300\200\0\r\212\f\0\4\20\0\210@2\10*@\210T<, \01=
62H&\204\300\214\4\10\0\2\2\16\241\254\32\4f\300\0\3002\0\300\0P\1 \201\10\=
204\v  ($\0\4 Z\0\20X\200\312DB(\0\6\200\20\30B\0 @\200\0IP\0Q\212@\22\0\0\=
0\0\10\0\0\21\20", 832) =3D 832
9559  fstat(3, {st_mode=3DS_IFREG|0755, st_size=3D1275672, ...}) =3D 0
9559  mmap(NULL, 1348256, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3=
, 0) =3D 0xffff8e733000
9559  mprotect(0xffff8e863000, 65536, PROT_NONE) =3D 0
9559  mmap(0xffff8e873000, 24576, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIX=
ED|MAP_DENYWRITE, 3, 0x130000) =3D 0xffff8e873000
9559  mmap(0xffff8e879000, 12960, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIX=
ED|MAP_ANONYMOUS, -1, 0) =3D 0xffff8e879000
9559  close(3)                          =3D 0
9559  mprotect(0xffff8e873000, 16384, PROT_READ) =3D 0
9559  mprotect(0xaaaab1ad1000, 4096, PROT_READ) =3D 0
9559  mprotect(0xffff8e8a9000, 4096, PROT_READ) =3D 0
9559  munmap(0xffff8e8a0000, 16129)     =3D 0
9559  brk(NULL)                         =3D 0xaaaae718a000
9559  brk(0xaaaae71ab000)               =3D 0xaaaae71ab000
9559  openat(AT_FDCWD, "/usr/lib/locale/locale-archive", O_RDONLY|O_CLOEXEC=
) =3D 3
9559  fstat(3, {st_mode=3DS_IFREG|0644, st_size=3D1679488, ...}) =3D 0
9559  mmap(NULL, 1679488, PROT_READ, MAP_PRIVATE, 3, 0) =3D 0xffff8e598000
9559  close(3)                          =3D 0
9559  getcwd("/home/agx", 4096)         =3D 10
9559  newfstatat(AT_FDCWD, "/home/agx/armhf-chroot", {st_mode=3DS_IFDIR|075=
5, st_size=3D4096, ...}, AT_SYMLINK_NOFOLLOW) =3D 0
9559  chroot("armhf-chroot/")           =3D 0
9559  chdir("/")                        =3D 0
9559  execve("tmp/qemu-arm-static", ["tmp/qemu-arm-static", "tmp/a.out"], [=
/* 20 vars */]) =3D 0
9559  uname({sysname=3D"Linux", nodename=3D"aarch64", ...}) =3D 0
9559  brk(NULL)                         =3D 0x3dea7000
9559  brk(0x3dea8000)                   =3D 0x3dea8000
9559  set_tid_address(0x3dea70d0)       =3D 9559
9559  set_robust_list(0x3dea70e0, 24)   =3D 0
9559  rt_sigaction(SIGRTMIN, {sa_handler=3D0x53f700, sa_mask=3D[], sa_flags=
=3DSA_SIGINFO}, NULL, 8) =3D 0
9559  rt_sigaction(SIGRT_1, {sa_handler=3D0x53f7f0, sa_mask=3D[], sa_flags=
=3DSA_RESTART|SA_SIGINFO}, NULL, 8) =3D 0
9559  rt_sigprocmask(SIG_UNBLOCK, [RTMIN RT_1], NULL, 8) =3D 0
9559  getrlimit(RLIMIT_STACK, {rlim_cur=3D8192*1024, rlim_max=3DRLIM64_INFI=
NITY}) =3D 0
9559  readlinkat(AT_FDCWD, "/proc/self/exe", 0xffffcdb2a340, 4096) =3D -1 E=
NOENT (No such file or directory)
9559  brk(0x3dec9000)                   =3D 0x3dec9000
9559  faccessat(AT_FDCWD, "/etc/ld.so.nohwcap", F_OK) =3D -1 ENOENT (No suc=
h file or directory)
9559  rt_sigprocmask(SIG_SETMASK, ~[RTMIN RT_1], [], 8) =3D 0
9559  mmap(NULL, 8388608, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS|M=
AP_STACK, -1, 0) =3D 0xffff95712000
9559  mprotect(0xffff95712000, 4096, PROT_NONE) =3D 0
9559  clone(child_stack=3D0xffff95f10920, flags=3DCLONE_VM|CLONE_FS|CLONE_F=
ILES|CLONE_SIGHAND|CLONE_THREAD|CLONE_SYSVSEM|CLONE_SETTLS|CLONE_PARENT_SET=
TID|CLONE_CHILD_CLEARTID, parent_tidptr=3D0xffff95f110e0, tls=3D0xffff95f11=
700, child_tidptr=3D0xffff95f110e0) =3D 9560
9559  rt_sigprocmask(SIG_SETMASK, [], NULL, 8) =3D 0
9559  gettimeofday({tv_sec=3D1516724584, tv_usec=3D777757}, NULL) =3D 0
9559  getrlimit(RLIMIT_STACK, {rlim_cur=3D8192*1024, rlim_max=3DRLIM64_INFI=
NITY}) =3D 0
9559  gettimeofday({tv_sec=3D1516724584, tv_usec=3D784514}, NULL) =3D 0
9559  openat(AT_FDCWD, "/etc/qemu-binfmt/arm", O_RDONLY|O_NONBLOCK|O_DIRECT=
ORY|O_CLOEXEC) =3D -1 ENOENT (No such file or directory)
9559  uname({sysname=3D"Linux", nodename=3D"aarch64", ...}) =3D 0
9559  brk(0x3deea000)                   =3D 0x3deea000
9559  mmap(NULL, 528384, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -=
1, 0) =3D 0xffff95691000
9560  set_robust_list(0xffff95f110f0, 24) =3D 0
9560  nanosleep({tv_sec=3D0, tv_nsec=3D10000000}, 0xffff95f107b8) =3D 0
9560  futex(0x26ddb98, FUTEX_WAIT, 4294967295, NULL <unfinished ...>
9559  mprotect(0x6d6000, 33550336, PROT_READ|PROT_WRITE|PROT_EXEC) =3D 0
9559  mprotect(0x26d5000, 4096, PROT_NONE) =3D 0
9559  madvise(0x6d6c50, 33547184, MADV_HUGEPAGE) =3D -1 EINVAL (Invalid arg=
ument)
9559  mmap(NULL, 23261184, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS,=
 -1, 0) =3D 0xffff94062000
9559  brk(0x3df0b000)                   =3D 0x3df0b000
9559  mmap(NULL, 4143972352, PROT_NONE, MAP_PRIVATE|MAP_ANONYMOUS|MAP_NORES=
ERVE, -1, 0) =3D 0xfffe9d062000
9559  mmap(0xffff9d052000, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANON=
YMOUS, -1, 0) =3D 0xffff9d052000
9559  mprotect(0xffff9d052000, 4096, PROT_READ) =3D 0
9559  openat(AT_FDCWD, "/proc/sys/vm/mmap_min_addr", O_RDONLY) =3D -1 ENOEN=
T (No such file or directory)
9559  gettid()                          =3D 9559
9559  openat(AT_FDCWD, "tmp/a.out", O_RDONLY) =3D 3
9559  fstat(3, {st_mode=3DS_IFREG|0755, st_size=3D8460, ...}) =3D 0
9559  geteuid()                         =3D 0
9559  getegid()                         =3D 0
9559  read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0(\0\1\0\0\0a\7\0\0004\0\0=
\0\204\34\0\0\0\4\0\0054\0 \0\t\0(\0\35\0\34\0\1\0\0pP\t\0\0P\t\0\0P\t\0\0\=
10\0\0\0\10\0\0\0\4\0\0\0\4\0\0\0\6\0\0\0004\0\0\0004\0\0\0004\0\0\0 \1\0\0=
 \1\0\0\5\0\0\0\4\0\0\0\3\0\0\0T\1\0\0T\1\0\0T\1\0\0\31\0\0\0\31\0\0\0\4\0\=
0\0\1\0\0\0\1\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\\\t\0\0\\\t\0\0\5\0\0\0\0\0\1\0=
\1\0\0\0\0\17\0\0\0\17\1\0\0\17\1\0`\1\0\0d\1\0\0\6\0\0\0\0\0\1\0\2\0\0\0\1=
0\17\0\0\10\17\1\0\10\17\1\0\370\0\0\0\370\0\0\0\6\0\0\0\4\0\0\0\4\0\0\0p\1=
\0\0p\1\0\0p\1\0\0D\0\0\0D\0\0\0\4\0\0\0\4\0\0\0Q\345td\0\0\0\0\0\0\0\0\0\0=
\0\0\0\0\0\0\0\0\0\0\6\0\0\0\20\0\0\0R\345td\0\17\0\0\0\17\1\0\0\17\1\0\0\1=
\0\0\0\1\0\0\4\0\0\0\1\0\0\0/lib/ld-linux-armhf.so.3\0\0\0\0\4\0\0\0\20\0\0=
\0\1\0\0\0GNU\0\0\0\0\0\3\0\0\0\2\0\0\0\0\0\0\0\4\0\0\0\24\0\0\0\3\0\0\0GNU=
\0\366qT\247]\370\235n\370\223w9\201\266\376V\244N\264\304\3\0\0\0\21\0\0\0=
\4\0\0\0\7\0\0\0\1\21\0@\200@ \211\10\4\0M\200\5@@\21\0\0\0\25\0\0\0\32\0\0=
\0\0\2574\350BE\325\354\272\343\222|\257o\210\v\276\332W\33\332\315\343\236=
\330qX\34j\177\232|\271\215\361\16\f\24\342\236vT<\224\352\323\357\16Y\357\=
227y\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0H\6\0\0\0\0\0\0\3\0\v\0\0\0\0\0=
X\20\1\0\0\0\0\0\3\0\26\0\267\0\0\0\0\0\0\0\0\0\0\0\"\0\0\0\17\0\0\0\0\0\0\=
0\0\0\0\0 \0\0\0T\0\0\0\0\0\0\0\0\0\0\0\22\0\0\0\250\0\0\0\0\0\0\0\0\0\0\0\=
21\0\0\0\317\0\0\0\0\0\0\0\0\0\0\0\22\0\0\0\306\0\0\0\0\0\0\0\0\0\0\0\22\0\=
0\0+\0\0\0\0\0\0\0\0\0\0\0 \0\0\0\214\0\0\0\0\0\0\0\0\0\0\0\22\0\0\0v\0\0\0=
\0\0\0\0\0\0\0\0\22\0\0\0\257\0\0\0\0\0\0\0\0\0\0\0\22\0\0\0\227\0\0\0\0\0\=
0\0\0\0\0\0\22\0\0\0_\0\0\0\0\0\0\0\0\0\0\0\22\0\0\0:\0\0\0\0\0\0\0\0\0\0\0=
 \0\0\0\221\0\0\0\0\0\0\0\0\0\0\0\22\0\0\0\3\1\0\0d\20\1\0\0\0\0\0\20\0\27\=
0\341\0\0\0`\20\1\0\0\0\0\0\20\0\26\0\26\1\0\0d\20\1\0\0\0\0\0\20\0\27\0\25=
3\0\0\0q\10\0\0008\0\0\0\22\0\r\0\2\1\0\0d\20\1\0\0\0\0\0\20\0\27\0005\1\0\=
0\251\10\0\0@\0\0\0\22\0\r\0\350\0\0\0`\20\1\0\0\0\0\0\20\0\27\0\334\0\0\0\=
355\6\0\0t\0\0\0\22\0\r\0?\1\0\0H\6\0\0\0\0\0\0\22\0\v\0%\1\0\0\351\10\0\0\=
2\0\0\0\22\0\r\0\364\0\0\0`\20\1\0\0\0\0\0\20\0\27\0/\1\0\0\354\10\0\0\0\0\=
0\0\22\0\16\0\16\1\0\0d\20\1\0\0\0\0\0\20\0\27\0\0libaudit.so", 1024) =3D 1=
024
9559  mmap(0xffff94050000, 73728, PROT_NONE, MAP_PRIVATE|MAP_FIXED|MAP_ANON=
YMOUS|MAP_NORESERVE, -1, 0) =3D 0xffff94050000
9559  mmap(0xffff94050000, 4096, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_FIXED=
, 3, 0) =3D 0xffff94050000
9559  mmap(0xffff94060000, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXE=
D, 3, 0) =3D 0xffff94060000
9559  close(3)                          =3D 0
9559  mmap(0xffff9384f000, 8392704, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_F=
IXED|MAP_ANONYMOUS, -1, 0) =3D 0xffff9384f000
9559  mprotect(0xffff9384f000, 4096, PROT_NONE) =3D 0
9559  openat(AT_FDCWD, "/lib/ld-linux-armhf.so.3", O_RDONLY) =3D 3
9559  read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0(\0\1\0\0\0@\n\0\0004\0\0=
\0\310\231\1\0\0\4\0\0054\0 \0\7\0(\0\27\0\26\0\1\0\0pT\177\1\0T\177\1\0T\1=
77\1\0\350\0\0\0\350\0\0\0\4\0\0\0\4\0\0\0\1\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0<=
\200\1\0<\200\1\0\5\0\0\0\0\0\1\0\1\0\0\0`\212\1\0`\212\2\0`\212\2\0,\16\0\=
0\4\17\0\0\6\0\0\0\0\0\1\0\2\0\0\0D\217\1\0D\217\2\0D\217\2\0\270\0\0\0\270=
\0\0\0\6\0\0\0\4\0\0\0\4\0\0\0\24\1\0\0\24\1\0\0\24\1\0\0$\0\0\0$\0\0\0\4\0=
\0\0\4\0\0\0Q\345td\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\6\0\0\0\20\0\0\=
0R\345td`\212\1\0`\212\2\0`\212\2\0\240\5\0\0\240\5\0\0\4\0\0\0\1\0\0\0\4\0=
\0\0\24\0\0\0\3\0\0\0GNU\0\245\336-,\215\277\343b\300d\316\302\356\261\16\2=
13\323X\246\264\21\0\0\0\36\0\0\0\3\0\0\0\0\0\0\0\32\0\0\0\7\0\0\0\24\0\0\0=
\6\0\0\0\t\0\0\0\4\0\0\0\0\0\0\0\0\0\0\0\30\0\0\0\v\0\0\0\10\0\0\0\n\0\0\0\=
21\0\0\0\20\0\0\0\f\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\26\0\0\0\33\0\0\0=
\34\0\0\0\17\0\0\0\0\0\0\0\5\0\0\0\35\0\0\0\23\0\0\0\0\0\0\0\0\0\0\0\0\0\0\=
0\0\0\0\0\25\0\0\0\22\0\0\0\0\0\0\0\0\0\0\0\r\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0=
\0\0\0\0\27\0\0\0\31\0\0\0\0\0\0\0\16\0\0\0\0\0\0\0\21\0\0\0\3\0\0\0\10\0\0=
\0\10\0\0\0\0\4@\0=3D \0014\200\2 \304\r\5\200\0\200\0\v\0\0\n\20\20\201D\2=
00&\2\204l\0\0\0\0\0\3\0\0\0\5\0\0\0\6\0\0\0\0\0\0\0\t\0\0\0\f\0\0\0\0\0\0\=
0\r\0\0\0\16\0\0\0\21\0\0\0\22\0\0\0\24\0\0\0\25\0\0\0\26\0\0\0\27\0\0\0\33=
\0\0\0\326j\372\241\253\234\371ia\242\222\6\330=3Dl\366^\232\177g\207\360\2=
26|\306\16\340=3D\n\326\273$=3D\20uTi7J\265\223\321p\355T\251\245B\362\26\3=
46\365#d\274<I\336Xx\356\265\275\205\333\0\\\302;\205\353\34k\200<\262\357\=
322\212|F:m\206<\2559\r\334\271\327\237kC(\237 bd\7\250\224\24\360\353\1F\2=
10\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\t\0\0\0\0\0\0\3\0\v\0\0\0\0\0X=
\220\2\0\0\0\0\0\3\0\22\0\263\0\0\0001\325\0\0\30\0\0\0\22\0\v\0Z\1\0\0\264=
\212\2\0\4\0\0\0\21\0\17\0\252\1\0\0\0\0\0\0\0\0\0\0\21\0\361\377\240\1\0\0=
\0\0\0\0\0\0\0\0\21\0\361\377w\1\0\0\35\23\1\0x\0\0\0\22\0\v\0\207\1\0\0\27=
1\16\1\0 \0\0\0\"\0\v\0\21\1\0\0\35\20\1\0T\0\0\0\"\0\v\0008\1\0\0e\327\0\0=
\30\0\0\0\22\0\v\0n\1\0\0L\231\2\0\24\0\0\0\21\0\23\0@\0\0\0008\217\2\0\4\0=
\0\0\21\0\17\0j\0\0\0}\327\0\0X\0\0\0\22\0\v\0\16\0\0\0\311\337\0\0\214\0\0=
\0\22\0\v\0\313\0\0\0\201\16\1\0008\0\0\0\"\0\v\0\342\0\0\0\214\230\2\0\4\0=
\0\0\21\0\23\0-\1\0\0Y\316\0\0\250\2\0\0\22\0\v\0}\0\0\0", 1024) =3D 1024
9559  mmap(0xffff93825000, 172032, PROT_NONE, MAP_PRIVATE|MAP_FIXED|MAP_ANO=
NYMOUS|MAP_NORESERVE, -1, 0) =3D 0xffff93825000
9559  mmap(0xffff93825000, 102400, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_FIX=
ED, 3, 0) =3D 0xffff93825000
9559  mmap(0xffff9384d000, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXE=
D, 3, 0x18000) =3D 0xffff9384d000
9559  close(3)                          =3D 0
9559  getuid()                          =3D 0
9559  geteuid()                         =3D 0
9559  getgid()                          =3D 0
9559  getegid()                         =3D 0
9559  rt_sigprocmask(SIG_BLOCK, NULL, [], 8) =3D 0
9559  rt_sigaction(SIGHUP, NULL, {sa_handler=3DSIG_DFL, sa_mask=3D[], sa_fl=
ags=3D0}, 8) =3D 0
9559  rt_sigaction(SIGHUP, {sa_handler=3D0x445f70, sa_mask=3D~[RTMIN RT_1],=
 sa_flags=3DSA_SIGINFO}, NULL, 8) =3D 0
9559  rt_sigaction(SIGINT, NULL, {sa_handler=3DSIG_DFL, sa_mask=3D[], sa_fl=
ags=3D0}, 8) =3D 0
9559  rt_sigaction(SIGINT, {sa_handler=3D0x445f70, sa_mask=3D~[RTMIN RT_1],=
 sa_flags=3DSA_SIGINFO}, NULL, 8) =3D 0
9559  rt_sigaction(SIGQUIT, NULL, {sa_handler=3DSIG_DFL, sa_mask=3D[], sa_f=
lags=3D0}, 8) =3D 0
9559  rt_sigaction(SIGQUIT, {sa_handler=3D0x445f70, sa_mask=3D~[RTMIN RT_1]=
, sa_flags=3DSA_SIGINFO}, NULL, 8) =3D 0
9559  rt_sigaction(SIGILL, NULL, {sa_handler=3DSIG_DFL, sa_mask=3D[], sa_fl=
ags=3D0}, 8) =3D 0
9559  rt_sigaction(SIGILL, {sa_handler=3D0x445f70, sa_mask=3D~[RTMIN RT_1],=
 sa_flags=3DSA_SIGINFO}, NULL, 8) =3D 0
9559  rt_sigaction(SIGTRAP, NULL, {sa_handler=3DSIG_DFL, sa_mask=3D[], sa_f=
lags=3D0}, 8) =3D 0
9559  rt_sigaction(SIGTRAP, {sa_handler=3D0x445f70, sa_mask=3D~[RTMIN RT_1]=
, sa_flags=3DSA_SIGINFO}, NULL, 8) =3D 0
9559  rt_sigaction(SIGABRT, NULL, {sa_handler=3DSIG_DFL, sa_mask=3D[], sa_f=
lags=3D0}, 8) =3D 0
9559  rt_sigaction(SIGABRT, {sa_handler=3D0x445f70, sa_mask=3D~[RTMIN RT_1]=
, sa_flags=3DSA_SIGINFO}, NULL, 8) =3D 0
9559  rt_sigaction(SIGBUS, NULL, {sa_handler=3DSIG_DFL, sa_mask=3D[], sa_fl=
ags=3D0}, 8) =3D 0
9559  rt_sigaction(SIGBUS, {sa_handler=3D0x445f70, sa_mask=3D~[RTMIN RT_1],=
 sa_flags=3DSA_SIGINFO}, NULL, 8) =3D 0
9559  rt_sigaction(SIGFPE, NULL, {sa_handler=3DSIG_DFL, sa_mask=3D[], sa_fl=
ags=3D0}, 8) =3D 0
9559  rt_sigaction(SIGFPE, {sa_handler=3D0x445f70, sa_mask=3D~[RTMIN RT_1],=
 sa_flags=3DSA_SIGINFO}, NULL, 8) =3D 0
9559  rt_sigaction(SIGKILL, NULL, {sa_handler=3DSIG_DFL, sa_mask=3D[], sa_f=
lags=3D0}, 8) =3D 0
9559  rt_sigaction(SIGKILL, {sa_handler=3D0x445f70, sa_mask=3D~[RTMIN RT_1]=
, sa_flags=3DSA_SIGINFO}, NULL, 8) =3D -1 EINVAL (Invalid argument)
9559  rt_sigaction(SIGUSR1, NULL, {sa_handler=3DSIG_DFL, sa_mask=3D[], sa_f=
lags=3D0}, 8) =3D 0
9559  rt_sigaction(SIGUSR1, {sa_handler=3D0x445f70, sa_mask=3D~[RTMIN RT_1]=
, sa_flags=3DSA_SIGINFO}, NULL, 8) =3D 0
9559  rt_sigaction(SIGSEGV, NULL, {sa_handler=3DSIG_DFL, sa_mask=3D[], sa_f=
lags=3D0}, 8) =3D 0
9559  rt_sigaction(SIGSEGV, {sa_handler=3D0x445f70, sa_mask=3D~[RTMIN RT_1]=
, sa_flags=3DSA_SIGINFO}, NULL, 8) =3D 0
9559  rt_sigaction(SIGUSR2, NULL, {sa_handler=3DSIG_DFL, sa_mask=3D[], sa_f=
lags=3D0}, 8) =3D 0
9559  rt_sigaction(SIGUSR2, {sa_handler=3D0x445f70, sa_mask=3D~[RTMIN RT_1]=
, sa_flags=3DSA_SIGINFO}, NULL, 8) =3D 0
9559  rt_sigaction(SIGPIPE, NULL, {sa_handler=3DSIG_DFL, sa_mask=3D[], sa_f=
lags=3D0}, 8) =3D 0
9559  rt_sigaction(SIGPIPE, {sa_handler=3D0x445f70, sa_mask=3D~[RTMIN RT_1]=
, sa_flags=3DSA_SIGINFO}, NULL, 8) =3D 0
9559  rt_sigaction(SIGALRM, NULL, {sa_handler=3DSIG_DFL, sa_mask=3D[], sa_f=
lags=3D0}, 8) =3D 0
9559  rt_sigaction(SIGALRM, {sa_handler=3D0x445f70, sa_mask=3D~[RTMIN RT_1]=
, sa_flags=3DSA_SIGINFO}, NULL, 8) =3D 0
9559  rt_sigaction(SIGTERM, NULL, {sa_handler=3DSIG_DFL, sa_mask=3D[], sa_f=
lags=3D0}, 8) =3D 0
9559  rt_sigaction(SIGTERM, {sa_handler=3D0x445f70, sa_mask=3D~[RTMIN RT_1]=
, sa_flags=3DSA_SIGINFO}, NULL, 8) =3D 0
9559  rt_sigaction(SIGSTKFLT, NULL, {sa_handler=3DSIG_DFL, sa_mask=3D[], sa=
_flags=3D0}, 8) =3D 0
9559  rt_sigaction(SIGSTKFLT, {sa_handler=3D0x445f70, sa_mask=3D~[RTMIN RT_=
1], sa_flags=3DSA_SIGINFO}, NULL, 8) =3D 0
9559  rt_sigaction(SIGCHLD, NULL, {sa_handler=3DSIG_DFL, sa_mask=3D[], sa_f=
lags=3D0}, 8) =3D 0
9559  rt_sigaction(SIGCONT, NULL, {sa_handler=3DSIG_DFL, sa_mask=3D[], sa_f=
lags=3D0}, 8) =3D 0
9559  rt_sigaction(SIGSTOP, NULL, {sa_handler=3DSIG_DFL, sa_mask=3D[], sa_f=
lags=3D0}, 8) =3D 0
9559  rt_sigaction(SIGTSTP, NULL, {sa_handler=3DSIG_DFL, sa_mask=3D[], sa_f=
lags=3D0}, 8) =3D 0
9559  rt_sigaction(SIGTTIN, NULL, {sa_handler=3DSIG_DFL, sa_mask=3D[], sa_f=
lags=3D0}, 8) =3D 0
9559  rt_sigaction(SIGTTOU, NULL, {sa_handler=3DSIG_DFL, sa_mask=3D[], sa_f=
lags=3D0}, 8) =3D 0
9559  rt_sigaction(SIGURG, NULL, {sa_handler=3DSIG_DFL, sa_mask=3D[], sa_fl=
ags=3D0}, 8) =3D 0
9559  rt_sigaction(SIGXCPU, NULL, {sa_handler=3DSIG_DFL, sa_mask=3D[], sa_f=
lags=3D0}, 8) =3D 0
9559  rt_sigaction(SIGXCPU, {sa_handler=3D0x445f70, sa_mask=3D~[RTMIN RT_1]=
, sa_flags=3DSA_SIGINFO}, NULL, 8) =3D 0
9559  rt_sigaction(SIGXFSZ, NULL, {sa_handler=3DSIG_DFL, sa_mask=3D[], sa_f=
lags=3D0}, 8) =3D 0
9559  rt_sigaction(SIGXFSZ, {sa_handler=3D0x445f70, sa_mask=3D~[RTMIN RT_1]=
, sa_flags=3DSA_SIGINFO}, NULL, 8) =3D 0
9559  rt_sigaction(SIGVTALRM, NULL, {sa_handler=3DSIG_DFL, sa_mask=3D[], sa=
_flags=3D0}, 8) =3D 0
9559  rt_sigaction(SIGVTALRM, {sa_handler=3D0x445f70, sa_mask=3D~[RTMIN RT_=
1], sa_flags=3DSA_SIGINFO}, NULL, 8) =3D 0
9559  rt_sigaction(SIGPROF, NULL, {sa_handler=3DSIG_DFL, sa_mask=3D[], sa_f=
lags=3D0}, 8) =3D 0
9559  rt_sigaction(SIGPROF, {sa_handler=3D0x445f70, sa_mask=3D~[RTMIN RT_1]=
, sa_flags=3DSA_SIGINFO}, NULL, 8) =3D 0
9559  rt_sigaction(SIGWINCH, NULL, {sa_handler=3DSIG_DFL, sa_mask=3D[], sa_=
flags=3D0}, 8) =3D 0
9559  rt_sigaction(SIGIO, NULL, {sa_handler=3DSIG_DFL, sa_mask=3D[], sa_fla=
gs=3D0}, 8) =3D 0
9559  rt_sigaction(SIGIO, {sa_handler=3D0x445f70, sa_mask=3D~[RTMIN RT_1], =
sa_flags=3DSA_SIGINFO}, NULL, 8) =3D 0
9559  rt_sigaction(SIGPWR, NULL, {sa_handler=3DSIG_DFL, sa_mask=3D[], sa_fl=
ags=3D0}, 8) =3D 0
9559  rt_sigaction(SIGPWR, {sa_handler=3D0x445f70, sa_mask=3D~[RTMIN RT_1],=
 sa_flags=3DSA_SIGINFO}, NULL, 8) =3D 0
9559  rt_sigaction(SIGSYS, NULL, {sa_handler=3DSIG_DFL, sa_mask=3D[], sa_fl=
ags=3D0}, 8) =3D 0
9559  rt_sigaction(SIGSYS, {sa_handler=3D0x445f70, sa_mask=3D~[RTMIN RT_1],=
 sa_flags=3DSA_SIGINFO}, NULL, 8) =3D 0
9559  rt_sigaction(SIGRT_32, NULL, {sa_handler=3DSIG_DFL, sa_mask=3D[], sa_=
flags=3D0}, 8) =3D 0
9559  rt_sigaction(SIGRT_32, {sa_handler=3D0x445f70, sa_mask=3D~[RTMIN RT_1=
], sa_flags=3DSA_SIGINFO}, NULL, 8) =3D 0
9559  rt_sigaction(SIGRT_2, NULL, {sa_handler=3DSIG_DFL, sa_mask=3D[], sa_f=
lags=3D0}, 8) =3D 0
9559  rt_sigaction(SIGRT_2, {sa_handler=3D0x445f70, sa_mask=3D~[RTMIN RT_1]=
, sa_flags=3DSA_SIGINFO}, NULL, 8) =3D 0
9559  rt_sigaction(SIGRT_3, NULL, {sa_handler=3DSIG_DFL, sa_mask=3D[], sa_f=
lags=3D0}, 8) =3D 0
9559  rt_sigaction(SIGRT_3, {sa_handler=3D0x445f70, sa_mask=3D~[RTMIN RT_1]=
, sa_flags=3DSA_SIGINFO}, NULL, 8) =3D 0
9559  rt_sigaction(SIGRT_4, NULL, {sa_handler=3DSIG_DFL, sa_mask=3D[], sa_f=
lags=3D0}, 8) =3D 0
9559  rt_sigaction(SIGRT_4, {sa_handler=3D0x445f70, sa_mask=3D~[RTMIN RT_1]=
, sa_flags=3DSA_SIGINFO}, NULL, 8) =3D 0
9559  rt_sigaction(SIGRT_5, NULL, {sa_handler=3DSIG_DFL, sa_mask=3D[], sa_f=
lags=3D0}, 8) =3D 0
9559  rt_sigaction(SIGRT_5, {sa_handler=3D0x445f70, sa_mask=3D~[RTMIN RT_1]=
, sa_flags=3DSA_SIGINFO}, NULL, 8) =3D 0
9559  rt_sigaction(SIGRT_6, NULL, {sa_handler=3DSIG_DFL, sa_mask=3D[], sa_f=
lags=3D0}, 8) =3D 0
9559  rt_sigaction(SIGRT_6, {sa_handler=3D0x445f70, sa_mask=3D~[RTMIN RT_1]=
, sa_flags=3DSA_SIGINFO}, NULL, 8) =3D 0
9559  rt_sigaction(SIGRT_7, NULL, {sa_handler=3DSIG_DFL, sa_mask=3D[], sa_f=
lags=3D0}, 8) =3D 0
9559  rt_sigaction(SIGRT_7, {sa_handler=3D0x445f70, sa_mask=3D~[RTMIN RT_1]=
, sa_flags=3DSA_SIGINFO}, NULL, 8) =3D 0
9559  rt_sigaction(SIGRT_8, NULL, {sa_handler=3DSIG_DFL, sa_mask=3D[], sa_f=
lags=3D0}, 8) =3D 0
9559  rt_sigaction(SIGRT_8, {sa_handler=3D0x445f70, sa_mask=3D~[RTMIN RT_1]=
, sa_flags=3DSA_SIGINFO}, NULL, 8) =3D 0
9559  rt_sigaction(SIGRT_9, NULL, {sa_handler=3DSIG_DFL, sa_mask=3D[], sa_f=
lags=3D0}, 8) =3D 0
9559  rt_sigaction(SIGRT_9, {sa_handler=3D0x445f70, sa_mask=3D~[RTMIN RT_1]=
, sa_flags=3DSA_SIGINFO}, NULL, 8) =3D 0
9559  rt_sigaction(SIGRT_10, NULL, {sa_handler=3DSIG_DFL, sa_mask=3D[], sa_=
flags=3D0}, 8) =3D 0
9559  rt_sigaction(SIGRT_10, {sa_handler=3D0x445f70, sa_mask=3D~[RTMIN RT_1=
], sa_flags=3DSA_SIGINFO}, NULL, 8) =3D 0
9559  rt_sigaction(SIGRT_11, NULL, {sa_handler=3DSIG_DFL, sa_mask=3D[], sa_=
flags=3D0}, 8) =3D 0
9559  rt_sigaction(SIGRT_11, {sa_handler=3D0x445f70, sa_mask=3D~[RTMIN RT_1=
], sa_flags=3DSA_SIGINFO}, NULL, 8) =3D 0
9559  rt_sigaction(SIGRT_12, NULL, {sa_handler=3DSIG_DFL, sa_mask=3D[], sa_=
flags=3D0}, 8) =3D 0
9559  rt_sigaction(SIGRT_12, {sa_handler=3D0x445f70, sa_mask=3D~[RTMIN RT_1=
], sa_flags=3DSA_SIGINFO}, NULL, 8) =3D 0
9559  rt_sigaction(SIGRT_13, NULL, {sa_handler=3DSIG_DFL, sa_mask=3D[], sa_=
flags=3D0}, 8) =3D 0
9559  rt_sigaction(SIGRT_13, {sa_handler=3D0x445f70, sa_mask=3D~[RTMIN RT_1=
], sa_flags=3DSA_SIGINFO}, NULL, 8) =3D 0
9559  rt_sigaction(SIGRT_14, NULL, {sa_handler=3DSIG_DFL, sa_mask=3D[], sa_=
flags=3D0}, 8) =3D 0
9559  rt_sigaction(SIGRT_14, {sa_handler=3D0x445f70, sa_mask=3D~[RTMIN RT_1=
], sa_flags=3DSA_SIGINFO}, NULL, 8) =3D 0
9559  rt_sigaction(SIGRT_15, NULL, {sa_handler=3DSIG_DFL, sa_mask=3D[], sa_=
flags=3D0}, 8) =3D 0
9559  rt_sigaction(SIGRT_15, {sa_handler=3D0x445f70, sa_mask=3D~[RTMIN RT_1=
], sa_flags=3DSA_SIGINFO}, NULL, 8) =3D 0
9559  rt_sigaction(SIGRT_16, NULL, {sa_handler=3DSIG_DFL, sa_mask=3D[], sa_=
flags=3D0}, 8) =3D 0
9559  rt_sigaction(SIGRT_16, {sa_handler=3D0x445f70, sa_mask=3D~[RTMIN RT_1=
], sa_flags=3DSA_SIGINFO}, NULL, 8) =3D 0
9559  rt_sigaction(SIGRT_17, NULL, {sa_handler=3DSIG_DFL, sa_mask=3D[], sa_=
flags=3D0}, 8) =3D 0
9559  rt_sigaction(SIGRT_17, {sa_handler=3D0x445f70, sa_mask=3D~[RTMIN RT_1=
], sa_flags=3DSA_SIGINFO}, NULL, 8) =3D 0
9559  rt_sigaction(SIGRT_18, NULL, {sa_handler=3DSIG_DFL, sa_mask=3D[], sa_=
flags=3D0}, 8) =3D 0
9559  rt_sigaction(SIGRT_18, {sa_handler=3D0x445f70, sa_mask=3D~[RTMIN RT_1=
], sa_flags=3DSA_SIGINFO}, NULL, 8) =3D 0
9559  rt_sigaction(SIGRT_19, NULL, {sa_handler=3DSIG_DFL, sa_mask=3D[], sa_=
flags=3D0}, 8) =3D 0
9559  rt_sigaction(SIGRT_19, {sa_handler=3D0x445f70, sa_mask=3D~[RTMIN RT_1=
], sa_flags=3DSA_SIGINFO}, NULL, 8) =3D 0
9559  rt_sigaction(SIGRT_20, NULL, {sa_handler=3DSIG_DFL, sa_mask=3D[], sa_=
flags=3D0}, 8) =3D 0
9559  rt_sigaction(SIGRT_20, {sa_handler=3D0x445f70, sa_mask=3D~[RTMIN RT_1=
], sa_flags=3DSA_SIGINFO}, NULL, 8) =3D 0
9559  rt_sigaction(SIGRT_21, NULL, {sa_handler=3DSIG_DFL, sa_mask=3D[], sa_=
flags=3D0}, 8) =3D 0
9559  rt_sigaction(SIGRT_21, {sa_handler=3D0x445f70, sa_mask=3D~[RTMIN RT_1=
], sa_flags=3DSA_SIGINFO}, NULL, 8) =3D 0
9559  rt_sigaction(SIGRT_22, NULL, {sa_handler=3DSIG_DFL, sa_mask=3D[], sa_=
flags=3D0}, 8) =3D 0
9559  rt_sigaction(SIGRT_22, {sa_handler=3D0x445f70, sa_mask=3D~[RTMIN RT_1=
], sa_flags=3DSA_SIGINFO}, NULL, 8) =3D 0
9559  rt_sigaction(SIGRT_23, NULL, {sa_handler=3DSIG_DFL, sa_mask=3D[], sa_=
flags=3D0}, 8) =3D 0
9559  rt_sigaction(SIGRT_23, {sa_handler=3D0x445f70, sa_mask=3D~[RTMIN RT_1=
], sa_flags=3DSA_SIGINFO}, NULL, 8) =3D 0
9559  rt_sigaction(SIGRT_24, NULL, {sa_handler=3DSIG_DFL, sa_mask=3D[], sa_=
flags=3D0}, 8) =3D 0
9559  rt_sigaction(SIGRT_24, {sa_handler=3D0x445f70, sa_mask=3D~[RTMIN RT_1=
], sa_flags=3DSA_SIGINFO}, NULL, 8) =3D 0
9559  rt_sigaction(SIGRT_25, NULL, {sa_handler=3DSIG_DFL, sa_mask=3D[], sa_=
flags=3D0}, 8) =3D 0
9559  rt_sigaction(SIGRT_25, {sa_handler=3D0x445f70, sa_mask=3D~[RTMIN RT_1=
], sa_flags=3DSA_SIGINFO}, NULL, 8) =3D 0
9559  rt_sigaction(SIGRT_26, NULL, {sa_handler=3DSIG_DFL, sa_mask=3D[], sa_=
flags=3D0}, 8) =3D 0
9559  rt_sigaction(SIGRT_26, {sa_handler=3D0x445f70, sa_mask=3D~[RTMIN RT_1=
], sa_flags=3DSA_SIGINFO}, NULL, 8) =3D 0
9559  rt_sigaction(SIGRT_27, NULL, {sa_handler=3DSIG_DFL, sa_mask=3D[], sa_=
flags=3D0}, 8) =3D 0
9559  rt_sigaction(SIGRT_27, {sa_handler=3D0x445f70, sa_mask=3D~[RTMIN RT_1=
], sa_flags=3DSA_SIGINFO}, NULL, 8) =3D 0
9559  rt_sigaction(SIGRT_28, NULL, {sa_handler=3DSIG_DFL, sa_mask=3D[], sa_=
flags=3D0}, 8) =3D 0
9559  rt_sigaction(SIGRT_28, {sa_handler=3D0x445f70, sa_mask=3D~[RTMIN RT_1=
], sa_flags=3DSA_SIGINFO}, NULL, 8) =3D 0
9559  rt_sigaction(SIGRT_29, NULL, {sa_handler=3DSIG_DFL, sa_mask=3D[], sa_=
flags=3D0}, 8) =3D 0
9559  rt_sigaction(SIGRT_29, {sa_handler=3D0x445f70, sa_mask=3D~[RTMIN RT_1=
], sa_flags=3DSA_SIGINFO}, NULL, 8) =3D 0
9559  rt_sigaction(SIGRT_30, NULL, {sa_handler=3DSIG_DFL, sa_mask=3D[], sa_=
flags=3D0}, 8) =3D 0
9559  rt_sigaction(SIGRT_30, {sa_handler=3D0x445f70, sa_mask=3D~[RTMIN RT_1=
], sa_flags=3DSA_SIGINFO}, NULL, 8) =3D 0
9559  rt_sigaction(SIGRT_31, NULL, {sa_handler=3DSIG_DFL, sa_mask=3D[], sa_=
flags=3D0}, 8) =3D 0
9559  rt_sigaction(SIGRT_31, {sa_handler=3D0x445f70, sa_mask=3D~[RTMIN RT_1=
], sa_flags=3DSA_SIGINFO}, NULL, 8) =3D 0
9559  uname({sysname=3D"Linux", nodename=3D"aarch64", ...}) =3D 0
9559  faccessat(AT_FDCWD, "/etc/ld.so.nohwcap", F_OK) =3D -1 ENOENT (No suc=
h file or directory)
9559  faccessat(AT_FDCWD, "/etc/ld.so.preload", R_OK) =3D -1 ENOENT (No suc=
h file or directory)
9559  openat(AT_FDCWD, "/etc/ld.so.cache", O_RDONLY|O_CLOEXEC) =3D 3
9559  fstat(3, {st_mode=3DS_IFREG|0644, st_size=3D13472, ...}) =3D 0
9559  mmap(0xffff93821000, 16384, PROT_READ, MAP_PRIVATE|MAP_FIXED|MAP_ANON=
YMOUS, -1, 0) =3D 0xffff93821000
9559  mmap(0xffff93821000, 16384, PROT_READ, MAP_PRIVATE|MAP_FIXED, 3, 0) =
=3D 0xffff93821000
9559  close(3)                          =3D 0
9559  faccessat(AT_FDCWD, "/etc/ld.so.nohwcap", F_OK) =3D -1 ENOENT (No suc=
h file or directory)
9559  openat(AT_FDCWD, "/lib/arm-linux-gnueabihf/libaudit.so.1", O_RDONLY|O=
_CLOEXEC) =3D 3
9559  read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0(\0\1\0\0\0\254\"\0\0004\=
0\0\0\\\221\1\0\0\4\0\0054\0 \0\6\0(\0\31\0\30\0\1\0\0\0\0\0\0\0\0\0\0\0\0\=
0\0\0\224\210\1\0\224\210\1\0\5\0\0\0\0\0\1\0\1\0\0\0t\213\1\0t\213\2\0t\21=
3\2\0\230\4\0\0\4\245\0\0\6\0\0\0\0\0\1\0\2\0\0\0L\215\1\0L\215\2\0L\215\2\=
0\10\1\0\0\10\1\0\0\6\0\0\0\4\0\0\0\4\0\0\0\364\0\0\0\364\0\0\0\364\0\0\0$\=
0\0\0$\0\0\0\4\0\0\0\4\0\0\0Q\345td\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0=
\6\0\0\0\20\0\0\0R\345tdt\213\1\0t\213\2\0t\213\2\0\214\4\0\0\214\4\0\0\4\0=
\0\0\1\0\0\0\4\0\0\0\24\0\0\0\3\0\0\0GNU\0q\367\tSo\23\n\22f\362\225\317lT\=
362\303\204=3D\313FC\0\0\0G\0\0\0\20\0\0\0\t\0\0\0f\254v\26\227\21\20\202\6=
\270\216\5`E\304\2\200\1\"\1$!\200\214) \221\311i\0D\250\3\6\200\1@\300\0F\=
f\206\324CA\252\304\10\277\0 iE@\202\v\4\5B\211hV\5H\0\0\0\0G\0\0\0H\0\0\0J=
\0\0\0L\0\0\0\0\0\0\0O\0\0\0P\0\0\0\0\0\0\0Q\0\0\0R\0\0\0S\0\0\0\0\0\0\0T\0=
\0\0V\0\0\0X\0\0\0Y\0\0\0\0\0\0\0[\0\0\0\0\0\0\0\\\0\0\0]\0\0\0_\0\0\0b\0\0=
\0\0\0\0\0\0\0\0\0d\0\0\0g\0\0\0i\0\0\0j\0\0\0n\0\0\0q\0\0\0s\0\0\0u\0\0\0\=
0\0\0\0w\0\0\0\0\0\0\0x\0\0\0", 512) =3D 512
9559  lseek(3, 102748, SEEK_SET)        =3D 102748
9559  read(3, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0=
\0\0\0\0\0\0\0\0\0\0\v\0\0\0\7\0\0\0\2\0\0\0\364\0\0\0\364\0\0\0$\0\0\0\0\0=
\0\0\0\0\0\0\4\0\0\0\0\0\0\0\36\0\0\0\366\377\377o\2\0\0\0\30\1\0\0\30\1\0\=
0\314\2\0\0\3\0\0\0\0\0\0\0\4\0\0\0\4\0\0\0(\0\0\0\v\0\0\0\2\0\0\0\344\3\0\=
0\344\3\0\0000\n\0\0\4\0\0\0\3\0\0\0\4\0\0\0\20\0\0\0000\0\0\0\3\0\0\0\2\0\=
0\0\24\16\0\0\24\16\0\0\351\t\0\0\0\0\0\0\0\0\0\0\1\0\0\0\0\0\0\0008\0\0\0\=
377\377\377o\2\0\0\0\376\27\0\0\376\27\0\0F\1\0\0\3\0\0\0\0\0\0\0\2\0\0\0\2=
\0\0\0E\0\0\0\376\377\377o\2\0\0\0D\31\0\0D\31\0\0P\0\0\0\4\0\0\0\2\0\0\0\4=
\0\0\0\0\0\0\0T\0\0\0\t\0\0\0\2\0\0\0\224\31\0\0\224\31\0\0\260\1\0\0\3\0\0=
\0\0\0\0\0\4\0\0\0\10\0\0\0]\0\0\0\t\0\0\0B\0\0\0D\33\0\0D\33\0\0\340\2\0\0=
\3\0\0\0\23\0\0\0\4\0\0\0\10\0\0\0f\0\0\0\1\0\0\0\6\0\0\0$\36\0\0$\36\0\0\f=
\0\0\0\0\0\0\0\0\0\0\0\4\0\0\0\0\0\0\0a\0\0\0\1\0\0\0\6\0\0\0000\36\0\0000\=
36\0\0|\4\0\0\0\0\0\0\0\0\0\0\4\0\0\0\4\0\0\0l\0\0\0\1\0\0\0\6\0\0\0\254\"\=
0\0\254\"\0\0\234H\0\0\0\0\0\0\0\0\0\0\4\0\0\0\0\0\0\0r\0\0\0\1\0\0\0\6\0\0=
\0Hk\0\0Hk\0\0\10\0\0\0\0\0\0\0\0\0\0\0\4\0\0\0\0\0\0\0x\0\0\0\1\0\0\0\2\0\=
0\0Pk\0\0Pk\0\0@\35\1\0\0\0\0\0\0\0\0\0\4\0\0\0\0\0\0\0\200\0\0\0\1\0\0\0\2=
\0\0\0\220\210\1\0\220\210\1\0\4\0\0\0\0\0\0\0\0\0\0\0\4\0\0\0\0\0\0\0\212\=
0\0\0\16\0\0\0\3\0\0\0t\213\2\0t\213\1\0\4\0\0\0\0\0\0\0\0\0\0\0\4\0\0\0\4\=
0\0\0\226\0\0\0\17\0\0\0\3\0\0\0x\213\2\0x\213\1\0\4\0\0\0\0\0\0\0\0\0\0\0\=
4\0\0\0\4\0\0\0\242\0\0\0\1\0\0\0\3\0\0\0|\213\2\0|\213\1\0\320\1\0\0\0\0\0=
\0\0\0\0\0\4\0\0\0\0\0\0\0\257\0\0\0\6\0\0\0\3\0\0\0L\215\2\0L\215\1\0\10\1=
\0\0\4\0\0\0\0\0\0\0\4\0\0\0\10\0\0\0\270\0\0\0\1\0\0\0\3\0\0\0T\216\2\0T\2=
16\1\0\254\1\0\0\0\0\0\0\0\0\0\0\4\0\0\0\4\0\0\0\275\0\0\0\1\0\0\0\3\0\0\0\=
0\220\2\0\0\220\1\0\f\0\0\0\0\0\0\0\0\0\0\0\4\0\0\0\0\0\0\0\303\0\0\0\10\0\=
0\0\3\0\0\0\f\220\2\0\f\220\1\0l\240\0\0\0\0\0\0\0\0\0\0\4\0\0\0\0\0\0\0\31=
0\0\0\0\3\0\0p\0\0\0\0\0\0\0\0\f\220\1\0001\0\0\0\0\0\0\0\0\0\0\0\1\0\0\0\0=
\0\0\0\330\0\0\0\1\0\0\0\0\0\0\0\0\0\0\0@\220\1\0004\0\0\0\0\0\0\0\0\0\0\0\=
4\0\0\0\0\0\0\0\1\0\0\0\3\0\0\0\0\0\0\0\0\0\0\0t\220\1\0\347\0\0\0\0\0\0\0\=
0\0\0\0\1\0\0\0\0\0\0\0", 1000) =3D 1000
9559  lseek(3, 102412, SEEK_SET)        =3D 102412
9559  read(3, "A0\0\0\0aeabi\0\1&\0\0\0\0057-A\0\6\n\7A\10\1\t\2\n\4\22\4\2=
4\1\25\1\27\3\30\1\31\1\32\2\34\1\"\1", 49) =3D 49
9559  fstat(3, {st_mode=3DS_IFREG|0644, st_size=3D103748, ...}) =3D 0
9559  mmap(0xffff9381f000, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXE=
D|MAP_ANONYMOUS, -1, 0) =3D 0xffff9381f000
9559  mmap(0xffff937eb000, 212992, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_FIX=
ED|MAP_ANONYMOUS|MAP_DENYWRITE, -1, 0) =3D 0xffff937eb000
9559  mmap(0xffff937eb000, 212992, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_FIX=
ED|MAP_DENYWRITE, 3, 0) =3D 0xffff937eb000
9559  mprotect(0xffff93804000, 61440, PROT_NONE) =3D 0
9559  mmap(0xffff93813000, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXE=
D|MAP_DENYWRITE, 3, 0x18000) =3D 0xffff93813000
9559  mmap(0xffff93815000, 40960, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIX=
ED|MAP_ANONYMOUS, -1, 0) =3D 0xffff93815000
9559  close(3)                          =3D 0
9559  faccessat(AT_FDCWD, "/etc/ld.so.nohwcap", F_OK) =3D -1 ENOENT (No suc=
h file or directory)
9559  openat(AT_FDCWD, "/lib/arm-linux-gnueabihf/libc.so.6", O_RDONLY|O_CLO=
EXEC) =3D 3
9559  read(3, "\177ELF\1\1\1\3\0\0\0\0\0\0\0\0\3\0(\0\1\0\0\0\271j\1\0004\0=
\0\0<\34\16\0\0\4\0\0054\0 \0\n\0(\0I\0H\0\1\0\0ph\233\r\0h\233\r\0h\233\r\=
0\340\26\0\0\340\26\0\0\4\0\0\0\4\0\0\0\6\0\0\0004\0\0\0004\0\0\0004\0\0\0@=
\1\0\0@\1\0\0\5\0\0\0\4\0\0\0\3\0\0\0\230\221\r\0\230\221\r\0\230\221\r\0\3=
1\0\0\0\31\0\0\0\4\0\0\0\4\0\0\0\1\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\304\345\r\=
0\304\345\r\0\5\0\0\0\0\0\1\0\1\0\0\0\10\347\r\0\10\347\16\0\10\347\16\0T'\=
0\0\224N\0\0\6\0\0\0\0\0\1\0\2\0\0\0 \377\r\0 \377\16\0 \377\16\0\340\0\0\0=
\340\0\0\0\6\0\0\0\4\0\0\0\4\0\0\0t\1\0\0t\1\0\0t\1\0\0D\0\0\0D\0\0\0\4\0\0=
\0\4\0\0\0\7\0\0\0\10\347\r\0\10\347\16\0\10\347\16\0\10\0\0\0T\0\0\0\4\0\0=
\0\4\0\0\0Q\345td\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\6\0\0\0\20\0\0\0R=
\345td\10\347\r\0\10\347\16\0\10\347\16\0\370\30\0\0\370\30\0\0\4\0\0\0\1\0=
\0\0\4\0\0\0\24\0\0\0\3\0\0\0GNU\0;\217\241\322FN\32\311\261\333\226\22\316=
G\360\243\374-]\334\4\0\0\0\20\0\0\0\1\0\0\0GNU\0\0\0\0\0\3\0\0\0\2\0\0\0\0=
\0\0\0\363\3\0\0\r\0\0\0\0\2\0\0\16\0\0\0\2440\20D\204!\n\1\214\3\346\220AE=
\210\0\204\0\10\0E\204\0`\300\200\1\f\212\f@\0010\0\10@2\10\252\0\210H6l\24=
0\0268\0&\204\200\216\4\10@\4", 512) =3D 512
9559  lseek(3, 924732, SEEK_SET)        =3D 924732
9559  read(3, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0=
\0\0\0\0\0\0\0\0\0\0\v\0\0\0\7\0\0\0\2\0\0\0t\1\0\0t\1\0\0$\0\0\0\0\0\0\0\0=
\0\0\0\4\0\0\0\0\0\0\0\36\0\0\0\7\0\0\0\2\0\0\0\230\1\0\0\230\1\0\0 \0\0\0\=
0\0\0\0\0\0\0\0\4\0\0\0\0\0\0\0,\0\0\0\366\377\377o\2\0\0\0\270\1\0\0\270\1=
\0\0004;\0\0\4\0\0\0\0\0\0\0\4\0\0\0\4\0\0\0006\0\0\0\v\0\0\0\2\0\0\0\354<\=
0\0\354<\0\0000\216\0\0\5\0\0\0\3\0\0\0\4\0\0\0\20\0\0\0>\0\0\0\3\0\0\0\2\0=
\0\0\34\313\0\0\34\313\0\0\202]\0\0\0\0\0\0\0\0\0\0\1\0\0\0\0\0\0\0F\0\0\0\=
377\377\377o\2\0\0\0\236(\1\0\236(\1\0\306\21\0\0\4\0\0\0\0\0\0\0\2\0\0\0\2=
\0\0\0S\0\0\0\375\377\377o\2\0\0\0d:\1\0d:\1\0\10\3\0\0\5\0\0\0\26\0\0\0\4\=
0\0\0\0\0\0\0b\0\0\0\376\377\377o\2\0\0\0l=3D\1\0l=3D\1\0000\0\0\0\5\0\0\0\=
1\0\0\0\4\0\0\0\0\0\0\0q\0\0\0\t\0\0\0\2\0\0\0\234=3D\1\0\234=3D\1\0\210(\0=
\0\4\0\0\0\0\0\0\0\4\0\0\0\10\0\0\0z\0\0\0\t\0\0\0B\0\0\0$f\1\0$f\1\0H\0\0\=
0\4\0\0\0\36\0\0\0\4\0\0\0\10\0\0\0~\0\0\0\1\0\0\0\6\0\0\0lf\1\0lf\1\0\214\=
0\0\0\0\0\0\0\0\0\0\0\4\0\0\0\4\0\0\0\203\0\0\0\1\0\0\0\6\0\0\0\370f\1\0\37=
0f\1\0\34\0\0\0\0\0\0\0\0\0\0\0\4\0\0\0\0\0\0\0\211\0\0\0\1\0\0\0\6\0\0\0@g=
\1\0@g\1\0\270\235\n\0\0\0\0\0\0\0\0\0@\0\0\0\0\0\0\0\217\0\0\0\1\0\0\0\6\0=
\0\0\370\4\f\0\370\4\f\0\210\t\0\0\0\0\0\0\0\0\0\0\4\0\0\0\0\0\0\0\241\0\0\=
0\1\0\0\0\6\0\0\0\200\16\f\0\200\16\f\0 \2\0\0\0\0\0\0\0\0\0\0\4\0\0\0\0\0\=
0\0\272\0\0\0\1\0\0\0\2\0\0\0\240\20\f\0\240\20\f\0\365\200\1\0\0\0\0\0\0\0=
\0\0\10\0\0\0\0\0\0\0\302\0\0\0\1\0\0\0\2\0\0\0\230\221\r\0\230\221\r\0\31\=
0\0\0\0\0\0\0\0\0\0\0\4\0\0\0\0\0\0\0\312\0\0\0\1\0\0\0\2\0\0\0\264\221\r\0=
\264\221\r\0\264\t\0\0\0\0\0\0\0\0\0\0\4\0\0\0\0\0\0\0\325\0\0\0\1\0\0p\202=
\0\0\0h\233\r\0h\233\r\0\340\26\0\0\r\0\0\0\0\0\0\0\4\0\0\0\0\0\0\0\340\0\0=
\0\1\0\0\0\2\0\0\0H\262\r\0H\262\r\0\4\0\0\0\0\0\0\0\0\0\0\0\4\0\0\0\0\0\0\=
0000\0\0\0\5\0\0\0\2\0\0\0L\262\r\0L\262\r\0x3\0\0\4\0\0\0\0\0\0\0\4\0\0\0\=
4\0\0\0\352\0\0\0\1\0\0\0\3\4\0\0\10\347\16\0\10\347\r\0\10\0\0\0\0\0\0\0\0=
\0\0\0\4\0\0\0\0\0\0\0\361\0\0\0\10\0\0\0\3\4\0\0\20\347\16\0\20\347\r\0L\0=
\0\0\0\0\0\0\0\0\0\0\4\0\0\0\0\0\0\0\367\0\0\0\1\0\0\0\3\0\0\0\20\347\16\0\=
20\347\r\0\200\0\0\0\0\0\0\0\0\0\0\0\4\0\0\0\0\0\0\0\t\1\0\0\1\0\0\0\3\0\0\=
0\220\347\16\0\220\347\r\0\4\0\0\0\0\0\0\0\0\0\0\0\4\0\0\0\0\0\0\0\27\1\0\0=
\1\0\0\0\3\0\0\0\224\347\16\0\224\347\r\0\24\0\0\0\0\0\0\0\0\0\0\0\4\0\0\0\=
0\0\0\0000\1\0\0\1\0\0\0\3\0\0\0\250\347\16\0\250\347\r\0\350\5\0\0\0\0\0\0=
\0\0\0\0\4\0\0\0\0\0\0\0B\1\0\0\1\0\0\0\3\0\0\0\220\355\16\0\220\355\r\0\22=
0\21\0\0\0\0\0\0\0\0\0\0\4\0\0\0\0\0\0\0O\1\0\0\6\0\0\0\3\0\0\0 \377\16\0 \=
377\r\0\340\0\0\0\5\0\0\0\0\0\0\0\4\0\0\0\10\0\0\0X\1\0\0\1\0\0\0\3\0\0\0\0=
\0\17\0\0\0\16\0\320\1\0\0\0\0\0\0\0\0\0\0\4\0\0\0\4\0\0\0]\1\0\0\1\0\0\0\3=
\0\0\0\320\1\17\0\320\1\16\0\214\f\0\0\0\0\0\0\0\0\0\0\10\0\0\0\0\0\0\0c\1\=
0\0\10\0\0\0\3\0\0\0`\16\17\0\\\16\16\0<'\0\0\0\0\0\0\0\0\0\0\10\0\0\0\0\0\=
0\0h\1\0\0\3\0\0p\0\0\0\0\0\0\0\0\\\16\16\0005\0\0\0\0\0\0\0\0\0\0\0\1\0\0\=
0\0\0\0\0x\1\0\0\1\0\0\0\0\0\0\0\0\0\0\0\224\16\16\0M\0\0\0\0\0\0\0\0\0\0\0=
\4\0\0\0\0\0\0\0\216\1\0\0\1\0\0\0\0\0\0\0\0\0\0\0\344\16\16\0002\0\0\0\0\0=
\0\0\0\0\0\0\4\0\0\0\0\0\0\0\245\1\0\0\1\0\0\0\0\0\0\0\0\0\0\0\30\17\16\000=
9\0\0\0\0\0\0\0\0\0\0\0\4\0\0\0\0\0\0\0\275\1\0\0\1\0\0\0\0\0\0\0\0\0\0\0T\=
17\16\0007\0\0\0\0\0\0\0\0\0\0\0\4\0\0\0\0\0\0\0\321\1\0\0\1\0\0\0\0\0\0\0\=
0\0\0\0\214\17\16\0009\0\0\0\0\0\0\0\0\0\0\0\4\0\0\0\0\0\0\0\347\1\0\0\1\0\=
0\0\0\0\0\0\0\0\0\0\310\17\16\0008\0\0\0\0\0\0\0\0\0\0\0\4\0\0\0\0\0\0\0\37=
4\1\0\0\1\0\0\0\0\0\0\0\0\0\0\0\0\20\16\0D\0\0\0\0\0\0\0\0\0\0\0\4\0\0\0\0\=
0\0\0\25\2\0\0\1\0\0\0\0\0\0\0\0\0\0\0D\20\16\0A\0\0\0\0\0\0\0\0\0\0\0\4\0\=
0\0\0\0\0\0+\2\0\0\1\0\0\0\0\0\0\0\0\0\0\0\210\20\16\0009\0\0\0\0\0\0\0\0\0=
\0\0\4\0\0\0\0\0\0\0=3D\2\0\0\1\0\0\0\0\0\0\0\0\0\0\0\304\20\16\0:\0\0\0\0\=
0\0\0\0\0\0\0\4\0\0\0\0\0\0\0P\2\0\0\1\0\0\0\0\0\0\0\0\0\0\0\0\21\16\0/\0\0=
\0\0\0\0\0\0\0\0\0\4\0\0\0\0\0\0\0d\2\0\0\1\0\0\0\0\0\0\0\0\0\0\0000\21\16\=
0?\0\0\0\0\0\0\0\0\0\0\0\4\0\0\0\0\0\0\0x\2\0\0\1\0\0\0\0\0\0\0\0\0\0\0p\21=
\16\0v\0\0\0\0\0\0\0\0\0\0\0\4\0\0\0\0\0\0\0\213\2\0\0\1\0\0\0\0\0\0\0\0\0\=
0\0\350\21\16\0-\0\0\0\0\0\0\0\0\0\0\0\4\0\0\0\0\0\0\0\235\2\0\0\1\0\0\0\0\=
0\0\0\0\0\0\0\30\22\16\0/\0\0\0\0\0\0\0\0\0\0\0\4\0\0\0\0\0\0\0\261\2\0\0\1=
\0\0\0\0\0\0\0\0\0\0\0H\22\16\0D\0\0\0\0\0\0\0\0\0\0\0\4\0\0\0\0\0\0\0\305\=
2\0\0\1\0\0\0\0\0\0\0\0\0\0\0\214\22\16\0-\0\0\0\0\0\0\0\0\0\0\0\4\0\0\0\0\=
0\0\0\327\2\0\0\1\0\0\0"..., 2920) =3D 2920
9559  lseek(3, 921180, SEEK_SET)        =3D 921180
9559  read(3, "A4\0\0\0aeabi\0\1*\0\0\0\0057-A\0\6\n\7A\10\1\t\2\n\3\f\1\22=
\4\23\1\24\1\25\1\26\1\27\3\30\1\32\2\34\1\"\1", 53) =3D 53
9559  fstat(3, {st_mode=3DS_IFREG|0755, st_size=3D927652, ...}) =3D 0
9559  mmap(0xffff936f7000, 999424, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_FIX=
ED|MAP_ANONYMOUS|MAP_DENYWRITE, -1, 0) =3D 0xffff936f7000
9559  mmap(0xffff936f7000, 999424, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_FIX=
ED|MAP_DENYWRITE, 3, 0) =3D 0xffff936f7000
9559  mprotect(0xffff937d6000, 61440, PROT_NONE) =3D 0
9559  mmap(0xffff937e5000, 12288, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIX=
ED|MAP_DENYWRITE, 3, 0xde000) =3D 0xffff937e5000
9559  mmap(0xffff937e8000, 12288, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIX=
ED|MAP_ANONYMOUS, -1, 0) =3D 0xffff937e8000
9559  close(3)                          =3D 0
9559  faccessat(AT_FDCWD, "/etc/ld.so.nohwcap", F_OK) =3D -1 ENOENT (No suc=
h file or directory)
9559  openat(AT_FDCWD, "/lib/arm-linux-gnueabihf/libcap-ng.so.0", O_RDONLY|=
O_CLOEXEC) =3D 3
9559  read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0(\0\1\0\0\0\364\16\0\0004=
\0\0\00042\0\0\0\4\0\0054\0 \0\7\0(\0\31\0\30\0\1\0\0\0\0\0\0\0\0\0\0\0\0\0=
\0\0\264'\0\0\264'\0\0\5\0\0\0\0\0\1\0\1\0\0\0\330.\0\0\330.\1\0\330.\1\0\2=
0\2\0\0\24\2\0\0\6\0\0\0\0\0\1\0\2\0\0\0\20/\0\0\20/\1\0\20/\1\0\360\0\0\0\=
360\0\0\0\6\0\0\0\4\0\0\0\4\0\0\0\24\1\0\0\24\1\0\0\24\1\0\0$\0\0\0$\0\0\0\=
4\0\0\0\4\0\0\0\7\0\0\0\330.\0\0\330.\1\0\330.\1\0000\0\0\0000\0\0\0\4\0\0\=
0\4\0\0\0Q\345td\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\6\0\0\0\20\0\0\0R\=
345td\330.\0\0\330.\1\0\330.\1\0(\1\0\0(\1\0\0\4\0\0\0\1\0\0\0\4\0\0\0\24\0=
\0\0\3\0\0\0GNU\0s\1:\"\346z\317mT\374\360-\271\335\33\277\363(\26z\21\0\0\=
0+\0\0\0\10\0\0\0\10\0\0\0E\220\20\4\0\4L\320(\220\2\201\0\0R\2\20\0\t\2\10=
!@\235\4@\36\221\0\4\10\0+\0\0\0/\0\0\0005\0\0\0008\0\0\0:\0\0\0\0\0\0\0<\0=
\0\0>\0\0\0@\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0A\0\0\0B\0\0\0C\0\0\0\0\0\0\0D\0\=
0\0002\36\312mt\271\204^\0\2574\350\25:rP\320\316\246\375\352\323\357\16\33=
6\23AU\272\350\221\2072\352b^\323\"~\257vT<\224Pl\347\\\271\215\361\16\334T=
\237\251\331qX\34\272\343\222|Y\357\227y\220\231`Y7?\370SBE\325\354=3D\22\2=
05D", 512) =3D 512
9559  lseek(3, 12852, SEEK_SET)         =3D 12852
9559  read(3, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0=
\0\0\0\0\0\0\0\0\0\0\v\0\0\0\7\0\0\0\2\0\0\0\24\1\0\0\24\1\0\0$\0\0\0\0\0\0=
\0\0\0\0\0\4\0\0\0\0\0\0\0\36\0\0\0\366\377\377o\2\0\0\0008\1\0\0008\1\0\0\=
344\0\0\0\3\0\0\0\0\0\0\0\4\0\0\0\4\0\0\0(\0\0\0\v\0\0\0\2\0\0\0\34\2\0\0\3=
4\2\0\0p\4\0\0\4\0\0\0\3\0\0\0\4\0\0\0\20\0\0\0000\0\0\0\3\0\0\0\2\0\0\0\21=
4\6\0\0\214\6\0\0\212\3\0\0\0\0\0\0\0\0\0\0\1\0\0\0\0\0\0\0008\0\0\0\377\37=
7\377o\2\0\0\0\26\n\0\0\26\n\0\0\216\0\0\0\3\0\0\0\0\0\0\0\2\0\0\0\2\0\0\0E=
\0\0\0\376\377\377o\2\0\0\0\244\n\0\0\244\n\0\0P\0\0\0\4\0\0\0\2\0\0\0\4\0\=
0\0\0\0\0\0T\0\0\0\t\0\0\0\2\0\0\0\364\n\0\0\364\n\0\0H\0\0\0\3\0\0\0\0\0\0=
\0\4\0\0\0\10\0\0\0]\0\0\0\t\0\0\0B\0\0\0<\v\0\0<\v\0\0p\1\0\0\3\0\0\0\23\0=
\0\0\4\0\0\0\10\0\0\0f\0\0\0\1\0\0\0\6\0\0\0\254\f\0\0\254\f\0\0\f\0\0\0\0\=
0\0\0\0\0\0\0\4\0\0\0\0\0\0\0a\0\0\0\1\0\0\0\6\0\0\0\270\f\0\0\270\f\0\0<\2=
\0\0\0\0\0\0\0\0\0\0\4\0\0\0\4\0\0\0l\0\0\0\1\0\0\0\6\0\0\0\364\16\0\0\364\=
16\0\0,\24\0\0\0\0\0\0\0\0\0\0\4\0\0\0\0\0\0\0r\0\0\0\1\0\0\0\6\0\0\0 #\0\0=
 #\0\0\10\0\0\0\0\0\0\0\0\0\0\0\4\0\0\0\0\0\0\0x\0\0\0\1\0\0\0\2\0\0\0(#\0\=
0(#\0\0\210\4\0\0\0\0\0\0\0\0\0\0\4\0\0\0\0\0\0\0\200\0\0\0\1\0\0\0\2\0\0\0=
\260'\0\0\260'\0\0\4\0\0\0\0\0\0\0\0\0\0\0\4\0\0\0\0\0\0\0\212\0\0\0\1\0\0\=
0\3\4\0\0\330.\1\0\330.\0\0000\0\0\0\0\0\0\0\0\0\0\0\4\0\0\0\0\0\0\0\221\0\=
0\0\16\0\0\0\3\0\0\0\10/\1\0\10/\0\0\4\0\0\0\0\0\0\0\0\0\0\0\4\0\0\0\4\0\0\=
0\235\0\0\0\17\0\0\0\3\0\0\0\f/\1\0\f/\0\0\4\0\0\0\0\0\0\0\0\0\0\0\4\0\0\0\=
4\0\0\0\251\0\0\0\6\0\0\0\3\0\0\0\20/\1\0\20/\0\0\360\0\0\0\4\0\0\0\0\0\0\0=
\4\0\0\0\10\0\0\0\262\0\0\0\1\0\0\0\3\0\0\0\0000\1\0\0000\0\0\340\0\0\0\0\0=
\0\0\0\0\0\0\4\0\0\0\4\0\0\0\267\0\0\0\1\0\0\0\3\0\0\0\3400\1\0\3400\0\0\10=
\0\0\0\0\0\0\0\0\0\0\0\4\0\0\0\0\0\0\0\275\0\0\0\10\0\0\0\3\0\0\0\3500\1\0\=
3500\0\0\4\0\0\0\0\0\0\0\0\0\0\0\1\0\0\0\0\0\0\0\302\0\0\0\3\0\0p\0\0\0\0\0=
\0\0\0\3500\0\0001\0\0\0\0\0\0\0\0\0\0\0\1\0\0\0\0\0\0\0\322\0\0\0\1\0\0\0\=
0\0\0\0\0\0\0\0\0341\0\0004\0\0\0\0\0\0\0\0\0\0\0\4\0\0\0\0\0\0\0\1\0\0\0\3=
\0\0\0\0\0\0\0\0\0\0\0P1\0\0\341\0\0\0\0\0\0\0\0\0\0\0\1\0\0\0\0\0\0\0", 10=
00) =3D 1000
9559  lseek(3, 12520, SEEK_SET)         =3D 12520
9559  read(3, "A0\0\0\0aeabi\0\1&\0\0\0\0057-A\0\6\n\7A\10\1\t\2\n\4\22\4\2=
4\1\25\1\27\3\30\1\31\1\32\2\34\1\"\1", 49) =3D 49
9559  fstat(3, {st_mode=3DS_IFREG|0644, st_size=3D13852, ...}) =3D 0
9559  mmap(0xffff936e3000, 81920, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_FIXE=
D|MAP_ANONYMOUS|MAP_DENYWRITE, -1, 0) =3D 0xffff936e3000
9559  mmap(0xffff936e3000, 81920, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_FIXE=
D|MAP_DENYWRITE, 3, 0) =3D 0xffff936e3000
9559  mprotect(0xffff936e6000, 61440, PROT_NONE) =3D 0
9559  mmap(0xffff936f5000, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXE=
D|MAP_DENYWRITE, 3, 0x2000) =3D 0xffff936f5000
9559  close(3)                          =3D 0
9559  mprotect(0xffff937e5000, 8192, PROT_READ) =3D 0
9559  mprotect(0xffff936f5000, 4096, PROT_READ) =3D 0
9559  mprotect(0xffff93813000, 4096, PROT_READ) =3D 0
9559  mprotect(0xffff94060000, 4096, PROT_READ) =3D 0
9559  mprotect(0xffff9384d000, 4096, PROT_READ) =3D 0
9559  mmap(0xffff93821000, 16384, PROT_NONE, MAP_PRIVATE|MAP_FIXED|MAP_ANON=
YMOUS|MAP_NORESERVE, -1, 0) =3D 0xffff93821000
9559  socket(AF_NETLINK, SOCK_RAW, NETLINK_AUDIT) =3D 3
9559  fcntl(3, F_SETFD, FD_CLOEXEC)     =3D 0
9559  socket(AF_NETLINK, SOCK_RAW, NETLINK_ROUTE) =3D 4
9559  bind(4, {sa_family=3DAF_NETLINK, nl_pid=3D0, nl_groups=3D00000000}, 1=
2) =3D 0
9559  getsockname(4, {sa_family=3DAF_NETLINK, nl_pid=3D9559, nl_groups=3D00=
000000}, [12]) =3D 0
9559  gettimeofday({tv_sec=3D1516724585, tv_usec=3D725982}, NULL) =3D 0
9559  sendto(4, {{len=3D20, type=3D0x16 /* NLMSG_??? */, flags=3DNLM_F_REQU=
EST|0x300, seq=3D1516724585, pid=3D0}, "\0\0\0\0"}, 20, 0, 0xffffcdb29840, =
0) =3D 20
9559  recvmsg(4, {msg_name=3D{sa_family=3DAF_NETLINK, nl_pid=3D0, nl_groups=
=3D00000000}, msg_namelen=3D12, msg_iov=3D[{iov_base=3D[{{len=3D76, type=3D=
0x14 /* NLMSG_??? */, flags=3DNLM_F_MULTI, seq=3D1516724585, pid=3D9559}, "=
\2\10\200\376\1\0\0\0\10\0\1\0\177\0\0\1\10\0\2\0\177\0\0\1\7\0\3\0lo\0\0\1=
0\0\10\0\200\0\0\0\24\0\6\0\377\377\377\377\377\377\377\377'\5\0\0'\5\0\0"}=
, {{len=3D88, type=3D0x14 /* NLMSG_??? */, flags=3DNLM_F_MULTI, seq=3D15167=
24585, pid=3D9559}, "\2\30\200\0\2\0\0\0\10\0\1\0\n\0\2\17\10\0\2\0\n\0\2\1=
7\10\0\4\0\n\0\2\377\v\0\3\0enp0s2\0\0\10\0\10\0\200\0\0\0\24\0\6\0\377\377=
\377\377\377\377\377\377\304\r\0\0\304\r\0\0"}, {{len=3D0, type=3D0 /* NLMS=
G_??? */, flags=3D0, seq=3D0, pid=3D0}}], iov_len=3D4096}], msg_iovlen=3D1,=
 msg_controllen=3D0, msg_flags=3D0}, 0) =3D 164
9559  mmap(0xffff936c2000, 135168, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FI=
XED|MAP_ANONYMOUS, -1, 0) =3D 0xffff936c2000
9559  mmap(0xffff936c2000, 135168, PROT_NONE, MAP_PRIVATE|MAP_FIXED|MAP_ANO=
NYMOUS|MAP_NORESERVE, -1, 0) =3D 0xffff936c2000
9559  mmap(0xffff935e3000, 1048576, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_F=
IXED|MAP_ANONYMOUS, -1, 0) =3D 0xffff935e3000
9559  recvmsg(4, {msg_name=3D{sa_family=3DAF_NETLINK, nl_pid=3D0, nl_groups=
=3D00000000}, msg_namelen=3D12, msg_iov=3D[{iov_base=3D[{{len=3D72, type=3D=
0x14 /* NLMSG_??? */, flags=3DNLM_F_MULTI, seq=3D1516724585, pid=3D9559}, "=
\n\200\200\376\1\0\0\0\24\0\1\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\1\24\0\6\0\37=
7\377\377\377\377\377\377\377)\5\0\0)\5\0\0\10\0\10\0\200\0\0\0"}, {{len=3D=
72, type=3D0x14 /* NLMSG_??? */, flags=3DNLM_F_MULTI, seq=3D1516724585, pid=
=3D9559}, "\n@\0\310\2\0\0\0\24\0\1\0\376\300\0\0\0\0\0\0PT\0\377\376\0224V=
\24\0\6\0\0237\0\0SP\1\0\307\r\0\0\352'\216\0\10\0\10\0\0\1\0\0"}, {{len=3D=
72, type=3D0x14 /* NLMSG_??? */, flags=3DNLM_F_MULTI, seq=3D1516724585, pid=
=3D9559}, "\n@\200\375\2\0\0\0\24\0\1\0\376\200\0\0\0\0\0\0PT\0\377\376\022=
4V\24\0\6\0\377\377\377\377\377\377\377\3778\r\0\0008\r\0\0\10\0\10\0\200\0=
\0\0"}, {{len=3D0, type=3D0 /* NLMSG_??? */, flags=3D0, seq=3D0, pid=3D0}}]=
, iov_len=3D4096}], msg_iovlen=3D1, msg_controllen=3D0, msg_flags=3D0}, 0) =
=3D 216
9559  recvmsg(4, {msg_name=3D{sa_family=3DAF_NETLINK, nl_pid=3D0, nl_groups=
=3D00000000}, msg_namelen=3D12, msg_iov=3D[{iov_base=3D[{{len=3D20, type=3D=
NLMSG_DONE, flags=3DNLM_F_MULTI, seq=3D1516724585, pid=3D9559}, "\0\0\0\0"}=
, {{len=3D1, type=3D0x14 /* NLMSG_??? */, flags=3DNLM_F_REQUEST, seq=3D0, p=
id=3D0}}], iov_len=3D4096}], msg_iovlen=3D1, msg_controllen=3D0, msg_flags=
=3D0}, 0) =3D 20
9559  socket(AF_UNIX, SOCK_STREAM|SOCK_CLOEXEC|SOCK_NONBLOCK, 0) =3D 5
9559  connect(5, {sa_family=3DAF_UNIX, sun_path=3D"/var/run/nscd/socket"}, =
110) =3D -1 ENOENT (No such file or directory)
9559  close(5)                          =3D 0
9559  close(4)                          =3D 0
9559  socket(AF_UNIX, SOCK_STREAM|SOCK_CLOEXEC|SOCK_NONBLOCK, 0) =3D 4
9559  connect(4, {sa_family=3DAF_UNIX, sun_path=3D"/var/run/nscd/socket"}, =
110) =3D -1 ENOENT (No such file or directory)
9559  close(4)                          =3D 0
9559  openat(AT_FDCWD, "/etc/nsswitch.conf", O_RDONLY|O_CLOEXEC) =3D 4
9559  fstat(4, {st_mode=3DS_IFREG|0644, st_size=3D497, ...}) =3D 0
9559  read(4, "# /etc/nsswitch.conf\n#\n# Example configuration of GNU Name=
 Service Switch functionality.\n# If you have the `glibc-doc-reference' and=
 `info' packages installed, try:\n# `info libc \"Name Service Switch\"' for=
 information about this file.\n\npasswd:         compat\ngroup:          co=
mpat\nshadow:         compat\ngshadow:        files\n\nhosts:          file=
s dns\nnetworks:       files\n\nprotocols:      db files\nservices:       d=
b files\nethers:         db files\nrpc:            db files\n\nnetgroup:   =
    nis\n", 4096) =3D 497
9559  read(4, "", 4096)                 =3D 0
9559  close(4)                          =3D 0
9559  newfstatat(AT_FDCWD, "/etc/resolv.conf", {st_mode=3DS_IFREG|0644, st_=
size=3D20, ...}, 0) =3D 0
9559  openat(AT_FDCWD, "/etc/host.conf", O_RDONLY|O_CLOEXEC) =3D 4
9559  fstat(4, {st_mode=3DS_IFREG|0644, st_size=3D9, ...}) =3D 0
9559  read(4, "multi on\n", 4096)       =3D 9
9559  read(4, "", 4096)                 =3D 0
9559  close(4)                          =3D 0
9559  openat(AT_FDCWD, "/etc/resolv.conf", O_RDONLY|O_CLOEXEC) =3D 4
9559  fstat(4, {st_mode=3DS_IFREG|0644, st_size=3D20, ...}) =3D 0
9559  read(4, "nameserver 10.0.0.3\n", 4096) =3D 20
9559  read(4, "", 4096)                 =3D 0
9559  close(4)                          =3D 0
9559  uname({sysname=3D"Linux", nodename=3D"aarch64", ...}) =3D 0
9559  openat(AT_FDCWD, "/etc/ld.so.cache", O_RDONLY|O_CLOEXEC) =3D 4
9559  fstat(4, {st_mode=3DS_IFREG|0644, st_size=3D13472, ...}) =3D 0
9559  mmap(0xffff935df000, 16384, PROT_READ, MAP_PRIVATE|MAP_FIXED|MAP_ANON=
YMOUS, -1, 0) =3D 0xffff935df000
9559  mmap(0xffff935df000, 16384, PROT_READ, MAP_PRIVATE|MAP_FIXED, 4, 0) =
=3D 0xffff935df000
9559  close(4)                          =3D 0
9559  faccessat(AT_FDCWD, "/etc/ld.so.nohwcap", F_OK) =3D -1 ENOENT (No suc=
h file or directory)
9559  openat(AT_FDCWD, "/lib/arm-linux-gnueabihf/libnss_files.so.2", O_RDON=
LY|O_CLOEXEC) =3D 4
9559  read(4, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0(\0\1\0\0\0\0\33\0\0004\0=
\0\0Pr\0\0\0\4\0\0054\0 \0\6\0(\0\33\0\32\0\1\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0=
xg\0\0xg\0\0\5\0\0\0\0\0\1\0\1\0\0\0\350n\0\0\350n\1\0\350n\1\0\10\2\0\0(d\=
0\0\6\0\0\0\0\0\1\0\2\0\0\0\360n\0\0\360n\1\0\360n\1\0\20\1\0\0\20\1\0\0\6\=
0\0\0\4\0\0\0\4\0\0\0\364\0\0\0\364\0\0\0\364\0\0\0D\0\0\0D\0\0\0\4\0\0\0\4=
\0\0\0Q\345td\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\6\0\0\0\20\0\0\0R\345=
td\350n\0\0\350n\1\0\350n\1\0\30\1\0\0\30\1\0\0\4\0\0\0\1\0\0\0\4\0\0\0\24\=
0\0\0\3\0\0\0GNU\0\327*E\5\313b]\326\372\350\252\234\330\235^\27\331\232J\3=
57\4\0\0\0\20\0\0\0\1\0\0\0GNU\0\0\0\0\0\3\0\0\0\2\0\0\0\0\0\0\0k\0\0\0006\=
0\0\0\20\0\0\0\t\0\0\0\"F\340\24\260\241\245\1\31\10\3000\203\6\212\10\0\20=
0\322@]\1(\nx\10 \"\220\200\30,\7\3\205\24)!\22<\0\24\0\31\0\0\2\2\210@\0\2=
00@0\210\201@@\200\0\302\0\6\3006\0\0\0007\0\0\0\0\0\0\0008\0\0\0009\0\0\0:=
\0\0\0;\0\0\0<\0\0\0\0\0\0\0=3D\0\0\0\0\0\0\0>\0\0\0@\0\0\0A\0\0\0\0\0\0\0C=
\0\0\0\0\0\0\0E\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0F\0\0\=
0H\0\0\0\0\0\0\0I\0\0\0K\0\0\0\0\0\0\0", 512) =3D 512
9559  lseek(4, 29264, SEEK_SET)         =3D 29264
9559  read(4, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0=
\0\0\0\0\0\0\0\0\0\0\v\0\0\0\7\0\0\0\2\0\0\0\364\0\0\0\364\0\0\0$\0\0\0\0\0=
\0\0\0\0\0\0\4\0\0\0\0\0\0\0\36\0\0\0\7\0\0\0\2\0\0\0\30\1\0\0\30\1\0\0 \0\=
0\0\0\0\0\0\0\0\0\0\4\0\0\0\0\0\0\0,\0\0\0\366\377\377o\2\0\0\0008\1\0\0008=
\1\0\0\20\3\0\0\4\0\0\0\0\0\0\0\4\0\0\0\4\0\0\0006\0\0\0\v\0\0\0\2\0\0\0H\4=
\0\0H\4\0\0\260\7\0\0\5\0\0\0\3\0\0\0\4\0\0\0\20\0\0\0>\0\0\0\3\0\0\0\2\0\0=
\0\370\v\0\0\370\v\0\0h\t\0\0\0\0\0\0\0\0\0\0\1\0\0\0\0\0\0\0F\0\0\0\377\37=
7\377o\2\0\0\0`\25\0\0`\25\0\0\366\0\0\0\4\0\0\0\0\0\0\0\2\0\0\0\2\0\0\0S\0=
\0\0\375\377\377o\2\0\0\0X\26\0\0X\26\0\0008\0\0\0\5\0\0\0\2\0\0\0\4\0\0\0\=
0\0\0\0b\0\0\0\376\377\377o\2\0\0\0\220\26\0\0\220\26\0\0P\0\0\0\5\0\0\0\2\=
0\0\0\4\0\0\0\0\0\0\0q\0\0\0\t\0\0\0\2\0\0\0\340\26\0\0\340\26\0\0h\0\0\0\4=
\0\0\0\0\0\0\0\4\0\0\0\10\0\0\0z\0\0\0\t\0\0\0B\0\0\0H\27\0\0H\27\0\0p\1\0\=
0\4\0\0\0\25\0\0\0\4\0\0\0\10\0\0\0\203\0\0\0\1\0\0\0\6\0\0\0\270\30\0\0\27=
0\30\0\0\f\0\0\0\0\0\0\0\0\0\0\0\4\0\0\0\0\0\0\0~\0\0\0\1\0\0\0\6\0\0\0\304=
\30\0\0\304\30\0\0<\2\0\0\0\0\0\0\0\0\0\0\4\0\0\0\4\0\0\0\211\0\0\0\1\0\0\0=
\6\0\0\0\0\33\0\0\0\33\0\0\270D\0\0\0\0\0\0\0\0\0\0\4\0\0\0\0\0\0\0\217\0\0=
\0\1\0\0\0\6\0\0\0\270_\0\0\270_\0\0\10\0\0\0\0\0\0\0\0\0\0\0\4\0\0\0\0\0\0=
\0\225\0\0\0\1\0\0\0002\0\0\0\300_\0\0\300_\0\0\4\2\0\0\0\0\0\0\0\0\0\0\4\0=
\0\0\1\0\0\0\235\0\0\0\1\0\0\0\2\0\0\0\304a\0\0\304a\0\0\4\0\0\0\0\0\0\0\0\=
0\0\0\4\0\0\0\0\0\0\0000\0\0\0\5\0\0\0\2\0\0\0\310a\0\0\310a\0\0\260\5\0\0\=
4\0\0\0\0\0\0\0\4\0\0\0\4\0\0\0\247\0\0\0\16\0\0\0\3\0\0\0\350n\1\0\350n\0\=
0\4\0\0\0\0\0\0\0\0\0\0\0\4\0\0\0\4\0\0\0\263\0\0\0\17\0\0\0\3\0\0\0\354n\1=
\0\354n\0\0\4\0\0\0\0\0\0\0\0\0\0\0\4\0\0\0\4\0\0\0\277\0\0\0\6\0\0\0\3\0\0=
\0\360n\1\0\360n\0\0\20\1\0\0\5\0\0\0\0\0\0\0\4\0\0\0\10\0\0\0\310\0\0\0\1\=
0\0\0\3\0\0\0\0p\1\0\0p\0\0\354\0\0\0\0\0\0\0\0\0\0\0\4\0\0\0\4\0\0\0\315\0=
\0\0\1\0\0\0\3\0\0\0\354p\1\0\354p\0\0\4\0\0\0\0\0\0\0\0\0\0\0\4\0\0\0\0\0\=
0\0\323\0\0\0\10\0\0\0\3\0\0\0\360p\1\0\360p\0\0 b\0\0\0\0\0\0\0\0\0\0\4\0\=
0\0\0\0\0\0\330\0\0\0\3\0\0p\0\0\0\0\0\0\0\0\360p\0\0003\0\0\0\0\0\0\0\0\0\=
0\0\1\0\0\0\0\0\0\0\350\0\0\0\1\0\0\0\0\0\0\0\0\0\0\0$q\0\0004\0\0\0\0\0\0\=
0\0\0\0\0\4\0\0\0\0\0\0\0\1\0\0\0\3\0\0\0\0\0\0\0\0\0\0\0Xq\0\0\367\0\0\0\0=
\0\0\0\0\0\0\0\1\0\0\0\0\0\0\0", 1080) =3D 1080
9559  lseek(4, 28912, SEEK_SET)         =3D 28912
9559  read(4, "A2\0\0\0aeabi\0\1(\0\0\0\0057-A\0\6\n\7A\10\1\t\2\n\4\22\4\2=
3\1\24\1\25\1\27\3\30\1\31\1\32\2\34\1\"\1", 51) =3D 51
9559  fstat(4, {st_mode=3DS_IFREG|0644, st_size=3D30344, ...}) =3D 0
9559  mmap(0xffff935c1000, 122880, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_FIX=
ED|MAP_ANONYMOUS|MAP_DENYWRITE, -1, 0) =3D 0xffff935c1000
9559  mmap(0xffff935c1000, 122880, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_FIX=
ED|MAP_DENYWRITE, 4, 0) =3D 0xffff935c1000
9559  mprotect(0xffff935c8000, 61440, PROT_NONE) =3D 0
9559  mmap(0xffff935d7000, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXE=
D|MAP_DENYWRITE, 4, 0x6000) =3D 0xffff935d7000
9559  mmap(0xffff935d9000, 24576, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIX=
ED|MAP_ANONYMOUS, -1, 0) =3D 0xffff935d9000
9559  close(4)                          =3D 0
9559  mprotect(0xffff935d7000, 4096, PROT_READ) =3D 0
9559  mmap(0xffff935df000, 16384, PROT_NONE, MAP_PRIVATE|MAP_FIXED|MAP_ANON=
YMOUS|MAP_NORESERVE, -1, 0) =3D 0xffff935df000
9559  openat(AT_FDCWD, "/etc/hosts", O_RDONLY|O_CLOEXEC) =3D 4
9559  fstat(4, {st_mode=3DS_IFREG|0644, st_size=3D109, ...}) =3D 0
9559  read(4, "127.0.0.1\tlocalhost\n::1\t\tlocalhost ip6-localhost ip6-loo=
pback\nff02::1\t\tip6-allnodes\nff02::2\t\tip6-allrouters\n\n", 4096) =3D 1=
09
9559  read(4, "", 4096)                 =3D 0
9559  close(4)                          =3D 0
9559  openat(AT_FDCWD, "/etc/gai.conf", O_RDONLY|O_CLOEXEC) =3D 4
9559  fstat(4, {st_mode=3DS_IFREG|0644, st_size=3D2584, ...}) =3D 0
9559  fstat(4, {st_mode=3DS_IFREG|0644, st_size=3D2584, ...}) =3D 0
9559  read(4, "# Configuration for getaddrinfo(3).\n#\n# So far only config=
uration for the destination address sorting is needed.\n# RFC 3484 governs =
the sorting.  But the RFC also says that system\n# administrators should be=
 able to overwrite the defaults.  This can be\n# achieved here.\n#\n# All l=
ines have an initial identifier specifying the option followed by\n# up to =
two values.  Information specified in this file replaces the\n# default inf=
ormation.  Complete absence of data of one kind causes the\n# appropriate d=
efault information to be used.  The supported commands include:\n#\n# reloa=
d  <yes|no>\n#    If set to yes, each getaddrinfo(3) call will check whethe=
r this file\n#    changed and if necessary reload.  This option should not =
really be\n#    used.  There are possible runtime problems.  The default is=
 no.\n#\n# label   <mask>   <value>\n#    Add another rule to the RFC 3484 =
label table.  See section 2.1 in\n#    RFC 3484.  The default is:\n#\n#labe=
l ::1/128       0\n#label ::/0          1\n#label 2002::/16     2\n#label :=
:/96         3\n#label ::ffff:0:0/96 4\n#label fec0::/10     5\n#label fc00=
::/7      6\n#label 2001:0::/32   7\n#\n#    This default differs from the =
tables given in RFC 3484 by handling\n#    (now obsolete) site-local IPv6 a=
ddresses and Unique Local Addresses.\n#    The reason for this difference i=
s that these addresses are never\n#    NATed while IPv4 site-local addresse=
s most probably are.  Given\n#    the precedence of IPv6 over IPv4 (see bel=
ow) on machines having only\n#    site-local IPv4 and IPv6 addresses a look=
up for a global address would\n#    see the IPv6 be preferred.  The result =
is a long delay because the\n#    site-local IPv6 addresses cannot be used =
while the IPv4 address is\n#    (at least for the foreseeable future) NATed=
=2E  We also treat Teredo\n#    tunnels special.\n#\n# precedence  <mask>  =
 <value>\n#    Add another rule to the RFC 3484 precedence table.  See sect=
ion 2.1\n#    and 10.3 in RFC 3484.  The default is:\n#\n#precedence  ::1/1=
28       50\n#precedence  ::/0          40\n#precedence  2002::/16     30\n=
#precedence :"..., 4096) =3D 2584
9559  read(4, "", 4096)                 =3D 0
9559  close(4)                          =3D 0
9559  socket(AF_INET, SOCK_DGRAM|SOCK_CLOEXEC, IPPROTO_IP) =3D 4
9559  connect(4, {sa_family=3DAF_INET, sin_port=3Dhtons(0), sin_addr=3Dinet=
_addr("127.0.0.1")}, 16) =3D 0
9559  getsockname(4, {sa_family=3DAF_INET, sin_port=3Dhtons(35778), sin_add=
r=3Dinet_addr("127.0.0.1")}, [28->16]) =3D 0
9559  close(4)                          =3D 0
9559  socket(AF_INET6, SOCK_DGRAM|SOCK_CLOEXEC, IPPROTO_IP) =3D 4
9559  connect(4, {sa_family=3DAF_INET6, sin6_port=3Dhtons(0), inet_pton(AF_=
INET6, "::1", &sin6_addr), sin6_flowinfo=3Dhtonl(0), sin6_scope_id=3D0}, 28=
) =3D 0
9559  getsockname(4, {sa_family=3DAF_INET6, sin6_port=3Dhtons(56274), inet_=
pton(AF_INET6, "::1", &sin6_addr), sin6_flowinfo=3Dhtonl(0), sin6_scope_id=
=3D0}, [28]) =3D 0
9559  close(4)                          =3D 0
9559  getcwd("/", 4096)                 =3D 2
9559  newfstatat(AT_FDCWD, "/tmp", {st_mode=3DS_IFDIR|S_ISVTX|0777, st_size=
=3D4096, ...}, AT_SYMLINK_NOFOLLOW) =3D 0
9559  newfstatat(AT_FDCWD, "/tmp/a.out", {st_mode=3DS_IFREG|0755, st_size=
=3D8460, ...}, AT_SYMLINK_NOFOLLOW) =3D 0
9559  sendto(3, {{len=3D120, type=3D0x454 /* NLMSG_??? */, flags=3DNLM_F_RE=
QUEST|NLM_F_ACK, seq=3D1, pid=3D0}, "op=3Dtest:message acct=3D\"?\" exe=3D\=
"/tmp/a.out\" hostname=3Dlocalhost addr=3D::1 terminal=3D/dev/pts/2 res=3Ds=
uccess\0\0\0"}, 120, 0, 0xffffcdb29840, 0) =3D 120
9559  ppoll([{fd=3D3, events=3DPOLLIN}], 1, {tv_sec=3D0, tv_nsec=3D50000000=
0}, NULL, 0) =3D 1 ([{fd=3D3, revents=3DPOLLIN}], left {tv_sec=3D0, tv_nsec=
=3D499951056})
9559  recvfrom(3, 0xffff9404ae84, 8988, MSG_PEEK|MSG_DONTWAIT, 0xffffcdb298=
50, 0x42) =3D -1 EFAULT (Bad address)
9559  write(2, "audit_log_acct_message: Bad address\n", 36) =3D 36
9559  exit_group(1)                     =3D ?
9560  <... futex resumed>)              =3D ?
9560  +++ exited with 1 +++
9559  +++ exited with 1 +++

--J2SCkAp4GZ/dPZZf--
