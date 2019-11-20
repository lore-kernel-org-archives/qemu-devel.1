Return-Path: <SRS0=6hMH=ZM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95845C432C3
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 00:38:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 616942240C
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 00:38:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E1Vn5QL4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 616942240C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52650 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXE0d-0003Xb-JW
	for qemu-devel@archiver.kernel.org; Tue, 19 Nov 2019 19:38:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39938)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dirty.ice.hu@gmail.com>) id 1iXDzE-00030m-Ia
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 19:36:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dirty.ice.hu@gmail.com>) id 1iXDzD-0005bm-GP
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 19:36:48 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:32939)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <dirty.ice.hu@gmail.com>)
 id 1iXDzD-0005ZM-Ap
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 19:36:47 -0500
Received: by mail-wm1-x342.google.com with SMTP id a17so3784063wmb.0
 for <qemu-devel@nongnu.org>; Tue, 19 Nov 2019 16:36:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:subject:to:references:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=EcaBl1iAkqXXdZ42dZQOLzpmqgniP2RIP2t1QB6QtUM=;
 b=E1Vn5QL4loSjWvI6jKuyYgAaGfKyV2NG86VrL1++v3KwZHIEN7uu3ddV7V7qDDm4R2
 eLlYyTBR1fFJRPfnhnxCnHQJzPdWgvB05PNshgTMauC+5q0q4GPwN/0yTxBwKwHWcfPU
 Ozu5bCqemSrrLelwFiojB/aRA2XGe8VrapDXDcGHC6LTWdILeqNe45GZ00Xtv63LgKRQ
 q4M5lhG5uXaIb5BznekS7Lu2P3+KfXuRNpnQA9qE3fuHL0pR4lWUu+k6EXC1lFj8cAMU
 N0LNdb8P2u/hrpTYo0kqPUGfVgPxlJzHJ9/dp1Sdl5LYQbx0tNW6d5GWwY9utpelWvbR
 /7Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:subject:to:references:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=EcaBl1iAkqXXdZ42dZQOLzpmqgniP2RIP2t1QB6QtUM=;
 b=ISmFFA/8xPPgm9xnxUVeUuN6pXZCGg19AuJ/1Ak9xNQQHHiXs9uIATOlizudToXu7F
 94dC5obq7FowZTZ3EnFoQw0dDn/s82LaqfDqCNloSC7H+lHuktTqFNNVD49o9IEWILuc
 D15hL+GP39huvX1I3xnYGEgxCPuNJbrigOC03z9HnYFI2T7JQmFPjJOQ+udlKPXWDmhp
 sNTInJneHpzbOxDMTkc6bdStexRLVMx5j3q/xokjwWocGlGLi8wUChse8ZdqFlZUwDFX
 jesV30a6nJiHKLQWydUI7OU0zysKvMjlMDTq3h45sToU/exGfRbZfVC289LVqqcZLIaH
 mgOg==
X-Gm-Message-State: APjAAAWcFRU1zFUa/zxHKJgcypqLRhSeIxQ4YLwFh+TZE27gdGacWDHK
 SaV5UQIo2KQTxllMQeEfYZ4jqqJG
X-Google-Smtp-Source: APXvYqz42WIgfn86VfZey4YDaTKV/eKHQRt0JBPG8NpaZyAd5BCw0NyeKZVS+0VBB9ilYRLcca6iEA==
X-Received: by 2002:a1c:39c1:: with SMTP id g184mr117562wma.75.1574210203594; 
 Tue, 19 Nov 2019 16:36:43 -0800 (PST)
Received: from ?IPv6:fd00:835b:d940:d4fc:1::1b?
 (2a01-036c-0113-0d0a-0001-0000-0000-001b.pool6.digikabel.hu.
 [2a01:36c:113:d0a:1::1b])
 by smtp.gmail.com with ESMTPSA id k1sm29731233wrp.29.2019.11.19.16.36.42
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 19 Nov 2019 16:36:43 -0800 (PST)
From: "=?UTF-8?B?Wm9sdMOhbiBLxZF2w6Fnw7M=?=" <dirty.ice.hu@gmail.com>
X-Google-Original-From: =?UTF-8?B?Wm9sdMOhbiBLxZF2w6Fnw7M=?=
 <DirtY.iCE.hu@gmail.com>
Subject: Re: [PATCH] audio: fix audio recording
To: =?UTF-8?Q?Volker_R=c3=bcmelin?= <vr_qemu@t-online.de>,
 Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
References: <2fc947cf-7b42-de68-3f11-cbcf1c096be9@t-online.de>
Message-ID: <5a934a46-cf4b-1134-2682-441d1506ae1e@gmail.com>
Date: Wed, 20 Nov 2019 01:36:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <2fc947cf-7b42-de68-3f11-cbcf1c096be9@t-online.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
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

On 2019-11-19 07:58, Volker Rümelin wrote:
> With current code audio recording with all audio backends
> except PulseAudio and DirectSound is broken. The generic audio
> recording buffer management forgot to update the current read
> position after a read.

Indeed, pos_emul is updated in audio_generic_put_buffer_out_nowrite but 
it's never updated on the capture end.  I tested it with alsa and 
hda-micro and it fixes the problem (that is, if I add in.try-poll=off, 
but I need that for output too).

Thanks.

> 
> Fixes: ff095e5231 "audio: api for mixeng code free backends"
> 
> Signed-off-by: Volker Rümelin <vr_qemu@t-online.de>
Reviewed-by: Zoltán Kővágó <DirtY.iCE.hu@gmail.com>

> ---
>   audio/audio.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/audio/audio.c b/audio/audio.c
> index 7fc3aa9d16..56fae55047 100644
> --- a/audio/audio.c
> +++ b/audio/audio.c
> @@ -1390,6 +1390,7 @@ void *audio_generic_get_buffer_in(HWVoiceIn *hw, size_t *size)
>           size_t read = hw->pcm_ops->read(hw, hw->buf_emul + hw->pos_emul,
>                                           read_len);
>           hw->pending_emul += read;
> +        hw->pos_emul = (hw->pos_emul + read) % hw->size_emul;
>           if (read < read_len) {
>               break;
>           }
> 


