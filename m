Return-Path: <SRS0=+ldK=Y7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4594C5DF60
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2019 13:45:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F74B2077C
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2019 13:45:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cozOVn+e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F74B2077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42672 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSi6H-0003iB-Ra
	for qemu-devel@archiver.kernel.org; Thu, 07 Nov 2019 08:45:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40388)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lersek@redhat.com>) id 1iSi5S-000366-1Y
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 08:44:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <lersek@redhat.com>) id 1iSi5Q-0001Ih-JD
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 08:44:33 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:31777
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <lersek@redhat.com>) id 1iSi5Q-0001IM-Fh
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 08:44:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573134271;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MtTv65/cUTSV/C5FC9Kyjuj/mKdxOnEinOVdFDzlhIs=;
 b=cozOVn+eoMl4gG0nBz4NEhDm4QiNSKBk7KLjNzIFJr42ueruM3K8JIYV9OLwpGNtuAzHsV
 /eqM8QA+geWijN/LE5CyR7nXMZwl/yWUwPiM0Ep25qK2OYyGSmnuHl8RH1WGwCBhKuAWGJ
 pAYc2YEtevIBNsVT+eAcOVFTnB7qwl0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-228-UR4GN-N1OKO43jlNzUUIHQ-1; Thu, 07 Nov 2019 08:44:26 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4D1D91005500;
 Thu,  7 Nov 2019 13:44:25 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (unknown [10.36.118.71])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A30115D72D;
 Thu,  7 Nov 2019 13:44:12 +0000 (UTC)
Subject: Re: privileged entropy sources in QEMU/KVM guests
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P._Berrang=c3=a9?= <berrange@redhat.com>
References: <03e769cf-a5ad-99ce-cd28-690e0a72a310@redhat.com>
 <20191107115203.GD120292@redhat.com>
 <31917972-da28-8e0d-432d-1cb7607ff3e7@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <ad6a25e6-6019-e02f-b632-e19e6eeb0b95@redhat.com>
Date: Thu, 7 Nov 2019 14:44:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <31917972-da28-8e0d-432d-1cb7607ff3e7@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: UR4GN-N1OKO43jlNzUUIHQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
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
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 Jian J Wang <jian.j.wang@intel.com>,
 edk2-devel-groups-io <devel@edk2.groups.io>,
 Bret Barkelew <Bret.Barkelew@microsoft.com>,
 qemu devel list <qemu-devel@nongnu.org>, Erik Bjorge <erik.c.bjorge@intel.com>,
 Sean Brogan <sean.brogan@microsoft.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/07/19 13:47, Paolo Bonzini wrote:
> On 07/11/19 12:52, Daniel P. Berrang=C3=A9 wrote:
>>
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commi=
t/?id=3Dbb5530e4082446aac3a3d69780cd4dbfa4520013
>>
>> Is it practical to provide a jitter entropy source for EDK2
>> too ?
>=20
> The hard part is not collecting jitter (though the firmware might be too
> deterministic for that), but rather turning it into a random number seed
> (mixing data from various sources, crediting entropy, etc.).

If there is *any* entropy source that (a) we can trust to be random
enough and (b) depends only on the CPU, then we shouldn't struggle with
virtio-rng (or similar devices) at all. RDRAND would be a no-brainer,
but the "community literature" suggests it should not be trusted in itself.

I've read the commit message linked above, and it appears too good to be
true.

    The CPU Jitter RNG provides a source of good entropy by collecting
    CPU executing time jitter. [...] The RNG does not have any
    dependencies on any other service in the kernel. The RNG only needs
    a high-resolution time stamp. [...]

http://www.chronox.de/jent.html

    The CPU Jitter Random Number Generator provides a non-physical true
    random number generator that works equally in kernel and user land.
    The only prerequisite is the availability of a high-resolution timer
    that is available in modern CPUs.

http://www.chronox.de/jent/doc/CPU-Jitter-NPTRNG.html

    Today=E2=80=99s operating systems provide non-physical true random numb=
er
    generators which are based on hardware events. With the advent of
    virtualization and the ever growing need of more high-quality random
    numbers, these random number generators reach their limits.
    Additional sources of entropy must be opened up. This document
    introduces an entropy source based on CPU execution time jitter. The
    design and implementation of a non-physical true random number
    generator, the CPU Jitter random number generator, its statistical
    properties and the maintenance and behavior of entropy is discussed
    in this document.

If this construct is legit, a core edk2 implementation (available to all
platforms, and on all edk2 arches) would be a huge win.

On the other hand, we're having this discussion because the premise of
TianoCore#1871 is that we shouldn't rely on just the CPU and a high
resolution timer... I simply cannot decide if this construct is
trustworthy. (With any solution that was based in the host's /dev/random
or /dev/urandom, the trustworthiness question would be side-stepped in
the firmware.)

Laszlo


