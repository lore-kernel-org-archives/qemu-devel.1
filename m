Return-Path: <SRS0=+ldK=Y7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BFC6C5DF60
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2019 15:12:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A914218AE
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2019 15:12:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N3TBWWJt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A914218AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44208 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSjSq-0005D5-Cn
	for qemu-devel@archiver.kernel.org; Thu, 07 Nov 2019 10:12:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56455)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lersek@redhat.com>) id 1iSjS4-0004nh-Ep
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 10:12:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <lersek@redhat.com>) id 1iSjS0-00066I-6C
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 10:11:59 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:31670
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <lersek@redhat.com>) id 1iSjRy-00064x-4u
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 10:11:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573139512;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tR8j7H7aiTkwStKNBO6ykFl34JCmHQB2Pm7zfoFSfyo=;
 b=N3TBWWJtpy+laauPEvFk1xCkhb2NwaVCZnM4hec+qlrkhLRghulGqihnSGC4l7OMCgLnwe
 IZiGAYdHNVwilt5mZ+CKt4aaVhWV0g/ysK37Q5EidyHieDWIDUg3EQuTK1tVkbyJXzAVnI
 ruDZ1778Z7kivyDbKyobaYsKYsX1yUQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-249-PUk9OG7rPc295j8UsY94yw-1; Thu, 07 Nov 2019 10:11:48 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 354FC8017DD;
 Thu,  7 Nov 2019 15:11:47 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (unknown [10.36.118.71])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D43A01001B34;
 Thu,  7 Nov 2019 15:11:39 +0000 (UTC)
Subject: Re: privileged entropy sources in QEMU/KVM guests
To: Paolo Bonzini <pbonzini@redhat.com>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>
References: <03e769cf-a5ad-99ce-cd28-690e0a72a310@redhat.com>
 <CAKv+Gu8gqfu_mOm2zK64dmj5CkVaPvix3gEMEFQScyk1CnOv6w@mail.gmail.com>
 <ef126cd5-7b64-1b8a-ca74-11bd06b5f4b1@redhat.com>
 <421cf4ef-ea84-c7e6-81aa-c24a91459de5@redhat.com>
 <659cd76f-2f46-1e08-342b-ee2fa0877fd8@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <2a14b9f5-e268-b711-279d-a58bf28b201d@redhat.com>
Date: Thu, 7 Nov 2019 16:11:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <659cd76f-2f46-1e08-342b-ee2fa0877fd8@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: PUk9OG7rPc295j8UsY94yw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: "Daniel P. Berrange" <berrange@redhat.com>,
 Jian J Wang <jian.j.wang@intel.com>,
 edk2-devel-groups-io <devel@edk2.groups.io>,
 Bret Barkelew <Bret.Barkelew@microsoft.com>,
 qemu devel list <qemu-devel@nongnu.org>, Erik Bjorge <erik.c.bjorge@intel.com>,
 Sean Brogan <sean.brogan@microsoft.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/07/19 14:58, Paolo Bonzini wrote:
> On 07/11/19 14:27, Laszlo Ersek wrote:
>> The VirtioRngDxe driver is a UEFI driver that follows the UEFI driver
>> model. Meaning (in this context), it is connected to the virtio-rng
>> device in the BDS phase, by platform BDS code.
>>
>> Put differently, the non-privileged driver that's the source of the
>> sensitive data would have to be a "platform DXE driver". The virtio
>> drivers are not such drivers however.
>=20
> Yes, it would have to be a platform DXE driver.  What is it that limits
> virtio to the BDS phase?

For virtio-pci, we have:

- The PCI host bridge / root bridge driver, which is a platform DXE
driver, and produces PCI Root Bridge IO Protocol instances in its entry
point.

- The PCI bus driver, which is a UEFI driver that follows the UEFI
driver model. It only does its actual job when BDS connects it to the
PCI Root Bridge IO Protocol instances mentioned above. At that point,
the PCI bus driver produces a bunch of PCI IO protocol instances.

- The virtio 0.9.5 and virtio 1.0 PCI transport drivers. They are also
UEFI drivers that follow the UEFI driver model. They bind PCI IO
protocol instances when BDS says so, and produce VIRTIO_DEVICE_PROTOCOL
instances.

- The actual virtio device drivers (scsi, blk, net, rng, gpu) that bind
VIRTIO_DEVICE_PROTOCOL instances, when BDS says so, and produce the
use-case specific UEFI protocols (such as SCSI pass-thru, Block IO,
Simple Network, RNG, and Graphics Output).


For virtio-mmio, we have (on ARM only):

- a platform DXE driver that enumerates the virtio-mmio transports, in
its entry point function, based on the DTB that QEMU exposes. Each
register block / transport is turned into a VIRTIO_DEVICE_PROTOCOL
instances.

- The actual virtio device drivers (scsi, blk, net, rng, gpu) that bind
VIRTIO_DEVICE_PROTOCOL instances, when BDS says so, and produce the
use-case specific UEFI protocols (such as SCSI pass-thru, Block IO,
Simple Network, RNG, and Graphics Output).


UEFI drivers that follow the UEFI driver model allow BDS to orchestrate
device binding, and don't generally do anything unless called from BDS.

Platform DXE drivers do their job in their entry point functions. If
they have protocol dependencies, then they either spell that out as a
DEPEXes (dependency expressions, honored by the DXE Core during driver
dispatch), or else they operate with low-level protocol notification
callbacks (=3D they automatically take action, regardless of BDS, when a
particular protocol appears in the system). They produce their own
protocols in their entry point functions, or else in said protocol
notify callbacks, without being asked to by BDS.

UEFI-2.* strongly encourages device driver authors to structure their
drivers as such UEFI drivers that follow the UEFI driver model, and not
as platform DXE drivers.


A core idea in BDS is that the largest possible set of devices should
*not* be bound by drivers. If we don't connect anything that we don't
intend to boot off of (and don't need for other booting purposes [*],
then that makes for a speedy & frugal boot.

[*] such as console drivers (keyboard, serial, graphics), or RNG
drivers, ...

The set of devices connected by BDS is, by design, platform policy. When
the device drivers follow the UEFI driver model, platform BDS can manage
a large herd of 3rd party UEFI drivers, and only bind the set of devices
that's actually necessary.

When most device drivers are platform DXE drivers, all doing whatever
they want, and all acting on their own dependencies, it's very difficult
to express or implement a similar policy in a central component.


In OvmfPkg and ArmVirtPkg, we originally connected all drivers to all
devices. That was safe, but not too fast (especially when you had tens
or hundreds of virtio devices in the system). Nowadays, we connect only
what we really need for booting. That selection / binding procedure is
driven by the "bootorder" fw_cfg file from QEMU.

https://lists.01.org/hyperkitty/list/edk2-devel@lists.01.org/message/UAYFGP=
OQVI4FSHTU6MDLA6ULMUWSQ5HJ/

This selection is so effective that, when we first implemented it, we
actually stopped binding the virtio RNG device. (It was a regression --
I think the kernel's UEFI stub consumes it, if it's available, and we
noticed that the stub started complaining.) That happened because
virtio-rng is never a *bootable* device, and so it's never listed in the
"bootorder" fw_cfg file. Therefore we had to add custom BDS code to bind
virtio RNG devices "forcibly".

https://github.com/tianocore/edk2/commit/7ebad830d6ab6


Now, technically speaking, we could rewrite VirtioRngDxe to be a
platform DXE driver. It would register a protocol notify callback for
VIRTIO_DEVICE_PROTOCOL, it would investigate every such protocol
instance as they appeared in the protocol database, and bind whichever
was a virtio-rng device.

It wouldn't make a difference in the end, because the virtio PCI
transport drivers (producing VIRTIO_DEVICE_PROTOCOL) themselves are UEFI
drivers that follow the UEFI driver model. Thus, they are "kicked" by BDS.

The PCI Bus driver itself (producing the PCI IO instances that the
virtio PCI transport drivers bind) is itself a UEFI Driver that follows
the UEFI driver model. Thus, that too is set in motion by BDS.

--*--

Nonetheless, we might be able to make this work, with a not too terrible
hack.

- In "OvmfPkg/Library/PlatformBootManagerLib/BdsPlatform.c", hoist the
virtio-rng binding from the end of the
PlatformBootManagerBeforeConsole() function, to just before signaling
End-of-Dxe.

- in the constructor function of OVMF's new SMM-oriented RngLib
instance, register a protocol notify for EFI_RNG_PROTOCOL. Also register
an event notification function for End-of-Dxe.

- In the EFI_RNG_PROTOCOL callback, fetch the seed (and make a note that
the seed has been fetched). Uninstall the same callback.

- In the End-of-Dxe event notification callback, check if the seed has
been fetched. If not, hang the system. (We must not exit the DXE phase
without having a seed.)

- In the RngLib APIs that provide randomness to the caller (and so
depend on a seed having been fetched), hang the system if the seed has
not been fetched. This will never fire if the first such API call is
made at, or after, End-of-Dxe (see above), but it could fire if the API
is called earlier. For example, if the variable SMM driver actually
needed some randomness before the system reaches End-of-Dxe.

I'll take this last design question back to the TianoCore BZ -- can we
expect the SMM drivers to fetch the seed at EndOfDxe (and not earlier)?
Because the EFI_RNG_PROTOCOL instances that are present in the system
*by then* can be trusted to provide the seed.

Thanks,
Laszlo


