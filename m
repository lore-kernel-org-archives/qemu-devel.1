Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAB3AC83001
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 07:10:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B36442082E
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 07:10:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BhDEobYp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B36442082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37870 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jU3LB-0005ss-Rf
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 03:10:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33054)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jU3KQ-0004x7-UL
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 03:09:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jU3KQ-0008Tz-3Y
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 03:09:50 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:48651
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jU3KP-0008Tq-MN
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 03:09:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588230588;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5gA/7Cwa1XumlWSW+O+uf+C+wZsm/4eJzoxl9niMGNA=;
 b=BhDEobYpJZ5lCwkR1C+MgcPViwugDqqmboUNm+XZWfcHdYXGanSHgcDCgmSR4ZXWil4qzZ
 2cDrTCwyTosXh08sJ8V+JMo/l1XN9FfTOlfelgT3EN1bND4S/DqZ31DbiPE6ZVH6k5xTZn
 hHJPavbXDmmU6m8TJsndCgcjHFhyNJ0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-1-QgrB6kllNbeZD5yKF9ucRA-1; Thu, 30 Apr 2020 03:09:46 -0400
X-MC-Unique: QgrB6kllNbeZD5yKF9ucRA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A3099462;
 Thu, 30 Apr 2020 07:09:45 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-113-6.ams2.redhat.com [10.36.113.6])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 99A6E5D9F1;
 Thu, 30 Apr 2020 07:09:42 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 28AAA11358BC; Thu, 30 Apr 2020 09:09:41 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Subject: Re: Failing property setters + hardwired devices + -global = a bad day
References: <87mu6uia5i.fsf@dusky.pond.sub.org>
 <20200429155719.GL1495129@redhat.com>
Date: Thu, 30 Apr 2020 09:09:41 +0200
In-Reply-To: <20200429155719.GL1495129@redhat.com> ("Daniel P. =?utf-8?Q?B?=
 =?utf-8?Q?errang=C3=A9=22's?=
 message of "Wed, 29 Apr 2020 16:57:19 +0100")
Message-ID: <87k11xh2kq.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.81; envelope-from=armbru@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/30 01:31:09
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>, Jason Wang <jasowang@redhat.com>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> On Wed, Apr 29, 2020 at 05:28:25PM +0200, Markus Armbruster wrote:
>> Is there any sane use for configuring backends via any of the default
>> mechanisms?
>>=20
>> I'm aware of one, but it's outdated: -global isa-fdc.driveA=3D...  Use
>> -device floppy instead.
>>=20
>> I'd love to deprecate -global wholesale, but we can't as long as we
>> don't have better means to configure onboard devices.  Can we deprecate
>> its use with backend properties at least?
>
> Currently libvirt has code using the following

Useful, thanks!

> * Floppy
>
>   -global isa-fdc.driveA=3DID
>   -global isa-fdc.driveB=3DID
>   -global isa-fdc.bootindexA=3DNN
>   -global isa-fdc.bootindexB=3DNN
>
>   Only used when the machine type is pc-q35-2.4 or earlier

This is qemuBuildFloppyCommandLineControllerOptions().  I'm not sure I
follow the logic there.

Two compatibility issues are relevant to floppies:

* Onboard isa-fdc

  We dropped the onboard isa-fdc for certain machine types (commit
  ea96bc629c "i386: drop FDC in pc-q35-2.4+ if neither it nor floppy
  drives are wanted", v2.4.0).  To get one, use -device isa-fdc of
  -drive if=3Dfloppy,...

  The upstream machine types are pc-q35-2.4 or later.  Downstreams are
  free to do the same for their machine types.

  qemuDomainMachineNeedsFDC() returns true for x86 machine types other
  than pc-q35-{1.,2.0,2.1,2.2,2.3}*

  Your "when the machine type is pc-q35-2.4 or earlier" appears to be
  off by one.

  When libvirt decides to use -device isa-fdc, it sensibly puts the
  driveA=3D... and driveB=3D... bits there rather than in -global isa-fdc..=
.

  Libvirt still uses -global for machine types with an onboard isa-fdc.

* -device floppy

  We support configuring floppy drives with -device (commit a92bd191a4
  "fdc: Move qdev properties to FloppyDrive", v2.8.0).

  This permits

    -device isa-fdc,FDC-OPTS...
    -device floppy unit=3D0,drive=3DBACKEND,FLOPPY-OPTS...

  in addition to the old

    -device isa-fdc,driveA=3DBACKEND,FDC_OPTS...

  or the even older

    -global isa-fdc.driveA=3DBACKEND,FDC_OPTS...

  which both rely on black magic in device isa-fdc to automatically
  create the floppy device.

  Same for driveB / unit=3D0, of course.

  I expect us to deprecate isa-fdc's driveA and driveB some day.

  Its replacement lets you avoid -global even for machine types with an
  onboard isa-fdc.

  To detect it, check whether device "floppy" exists.

> * NVRAM
>
>   -global spapr-nvram.reg=3D0xnnnn

Onboard device of the pseries-* machine type family.

Our means to configure onboard devices are weak.  We sidestepped this
for isa-fdc by taking it off the board, and thus make -device work.

I investigated doing the same for onboard flash memory, but Paolo
convinced me to do something else instead: add machine properties that
alias the onboard devices' properties.  Commit ebc29e1beab explains all
this, if you're curious.

If we do the same here, we can replace -global spapr-nvram.reg=3D... by
something like -machine nvram-reg=3D...

> * Video primary display adapter
>
>   -global qxl-vga.ram_size=3DNN
>   -global qxl-vga.vram_size=3DNN
>   -global qxl-vga.vram64_size=3DNN
>   -global qxl-vga.vgamem_mb=3DNN
>   -global qxl-vga.max_outputs=3DNN
>   -global VGA.vgamem_mb=3DMM
>   -global vmware-svga.vgamem_mb=3DMM
>
>   Only used for old qemu lacking -device support where we must use -vga
>   instead

Solution: wait for libvirt to notice QEMU lacking -device is long dead
and buried.

> * PIT policy
>
>    -global kvm-pit.lost_tick_policy=3DXXX

Onboard device, same solution as for NVRAM.

Note that the board uses either isa-pit or kvm-pit, depending on
configuration.  Might complicate things a bit.

> * S3/S4
>
>    -global PIIX4_PM.disable_s3=3DNNN
>    -global PIIX4_PM.disable_s4=3DNNN
>    -global ICH9-LPC.disable_s3=3DNNN
>    -global ICH9-LPC.disable_s4=3DNNN
>
> * PCI hole
>
>    -global i440FX-pcihost.pci-hole64-size=3DNNN
>    -global q35-pcihost.pci-hole64-size=3DNNN
>
> * SMM TSeg
>
>    -global mch.extended-tseg-mbytes=3DNNN
>
> * pflash
>
>    -global driver=3Dcfi.pflash01,property=3Dsecure,value=3Don
>
>   Used for EFI secure boot

Onboard devices, same solution as for NVRAM, I guess.

> I'm unclear which of these can be replaced with a different QEMU cli
> option....

Mostly "not yet", I think.


