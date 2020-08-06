Return-Path: <SRS0=Z/nf=BQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBBF2C433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 13:48:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E99CB23128
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 13:48:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a8SsdXAc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E99CB23128
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51548 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3gFX-0004Vo-1j
	for qemu-devel@archiver.kernel.org; Thu, 06 Aug 2020 09:48:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54216)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k3gEm-0003xG-B7
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 09:47:16 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:48303
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k3gEj-00045n-US
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 09:47:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596721632;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YVPzBRvGODFCQEDGUcn1r93j5CLEPgsaI+4Rak7X6l0=;
 b=a8SsdXAccHc5ElXYkTrdbwO6Vqg3yeDSMgRN/cVjf4hqAt/g99HdgS1gwkunyZ4m9DHYW9
 f7RDsIi7yNzUfYcyk9Zf3HrQRFq12KMaONKR/Cg6RMUPsVgLtIMEQNA/decGgsIcQbWqtX
 50IzDXsQFQqCaB9xb0gBats8I73/bnY=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-219-uaCmD1wOM5GGIErgp1fp0w-1; Thu, 06 Aug 2020 09:47:09 -0400
X-MC-Unique: uaCmD1wOM5GGIErgp1fp0w-1
Received: by mail-wr1-f71.google.com with SMTP id e14so11337707wrr.7
 for <qemu-devel@nongnu.org>; Thu, 06 Aug 2020 06:47:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=YVPzBRvGODFCQEDGUcn1r93j5CLEPgsaI+4Rak7X6l0=;
 b=iX75zCo0iB6fYVLfb0+7ERWzCpHos+kmjrAZM65D1XcCBGonICXUIOKNlNdEJXcdYF
 UrtgHbdWYLsAkmWeIZxZCjWJIgD7DekyfDeVP3fEboielpfuUN/k/FmUiqWdaIsJahYE
 HKfswmKf0VDbajlAgiKDwoa20ejPBLOYB5svyx9+/G0Y+cB2DUwQMbFQXwQVHEr4zBsL
 yV9RrhBAN3vQtzAQtH7sum6hhAsqz7AY34CQbamXqOI9QgKOA1Wu7o0t4l4Lsw1hKcIT
 FcVHHo+K1Np+1R6tosFMaZyoEygNxMMBlxrfHetjRBw32t+WXh8zgjFL7IyHT4ClwH/c
 FH0g==
X-Gm-Message-State: AOAM530f5rEs9gyAaLNBlyLPu6fcqFBhJZO++xBSPuoBlp9CMJBkU8Xv
 PHT/4MAhZ5CfkdsBlqQaLfTpgpWT9fgJnhyjs0ATIPBFpWtWDrVgtQxxEMSJxenL4L+BZMkhPQ3
 p9P7cdzb5jlKxrBw=
X-Received: by 2002:adf:e712:: with SMTP id c18mr7955892wrm.92.1596721628741; 
 Thu, 06 Aug 2020 06:47:08 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwlNF4K05lJ+9P+D7gPqQK/X1HRj0L1KY6L2/QkvQTx11qolpsAdhR7GmL3CoXyFhND5+gg+Q==
X-Received: by 2002:adf:e712:: with SMTP id c18mr7955874wrm.92.1596721628512; 
 Thu, 06 Aug 2020 06:47:08 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:7841:78cc:18c6:1e20?
 ([2001:b07:6468:f312:7841:78cc:18c6:1e20])
 by smtp.gmail.com with ESMTPSA id m20sm16921540wmc.1.2020.08.06.06.47.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Aug 2020 06:47:07 -0700 (PDT)
Subject: Re: [PATCH v3 0/3] aio-posix: keep aio_notify_me disabled during
 polling
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
References: <20200806131802.569478-1-stefanha@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <9115f245-dc66-50d0-a53c-c8fa2f49334b@redhat.com>
Date: Thu, 6 Aug 2020 15:47:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200806131802.569478-1-stefanha@redhat.com>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/06 05:03:13
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Fam Zheng <fam@euphon.net>, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 06/08/20 15:17, Stefan Hajnoczi wrote:
> v3:
>  * Use smp_wmb() in aio_notify_accept() [Paolo]
>  * Flatten if statement in aio_poll() [Paolo]
> 
> v2:
>  * Added smp_mb() in aio_notify_accept() [Paolo]
>  * Added comments about memory barrier pairing [Paolo]
>  * Eliminated extra aio_compute_timeout() before calling ppoll()
> 
> This patch series eliminates ctx->notifier EventNotifier activity when
> aio_poll() is in polling mode. There is no need to use the EventNotifier since
> a polling handler can detect that aio_notify() has been called by monitoring a
> field in memory instead.
> 
> Optimizing out the EventNotifier calls improves null-co random read 4KB
> iodepth=1 IOPS by 18%.
> 
> I have not modified docs/spin/aio_notify*.promela because I'm not familiar with
> the SPIN model checker.
> 
> Stefan Hajnoczi (3):
>   async: rename event_notifier_dummy_cb/poll()
>   async: always set ctx->notified in aio_notify()
>   aio-posix: keep aio_notify_me disabled during polling
> 
>  util/aio-posix.c | 47 +++++++++++++++++++++++++----------------------
>  util/async.c     | 36 +++++++++++++++++++++++-------------
>  2 files changed, 48 insertions(+), 35 deletions(-)
> 

Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>

apart from a nit on patch 2.

Paolo


