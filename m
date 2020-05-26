Return-Path: <SRS0=4PQo=7I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03DC9C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 20:19:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B9A862088E
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 20:19:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GuZdbyTQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9A862088E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47920 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdg2o-00080N-VT
	for qemu-devel@archiver.kernel.org; Tue, 26 May 2020 16:19:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57530)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jdg23-0007Z5-Sr
 for qemu-devel@nongnu.org; Tue, 26 May 2020 16:18:39 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:40809
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jdg22-0003F7-E2
 for qemu-devel@nongnu.org; Tue, 26 May 2020 16:18:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590524317;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=X/JmBVw3TBngYIyFIhJC1yFwQ0e/cw0+/l4FMDL7MQw=;
 b=GuZdbyTQT1NPf1cs2llF+guzEil/Kk2k9opMBBNtUWs1R4s843fDpb8IpbC7ImEowKNeOt
 jvzvl2B5W7X2TvOtLCaEuRCQs/ruWmTG3Ta/XKmVvylF/cm6Fxam6RCtwjBuGb6pfcE6xL
 JVNGBhKnx76tsfI/T+fYJFMcyMkUerw=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-445-qO_-3VPnN_aDYk2vETmxVw-1; Tue, 26 May 2020 16:18:35 -0400
X-MC-Unique: qO_-3VPnN_aDYk2vETmxVw-1
Received: by mail-ed1-f70.google.com with SMTP id o12so9417015edj.12
 for <qemu-devel@nongnu.org>; Tue, 26 May 2020 13:18:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=X/JmBVw3TBngYIyFIhJC1yFwQ0e/cw0+/l4FMDL7MQw=;
 b=JLcgdFDCA28sndLGYundx0RH7EVdrzvaJ2UkcI6xzhESBUbiurGWMj2e2cd1XeUDsq
 v5lQqS2Ql5Xg7HYZ0C5zv8dRVauC590z94DrmB5BSIN22ZPthO+ORGKQq7AGbOco4lsU
 0oht0IOG/fXYnE8ofAUVVl6LU2vCUNmJL/XeNJ5hqymVrhZiGPGUcINFf7ZXIKhGHLow
 gaGsgsYyQw29pkwDloL7v5kcq3CRLD186RXeuvxVx4JeZK3p5HJoeZUntt9T55TxFB3h
 eR6KhRtcSGGzhlQDPuU9WXM9eQoOv1KgBo0qFWM0eoj+AUenKnZe8J0vO38Po7r+Nnm+
 G4UQ==
X-Gm-Message-State: AOAM532mxU2Y6Gwriflvta875Kkq8Fl/9PAXk/+nU+rgTCAASRyJF+W/
 +6mFjCyGeYoB8abHWXKiPxMPzot4tF5m+9FLZqi4P3hspl5E0g9D7nRqOScFZ7VCVm41Vv2WKM9
 voXidktGEvTHim/Q=
X-Received: by 2002:a17:907:11cb:: with SMTP id
 va11mr2766478ejb.515.1590524314532; 
 Tue, 26 May 2020 13:18:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzPaheatzxkHB/ZcWWA0gq9Rpc/nakrG9zAwxJI5YAPy7XCrtCn+SoAoxSEBvcspgv2ICBHDA==
X-Received: by 2002:a17:907:11cb:: with SMTP id
 va11mr2766458ejb.515.1590524314296; 
 Tue, 26 May 2020 13:18:34 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:3c1c:ffba:c624:29b8?
 ([2001:b07:6468:f312:3c1c:ffba:c624:29b8])
 by smtp.gmail.com with ESMTPSA id y26sm272929edv.91.2020.05.26.13.18.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 May 2020 13:18:33 -0700 (PDT)
Subject: Re: [PATCH 16/19] util: fixed tsan warnings in thread_pool.c
To: Robert Foley <robert.foley@linaro.org>, qemu-devel@nongnu.org
References: <20200522160755.886-1-robert.foley@linaro.org>
 <20200522160755.886-17-robert.foley@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <ff3314f8-3dbc-3ad0-3726-80a2eea832b9@redhat.com>
Date: Tue, 26 May 2020 22:18:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200522160755.886-17-robert.foley@linaro.org>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/26 01:51:57
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: peter.puhov@linaro.org, cota@braap.org, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 22/05/20 18:07, Robert Foley wrote:
>  #include "trace.h"
>  #include "block/thread-pool.h"
>  #include "qemu/main-loop.h"
> +#include "qemu/tsan.h"
>  
>  static void do_spawn_thread(ThreadPool *pool);
>  
> @@ -97,7 +98,9 @@ static void *worker_thread(void *opaque)
>          }
>  
>          req = QTAILQ_FIRST(&pool->request_list);
> +        TSAN_ANNOTATE_IGNORE_WRITES_BEGIN();
>          QTAILQ_REMOVE(&pool->request_list, req, reqs);
> +
>          req->state = THREAD_ACTIVE;
>          qemu_mutex_unlock(&pool->lock);
>  
> @@ -107,7 +110,7 @@ static void *worker_thread(void *opaque)
>          /* Write ret before state.  */
>          smp_wmb();
>          req->state = THREAD_DONE;
> -
> +        TSAN_ANNOTATE_IGNORE_WRITES_END();

You should instead use atomic_read/set for req->state and req->ret.

Paolo


