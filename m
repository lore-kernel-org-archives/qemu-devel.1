Return-Path: <SRS0=TEh4=AD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5A67C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 09:28:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9144920708
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 09:28:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=hostfission.com header.i=@hostfission.com header.b="DW8Q2tg1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9144920708
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=hostfission.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52946 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnIkY-00036w-Px
	for qemu-devel@archiver.kernel.org; Mon, 22 Jun 2020 05:28:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49424)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <geoff@hostfission.com>)
 id 1jnIjy-00028W-NQ
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 05:27:46 -0400
Received: from mail1.hostfission.com ([139.99.139.48]:43918)
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <geoff@hostfission.com>) id 1jnIjw-0001IJ-U8
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 05:27:46 -0400
Received: from www1.hostfission.com (www1.hostfission.com [139.99.139.52])
 by mail1.hostfission.com (Postfix) with ESMTP id 96E6844B57;
 Mon, 22 Jun 2020 19:27:37 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=hostfission.com;
 s=mail; t=1592818057;
 bh=m3iIZYA3edvUK1EenDxTZxKg+gkBZIo1U8Bp5YJWZ1U=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=DW8Q2tg1cdAxCPSQnJIWzOrOBM9DUjiHrjkr3U1E3wqNXcjAAVv3QXENTYmyDhyG+
 e+86MlcmvszEl+EuiQci0+OVkvPqZSWkMXtZvAjUFwMRr3dIyl43IGGEEFQ9rQP53T
 5q0Hxy/74lozoxV43fguHSPAd1mKpAWyQa1SBda4=
Received: from mail.hostfission.com (www1.hostfission.com [127.0.0.1])
 by www1.hostfission.com (Postfix) with ESMTP id 7E34E817C3;
 Mon, 22 Jun 2020 19:27:37 +1000 (AEST)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Mon, 22 Jun 2020 19:27:37 +1000
From: Geoffrey McRae <geoff@hostfission.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH 5/6] audio/jack: honour the enable state of the audio
 device
In-Reply-To: <20200622090506.tmq7a4hig5whrf6c@sirius.home.kraxel.org>
References: <20200613040518.38172-1-geoff@hostfission.com>
 <20200613040518.38172-6-geoff@hostfission.com>
 <20200617124406.7dgne73ttfhgkj3x@sirius.home.kraxel.org>
 <a08a08cc6735d2fb2ba07145befc64c3@hostfission.com>
 <20200619092924.wjvegwpfrpaq6adz@sirius.home.kraxel.org>
 <649d66d244d7fdc8375464f91a7b254c@hostfission.com>
 <20200622090506.tmq7a4hig5whrf6c@sirius.home.kraxel.org>
Message-ID: <a28102a9824d4817870421f3c7e74ffc@hostfission.com>
X-Sender: geoff@hostfission.com
User-Agent: Roundcube Webmail/1.3.8
Received-SPF: pass client-ip=139.99.139.48; envelope-from=geoff@hostfission.com;
 helo=mail1.hostfission.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/22 05:27:39
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 2020-06-22 19:05, Gerd Hoffmann wrote:
> On Sun, Jun 21, 2020 at 02:06:25PM +1000, Geoffrey McRae wrote:
>> 
>> > Can you stop the stream without closing the connection?
>> 
>> Not as far as I can tell, it seems the JACK API doesn't allow for this 
>> in a
>> way that is useful to us.
> 
> What happens if you don't feed data to jack?  The cracking you hear on
> reboots etc. sounds like jack might reuses the buffers in that case.
> 
> So, maybe you can stop sending data to jack when all buffers are 
> already
> filled with silence?

Jack hands us a buffer we have to set, it's uninitialized as it's a ring 
buffer, if we do not zero it then we get repeating samples like your 
sound device has hung.

> 
> take care,
>   Gerd

