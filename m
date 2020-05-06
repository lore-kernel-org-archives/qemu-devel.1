Return-Path: <SRS0=CRBd=6U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF2EBC38A2A
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 13:37:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 78D2A20575
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 13:37:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (4096-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="MrX8Phxq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78D2A20575
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35852 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWKEV-0002WQ-JF
	for qemu-devel@archiver.kernel.org; Wed, 06 May 2020 09:37:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47194)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1jWKDl-00024C-Lt
 for qemu-devel@nongnu.org; Wed, 06 May 2020 09:36:21 -0400
Received: from kylie.crudebyte.com ([5.189.157.229]:39625)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1jWKDk-0005kS-Dc
 for qemu-devel@nongnu.org; Wed, 06 May 2020 09:36:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Content-ID:Content-Description;
 bh=HzmkrjFQ4X60eIgaRl3PgwFZT2qmVVzq6V3ppGvfiEQ=; b=MrX8PhxqsKbHb7gA1uQNvkgECI
 EP7AWHKW2WbnWyC0bRTZn8E6jp67w/ovzprpvLvqi0vFqAs2vwfzXI+x+cY6DtXoEbkCbYn0gjTkr
 dt/o1u6ILLUZsSCCJJUuzNEqKFAbp2j4ADQwq5xoV8lwyZ4LtvOI5q499XM2rQ2NlXQ0G/R0MWxHZ
 MXOblqJsf0YWwSNRqitZsTNJUcprLvmGMB3DHvMbRmlXnt4VUDHoH+ivWb4+ruo+8acBzZFmSloNc
 2ewlQ4M0Cg96EsOg5BBob+mPCI7PFtYWiRMcFkirbQE/CW0t0rTSkhl3XY169Wd6uFJ/Y7aopmIuP
 MmXnCUEMCemGZr4mOaJHZOeUU80+mT7wucLsNsTcf0/UVR93VzECq+Yj22UNZYgcaluJPjIN9RTmH
 NhVUDurpyb2K5ZtzCiNP4e3KuYMjUkW/vMjNjIjIvxDHJJzdT4s4n3EOZV5fsi3sLCf7doyKS0Po6
 ZSd8eq1gatIwMP6ZleMWhg6uchdMq/njLf6qxmm4mTX4sisAhdA+/g0o9NSM+F/BWos0I5UZDlPNf
 3qE2iUffvpro2QJzVUdwbJ8QN9G1sAjp2WhXr1xgJkAyzsOMjnvHlXMAa6Wi3MEdjTiADKetSBAHm
 Lm+5hPghjTUNcj+ZwrqQXEwKRcLs/c32aFr5FW5X4=;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
To: qemu-devel@nongnu.org
Cc: Greg Kurz <groug@kaod.org>
Subject: Re: [PATCH] 9pfs: Fix potential deadlock of QEMU mainloop
Date: Wed, 06 May 2020 15:36:16 +0200
Message-ID: <3204505.kZXhZKLjgj@silver>
In-Reply-To: <4216293.sUgoX00Q1d@silver>
References: <158826201391.1344781.9403916162733181811.stgit@bahia.lan>
 <4216293.sUgoX00Q1d@silver>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Received-SPF: pass client-ip=5.189.157.229;
 envelope-from=qemu_oss@crudebyte.com; helo=kylie.crudebyte.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/06 09:05:25
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

On Mittwoch, 6. Mai 2020 15:05:23 CEST Christian Schoenebeck wrote:
> > diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
> > index 9e046f7acb51..ac84ae804496 100644
> > --- a/hw/9pfs/9p.c
> > +++ b/hw/9pfs/9p.c
> > @@ -2170,7 +2170,7 @@ static int coroutine_fn
> > v9fs_do_readdir_with_stat(V9fsPDU *pdu, int32_t count = 0;
> > 
> >      struct stat stbuf;
> >      off_t saved_dir_pos;
> > 
> > -    struct dirent *dent;
> > +    struct dirent dent;

One more: since this dirent structure is now on the stack, it should better be 
initialized for safety reasons.

Best regards,
Christian Schoenebeck



