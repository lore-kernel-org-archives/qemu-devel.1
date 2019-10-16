Return-Path: <SRS0=/TIv=YJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C059FA3728
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Oct 2019 16:36:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA4712168B
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Oct 2019 16:36:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PU0oxjhs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA4712168B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45458 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iKmHr-0008VW-Pu
	for qemu-devel@archiver.kernel.org; Wed, 16 Oct 2019 12:36:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34479)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@gmail.com>) id 1iKmDO-0005QI-4g
 for qemu-devel@nongnu.org; Wed, 16 Oct 2019 12:31:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@gmail.com>) id 1iKmDM-0001Nv-DV
 for qemu-devel@nongnu.org; Wed, 16 Oct 2019 12:31:57 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:33415)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
 id 1iKmDM-0001NT-7I
 for qemu-devel@nongnu.org; Wed, 16 Oct 2019 12:31:56 -0400
Received: by mail-wm1-x342.google.com with SMTP id r17so5058174wme.0
 for <qemu-devel@nongnu.org>; Wed, 16 Oct 2019 09:31:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=g/8orlTVEmu6WEC/k+mTbnT8T8wetKSepjnvXGf1ACg=;
 b=PU0oxjhs8E2SZB7J2NXIDtB8EZnpIbTvGcWioJpozUnFuYgQiJTRyLFK3oEjAuk+XA
 Ax3dSqZ/50oC9IBBI5qIwxN7O45Gdp3NldTUlQ3peyUSAxmcLFOgneQDTt75bfmZSlZe
 DpCKbdbLwcM/UUg2Eop3uNLCdN8gP57ipoR2Dd3gni1wVf4BIg0nCzTg05cOQnGpuYAA
 eoc5WxjieQJegxjx0wzdCrPpVG3XPoelXqHbcIEqzttEshnQW6/IwLG8dAa+Tq6jAJCE
 yrDTXBHPjjuOm5MWCNDD2uI7PDsfhdoI7EMkhfJ25Yu7v1TDEWZcWo0tWl/B0Gq6VxdM
 LHXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=g/8orlTVEmu6WEC/k+mTbnT8T8wetKSepjnvXGf1ACg=;
 b=j89L6fqiTqFn/5ahkhsKJFNqGv8J2XtDo11vtYQM9aXEKOVsi4b/NT7SGf4wvaHugT
 XxQPUO7CD0279AjgzMK1KJk+fNuY1jMoM9oiCffz6r/Or++4rWtMoCwJbDd7B5rR0PTR
 wJ1O/3axRjRqSicd6Z1jlnxN7/5DLpgCPoj7O6PVbYW+YBdSauyXWR7hcmOrE0g7Ejt7
 PR3PEBuGmOSLBuq4a9quVxjGJKzUL/n4LlWgpGA2He/+YcDGv4FDaRvnyvDRqHz5kNYU
 EzWH1Osl8io45T/oPfb0EJ0ancPfvoPaRW6/YhSuWv7ora62iLlkYNIaPEu/uVV2L3Zn
 zJCw==
X-Gm-Message-State: APjAAAVMy/R8iex3ioh4zibChFcZBhyaasAZNSDHZbLP4ZBjud9wSjeK
 0PK15TUoEf/n72NVM52FoI9cHJu51647KFG69yI=
X-Google-Smtp-Source: APXvYqz91880f2YRD4yiRUCQjfgK/SqVFWh2iMWvLYWWwRW9Kmjg74XlDeLGnJmcvq8rMMPnyPYT75GMkeqIKSpCcbI=
X-Received: by 2002:a7b:c395:: with SMTP id s21mr4430559wmj.114.1571243514826; 
 Wed, 16 Oct 2019 09:31:54 -0700 (PDT)
MIME-Version: 1.0
References: <20191016101241.24405-1-slp@redhat.com>
 <20191016101241.24405-14-slp@redhat.com>
In-Reply-To: <20191016101241.24405-14-slp@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 16 Oct 2019 18:31:42 +0200
Message-ID: <CAJ+F1CJK51sDUKsAp5z7UOSyb-+GbWHR19hk2wr1qW4THZc-RA@mail.gmail.com>
Subject: Re: [PATCH v10 13/15] docs/microvm.rst: document the new microvm
 machine type
To: Sergio Lopez <slp@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>, groug@kaod.org,
 QEMU <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>, Laszlo Ersek <lersek@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi

On Wed, Oct 16, 2019 at 12:19 PM Sergio Lopez <slp@redhat.com> wrote:
>
> Document the new microvm machine type.
>
> Signed-off-by: Sergio Lopez <slp@redhat.com>
> Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  docs/microvm.rst | 98 ++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 98 insertions(+)
>  create mode 100644 docs/microvm.rst
>
> diff --git a/docs/microvm.rst b/docs/microvm.rst
> new file mode 100644
> index 0000000000..0aab55576c
> --- /dev/null
> +++ b/docs/microvm.rst
> @@ -0,0 +1,98 @@
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +microvm Machine Type
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +``microvm`` is a machine type inspired by ``Firecracker`` and
> +constructed after its machine model.
> +
> +It's a minimalist machine type without ``PCI`` nor ``ACPI`` support,
> +designed for short-lived guests. microvm also establishes a baseline
> +for benchmarking and optimizing both QEMU and guest operating systems,
> +since it is optimized for both boot time and footprint.
> +
> +
> +Supported devices
> +-----------------
> +
> +The microvm machine type supports the following devices:
> +
> +- ISA bus
> +- i8259 PIC (optional)
> +- i8254 PIT (optional)
> +- MC146818 RTC (optional)
> +- One ISA serial port (optional)
> +- LAPIC
> +- IOAPIC (with kernel-irqchip=3Dsplit by default)
> +- kvmclock (if using KVM)
> +- fw_cfg
> +- Up to eight virtio-mmio devices (configured by the user)
> +
> +
> +Using the microvm machine type
> +------------------------------
> +
> +Machine-specific options
> +~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +It supports the following machine-specific options:
> +
> +- microvm.x-option-roms=3Dbool (Set off to disable loading option ROMs)
> +- microvm.pit=3DOnOffAuto (Enable i8254 PIT)
> +- microvm.isa-serial=3Dbool (Set off to disable the instantiation an ISA=
 serial port)
> +- microvm.pic=3DOnOffAuto (Enable i8259 PIC)
> +- microvm.rtc=3DOnOffAuto (Enable MC146818 RTC)
> +- microvm.auto-kernel-cmdline=3Dbool (Set off to disable adding virtio-m=
mio devices to the kernel cmdline)
> +
> +
> +Boot options
> +~~~~~~~~~~~~
> +
> +By default, microvm uses ``qboot`` as its BIOS, to obtain better boot
> +times, but it's also compatible with ``SeaBIOS``.
> +
> +As no current FW is able to boot from a block device using
> +``virtio-mmio`` as its transport, a microvm-based VM needs to be run
> +using a host-side kernel and, optionally, an initrd image.
> +
> +
> +Running a microvm-based VM
> +~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +By default, microvm aims for maximum compatibility, enabling both
> +legacy and non-legacy devices. In this example, a VM is created
> +without passing any additional machine-specific option, using the
> +legacy ``ISA serial`` device as console::
> +
> +  $ qemu-system-x86_64 -M microvm \
> +     -enable-kvm -cpu host -m 512m -smp 2 \
> +     -kernel vmlinux -append "earlyprintk=3DttyS0 console=3DttyS0 root=
=3D/dev/vda" \
> +     -nodefaults -no-user-config -nographic \
> +     -serial stdio \
> +     -drive id=3Dtest,file=3Dtest.img,format=3Draw,if=3Dnone \
> +     -device virtio-blk-device,drive=3Dtest \
> +     -netdev tap,id=3Dtap0,script=3Dno,downscript=3Dno \
> +     -device virtio-net-device,netdev=3Dtap0
> +
> +While the example above works, you might be interested in reducing the
> +footprint further by disabling some legacy devices. If you're using
> +``KVM``, you can disable the ``RTC``, making the Guest rely on
> +``kvmclock`` exclusively. Additionally, if your host's CPUs have the
> +``TSC_DEADLINE`` feature, you can also disable both the i8259 PIC and
> +the i8254 PIT (make sure you're also emulating a CPU with such feature
> +in the guest).
> +
> +This is an example of a VM with all optional legacy features
> +disabled::
> +
> +  $ qemu-system-x86_64 \
> +     -M microvm,x-option-roms=3Doff,pit=3Doff,pic=3Doff,isa-serial=3Doff=
,rtc=3Doff \
> +     -enable-kvm -cpu host -m 512m -smp 2 \
> +     -kernel vmlinux -append "console=3Dhvc0 root=3D/dev/vda" \
> +     -nodefaults -no-user-config -nographic \
> +     -chardev stdio,id=3Dvirtiocon0,server \

server? doesn't make sense here :)

> +     -device virtio-serial-device \
> +     -device virtconsole,chardev=3Dvirtiocon0 \
> +     -drive id=3Dtest,file=3Dtest.img,format=3Draw,if=3Dnone \
> +     -device virtio-blk-device,drive=3Dtest \
> +     -netdev tap,id=3Dtap0,script=3Dno,downscript=3Dno \
> +     -device virtio-net-device,netdev=3Dtap0
> --
> 2.21.0
>
>

seem to work with appropriate kernel otherwise, so
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

--=20
Marc-Andr=C3=A9 Lureau

