Return-Path: <SRS0=Q9tF=AE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AC5EC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 21:06:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 01B8C20702
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 21:06:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U/3Jimq8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01B8C20702
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40926 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnq85-0007pF-51
	for qemu-devel@archiver.kernel.org; Tue, 23 Jun 2020 17:06:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47770)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jnq03-000299-5t
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 16:58:35 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:25133
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jnq00-00054q-IZ
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 16:58:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592945911;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TF5149cz3W+r6QZFruauOKk8RmlxeMqeZYvtPFm5PVg=;
 b=U/3Jimq8T21Zdj3x/2vs3TKFjhRyd2kRiU1ZWDlIVEmRFalsMsqCB14ipVGars6naIqfI1
 GierNI5xpQZX9+9viUZQlzz4oAEcWETA8/ZIwV2qxLvg6Q/uPWSIb8+oUkR56eWZbRVo6j
 xNnaOdY9yK0JwlPdzcwlxupCdMWKtpY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-237-aDlzGPc0M02uQpRD7KTQgw-1; Tue, 23 Jun 2020 16:58:27 -0400
X-MC-Unique: aDlzGPc0M02uQpRD7KTQgw-1
Received: by mail-wm1-f72.google.com with SMTP id h6so33164wmb.7
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2020 13:58:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=Xtw0c+pZCHFNxDXqiO5daZBikr1u/QeTEjSvhPx5HzM=;
 b=i/leqjLO5cua8yov8d/1cLEKeT6hNOUUktk0Im6qZzA0wLWvL/GlIwX2+11HrnsqIg
 8bs6Wpn0cLDjTl4rXNojz4IQeYarI1pX5keMrJsCHfGbkY1MYuM2RGWIbahXrHQklcom
 VS8hUYndHPzooZFFH6NH+IQnyKJjbV7+yV8xqWQgwaXs2pOJyXqNdRPfR2pfyOV3B3xk
 Rke3OTkw4YCEGmGGE/leXq7hnJ77cxY86VkiutYa8S479ajT5J4mojoboFVRaA6Oau+8
 2+KHkEOkbzAs/vjwfzepMtxTxd3lmQQJ9ZVTAyLJtl7LPuZ7T3WUw5p6m/5u/c5Zz4/d
 9Cyw==
X-Gm-Message-State: AOAM533Wz4MX4S7MXkuo5LBPrU1/oxxbXd1by70iyif7mqHv2amYzfri
 jrzho+FL3AvMk/LfpGgoM5oDgfE/sw+NYy0L68pCBS170MGZ5Q/+QiUGNmQ5gGo4onSHlXeyE5Z
 5QNJ5iGyaJ6HUgJ0=
X-Received: by 2002:adf:97cb:: with SMTP id t11mr27122826wrb.314.1592945906004; 
 Tue, 23 Jun 2020 13:58:26 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyueOWu5StELhIYEWVDlY8LVZLM3Aqhgh9X9I0R2PvKiU8h6kFPlNQbWLrdU7+FoUaKP7sgdg==
X-Received: by 2002:adf:97cb:: with SMTP id t11mr27122813wrb.314.1592945905771; 
 Tue, 23 Jun 2020 13:58:25 -0700 (PDT)
Received: from redhat.com (bzq-79-182-31-92.red.bezeqint.net. [79.182.31.92])
 by smtp.gmail.com with ESMTPSA id
 n8sm20696797wrj.44.2020.06.23.13.58.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jun 2020 13:58:25 -0700 (PDT)
Date: Tue, 23 Jun 2020 16:58:22 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: [PATCH] Revert "tests/migration: Reduce autoconverge initial
 bandwidth"
Message-ID: <20200623165639-mutt-send-email-mst@kernel.org>
References: <20200623145506.439100-1-mst@redhat.com>
 <3554a068-ba6f-0aa0-38b4-b6dca3069630@redhat.com>
MIME-Version: 1.0
In-Reply-To: <3554a068-ba6f-0aa0-38b4-b6dca3069630@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/23 02:54:39
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Jun 23, 2020 at 05:39:13PM +0200, Philippe Mathieu-Daudé wrote:
> On 6/23/20 4:56 PM, Michael S. Tsirkin wrote:
> > This reverts commit 6d1da867e65f ("tests/migration: Reduce autoconverge initial bandwidth")
> > since that change makes unit tests much slower for all developers, while it's not
> > a robust way to fix migration tests. Migration tests need to find
> > a more robust way to discover a reasonable bandwidth without slowing
> > things down for everyone.
> 
> Please also mention we can do this since 1de8e4c4dcf which allow
> marked the s390x job as "unstable" and allow it to fail.
> 
> But if nobody is going to look at it, instead lets disable

OK we can do this as an extra patch. Can you supply a S.O.B. pls?

> it until someone figure out the issue:
> 
> -- >8 --
> diff --git a/.travis.yml b/.travis.yml
> index 74158f741b..364e67b14b 100644
> --- a/.travis.yml
> +++ b/.travis.yml
> @@ -507,6 +507,7 @@ jobs:
> 
>      - name: "[s390x] Clang (disable-tcg)"
>        arch: s390x
> +      if: false # Temporarily disabled due to issue testing migration
> (see commit 6d1da867e65).
>        dist: bionic
>        compiler: clang
>        addons:
> ---
> 
> With the hunk amended (no need to mention 1de8e4c4d actually):
> Acked-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> 
> > 
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > 
> > ---
> >  tests/qtest/migration-test.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
> > index dc3490c9fa..21ea5ba1d2 100644
> > --- a/tests/qtest/migration-test.c
> > +++ b/tests/qtest/migration-test.c
> > @@ -1211,7 +1211,7 @@ static void test_migrate_auto_converge(void)
> >       * without throttling.
> >       */
> >      migrate_set_parameter_int(from, "downtime-limit", 1);
> > -    migrate_set_parameter_int(from, "max-bandwidth", 1000000); /* ~1Mb/s */
> > +    migrate_set_parameter_int(from, "max-bandwidth", 100000000); /* ~100Mb/s */
> >  
> >      /* To check remaining size after precopy */
> >      migrate_set_capability(from, "pause-before-switchover", true);
> > 


