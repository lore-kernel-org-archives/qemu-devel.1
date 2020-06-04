Return-Path: <SRS0=1Qun=7R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 633F4C433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 19:02:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E50F9206C3
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 19:02:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PrAYZKBg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E50F9206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37590 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgv8W-0002G1-PV
	for qemu-devel@archiver.kernel.org; Thu, 04 Jun 2020 15:02:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41820)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jgv7d-0001mS-8i
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 15:01:49 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:40211
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jgv7a-0005BQ-EK
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 15:01:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591297305;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BkSts/kBHp3NPZTcL5X+yQie/Fi4vU9PB7G5KtCCNp4=;
 b=PrAYZKBghTxED4A+TnItMjDz1lmN9/vxVifzJgjJhhejC4yedyE7CAXb+dwf/22vAQ2Pug
 nk78fQ0Kzf8b79/d3uCXbyjFW00aC2KU/TwbsprDWanwphnXI4ASUGTOB3R7zJ3kCDIgrt
 +BZpGKRiTdPxlRl9lF5V3CYbhOukano=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-359-93sFXZLNOpSjZpl2JVbxOQ-1; Thu, 04 Jun 2020 15:01:42 -0400
X-MC-Unique: 93sFXZLNOpSjZpl2JVbxOQ-1
Received: by mail-wr1-f71.google.com with SMTP id c14so2777848wrm.15
 for <qemu-devel@nongnu.org>; Thu, 04 Jun 2020 12:01:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=BkSts/kBHp3NPZTcL5X+yQie/Fi4vU9PB7G5KtCCNp4=;
 b=O8wD8mpe+hcky1rRx8S90loBz2CjeH9gPnccZTjj8mi18gnhV2v0bnDqoSh01llQM/
 T4qlIydgumdo0pGRhYmXOnbwEIgUthtB1scVh98QwgnbSDSqGugncWIWmb8Ei7osJoR6
 M4iEf6Bd/K/2iCldMQQIJzADgciNxeanPqgaLFlXkjniZZoRuL5s1QuylOqkWvqt58Yp
 huIc6y8Wwo1agznEwawjf08GSBSGZnpPRS9E3a3+deg2Xi3KRGGcS+omSll7NMx6PgSA
 FkylWfLUzeWmK4BtWxMXFpSfNlcUKvAcMNsLx8mGYLPR49THQe1xbqVbSmnWoWQBaKXo
 9zDw==
X-Gm-Message-State: AOAM532qtXBukLJ2w5rWv1ZrYiEdMN0Z9Ci5BnwB/q5Efn/MM472QT48
 ySc/a1DtY5i7ek5DkbNVwrUFF063xP4VfuPeoeCHOcavBhXpT+mJUJTX6+G6kMYlRsYEplNBwx3
 HERz1UP6H4aEZOjE=
X-Received: by 2002:adf:ef50:: with SMTP id c16mr5606704wrp.161.1591297301429; 
 Thu, 04 Jun 2020 12:01:41 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyTKNuJdY9LK8NZddYkZzytSm6j2kqHnR6EKkjzWj7CW/qT2rxqPsbV/WYMLHzyuB3TpyRfBA==
X-Received: by 2002:adf:ef50:: with SMTP id c16mr5606686wrp.161.1591297301196; 
 Thu, 04 Jun 2020 12:01:41 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:a0c0:5d2e:1d35:17bb?
 ([2001:b07:6468:f312:a0c0:5d2e:1d35:17bb])
 by smtp.gmail.com with ESMTPSA id z9sm8054038wmi.41.2020.06.04.12.01.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 04 Jun 2020 12:01:40 -0700 (PDT)
Subject: Re: [PATCH] replay: fix replay shutdown for console mode
To: Pavel Dovgalyuk <Pavel.Dovgaluk@gmail.com>, qemu-devel@nongnu.org
References: <159012995470.27967.18129611453659045726.stgit@pasha-ThinkPad-X280>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <d2890d62-92e0-d96b-3bc7-0ded8affb63b@redhat.com>
Date: Thu, 4 Jun 2020 21:01:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <159012995470.27967.18129611453659045726.stgit@pasha-ThinkPad-X280>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/04 01:31:23
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: dovgaluk@ispras.ru, alex.bennee@linaro.org, pavel.dovgaluk@ispras.ru,
 rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 22/05/20 08:45, Pavel Dovgalyuk wrote:
> When QEMU is used without any graphical window,
> QEMU execution is terminated with the signal (e.g., Ctrl-C).
> Signal processing in QEMU does not include
> qemu_system_shutdown_request call. That is why shutdown
> event is not recorded by record/replay in this case.
> This patch adds shutdown event to the end of the record log.
> Now every replay will shutdown the machine at the end.
> 
> Signed-off-by: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
> ---
>  0 files changed
> 
> diff --git a/replay/replay.c b/replay/replay.c
> index 53edad1377..83ed9e0e24 100644
> --- a/replay/replay.c
> +++ b/replay/replay.c
> @@ -366,6 +366,11 @@ void replay_finish(void)
>      /* finalize the file */
>      if (replay_file) {
>          if (replay_mode == REPLAY_MODE_RECORD) {
> +            /*
> +             * Can't do it in the signal handler, therefore
> +             * add shutdown event here for the case of Ctrl-C.
> +             */
> +            replay_shutdown_request(SHUTDOWN_CAUSE_HOST_SIGNAL);
>              /* write end event */
>              replay_put_event(EVENT_END);
>  
> 

Queued, thanks.

Paolo


