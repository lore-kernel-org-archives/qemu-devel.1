Received: from eggs.gnu.org ([2001:4830:134:3::10]:43497)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <riemensberger@cadami.net>) id 1eXWe7-0003az-53
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 13:23:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <riemensberger@cadami.net>) id 1eXWe2-0004pi-1a
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 13:23:11 -0500
Received: from dd7730.kasserver.com ([85.13.132.46]:48411)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <riemensberger@cadami.net>)
	id 1eXWe1-0004oM-Ju
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 13:23:05 -0500
Received: from [192.168.153.160] (ipbcc37f62.dynamic.kabel-deutschland.de
	[188.195.127.98])
	by dd7730.kasserver.com (Postfix) with ESMTPSA id 699455980A8F
	for <qemu-devel@nongnu.org>; Fri,  5 Jan 2018 19:13:09 +0100 (CET)
From: Maximilian Riemensberger <riemensberger@cadami.net>
Message-ID: <a979d8c1-2b2a-9ccd-5e51-bfef8292e571@cadami.net>
Date: Fri, 5 Jan 2018 19:13:08 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] linux-user/mmap: Should not return NULL on guest call
 mmap(NULL, ...), causes crash inside glibc
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Hi,

yesterday I hit the following problem when running an arm linux executabl=
e on
qemu-2.10 (qemu-arm-static through binfmt_misc)=09

1879 mmap2(NULL,8388608,PROT_READ|PROT_WRITE,MAP_PRIVATE|MAP_ANONYMOUS|0x=
20000,-1,0) =3D 0x00000000
1879 write(2,0xf6fd39d0,79) stx_test: allocatestack.c:514: allocate_stack=
: Assertion `mem !=3D NULL' failed.

The issue comes up when the executable creates and joins lots of
threads in a loop (it's a unit test).  Eventually, glibc allocatestack
hits the mmap(NULL, ...) =3D=3D NULL.  Judging from the posix and linux
manuals mmap(NULL, ...) never returns NULL.  Either it fails with MAP_FAI=
LED
or it succeeds and returns non-NULL address.

AFAIK target_mmap() and mmap_find_vma() don't check the start address
after h2g().

More detailed straces below.

Cheers
Max



Guest strace: qemu-arm-static --strace [truncated and filtered]:

...

1879 clone(CLONE_VM|CLONE_FS|CLONE_FILES|CLONE_SIGHAND|CLONE_THREAD|CLONE=
_SYSVSEM|CLONE_SETTLS|CLONE_PARENT_SETTID|CLONE_CHILD_CLEARTID,child_stac=
k=3D0x00ffef88,parent_tidptr=3D0x00fff4b8,tls=3D0x00fff910,child_tidptr=3D=
0x00fff4b8) =3D 2483
1879 clone(CLONE_VM|CLONE_FS|CLONE_FILES|CLONE_SIGHAND|CLONE_THREAD|CLONE=
_SYSVSEM|CLONE_SETTLS|CLONE_PARENT_SETTID|CLONE_CHILD_CLEARTID,child_stac=
k=3D0x00ffef88,parent_tidptr=3D0x00fff4b8,tls=3D0x00fff910,child_tidptr=3D=
0x00fff4b8) =3D 2484
1879 futex(0xf61d5fa0,FUTEX_PRIVATE_FLAG|FUTEX_WAIT,0,NULL,0xf61d5fa0,-16=
5847136)1879 clone(CLONE_VM|CLONE_FS|CLONE_FILES|CLONE_SIGHAND|CLONE_THRE=
AD|CLONE_SYSVSEM|CLONE_SETTLS|CLONE_PARENT_SETTID|CLONE_CHILD_CLEARTID,ch=
ild_stack=3D0x017fef88,parent_tidptr=3D0x017ff4b8,tls=3D0x017ff910,child_=
tidptr=3D0x017ff4b8) =3D 2485
1879 clone(CLONE_VM|CLONE_FS|CLONE_FILES|CLONE_SIGHAND|CLONE_THREAD|CLONE=
_SYSVSEM1879 futex(0xf61d5fa0,FUTEX_PRIVATE_FLAG|FUTEX_WAIT,0,NULL,0xf61d=
5fa0,-165847136)|CLONE_SETTLS|CLONE_PARENT_SETTID|CLONE_CHILD_CLEARTID,ch=
ild_stack=3D0x01ffef88,parent_tidptr=3D0x01fff4b8,tls=3D0x01fff910,child_=
tidptr=3D0x01fff4b8) =3D 2486
1879 clone(CLONE_VM|CLONE_FS|CLONE_FILES|CLONE_SIGHAND|CLONE_THREAD|CLONE=
_SYSVSEM|CLONE_SETTLS|CLONE_PARENT_SETTID|CLONE_CHILD_CLEARTID,child_stac=
k=3D0x027fef88,parent_tidptr=3D0x027ff4b8,tls=3D0x027ff910,child_tidptr=3D=
0x027ff4b8)1879 futex(0xf61d5fa0,FUTEX_PRIVATE_FLAG|FUTEX_WAIT,0,NULL,0xf=
61d5fa0,-165847136) =3D 2487
1879 clone(CLONE_VM|CLONE_FS|CLONE_FILES1879 futex(0xf61d5fa0,FUTEX_PRIVA=
TE_FLAG|FUTEX_WAIT,0,NULL,0xf61d5fa0,-165847136)|CLONE_SIGHAND|CLONE_THRE=
AD|CLONE_SYSVSEM|CLONE_SETTLS|CLONE_PARENT_SETTID|CLONE_CHILD_CLEARTID,ch=
ild_stack=3D0x02ffef88,parent_tidptr=3D0x02fff4b8,tls=3D0x02fff910,child_=
tidptr=3D0x02fff4b8) =3D 2488
1879 mmap2(NULL,8388608,PROT_READ|PROT_WRITE,MAP_PRIVATE1879 futex(0xf61d=
5fa0,FUTEX_PRIVATE_FLAG|FUTEX_WAIT,0,NULL,0xf61d5fa0,-165847136)|MAP_ANON=
YMOUS|0x20000,-1,0) =3D 0x00000000
1879 write(2,0xf6fd39d0,79)stx_test: allocatestack.c:514: allocate_stack:=
 Assertion `mem !=3D NULL' failed.
1879 mmap2(NULL,4096,PROT_READ|PROT_WRITE,MAP_PRIVATE|MAP_ANONYMOUS,-1,0)=
 =3D 0xf61ca000


Host strace: strace -f qemu-arm-static [truncated and filtered, different=
 run than above]:

mmap(NULL, 8392704, PROT_NONE, MAP_PRIVATE|MAP_ANONYMOUS|MAP_STACK, -1, 0=
) =3D 0x7f5344532000
clone(child_stack=3D0x7f5344d31db0, flags=3DCLONE_VM|CLONE_FS|CLONE_FILES=
|CLONE_SIGHAND|CLONE_THREAD|CLONE_SYSVSEM|CLONE_SETTLS|CLONE_PARENT_SETTI=
D|CLONE_CHILD_CLEARTID, parent_tidptr=3D0x7f5344d329d0, tls=3D0x7f5344d32=
700, child_tidptr=3D0x7f5344d329d0) =3D 2492
[pid  2491] mmap(NULL, 528384, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANON=
YMOUS, -1, 0) =3D 0x7f53444b1000
[pid  2491] mmap(NULL, 225280, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANON=
YMOUS, -1, 0) =3D 0x7f534447a000
[pid  2491] mmap(NULL, 4143972352, PROT_NONE, MAP_PRIVATE|MAP_ANONYMOUS|M=
AP_NORESERVE, -1, 0) =3D 0x7f524d47a000
[pid  2491] mmap(0x7f534d46a000, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|=
MAP_ANONYMOUS, -1, 0) =3D 0x7f534d46a000
[pid  2491] openat(AT_FDCWD, "/proc/sys/vm/mmap_min_addr", O_RDONLY) =3D =
3

...

[pid  2491] clone(child_stack=3D0x7f524cd1bdb0, flags=3DCLONE_VM|CLONE_FS=
|CLONE_FILES|CLONE_SIGHAND|CLONE_THREAD|CLONE_SYSVSEM|CLONE_SETTLS|CLONE_=
PARENT_SETTID|CLONE_CHILD_CLEARTID, parent_tidptr=3D0x7f524cd1c9d0, tls=3D=
0x7f524cd1c700, child_tidptr=3D0x7f524cd1c9d0) =3D 3092
[pid  2491] mmap(0x7f524e47a000, 8388608, PROT_READ|PROT_WRITE, MAP_PRIVA=
TE|MAP_FIXED|MAP_ANONYMOUS, -1, 0 <unfinished ...>
[pid  2491] <... mmap resumed> )        =3D 0x7f524e47a000
[pid  2491] clone(child_stack=3D0x7f524cd9ddb0, flags=3DCLONE_VM|CLONE_FS=
|CLONE_FILES|CLONE_SIGHAND|CLONE_THREAD|CLONE_SYSVSEM|CLONE_SETTLS|CLONE_=
PARENT_SETTID|CLONE_CHILD_CLEARTID, parent_tidptr=3D0x7f524cd9e9d0, tls=3D=
0x7f524cd9e700, child_tidptr=3D0x7f524cd9e9d0) =3D 3093
[pid  2491] mmap(0x7f524dc7a000, 8388608, PROT_READ|PROT_WRITE, MAP_PRIVA=
TE|MAP_FIXED|MAP_ANONYMOUS, -1, 0 <unfinished ...>
[pid  2491] <... mmap resumed> )        =3D 0x7f524dc7a000
[pid  2491] clone(strace: Process 3094 attached
[pid  2491] mmap(0x7f525b47a000, 8388608, PROT_NONE, MAP_PRIVATE|MAP_FIXE=
D|MAP_ANONYMOUS|MAP_NORESERVE, -1, 0 <unfinished ...>
[pid  2491] <... mmap resumed> )        =3D 0x7f525b47a000
[pid  2491] mmap(0x7f525bc7a000, 8388608, PROT_NONE, MAP_PRIVATE|MAP_FIXE=
D|MAP_ANONYMOUS|MAP_NORESERVE, -1, 0 <unfinished ...>
[pid  2491] <... mmap resumed> )        =3D 0x7f525bc7a000
[pid  2491] mmap(0x7f525c47a000, 8388608, PROT_NONE, MAP_PRIVATE|MAP_FIXE=
D|MAP_ANONYMOUS|MAP_NORESERVE, -1, 0) =3D 0x7f525c47a000
[pid  2491] mmap(0x7f525cc7a000, 8388608, PROT_NONE, MAP_PRIVATE|MAP_FIXE=
D|MAP_ANONYMOUS|MAP_NORESERVE, -1, 0) =3D 0x7f525cc7a000
[pid  2491] mmap(0x7f525d47a000, 8388608, PROT_NONE, MAP_PRIVATE|MAP_FIXE=
D|MAP_ANONYMOUS|MAP_NORESERVE, -1, 0) =3D 0x7f525d47a000
[pid  2491] mmap(0x7f525ac7a000, 8388608, PROT_NONE, MAP_PRIVATE|MAP_FIXE=
D|MAP_ANONYMOUS|MAP_NORESERVE, -1, 0) =3D 0x7f525ac7a000
[pid  2491] mmap(0x7f525a47a000, 8388608, PROT_NONE, MAP_PRIVATE|MAP_FIXE=
D|MAP_ANONYMOUS|MAP_NORESERVE, -1, 0) =3D 0x7f525a47a000
[pid  2491] mmap(0x7f5259c7a000, 8388608, PROT_NONE, MAP_PRIVATE|MAP_FIXE=
D|MAP_ANONYMOUS|MAP_NORESERVE, -1, 0) =3D 0x7f5259c7a000
[pid  2491] mmap(0x7f525947a000, 8388608, PROT_NONE, MAP_PRIVATE|MAP_FIXE=
D|MAP_ANONYMOUS|MAP_NORESERVE, -1, 0) =3D 0x7f525947a000
[pid  2491] mmap(0x7f5258c7a000, 8388608, PROT_NONE, MAP_PRIVATE|MAP_FIXE=
D|MAP_ANONYMOUS|MAP_NORESERVE, -1, 0) =3D 0x7f5258c7a000
[pid  2491] mmap(0x7f525847a000, 8388608, PROT_NONE, MAP_PRIVATE|MAP_FIXE=
D|MAP_ANONYMOUS|MAP_NORESERVE, -1, 0) =3D 0x7f525847a000
[pid  2491] mmap(0x7f5257c7a000, 8388608, PROT_NONE, MAP_PRIVATE|MAP_FIXE=
D|MAP_ANONYMOUS|MAP_NORESERVE, -1, 0) =3D 0x7f5257c7a000
[pid  2491] mmap(0x7f525747a000, 8388608, PROT_NONE, MAP_PRIVATE|MAP_FIXE=
D|MAP_ANONYMOUS|MAP_NORESERVE, -1, 0) =3D 0x7f525747a000
[pid  2491] mmap(0x7f5256c7a000, 8388608, PROT_NONE, MAP_PRIVATE|MAP_FIXE=
D|MAP_ANONYMOUS|MAP_NORESERVE, -1, 0) =3D 0x7f5256c7a000
[pid  2491] mmap(0x7f525647a000, 8388608, PROT_NONE, MAP_PRIVATE|MAP_FIXE=
D|MAP_ANONYMOUS|MAP_NORESERVE, -1, 0) =3D 0x7f525647a000
[pid  2491] mmap(0x7f5255c7a000, 8388608, PROT_NONE, MAP_PRIVATE|MAP_FIXE=
D|MAP_ANONYMOUS|MAP_NORESERVE, -1, 0) =3D 0x7f5255c7a000
[pid  2491] mmap(0x7f525547a000, 8388608, PROT_NONE, MAP_PRIVATE|MAP_FIXE=
D|MAP_ANONYMOUS|MAP_NORESERVE, -1, 0) =3D 0x7f525547a000
[pid  2491] mmap(0x7f5254c7a000, 8388608, PROT_NONE, MAP_PRIVATE|MAP_FIXE=
D|MAP_ANONYMOUS|MAP_NORESERVE, -1, 0) =3D 0x7f5254c7a000
[pid  2491] mmap(0x7f525447a000, 8388608, PROT_NONE, MAP_PRIVATE|MAP_FIXE=
D|MAP_ANONYMOUS|MAP_NORESERVE, -1, 0) =3D 0x7f525447a000
[pid  2491] mmap(0x7f5253c7a000, 8388608, PROT_NONE, MAP_PRIVATE|MAP_FIXE=
D|MAP_ANONYMOUS|MAP_NORESERVE, -1, 0) =3D 0x7f5253c7a000
[pid  2491] mmap(0x7f525347a000, 8388608, PROT_NONE, MAP_PRIVATE|MAP_FIXE=
D|MAP_ANONYMOUS|MAP_NORESERVE, -1, 0) =3D 0x7f525347a000
[pid  2491] mmap(0x7f5252c7a000, 8388608, PROT_NONE, MAP_PRIVATE|MAP_FIXE=
D|MAP_ANONYMOUS|MAP_NORESERVE, -1, 0) =3D 0x7f5252c7a000
[pid  2491] mmap(0x7f525247a000, 8388608, PROT_NONE, MAP_PRIVATE|MAP_FIXE=
D|MAP_ANONYMOUS|MAP_NORESERVE, -1, 0) =3D 0x7f525247a000
[pid  2491] mmap(0x7f5251c7a000, 8388608, PROT_NONE, MAP_PRIVATE|MAP_FIXE=
D|MAP_ANONYMOUS|MAP_NORESERVE, -1, 0) =3D 0x7f5251c7a000
[pid  2491] mmap(0x7f525147a000, 8388608, PROT_NONE, MAP_PRIVATE|MAP_FIXE=
D|MAP_ANONYMOUS|MAP_NORESERVE, -1, 0) =3D 0x7f525147a000
[pid  2491] mmap(0x7f5250c7a000, 8388608, PROT_NONE, MAP_PRIVATE|MAP_FIXE=
D|MAP_ANONYMOUS|MAP_NORESERVE, -1, 0) =3D 0x7f5250c7a000
[pid  2491] mmap(0x7f525047a000, 8388608, PROT_NONE, MAP_PRIVATE|MAP_FIXE=
D|MAP_ANONYMOUS|MAP_NORESERVE, -1, 0) =3D 0x7f525047a000
[pid  2491] clone(strace: Process 3095 attached
[pid  2491] clone(strace: Process 3096 attached
[pid  2491] clone(strace: Process 3097 attached
[pid  2491] clone(strace: Process 3098 attached
[pid  2491] clone(strace: Process 3099 attached
[pid  2491] clone(strace: Process 3100 attached
[pid  2491] mmap(0x7f524d47a000, 8388608, PROT_READ|PROT_WRITE, MAP_PRIVA=
TE|MAP_FIXED|MAP_ANONYMOUS, -1, 0 <unfinished ...>
[pid  2491] <... mmap resumed> )        =3D 0x7f524d47a000
[pid  2491] write(2, "stx_test: allocatestack.c:514: a"..., 79stx_test: a=
llocatestack.c:514: allocate_stack: Assertion `mem !=3D NULL' failed.








--=20
----------------------------------------------------------------------
Cadami UG (haftungsbeschr=C3=A4nkt)
Waagstra=C3=9Fe 10, 85386 Eching (near Munich), Germany
Office:    c/o Wayra, Kaufingerstra=C3=9Fe 15, 80331 Munich, Germany

Contact:   +49-176-63360306, riemensberger@cadami.net, www.cadami.net

Gesch=C3=A4ftsf=C3=BChrer:         Andreas Dotzler, Michael Heindlmaier,
                         Thomas K=C3=BChn, Maximilian Riemensberger
Sitz der Gesellschaft:   Eching, HRB 219979 Amtsgericht M=C3=BCnchen
USt-IdNr.:               DE301293803
----------------------------------------------------------------------
