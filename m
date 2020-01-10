Return-Path: <SRS0=GavZ=27=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7913EC33CA2
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2020 12:15:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 447A22072E
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2020 12:15:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="HOxXnwq5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 447A22072E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44710 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iptCl-0000Tm-7Y
	for qemu-devel@archiver.kernel.org; Fri, 10 Jan 2020 07:15:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38270)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berto@igalia.com>) id 1iptBi-0007Uw-DY
 for qemu-devel@nongnu.org; Fri, 10 Jan 2020 07:14:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berto@igalia.com>) id 1iptBh-0000Zl-Bl
 for qemu-devel@nongnu.org; Fri, 10 Jan 2020 07:14:50 -0500
Received: from fanzine.igalia.com ([178.60.130.6]:44144)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <berto@igalia.com>)
 id 1iptBg-0000Pu-Pj; Fri, 10 Jan 2020 07:14:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
 s=20170329; 
 h=Content-Type:MIME-Version:Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From;
 bh=VH1L5LOjqfRACbvBu/DV4kQd1H9V1z9zv+XJg/lPXzg=; 
 b=HOxXnwq5cxfIszz8mvq0V2tmy/TxfCyXEzyCB3M5w9y/e6zYBmnA/YJozgjCAdGpA0KVODNRaXqNMkH0ZOx+yW3dmYskDxd+oh8z6QBkb3StS3nm87Dwk+rrBl3YFEHbQeTGcMUFRANoH+UgUFL1iTxfComqxZIWSLLVf59qKL/ekKSX8pCchDrsPym/gtD8fMXvTgNciO8G2xHRJhZKHlvlzzkfe/KgEBAmoMnw5KLswxcHuG3tMqpf5lpU9SCFsWbtQtcwQICc+dJyfFMRYwTSfoGdGk9QlyO2sQAP1gW7wDq9CSaXCClO+hVG+/wFvGvIIbyuiY7SNWTPbUSKVg==;
Received: from maestria.local.igalia.com ([192.168.10.14] helo=mail.igalia.com)
 by fanzine.igalia.com with esmtps 
 (Cipher TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim)
 id 1iptBe-0007pM-7q; Fri, 10 Jan 2020 13:14:46 +0100
Received: from berto by mail.igalia.com with local (Exim)
 id 1iptBd-0001QB-Tq; Fri, 10 Jan 2020 13:14:45 +0100
From: Alberto Garcia <berto@igalia.com>
To: qemu-devel@nongnu.org
Subject: Re: [PATCH v2 3/4] qcow2: Tighten cluster_offset alignment assertions
In-Reply-To: <fe47feb4fc96cf1242ba9e9431f910aef575cf16.1578596897.git.berto@igalia.com>
References: <cover.1578596897.git.berto@igalia.com>
 <fe47feb4fc96cf1242ba9e9431f910aef575cf16.1578596897.git.berto@igalia.com>
User-Agent: Notmuch/0.18.2 (http://notmuchmail.org) Emacs/24.4.1
 (i586-pc-linux-gnu)
Date: Fri, 10 Jan 2020 13:14:45 +0100
Message-ID: <w515zhjbj9m.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x (no
 timestamps) [generic] [fuzzy]
X-Received-From: 178.60.130.6
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
Cc: Kevin Wolf <kwolf@redhat.com>, Nir Soffer <nsoffer@redhat.com>,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu 09 Jan 2020 08:13:01 PM CET, Alberto Garcia wrote:
> -        assert((cluster_offset & 511) == 0);
> +        assert(QEMU_IS_ALIGNED(cluster_offset, s->cluster_size));

On second thoughts this patch could also use the (probably more
efficient) offset_into_cluster() call instead.

I can resend it if you think it's a good idea.

Berto

