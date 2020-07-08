Return-Path: <SRS0=/TnL=AT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF80FC433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 20:10:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BDC7A206F6
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 20:10:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDC7A206F6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=t-online.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43366 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtGP0-0001Xr-1q
	for qemu-devel@archiver.kernel.org; Wed, 08 Jul 2020 16:10:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42178)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vr_qemu@t-online.de>)
 id 1jtGOL-00011z-Ky
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 16:10:05 -0400
Received: from mailout05.t-online.de ([194.25.134.82]:57522)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vr_qemu@t-online.de>)
 id 1jtGOJ-0000GT-Hz
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 16:10:05 -0400
Received: from fwd19.aul.t-online.de (fwd19.aul.t-online.de [172.20.27.65])
 by mailout05.t-online.de (Postfix) with SMTP id 9E55342322F5;
 Wed,  8 Jul 2020 22:09:58 +0200 (CEST)
Received: from [192.168.211.200]
 (Vrn1sgZHQhAzr9JcOe1UhAVIcMlWszGlJiE+qyJYKhrhTj-EMdnq+QeZlhJUdI1Ze5@[93.236.146.213])
 by fwd19.t-online.de
 with (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384 encrypted)
 esmtp id 1jtGO0-13WJVY0; Wed, 8 Jul 2020 22:09:44 +0200
Subject: Re: [PATCH] ossaudio: fix out of bounds write
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>
References: <20200707180836.5435-1-vr_qemu@t-online.de>
 <4591613b-067d-ac5d-99d0-d8b7a3cf0ce1@redhat.com>
From: =?UTF-8?Q?Volker_R=c3=bcmelin?= <vr_qemu@t-online.de>
Message-ID: <82608aa1-33d6-4b72-1ff3-a426f38178cd@t-online.de>
Date: Wed, 8 Jul 2020 22:09:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <4591613b-067d-ac5d-99d0-d8b7a3cf0ce1@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ID: Vrn1sgZHQhAzr9JcOe1UhAVIcMlWszGlJiE+qyJYKhrhTj-EMdnq+QeZlhJUdI1Ze5
X-TOI-EXPURGATEID: 150726::1594238984-00008954-A77F6702/0/0 CLEAN NORMAL
X-TOI-MSGID: 276cd162-5121-4705-9219-7a7d816892b7
Received-SPF: none client-ip=194.25.134.82; envelope-from=vr_qemu@t-online.de;
 helo=mailout05.t-online.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/08 16:09:59
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Cc: QEMU <qemu-devel@nongnu.org>,
 =?UTF-8?B?Wm9sdMOhbiBLxZF2w6Fnw7M=?= <dirty.ice.hu@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

> On 7/7/20 8:08 PM, Volker Rümelin wrote:
>> In function oss_read() a read error currently does not exit the
>> read loop. With no data to read the variable pos will quickly
>> underflow and a subsequent successful read overwrites memory
>> outside the buffer. This patch adds the missing break statement
>> to the error path of the function.
> Correct, but ...
>
>> To reproduce start qemu with -audiodev oss,id=audio0 and in the
>> guest start audio recording. After some time this will trigger
>> an exception.
>>
>> Fixes: 3ba4066d08 "ossaudio: port to the new audio backend api"
>>
>> Signed-off-by: Volker Rümelin <vr_qemu@t-online.de>
>> ---
>>  audio/ossaudio.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/audio/ossaudio.c b/audio/ossaudio.c
>> index f88d076ec2..a7dcaa31ad 100644
>> --- a/audio/ossaudio.c
>> +++ b/audio/ossaudio.c
>> @@ -691,6 +691,7 @@ static size_t oss_read(HWVoiceIn *hw, void *buf, size_t len)
>>                             len, dst);
>>                  break;
>>              }
>> +            break;
>>          }
>>  
>>          pos += nread;
> ... now pos += -1, then the size returned misses the last byte.
>
Hi Philippe,

no, the added break breaks the while loop. The next executed instruction after this break is the return pos statement not pos += nread.

With best regards,
Volker


