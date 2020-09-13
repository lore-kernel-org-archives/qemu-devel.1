Return-Path: <SRS0=H3r+=CW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE2C5C43461
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Sep 2020 12:28:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 13B4D2158C
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Sep 2020 12:28:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13B4D2158C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=t-online.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56994 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHR7X-00076r-UY
	for qemu-devel@archiver.kernel.org; Sun, 13 Sep 2020 08:28:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48118)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vr_qemu@t-online.de>)
 id 1kHR6l-0006fp-Ui
 for qemu-devel@nongnu.org; Sun, 13 Sep 2020 08:27:51 -0400
Received: from mailout04.t-online.de ([194.25.134.18]:34834)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vr_qemu@t-online.de>)
 id 1kHR6j-0000RH-SV
 for qemu-devel@nongnu.org; Sun, 13 Sep 2020 08:27:51 -0400
Received: from fwd28.aul.t-online.de (fwd28.aul.t-online.de [172.20.26.133])
 by mailout04.t-online.de (Postfix) with SMTP id 556F441F36CC;
 Sun, 13 Sep 2020 14:27:46 +0200 (CEST)
Received: from [192.168.211.200]
 (Ew30H+ZVgh9dMLFjYCPQkMFLx8FWquFcC1xAJuc3bt9-JkPaD6Le6ZMCBblARadQxp@[46.86.49.25])
 by fwd28.t-online.de
 with (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384 encrypted)
 esmtp id 1kHR6S-49mWau0; Sun, 13 Sep 2020 14:27:32 +0200
From: =?UTF-8?Q?Volker_R=c3=bcmelin?= <vr_qemu@t-online.de>
Subject: Re: [PATCH] Fix video playback slowdown when spice client no audio
 enabled
To: zhou qi <atmgnd@outlook.com>
References: <SYBP282MB00121EE06C845D33A07413BAC9270@SYBP282MB0012.AUSP282.PROD.OUTLOOK.COM>
Message-ID: <ba86e0a0-4864-0881-f6ed-704ff90428fe@t-online.de>
Date: Sun, 13 Sep 2020 14:27:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <SYBP282MB00121EE06C845D33A07413BAC9270@SYBP282MB0012.AUSP282.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ID: Ew30H+ZVgh9dMLFjYCPQkMFLx8FWquFcC1xAJuc3bt9-JkPaD6Le6ZMCBblARadQxp
X-TOI-EXPURGATEID: 150726::1600000053-00000C65-CE23FD30/0/0 CLEAN NORMAL
X-TOI-MSGID: ba049b6f-ca19-41f1-a50e-a9a6310c1e35
Received-SPF: none client-ip=194.25.134.18; envelope-from=vr_qemu@t-online.de;
 helo=mailout04.t-online.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/13 08:27:46
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, FREEMAIL_FROM=0.001,
 NICE_REPLY_A=-0.001, RCVD_IN_BL_SPAMCOP_NET=1.347, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=no autolearn_force=no
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
Cc: =?UTF-8?B?Wm9sdMOhbiBLxZF2w6Fnw7M=?= <dirty.ice.hu@gmail.com>,
 Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 10.09.20 um 13:17 schrieb zhou qi:
> From e8c2e283f0954de255a32ea70d577d5e61992399 Mon Sep 17 00:00:00 2001
> From: Qi Zhou <atmgnd@outlook.com>
> Date: Thu, 10 Sep 2020 19:09:29 +0800
> Subject: [PATCH] Fix video playback slowdown when spice client no audio enabled
>
> You will get video playback slowdown on the following cases
>
> 1. use official spice client with audio channel disabled, use --spice-disable-audio
>    option
> 2. thirtpart client doesn't implement audio channel
>
> ref: https://github.com/qemu/qemu/commit/fb35c2cec58985f0b8d2733f1b91927542eeb3fd
> Signed-off-by: Qi Zhou <atmgnd@outlook.com>
> ---
>  audio/audio.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/audio/audio.c b/audio/audio.c
> index ce8c6dec5f..50febe190f 100644
> --- a/audio/audio.c
> +++ b/audio/audio.c
> @@ -1091,7 +1091,11 @@ static size_t audio_pcm_hw_run_out(HWVoiceOut *hw, size_t live)
>      while (live) {
>          size_t size, decr, proc;
>          void *buf = hw->pcm_ops->get_buffer_out(hw, &size);
> -        if (!buf || size == 0) {
> +
> +        if (!buf) {
> +            hw->mix_buf->pos = (hw->mix_buf->pos + live) % hw->mix_buf->size;
> +            return clipped + live;
> +        } else if ( size == 0) {
>              break;
>          }
>  

Hello Qi,

your patch breaks audio playback with the dsoundaudio backend.

I suggest you make the following changes:

- Test for size == 0 first and leave the loop in that case.
- For buf == NULL drop size bytes. Don't leave the loop with break or return.
- Verify all audio backends adhere to the new rules and fix them if necessary. It's quite possible no patches are needed.
- Rate limit the audio stream in function line_out_get_buffer() in audio/spiceaudio.c for the noaudio case too. Have a look at audio/spiceaudio.c at version v4.1.0. The code there was correct.

Please don't forget to run scripts/checkpatch.pl on your next patches and don't forget to CC the maintainer.

With best regards,

Volker

