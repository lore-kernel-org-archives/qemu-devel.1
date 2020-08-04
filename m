Return-Path: <SRS0=UEgn=BO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ADC7C433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2020 20:37:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 40C6520842
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2020 20:37:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S3pRDf/l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40C6520842
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53920 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k33gM-00072L-HK
	for qemu-devel@archiver.kernel.org; Tue, 04 Aug 2020 16:37:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57436)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1k33fc-0006bz-Rp
 for qemu-devel@nongnu.org; Tue, 04 Aug 2020 16:36:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:34825)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1k33fa-0006ov-UY
 for qemu-devel@nongnu.org; Tue, 04 Aug 2020 16:36:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596573381;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wGWN1N/jSOqGchP4+RAuzqyz6D1JUg3pBOWriVJYHZQ=;
 b=S3pRDf/lQ7sPzo5zvutY9jtu1wYD7isyW1VU7S3kKkEfgopSne4ShQFy8pJSK0z1z3ajt7
 P5N+vLlU3kMmifwZUgrACKEe3pgE2WYg+voT3EBrBpBBZXnRJ4pxu67V5pNCa53vaDNGW5
 izKrse8LaxNL1NTdzr2URGEuG0sA6ZI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-340-bSkiP_y8PA6MhIh8i-6LZQ-1; Tue, 04 Aug 2020 16:36:17 -0400
X-MC-Unique: bSkiP_y8PA6MhIh8i-6LZQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1B8C180BCAE;
 Tue,  4 Aug 2020 20:36:16 +0000 (UTC)
Received: from localhost (ovpn-112-108.rdu2.redhat.com [10.10.112.108])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C6CA45DA7A;
 Tue,  4 Aug 2020 20:36:15 +0000 (UTC)
Date: Tue, 4 Aug 2020 16:36:15 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Subject: Re: [PATCH 1/2] hw/core: Add bql_interrupt flag to CPUClass
Message-ID: <20200804203615.GM225270@habkost.net>
References: <20200731125127.30866-1-robert.foley@linaro.org>
 <20200731125127.30866-2-robert.foley@linaro.org>
 <20200731174353.GF225270@habkost.net>
 <CAEyhzFuBiqpAijLMw-SZmiDyGQnc2c6yk6g+E0HN9eSYRVaWMA@mail.gmail.com>
 <20200731192404.GH225270@habkost.net> <87ime1yqxb.fsf@linaro.org>
MIME-Version: 1.0
In-Reply-To: <87ime1yqxb.fsf@linaro.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/04 16:36:21
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: Robert Foley <robert.foley@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, "Emilio G. Cota" <cota@braap.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Puhov <peter.puhov@linaro.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, Aug 02, 2020 at 05:05:04PM +0100, Alex Bennée wrote:
> 
> Eduardo Habkost <ehabkost@redhat.com> writes:
> 
> > On Fri, Jul 31, 2020 at 03:14:02PM -0400, Robert Foley wrote:
> >> On Fri, 31 Jul 2020 at 13:44, Eduardo Habkost <ehabkost@redhat.com> wrote:
> >> > >
> >> > > +static inline void cpu_class_disable_bql_interrupt(CPUClass *cc)
> >> > > +{
> >> > > +    cc->bql_interrupt = false;
> >> > > +}
> >> >
> >> > Class data is not supposed to change outside class_init.  Why do
> >> > you need this function?  I don't see it being used anywhere in
> >> > this series.
> >> 
> >> This function was to be called from changes in a later patch series
> >> that depend on these changes.  BTW,  I added a correction above,
> >> it should be disable, not enable.  The idea is that it is initialized to true,
> >> but then the per arch changes would use this call at init time to set
> >> it to false
> >> as needed.
> >
> > If you plan to call it from class_init, I don't think you need a
> > wrapper.  You can simply set cc->bql_interrupt=false directly
> > inside arch-specific class_init functions.
> 
> We just need to be careful of the ordering so the base class init goes
> first. Is that always the case?

Absolutely.  Subclasses overriding class data previously
initialized by the base class is a very common pattern in QOM
code.

-- 
Eduardo


