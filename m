Return-Path: <SRS0=+ldK=Y7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F793C5DF61
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2019 11:38:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CEA372084D
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2019 11:38:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c/UcX2xW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CEA372084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41150 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSg7I-00050j-0C
	for qemu-devel@archiver.kernel.org; Thu, 07 Nov 2019 06:38:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50416)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1iSg5k-0003Of-Hq
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 06:36:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1iSg5h-0001Z0-M4
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 06:36:44 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:34018
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1iSg5h-0001Yt-HQ
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 06:36:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573126601;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=t2ff9+c6qAfukn4g0vL5C9Jaj893i/GSBuXfsdxKY2Y=;
 b=c/UcX2xWFx+kz7J7uqvmr1FTUhEsXmI7w3xShXsAwhdQMMT0SrguxGXgk1XHVzIMiT3DGL
 jnYATQEzNXooqcEEkGJqi9Wyzv+X3+XSxYerWz6oz3GQxvJkvAnim+PmeYTd0Zl4Ow+von
 zY0lUc4rxPpTi7tGr4d7+5TaOxKrDdM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-45-SWHPe2vdP16rmgkogmQUKg-1; Thu, 07 Nov 2019 06:36:37 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D30651800D7A;
 Thu,  7 Nov 2019 11:36:35 +0000 (UTC)
Received: from work-vm (unknown [10.36.118.14])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E5D6D19757;
 Thu,  7 Nov 2019 11:36:29 +0000 (UTC)
Date: Thu, 7 Nov 2019 11:36:27 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Laszlo Ersek <lersek@redhat.com>
Subject: Re: privileged entropy sources in QEMU/KVM guests
Message-ID: <20191107113627.GF2816@work-vm>
References: <03e769cf-a5ad-99ce-cd28-690e0a72a310@redhat.com>
 <20191107101832.GA2817@work-vm>
 <37168ef5-2ae1-4e95-1709-6eddf8f6cc12@redhat.com>
MIME-Version: 1.0
In-Reply-To: <37168ef5-2ae1-4e95-1709-6eddf8f6cc12@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: SWHPe2vdP16rmgkogmQUKg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
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
 qemu devel list <qemu-devel@nongnu.org>, Erik Bjorge <erik.c.bjorge@intel.com>,
 Sean Brogan <sean.brogan@microsoft.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Laszlo Ersek (lersek@redhat.com) wrote:
> On 11/07/19 11:18, Dr. David Alan Gilbert wrote:
> > * Laszlo Ersek (lersek@redhat.com) wrote:
> >> Hi,
> >>
> >> related TianoCore BZ:
> >>
> >>   https://bugzilla.tianocore.org/show_bug.cgi?id=3D1871
> >>
> >> (I'm starting this thread separately because at least some of the topi=
cs
> >> are specific to QEMU, and I didn't want to litter the BZ with a
> >> discussion that may not be interesting to all participants CC'd on the
> >> BZ. I am keeping people CC'd on this initial posting; please speak up =
if
> >> you'd like to be dropped from the email thread.)
> >>
> >> QEMU provides guests with the virtio-rng device, and the OVMF and
> >> ArmVirtQemu* edk2 platforms build EFI_RNG_PROTOCOL on top of that
> >> device. But, that doesn't seem enough for all edk2 use cases.
> >>
> >> Also, virtio-rng (hence EFI_RNG_PROTOCOL too) is optional, and its
> >> absence may affect some other use cases.
> >>
> >>
> >> (1) For UEFI HTTPS boot, TLS would likely benefit from good quality
> >> entropy. If the VM config includes virtio-rng (hence the guest firmwar=
e
> >> has EFI_RNG_PROTOCOL), then it should be used as a part of HTTPS boot.
> >>
> >> However, what if virtio-rng (hence EFI_RNG_PROTOCOL) are absent? Shoul=
d
> >> UEFI HTTPS boot be disabled completely (or prevented / rejected
> >> somehow), blaming lack of good entropy? Or should TLS silently fall ba=
ck
> >> to "mixing some counters [such as TSC] together and applying a
> >> deterministic cryptographic transformation"?
> >>
> >> IOW, knowing that the TLS setup may not be based on good quality
> >> entropy, should we allow related firmware services to "degrade silentl=
y"
> >> (not functionally, but potentially in security), or should we deny the
> >> services altogether?
> >=20
> > I don't see a downside to insisting that if you want to use https then
> > you must provide an entropy source; they're easy enough to add using
> > virtio-rng if the CPU doesn't provide it.
>=20
> Possibly true; however it could be considered a usability regression by
> end-users. ("UEFI HTTPS boot used to work, now it breaks with the same
> VM config". Unless we can respond, "UEFI HTTPS boot's TLS init has never
> been secure enough", they'll have a point. See also Ard's followup.)

You could turn it into a scary warning for a few releases first.

> >=20
> >>
> >> (2) It looks like the SMM driver implementing the privileged part of t=
he
> >> UEFI variable runtime service could need access to good quality entrop=
y,
> >> while running in SMM; in the future.
> >>
> >> This looks problematic on QEMU. Entropy is a valuable resource, and
> >> whatever resource SMM drivers depend on, should not be possible for e.=
g.
> >> a 3rd party UEFI driver (or even for the runtime OS) to exhaust.
> >> Therefore, it's not *only* the case that SMM drivers must not consume
> >> EFI_RNG_PROTOCOL (which exists at a less critical privilege level, i.e=
.
> >> outside of SMM/SMRAM), but also that SMM drivers must not depend on th=
e
> >> same piece of *hardware* that feeds EFI_RNG_PROTOCOL.
> >>
> >> Furthermore, assuming we dedicate a hardware entropy device specifical=
ly
> >> to SMM drivers, such a device cannot be PCI(e). It would have to be a
> >> platform device at a fixed location (IO port or MMIO) that is only
> >> accessible to such guest code that executes in SMM. IOW, device access
> >> would have to be restricted similarly to pflash. (In fact the variable
> >> SMM driver will need, AIUI, the entropy for encrypting various variabl=
e
> >> contents, which are then written into pflash.)
> >=20
> > Ewww.  I guess a virtio-rng instance wired to virtio-mmio could do that=
.
> > It's a bit grim though.
>=20
> *shudder* please let's keep virtio-mmio (or any remotely enumerable /
> complex "bus" thingy) out of this :( I'm all for extensible hardware
> interfaces, but cramming more and more infrastructure code into SMM
> looks very questionable to me.

The reason I suggested virtio-mmio was because it's not enumerable; it's
a fixed location; so you just check that the device you have there is
what you expect.
It means not inventing a new qemu device (although you would have to
make it addable on x86, and you would have to make it hideable in SMM).
(pci with preallocated addresses is similar).

> My main concern here is that most physical platform vendors will just
> solder some physical entropy-gen chip onto their boards, and then
> hard-code the MMIO base address of that as a build-time constant in
> their firmware blobs. This obviously won't work for QEMU, where the hw
> can change from boot to boot; so the generic edk2 solution (regardless
> of the actual chip) need to allow for that kind of dynamism. This is a
> recurrent problem between QEMU and edk2, alas. The answer is of course
> dynamic detection, but I *still* like to keep the enumeration logic to
> the absolute minimum in SMM.

While the hw can change from boot to boot on qemu, there's no
requirement that as a bios you respect that;  just state where you want
the device.

Dave

> Thanks!
> Laszlo
>=20
> >=20
> > Dave
> >=20
> >> Alternatively, CPU instructions could exist that return entropy, and a=
re
> >> executable only inside SMM. It seems that e.g. RDRAND can be trapped i=
n
> >> guests ("A VMEXIT due to RDRAND will have exit reason 57 (decimal)").
> >> Then KVM / QEMU could provide any particular implementation we wanted =
--
> >> for example an exception could be injected unless RDRAND had been
> >> executed from within SMM. Unfortunately, such an arbitrary restriction
> >> (of RDRAND to SMM) would diverge from the Intel SDM, and would likely
> >> break other (non-SMM) guest code.
> >>
> >> Does a platform device that is dynamically detectable and usable in SM=
M
> >> only seem like an acceptable design for QEMU?
> >>
> >> Thanks,
> >> Laszlo
> >>
> >>
> > --
> > Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
> >=20
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


