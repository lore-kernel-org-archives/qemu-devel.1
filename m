Return-Path: <SRS0=bVMU=B5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A079C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 12:42:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D293206B5
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 12:42:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="EWRTJPrM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D293206B5
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45354 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8NQF-00041n-E5
	for qemu-devel@archiver.kernel.org; Wed, 19 Aug 2020 08:42:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43876)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1k8NPe-00037I-1M
 for qemu-devel@nongnu.org; Wed, 19 Aug 2020 08:41:54 -0400
Received: from lizzy.crudebyte.com ([91.194.90.13]:50555)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1k8NPb-0002g2-MF
 for qemu-devel@nongnu.org; Wed, 19 Aug 2020 08:41:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=lizzy; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Content-ID:Content-Description;
 bh=xgdWGINa39Xjy59JWXRhGzjBwPj5GnRCm6uvicveXrI=; b=EWRTJPrMxWoqnKxwk8efcIUFml
 KhueEr3dmD8C8OIWSRlDlEzpyr6ASzN7zfYvTspoJ/624gmJss5fOZxfgzSex8t1G/a91BOUTmWXk
 O5n9Imm/SqPvv5lKxQYnWZX+dI0MCNaSYZCwd13GsD/gv4qfs94iRRSxKlifA9LZ91TeWam1iEDV1
 giekXJ2a0Piet7qSlfdLt8KvWLV2s9Sx6RSAl+zNv64g5522OXxqVhZrRUL9TzAyFFbaU0V5K3ka7
 xuEKQzLPeM0euoa+CZGBxIVM3bPkciFFivJdJPT8yWI4X2PS3W6fmjn8AQ6wJW+F+3IeYskRbs5qg
 N+I2hb1Q==;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
To: qemu-devel@nongnu.org
Cc: Geoffrey McRae <geoff@hostfission.com>, kraxel@redhat.com
Subject: Re: [PATCH] audio/jack: fix use after free segfault
Date: Wed, 19 Aug 2020 14:41:48 +0200
Message-ID: <1858869.V9CTJjVLrA@silver>
In-Reply-To: <fdec112034e900c2d8408a634aa184b6@hostfission.com>
References: <20200818131206.BB75F3A0B9F@moya.office.hostfission.com>
 <2255329.JDkKyqenvo@silver>
 <fdec112034e900c2d8408a634aa184b6@hostfission.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Received-SPF: pass client-ip=91.194.90.13; envelope-from=qemu_oss@crudebyte.com;
 helo=lizzy.crudebyte.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/19 07:30:08
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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

On Mittwoch, 19. August 2020 13:45:33 CEST Geoffrey McRae wrote:
> > I still don't quite get how this correlates. So you are forcing a
> > restart of
> > jackd on host side in between, for what purpose? To simulate the
> > Windows
> > client being kicked by jackd?
> 
> For many reasons jack may need to be stopped and started again, such as
> hardware changes when switching to a USB audio device, or tuning the
> period size, etc. QEMU should be able to recover if the jack server goes
> away, it's that simple.

Most of that could be done without jackd restart, but yeah I got your point. 
Thanks!

> The following sequence is what triggers this fault.
> 
>    client1 = jack_client_open();
>    client2 = jack_client_open();
> 
> client1 gets a shutdown signal
> 
>    jack_client_close(client1);
>    client1 = jack_client_open();
> 
> client2 gets a shutdown signal
> 
>    jack_client_close(client2);
>    client2 = jack_client_open();
> 
> One would expect this sequence to work fine as it conforms to the JACK
> documentation and common design practice, however, the call to
> `jack_client_open` notices that there is the 2nd session and frees it
> out from under the application.
> 
> This has been resolved in the v5 patch as suggested by Gerd by
> scheduling a QEMUBH to perform the closures so they occur in order
> before an attempt to open again. Even still this is clearly a design
> flaw in the Jack2 library.

Agreed.

I look at your v5 a bit later.

> > What latencies do you achieve BTW with Windows guests?
> 
> Never tested, it's not the reason why I use jack. 

Surpring that you never checked the min. latency there, as you nailed quite an 
ambitous jack driver into QEMU which I just realize now. Must have been 
splipped my awareness due to traffic.

> Suffice to say it's far better than PulseAudio,

Of course! :) I was shaking my head when distros started to pick PulseAudio as 
standard sound server. I never got that decision as JACK was always way 
superior than PA.

Probably the only issue for consumer use cases is JACK's habit to kick 
unreliable clients out of the graph. Even though this could be handled of 
course.

> I get no stuttering issues like is commonly
> reported for ALSA and PA, and allows for a high degree of
> reconfigurability. The guest VM overall performs far better also as
> windows is never waiting on the audio device due to the decoupling
> provided by the ring buffer in my implementation.

Yeah, looks good indeed!

> >> I am aware and since these libraries are interchangeable I had assumed
> >> that
> >> JACK1 will have the same fault. If not I suppose we need to detect
> >> which
> >> is in
> >> use and change this code appropriately.
> > 
> > I haven't checked this in the JACK1 code base yet, but I assume JACK1
> > does not
> > behave like JACK2 here, because the JACK API is very clear that it is
> > the
> > client's responsibility to free itself.
> > 
> > So it looks like a JACK2-only-bug to me.
> 
> Confirmed, this was investigated today.
> 
> > Very weird that there is no jack_client_version() in the shared weak
> > API (i.e.
> > missing on JACK1 side).
> 
> I raised this as an issue today:
> https://github.com/jackaudio/jack2/issues/628
> The developer there seems to feel that allowing the application to know
> the jack client version is a bad thing.

Yeah, I raised my voice there as well now.

Best regards,
Christian Schoenebeck



