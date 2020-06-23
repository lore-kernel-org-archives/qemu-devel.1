Return-Path: <SRS0=Q9tF=AE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1C76C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 14:15:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7CFCE2064B
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 14:15:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="IAr9pJYm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CFCE2064B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44718 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnji7-0002ZC-MM
	for qemu-devel@archiver.kernel.org; Tue, 23 Jun 2020 10:15:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47942)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1jnjh7-0001pQ-AJ; Tue, 23 Jun 2020 10:14:37 -0400
Received: from fanzine.igalia.com ([178.60.130.6]:40588)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1jnjh4-0003eC-2J; Tue, 23 Jun 2020 10:14:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
 s=20170329; 
 h=Content-Type:MIME-Version:Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From;
 bh=w9EeemSKDfNK1I8zbH94m4IK1fAmBp9IqicmKrRkE8U=; 
 b=IAr9pJYmw7QVk/JPcWYvddD761JfTwvyBGVV5oSPXkWmQyvrr/2ZTYfX3Q/8GDB2rHlh1R6YGvITZ8/Dbk47bRurJVq6GAFbl1my1RFbNBNhvQxyPLV8W9dadfo8qrJ64t41JHFsU/jYbc2ooffJXfgbUqwEP0eMlWo9ZeX0ddSRIjOOr6YTrT2j0b1/0xA1R7wPyUaJ5RmBqQbSXN+DjDJ5xdjcSzIBoySOHmRuXXP+t6kQt/I8abt8WVMZ00JMLhzMQSYJwzKaZG/T4IUB03qnYgkHMZl1eijEJBCQUfiChuow8ZJ8/A0jAiYg9HM0JLA6AYy2164l4JVYYTe5OQ==;
Received: from maestria.local.igalia.com ([192.168.10.14] helo=mail.igalia.com)
 by fanzine.igalia.com with esmtps 
 (Cipher TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim)
 id 1jnjgz-0001Hr-F6; Tue, 23 Jun 2020 16:14:29 +0200
Received: from berto by mail.igalia.com with local (Exim)
 id 1jnjgz-0005eX-1B; Tue, 23 Jun 2020 16:14:29 +0200
From: Alberto Garcia <berto@igalia.com>
To: qemu-devel@nongnu.org
Subject: Re: [PATCH v2] qcow2: Fix preallocation on images with unaligned sizes
In-Reply-To: <20200617140036.20311-1-berto@igalia.com>
References: <20200617140036.20311-1-berto@igalia.com>
User-Agent: Notmuch/0.18.2 (http://notmuchmail.org) Emacs/24.4.1
 (i586-pc-linux-gnu)
Date: Tue, 23 Jun 2020 16:14:29 +0200
Message-ID: <w51imfhhnsq.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=178.60.130.6; envelope-from=berto@igalia.com;
 helo=fanzine.igalia.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/23 10:14:30
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x (no timestamps) [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

ping

On Wed 17 Jun 2020 04:00:36 PM CEST, Alberto Garcia wrote:
> When resizing an image with qcow2_co_truncate() using the falloc or
> full preallocation modes the code assumes that both the old and new
> sizes are cluster-aligned.
>
> There are two problems with this:
>
>   1) The calculation of how many clusters are involved does not always
>      get the right result.
>
>      Example: creating a 60KB image and resizing it (with
>      preallocation=full) to 80KB won't allocate the second cluster.
>
>   2) No copy-on-write is performed, so in the previous example if
>      there is a backing file then the first 60KB of the first cluster
>      won't be filled with data from the backing file.
>
> This patch fixes both issues.
>
> Signed-off-by: Alberto Garcia <berto@igalia.com>

