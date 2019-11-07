Return-Path: <SRS0=+ldK=Y7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F49CC5DF61
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2019 13:55:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A67B2178F
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2019 13:55:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UgiAn9+v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A67B2178F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42770 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSiG5-0000ai-Ds
	for qemu-devel@archiver.kernel.org; Thu, 07 Nov 2019 08:55:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41923)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1iSiF0-00085H-4i
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 08:54:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1iSiEx-0007uL-7o
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 08:54:24 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:50137
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1iSiEx-0007ti-2h
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 08:54:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573134862;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZAPXLzu/WWGlIR7eYqolsYiUpc16e9PqSb22Q2rDzRc=;
 b=UgiAn9+vRRfWH7+tO2+DLkM1yLx/seHD3LxxZDyvqHblmSkvbMA/YH5wC0Y9NjcXt/fvSg
 mVByoIJITT6yG7L6owzF1gSV6dTvT0AgWAF/rzDqyfMI76pdBscn8eUF4maee9GtC77+9t
 MaWPk642L6bTgwOYlhCywUPFwOLjDbs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-304-VPWNaCA6My-XFr4xbFDCOQ-1; Thu, 07 Nov 2019 08:54:17 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 70F6C102;
 Thu,  7 Nov 2019 13:54:16 +0000 (UTC)
Received: from redhat.com (unknown [10.42.16.105])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7D0F0608B2;
 Thu,  7 Nov 2019 13:54:07 +0000 (UTC)
Date: Thu, 7 Nov 2019 13:54:05 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Laszlo Ersek <lersek@redhat.com>
Subject: Re: privileged entropy sources in QEMU/KVM guests
Message-ID: <20191107135405.GF120292@redhat.com>
References: <03e769cf-a5ad-99ce-cd28-690e0a72a310@redhat.com>
 <20191107115203.GD120292@redhat.com>
 <31917972-da28-8e0d-432d-1cb7607ff3e7@redhat.com>
 <ad6a25e6-6019-e02f-b632-e19e6eeb0b95@redhat.com>
MIME-Version: 1.0
In-Reply-To: <ad6a25e6-6019-e02f-b632-e19e6eeb0b95@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: VPWNaCA6My-XFr4xbFDCOQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 Jian J Wang <jian.j.wang@intel.com>,
 edk2-devel-groups-io <devel@edk2.groups.io>,
 Bret Barkelew <Bret.Barkelew@microsoft.com>,
 qemu devel list <qemu-devel@nongnu.org>, Erik Bjorge <erik.c.bjorge@intel.com>,
 Sean Brogan <sean.brogan@microsoft.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Nov 07, 2019 at 02:44:11PM +0100, Laszlo Ersek wrote:
> On 11/07/19 13:47, Paolo Bonzini wrote:
> > On 07/11/19 12:52, Daniel P. Berrang=C3=A9 wrote:
> >>
> >> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/com=
mit/?id=3Dbb5530e4082446aac3a3d69780cd4dbfa4520013
> >>
> >> Is it practical to provide a jitter entropy source for EDK2
> >> too ?
> >=20
> > The hard part is not collecting jitter (though the firmware might be to=
o
> > deterministic for that), but rather turning it into a random number see=
d
> > (mixing data from various sources, crediting entropy, etc.).
>=20
> If there is *any* entropy source that (a) we can trust to be random
> enough and (b) depends only on the CPU, then we shouldn't struggle with
> virtio-rng (or similar devices) at all. RDRAND would be a no-brainer,
> but the "community literature" suggests it should not be trusted in itsel=
f.
>=20
> I've read the commit message linked above, and it appears too good to be
> true.
>=20
>     The CPU Jitter RNG provides a source of good entropy by collecting
>     CPU executing time jitter. [...] The RNG does not have any
>     dependencies on any other service in the kernel. The RNG only needs
>     a high-resolution time stamp. [...]
>=20
> http://www.chronox.de/jent.html
>=20
>     The CPU Jitter Random Number Generator provides a non-physical true
>     random number generator that works equally in kernel and user land.
>     The only prerequisite is the availability of a high-resolution timer
>     that is available in modern CPUs.
>=20
> http://www.chronox.de/jent/doc/CPU-Jitter-NPTRNG.html
>=20
>     Today=E2=80=99s operating systems provide non-physical true random nu=
mber
>     generators which are based on hardware events. With the advent of
>     virtualization and the ever growing need of more high-quality random
>     numbers, these random number generators reach their limits.
>     Additional sources of entropy must be opened up. This document
>     introduces an entropy source based on CPU execution time jitter. The
>     design and implementation of a non-physical true random number
>     generator, the CPU Jitter random number generator, its statistical
>     properties and the maintenance and behavior of entropy is discussed
>     in this document.
>=20
> If this construct is legit, a core edk2 implementation (available to all
> platforms, and on all edk2 arches) would be a huge win.
>=20
> On the other hand, we're having this discussion because the premise of
> TianoCore#1871 is that we shouldn't rely on just the CPU and a high
> resolution timer... I simply cannot decide if this construct is
> trustworthy. (With any solution that was based in the host's /dev/random
> or /dev/urandom, the trustworthiness question would be side-stepped in
> the firmware.)

I can't claim to have knowledge of whether the above text is accurate
or not, instead I just defer to the Linux maintainers recommendatiohns.
They've considered it acceptable to merge it into Linux, and to me that
says it should be acceptable to have in EDK2 too.

As a second data point, jitter entropy has been the recommended solution
in RHEL for VMs where there's no RDRAND or virtio-rng available. In RHEL-7
this was implemented in userspace in rng-tools rather than with the kernel
module I link above, but the approach is the same in both cases IIUC.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange=
 :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com=
 :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange=
 :|


