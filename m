Return-Path: <SRS0=MAm8=C6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D5DDC43463
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 12:13:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B0F8D206D9
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 12:13:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Vy001IAT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0F8D206D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53684 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKKgq-0006ia-Jl
	for qemu-devel@archiver.kernel.org; Mon, 21 Sep 2020 08:13:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53684)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kKKew-000684-IQ
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 08:11:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:44090)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kKKeu-0006kL-Bh
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 08:11:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600690262;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yJ979M6HD6VGwbKwqQKLiQH5zU3sesoSCg3VBFdoXOo=;
 b=Vy001IATZA6LGSuSuponT4ZItqikf7Wwje/y60vV97IoDRY/BJx5CfumuFzgibncq3gM4I
 xTn2+DmgTGNf2dwd1AqsIxw2y/CzdpivOG2leLzGzybA0KuukCgkHdyYnrocOWUVs1IXEV
 EgPgYDPvQOu6MoIBkLcUFaY9lmcowr4=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-55-42feAefEPSOU_e-gF_ebVw-1; Mon, 21 Sep 2020 08:10:58 -0400
X-MC-Unique: 42feAefEPSOU_e-gF_ebVw-1
Received: by mail-wr1-f72.google.com with SMTP id i10so5772276wrq.5
 for <qemu-devel@nongnu.org>; Mon, 21 Sep 2020 05:10:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=yJ979M6HD6VGwbKwqQKLiQH5zU3sesoSCg3VBFdoXOo=;
 b=qdForGQZqkJIwW09OXu2IZzrpXv1qlOTMHmp9CWk3FtApXDdHKzhGTcB/8REbHegEe
 xNphAVfVSsqGyibHnM3uD3yqxGtapU6H/LGKsBAtVeHZwCzdB4zYuUzLxH9lMCvcd0W+
 LvUDvN6skoK26KltCJxALjtuP5OY0OKRK9JTl9/S9GNd1QzXTDvbo+ZLBjHvRFvurzHX
 T9zxFuXpBiC35Qc4X7tTlGWNBSI/GzCMw+5q8Bi9ueDtErpEVRRbIqbbWFqyyZbC8m4K
 wFi8esHj7PRJrBowh/CX8aAccjvmkyTy05/3XEJdM+rYNW/NVn0u/f3ZV5yF1K8bVPnE
 OFRQ==
X-Gm-Message-State: AOAM530l06SRAOyRPgEzapJcP22a+rx4xvkPICF5EXJq62/hwKhQlIIV
 7fHy4WV/2d+cxpFFQR+KwXiSJRfqnZ3eLr2ZrShNHqJ25fMKZ6I1btmLzsGwbvCtwgGkZijnlJa
 l2onJj254eSy1nRQ=
X-Received: by 2002:adf:e488:: with SMTP id i8mr55394259wrm.116.1600690257379; 
 Mon, 21 Sep 2020 05:10:57 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxoxyW5GLpJ92fS3n2dOBcl9Iq6LCBi+XK0R6iFuC9uY/8bLg7YpsplreShmcOt7NRipkDj/w==
X-Received: by 2002:adf:e488:: with SMTP id i8mr55394230wrm.116.1600690257149; 
 Mon, 21 Sep 2020 05:10:57 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:d153:8d0f:94cf:5114?
 ([2001:b07:6468:f312:d153:8d0f:94cf:5114])
 by smtp.gmail.com with ESMTPSA id 70sm19767504wme.15.2020.09.21.05.10.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 21 Sep 2020 05:10:56 -0700 (PDT)
Subject: Re: Issue 25514 in oss-fuzz: qemu: Coverage build failure
To: qemu-devel <qemu-devel@nongnu.org>, "Oleinik, Alexander" <alxndr@bu.edu>
References: <0=0a88cf92d34dc9db91727cc9bd0dc58b=d9ca53ad17e3d19752f355e6c3ba1ecc=oss-fuzz@monorail-prod.appspotmail.com>
 <0000000000003aa8d805afd00f24@google.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <995b1aa7-8efc-57d2-a85e-5520fab0755b@redhat.com>
Date: Mon, 21 Sep 2020 14:10:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <0000000000003aa8d805afd00f24@google.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Received-SPF: pass client-ip=216.205.24.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/21 01:43:11
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.455,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 21/09/20 12:10, ClusterFuzz-External via monorail wrote:
> 
> Comment #2 on issue 25514 by ClusterFuzz-External: qemu: Coverage build
> failure
> https://bugs.chromium.org/p/oss-fuzz/issues/detail?id=25514#c2
> 
> Friendly reminder that the the build is still failing.
> Please try to fix this failure to ensure that fuzzing remains productive.
> Latest build log:
> https://oss-fuzz-build-logs.storage.googleapis.com/log-632125f2-e66b-4480-9504-c1097198069a.txt
> 
> -- 
> You received this message because:
> 1. You were specifically CC'd on the issue
> 
> You may adjust your notification preferences at:
> https://bugs.chromium.org/hosting/settings
> 
> Reply to this email to add a comment.

It's now failing with:

Step #3: /usr/bin/ld: section .interp loaded at
[00000000000002a8,00000000000002c3] overlaps section .data.fuzz_ordered
loaded at [0000000000000000,000000000016ebff]

Do you know what's going on?  Also, should we make
scripts/oss-fuzz/build.sh use "make V=1"?

Paolo


