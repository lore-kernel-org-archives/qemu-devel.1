Received: from eggs.gnu.org ([2001:4830:134:3::10]:41555)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1fs310-0001Jc-5c
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 05:31:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1fs2od-0007ZT-M1
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 05:19:10 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429]:41044)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1fs2ob-0007Xt-Al
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 05:19:06 -0400
Received: by mail-wr1-x429.google.com with SMTP id z96-v6so6565067wrb.8
	for <qemu-devel@nongnu.org>; Tue, 21 Aug 2018 02:19:05 -0700 (PDT)
MIME-Version: 1.0
References: <62da53b4.26c.16540558d49.Coremail.tangfu@gohighsec.com>
	<CAJ+F1C+zhQkaQgHgKf_oa8nfw_PTY1wgS7tHZG7cuUObzVk9jA@mail.gmail.com>
	<6d7ecaf.2be.1655124b512.Coremail.tangfu@gohighsec.com>
In-Reply-To: <6d7ecaf.2be.1655124b512.Coremail.tangfu@gohighsec.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 21 Aug 2018 11:18:52 +0200
Message-ID: <CAJ+F1CLdX5v+vHwQ8gj1SfsHCQdLFqiXU2mPzgGm+X1uapT6rQ@mail.gmail.com>
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
On Sun, Aug 19, 2018 at 9:47 AM =E6=B1=A4=E7=A6=8F <tangfu@gohighsec.com> w=
rote:
>
> I tried it according to your method, but I have some problems. My host is=
 centos 7.2 with the TPM 2.0 hardware and qemu v2.10.2. The driver for the =
TPM 2.0 hardware is crb device=EF=BC=8CExecute lsmod to view the tpm 2.0 dr=
iver information as follows=EF=BC=9A
> [root@localhost BUILD]# lsmod | grep tpm
> tpm_crb                12972  0
>
> I downloaded the OVMF-20182028-5.noarch.src.rpm package from the rpm sear=
ch website. And rebulid it with -DTPM2_ENABLE and -DSECURE_BOOT_ENABLE, Reb=
ulid everything well and generate the OVMF.fd and OVMF_ARGS.fd file=EF=BC=
=8Cso I copy OVMF.fd to my qemu-kvm project and start qemu to install windo=
ws 10 virtual machine.
>
> I first created a blank img file named win10.img=EF=BC=8Cand install win1=
0  virtual machine as follows=EF=BC=9A
> [root@localhost BUILD]#qemu-system-x86_64 -display sdl -enable-kvm  -m 40=
96 -boot d  -cdrom win10.iso -bios OVMF.fd  -net none  -boot menu=3Don -tpm=
dev cuse-tpm,id=3Dtpm0,cancel-path=3D/dev/null,type=3Dpassthrough,path=3D/d=
ev/tpm0  -device tpm-tis,tpmdev=3Dtpm0 win10.img

cuse-tpm doesn't exist in qemu upstream. You are using TPM passthrough
here, not vTPM.

I suggest you try with qemu upstream and read the TPM document
(replacing seabios with ovmf like you did, and tis with crb etc), in
complement with
https://github.com/stefanberger/swtpm/wiki/Certificiates-created-by-swtpm_s=
etup
:
https://git.qemu.org/?p=3Dqemu.git;a=3Dblob_plain;f=3Ddocs/specs/tpm.txt

>
> The installation process is very very slow, the system automatically rest=
arts after the installation is complete. But it seems can't enter the deskt=
op. The system restarts cyclically, it looks like there is a problem with B=
IOS boot. I think of what you said that  for Windows TPM 2 support will nee=
d the TPM CRB device, so I start qemu with parameter of -device tpm-crb but=
 it didn't work. Prompt the following error message=EF=BC=9A
> [root@localhost BUILD]#qemu-system-x86_64 -display sdl -enable-kvm  -m 40=
96 -boot d  -bios OVMF.fd  -net none  -boot menu=3Don -tpmdev cuse-tpm,id=
=3Dtpm0,cancel-path=3D/dev/null,type=3Dpassthrough,path=3D/dev/tpm0  -devic=
e tpm-crb,tpmdev=3Dtpm0 win10.img
> [root@localhost BUILD]#qemu-system-x86_64: -device tpm-crb,tpmdev=3Dtpm0:=
 'tpm-crb' is not a valid device model name
>
> I don't know where the problem is, I need you to give me some help. Thank=
 you very much!
>
>
> > -----=E5=8E=9F=E5=A7=8B=E9=82=AE=E4=BB=B6-----
> > =E5=8F=91=E4=BB=B6=E4=BA=BA: "Marc-Andr=C3=A9 Lureau" <marcandre.lureau=
@gmail.com>
> > =E5=8F=91=E9=80=81=E6=97=B6=E9=97=B4: 2018-08-16 16:56:52 (=E6=98=9F=E6=
=9C=9F=E5=9B=9B)
> > =E6=94=B6=E4=BB=B6=E4=BA=BA: tangfu@gohighsec.com
> > =E6=8A=84=E9=80=81: QEMU <qemu-devel@nongnu.org>
> > =E4=B8=BB=E9=A2=98: Re: [Qemu-devel] vTPM 2.0 is recognized as vTPM 1.2=
 on the Win 10 virtual machine
> >
> > Hi
> > On Thu, Aug 16, 2018 at 3:29 AM =E6=B1=A4=E7=A6=8F <tangfu@gohighsec.co=
m> wrote:
> > >
> > > Hi,
> > >
> > > I want to use the vTPM in a qemu Windows image. Unfortunately, it did=
n't work.
> > > First, the equipment:
> > > TPM 2.0 hardware
> > > CentOS 7.2
> > > Qemu v2.10.2
> > > SeaBIOS 1.11.0
> > > libtpm and so on
> > >
> > > My host is centos 7.2 with the TPM 2.0 hardware and qemu v2.10.2.
> > > I make the libtpm and seabios with ./configure, make and so on. I che=
cked seabios with make menuconfig the TPM setting. It is enabled tpm by def=
ault.
> > > Eventually, all works without errors.
> > >
> > > I start the Widnows 10 image with:
> > > qemu-system-x86_64 -display sdl -enable-kvm -m 2048 -boot d -bios bio=
s.bin -boot menu=3Don -tpmdev cuse-tpm,id=3Dtpm0,cancel-path=3D/dev/null,ty=
pe=3Dpassthrough,path=3D/dev/tpm0  -device tpm-tis,tpmdev=3Dtpm0 win10.img
> > >
> > >
> > > First it looks all fine. Windows 10 booted up but the vTPM was recogn=
ized as TPM 1.2 instead of TPM 2.0 in device manager. I open the tpm Manage=
r with tpm.msc but get error with No compatible TPM found.
> > > If I use vTPM in a qemu linux image, everything gose well. I think of=
 what you said
> > >
> > >
> > > So, what could be the problem?
> >
> > You need to build libtpms & swtpm from Stefan tpm2-preview branches.
> > (Alternatively, there is now an experimental fedora copr repository:
> > https://copr.fedorainfracloud.org/coprs/stefanberger/swtpm/)
> >
> > I suggest to setup the VM with libvirt upstream, which will do the
> > preliminary swtpm_setup for you, or follow
> > https://github.com/stefanberger/swtpm/wiki/Certificiates-created-by-swt=
pm_setup
> >
> > For Windows TPM 2 support, you will need the TPM CRB device, and
> > upstream OVMF compiled with  -D TPM2_ENABLE (TIS & Bios are 1.2 only
> > for Windows, even if seabios does have some 2.0 support with them)
> >
> > Furthermore, to pass the WLK tests, you need PPI & MOR interface,
> > which are still pending merge ([PATCH v9 0/6] Add support for TPM
> > Physical Presence interface)
> >
> >
> >
> >
> > --
> > Marc-Andr=C3=A9 Lureau



--
Marc-Andr=C3=A9 Lureau
