Return-Path: <SRS0=QZTr=DB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DD65C4363D
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 17:46:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C0B8E2311B
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 17:46:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0B8E2311B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=t-online.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36992 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLVJl-0001aS-O1
	for qemu-devel@archiver.kernel.org; Thu, 24 Sep 2020 13:46:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53910)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vr_qemu@t-online.de>)
 id 1kLVGX-0008K4-1o
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 13:42:47 -0400
Received: from mailout08.t-online.de ([194.25.134.20]:33922)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vr_qemu@t-online.de>)
 id 1kLVGU-00017w-JI
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 13:42:44 -0400
Received: from fwd28.aul.t-online.de (fwd28.aul.t-online.de [172.20.26.133])
 by mailout08.t-online.de (Postfix) with SMTP id BE0D34117A5D;
 Thu, 24 Sep 2020 19:42:36 +0200 (CEST)
Received: from [192.168.211.200]
 (bLfARiZOQhIQBCgu-k9o7IbTPZBTBAL2PcRaTwKMdbNITiiBrmw8mI5q9et9ulsgdG@[46.86.52.225])
 by fwd28.t-online.de
 with (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384 encrypted)
 esmtp id 1kLVGO-23ncGW0; Thu, 24 Sep 2020 19:42:36 +0200
From: =?UTF-8?Q?Volker_R=c3=bcmelin?= <vr_qemu@t-online.de>
Subject: Re: [PATCH 8/9] audio: restore mixing-engine playback buffer size
To: Gerd Hoffmann <kraxel@redhat.com>
References: <84f1c61a-8399-c75e-96c2-febfc2dd5fab@t-online.de>
 <20200920171729.15861-8-vr_qemu@t-online.de>
 <20200923063605.hatwdgbnvaxcgmn7@sirius.home.kraxel.org>
Message-ID: <e1cc9b2b-c53c-9195-73ae-fcbec7049c5f@t-online.de>
Date: Thu, 24 Sep 2020 19:42:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200923063605.hatwdgbnvaxcgmn7@sirius.home.kraxel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ID: bLfARiZOQhIQBCgu-k9o7IbTPZBTBAL2PcRaTwKMdbNITiiBrmw8mI5q9et9ulsgdG
X-TOI-EXPURGATEID: 150726::1600969356-00000C65-B36B5F90/0/0 CLEAN NORMAL
X-TOI-MSGID: 373b45c2-4b45-4564-beba-694c9a807189
Received-SPF: none client-ip=194.25.134.20; envelope-from=vr_qemu@t-online.de;
 helo=mailout08.t-online.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/24 13:42:37
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, FREEMAIL_FROM=0.001,
 NICE_REPLY_A=-0.214, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Cc: qemu-devel <qemu-devel@nongnu.org>,
 =?UTF-8?B?Wm9sdMOhbiBLxZF2w6Fnw7M=?= <dirty.ice.hu@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

>> diff --git a/audio/sdlaudio.c b/audio/sdlaudio.c
>> index 21b7a0484b..cb931d0fda 100644
>> --- a/audio/sdlaudio.c
>> +++ b/audio/sdlaudio.c
>> @@ -253,6 +253,7 @@ static void sdl_callback (void *opaque, Uint8 *buf, int len)
>>          return ret;                                                     \
>>      }
>>  
>> +SDL_WRAPPER_FUNC(buffer_get_free, size_t, (HWVoiceOut *hw), (hw))
>>  SDL_WRAPPER_FUNC(get_buffer_out, void *, (HWVoiceOut *hw, size_t *size),
>>                   (hw, size), *size = 0, sdl_unlock)
>>  SDL_WRAPPER_FUNC(put_buffer_out, size_t,
> Compiling C object libcommon.fa.p/audio_sdlaudio.c.o
> ../../audio/sdlaudio.c:256:65: error: macro "SDL_WRAPPER_FUNC" requires 6 arguments, but only 4 given
>   256 | SDL_WRAPPER_FUNC(buffer_get_free, size_t, (HWVoiceOut *hw), (hw))
>       |                                                                 ^
> ../../audio/sdlaudio.c:243: note: macro "SDL_WRAPPER_FUNC" defined here
>   243 | #define SDL_WRAPPER_FUNC(name, ret_type, args_decl, args, fail, unlock) \
>       | 
> ../../audio/sdlaudio.c:256:17: error: expected ‘;’ before ‘static’
>   256 | SDL_WRAPPER_FUNC(buffer_get_free, size_t, (HWVoiceOut *hw), (hw))
>       |                 ^
>       |                 ;
> ../../audio/sdlaudio.c:355:24: error: ‘sdl_buffer_get_free’ undeclared here (not in a function)
>   355 |     .buffer_get_free = sdl_buffer_get_free,
>       |                        ^~~~~~~~~~~~~~~~~~~
> make: *** [Makefile.ninja:1113: libcommon.fa.p/audio_sdlaudio.c.o] Error 1
>
> (I think coreaudio has the same problem ...).
>
> take care,
>   Gerd
>

Sorry. This was caused by a bad rebase and my tests were insufficient. I guess I'll send my sdlaudio patches next. This patch has to wait.

With best regards,
Volker

