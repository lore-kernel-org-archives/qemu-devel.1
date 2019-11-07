Return-Path: <SRS0=+ldK=Y7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13FE5C5DF61
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2019 10:12:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D17A92084D
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2019 10:12:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="er4dyb2M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D17A92084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40386 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSelz-0004xx-VQ
	for qemu-devel@archiver.kernel.org; Thu, 07 Nov 2019 05:12:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34400)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lersek@redhat.com>) id 1iSekx-0004I9-6i
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 05:11:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <lersek@redhat.com>) id 1iSekv-0007Yr-Re
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 05:11:11 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:23779
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <lersek@redhat.com>) id 1iSekv-0007TI-Mj
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 05:11:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573121468;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=yixX++/py6sBiSFVMQI6sWWGNBpLZUyIFn2qkegtNzk=;
 b=er4dyb2MgWEVXHApUvDuWQxRRFvOq5nGijwISAHXU6kd9V3bWNMtSPt6Vfb0pkSRJRQUqb
 UYw3ZsmPuyOJCynkcKabYMjy8Q1K9PagwBfk0W+yfGbXD7VsTQ/WKMjRCI/G7VkkHSil9+
 xgQ0UtjoNakre8oFFyB0HwzF8teNMRM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-169-s2mQSKbhPb2xPe-Wi4EvOg-1; Thu, 07 Nov 2019 05:11:05 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C2FBB477;
 Thu,  7 Nov 2019 10:11:03 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (unknown [10.36.118.71])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 647E3608B4;
 Thu,  7 Nov 2019 10:10:58 +0000 (UTC)
To: qemu devel list <qemu-devel@nongnu.org>
From: Laszlo Ersek <lersek@redhat.com>
Subject: privileged entropy sources in QEMU/KVM guests
Message-ID: <03e769cf-a5ad-99ce-cd28-690e0a72a310@redhat.com>
Date: Thu, 7 Nov 2019 11:10:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: s2mQSKbhPb2xPe-Wi4EvOg-1
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
 Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 Jian J Wang <jian.j.wang@intel.com>,
 edk2-devel-groups-io <devel@edk2.groups.io>,
 Bret Barkelew <Bret.Barkelew@microsoft.com>,
 Erik Bjorge <erik.c.bjorge@intel.com>, Sean Brogan <sean.brogan@microsoft.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

related TianoCore BZ:

  https://bugzilla.tianocore.org/show_bug.cgi?id=3D1871

(I'm starting this thread separately because at least some of the topics
are specific to QEMU, and I didn't want to litter the BZ with a
discussion that may not be interesting to all participants CC'd on the
BZ. I am keeping people CC'd on this initial posting; please speak up if
you'd like to be dropped from the email thread.)

QEMU provides guests with the virtio-rng device, and the OVMF and
ArmVirtQemu* edk2 platforms build EFI_RNG_PROTOCOL on top of that
device. But, that doesn't seem enough for all edk2 use cases.

Also, virtio-rng (hence EFI_RNG_PROTOCOL too) is optional, and its
absence may affect some other use cases.


(1) For UEFI HTTPS boot, TLS would likely benefit from good quality
entropy. If the VM config includes virtio-rng (hence the guest firmware
has EFI_RNG_PROTOCOL), then it should be used as a part of HTTPS boot.

However, what if virtio-rng (hence EFI_RNG_PROTOCOL) are absent? Should
UEFI HTTPS boot be disabled completely (or prevented / rejected
somehow), blaming lack of good entropy? Or should TLS silently fall back
to "mixing some counters [such as TSC] together and applying a
deterministic cryptographic transformation"?

IOW, knowing that the TLS setup may not be based on good quality
entropy, should we allow related firmware services to "degrade silently"
(not functionally, but potentially in security), or should we deny the
services altogether?


(2) It looks like the SMM driver implementing the privileged part of the
UEFI variable runtime service could need access to good quality entropy,
while running in SMM; in the future.

This looks problematic on QEMU. Entropy is a valuable resource, and
whatever resource SMM drivers depend on, should not be possible for e.g.
a 3rd party UEFI driver (or even for the runtime OS) to exhaust.
Therefore, it's not *only* the case that SMM drivers must not consume
EFI_RNG_PROTOCOL (which exists at a less critical privilege level, i.e.
outside of SMM/SMRAM), but also that SMM drivers must not depend on the
same piece of *hardware* that feeds EFI_RNG_PROTOCOL.

Furthermore, assuming we dedicate a hardware entropy device specifically
to SMM drivers, such a device cannot be PCI(e). It would have to be a
platform device at a fixed location (IO port or MMIO) that is only
accessible to such guest code that executes in SMM. IOW, device access
would have to be restricted similarly to pflash. (In fact the variable
SMM driver will need, AIUI, the entropy for encrypting various variable
contents, which are then written into pflash.)

Alternatively, CPU instructions could exist that return entropy, and are
executable only inside SMM. It seems that e.g. RDRAND can be trapped in
guests ("A VMEXIT due to RDRAND will have exit reason 57 (decimal)").
Then KVM / QEMU could provide any particular implementation we wanted --
for example an exception could be injected unless RDRAND had been
executed from within SMM. Unfortunately, such an arbitrary restriction
(of RDRAND to SMM) would diverge from the Intel SDM, and would likely
break other (non-SMM) guest code.

Does a platform device that is dynamically detectable and usable in SMM
only seem like an acceptable design for QEMU?

Thanks,
Laszlo


