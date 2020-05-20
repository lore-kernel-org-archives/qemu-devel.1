Return-Path: <SRS0=CoOB=7C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93763C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 06:30:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5434B207FB
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 06:30:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T1SOnnKN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5434B207FB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58476 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbIFm-0001bV-FH
	for qemu-devel@archiver.kernel.org; Wed, 20 May 2020 02:30:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56846)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jbIEx-00014x-Ci
 for qemu-devel@nongnu.org; Wed, 20 May 2020 02:30:07 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:60996
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jbIEw-0006HU-Ad
 for qemu-devel@nongnu.org; Wed, 20 May 2020 02:30:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589956205;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0dhu8rTiswT7gyTshC9ljghjRP+wrr9cjv8+wBwdqhM=;
 b=T1SOnnKNPyK/QIuHbREpstJQO1WdVPQ35gWL86Wr3QiDlFxwFDFyno5Ey2F4sWxBaDF5d6
 88SagApYn0GUiCstKmstg4U976dNLx6ysnv3Nb/0GR/ToZGE67B+0H8RJchmt6FDVQGhdx
 +5QeBDvRwQhQTKJPIlGX+gbGeD23aEo=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-222-_-DadFjKOnSMBjSSRWy2Rw-1; Wed, 20 May 2020 02:30:03 -0400
X-MC-Unique: _-DadFjKOnSMBjSSRWy2Rw-1
Received: by mail-wr1-f69.google.com with SMTP id z16so940772wrq.21
 for <qemu-devel@nongnu.org>; Tue, 19 May 2020 23:30:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=0dhu8rTiswT7gyTshC9ljghjRP+wrr9cjv8+wBwdqhM=;
 b=sI6Ix6+HAcYB6zYMCiunC6xVgPMs7l7A/gX/WdL3uBIo1iVZoafglFwyNCHlewh3K0
 RHGPtrojijnOAkmsvCQuyk22AsludMlgYhRoMWzaXxb/e/thPqwjHTR7BE1aSsEtV1X+
 iWs7juhYblcMumFsbwFiCqFOPbqR43pczEFchoZZgex6AFcSUcJdpTZzUPXe7bIPb26l
 SEf4tsEYfUIWxPFdobbFAlufS+DpFaetzp+AFaWCfupetoUAd5Tzvvc+YHWF1ntQBZcn
 HczXXCf9p2AMFoLqYnOxRdVNShl9Df49WZRVBIpebZSGJZk9UGmI0BIgiBdDfMHCZiFl
 8Itg==
X-Gm-Message-State: AOAM530K73bRUpacMKGvA5oHxbP/JNGFr6aFWhNJF/+2bRJwk/bQhFLz
 Kc1gGMUExq2gKyOg5t/o0oA9d0Vosdryp5sk/Sj6vHuEIGSqYH44qRrav39FdYFATNvFt6dij9e
 zDsuUQFt6mx2x4e0=
X-Received: by 2002:a7b:c5cc:: with SMTP id n12mr3014616wmk.69.1589956202743; 
 Tue, 19 May 2020 23:30:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzMUApEqQzwfTKSjEoy+CQ4y4bFmRKNTHGTWUJ4xWJiu8ietHY5zVycI/20SdvXJ3Cr9peaog==
X-Received: by 2002:a7b:c5cc:: with SMTP id n12mr3014598wmk.69.1589956202501; 
 Tue, 19 May 2020 23:30:02 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:591e:368f:1f3f:27d2?
 ([2001:b07:6468:f312:591e:368f:1f3f:27d2])
 by smtp.gmail.com with ESMTPSA id 32sm1794708wrg.19.2020.05.19.23.30.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 May 2020 23:30:01 -0700 (PDT)
Subject: Re: [PATCH 08/55] qdev: Convert uses of qdev_create() with Coccinelle
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20200519145551.22836-1-armbru@redhat.com>
 <20200519145551.22836-9-armbru@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <87ca8eae-d100-9098-d3e9-91a7abca1e28@redhat.com>
Date: Wed, 20 May 2020 08:30:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200519145551.22836-9-armbru@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/20 02:22:41
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: berrange@redhat.com, ehabkost@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 19/05/20 16:55, Markus Armbruster wrote:
>     expression bus, type_name, dev;
>     @@
>     -    dev = qdev_create(bus, type_name);
>     +    dev = qdev_new(type_name);
>          ...
>     -    qdev_init_nofail(dev);
>     +    qdev_realize_and_unref(dev, bus, &error_fatal);
> 

> The first rule exempts hw/arm/highbank.c, because it matches along two
> control flow paths there, with different @type_name.  Covered by the
> next commit's manual conversions.

Slightly better way to express it:

     expression bus, type_name, dev;
     @@
     -    dev = qdev_create(bus, type_name);
     +    dev = qdev_new(type_name);
          ... when != dev = qdev_create(...)
     -    qdev_init_nofail(dev);
     +    qdev_realize_and_unref(dev, bus, &error_fatal);

(Just for documentation purposes, the patch is okay of course).

Paolo


