Received: from eggs.gnu.org ([2001:4830:134:3::10]:55036)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1fqE5l-0000xC-NO
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 04:57:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1fqE5i-0000NN-Bi
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 04:57:17 -0400
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:55957)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1fqE5c-0000J3-9G
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 04:57:08 -0400
Received: by mail-wm0-x241.google.com with SMTP id f21-v6so3703158wmc.5
	for <qemu-devel@nongnu.org>; Thu, 16 Aug 2018 01:57:04 -0700 (PDT)
MIME-Version: 1.0
References: <62da53b4.26c.16540558d49.Coremail.tangfu@gohighsec.com>
In-Reply-To: <62da53b4.26c.16540558d49.Coremail.tangfu@gohighsec.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Thu, 16 Aug 2018 10:56:52 +0200
Message-ID: <CAJ+F1C+zhQkaQgHgKf_oa8nfw_PTY1wgS7tHZG7cuUObzVk9jA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] vTPM 2.0 is recognized as vTPM 1.2 on the Win 10
 virtual machine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: tangfu@gohighsec.com
Cc: QEMU <qemu-devel@nongnu.org>

Hi
On Thu, Aug 16, 2018 at 3:29 AM =E6=B1=A4=E7=A6=8F <tangfu@gohighsec.com> w=
rote:
>
> Hi,
>
> I want to use the vTPM in a qemu Windows image. Unfortunately, it didn't =
work.
> First, the equipment:
> TPM 2.0 hardware
> CentOS 7.2
> Qemu v2.10.2
> SeaBIOS 1.11.0
> libtpm and so on
>
> My host is centos 7.2 with the TPM 2.0 hardware and qemu v2.10.2.
> I make the libtpm and seabios with ./configure, make and so on. I checked=
 seabios with make menuconfig the TPM setting. It is enabled tpm by default=
.
> Eventually, all works without errors.
>
> I start the Widnows 10 image with:
> qemu-system-x86_64 -display sdl -enable-kvm -m 2048 -boot d -bios bios.bi=
n -boot menu=3Don -tpmdev cuse-tpm,id=3Dtpm0,cancel-path=3D/dev/null,type=
=3Dpassthrough,path=3D/dev/tpm0  -device tpm-tis,tpmdev=3Dtpm0 win10.img
>
>
> First it looks all fine. Windows 10 booted up but the vTPM was recognized=
 as TPM 1.2 instead of TPM 2.0 in device manager. I open the tpm Manager wi=
th tpm.msc but get error with No compatible TPM found.
> If I use vTPM in a qemu linux image, everything gose well.
>
>
> So, what could be the problem?

You need to build libtpms & swtpm from Stefan tpm2-preview branches.
(Alternatively, there is now an experimental fedora copr repository:
https://copr.fedorainfracloud.org/coprs/stefanberger/swtpm/)

I suggest to setup the VM with libvirt upstream, which will do the
preliminary swtpm_setup for you, or follow
https://github.com/stefanberger/swtpm/wiki/Certificiates-created-by-swtpm_s=
etup

For Windows TPM 2 support, you will need the TPM CRB device, and
upstream OVMF compiled with  -D TPM2_ENABLE (TIS & Bios are 1.2 only
for Windows, even if seabios does have some 2.0 support with them)

Furthermore, to pass the WLK tests, you need PPI & MOR interface,
which are still pending merge ([PATCH v9 0/6] Add support for TPM
Physical Presence interface)




--=20
Marc-Andr=C3=A9 Lureau
