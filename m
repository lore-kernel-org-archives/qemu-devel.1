Received: from eggs.gnu.org ([208.118.235.92]:36965)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <luto@kernel.org>) id 1gcuLS-00036L-75
	for qemu-devel@nongnu.org; Fri, 28 Dec 2018 10:46:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <luto@kernel.org>) id 1gcuA3-0000R8-5A
	for qemu-devel@nongnu.org; Fri, 28 Dec 2018 10:34:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:58102)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <luto@kernel.org>) id 1gcu1k-0002r9-IB
	for qemu-devel@nongnu.org; Fri, 28 Dec 2018 10:26:21 -0500
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com
	[209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPSA id 1C89E214C6
	for <qemu-devel@nongnu.org>; Fri, 28 Dec 2018 15:26:14 +0000 (UTC)
Received: by mail-wm1-f50.google.com with SMTP id f81so19936214wmd.4
	for <qemu-devel@nongnu.org>; Fri, 28 Dec 2018 07:26:14 -0800 (PST)
MIME-Version: 1.0
References: <87bm56vqg4.fsf@mid.deneb.enyo.de>
In-Reply-To: <87bm56vqg4.fsf@mid.deneb.enyo.de>
From: Andy Lutomirski <luto@kernel.org>
Date: Fri, 28 Dec 2018 07:26:00 -0800
Message-ID: <CALCETrUBfVK1yUtuVn-pGzgrq8GQ7_E0sjPBXPaSiPU+Q-C_aA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
Cc: Linux FS Devel <linux-fsdevel@vger.kernel.org>, Linux API <linux-api@vger.kernel.org>, linux-ext4@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, V9FS Developers <v9fs-developer@lists.sourceforge.net>, libc-alpha <libc-alpha@sourceware.org>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Eric Van Hensbergen <ericvh@gmail.com>, Ron Minnich <rminnich@sandia.gov>, Latchesar Ionkov <lucho@ionkov.net>, "H. Peter Anvin" <hpa@zytor.com>, Arnd Bergmann <arnd@arndb.de>

[sending again, slightly edited, due to email client issues]

On Thu, Dec 27, 2018 at 9:25 AM Florian Weimer <fw@deneb.enyo.de> wrote:
>
> We have a bit of an interesting problem with respect to the d_off
> field in struct dirent.
>
> When running a 64-bit kernel on certain file systems, notably ext4,
> this field uses the full 63 bits even for small directories (strace -v
> output, wrapped here for readability):
>
> getdents(3, [
>   {d_ino=3D1494304, d_off=3D3901177228673045825, d_reclen=3D40, d_name=3D=
"authorized_keys", d_type=3DDT_REG},
>   {d_ino=3D1494277, d_off=3D7491915799041650922, d_reclen=3D24, d_name=3D=
".", d_type=3DDT_DIR},
>   {d_ino=3D1314655, d_off=3D9223372036854775807, d_reclen=3D24, d_name=3D=
"..", d_type=3DDT_DIR}
> ], 32768) =3D 88
>
> When running in 32-bit compat mode, this value is somehow truncated to
> 31 bits, for both the getdents and the getdents64 (!) system call (at
> least on i386).
>

...

>
> However, both qemu-user and the 9p file system can run in such a way
> that the kernel is entered from a 64-bit process, but the actual usage
> is from a 32-bit process:


I imagine that at least some of the problems you're seeing are due to this =
bug:

https://lkml.org/lkml/2018/10/18/859

Presumably the right fix involves modifying the relevant VFS file
operations to indicate the relevant ABI to the implementations.  I
would guess that 9p is triggering the =E2=80=9Cnot really in the syscall yo=
u
think you=E2=80=99re in=E2=80=9D issue.
