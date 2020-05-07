Return-Path: <SRS0=s5cl=6V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37444C38A2A
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 14:39:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0295A20575
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 14:39:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="T/tHdWzS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0295A20575
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57386 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWhgV-0002iE-2G
	for qemu-devel@archiver.kernel.org; Thu, 07 May 2020 10:39:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46006)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1jWhem-000102-A4; Thu, 07 May 2020 10:37:48 -0400
Received: from fanzine.igalia.com ([178.60.130.6]:55897)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1jWhek-00028w-Qq; Thu, 07 May 2020 10:37:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
 s=20170329; 
 h=Content-Type:MIME-Version:Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From;
 bh=MN/YlR/ABv/N+Xv5Sj/GoyAwWzMhpPiqSuZzcTntz5I=; 
 b=T/tHdWzS5DpzG3YExeT8btUTQh3mjTfFY4F99C41O2gwO3QM5KGhW0cWNofA94nGEE1F/YwShIXpGwrJnYXap2a+uHZqwG6VeeA6puCSgGxGOccOFoVkx4w+/g7dO41/RyAe+yDW9526Vdnf7MWpDYBIIamUl2FBycogn4K1xfNQwGw1PpRi6Nvq8PiRoakwRCdgAkgxKjbqSwjoMGRKBAVIFhfIEIrcEnUvnZq64U9QY6JStIs0qY2AX2ZpLCs3l86tIQMo5j7kNmrt2VFki/lN4QnRStcrOVJ2LOOVavxkTyHXAUt3eTzHMViGS45OD/Iug4VIV80Wr87IFXTxOQ==;
Received: from maestria.local.igalia.com ([192.168.10.14] helo=mail.igalia.com)
 by fanzine.igalia.com with esmtps 
 (Cipher TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim)
 id 1jWheM-0000OL-Sb; Thu, 07 May 2020 16:37:22 +0200
Received: from berto by mail.igalia.com with local (Exim)
 id 1jWheM-0003u9-Ix; Thu, 07 May 2020 16:37:22 +0200
From: Alberto Garcia <berto@igalia.com>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH v5 28/31] qcow2: Add the 'extended_l2' option and the
 QCOW2_INCOMPAT_EXTL2 bit
In-Reply-To: <926a34f4-c629-fe8e-ed5a-b655b68d1265@redhat.com>
References: <cover.1588699789.git.berto@igalia.com>
 <f8d2bb7d22fd228816e5caed6640af36a63cdddc.1588699789.git.berto@igalia.com>
 <926a34f4-c629-fe8e-ed5a-b655b68d1265@redhat.com>
User-Agent: Notmuch/0.18.2 (http://notmuchmail.org) Emacs/24.4.1
 (i586-pc-linux-gnu)
Date: Thu, 07 May 2020 16:37:22 +0200
Message-ID: <w51ftcbn74t.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=178.60.130.6; envelope-from=berto@igalia.com;
 helo=fanzine.igalia.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/07 10:37:24
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x (no timestamps) [generic] [fuzzy]
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed 06 May 2020 08:09:07 PM CEST, Eric Blake wrote:
> What you have looks good, but I didn't notice anything affecting
> amend.  The simplest option: amend can reject attempts to toggle the
> extended L2 option (the zstd compression patches take that path).

You're right, thanks! I think I'll just disable it, I'm not sure that
it's worth the complexity.

Berto

