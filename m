Return-Path: <SRS0=2IDT=CR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C016C43461
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 10:03:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D517C21D47
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 10:03:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aAVpidKw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D517C21D47
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38180 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFaTE-0007dp-TV
	for qemu-devel@archiver.kernel.org; Tue, 08 Sep 2020 06:03:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54092)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kFaSY-0006ZB-Vm
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 06:02:43 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:26759
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kFaSX-0005Un-AV
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 06:02:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599559360;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JBFHjcUtbBXAsdvv5y0IusU6uEyPfsMtwGczYTQlzdQ=;
 b=aAVpidKwmcguLs83m8cpE5WmLr9TqrAcHOQ/Qg9lqRxT9GcUt2jR5Ws9ub8NDLg04znQq1
 qkDoSGB8XILJYIEaJjofTxdySzFir1mdFsHgwb0GKY5r5vaidgmI44ZhS17nNOYFDWNHjQ
 WCQbevmUI9+n2NILuvkngdJs6+ou1D0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-82-mFF-idGgPC6Q4Zvf6Uujzw-1; Tue, 08 Sep 2020 06:02:39 -0400
X-MC-Unique: mFF-idGgPC6Q4Zvf6Uujzw-1
Received: by mail-wr1-f71.google.com with SMTP id g6so6804827wrv.3
 for <qemu-devel@nongnu.org>; Tue, 08 Sep 2020 03:02:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=JBFHjcUtbBXAsdvv5y0IusU6uEyPfsMtwGczYTQlzdQ=;
 b=RLclz17oITUOtcl92hCa+6A7Rwv7L52/+a8xLBuVujbTadGr9DuHkR9fdnmhRZ2BoM
 c+hOkz1tc6dCtonR8o6sVdcftuS3Mbwf+gWto+NxgvTgNNQ4go+chjTwEFdhzb6jDtUe
 +Ve56s/k4rKslONP7RRWYmn73xHG6CAvA5Gggjkf0plaDyvVc/4iDurgMhOwhrc4pLCT
 1eLdJfPt38lBzMMa5512BKLrKMQDK0Xbb8YvrfERF/AqqBQkxxaWnhBAhJWwYm0Wua01
 /kdPtqXUpAnAas+7iuzKtOFclZ6ekWJz2mCiQb0o/MzvpBv7FK3mH/S2DMeFe39K2h5C
 2vrA==
X-Gm-Message-State: AOAM530Vq6gSxpUc0sIzLn/aPJDCG3Qp6wkF5WB2HS0d+0U6xYfSSrb5
 Y4s79BdvfEC14JkjTL1YwOXqmWbBS6GdAIzzlKmZTPkbRpOw6iQjVZelcXvW0ZOhl9JWEQcYMhS
 NTAP5KBT3UP+6ddU=
X-Received: by 2002:a1c:c256:: with SMTP id s83mr3613098wmf.93.1599559357915; 
 Tue, 08 Sep 2020 03:02:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx/JIoH5nAM1wd712lB+3yi3UMLsNxYs4hbX1oGqkB0dt1bVC9nYUYuBxpliHq5YxAA5QYASw==
X-Received: by 2002:a1c:c256:: with SMTP id s83mr3613078wmf.93.1599559357741; 
 Tue, 08 Sep 2020 03:02:37 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-221-30.inter.net.il. [80.230.221.30])
 by smtp.gmail.com with ESMTPSA id z15sm32708955wrv.94.2020.09.08.03.02.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Sep 2020 03:02:36 -0700 (PDT)
Date: Tue, 8 Sep 2020 06:02:33 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v1] pc: fix
 auto_enable_numa_with_memhp/auto_enable_numa_with_memdev for the 5.0 machine
Message-ID: <20200908060219-mutt-send-email-mst@kernel.org>
References: <20200820094828.30348-1-david@redhat.com>
 <72ef0b4f-e0a1-ce1e-0b92-9228843a774f@redhat.com>
MIME-Version: 1.0
In-Reply-To: <72ef0b4f-e0a1-ce1e-0b92-9228843a774f@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=mst@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/08 02:10:53
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.1,
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, qemu-stable@nongnu.org,
 qemu-devel@nongnu.org, "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Sep 08, 2020 at 10:56:53AM +0200, David Hildenbrand wrote:
> On 20.08.20 11:48, David Hildenbrand wrote:
> > Unfortunately, a typo sneeked in: we want to set
> > auto_enable_numa_with_memdev to false, not auto_enable_numa_with_memhp.
> > 
> > Cc: qemu-stable@nongnu.org # v5.1
> > Fixes: 195784a0cfad (numa: Auto-enable NUMA when any memory devices are possible)
> > Reported-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> > Cc: Paolo Bonzini <pbonzini@redhat.com>
> > Cc: Richard Henderson <rth@twiddle.net>
> > Cc: Eduardo Habkost <ehabkost@redhat.com>
> > Cc: "Michael S. Tsirkin" <mst@redhat.com>
> > Signed-off-by: David Hildenbrand <david@redhat.com>
> 
> @MST, do you want to queue this patch? thanks!

queued, thanks!
> 
> -- 
> Thanks,
> 
> David / dhildenb


