Return-Path: <SRS0=gXk/=AL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DF41C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 14:45:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 275F5206BE
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 14:45:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b6AaFFy+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 275F5206BE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52428 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqHVW-0005XT-AP
	for qemu-devel@archiver.kernel.org; Tue, 30 Jun 2020 10:45:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55250)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jqHU8-0003ze-Uh
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 10:43:44 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:39476
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jqHU7-0000vI-BV
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 10:43:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593528222;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DTdpC2GuPMPHyT46rqlDxVbcn4fFNliki+cobUXv3DY=;
 b=b6AaFFy+YHw4qHwXyakwjYRukN+t0Hw2Q9BMTZMHGdd6KAD5yrE8AAR7dKXn7GsZUd7HJL
 5WReNmz+/hlfN8/plKleWNTn1qeIEWMvukLfgx1OzGsa46Qu664zvHEab/1wDYB2nHIP/Q
 wJ3sBfnb6mHVm71bZ/DJ73tKNSkJWw4=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-150-clxXk8A5OM21JCBY6dlqBw-1; Tue, 30 Jun 2020 10:43:40 -0400
X-MC-Unique: clxXk8A5OM21JCBY6dlqBw-1
Received: by mail-wr1-f71.google.com with SMTP id i10so18871659wrn.21
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2020 07:43:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=DTdpC2GuPMPHyT46rqlDxVbcn4fFNliki+cobUXv3DY=;
 b=HGXXOUmmBYALZTo4mhSYu/6DMMVpXPJNXrfXJ5UO6HLGw26P297UU2YTU/EjH3GnsG
 B/hM/WdwR4HlkuTiGTM/H+3ldY9wFI9IvRyRARu4Oq/bsqtBCJCWQVbVvrdLJTb7XPNW
 hQ389oM4ChNDKK7zfU+7hn8ymloaks763vclNSfY7U5aZEzt4Iah1SHETAUG8AuzOk6d
 BYDVERz+8f75QRSOfnSE6wUQ5lFUcNILSUGd1I0wuX0r+RwP9SVdtaThBgKIDOrzItB3
 3CXJC+MiE03j+k0P87ejoX5W+BWbvs45HrgAABfv+YX4wULbMZsp+mG1OFmd2XgGPTI4
 oEdA==
X-Gm-Message-State: AOAM532jt5UqEIt6AMkv4dI6UqbCAj6f/JG6aRCkU6RePHGu6bDyvmYt
 TNM5T9b9anH6tO4LQDIha8EbYqI1jsGmtoH+zqJ+APvn+TuGZdcPcSdr40zAzhiRvwlQsu2hFYW
 ZUjMGonraXpdFFkM=
X-Received: by 2002:a1c:f007:: with SMTP id a7mr21817275wmb.103.1593528219156; 
 Tue, 30 Jun 2020 07:43:39 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzTZJncjRVh0jmvH+ToRI0FKBcLz3bHIEvOn2UpP43xcJq2XSOpd66tbiqlevJETRaJsOn2eg==
X-Received: by 2002:a1c:f007:: with SMTP id a7mr21817261wmb.103.1593528218951; 
 Tue, 30 Jun 2020 07:43:38 -0700 (PDT)
Received: from redhat.com (bzq-79-182-31-92.red.bezeqint.net. [79.182.31.92])
 by smtp.gmail.com with ESMTPSA id
 y17sm4063126wrd.58.2020.06.30.07.43.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jun 2020 07:43:38 -0700 (PDT)
Date: Tue, 30 Jun 2020 10:43:35 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH] Revert "tests/migration: Reduce autoconverge initial
 bandwidth"
Message-ID: <20200630104328-mutt-send-email-mst@kernel.org>
References: <20200623145506.439100-1-mst@redhat.com>
 <20200630090717-mutt-send-email-mst@kernel.org>
 <3fefaeb3-0972-2ab4-6e00-aae78357ec3d@redhat.com>
MIME-Version: 1.0
In-Reply-To: <3fefaeb3-0972-2ab4-6e00-aae78357ec3d@redhat.com>
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
 Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Jun 30, 2020 at 03:20:04PM +0200, Thomas Huth wrote:
> On 30/06/2020 15.07, Michael S. Tsirkin wrote:
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
> Fine for me (from the s390x side). The test should not run with TCG in the
> CI for s390x ... if it still does, we have to have another closer look at
> the check there instead.
> 
>  Thomas

ack pls?

> 
> > 
> > > ---
> > >   tests/qtest/migration-test.c | 2 +-
> > >   1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
> > > index dc3490c9fa..21ea5ba1d2 100644
> > > --- a/tests/qtest/migration-test.c
> > > +++ b/tests/qtest/migration-test.c
> > > @@ -1211,7 +1211,7 @@ static void test_migrate_auto_converge(void)
> > >        * without throttling.
> > >        */
> > >       migrate_set_parameter_int(from, "downtime-limit", 1);
> > > -    migrate_set_parameter_int(from, "max-bandwidth", 1000000); /* ~1Mb/s */
> > > +    migrate_set_parameter_int(from, "max-bandwidth", 100000000); /* ~100Mb/s */
> > >       /* To check remaining size after precopy */
> > >       migrate_set_capability(from, "pause-before-switchover", true);
> > > -- 
> > > MST
> > 
> > 


