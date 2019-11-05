Return-Path: <SRS0=HxLX=Y5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E369C5DF60
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2019 20:30:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 459E821929
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2019 20:30:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=reactos.org header.i=@reactos.org header.b="pZjn+NAR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 459E821929
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=reactos.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49712 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iS5T3-0006qM-Hs
	for qemu-devel@archiver.kernel.org; Tue, 05 Nov 2019 15:30:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55114)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <hpoussin@reactos.org>) id 1iS5SM-0006OS-00
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 15:29:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <hpoussin@reactos.org>) id 1iS5SK-00075B-SP
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 15:29:37 -0500
Received: from iserv.reactos.org ([2a01:4f8:1c17:5ae1::1]:60956)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <hpoussin@reactos.org>)
 id 1iS5SK-0006vJ-CN
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 15:29:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=reactos.org
 ; s=25047;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:
 Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=bCjFzig+so6IUzdmWivhLEgtWE6YsXNfZ8TWZaqReLg=; b=pZjn+NARtOym5mwiHrVcDYeKa5
 eeG4880JEROB7j+80HutVKe+Kti9zjnYldd2SkBiRdXvjCw43wZMq1Feoi4L8lQkIR4n/H2mBsQ8L
 JMEh6m+918txe28IFzVWhkvUe/fDTtOVXAffdEyLotRRG5/uVjqrFBrKgtdm9uJgv21E=;
Received: from [2a01:e35:2e3e:3c40:810c:5dc0:a5b7:d589]
 by iserv.reactos.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.89) (envelope-from <hpoussin@reactos.org>)
 id 1iS5SD-0003BU-WB; Tue, 05 Nov 2019 20:29:31 +0000
Subject: Re: [PATCH 1/3] dp8393x: put the DMA buffer in the state structure
To: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org
References: <20191102171511.31881-1-laurent@vivier.eu>
 <20191102171511.31881-2-laurent@vivier.eu>
From: =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>
Message-ID: <bd8f073e-3e67-4d62-cdcf-cb3b16156caf@reactos.org>
Date: Tue, 5 Nov 2019 21:29:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191102171511.31881-2-laurent@vivier.eu>
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
Cc: Jason Wang <jasowang@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 02/11/2019 à 18:15, Laurent Vivier a écrit :
> Move it from the stack.
> 
> It's only 24 bytes, and this simplifies the dp8393x_get()/
> dp8393x_put() interface.
> 
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
> ---
>   hw/net/dp8393x.c | 105 ++++++++++++++++++++++-------------------------
>   1 file changed, 50 insertions(+), 55 deletions(-)

Reviewed-by: Hervé Poussineau <hpoussin@reactos.org>

