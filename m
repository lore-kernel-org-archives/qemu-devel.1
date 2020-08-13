Return-Path: <SRS0=egLd=BX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09334C433E4
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 09:51:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC1DD2074D
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 09:51:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J/vfqnvy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC1DD2074D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39072 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k69tB-0006CG-1e
	for qemu-devel@archiver.kernel.org; Thu, 13 Aug 2020 05:51:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41496)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <drjones@redhat.com>)
 id 1k69sQ-0005hq-64
 for qemu-devel@nongnu.org; Thu, 13 Aug 2020 05:50:26 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:40414
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <drjones@redhat.com>)
 id 1k69sN-0001ld-Cc
 for qemu-devel@nongnu.org; Thu, 13 Aug 2020 05:50:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597312222;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LpT/aRV3dmDeTa485YJRSYwYHQ0M6zzHx1vcEnvxN4c=;
 b=J/vfqnvyZYKNyW6FMatAMt81ZlxiEXsKQFwOi9tS1hjLK2SlYhndkuFbiS/DI+zcTysfF5
 1bOOp1nk/uRE+CvB7WqtFAIGQWzSTQn3fORxsVvusyfZrwwEVDgrW6WPTByOHpfvAqIqHW
 6ZLxN1l8g6uzEQck6d/DVLxokPj5kGo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-255-VElY13BcPdaBRncIxd8Aiw-1; Thu, 13 Aug 2020 05:49:13 -0400
X-MC-Unique: VElY13BcPdaBRncIxd8Aiw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C8BA279EC0;
 Thu, 13 Aug 2020 09:49:11 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.40.192.72])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6217960BA7;
 Thu, 13 Aug 2020 09:49:10 +0000 (UTC)
Date: Thu, 13 Aug 2020 11:49:07 +0200
From: Andrew Jones <drjones@redhat.com>
To: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH 1/2] target/arm: Add cpu property to control pauth
Message-ID: <20200813094907.y5253jvekiqbz7n2@kamzik.brq.redhat.com>
References: <20200812065339.2030527-1-richard.henderson@linaro.org>
 <20200812065339.2030527-2-richard.henderson@linaro.org>
 <20200812110049.ghtvl7dmtspkfdor@kamzik.brq.redhat.com>
 <2219f3f9-7894-f898-0cad-43eccaa2a70d@linaro.org>
 <20200812163107.lbubi6c7ei7i5hmw@kamzik.brq.redhat.com>
 <20200813060321.cbr2tun6cuq25yst@kamzik.brq.redhat.com>
 <20200813090504.GA45195@C02TD0UTHF1T.local>
MIME-Version: 1.0
In-Reply-To: <20200813090504.GA45195@C02TD0UTHF1T.local>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=drjones@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=drjones@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/13 02:03:30
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
Cc: alex.bennee@linaro.org, peter.maydell@linaro.org,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Aug 13, 2020 at 10:05:04AM +0100, Mark Rutland wrote:
> On Thu, Aug 13, 2020 at 08:03:21AM +0200, Andrew Jones wrote:
> > Thinking about this some more, maybe we don't need pauth-arch.
> > If we don't, then it simplifies nicely to
> > 
> >  # Default (enabled with architected algorithm)
> >  -cpu max[,pauth=on][,pauth-fast=off]
> > 
> >  # Select pauth-fast
> >  -cpu max[,pauth=on],pauth-fast=on
> 
> One reason that users may wish to choose the IMP-DEF algorithm is for
> functional testing regardless of speed (since APA+GPA / API+GPI depend
> on whether the algo is architected or imp-def).
> 
> Given that, I think that "impdef" is a better option name than
> "pauth-fast", and speed is a benefit but not the only reason to use the
> option.

I was going with pauth-fast because in this case Richard identified a
need for a fast version. If we identify another need later, then we may
want to add another impdef version, e.g. pauth-foo. Maybe all the impdef
versions should have impdef in their name to make that more explicit?

 pauth-impdef-fast
 pauth-impdef-foo
 ...

That seems a bit verbose, though, and we can document that pauth-* are
impdefs and that the default is architected.

> 
> How about hacing a 'pauth-algo' option which defaults to architected,
> e.g.
> 
> | -cpu max,pauth={on,off},pauth-algo={impdef,architected}
> 
> ... then in future the 'pauth={on,off}' bit could de extended to cover
> FPAC version etc independently of the algorithm, but for now that can be
> a boolean.
>

Keeping pauth a boolean, but creating a pauth-algo enum doesn't help us
much, because probing will only be possible for pauth. The prober could
only decide to enable pauth with the default algo or not. We could create
a pauth-specific probe, similar to the gic-specific probe, but, IMO, it's
really not necessary. If we need multiple pauth-* properties, then we can
have them all. It just adds a few more lines of logic to the pauth
finalize function.

Thanks,
drew


