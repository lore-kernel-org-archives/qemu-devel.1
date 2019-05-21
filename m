Return-Path: <SRS0=/4tE=TV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68D31C04AAF
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2019 20:12:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 34C7A217F9
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2019 20:12:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b="bxUPF4uH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34C7A217F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=ozlabs.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:58893 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTB86-0008OL-CZ
	for qemu-devel@archiver.kernel.org; Tue, 21 May 2019 16:12:58 -0400
Received: from eggs.gnu.org ([209.51.188.92]:57426)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anton@ozlabs.org>) id 1hTB6e-0007TO-E5
	for qemu-devel@nongnu.org; Tue, 21 May 2019 16:11:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anton@ozlabs.org>) id 1hTB6d-000318-3Z
	for qemu-devel@nongnu.org; Tue, 21 May 2019 16:11:28 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:57831 helo=ozlabs.org)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <anton@ozlabs.org>)
	id 1hTB6c-0002hm-HO; Tue, 21 May 2019 16:11:27 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits)
	server-digest SHA256) (No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 457n2p2bjwz9s3l;
	Wed, 22 May 2019 06:11:13 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ozlabs.org; s=201707;
	t=1558469475; bh=vbldDZJnrimtoFoAJ6UKMk/YrTCOYZ+2IEmNAcwLwdw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=bxUPF4uHzzD+Cxsle7Hd38jR1tQK/fV5McsEZ1Dh/Uxq6jiThrVHScQD4qtumQuy8
	/iqC252nFxpRJg1YEq3J8SzV49WNDIf5Ep++WrZuFWsXzDI9aOTkd+AphKONoxxTLc
	ivdph2LW4+aPF9eqXQTKNQIuit8xuDiv+sFgEEmTxqir2TllRkb0MD7w5k2NioLmfQ
	o99E3i85t0X0s3qPlSJrDbM+sg3giU+G4gWGOHzMYeUm9lnPpAW2f+KyBngVCtLG9Y
	IAZ1HtB2jD3wHzjetuObSR8F0JZmLN0Vvh/bVyp1O6aZXPlrHdTtf1vFXoOUO5UNeI
	i59FPTq089hXA==
Date: Wed, 22 May 2019 06:11:12 +1000
From: Anton Blanchard <anton@ozlabs.org>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
	david@gibson.dropbear.id.au
Message-ID: <20190522061112.3accdb76@kryten>
In-Reply-To: <c1d2a4cf-a9a7-4dfa-ed80-987118043f08@ilande.co.uk>
References: <20190507004811.29968-1-anton@ozlabs.org>
	<20190507004811.29968-4-anton@ozlabs.org>
	<c1d2a4cf-a9a7-4dfa-ed80-987118043f08@ilande.co.uk>
X-Mailer: Mutt/1.8.0 (2017-02-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 203.11.71.1
Subject: Re: [Qemu-devel] [PATCH 4/9] target/ppc: Fix lxvw4x,
 lxvh8x and lxvb16x
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: ego@linux.vnet.ibm.com, sandipandas1990@gmail.com,
	richard.henderson@linaro.org, f4bug@amsat.org,
	qemu-devel@nongnu.org, qemu-ppc@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

> I've now had a bit of time to look through this and I believe it is
> correct, so:
> 
> Reviewed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

Thanks Mark. David: any chance we could get this merged? I can't run a
recent Ubuntu image successfully without it. sshd hangs when I try to
ssh into it.

Thanks,
Anton

