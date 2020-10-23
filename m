Return-Path: <SRS0=OdKR=D6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2CD4C4363A
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 16:23:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 145832192A
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 16:23:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="VaiuLswQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 145832192A
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49440 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVzqf-0004NR-PW
	for qemu-devel@archiver.kernel.org; Fri, 23 Oct 2020 12:23:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36110)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1kVzB3-0004Qw-1P
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 11:40:26 -0400
Received: from lizzy.crudebyte.com ([91.194.90.13]:51783)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1kVzB0-0003Av-Rk
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 11:40:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=lizzy; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Content-ID:Content-Description;
 bh=YOh4Y7I8iR4iwmRb1Tv4RepzFuYfoG+/0OBsIE7sL2A=; b=VaiuLswQqdUKYU01K6C1fMCeep
 izyK7hBvgyzc+Yrr6jVA17MQ/G1UAIgFx/KPASnxgt9FunxVtzjp20dwzLqr/JJ/XKYoqkGIBvzkS
 FCRTu83Qbv0oPkNFNF0eaQ5J/+FVFtiqj0yFhnlaNVnHAGoLdlKNnIhRRoCyV64HBSp8mx9gqszjx
 6S1bnk/Vai/XLHkIyDmvR9L+GwPFAjq/N+5PJ1m4d7/QmNTAClX1lejAKVT5h2p7sfLoFwa3AagVC
 guakAF5mS5yL4qeMwiQOQSxVGNIOrB2QhO+CIufVuaVTVtuA5XR+AwlbtUK8uLn1EtKaRJ8UkyYek
 cb0feKLg==;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
To: Greg Kurz <groug@kaod.org>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PULL 01/13] tests/9pfs: Factor out do_version() helper
Date: Fri, 23 Oct 2020 17:40:13 +0200
Message-ID: <4875106.geqTqo5ub7@silver>
In-Reply-To: <20201023172950.4b148e3f@bahia.lan>
References: <cover.1603452058.git.qemu_oss@crudebyte.com>
 <ccc858509ddfa3f6244cc4caf92c4149b7269b43.1603452058.git.qemu_oss@crudebyte.com>
 <20201023172950.4b148e3f@bahia.lan>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Received-SPF: pass client-ip=91.194.90.13; envelope-from=qemu_oss@crudebyte.com;
 helo=lizzy.crudebyte.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/23 11:40:15
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Freitag, 23. Oktober 2020 17:32:02 CEST Greg Kurz wrote:
> It feels weird to receive a mail I didn't send with my address
> in the top From: header. I would have expected yours instead and
> another From: with my address in the changelog...
> 
> 
> On Tue, 20 Oct 2020 18:09:14 +0200
> Greg Kurz <groug@kaod.org> wrote:
> 
> ... here.

Yep, I noticed that too late. I'll take care about it next time. Sorry!

Best regards,
Christian Schoenebeck



