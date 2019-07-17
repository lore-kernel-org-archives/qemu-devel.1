Return-Path: <SRS0=PWhW=VO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1224C76186
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2019 05:21:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C1B8208C0
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2019 05:21:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="ZcSMLAkG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C1B8208C0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54102 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hncNp-00037e-Q2
	for qemu-devel@archiver.kernel.org; Wed, 17 Jul 2019 01:21:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44375)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <chihmin.chao@sifive.com>) id 1hncNZ-0002Um-GG
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 01:21:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <chihmin.chao@sifive.com>) id 1hncNW-0008JF-NO
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 01:21:25 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c]:34178)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <chihmin.chao@sifive.com>)
 id 1hncNW-0008Hx-AJ
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 01:21:22 -0400
Received: by mail-wr1-x42c.google.com with SMTP id 31so23285385wrm.1
 for <qemu-devel@nongnu.org>; Tue, 16 Jul 2019 22:21:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=PCImjgRifn1SwvlGL4zX8B1ThX4Nq2Y5ZjmlRwejJc4=;
 b=ZcSMLAkGw9vXo9BtPe4q5fsJziHFRvnelcEGMKvebb9mX2lmiNYbBaZ/+UGb3MqCI8
 lQFFUbeiHWKtkj/v3L2QCyUgSp+oY25pIKCcS8/elqO3BYndCffMKw7WwO4CLzXyvxXn
 7slqbdxfCfDnHcd8qs+drujtJOzoLqr61XQdcglI1iV8iI97M6Y182tJltBJkaSQSKNC
 lvtou4KE01rixxyrYJz1JfvXdNQWmDjEKs7cFAxSzWnpGmX6SFRqMjlUqnpvMA/E+pOh
 IG+4OfOqBJFpr7hcO2/hSAxPy0YWS8EZ5LJNr4PnoznPaU39dMyFJ/xLMLttEnhzCccR
 H+/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=PCImjgRifn1SwvlGL4zX8B1ThX4Nq2Y5ZjmlRwejJc4=;
 b=kHHCmd8wWDVxI4ljJmGc8sILcLVlNwFOPPjdJGiFxDK2so0FZ70HG//Z8sxE1WG9ls
 d3jhcIGV+4bzwFqRMm7iWx8JUc6kzgI/85HdiSGftE8Z8gVMUIhI2gO67h77bSoGztMK
 13W1DdtqR9HqGbzHPtWDF3XOYg98fmRgR86ds6tZv2Mdo12HWMHG+ZGZa4/Wj4zQKt4Q
 b/pZkw79HZ3H2l2i1RZFbLhIrS0AUhL7bDgtn+DNCuoTV7CYGhSauaO6+VQlN+Tlz7mj
 hJlw7zZIDsabOJgGT0psj3sXsJ6UuyCazyK2Giknx355x8BM01enQAR5IvPTPve4kFed
 a/cg==
X-Gm-Message-State: APjAAAVpli3WJX1o/583LPei+fTF4hN/Sy9NHCeWwmwWm9j8w0Qs7xGQ
 9L9h508lxBA9IFaKGqmju28lrvQd0z12vG9wxQRDOQ==
X-Google-Smtp-Source: APXvYqw8irZ3ilOI07OTOdfPjxrOuMagT6v8TvaXAK4Kvqd9yPhhc4fwAa/1hBP3RIlnrHu7Bqk9AcDSzqr0CmSDXiQ=
X-Received: by 2002:adf:ecd0:: with SMTP id s16mr39619637wro.324.1563340880285; 
 Tue, 16 Jul 2019 22:21:20 -0700 (PDT)
MIME-Version: 1.0
References: <1563181721-5055-1-git-send-email-chihmin.chao@sifive.com>
 <93b35a5e-c40a-535b-2a91-2c210b4a5928@redhat.com>
 <CAEiOBXXxS-93rTAQuvY_Tkxi1pYc1YfJenpBC_8gG2ou9uUZMg@mail.gmail.com>
 <7eb239bc-32aa-b5fc-ab2e-a741b005aad7@redhat.com>
 <CAKmqyKOZSz4f1-kLDhn=+imCvKHcZJVgqgqWbQ6qxD3K1n17GA@mail.gmail.com>
 <CAEiOBXUBPFx5__wOLvLD0qQ7dzV2XVpHfiOoBZpXpu-SZsMiUg@mail.gmail.com>
 <CAKmqyKNOiRYqZgiWT+LUKkOv+Bew3djOqc9vHpmSqZ-1Gfjd8Q@mail.gmail.com>
 <d2c7e6c6-4d4a-d47e-e496-4f4cfe466fe1@redhat.com>
 <CAKmqyKPiDHrPVuz2P1n9_j170k2bSm=7uDKrQg-fAUhL1FQm9g@mail.gmail.com>
In-Reply-To: <CAKmqyKPiDHrPVuz2P1n9_j170k2bSm=7uDKrQg-fAUhL1FQm9g@mail.gmail.com>
From: Chih-Min Chao <chihmin.chao@sifive.com>
Date: Wed, 17 Jul 2019 13:21:07 +0800
Message-ID: <CAEiOBXUXdyntjnt-bi9-wiO2mmpgVC8WpD9KnxWoDdP__71XXQ@mail.gmail.com>
To: Alistair Francis <alistair23@gmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42c
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: Re: [Qemu-devel] [PATCH v2] tests/boot_linux_console: add a test
 for riscv64 + virt
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Fam Zheng <fam@euphon.net>, Cornelia Huck <cohuck@redhat.com>,
 "open list:RISC-V" <qemu-riscv@nongnu.org>,
 Eduardo Habkost <ehabkost@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 Alistair Francis <alistair@alistair23.me>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jul 17, 2019 at 6:59 AM Alistair Francis <alistair23@gmail.com>
wrote:

> On Tue, Jul 16, 2019 at 2:50 PM Philippe Mathieu-Daud=C3=A9
> <philmd@redhat.com> wrote:
> >
> > On 7/16/19 10:43 PM, Alistair Francis wrote:
> > > On Tue, Jul 16, 2019 at 6:56 AM Chih-Min Chao <chihmin.chao@sifive.co=
m>
> wrote:
> > >>
> > >>
> > >> On Tue, Jul 16, 2019 at 12:34 AM Alistair Francis <
> alistair23@gmail.com> wrote:
> > >>>
> > >>> On Mon, Jul 15, 2019 at 6:02 AM Philippe Mathieu-Daud=C3=A9
> > >>> <philmd@redhat.com> wrote:
> > >>>>
> > >>>> On 7/15/19 1:09 PM, Chih-Min Chao wrote:
> > >>>>> On Mon, Jul 15, 2019 at 5:15 PM Philippe Mathieu-Daud=C3=A9
> > >>>>> <philmd@redhat.com <mailto:philmd@redhat.com>> wrote:
> > >>>>>
> > >>>>>     On 7/15/19 11:08 AM, Chih-Min Chao wrote:
> > >>>>>     > Similar to the mips + malta test, it boots a Linux kernel o=
n
> a virt
> > >>>>>     > board and verify the serial is working.  Also, it relies on
> the serial
> > >>>>>     > device set by the machine itself.
> > >>>>>     >
> > >>>>>     > If riscv64 is a target being built, "make check-acceptance"
> will
> > >>>>>     > automatically include this test by the use of the
> "arch:riscv64" tags.
> > >>>>>     >
> > >>>>>     > Alternatively, this test can be run using:
> > >>>>>     >
> > >>>>>     >   $ avocado run -t arch:riscv64 tests/acceptance
> > >>>>>     >
> > >>>>>     > packages
> > >>>>>     >   debian official
> > >>>>>     >     binutils-riscv64-linux-gnu_2.32-8
> > >>>>>     >     opensbi_0.4-1_all
> > >>>>>     >     linux-image-4.19.0-5-riscv64 4.19.37-4
> > >>>>>     >   third-party
> > >>>>>     >
> > >>>>>
> https://github.com/groeck/linux-build-test/rootfs/riscv64/rootfs.cpio.gz
> > >>>>>     >     (the repo is also used in mips target acceptance)
> > >>>>>     >
> > >>>>>     > Signed-off-by: Chih-Min Chao <chihmin.chao@sifive.com
> > >>>>>     <mailto:chihmin.chao@sifive.com>>
> > >>>>>     > ---
> > >>>>>     >  .travis.yml                            |  2 +-
> > >>>>>     >  tests/acceptance/boot_linux_console.py | 66
> > >>>>>     ++++++++++++++++++++++++++++++++++
> > >>>>>     >  2 files changed, 67 insertions(+), 1 deletion(-)
> > >>>>>     >
> > >>>>>     > diff --git a/.travis.yml b/.travis.yml
> > >>>>>     > index 5d3d6ee..21fcead 100644
> > >>>>>     > --- a/.travis.yml
> > >>>>>     > +++ b/.travis.yml
> > >>>>>     > @@ -232,7 +232,7 @@ matrix:
> > >>>>>     >
> > >>>>>     >      # Acceptance (Functional) tests
> > >>>>>     >      - env:
> > >>>>>     > -        - CONFIG=3D"--python=3D/usr/bin/python3
> > >>>>>
>  --target-list=3Dx86_64-softmmu,mips-softmmu,mips64el-softmmu,aarch64-sof=
tmmu,arm-softmmu,s390x-softmmu,alpha-softmmu"
> > >>>>>     > +        - CONFIG=3D"--python=3D/usr/bin/python3
> > >>>>>
>  --target-list=3Dx86_64-softmmu,mips-softmmu,mips64el-softmmu,aarch64-sof=
tmmu,arm-softmmu,s390x-softmmu,alpha-softmmu,riscv64-softmmu"
> > >>>>>     >          - TEST_CMD=3D"make check-acceptance"
> > >>>>>     >        after_failure:
> > >>>>>     >          - cat tests/results/latest/job.log
> > >>>>>     > diff --git a/tests/acceptance/boot_linux_console.py
> > >>>>>     b/tests/acceptance/boot_linux_console.py
> > >>>>>     > index 3215950..0f638bc 100644
> > >>>>>     > --- a/tests/acceptance/boot_linux_console.py
> > >>>>>     > +++ b/tests/acceptance/boot_linux_console.py
> > >>>>>     > @@ -354,3 +354,69 @@ class BootLinuxConsole(Test):
> > >>>>>     >          self.vm.launch()
> > >>>>>     >          console_pattern =3D 'Kernel command line: %s' %
> > >>>>>     kernel_command_line
> > >>>>>     >          self.wait_for_console_pattern(console_pattern)
> > >>>>>     > +
> > >>>>>     > +    def test_riscv64_virt(self):
> > >>>>>     > +        """
> > >>>>>     > +        :avocado: tags=3Darch:riscv64
> > >>>>>     > +        :avocado: tags=3Dmachine:virt
> > >>>>>     > +        """
> > >>>>>     > +        deb_url =3D ('
> https://snapshot.debian.org/archive/debian/'
> > >>>>>     > +
>  '20190424T171759Z/pool/main/b/binutils/'
> > >>>>>     > +
> > >>>>>      'binutils-riscv64-linux-gnu_2.32-8_amd64.deb')
> > >>>>>     > +        deb_hash =3D
> ('7fe376fd4452696c03acd508d6d613ca553ea15e')
> > >>>>>     > +        deb_path =3D self.fetch_asset(deb_url,
> asset_hash=3Ddeb_hash)
> > >>>>>     > +        objcopy_path =3D '/usr/bin/riscv64-linux-gnu-objco=
py'
> > >>>>>     > +        objcopy_path =3D self.extract_from_deb(deb_path,
> objcopy_path)
> > >>>>>     > +        libbfd_path =3D
> > >>>>>     '/usr/lib/x86_64-linux-gnu/libbfd-2.32-riscv64.so
> > >>>>>     <http://libbfd-2.32-riscv64.so>'
> > >>>>>     > +        libbfd_path =3D self.extract_from_deb(deb_path,
> libbfd_path)
> > >>>>>     > +        process.run('ls -al %s' % (objcopy_path))
> > >>>>>     > +
> > >>>>>     > +        deb_url =3D ('
> https://snapshot.debian.org/archive/debian/'
> > >>>>>     > +                   '20190708T032337Z/pool/main/o/opensbi/'
> > >>>>>     > +                   'opensbi_0.4-1_all.deb')
> > >>>>>     > +        deb_hash =3D
> ('2319dcd702958291d323acf5649fd98a11d90112')
> > >>>>>     > +        deb_path =3D self.fetch_asset(deb_url,
> asset_hash=3Ddeb_hash)
> > >>>>>     > +        opensbi_path =3D
> ('/usr/lib/riscv64-linux-gnu/opensbi/'
> > >>>>>     > +                        'qemu/virt/fw_jump.elf')
> > >>>>>     > +        opensbi_path =3D self.extract_from_deb(deb_path,
> opensbi_path)
> > >>>>>     > +
> > >>>>>     > +        deb_url =3D
> > >>>>>     ('https://snapshot.debian.org/archive/debian-ports/'
> > >>>>>     > +
>  '20190620T095935Z/pool-riscv64/main/l/linux/'
> > >>>>>     > +
> > >>>>>      'linux-image-4.19.0-5-riscv64_4.19.37-4_riscv64.deb')
> > >>>>>     > +        deb_hash =3D
> ('bf5b5680c41d92134d22caef4fbd277c5217e1f0')
> > >>>>>     > +        deb_path =3D self.fetch_asset(deb_url,
> asset_hash=3Ddeb_hash)
> > >>>>>     > +        kernel_path =3D '/boot/vmlinux-4.19.0-5-riscv64'
> > >>>>>     > +        kernel_path =3D self.extract_from_deb(deb_path,
> kernel_path)
> > >>>>>     > +        kimage_path =3D self.workdir + "/Image"
> > >>>>>     > +        env =3D os.environ
> > >>>>>     > +        env['LD_LIBRARY_PATH'] =3D ('%s:' %
> > >>>>>     (os.path.dirname(libbfd_path)) +
> > >>>>>     > +                                 env.get('LD_LIBRARY_PATH'=
,
> ''))
> > >>>>>     > +        process.run(('%s -O binary -O binary -R'
> > >>>>>     > +                     '.note -R .note.gnu.build-id -R
> .comment -S
> > >>>>>     %s %s') %
> > >>>>>     > +                     (objcopy_path, kernel_path,
> kimage_path))
> > >>>>>
> > >>>>>     Please explain why you need to do that...
> > >>>>>
> > >>>>>     Also note these tests are run on other host architecture than
> x86, at
> > >>>>>     least ppc64/s390x (so this won't work there).
> > >>>>>
> > >>>>> it is because riscv64 vmlinux doesn't have physical loading addre=
ss
> > >>>>> information and
> > >>>>> depends on certain stage bootloader to move kernel raw data to
> specific
> > >>>>> physical address (0x8020_0000)
> > >>>>>
> > >>>>> The vmlinux program headers are
> > >>>>>   Type             Offset       VirtAddr                  PhysAdd=
r
> > >>>>>     FileSiz  MemSiz   Flg Align
> > >>>>>   LOAD           0x001000 0xffffffe000000000 0x0000000000000000
> 0x0303a6
> > >>>>> 0x0303a6 R E 0x1000
> > >>>>>   LOAD           0x032000 0xffffffe000031000 0x0000000000031000
> 0x828f0c
> > >>>>> 0x828f0c RWE 0x1000
> > >>>>>   NOTE           0x85aec0 0xffffffe000859ec0 0x0000000000859ec0
> 0x00004c
> > >>>>> 0x00004c R   0x4
> > >>>>>
> > >>>>> For legacy bootloader, bbl, It can handle payload in ELF format.
> > >>>>> However, for the newer OpenSBI, it can only handle raw data and
> > >>>>> debian doesn't provide linux image in raw data format.
> > >>>
> > >>> This doesn't sound right. You should just be able to say -kernel
> > >>> <anything> and it should work. It has worked for me with vmlinux an=
d
> > >>> Image files when using master (not the 4.0 release but master/4.1).
> > >>> Although all of my testing was with the 5.1 kernel, so maybe there =
is
> > >>> a difference there?
> > >>>
> > >>> What isn't working for you? Can you include the errors and output o=
f
> -d in_asm?
> > >>>
> > >>>
> > >>> Alistair
> > >>
> > >>
> > >> Hi Alistair,
> > >>    I have come across error before starting target simulation.  What
> I means is to execute
> > >>             qemu-system-riscv64 -M virt -m 256M -nographic -bios
> ./opensbi/build/platform/qemu/virt/firmware/fw_jump.elf -kernel vmlinux
> > >>    then get the error message
> > >>             rom: requested regions overlap (rom mrom.reset.
> free=3D0x000000000001eb7c, addr=3D0x0000000000001000)
> > >>             qemu-system-riscv64: rom check and register reset failed
> > >
> > > Hmmm.... I don't remember seeing this problem in my testing, but it
> > > does seem to make sense.
> > >
> > > We have two options here:
> > > 1. Use the Image file from Linux 5.0+ (my preferred option as 4.19 is
> > > getting old)
>
 I choose 4.19 version rather than 5.0+  because 4.19 is stable branch
maintained by Greg.
 But it is ok to use 5.0 trunk, the latest version provided by debian.


> > > 2. Use the device loader (documented here:
> > >
> https://github.com/riscv/opensbi/blob/master/docs/platform/qemu_virt.md)
>

The document describes two user cases
  1. fw_payload.elf
      a. include the Image (raw data file, not elf)  into data section
      b. -kernel load the each part to the correct address

     the program header of  fw_payload.elf are
     Type           Offset   VirtAddr           PhysAddr           FileSiz
 MemSiz   Flg Align
    LOAD           0x0000b0 0x0000000080000000 0x0000000080000000 0x00a008
0x00b0b8 RWE 0x10               <-  fw_payload  main program
    LOAD           0x00a0b8 0x0000000080200000 0x0000000080200000 0x8dbe20
0x8dbe20 R E 0x1                    <-  arch/riscv/boot/Image   or
u-boot.bin

  2. fw_jump.elf
      a. use  "-kernel <raw image> or -device  loader,file=3D<raw
Image>,addr=3D0x80200000" to load correct address
      b. fw_jump.elf just jump to the entry address 0x80200000


 The issues are
   a. debian linux-image package only provides vmlinux.
       so I use objcopy in acceptance test
   b. riscv64 vmlinux doesn't have correct PhysAddr and -kernel can't move
data to expected address
       explicit load the Image to specific
           -kernel raw_image   (if file is not elf or uImage,
riscv_kerner_loader treat it is as raw image and place it at 0x8020_0000)
           -device loader,file=3D<raw_image>,0x80200000  (do the same thing=
)

  ELF should work only if it has correct loading information.

  chihmin.chao

> >
> > Nice doc, this example is exactly what I had in mind:
> >
> >   qemu-system-riscv64 -M virt -m 256M -nographic \
> >         -kernel build/platform/qemu/virt/firmware/fw_jump.elf \
> >         -device
> >
> loader,file=3D<linux_build_directory>/arch/riscv/boot/Image,addr=3D0x8020=
0000 \
> >         -drive file=3D<path_to_linux_rootfs>,format=3Draw,id=3Dhd0 \
> >         -device virtio-blk-device,drive=3Dhd0 \
> >         -append "root=3D/dev/vda rw console=3DttyS0"
> >
> > If the Image is an ELF, I assume we don't need to specify the address,
> > because the device loader knows how to parse this format. Again,
> > Alistair is the expert ;)
>
> Yep, an elf should just work.
>
>  describe the issue above


> >
> > If for some reason it only works with Linux 5.0+, let's use these!
>
> Only 5.0+ builds an elf.
>
> Alistair
>
> >
> > Regards,
> >
> > Phil.
>
