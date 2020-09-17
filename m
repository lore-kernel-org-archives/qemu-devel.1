Return-Path: <SRS0=BocF=C2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89070C43461
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 17:23:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF497221E3
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 17:23:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF497221E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=t-online.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42276 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIxcd-0007WN-GE
	for qemu-devel@archiver.kernel.org; Thu, 17 Sep 2020 13:23:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37376)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vr_qemu@t-online.de>)
 id 1kIxc6-000764-SB
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 13:22:30 -0400
Received: from mailout12.t-online.de ([194.25.134.22]:41840)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vr_qemu@t-online.de>)
 id 1kIxc4-00087j-Rh
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 13:22:30 -0400
Received: from fwd07.aul.t-online.de (fwd07.aul.t-online.de [172.20.27.150])
 by mailout12.t-online.de (Postfix) with SMTP id 135B8419993E;
 Thu, 17 Sep 2020 19:22:24 +0200 (CEST)
Received: from [192.168.211.200]
 (Zqk3LeZFrhPRmgctF+lsFMbAxBIIazw2Hxe-C2Cuw0S5Oc1i7P1bveOq6Ksw6V3Qvq@[46.86.63.61])
 by fwd07.t-online.de
 with (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384 encrypted)
 esmtp id 1kIxbx-1GFEp60; Thu, 17 Sep 2020 19:22:21 +0200
From: =?UTF-8?Q?Volker_R=c3=bcmelin?= <vr_qemu@t-online.de>
Subject: Re: [PATCH] Fix video playback slowdown when spice client no audio
 enabled
To: zhou qi <atmgnd@outlook.com>
References: <SYBP282MB00121EE06C845D33A07413BAC9270@SYBP282MB0012.AUSP282.PROD.OUTLOOK.COM>
 <ba86e0a0-4864-0881-f6ed-704ff90428fe@t-online.de>
Message-ID: <e3006ac7-b92b-40b0-e3b8-15b81a26647c@t-online.de>
Date: Thu, 17 Sep 2020 19:22:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <ba86e0a0-4864-0881-f6ed-704ff90428fe@t-online.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ID: Zqk3LeZFrhPRmgctF+lsFMbAxBIIazw2Hxe-C2Cuw0S5Oc1i7P1bveOq6Ksw6V3Qvq
X-TOI-EXPURGATEID: 150726::1600363341-0000DD00-2175BA65/0/0 CLEAN NORMAL
X-TOI-MSGID: aa7da026-2745-4b07-8573-f9bb708ead1d
Received-SPF: none client-ip=194.25.134.22; envelope-from=vr_qemu@t-online.de;
 helo=mailout12.t-online.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/17 13:22:24
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, FREEMAIL_FROM=0.001,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


> Hello Qi,
>
> your patch breaks audio playback with the dsoundaudio backend.
>
> I suggest you make the following changes:
>
> - Test for size == 0 first and leave the loop in that case.
> - For buf == NULL drop size bytes. Don't leave the loop with break or return.
> - Verify all audio backends adhere to the new rules and fix them if necessary. It's quite possible no patches are needed.
> - Rate limit the audio stream in function line_out_get_buffer() in audio/spiceaudio.c for the noaudio case too. Have a look at audio/spiceaudio.c at version v4.1.0. The code there was correct.
>
> Please don't forget to run scripts/checkpatch.pl on your next patches and don't forget to CC the maintainer.
>
> With best regards,
>
> Volker

Hello Qi,

I wonder if you are already working on an improved fix. Otherwise I will send my patches this weekend to the mailing list.

With best regards,
Volker


