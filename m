Return-Path: <SRS0=1Qun=7R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF7E7C433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 17:59:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 80548206DC
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 17:59:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="in/IpWah"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80548206DC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51380 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgu9F-0005Kg-Rk
	for qemu-devel@archiver.kernel.org; Thu, 04 Jun 2020 13:59:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34638)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jgu8V-0004O7-V7
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 13:58:40 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:35298
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jgu8U-0000di-UR
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 13:58:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591293517;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LhWVh1sG46RZz53mRIu/yaSVt+QBXHJoE4gi09btuMs=;
 b=in/IpWahdUv9K7zDNRZI5Ytf0i1RmiTfZg2CFesITtCvUbGOKIqdJTb2YYM/02SEoH1S/z
 /jqYp3hmQUYuA/Gg6jlFcnMBq8ppjwbdadBQZvgn+konFk6L0O4vvanSMUe7SH/WiA2ZA6
 w5Y698ks7VO2OO3/Bs2Phv3b1kkN88k=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-237-ElWxcQ0nMc-miY3IQcZqAw-1; Thu, 04 Jun 2020 13:58:34 -0400
X-MC-Unique: ElWxcQ0nMc-miY3IQcZqAw-1
Received: by mail-wr1-f72.google.com with SMTP id r5so2730481wrt.9
 for <qemu-devel@nongnu.org>; Thu, 04 Jun 2020 10:58:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=LhWVh1sG46RZz53mRIu/yaSVt+QBXHJoE4gi09btuMs=;
 b=smeB5zeMxfBxg4pwdWEVIw042aCeBk8s6VzlM8YMeLmdNAdoLJdHq4UIIEB4tra1g+
 LSonY0Ly9P9oEMgr8scS2Iu6bZvNcIJYrQSvThgMQd932CHJFMdi0cnJYcWnOK0H9T01
 KfS9dPGvyzhonK4oRSSRImRmMXEmQUEbuIi4efJrCuAYSVx9SXM6ufjUXyrPl6ypji9v
 3pQVIMmChjcuj6uH2LfBzkejY1/ifdZCtGoIoWtdaQqTQU2nC6EtjoxCtinOss2bshp5
 a/GXY9BOWKAVX0eCq18MwIwoOj/TkQBF8qXpVYGE3+V0SsR100Ybnld37NYzZ49a9TXY
 vhmA==
X-Gm-Message-State: AOAM533qypQ+ysb5CF5tjIxBQIhMtKOUU58Lm0ZU/9Cuhfi/2JAJ7Y+W
 pWPJdJOMoA8FkmrXgRs4jQFtGGoBcnY9TPqTsaXfQsGt8Kr00Ix9Ze+8OgE0ZqcMWSgQ+rdDy4i
 8H8B5VslYln4gmk4=
X-Received: by 2002:adf:ff8a:: with SMTP id j10mr5423028wrr.405.1591293512673; 
 Thu, 04 Jun 2020 10:58:32 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz3SvlWt4WXyuwiK6kGxd/aOHf+/ttC66W8COzSo5cU/GqXubmQGFNL2T2QAWryY+BWUpm3Pw==
X-Received: by 2002:adf:ff8a:: with SMTP id j10mr5423014wrr.405.1591293512435; 
 Thu, 04 Jun 2020 10:58:32 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:a0c0:5d2e:1d35:17bb?
 ([2001:b07:6468:f312:a0c0:5d2e:1d35:17bb])
 by smtp.gmail.com with ESMTPSA id t14sm9753441wrb.94.2020.06.04.10.58.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 04 Jun 2020 10:58:31 -0700 (PDT)
Subject: Re: [PATCH v4] exec: set map length to zero when returning NULL
To: P J P <ppandit@redhat.com>
References: <20200526111743.428367-1-ppandit@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <4b738d8e-6285-e845-8ad7-6be469d6a912@redhat.com>
Date: Thu, 4 Jun 2020 19:58:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200526111743.428367-1-ppandit@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/04 13:58:37
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 Prasad J Pandit <pjp@fedoraproject.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Alexander Bulekov <alxndr@bu.edu>,
 Ding Ren <rding@gatech.edu>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 26/05/20 13:17, P J P wrote:
> From: Prasad J Pandit <pjp@fedoraproject.org>
> 
> When mapping physical memory into host's virtual address space,
> 'address_space_map' may return NULL if BounceBuffer is in_use.
> Set and return '*plen = 0' to avoid later NULL pointer dereference.
> 
> Reported-by: Alexander Bulekov <alxndr@bu.edu>
> Fixes: https://bugs.launchpad.net/qemu/+bug/1878259
> Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
> ---
>  exec.c                | 1 +
>  include/exec/memory.h | 3 ++-
>  2 files changed, 3 insertions(+), 1 deletion(-)
> 
> Update v4: update address_space_map API doc text
>   -> https://lists.gnu.org/archive/html/qemu-devel/2020-05/msg07281.html
> 
> diff --git a/exec.c b/exec.c
> index 5162f0d12f..4eea84bf66 100644
> --- a/exec.c
> +++ b/exec.c
> @@ -3538,6 +3538,7 @@ void *address_space_map(AddressSpace *as,
>  
>      if (!memory_access_is_direct(mr, is_write)) {
>          if (atomic_xchg(&bounce.in_use, true)) {
> +            *plen = 0;
>              return NULL;
>          }
>          /* Avoid unbounded allocations */
> diff --git a/include/exec/memory.h b/include/exec/memory.h
> index e000bd2f97..8fa2d3cab2 100644
> --- a/include/exec/memory.h
> +++ b/include/exec/memory.h
> @@ -2303,7 +2303,8 @@ bool address_space_access_valid(AddressSpace *as, hwaddr addr, hwaddr len,
>  /* address_space_map: map a physical memory region into a host virtual address
>   *
>   * May map a subset of the requested range, given by and returned in @plen.
> - * May return %NULL if resources needed to perform the mapping are exhausted.
> + * May return %NULL and set *@plen to zero(0), if resources needed to perform
> + * the mapping are exhausted.
>   * Use only for reads OR writes - not for read-modify-write operations.
>   * Use cpu_register_map_client() to know when retrying the map operation is
>   * likely to succeed.
> 

Queued, thanks.

Paolo


