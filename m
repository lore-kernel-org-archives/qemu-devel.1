Return-Path: <SRS0=vczr=7A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EB66C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 11:24:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA948206D4
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 11:24:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MVlkt29R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA948206D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49490 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jadt7-0002Qw-2E
	for qemu-devel@archiver.kernel.org; Mon, 18 May 2020 07:24:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40152)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jadsa-0001wP-EW
 for qemu-devel@nongnu.org; Mon, 18 May 2020 07:24:20 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:26851
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jadsY-0008RP-St
 for qemu-devel@nongnu.org; Mon, 18 May 2020 07:24:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589801057;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8b7SIVmJcPxZQRtuKK/ErsjbRd3Sjcsi8EHh2GNBBwU=;
 b=MVlkt29RqweN0gDpCkLiNHkzg+TBQChqrWkpdmxCTQfhRTbMi2Qz9LKExaR5XRY/5Gwlvz
 nBx5MOF+2vCY3HfbaACYcUxUrRahC4eRme2wBTt+QUHvL2vjn1iViwd/nPu+1/UouGfp13
 qdRed1DDlPu2uj7Bqhvp3LK4ldpkKlw=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-82-3Bg-zP0GMmepLRw18Onz_g-1; Mon, 18 May 2020 07:24:15 -0400
X-MC-Unique: 3Bg-zP0GMmepLRw18Onz_g-1
Received: by mail-wm1-f72.google.com with SMTP id t82so2862019wmf.4
 for <qemu-devel@nongnu.org>; Mon, 18 May 2020 04:24:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=8b7SIVmJcPxZQRtuKK/ErsjbRd3Sjcsi8EHh2GNBBwU=;
 b=l9+wlsOiuMMg/nBUS0Loie/9hmYug+/WumcO9QNMqB8TM2FRY8t0hQmxm9MnlqUtrh
 6HxnB1ElxvIFOSHwNMJ4f2iG3SmBnBx8Tk10JLZt0X8XV5ZfZN0JItlUZvP9S4H6YXz1
 uCMyhHGRcuQ3K72mH6Bc+UNtZEsmlq8F2NPlGdLl+8qYm7LzM2XlCiI0J+bCjTWY+8ur
 Yl4ajhiVusq0bVPwFGmw8jDzeQtn1Rk4bYraFvuvuapDxiBvXul2fslvjyAuCfDpmfWC
 giuXlkRrCRij2333uD0I/ZFp+KU2JHygNE2bYJBRKapSh6e0l0Y6DV8qr3KoTu/6Ms15
 E7vA==
X-Gm-Message-State: AOAM533Zi0r+t4WAnjva0ApJQ5kPJT21Ru14jj0NVFyF278gueZVWqsa
 e7pDHDfSuGSNFB8rdpSvALb+uVQMdlKt+rJdeWLJVBK+Y+lJA4YlzLcJVMpkT9t4gWpX9SDawGF
 vzlzLnPJTpfqUoPo=
X-Received: by 2002:adf:c508:: with SMTP id q8mr18404586wrf.4.1589801054277;
 Mon, 18 May 2020 04:24:14 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzeXEm/q5KfGVNEZyIwY+qwv1kygU+H1ekbcrgS9ErQNUTrR8xN2LGygdGpkgEhkORjY83RLA==
X-Received: by 2002:adf:c508:: with SMTP id q8mr18404558wrf.4.1589801054032;
 Mon, 18 May 2020 04:24:14 -0700 (PDT)
Received: from [192.168.1.38] (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id r9sm15952464wmg.47.2020.05.18.04.24.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 May 2020 04:24:13 -0700 (PDT)
Subject: Re: [PATCH] replay: synchronize on every virtual timer callback
To: Pavel Dovgalyuk <Pavel.Dovgaluk@gmail.com>, qemu-devel@nongnu.org
References: <158875304273.3986.105601155554744438.stgit@pasha-ThinkPad-X280>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <c74e9498-75b4-d80c-e380-3d448497cfd0@redhat.com>
Date: Mon, 18 May 2020 13:24:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <158875304273.3986.105601155554744438.stgit@pasha-ThinkPad-X280>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/17 22:51:00
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, pbonzini@redhat.com,
 dovgaluk@ispras.ru, pavel.dovgaluk@ispras.ru
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

+ Alex

On 5/6/20 10:17 AM, Pavel Dovgalyuk wrote:
> Sometimes virtual timer callbacks depend on order
> of virtual timer processing and warping of virtual clock.
> Therefore every callback should be logged to make replay deterministic.
> This patch creates a checkpoint before every virtual timer callback.
> With these checkpoints virtual timers processing and clock warping
> events order is completely deterministic.
> 
> Signed-off-by: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
> ---
>   util/qemu-timer.c |    5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/util/qemu-timer.c b/util/qemu-timer.c
> index d548d3c1ad..47833f338f 100644
> --- a/util/qemu-timer.c
> +++ b/util/qemu-timer.c
> @@ -588,6 +588,11 @@ bool timerlist_run_timers(QEMUTimerList *timer_list)
>           qemu_mutex_lock(&timer_list->active_timers_lock);
>   
>           progress = true;
> +        /*
> +         * Callback may insert new checkpoints, therefore add new checkpoint
> +         * for the virtual timers.
> +         */
> +        need_replay_checkpoint = timer_list->clock->type == QEMU_CLOCK_VIRTUAL;
>       }
>       qemu_mutex_unlock(&timer_list->active_timers_lock);
>   
> 
> 


