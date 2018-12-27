Received: from eggs.gnu.org ([208.118.235.92]:33270)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <luto@amacapital.net>) id 1gcZc6-0003gB-Gl
	for qemu-devel@nongnu.org; Thu, 27 Dec 2018 12:38:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <luto@amacapital.net>) id 1gcZc5-0000cS-KT
	for qemu-devel@nongnu.org; Thu, 27 Dec 2018 12:38:30 -0500
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:42352)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <luto@amacapital.net>) id 1gcZc5-0000bk-C2
	for qemu-devel@nongnu.org; Thu, 27 Dec 2018 12:38:29 -0500
Received: by mail-oi1-x242.google.com with SMTP id w13so15585887oiw.9
	for <qemu-devel@nongnu.org>; Thu, 27 Dec 2018 09:38:28 -0800 (PST)
Mime-Version: 1.0 (1.0)
From: Andy Lutomirski <luto@amacapital.net>
In-Reply-To: <87bm56vqg4.fsf@mid.deneb.enyo.de>
Date: Thu, 27 Dec 2018 10:38:10 -0700
Message-Id: <C65D3222-723F-4C0B-AF02-38488C302E84@amacapital.net>
References: <87bm56vqg4.fsf@mid.deneb.enyo.de>
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] d_off field in struct dirent and 32-on-64 emulation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Florian Weimer <fw@deneb.enyo.de>
Cc: linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org, linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org, v9fs-developer@lists.sourceforge.net, libc-alpha@sourceware.org, qemu-devel@nongnu.org, ericvh@gmail.com, rminnich@sandia.gov, lucho@ionkov.net, hpa@zytor.com, arnd@arndb.de



> On Dec 27, 2018, at 10:18 AM, Florian Weimer <fw@deneb.enyo.de> wrote:
>=20
> We have a bit of an interesting problem with respect to the d_off
> field in struct dirent.
>=20
> When running a 64-bit kernel on certain file systems, notably ext4,
> this field uses the full 63 bits even for small directories (strace -v
> output, wrapped here for readability):
>=20
> getdents(3, [
>  {d_ino=3D1494304, d_off=3D3901177228673045825, d_reclen=3D40, d_name=3D"a=
uthorized_keys", d_type=3DDT_REG},
>  {d_ino=3D1494277, d_off=3D7491915799041650922, d_reclen=3D24, d_name=3D".=
", d_type=3DDT_DIR},
>  {d_ino=3D1314655, d_off=3D9223372036854775807, d_reclen=3D24, d_name=3D".=
.", d_type=3DDT_DIR}
> ], 32768) =3D 88
>=20
> When running in 32-bit compat mode, this value is somehow truncated to
> 31 bits, for both the getdents and the getdents64 (!) system call (at
> least on i386).

I imagine you=E2=80=99re encountering this bug:

https://lkml.org/lkml/2018/10/18/859

Presumably the right fix involves modifying the relevant VFS file operations=
 to indicate the relevant ABI to the implementations.

I would guess that 9p is triggering the =E2=80=9Cnot really in the syscall y=
ou think you=E2=80=99re in=E2=80=9D issue.
