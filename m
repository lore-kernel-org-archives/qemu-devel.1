Return-Path: <SRS0=7f1Q=CT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6444BC43461
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 13:42:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB9FC2087C
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 13:41:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SYXtmeZj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB9FC2087C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41302 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGMpq-0001KR-M1
	for qemu-devel@archiver.kernel.org; Thu, 10 Sep 2020 09:41:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39958)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <drjones@redhat.com>)
 id 1kGMnX-0007sg-2b
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 09:39:35 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:51092
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <drjones@redhat.com>)
 id 1kGMnV-0001KL-Ft
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 09:39:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599745172;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7Y7Gme+6mP2kIxJBsfheP4T3JUU/zqQQOzX9yjwzzBo=;
 b=SYXtmeZjawLn6nE8Y3E+FaXBAm+5R0T0AR0TljniRwcukmDjUH9B/A2azCzd9wla+IqTWx
 jdOgXTBUCfvGmyfXLPFmKIq8YxZMglMIvrRVyW2b/nKtBpkUoClZKC3stiK6Wl22XISnso
 qgYTOLa7kzN+aZRxzanP37g3nlzydP0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-387-D1iJLJKcOje_PlRAcUXcZg-1; Thu, 10 Sep 2020 09:39:28 -0400
X-MC-Unique: D1iJLJKcOje_PlRAcUXcZg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 34B0118BA283;
 Thu, 10 Sep 2020 13:39:26 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.40.192.124])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id ACD1E5D9E8;
 Thu, 10 Sep 2020 13:39:22 +0000 (UTC)
Date: Thu, 10 Sep 2020 15:39:19 +0200
From: Andrew Jones <drjones@redhat.com>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Subject: Re: [PATCH v2 0/2] MTE support for KVM guest
Message-ID: <20200910133919.rkmki6x7iscbaymh@kamzik.brq.redhat.com>
References: <20200904160018.29481-1-steven.price@arm.com>
 <20200909152540.ylnrljd6aelxoxrf@kamzik.brq.redhat.com>
 <5cb1d7ed-54a5-4337-6c3d-2e3e7df89f17@linaro.org>
 <20200910054440.pvnzk7p7riiy45e2@kamzik.brq.redhat.com>
 <20200910132748.GF2814@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200910132748.GF2814@work-vm>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Received-SPF: pass client-ip=207.211.31.120; envelope-from=drjones@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/10 08:35:50
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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
Cc: Peter Maydell <Peter.Maydell@arm.com>, linux-kernel@vger.kernel.org,
 Juan Quintela <quintela@redhat.com>, Catalin Marinas <catalin.marinas@arm.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 Steven Price <steven.price@arm.com>, Marc Zyngier <maz@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will@kernel.org>,
 kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org,
 Dave Martin <Dave.Martin@arm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Sep 10, 2020 at 02:27:48PM +0100, Dr. David Alan Gilbert wrote:
> * Andrew Jones (drjones@redhat.com) wrote:
> > On Wed, Sep 09, 2020 at 06:45:33PM -0700, Richard Henderson wrote:
> > > On 9/9/20 8:25 AM, Andrew Jones wrote:
> > > >>  * Provide a KVM-specific method to extract the tags from guest memory.
> > > >>    This might also have benefits in terms of providing an easy way to
> > > >>    read bulk tag data from guest memory (since the LDGM instruction
> > > >>    isn't available at EL0).
> > > > 
> > > > Maybe we need a new version of KVM_GET_DIRTY_LOG that also provides
> > > > the tags for all addresses of each dirty page.
> > > 
> > > KVM_GET_DIRTY_LOG just provides one bit per dirty page, no?  Then VMM copies
> > > the data out from its local address to guest memory.
> > > 
> > > There'd be no difference with or without tags, afaik.  It's just about how VMM
> > > copies the data, with or without tags.
> > 
> > Right, as long as it's fast enough to do
> > 
> >   for_each_dirty_page(page, dirty_log)
> >     for (i = 0; i < host-page-size/16; i += 16)
> >       append_tag(LDG(page + i))
> > 
> > to get all the tags for each dirty page. I understood it would be faster
> > to use LDGM, but we'd need a new ioctl for that. So I was proposing we
> > just piggyback on a new dirty-log ioctl instead.
> 
> That feels a bad idea to me; there's a couple of different ways dirty
> page checking work; lets keep extracting the tags separate.
>

It's sounding like it was a premature optimization anyway. We don't yet
know if an ioctl for LDGM is worth it. Looping over LDG may work fine.

Thanks,
drew 


