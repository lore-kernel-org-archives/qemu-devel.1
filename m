Return-Path: <SRS0=M+f9=AC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A03B5C433DF
	for <qemu-devel@archiver.kernel.org>; Sun, 21 Jun 2020 04:07:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6598D247CC
	for <qemu-devel@archiver.kernel.org>; Sun, 21 Jun 2020 04:07:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=hostfission.com header.i=@hostfission.com header.b="aqS0duPe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6598D247CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=hostfission.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48424 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jmrGH-0001lx-KC
	for qemu-devel@archiver.kernel.org; Sun, 21 Jun 2020 00:07:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46016)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <geoff@hostfission.com>)
 id 1jmrFa-00016K-C6
 for qemu-devel@nongnu.org; Sun, 21 Jun 2020 00:06:34 -0400
Received: from mail1.hostfission.com ([139.99.139.48]:56816)
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <geoff@hostfission.com>) id 1jmrFW-0001kW-Ax
 for qemu-devel@nongnu.org; Sun, 21 Jun 2020 00:06:34 -0400
Received: from www1.hostfission.com (www1.hostfission.com [139.99.139.52])
 by mail1.hostfission.com (Postfix) with ESMTP id 34B4A44BA3;
 Sun, 21 Jun 2020 14:06:25 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=hostfission.com;
 s=mail; t=1592712385;
 bh=o6tO7GzVvrzCl7KZ7RwO+wHeRshZHRSDFbPDMSa3IdU=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=aqS0duPetX/Sq1DtaDsM5ZpUVnCt2P04ptHdjCZjz6M8g4cdoI+Hi6JLgEtiNmT28
 SiD0AWlYMR4+HFq4hYAwz+3nTxkQW3iUWhWqSSvopgoOFFmhrtXcckEEtCNvskVy6A
 2LqhIR25r86DufsJoYPV5E+F8ZoIJK23Jw04kJ6w=
Received: from mail.hostfission.com (www1.hostfission.com [127.0.0.1])
 by www1.hostfission.com (Postfix) with ESMTP id 21C12643;
 Sun, 21 Jun 2020 14:06:25 +1000 (AEST)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Sun, 21 Jun 2020 14:06:25 +1000
From: Geoffrey McRae <geoff@hostfission.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH 5/6] audio/jack: honour the enable state of the audio
 device
In-Reply-To: <20200619092924.wjvegwpfrpaq6adz@sirius.home.kraxel.org>
References: <20200613040518.38172-1-geoff@hostfission.com>
 <20200613040518.38172-6-geoff@hostfission.com>
 <20200617124406.7dgne73ttfhgkj3x@sirius.home.kraxel.org>
 <a08a08cc6735d2fb2ba07145befc64c3@hostfission.com>
 <20200619092924.wjvegwpfrpaq6adz@sirius.home.kraxel.org>
Message-ID: <649d66d244d7fdc8375464f91a7b254c@hostfission.com>
X-Sender: geoff@hostfission.com
User-Agent: Roundcube Webmail/1.3.8
Received-SPF: pass client-ip=139.99.139.48; envelope-from=geoff@hostfission.com;
 helo=mail1.hostfission.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/21 00:06:26
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



On 2020-06-19 19:29, Gerd Hoffmann wrote:
> Hi,
> 
>> > Hmm, I guess feeding silence into jack needs some cpu cycles?
>> > Maybe add a timer to close the jack server connection?  Keep the
>> > connection open for re-use for a while, but in case the guest stops
>> > playing sound altogether close the jack connection after being unused
>> > for a few minutes?
>> >
>> > [ Doesn't render the patch invalid, consider it a suggestion for future
>> >   improvements ]
>> 
>> Thanks, I had considered that however there is a usability issue to
>> consider. Each time a jack client registers, it removes the client 
>> entirely
>> and disconnects any custom plumbing that may have been done by the 
>> user.
> 
> Hmm, ok, that is bad indeed.
> 
> Can you stop the stream without closing the connection?

Not as far as I can tell, it seems the JACK API doesn't allow for this 
in a way that is useful to us.

> 
>> JACK does not remember this custom routing and as such it's lost until 
>> the
>> user re-establishes it, or they have some automation set up to do it. 
>> While
>> this could likely be worked around, it would likely cause more 
>> headaches
>> then the few CPU cycles lost in a memset.
> 
> I'm more concerned about the frequent wakeups to feed the next chunk of
> (silence) data to jack.
> 
> take care,
>   Gerd

