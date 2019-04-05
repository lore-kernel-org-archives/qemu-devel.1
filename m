Return-Path: <SRS0=1I+v=SH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CB80C4360F
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Apr 2019 07:42:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3CE36217D7
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Apr 2019 07:42:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="cD/p3DRa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CE36217D7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:37610 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hCJUs-0001WR-HK
	for qemu-devel@archiver.kernel.org; Fri, 05 Apr 2019 03:42:46 -0400
Received: from eggs.gnu.org ([209.51.188.92]:40258)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1hCJU9-0001C3-97
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 03:42:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1hCJU8-0002cb-Et
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 03:42:01 -0400
Received: from fanzine.igalia.com ([91.117.99.155]:43493)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <berto@igalia.com>)
	id 1hCJPE-000491-7V; Fri, 05 Apr 2019 03:36:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; 
	h=Content-Type:MIME-Version:Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From;
	bh=rbrEgb1OvdM/FwIqMDXj6MqqUrKvieubQndEDfCMgpM=; 
	b=cD/p3DRal3T8L45cqppMVmAQDxjwx2qWn7ZHf/fuTVFjI6vvot5Qjy88owLbelstmmhAOdVEq3nYmaPU3UpO98OZforZzZvI67LcTNi15jN4tRv0ZZVv2p+uDEtfoDwudBYjmgB52DTcJETzJ8lon6q5bK89xQbC0G8k8mXPOd0xjtvrXb26eCCGfGvdilaqqfvYpePeCVCN2saLYtg1RXovwXDIBDaoTdQ6GP2ZZH3OPNmPohMt3EVxDZlrjgbHVcdRjBatGOoHgWvcaGd66lLtcUZsImKtz9m0ybVEDCfl9/LItjfkbqGvQAM8DSgpVCNF7ztrQ2itvETNfcELzQ==;
Received: from maestria.local.igalia.com ([192.168.10.14] helo=mail.igalia.com)
	by fanzine.igalia.com with esmtps 
	(Cipher TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim)
	id 1hCJOu-0005vq-Vd; Fri, 05 Apr 2019 09:36:37 +0200
Received: from berto by mail.igalia.com with local (Exim)
	id 1hCJOu-0006mg-SO; Fri, 05 Apr 2019 09:36:36 +0200
From: Alberto Garcia <berto@igalia.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
In-Reply-To: <20190404150746.12585-1-kwolf@redhat.com>
References: <20190404150746.12585-1-kwolf@redhat.com>
User-Agent: Notmuch/0.18.2 (http://notmuchmail.org) Emacs/24.4.1
	(i586-pc-linux-gnu)
Date: Fri, 05 Apr 2019 09:36:36 +0200
Message-ID: <w51ftqwq4xn.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x (no
	timestamps) [generic] [fuzzy]
X-Received-From: 91.117.99.155
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH for-4.0] block: Forward
 'discard' to temporary overlay
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
Cc: kwolf@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190405073636.v_sTUWhiQxSsKOMoyOSfEGerP38JshVctfRl34wd6Wg@z>

On Thu 04 Apr 2019 05:07:46 PM CEST, Kevin Wolf wrote:
> When bdrv_temp_snapshot_options() is called for snapshot=on, the
> 'discard' option in the options QDict hasn't been parsed and merged into
> the flags yet. So copy the dict entry to make sure that the temporary
> overlay enables discard when it was requested for the drive.
>
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>

Reviewed-by: Alberto Garcia <berto@igalia.com>

Berto

