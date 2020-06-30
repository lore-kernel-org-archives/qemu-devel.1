Return-Path: <SRS0=gXk/=AL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F522C433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 14:44:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E2C52206BE
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 14:44:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SRTdkmWu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2C52206BE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48788 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqHUQ-00043n-7u
	for qemu-devel@archiver.kernel.org; Tue, 30 Jun 2020 10:44:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55164)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jqHTk-0003dG-6g
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 10:43:20 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:39607
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jqHTh-0000uN-KE
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 10:43:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593528195;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8+1VYQl92ykgqnjl5RMQLLjMk+RYuKnLss95O+hTXCQ=;
 b=SRTdkmWu4oXqbHeSh/GWDkRyqb+/XO30yjj+HCdgVrNynk1hx9n4liPUABpG3Gqg1644MW
 UfOnMd3cIelMOyMUN1U5XPeFuD06MSFMtZbL+GaF+277orNLYsxwN1V0xTnpX9rcZb0bG4
 t1dV6eskmwH144E7bY68FekSlgT1bX8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-24-FJogwNNqOXSimrXh_Nsi-A-1; Tue, 30 Jun 2020 10:43:11 -0400
X-MC-Unique: FJogwNNqOXSimrXh_Nsi-A-1
Received: by mail-wm1-f69.google.com with SMTP id h6so21040856wmb.7
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2020 07:43:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=8+1VYQl92ykgqnjl5RMQLLjMk+RYuKnLss95O+hTXCQ=;
 b=LayOGglx9ytq69EPb2eimlq2voMEHXpOfNe3lhCroLrGvUoRLVHKbzJdJ8k2EVia6Q
 fb3+zbCuv2gY6P6VOJ+GgVt0AQEIbYKsVX5VF18KRQbcvLNYSVzEgzDMobmIn1M6Gk2H
 uRbpzIzWWPvlAOGaq1pm45AjzAtX5xLB/AXU8gZDn5DetMDOxs0IkQcOx1lOKvvFVkc8
 o3ucZp8GPcyXPLXPh2pfNy86NCh1RWKUskRx2khNhOyheKbCCg9VZ3Lca17RJH+9wAYK
 fsTV+gIlOeg/kme8xSvvo0JK9POy1Ro9AbszeO/cJu1mxWACT7pLB2x24XCXf4x6LXiJ
 7wQA==
X-Gm-Message-State: AOAM532dYb6ta0iUP7TEdRvBGzHhncELQ00tU7z4FlRboaX3GFZyxWP+
 UFyLGecxjFYd0rxr/tv8n7OBT5E2dwKv7QS1AnYgZLgmdndHzoy8xWiBfIGsnTR7eD3s1dTfWXk
 UZGe6h3KIrvgCepo=
X-Received: by 2002:a1c:d5:: with SMTP id 204mr21326623wma.174.1593528190207; 
 Tue, 30 Jun 2020 07:43:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxWDyxmzVbrITLCpuKDU4Im14S69TNzshN3l9j43pJ4+Lqs6ELwAuUulzkxbfsxqn/08Ftrqw==
X-Received: by 2002:a1c:d5:: with SMTP id 204mr21326600wma.174.1593528189927; 
 Tue, 30 Jun 2020 07:43:09 -0700 (PDT)
Received: from redhat.com (bzq-79-182-31-92.red.bezeqint.net. [79.182.31.92])
 by smtp.gmail.com with ESMTPSA id
 i19sm4196486wrb.56.2020.06.30.07.43.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jun 2020 07:43:09 -0700 (PDT)
Date: Tue, 30 Jun 2020 10:43:05 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Subject: Re: [PATCH] Revert "tests/migration: Reduce autoconverge initial
 bandwidth"
Message-ID: <20200630104300-mutt-send-email-mst@kernel.org>
References: <20200623145506.439100-1-mst@redhat.com>
 <20200630090717-mutt-send-email-mst@kernel.org>
 <20200630135912.GI2673@work-vm>
MIME-Version: 1.0
In-Reply-To: <20200630135912.GI2673@work-vm>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=mst@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/30 03:55:26
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 Juan Quintela <quintela@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Jun 30, 2020 at 02:59:12PM +0100, Dr. David Alan Gilbert wrote:
> * Michael S. Tsirkin (mst@redhat.com) wrote:
> > On Tue, Jun 23, 2020 at 10:57:02AM -0400, Michael S. Tsirkin wrote:
> > > This reverts commit 6d1da867e65f ("tests/migration: Reduce autoconverge initial bandwidth")
> > > since that change makes unit tests much slower for all developers, while it's not
> > > a robust way to fix migration tests. Migration tests need to find
> > > a more robust way to discover a reasonable bandwidth without slowing
> > > things down for everyone.
> > > 
> > > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > 
> > What's the conclusion here? Should I merge this?
> 
> Yes please; I need to rethink that.
> 
> Dave
> 
> > 
> > > ---
> > >  tests/qtest/migration-test.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
> > > index dc3490c9fa..21ea5ba1d2 100644
> > > --- a/tests/qtest/migration-test.c
> > > +++ b/tests/qtest/migration-test.c
> > > @@ -1211,7 +1211,7 @@ static void test_migrate_auto_converge(void)
> > >       * without throttling.
> > >       */
> > >      migrate_set_parameter_int(from, "downtime-limit", 1);
> > > -    migrate_set_parameter_int(from, "max-bandwidth", 1000000); /* ~1Mb/s */
> > > +    migrate_set_parameter_int(from, "max-bandwidth", 100000000); /* ~100Mb/s */
> > >  
> > >      /* To check remaining size after precopy */
> > >      migrate_set_capability(from, "pause-before-switchover", true);
> > > -- 
> > > MST
> > 
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

ack pls?


