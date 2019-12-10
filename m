Return-Path: <SRS0=2P1T=2A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D56DC43603
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2019 15:49:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 580C5206D5
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2019 15:49:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gEl9OJJs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 580C5206D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58082 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iehlM-0005xp-2g
	for qemu-devel@archiver.kernel.org; Tue, 10 Dec 2019 10:49:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45548)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <abologna@redhat.com>) id 1iehk4-00052C-Nr
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 10:48:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <abologna@redhat.com>) id 1iehk1-00043Z-FD
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 10:48:02 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:24470
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <abologna@redhat.com>) id 1iehk1-00041d-BH
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 10:48:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575992880;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VhYuL2Sq9yxjpF+tZAOFmq1iyF/dfLOzaDkTF2Fc/GA=;
 b=gEl9OJJs333zcpWoGN+dRai+U+Qqf+29NpUm5I7XxHet6q5EY06dvVYhS+bBzhVbzLRIxm
 hhUB+apCOn94EkhRTDCdaC1QhUHp9f5ThwD6RHcODTMIfFBkpEqDdy79Oq/JICGweuFHy3
 T4uavo4baYqHGqfkmu1D0CBMsWCgDiY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-427-Vsc1rnNRMo-k8cxV4xnNCw-1; Tue, 10 Dec 2019 10:47:56 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 975FE100E0D9;
 Tue, 10 Dec 2019 15:47:54 +0000 (UTC)
Received: from ovpn-205-189.brq.redhat.com (ovpn-205-189.brq.redhat.com
 [10.40.205.189])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 56F1660BE0;
 Tue, 10 Dec 2019 15:47:52 +0000 (UTC)
Message-ID: <e0f86b200d0b3c08769cdbaa080569c3ec3db3ab.camel@redhat.com>
Subject: Re: [PATCH v1 0/5] target/arm/kvm: Provide an option to adjust
 virtual time
From: Andrea Bolognani <abologna@redhat.com>
To: Andrew Jones <drjones@redhat.com>
Date: Tue, 10 Dec 2019 16:47:49 +0100
In-Reply-To: <20191210143311.4sen6blhfhzop6zw@kamzik.brq.redhat.com>
References: <20191016143410.5023-1-drjones@redhat.com>
 <CAFEAcA8j8M_J8Ocdpms8a2XufigVQ6oB4JBy2BcYAkXfJX5y5A@mail.gmail.com>
 <20191206155327.7adiyjjkjh56mg2t@kamzik.brq.redhat.com>
 <596d07e933cb4da48dbba5b492e81a2438e78a2f.camel@redhat.com>
 <CAFEAcA9+G0jprsHRQp8g=Aso+2-_GhoWkDGx4WWxoC88maOKEg@mail.gmail.com>
 <20191210110531.psjzlikir2ep2omo@kamzik.brq.redhat.com>
 <CAFEAcA_M61hTzU=qCiUbR4V9Mnwd0phFNqTJG9pCWKreVmjy6A@mail.gmail.com>
 <20191210133254.22vcpvr3eabcnthe@kamzik.brq.redhat.com>
 <29add42daba074ab5bdbd462b2d377115fec7c3c.camel@redhat.com>
 <20191210143311.4sen6blhfhzop6zw@kamzik.brq.redhat.com>
User-Agent: Evolution 3.34.2 (3.34.2-1.fc31)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: Vsc1rnNRMo-k8cxV4xnNCw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: Peter Maydell <peter.maydell@linaro.org>, bijan.mottahedeh@oracle.com,
 Marc Zyngier <maz@kernel.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 2019-12-10 at 15:33 +0100, Andrew Jones wrote:
> On Tue, Dec 10, 2019 at 03:21:02PM +0100, Andrea Bolognani wrote:
> > I agree with everything except the naming: why would
> > 
> >   kvm-no-adjvtime=off  vtime is adjusted      (default)
> >   kvm-no-adjvtime=on   vtime is not adjusted
> > 
> > be better than
> > 
> >   kvm-adjvtime=on   vtime is adjusted      (default)
> >   kvm-adjvtime=off  vtime is not adjusted
> > 
> > ? Both offer the exact same amount of flexibility, but the latter has
> > the advantage of not introducing any unwieldy double negatives.
> 
> A default of 'off' == 0 means not setting anything at all. There's
> already precedent for 'kvm-no*' prefixed cpu features,
> 
> kvm-no-smi-migration
> kvm-nopiodelay

Sorry, I'm not sure I understand. Do you mean that the array where
you store CPU features is 0-inizialized, so it's more convenient to
have off (0) as the default because it means you don't have to touch
it beforehand? Or something different?

-- 
Andrea Bolognani / Red Hat / Virtualization


