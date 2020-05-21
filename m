Return-Path: <SRS0=QiA4=7D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61E7DC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 20:11:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 243F5207D3
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 20:11:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TzCuWDDp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 243F5207D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55834 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbrXC-0001gg-Al
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 16:11:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43604)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jbrVA-0006zN-RG
 for qemu-devel@nongnu.org; Thu, 21 May 2020 16:09:12 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:56582
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jbrV9-0001lZ-LT
 for qemu-devel@nongnu.org; Thu, 21 May 2020 16:09:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590091750;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=05lmqT28wOTGpDq0NU4Vr+Wn7HgWlo7JgstrrZQtcdY=;
 b=TzCuWDDpMsA9DEmA2HMgfplEV1sisQBjdtlcnCORU8LWOShiXlSG74pBGlousimBrX55n8
 zM8joGrHSLcBRVCpdccr2QOcErGgm+SWye1IIuzlIx0y34eEve17FzAA7ciU3g8ZewhUa4
 py2jtNWMqgv5N+I89Xl3tYDnngboLHw=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-334-Ua5xiKp7PbWCTGgj5T0Z2Q-1; Thu, 21 May 2020 16:09:08 -0400
X-MC-Unique: Ua5xiKp7PbWCTGgj5T0Z2Q-1
Received: by mail-wr1-f72.google.com with SMTP id x8so3365747wrl.16
 for <qemu-devel@nongnu.org>; Thu, 21 May 2020 13:09:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=05lmqT28wOTGpDq0NU4Vr+Wn7HgWlo7JgstrrZQtcdY=;
 b=dhoJDo4QDHIFEclZwe76lkaou1UQrUqkMGUiNkePx6enI650kYPT+3yggUxRScG2wE
 QlxDmTBc4o5fbLeommu75/sEhs7ZEG9QqV8Mix6t3vFz9kyntTk6oUUjsH6709zgUEYg
 3X7npCLTMUkCyLN1opmMdaUDYRzb5/MZVG0RR9BQKruNgpUPcOLu7bCE7ugOOWq0gv/h
 7Ead7JdeG3fwLqQunG8CFVxc6do7UXth31JbVPGTtX/srxzodm4j4ZhfARHRRO9B6Xb1
 H9Skiz+TJ/18A3uoWRQllwkoCpAopzJxE17Rqn6bnnttfkO3jbmkAX52EfcR2PSBUeSO
 rwZA==
X-Gm-Message-State: AOAM530Jfe/ZIiNPXdW4JY3oRVerANN5YTpudJKrIlZjxRaPt0PmeprL
 o/EdZg0zorFU8nYrxU86Cnh9XPO641swNmg4IgteL92WYht0Pzp8bbMvGjFwXiaqrkvWwx/7lbB
 1ffhfxxS3rbcLTEk=
X-Received: by 2002:a05:6000:1c5:: with SMTP id
 t5mr251825wrx.229.1590091747259; 
 Thu, 21 May 2020 13:09:07 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzxkwyVTfamuBmFjTldqdcgo8d/ExAJjQ1D4AEqZMDouxmAq8s6zDOZQbhgU8wwvL56MS8heg==
X-Received: by 2002:a05:6000:1c5:: with SMTP id
 t5mr251810wrx.229.1590091747005; 
 Thu, 21 May 2020 13:09:07 -0700 (PDT)
Received: from [192.168.1.40] (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id w15sm7255692wmi.35.2020.05.21.13.09.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 21 May 2020 13:09:06 -0700 (PDT)
Subject: Re: [PATCH] audio: fix wavcapture segfault
To: Bruce Rogers <brogers@suse.com>, qemu-devel@nongnu.org
References: <20200521172931.121903-1-brogers@suse.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <cb96a6b7-8dd4-1cef-f7de-2149b29a0192@redhat.com>
Date: Thu, 21 May 2020 22:09:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200521172931.121903-1-brogers@suse.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=philmd@redhat.com;
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
Cc: kraxel@redhat.com, dirty.ice.hu@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/21/20 7:29 PM, Bruce Rogers wrote:
> Commit 571a8c522e caused the HMP wavcapture command to segfault when
> processing audio data in audio_pcm_sw_write(), where a NULL
> sw->hw->pcm_ops is dereferenced. This fix checks that the pointer is
> valid before dereferincing it. A similar fix is also made in the
> parallel function audio_pcm_sw_read().
> 
> Fixes: 571a8c522e (audio: split ctl_* functions into enable_* and
> volume_*)
> Signed-off-by: Bruce Rogers <brogers@suse.com>
> ---
>   audio/audio.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/audio/audio.c b/audio/audio.c
> index 7a9e680355..08a067722b 100644
> --- a/audio/audio.c
> +++ b/audio/audio.c
> @@ -649,7 +649,7 @@ static size_t audio_pcm_sw_read(SWVoiceIn *sw, void *buf, size_t size)
>           total += isamp;
>       }
>   
> -    if (!hw->pcm_ops->volume_in) {
> +    if (hw->pcm_ops && !hw->pcm_ops->volume_in) {
>           mixeng_volume (sw->buf, ret, &sw->vol);
>       }
>   
> @@ -736,7 +736,7 @@ static size_t audio_pcm_sw_write(SWVoiceOut *sw, void *buf, size_t size)
>       if (swlim) {
>           sw->conv (sw->buf, buf, swlim);
>   
> -        if (!sw->hw->pcm_ops->volume_out) {
> +        if (sw->hw->pcm_ops && !sw->hw->pcm_ops->volume_out) {
>               mixeng_volume (sw->buf, swlim, &sw->vol);
>           }
>       }
> 

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>


