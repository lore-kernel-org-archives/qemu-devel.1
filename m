Return-Path: <SRS0=QiA4=7D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 160E4C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 13:49:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C9DF820721
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 13:49:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AupomTDT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9DF820721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34920 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jblZI-0002NH-1v
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 09:49:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57796)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jblXp-0000wv-TR
 for qemu-devel@nongnu.org; Thu, 21 May 2020 09:47:33 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:60312
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jblXp-0008M9-28
 for qemu-devel@nongnu.org; Thu, 21 May 2020 09:47:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590068852;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=22kMKhD3/Ao22UujdifKz0W3gvmf2AHQLXPRG+K7/ik=;
 b=AupomTDT8suEgDj7zFkIRTxXFZx+DDTBYHwkkGUzAWwfn29N3PcD1zB+FbrponVSLOiGSe
 pe6Os4R/sFXZ2aRu8ubxxT6brBWgP1mHTeRw7hl2YHBPGaWzvktrcQUNV9R7Sv4zi7vdmO
 Z+Jynqe3oOv9cMIPYu6Q9ZppfF0kLGw=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-332-lhnyUaoMM66c2BmFkYTlvg-1; Thu, 21 May 2020 09:47:30 -0400
X-MC-Unique: lhnyUaoMM66c2BmFkYTlvg-1
Received: by mail-wr1-f70.google.com with SMTP id g10so2945558wrr.10
 for <qemu-devel@nongnu.org>; Thu, 21 May 2020 06:47:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=22kMKhD3/Ao22UujdifKz0W3gvmf2AHQLXPRG+K7/ik=;
 b=ZWZYUzVTchGq0ExXHvnZqt8079MA6XhFBi6iSnvxPrxTLLDwBobmSjqShyvsICTgb+
 NkdD8P60W8A13FlJLOnRiL7e4oP8FwYhcyye4dCnM6m/EOK2iFplWJ0pnX8S6HzU0mpQ
 GaFuVgBKbWbB95q725lbRBpWSJUA5xdH3mxM6CoEAKxepW28wMZCXvYzsvudaIdaphsN
 18uPLVM7nuphhcjXbSPvLb2E1iiBSAssbR3i0KmvcDumhgPa7GLQdRQnbLNaL70Wl2qD
 dQUH46OS+Kf7MwhPujxXixI50zVFkuhpYDpPc1MrRiASpe9L03qx/J/h0OBlj570jB20
 ow/w==
X-Gm-Message-State: AOAM532P3KoBqcAmAk9n4C06MiqnbGs2T7d0DjK13IBrmZo9tIZvUCo0
 gq/VSJbTTgbLPT8C+nqfvszJL/Edx9AEeXjYSWlvFdR1zQ/KNMftWXRlWv6Ufm71BWbPSB6WdY5
 0hRiWvFqss9D6Rf0=
X-Received: by 2002:a5d:6ca7:: with SMTP id a7mr8478418wra.391.1590068848865; 
 Thu, 21 May 2020 06:47:28 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy5zluWsqLqxKDXXwb8AIyUHG+Ud2dZitlxIiEE34iEhlTQYGUzUKNXxOXoo7DYRd7BrBFHQA==
X-Received: by 2002:a5d:6ca7:: with SMTP id a7mr8478397wra.391.1590068848659; 
 Thu, 21 May 2020 06:47:28 -0700 (PDT)
Received: from [192.168.178.58] ([151.30.94.134])
 by smtp.gmail.com with ESMTPSA id u7sm6340817wmm.8.2020.05.21.06.47.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 21 May 2020 06:47:28 -0700 (PDT)
Subject: Re: [PATCH] icount: fix shift=auto for record/replay
To: Pavel Dovgalyuk <Pavel.Dovgaluk@gmail.com>, qemu-devel@nongnu.org
References: <158988500050.15192.692077802469400393.stgit@pasha-ThinkPad-X280>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <84ea9a6a-c325-3725-d728-2f8ac513761a@redhat.com>
Date: Thu, 21 May 2020 15:47:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <158988500050.15192.692077802469400393.stgit@pasha-ThinkPad-X280>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/21 01:47:40
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
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
Cc: dovgaluk@ispras.ru, alex.bennee@linaro.org, pavel.dovgaluk@ispras.ru,
 rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 19/05/20 12:43, Pavel Dovgalyuk wrote:
> This patch fixes shift=auto when record/replay is enabled.
> Now user does not need to guess the best shift value.
> 
> Signed-off-by: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>

Queued, thanks!

Paolo

> --
> 
> v2:
>   moved icount_time_shift to vmstate subsection
> ---
>  cpus.c |   20 +++++++++++++++++++-
>  1 file changed, 19 insertions(+), 1 deletion(-)
> 
> diff --git a/cpus.c b/cpus.c
> index 5670c96bcf..7ce0d569b3 100644
> --- a/cpus.c
> +++ b/cpus.c
> @@ -379,7 +379,8 @@ static void icount_adjust(void)
>  
>      seqlock_write_lock(&timers_state.vm_clock_seqlock,
>                         &timers_state.vm_clock_lock);
> -    cur_time = cpu_get_clock_locked();
> +    cur_time = REPLAY_CLOCK_LOCKED(REPLAY_CLOCK_VIRTUAL_RT,
> +                                   cpu_get_clock_locked());
>      cur_icount = cpu_get_icount_locked();
>  
>      delta = cur_icount - cur_time;
> @@ -647,6 +648,11 @@ static bool adjust_timers_state_needed(void *opaque)
>      return s->icount_rt_timer != NULL;
>  }
>  
> +static bool shift_state_needed(void *opaque)
> +{
> +    return use_icount == 2;
> +}
> +
>  /*
>   * Subsection for warp timer migration is optional, because may not be created
>   */
> @@ -674,6 +680,17 @@ static const VMStateDescription icount_vmstate_adjust_timers = {
>      }
>  };
>  
> +static const VMStateDescription icount_vmstate_shift = {
> +    .name = "timer/icount/shift",
> +    .version_id = 1,
> +    .minimum_version_id = 1,
> +    .needed = shift_state_needed,
> +    .fields = (VMStateField[]) {
> +        VMSTATE_INT16(icount_time_shift, TimersState),
> +        VMSTATE_END_OF_LIST()
> +    }
> +};
> +
>  /*
>   * This is a subsection for icount migration.
>   */
> @@ -690,6 +707,7 @@ static const VMStateDescription icount_vmstate_timers = {
>      .subsections = (const VMStateDescription*[]) {
>          &icount_vmstate_warp_timer,
>          &icount_vmstate_adjust_timers,
> +        &icount_vmstate_shift,
>          NULL
>      }
>  };
> 


