Return-Path: <SRS0=+ldK=Y7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D088C5DF61
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2019 11:56:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 077042166E
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2019 11:56:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i1RrMeXp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 077042166E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41258 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSgOl-000258-W0
	for qemu-devel@archiver.kernel.org; Thu, 07 Nov 2019 06:56:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52891)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1iSgNp-0001Xv-7m
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 06:55:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1iSgNn-00008g-Jq
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 06:55:25 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:25203
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1iSgNn-00008Q-G5
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 06:55:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573127722;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vjUfooQ1zgPwNeyYzWGH1a+y3ijXA4LLBofNQ+WbySk=;
 b=i1RrMeXpUm/dY211vi7TqrMHIGhzLLu2Rx2g+0imf1E9G8qdB/T/AQn+2SrBsygornW8Z+
 iN9pzMvWSocFgSj8Wny+rtDE4zh0/rPv7HDZJljQ8uIagN5IdrKUnVMNXbw30wUJWiz8C/
 LtVb8wsJfOo9Ei6i8CvfeUsk2ZQbhJ8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-5-_9oDHGmaM9S8Zez5XTEvyw-1; Thu, 07 Nov 2019 06:55:18 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B18891800D6B;
 Thu,  7 Nov 2019 11:55:17 +0000 (UTC)
Received: from redhat.com (unknown [10.42.16.105])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8B4951001B35;
 Thu,  7 Nov 2019 11:55:13 +0000 (UTC)
Date: Thu, 7 Nov 2019 11:55:11 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: privileged entropy sources in QEMU/KVM guests
Message-ID: <20191107115511.GE120292@redhat.com>
References: <03e769cf-a5ad-99ce-cd28-690e0a72a310@redhat.com>
 <CAKv+Gu8gqfu_mOm2zK64dmj5CkVaPvix3gEMEFQScyk1CnOv6w@mail.gmail.com>
 <ef126cd5-7b64-1b8a-ca74-11bd06b5f4b1@redhat.com>
MIME-Version: 1.0
In-Reply-To: <ef126cd5-7b64-1b8a-ca74-11bd06b5f4b1@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: _9oDHGmaM9S8Zez5XTEvyw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 Jian J Wang <jian.j.wang@intel.com>,
 edk2-devel-groups-io <devel@edk2.groups.io>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Bret Barkelew <Bret.Barkelew@microsoft.com>,
 qemu devel list <qemu-devel@nongnu.org>, Erik Bjorge <erik.c.bjorge@intel.com>,
 Sean Brogan <sean.brogan@microsoft.com>, Laszlo Ersek <lersek@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Nov 07, 2019 at 12:37:11PM +0100, Paolo Bonzini wrote:
> On 07/11/19 11:25, Ard Biesheuvel wrote:
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
> > The typical model is to seed a DRBG [deterministic pseudorandom
> > sequence generator] using a sufficient amount of high quality entropy.
> > Once you have done that, it is rather hard to exhaust a DRBG - it is a
> > mathematical construction that is designed to last for a long time (<=
=3D
> > 2^48 invocations [not bytes] according to the NIST spec), after which
> > it does not degrade although it may have generated so much output that
> > its internal state may be inferred if you have captured enough of it
> > (which is a rather theoretical issue IMHO)
> >=20
> > The problem is that using the output of a DRBG as a seed is
> > non-trivial - the spec describes ways to do this, but wiring
> > virtio-rng to a DRBG in the host and using its output to seed a DRBG
> > in the guest is slighly problematic.
> >=20
> > So it seems to me that the correct way to model this is to make the
> > host's true entropy source a shared resource like any other.
> >=20
>=20
> Yes, I would make SMM use a cryptographic pseudo-random number generator=
=20
> and seed it from virtio-rng from DXE, way before the OS starts and can=20
> "attack" it.
>=20
> Once you've gotten a seed, you can create a CSPRNG with a stream cipher=
=20
> such as ChaCha20, which is literally 30 lines of code.

If all we need is a one-time seed then virtio-rng is possibly overkill as
that provides a continuous stream. Instead could QEMU read a few bytes
from the host's /dev/urandom and pass it to EDK via fw_cfg, which can
use it for the CSPRNG seed. EDK would have to erase the fw_cfg field
to prevent the seed value leaking to the guest OS, but other than that
its quite straightforward.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange=
 :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com=
 :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange=
 :|


