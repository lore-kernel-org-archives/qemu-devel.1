Return-Path: <SRS0=6rdr=7Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43FC8C433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 17:17:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 115BF20674
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 17:17:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (4096-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="CpydVC34"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 115BF20674
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41774 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgX0e-0006Cw-9f
	for qemu-devel@archiver.kernel.org; Wed, 03 Jun 2020 13:17:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52722)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1jgX04-0005jU-Lt
 for qemu-devel@nongnu.org; Wed, 03 Jun 2020 13:16:24 -0400
Received: from kylie.crudebyte.com ([5.189.157.229]:38209)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1jgX03-0008Gl-4S
 for qemu-devel@nongnu.org; Wed, 03 Jun 2020 13:16:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Content-ID:Content-Description;
 bh=do8QewBWTwaUFMDOpMbrFcdPeqXI73yJMWSpFWFFSn0=; b=CpydVC34V8sciBnhYnwrlUFJJU
 I6h5+gR9Ay3Cv4ENVtBnWaKSRBL6LbOUKZZrix9wMtTy2pKr43ltdmmn1zI3ascimchdeUUweFNFo
 MI7P058XFK4l9ZhWVi1ln0jEpinU5OH+zirNTxLROrLJxSu9lyJWkvLmqL//reegrmLGS/3Yd3IsG
 p6oWO5fsQXwMaE6Yw0o0dNYPYwLAN828sHHimQYGGnzM8mfky8OxZDERQVO9HCJLQ2zzzWQQjkxDd
 STGYC3IkaQlv76wKlKWXUG4tyw2FlAAQv2MYFZASrkblouEcqckdu1MkrbisG7jVX4fI6nieXMn6N
 XkqWg1iwO37oeIJn69FHIwBVBt6AbTH3LqgxV45zpayi8/YJ24AWdQVQMxPhic1w9QRy0te7ntWZW
 sizGBcUT7mI5bfmgg/BfGz7QB6y8jAqL5TuT3KV0rwAPxwwgcpKNVX+j10so/U3hDE36+YFAAqOy3
 trUmCur2xO2Rlmj8OLxOPNV1ElBg1gAAhHul0bLPw2X6Hlix1duR5JlxX25l8Zce6js/ZjCq0219e
 ByoPt84HicjGOfybIaxMsf/SezeUT8u8x5ocwhV54UMB+h9zyhtufhy0Z7H6d/s3aS1a588z2QRXY
 QT738+DdEQjh1j/GgrRohWiMYUm81L8Phn9m4U73M=;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
To: qemu-devel@nongnu.org
Cc: Greg Kurz <groug@kaod.org>
Subject: Re: [PATCH v6 4/5] 9pfs: T_readdir latency optimization
Date: Wed, 03 Jun 2020 19:16:08 +0200
Message-ID: <3959658.0YslYoXCm0@silver>
In-Reply-To: <14ec5d880cfca878bf32e643243c7ab3f4a52440.1587309014.git.qemu_oss@crudebyte.com>
References: <cover.1587309014.git.qemu_oss@crudebyte.com>
 <14ec5d880cfca878bf32e643243c7ab3f4a52440.1587309014.git.qemu_oss@crudebyte.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Received-SPF: pass client-ip=5.189.157.229;
 envelope-from=qemu_oss@crudebyte.com; helo=kylie.crudebyte.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/03 13:16:20
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_PASS=-0.001,
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

On Sonntag, 19. April 2020 17:06:17 CEST Christian Schoenebeck wrote:
> Make top half really top half and bottom half really bottom half:
> 
> Each T_readdir request handling is hopping between threads (main
> I/O thread and background I/O driver threads) several times for
> every individual directory entry, which sums up to huge latencies
> for handling just a single T_readdir request.
> 
> Instead of doing that, collect now all required directory entries
> (including all potentially required stat buffers for each entry) in
> one rush on a background I/O thread from fs driver by calling the
> previously added function v9fs_co_readdir_many() instead of
> v9fs_co_readdir(), then assemble the entire resulting network
> response message for the readdir request on main I/O thread. The
> fs driver is still aborting the directory entry retrieval loop
> (on the background I/O thread inside of v9fs_co_readdir_many())
> as soon as it would exceed the client's requested maximum R_readdir
> response size. So this will not introduce a performance penalty on
> another end.
> 
> Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
> ---
>  hw/9pfs/9p.c | 122 +++++++++++++++++++++++----------------------------
>  1 file changed, 55 insertions(+), 67 deletions(-)

Ping. Anybody?

I would like to roll out this patch set soon and this is the only patch in 
this series missing a review yet.



