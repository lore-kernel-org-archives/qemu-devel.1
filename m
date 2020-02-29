Return-Path: <SRS0=0Zkw=4R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD718C3F2CE
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Feb 2020 09:57:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A984820661
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Feb 2020 09:57:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=duncanthrax.net header.i=@duncanthrax.net header.b="SqzATfev"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A984820661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=stackframe.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58962 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7ys7-0006YF-Mp
	for qemu-devel@archiver.kernel.org; Sat, 29 Feb 2020 04:57:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45346)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <svens@stackframe.org>) id 1j7yoz-0005hr-2u
 for qemu-devel@nongnu.org; Sat, 29 Feb 2020 04:54:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <svens@stackframe.org>) id 1j7yoy-0007CC-2T
 for qemu-devel@nongnu.org; Sat, 29 Feb 2020 04:54:08 -0500
Received: from smtp.duncanthrax.net ([178.63.180.169]:38570)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <svens@stackframe.org>)
 id 1j7yox-0007Bs-Sk
 for qemu-devel@nongnu.org; Sat, 29 Feb 2020 04:54:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=duncanthrax.net; s=dkim; h=In-Reply-To:Content-Type:MIME-Version:References
 :Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding
 :Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=WpMvdHrBHpOExIe1eFfQcjm0Y9Vvr609iulFZU235kE=; b=SqzATfev2i8prowzXM+WC2/LSZ
 O4lCux9Bnjbh9AWkfDke29jJ8PVLfg16A+mAVgXQ9cgQ+J8g+S2BIGnfjcx0CrzLOWSV2FJsVEUae
 7PPV0r+IfeQlzislbmrPevIsNhycM4SxVuoAUIakOx6ObmfLcvN5+IpwdhqDZS3fAlIQ=;
Received: from [134.3.47.90] (helo=t470p.stackframe.org)
 by smtp.duncanthrax.net with esmtpa (Exim 4.90_1)
 (envelope-from <svens@stackframe.org>)
 id 1j7yow-0006lY-K5; Sat, 29 Feb 2020 10:54:06 +0100
Date: Sat, 29 Feb 2020 10:54:06 +0100
From: Sven Schnelle <svens@stackframe.org>
To: qemu-devel@nongnu.org
Subject: Re: [PATCH] fix out of bounds check
Message-ID: <20200229095406.GA29686@t470p.stackframe.org>
References: <20200229095040.29616-1-svens@stackframe.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200229095040.29616-1-svens@stackframe.org>
User-Agent: Mutt/1.12.2 (2019-09-21)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 178.63.180.169
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
Cc: deller@gmx.de
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, Feb 29, 2020 at 10:50:40AM +0100, Sven Schnelle wrote:
> Signed-off-by: Sven Schnelle <svens@stackframe.org>
> ---
>  hw/display/artist.c | 18 ++++++------------
>  1 file changed, 6 insertions(+), 12 deletions(-)

That was supposed to only go to Helge for testing, so please ignore.

Sven

