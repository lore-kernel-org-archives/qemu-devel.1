Return-Path: <SRS0=kYy5=B4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2772EC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2020 22:20:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E471A206DA
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2020 22:20:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=hostfission.com header.i=@hostfission.com header.b="Wy19zLWN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E471A206DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=hostfission.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38444 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k89yQ-0002L2-4J
	for qemu-devel@archiver.kernel.org; Tue, 18 Aug 2020 18:20:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54272)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <geoff@hostfission.com>)
 id 1k89xk-0001pZ-Av
 for qemu-devel@nongnu.org; Tue, 18 Aug 2020 18:20:12 -0400
Received: from mail1.hostfission.com ([139.99.139.48]:55724)
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <geoff@hostfission.com>) id 1k89xi-0002RT-5j
 for qemu-devel@nongnu.org; Tue, 18 Aug 2020 18:20:12 -0400
Received: from www1.hostfission.com (www1.hostfission.com [139.99.139.52])
 by mail1.hostfission.com (Postfix) with ESMTP id 6634C42708;
 Wed, 19 Aug 2020 08:20:07 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=hostfission.com;
 s=mail; t=1597789207;
 bh=Isj0FyH1LjwFv4LagRJDx71QbeZWUK4i3oclvGklVZ8=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=Wy19zLWNWYc5s9RiUe70cB+lLe2NDWkW+84COirrNH/3FFWLVaVKKndN0G4X29bKY
 n28vqwMFUtFqH39lOcbxE9HA5nzlUdjQCsLdNUs0PJ/q6lXA4Kbr5Tz2cSx5iBTqe7
 oGOXi6VNkhogQJ3ZDLFmSClr0MqDDnBIumFJM0N0=
Received: from mail.hostfission.com (www1.hostfission.com [127.0.0.1])
 by www1.hostfission.com (Postfix) with ESMTP id 58C929D947;
 Wed, 19 Aug 2020 08:20:07 +1000 (AEST)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date: Wed, 19 Aug 2020 08:20:07 +1000
From: Geoffrey McRae <geoff@hostfission.com>
To: Christian Schoenebeck <qemu_oss@crudebyte.com>
Cc: qemu-devel@nongnu.org, kraxel@redhat.com
Subject: Re: [PATCH] audio/jack: fix use after free segfault
In-Reply-To: <11253274.hK5Fc7SEp3@silver>
References: <20200818131206.BB75F3A0B9F@moya.office.hostfission.com>
 <11253274.hK5Fc7SEp3@silver>
Message-ID: <fdfc3c5e5ef6c19c82bfaf5503011659@hostfission.com>
X-Sender: geoff@hostfission.com
User-Agent: Roundcube Webmail/1.3.8
Received-SPF: pass client-ip=139.99.139.48; envelope-from=geoff@hostfission.com;
 helo=mail1.hostfission.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/18 18:20:08
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 2020-08-19 04:11, Christian Schoenebeck wrote:
> On Dienstag, 18. August 2020 14:40:36 CEST Geoffrey McRae wrote:
>> Due to a ridiculous commit in the Jack library, the client may have 
>> been
>> freed already by a secondary audio device recovering its session.
>> 
>> https://github.com/jackaudio/jack2/issues/627
>> 
>> Until there is a proper fix for this we can not risk using the pointer
>> at all if we have been notified of a shutdown as it may have been 
>> freed
>> by the jack library, as such the close call is commented out to 
>> prevent
>> a use after free segfault.
>> 
>> At this time, this will not cause a memory leak as the recovery 
>> routine
>> will trigger the "cleanup" code in the jack library, however, if this 
>> is
>> ever corrected in the jack library this will need to be revisited.
>> 
>> Signed-off-by: Geoffrey McRae <geoff@hostfission.com>
>> ---
>>  audio/jackaudio.c | 17 ++++++++++++++++-
>>  1 file changed, 16 insertions(+), 1 deletion(-)
>> 
>> diff --git a/audio/jackaudio.c b/audio/jackaudio.c
>> index 72ed7c4929..e8faf1bb89 100644
>> --- a/audio/jackaudio.c
>> +++ b/audio/jackaudio.c
>> @@ -563,7 +563,22 @@ static void qjack_client_fini(QJackClient *c)
>>          /* fallthrough */
>> 
>>      case QJACK_STATE_SHUTDOWN:
>> -        jack_client_close(c->client);
>> +        /*
>> +         * Due to a rediculous commit in the Jack library, the client 
>> may
>> have +         * been freed already.
> 
> No need to be offending, and especially no need to insult Stéphane in 
> QEMU
> code.

Fair enough, I was not intending to offend Stéphane, and I apologize for 
this.
I will revise this patch.

> 
> Could you please describe in more detail how you ran into this 
> situation with
> your 2nd audio device?

Sure. Run a Windows guest with two audio devices, let it boot up, then 
restart
the jack service to trigger the recovery routine, then attempt to use 
the 2nd
(non-primary) audio device. Ie, go to windows audio settings to test the
microphone of the second audio device.

When windows try to use the 2nd audio device it goes through the 
recovery
routine triggering this fault.

> 
>> +         *
>> +         * Until there is a proper fix for this we can not risk using 
>> the
>> +         * pointer at all if we have been notified of a shutdown, as 
>> such
>> the +         * below line is commented out to prevent a use after 
>> free
>> segfault. +         * This will not cause a memory leak as the 
>> recovery
>> routine will trigger +         * the "cleanup" code in the jack 
>> library.
>> +         *
>> +         *
>> https://github.com/jackaudio/jack2/commit/171a3c4a0ddd18d2afae56f3af6291c8e
>> 96ee3ac +         */
>> +
>> +        //jack_client_close(c->client);
>> +        c->client = NULL;
>> +
>>          /* fallthrough */
> 
> Are you aware that there are two distinct variants of JACK? They are 
> commonly
> referred to as JACK1 vs. JACK2 and despite their names, they are in 
> fact
> completely separate implementations and there are people who prefer one 
> over
> the other. Your change would affect JACK1 as well.

I am aware and since these libraries are interchangeable I had assumed 
that
JACK1 will have the same fault. If not I suppose we need to detect which 
is in
use and change this code appropriately.

> 
> Best regards,
> Christian Schoenebeck

