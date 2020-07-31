Return-Path: <SRS0=FShu=BK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDC04C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2020 19:24:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E459208E4
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2020 19:24:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FF6z8nS6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E459208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38530 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k1ae8-0005YL-QO
	for qemu-devel@archiver.kernel.org; Fri, 31 Jul 2020 15:24:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41038)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1k1ada-000595-IA
 for qemu-devel@nongnu.org; Fri, 31 Jul 2020 15:24:14 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:45099
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1k1adX-0004Hc-MM
 for qemu-devel@nongnu.org; Fri, 31 Jul 2020 15:24:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596223449;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=AVU3Kvxs6OfJnaGw8nBtAKme6z+7m8gcNGI6IG/zWjI=;
 b=FF6z8nS6V7yk4KSE82OOQTBqnSNaQjzVhVZhvlN+scBRCjAbxyzCYQGuc9rkofYIfHByM8
 78c9dL9bsyqo+AHNnw2cIoq4B4KeKAs93DD0GPdLJB3z0nCTRKoKo5Wk0p2xhMike4SBH4
 yBJujdKlVewg+bvMwhmeac4UVLA1Y68=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-259--9VZ1GSSPGmr8OnU3jjZZQ-1; Fri, 31 Jul 2020 15:24:08 -0400
X-MC-Unique: -9VZ1GSSPGmr8OnU3jjZZQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A6FE0E91A;
 Fri, 31 Jul 2020 19:24:06 +0000 (UTC)
Received: from localhost (ovpn-120-33.rdu2.redhat.com [10.10.120.33])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5668E73039;
 Fri, 31 Jul 2020 19:24:05 +0000 (UTC)
Date: Fri, 31 Jul 2020 15:24:04 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
To: Robert Foley <robert.foley@linaro.org>
Subject: Re: [PATCH 1/2] hw/core: Add bql_interrupt flag to CPUClass
Message-ID: <20200731192404.GH225270@habkost.net>
References: <20200731125127.30866-1-robert.foley@linaro.org>
 <20200731125127.30866-2-robert.foley@linaro.org>
 <20200731174353.GF225270@habkost.net>
 <CAEyhzFuBiqpAijLMw-SZmiDyGQnc2c6yk6g+E0HN9eSYRVaWMA@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAEyhzFuBiqpAijLMw-SZmiDyGQnc2c6yk6g+E0HN9eSYRVaWMA@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/31 08:55:49
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: QEMU Developers <qemu-devel@nongnu.org>, "Emilio G. Cota" <cota@braap.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Puhov <peter.puhov@linaro.org>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Jul 31, 2020 at 03:14:02PM -0400, Robert Foley wrote:
> On Fri, 31 Jul 2020 at 13:44, Eduardo Habkost <ehabkost@redhat.com> wrote:
> > >
> > > +static inline void cpu_class_disable_bql_interrupt(CPUClass *cc)
> > > +{
> > > +    cc->bql_interrupt = false;
> > > +}
> >
> > Class data is not supposed to change outside class_init.  Why do
> > you need this function?  I don't see it being used anywhere in
> > this series.
> 
> This function was to be called from changes in a later patch series
> that depend on these changes.  BTW,  I added a correction above,
> it should be disable, not enable.  The idea is that it is initialized to true,
> but then the per arch changes would use this call at init time to set
> it to false
> as needed.

If you plan to call it from class_init, I don't think you need a
wrapper.  You can simply set cc->bql_interrupt=false directly
inside arch-specific class_init functions.

If you plan to call it from somewhere else, then maybe the field
doesn't belong to CPUClass.

> 
> We can remove this function from this series and add it in later when
> it gets used,
> it might make things more clear.

Makes sense to me.

-- 
Eduardo


