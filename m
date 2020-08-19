Return-Path: <SRS0=bVMU=B5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CAF3C433E4
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 11:46:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EEA0A23107
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 11:46:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=hostfission.com header.i=@hostfission.com header.b="YRhAsPOT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EEA0A23107
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=hostfission.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55424 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8MXu-0007Ds-5q
	for qemu-devel@archiver.kernel.org; Wed, 19 Aug 2020 07:46:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55854)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <geoff@hostfission.com>)
 id 1k8MXD-0006oE-59
 for qemu-devel@nongnu.org; Wed, 19 Aug 2020 07:45:39 -0400
Received: from mail1.hostfission.com ([139.99.139.48]:36706)
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <geoff@hostfission.com>) id 1k8MXA-0003NZ-UH
 for qemu-devel@nongnu.org; Wed, 19 Aug 2020 07:45:38 -0400
Received: from www1.hostfission.com (www1.hostfission.com [139.99.139.52])
 by mail1.hostfission.com (Postfix) with ESMTP id 7BCBC42749;
 Wed, 19 Aug 2020 21:45:33 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=hostfission.com;
 s=mail; t=1597837533;
 bh=jESawSZ6n07Nz+N9KgAzemb6FO2Y5vUWbfkvGoaLsYc=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=YRhAsPOTnY/uLLzRWMtBqArEpsMbEeaRocLEue1hVbK78zzCtn0cuSA3FE3T1rfqp
 d1O86usCUKlKcWtnDB7iUDXaI0ysPQVB8tigxx3HiXaR98qQhuRdRGfh3xrKw55FVV
 JxM/Eh40I/cXRndY3y8vAPZFxAoIgFIVFITFeGl0=
Received: from mail.hostfission.com (www1.hostfission.com [127.0.0.1])
 by www1.hostfission.com (Postfix) with ESMTP id 693889D947;
 Wed, 19 Aug 2020 21:45:33 +1000 (AEST)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Wed, 19 Aug 2020 21:45:33 +1000
From: Geoffrey McRae <geoff@hostfission.com>
To: Christian Schoenebeck <qemu_oss@crudebyte.com>
Cc: qemu-devel@nongnu.org, kraxel@redhat.com
Subject: Re: [PATCH] audio/jack: fix use after free segfault
In-Reply-To: <2255329.JDkKyqenvo@silver>
References: <20200818131206.BB75F3A0B9F@moya.office.hostfission.com>
 <11253274.hK5Fc7SEp3@silver>
 <fdfc3c5e5ef6c19c82bfaf5503011659@hostfission.com>
 <2255329.JDkKyqenvo@silver>
Message-ID: <fdec112034e900c2d8408a634aa184b6@hostfission.com>
X-Sender: geoff@hostfission.com
User-Agent: Roundcube Webmail/1.3.8
Received-SPF: pass client-ip=139.99.139.48; envelope-from=geoff@hostfission.com;
 helo=mail1.hostfission.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/19 07:45:35
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

On 2020-08-19 21:30, Christian Schoenebeck wrote:
> On Mittwoch, 19. August 2020 00:20:07 CEST Geoffrey McRae wrote:
>> > Could you please describe in more detail how you ran into this
>> > situation with
>> > your 2nd audio device?
>> 
>> Sure. Run a Windows guest with two audio devices, let it boot up, then
>> restart
>> the jack service to trigger the recovery routine, then attempt to use
>> the 2nd
>> (non-primary) audio device. Ie, go to windows audio settings to test 
>> the
>> microphone of the second audio device.
>> 
>> When windows try to use the 2nd audio device it goes through the
>> recovery
>> routine triggering this fault.
> 
> I still don't quite get how this correlates. So you are forcing a 
> restart of
> jackd on host side in between, for what purpose? To simulate the 
> Windows
> client being kicked by jackd?

For many reasons jack may need to be stopped and started again, such as 
hardware changes when switching to a USB audio device, or tuning the 
period size, etc. QEMU should be able to recover if the jack server goes 
away, it's that simple.

The following sequence is what triggers this fault.

   client1 = jack_client_open();
   client2 = jack_client_open();

client1 gets a shutdown signal

   jack_client_close(client1);
   client1 = jack_client_open();

client2 gets a shutdown signal

   jack_client_close(client2);
   client2 = jack_client_open();

One would expect this sequence to work fine as it conforms to the JACK 
documentation and common design practice, however, the call to 
`jack_client_open` notices that there is the 2nd session and frees it 
out from under the application.

This has been resolved in the v5 patch as suggested by Gerd by 
scheduling a QEMUBH to perform the closures so they occur in order 
before an attempt to open again. Even still this is clearly a design 
flaw in the Jack2 library.

> 
> What latencies do you achieve BTW with Windows guests?
> 

Never tested, it's not the reason why I use jack. Suffice to say it's 
far better than PulseAudio, I get no stuttering issues like is commonly 
reported for ALSA and PA, and allows for a high degree of 
reconfigurability. The guest VM overall performs far better also as 
windows is never waiting on the audio device due to the decoupling 
provided by the ring buffer in my implementation.

>> I am aware and since these libraries are interchangeable I had assumed
>> that
>> JACK1 will have the same fault. If not I suppose we need to detect 
>> which
>> is in
>> use and change this code appropriately.
> 
> I haven't checked this in the JACK1 code base yet, but I assume JACK1 
> does not
> behave like JACK2 here, because the JACK API is very clear that it is 
> the
> client's responsibility to free itself.
> 
> So it looks like a JACK2-only-bug to me.

Confirmed, this was investigated today.

> 
> Very weird that there is no jack_client_version() in the shared weak 
> API (i.e.
> missing on JACK1 side).

I raised this as an issue today: 
https://github.com/jackaudio/jack2/issues/628
The developer there seems to feel that allowing the application to know 
the jack client version is a bad thing.

> 
> Best regards,
> Christian Schoenebeck

