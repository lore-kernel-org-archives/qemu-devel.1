Return-Path: <SRS0=QiA4=7D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9574AC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 13:23:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 56D9B20671
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 13:23:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S3imNF1a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56D9B20671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58002 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jblAe-0005wT-EY
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 09:23:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54926)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jbl9v-0005RH-E4
 for qemu-devel@nongnu.org; Thu, 21 May 2020 09:22:51 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:51733
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jbl9q-0003QZ-JV
 for qemu-devel@nongnu.org; Thu, 21 May 2020 09:22:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590067365;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=f8wLQSganH09R5FvG66b9ppP1XdPlGjsrGuvM2cjgWc=;
 b=S3imNF1ajXBYplrX8koNy590mw7Q9iIQZ6fIVUowEW3oFqahHf1JrzPshFnTIVNCLPr63T
 odNqswswS+Y2TCxfToU9uF+uBtm0mDgmFSqn1jPFEDZDZMcU+osw9zMKsu/3CXixOT1+Sa
 gGZ1O9o/az8dfnfZtkddDWK45FsjduY=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-37-u3h9r4EmNRKl95bv8gYx8Q-1; Thu, 21 May 2020 09:22:43 -0400
X-MC-Unique: u3h9r4EmNRKl95bv8gYx8Q-1
Received: by mail-wm1-f69.google.com with SMTP id f62so2705848wme.3
 for <qemu-devel@nongnu.org>; Thu, 21 May 2020 06:22:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=f8wLQSganH09R5FvG66b9ppP1XdPlGjsrGuvM2cjgWc=;
 b=oalMM1jyb0Nf1fwFg03qYRxAtoBCFtADWRMDaJe1SwgjaRswq5isj6ryVGjUtC/x+S
 H0eBGKAXhBEMBYymK+KcD6Uvc8a3T5135+jY+FiC7AytaHfnD+ZtT6JJo48fK5zJjQbF
 /RejdoXzEEGEJcyVDrVZhSKdTTYXxk+v9Bb28/m2+S1iR22qRzCYiciIb8ZOcVlpvc50
 36IdYFLv6VifxOwsyBFc1TtWOZzIL1IMn8YzbwyrnZOoXjCED5eUpjkALSLU/uXIiZsx
 cDDcNo7a7Vbe56HL2VV9fPJ4IVQbI5Sid+dnrRil08LHZETYFTJZ5oKWHoM2lw6RY3PI
 4zhQ==
X-Gm-Message-State: AOAM5333Gy6k7H4NcSo5kKErjLHyfo3zWKvx3O1zaj1cilHWLXiqC5ui
 P0fB8T/a2IojkPGAE/ioa7w6yK2V6Q18IsYGqDOLP3HWTrDiPXovY1oZrjmgfTYPVO2JvEk4th8
 LHO8PWS/PcrHPvmc=
X-Received: by 2002:adf:9264:: with SMTP id 91mr8413896wrj.362.1590067361922; 
 Thu, 21 May 2020 06:22:41 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwp5xv2mJhyBPr1w3qSrId/GLU144ipgJ41VQ09L2evXjKGsZ3fh2W7Onikxu33iFUn+61SCA==
X-Received: by 2002:adf:9264:: with SMTP id 91mr8413877wrj.362.1590067361645; 
 Thu, 21 May 2020 06:22:41 -0700 (PDT)
Received: from [192.168.178.58] ([151.30.94.134])
 by smtp.gmail.com with ESMTPSA id n7sm5364359wrj.39.2020.05.21.06.22.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 21 May 2020 06:22:41 -0700 (PDT)
Subject: Re: [PATCH] replay: synchronize on every virtual timer callback
To: Pavel Dovgalyuk <Pavel.Dovgaluk@gmail.com>, qemu-devel@nongnu.org
References: <158875304273.3986.105601155554744438.stgit@pasha-ThinkPad-X280>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <0a778b07-3d20-90f3-9b8e-69f035c6f11b@redhat.com>
Date: Thu, 21 May 2020 15:22:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <158875304273.3986.105601155554744438.stgit@pasha-ThinkPad-X280>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/21 01:44:25
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
Cc: dovgaluk@ispras.ru, pavel.dovgaluk@ispras.ru
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 06/05/20 10:17, Pavel Dovgalyuk wrote:
> Sometimes virtual timer callbacks depend on order
> of virtual timer processing and warping of virtual clock.
> Therefore every callback should be logged to make replay deterministic.
> This patch creates a checkpoint before every virtual timer callback.
> With these checkpoints virtual timers processing and clock warping
> events order is completely deterministic.
> 
> Signed-off-by: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
> ---
>  util/qemu-timer.c |    5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/util/qemu-timer.c b/util/qemu-timer.c
> index d548d3c1ad..47833f338f 100644
> --- a/util/qemu-timer.c
> +++ b/util/qemu-timer.c
> @@ -588,6 +588,11 @@ bool timerlist_run_timers(QEMUTimerList *timer_list)
>          qemu_mutex_lock(&timer_list->active_timers_lock);
>  
>          progress = true;
> +        /*
> +         * Callback may insert new checkpoints, therefore add new checkpoint
> +         * for the virtual timers.
> +         */
> +        need_replay_checkpoint = timer_list->clock->type == QEMU_CLOCK_VIRTUAL;

You need to check replay_mode != REPLAY_MODE_NONE, either here or in the
"if (need_replay_checkpoint)" above.  If you choose the latter, you can
remove the other "if (replay_mode != REPLAY_MODE_NONE)".

Also, there is a comment that says that checkpointing "must only be done
once since the clock value stays the same".  Is that actually a "can"
rather than a "must"?  Should the central replay logic have something
like a checkpoint count, that prevents adding back-to-back equal
checkpoints?

Thanks,

Paolo

>      }
>      qemu_mutex_unlock(&timer_list->active_timers_lock);
>  
> 


