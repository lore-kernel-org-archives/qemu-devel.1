Received: from eggs.gnu.org ([2001:4830:134:3::10]:48056)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <riemensberger@cadami.net>) id 1eXZIh-0002uW-04
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 16:13:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <riemensberger@cadami.net>) id 1eXZIb-0000iT-Tl
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 16:13:14 -0500
Received: from dd7730.kasserver.com ([85.13.132.46]:56819)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <riemensberger@cadami.net>)
	id 1eXZIb-0000fk-6z
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 16:13:09 -0500
References: <a979d8c1-2b2a-9ccd-5e51-bfef8292e571@cadami.net>
	<CAFEAcA9Hg4-ZABXZXi8Rxs+nvVpMh+95nY-VLNsxzCRrj1srzQ@mail.gmail.com>
From: Maximilian Riemensberger <riemensberger@cadami.net>
Message-ID: <ad9e4d2e-7169-f8ec-792c-5b2c242fdac5@cadami.net>
Date: Fri, 5 Jan 2018 22:13:05 +0100
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9Hg4-ZABXZXi8Rxs+nvVpMh+95nY-VLNsxzCRrj1srzQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] linux-user/mmap: Should not return NULL on guest
 call mmap(NULL, ...), causes crash inside glibc
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 05.01.18 19:38, Peter Maydell wrote:
> On 5 January 2018 at 18:13, Maximilian Riemensberger
> <riemensberger@cadami.net> wrote:
>> Hi,
>>
>> yesterday I hit the following problem when running an arm linux execut=
able on
>> qemu-2.10 (qemu-arm-static through binfmt_misc)
>>
>> 1879 mmap2(NULL,8388608,PROT_READ|PROT_WRITE,MAP_PRIVATE|MAP_ANONYMOUS=
|0x20000,-1,0) =3D 0x00000000
>> 1879 write(2,0xf6fd39d0,79) stx_test: allocatestack.c:514: allocate_st=
ack: Assertion `mem !=3D NULL' failed.
>>
>> The issue comes up when the executable creates and joins lots of
>> threads in a loop (it's a unit test).  Eventually, glibc allocatestack
>> hits the mmap(NULL, ...) =3D=3D NULL.  Judging from the posix and linu=
x
>> manuals mmap(NULL, ...) never returns NULL.  Either it fails with MAP_=
FAILED
>> or it succeeds and returns non-NULL address.
>=20
> Given the heavy use of threading, can you retest with QEMU 2.11,
> please? We fixed a couple of threading issues in linux-user there.

Same error with fresh qemu-2.11 build.

648 clone(CLONE_VM|CLONE_FS|CLONE_FILES|CLONE_SIGHAND|CLONE_THREAD|CLONE_=
SYSVSEM|CLONE_SETTLS|CLONE_PARENT_SETTID|CLONE_CHILD_CLEARTID,child_stack=
=3D0x01ffef88,parent_tidptr=3D0x01fff4b8,tls=3D0x01fff910,child_tidptr=3D=
0x01fff4b8) =3D 1273
648 mmap2(NULL,8388608,PROT_READ|PROT_WRITE,MAP_PRIVATE|MAP_ANONYMOUS|0x2=
0000,-1,0) =3D 0x01000000
648 mprotect(0x01000000,4096,PROT_NONE) =3D 0
648 clone(CLONE_VM|CLONE_FS|CLONE_FILES|CLONE_SIGHAND|CLONE_THREAD|CLONE_=
SYSVSEM|CLONE_SETTLS|CLONE_PARENT_SETTID|CLONE_CHILD_CLEARTID,child_stack=
=3D0x017fef88,parent_tidptr=3D0x017ff4b8,tls=3D0x017ff910,child_tidptr=3D=
0x017ff4b8) =3D 1274
648 mmap2(NULL,8388608,PROT_READ|PROT_WRITE,MAP_PRIVATE|MAP_ANONYMOUS|0x2=
0000,-1,0) =3D 0x00800000
648 mprotect(0x00800000,4096,PROT_NONE) =3D 0
648 clone(CLONE_VM|CLONE_FS|CLONE_FILES|CLONE_SIGHAND|CLONE_THREAD|CLONE_=
SYSVSEM|CLONE_SETTLS|CLONE_PARENT_SETTID|CLONE_CHILD_CLEARTID,child_stack=
=3D0x00ffef88,parent_tidptr=3D0x00fff4b8,tls=3D0x00fff910,child_tidptr=3D=
0x00fff4b8) =3D 1275
648 mmap2(NULL,8388608,PROT_READ|PROT_WRITE,MAP_PRIVATE|MAP_ANONYMOUS|0x2=
0000,-1,0)648 futex(0xff1c6268,FUTEX_PRIVATE_FLAG|FUTEX_WAIT,0,NULL,0xff1=
c6268,-14917016) =3D 0x00000000
648 futex(0xff1c6268,FUTEX_PRIVATE_FLAG|FUTEX_WAIT,0,NULL,0xff1c6268,-149=
17016)648 futex(0xff1c6268,FUTEX_PRIVATE_FLAG|FUTEX_WAIT,0,NULL,0xff1c626=
8,-14917016)648 write(2,0xfffc39d0,79)stx_test: allocatestack.c:514: allo=
cate_stack: Assertion `mem !=3D NULL' failed.
 =3D 79

Cheers,
	Max

>=20
> thanks
> -- PMM
>=20

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
