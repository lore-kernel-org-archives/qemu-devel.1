Return-Path: <SRS0=+ldK=Y7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68F71C5DF60
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2019 10:19:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 33EC5214D8
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2019 10:19:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Sk6m4aa7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33EC5214D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40456 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSetE-0007rj-CF
	for qemu-devel@archiver.kernel.org; Thu, 07 Nov 2019 05:19:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35581)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1iSesP-0007EI-Vw
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 05:18:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1iSesN-0003Ii-Ej
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 05:18:53 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:28644
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1iSesN-0003GX-Am
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 05:18:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573121930;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HdIlwKJ69Zm1SPluhXRNdHJgWpBRL21+6VS5JEbmEgo=;
 b=Sk6m4aa7PvZfIAFdjhZ1b/yd0WnLMXiuQesI/5TJwZYNaC8gMDXWAQOjU+2PK5pQVbsW37
 q1iIbk4GTYkt3wJfPYCG5OqAQjD3CH25i/XABGY44Qaw178pVkugU90swIq5cW/781HIRi
 0W/GKu1RtrVsUVlZh9KWELn3BZ4rt0s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-190-WFJMf6aENoCoX-z6HZetcQ-1; Thu, 07 Nov 2019 05:18:41 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B73801005500;
 Thu,  7 Nov 2019 10:18:39 +0000 (UTC)
Received: from work-vm (unknown [10.36.118.14])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id AB94A5D6D8;
 Thu,  7 Nov 2019 10:18:34 +0000 (UTC)
Date: Thu, 7 Nov 2019 10:18:32 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Laszlo Ersek <lersek@redhat.com>
Subject: Re: privileged entropy sources in QEMU/KVM guests
Message-ID: <20191107101832.GA2817@work-vm>
References: <03e769cf-a5ad-99ce-cd28-690e0a72a310@redhat.com>
MIME-Version: 1.0
In-Reply-To: <03e769cf-a5ad-99ce-cd28-690e0a72a310@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: WFJMf6aENoCoX-z6HZetcQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
> Hi,
>=20
> related TianoCore BZ:
>=20
>   https://bugzilla.tianocore.org/show_bug.cgi?id=3D1871
>=20
> (I'm starting this thread separately because at least some of the topics
> are specific to QEMU, and I didn't want to litter the BZ with a
> discussion that may not be interesting to all participants CC'd on the
> BZ. I am keeping people CC'd on this initial posting; please speak up if
> you'd like to be dropped from the email thread.)
>=20
> QEMU provides guests with the virtio-rng device, and the OVMF and
> ArmVirtQemu* edk2 platforms build EFI_RNG_PROTOCOL on top of that
> device. But, that doesn't seem enough for all edk2 use cases.
>=20
> Also, virtio-rng (hence EFI_RNG_PROTOCOL too) is optional, and its
> absence may affect some other use cases.
>=20
>=20
> (1) For UEFI HTTPS boot, TLS would likely benefit from good quality
> entropy. If the VM config includes virtio-rng (hence the guest firmware
> has EFI_RNG_PROTOCOL), then it should be used as a part of HTTPS boot.
>=20
> However, what if virtio-rng (hence EFI_RNG_PROTOCOL) are absent? Should
> UEFI HTTPS boot be disabled completely (or prevented / rejected
> somehow), blaming lack of good entropy? Or should TLS silently fall back
> to "mixing some counters [such as TSC] together and applying a
> deterministic cryptographic transformation"?
>=20
> IOW, knowing that the TLS setup may not be based on good quality
> entropy, should we allow related firmware services to "degrade silently"
> (not functionally, but potentially in security), or should we deny the
> services altogether?

I don't see a downside to insisting that if you want to use https then
you must provide an entropy source; they're easy enough to add using
virtio-rng if the CPU doesn't provide it.

>=20
> (2) It looks like the SMM driver implementing the privileged part of the
> UEFI variable runtime service could need access to good quality entropy,
> while running in SMM; in the future.
>=20
> This looks problematic on QEMU. Entropy is a valuable resource, and
> whatever resource SMM drivers depend on, should not be possible for e.g.
> a 3rd party UEFI driver (or even for the runtime OS) to exhaust.
> Therefore, it's not *only* the case that SMM drivers must not consume
> EFI_RNG_PROTOCOL (which exists at a less critical privilege level, i.e.
> outside of SMM/SMRAM), but also that SMM drivers must not depend on the
> same piece of *hardware* that feeds EFI_RNG_PROTOCOL.
>=20
> Furthermore, assuming we dedicate a hardware entropy device specifically
> to SMM drivers, such a device cannot be PCI(e). It would have to be a
> platform device at a fixed location (IO port or MMIO) that is only
> accessible to such guest code that executes in SMM. IOW, device access
> would have to be restricted similarly to pflash. (In fact the variable
> SMM driver will need, AIUI, the entropy for encrypting various variable
> contents, which are then written into pflash.)

Ewww.  I guess a virtio-rng instance wired to virtio-mmio could do that.
It's a bit grim though.

Dave

> Alternatively, CPU instructions could exist that return entropy, and are
> executable only inside SMM. It seems that e.g. RDRAND can be trapped in
> guests ("A VMEXIT due to RDRAND will have exit reason 57 (decimal)").
> Then KVM / QEMU could provide any particular implementation we wanted --
> for example an exception could be injected unless RDRAND had been
> executed from within SMM. Unfortunately, such an arbitrary restriction
> (of RDRAND to SMM) would diverge from the Intel SDM, and would likely
> break other (non-SMM) guest code.
>=20
> Does a platform device that is dynamically detectable and usable in SMM
> only seem like an acceptable design for QEMU?
>=20
> Thanks,
> Laszlo
>=20
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


