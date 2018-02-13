Received: from eggs.gnu.org ([2001:4830:134:3::10]:41267)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1elgMh-0004Jn-C6
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 14:35:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1elgMe-0004QJ-9N
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 14:35:43 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42032 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1elgMe-0004Q0-4B
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 14:35:40 -0500
References: <embe7de3dd-331d-44fe-9c32-75916c902fb6@ndc-wkst-2>
	<20180213162857.GV573@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <7a31ffe6-03a2-8add-3d24-399651cd856f@redhat.com>
Date: Tue, 13 Feb 2018 20:35:23 +0100
MIME-Version: 1.0
In-Reply-To: <20180213162857.GV573@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] QEMU leaves pidfile behind on exit
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>, Shaun Reitan <shaun.reitan@ndchost.com>
Cc: pbonzini@redhat.com, qemu-devel@nongnu.org

On 02/13/18 17:28, Daniel P. Berrang=C3=A9 wrote:
> On Fri, Feb 09, 2018 at 07:12:59PM +0000, Shaun Reitan wrote:
>> QEMU leaves the pidfile behind on a clean exit when using the option
>> -pidfile /var/run/qemu.pid.
>>
>> Should QEMU leave it behind or should it clean up after itself?
>>
>> I'm willing to take a crack at a patch to fix the issue, but before I =
do, I
>> want to make sure that leaving the pidfile behind was not intentional?
>=20
> If QEMU deletes the pidfile on exit then, with the current pidfile
> acquisition logic, there's a race condition possible:
>=20
> To acquire we do
>=20
>  1. fd =3D open()
>  2. lockf(fd)
>=20
> If the first QEMU that currently owns the pidfile unlinks in, while
> a second qemu is in betweeen steps 1 & 2, the second QEMU will
> acquire the pidfile successfully (which is fine) but the pidfile
> is now unlinked. This is not fine, because a 3rd qemu can now come
> and try to acquire the pidfile (by creating a new one) and succeed,
> despite the second qemu still owning the (now unlinked) pidfile.
>=20
> It is possible to deal with this race by making qemu_create_pidfile
> more intelligent [1]. It would have todo
>=20
>   1. fd =3D open(filename)
>   2. fstat(fd)
>   3. lockf(fd)
>   4. stat(filename)
>=20
> It must then compare the results of 2 + 4 to ensure the pidfile it
> acquired is the same as the one on disk. With this change, it would
> be safe for QEMU to delete the pidfile on exit.

Why don't we just open the pidfile with (O_CREAT | O_EXCL)? O_EXCL is
supposed to be atomic.

... The open(2) manual on Linux says,

              On  NFS,  O_EXCL  is  supported only when using NFSv3 or
              later on kernel 2.6 or later.  In NFS environments where
              O_EXCL support is not provided, programs that rely on it
              for performing locking tasks will contain a race  condi-
              tion.   [...]

Sigh.

> [1] See the equiv libvirt logic for pidfile acquisition in
>      https://libvirt.org/git/?p=3Dlibvirt.git;a=3Dblob;f=3Dsrc/util/vir=
pidfile.c;h=3D58ab29f77f2cfb8583447112dae77a07446bc627;hb=3DHEAD#l384
>=20

To my knowledge, "same file" should be checked with:

  a.st_dev =3D=3D b.st_dev && a.st_ino =3D=3D b.st_ino

Example:
- "filename" is "/var/run/qemu.pid"
- "/var/run" is originally a symbolic link to "/mnt/fs1/"
- between steps #1 and #4, "/var/run" is re-created as a symbolic link
  to "/mnt/fs2/" -- a different filesystem from fs1
- "/mnt/fs2/qemu.pid" happens to have the same inode number as
  "/mnt/fs1/qemu.pid"

Thanks,
Laszlo
