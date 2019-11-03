Return-Path: <SRS0=n1BB=Y3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 560ACCA9EB0
	for <qemu-devel@archiver.kernel.org>; Sun,  3 Nov 2019 21:55:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 19C7E214D9
	for <qemu-devel@archiver.kernel.org>; Sun,  3 Nov 2019 21:55:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=reactos.org header.i=@reactos.org header.b="ghQefBuh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19C7E214D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=reactos.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56568 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iRNqP-0003tc-Vc
	for qemu-devel@archiver.kernel.org; Sun, 03 Nov 2019 16:55:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58410)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <hpoussin@reactos.org>) id 1iRNom-0002l3-Si
 for qemu-devel@nongnu.org; Sun, 03 Nov 2019 16:53:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <hpoussin@reactos.org>) id 1iRNol-0000mH-M0
 for qemu-devel@nongnu.org; Sun, 03 Nov 2019 16:53:52 -0500
Received: from iserv.reactos.org ([2a01:4f8:1c17:5ae1::1]:55884)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <hpoussin@reactos.org>)
 id 1iRNol-0000eU-5s; Sun, 03 Nov 2019 16:53:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=reactos.org
 ; s=25047;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:
 Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=xuEwWnDNsPOR/pB2kgR4fzpePtswcFJTcROH/nfymiw=; b=ghQefBuhBBHDkhgNLNkH6H/e6k
 YYxNEFmRZXjiUNCJ01g46dsp0vsfoYAFVhkQZCM7104amDjVRaGPrU33zqUaHdHgkvulXeSwEOFfK
 gLdmKvODPafqkI4a3n5UnN99kLPCzTJGqne72N1mLpgwv98OV5/ix2rYSJ7NtGWwkh+A=;
Received: from [2a01:e35:2e3e:3c40:810c:5dc0:a5b7:d589]
 by iserv.reactos.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.89) (envelope-from <hpoussin@reactos.org>)
 id 1iRNof-0002lr-Rf; Sun, 03 Nov 2019 21:53:47 +0000
Subject: Re: [PATCH v3] fdc/i8257: implement verify transfer mode
To: Sven Schnelle <svens@stackframe.org>, John Snow <jsnow@redhat.com>
References: <20191101165513.14229-1-svens@stackframe.org>
From: =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>
Message-ID: <558a066f-18b9-fe22-469d-88b8df573751@reactos.org>
Date: Sun, 3 Nov 2019 22:53:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191101165513.14229-1-svens@stackframe.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a01:4f8:1c17:5ae1::1
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
Cc: Kevin Wolf <kwolf@redhat.com>, "open list:Floppy" <qemu-block@nongnu.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>,
 Max Reitz <mreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 01/11/2019 à 17:55, Sven Schnelle a écrit :
> While working on the Tulip driver i tried to write some Teledisk images to
> a floppy image which didn't work. Turned out that Teledisk checks the written
> data by issuing a READ command to the FDC but running the DMA controller
> in VERIFY mode. As we ignored the DMA request in that case, the DMA transfer
> never finished, and Teledisk reported an error.
> 
> The i8257 spec says about verify transfers:
> 
> 3) DMA verify, which does not actually involve the transfer of data. When an
> 8257 channel is in the DMA verify mode, it will respond the same as described
> for transfer operations, except that no memory or I/O read/write control signals
> will be generated.
> 
> Hervé proposed to remove all the dma_mode_ok stuff from fdc to have a more
> clear boundary between DMA and FDC, so this patch also does that.
> 
> Suggested-by: Hervé Poussineau <hpoussin@reactos.org>
> Signed-off-by: Sven Schnelle <svens@stackframe.org>
> ---
>   hw/block/fdc.c       | 61 +++++++++++++-------------------------------
>   hw/dma/i8257.c       | 20 ++++++++++-----
>   include/hw/isa/isa.h |  1 -
>   3 files changed, 31 insertions(+), 51 deletions(-)

Reviewed-by: Hervé Poussineau <hpoussin@reactos.org>


