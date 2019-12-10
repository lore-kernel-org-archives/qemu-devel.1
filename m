Return-Path: <SRS0=2P1T=2A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 647B8C43603
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2019 14:22:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 204142073B
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2019 14:22:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MalhjYhf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 204142073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57416 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iegPE-0003F8-AE
	for qemu-devel@archiver.kernel.org; Tue, 10 Dec 2019 09:22:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52893)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <abologna@redhat.com>) id 1iegO5-0002Nd-ND
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 09:21:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <abologna@redhat.com>) id 1iegO2-0002zU-0g
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 09:21:15 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:25273
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <abologna@redhat.com>) id 1iegO1-0002yn-TD
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 09:21:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575987672;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=moUHla2XqP5eoohiHGzDGD1SQJpqUmN21LiF4ELBiFE=;
 b=MalhjYhfGuV7gnWhRTWnitROGnc5cu9zZNFMyO+TpUdWW8oLZ2UOOcWDqedU/mNgJ21fRa
 js/WLtgZrqZAtNFdnWQIQaFQLqo/Qub901r2I2p7Xvesnxk3b59hG1Ih+2S5mVJ9QcobUi
 4I1Pa4pmF/D2w8adjgQFyG/Xq6WNx5s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-160-OwFQM3SrM72eeLypHmqsUQ-1; Tue, 10 Dec 2019 09:21:09 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 23C4F107AD24;
 Tue, 10 Dec 2019 14:21:08 +0000 (UTC)
Received: from ovpn-205-189.brq.redhat.com (ovpn-205-189.brq.redhat.com
 [10.40.205.189])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7043B60BE2;
 Tue, 10 Dec 2019 14:21:05 +0000 (UTC)
Message-ID: <29add42daba074ab5bdbd462b2d377115fec7c3c.camel@redhat.com>
Subject: Re: [PATCH v1 0/5] target/arm/kvm: Provide an option to adjust
 virtual time
From: Andrea Bolognani <abologna@redhat.com>
To: Andrew Jones <drjones@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 10 Dec 2019 15:21:02 +0100
In-Reply-To: <20191210133254.22vcpvr3eabcnthe@kamzik.brq.redhat.com>
References: <20191016143410.5023-1-drjones@redhat.com>
 <CAFEAcA8j8M_J8Ocdpms8a2XufigVQ6oB4JBy2BcYAkXfJX5y5A@mail.gmail.com>
 <20191206155327.7adiyjjkjh56mg2t@kamzik.brq.redhat.com>
 <596d07e933cb4da48dbba5b492e81a2438e78a2f.camel@redhat.com>
 <CAFEAcA9+G0jprsHRQp8g=Aso+2-_GhoWkDGx4WWxoC88maOKEg@mail.gmail.com>
 <20191210110531.psjzlikir2ep2omo@kamzik.brq.redhat.com>
 <CAFEAcA_M61hTzU=qCiUbR4V9Mnwd0phFNqTJG9pCWKreVmjy6A@mail.gmail.com>
 <20191210133254.22vcpvr3eabcnthe@kamzik.brq.redhat.com>
User-Agent: Evolution 3.34.2 (3.34.2-1.fc31)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: OwFQM3SrM72eeLypHmqsUQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
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
Cc: Marc Zyngier <maz@kernel.org>, qemu-arm <qemu-arm@nongnu.org>,
 Richard Henderson <richard.henderson@linaro.org>, bijan.mottahedeh@oracle.com,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 2019-12-10 at 14:32 +0100, Andrew Jones wrote:
> After having done this git mining, it looks more and more like we should
> at least consider naming this feature 'kvm-no-adjvtime' and probably
> also change arm's default.

I agree with everything except the naming: why would

  kvm-no-adjvtime=off  vtime is adjusted      (default)
  kvm-no-adjvtime=on   vtime is not adjusted

be better than

  kvm-adjvtime=on   vtime is adjusted      (default)
  kvm-adjvtime=off  vtime is not adjusted

? Both offer the exact same amount of flexibility, but the latter has
the advantage of not introducing any unwieldy double negatives.

-- 
Andrea Bolognani / Red Hat / Virtualization


