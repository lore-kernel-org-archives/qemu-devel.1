Return-Path: <SRS0=pVGd=WM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0210BC3A59C
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2019 13:46:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C32B92064A
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2019 13:46:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="ClvQLbhI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C32B92064A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56382 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hycYt-00032a-Qp
	for qemu-devel@archiver.kernel.org; Fri, 16 Aug 2019 09:46:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37131)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berto@igalia.com>) id 1hycJB-0003BG-J6
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 09:30:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berto@igalia.com>) id 1hycJA-0005Xu-Av
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 09:30:21 -0400
Received: from fanzine.igalia.com ([91.117.99.155]:48681)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <berto@igalia.com>)
 id 1hycJ9-0005VS-Pe; Fri, 16 Aug 2019 09:30:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
 s=20170329; 
 h=Content-Type:MIME-Version:Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From;
 bh=DDRqAycT8hBniOd4Cul7ndoG0DA8nGO5hPLbOynYgUc=; 
 b=ClvQLbhI5CJKx2jXjS9nV5qCg4Emcm5YRD6nzImc8qCxbPpjTGttHti/8ITtBs08syVGYzrW4JZtPdFTh76oL48R8mC9v+R5Rw5LgkjQYvPqpGLWaScLXjR6icvhJultJZvFGUiSD80feNIMdYvIZe3ZTmaW9g5flMzMMcJy5i5Li6JomRCe4/iyZVEXBviVZRhc+tiS350z/KE2OJdRUMwwhnhcEi+ynyO1b6lSESe610purDs2jJ31LQBfYFVA0unbdKHlhXMiWdzVxiybEFuSpkK5O375V1nNKeIICzco2IXgFaGQCK4mSrdo3PR3CHDXtQ+SVoVGZSnVMArCPA==;
Received: from maestria.local.igalia.com ([192.168.10.14] helo=mail.igalia.com)
 by fanzine.igalia.com with esmtps 
 (Cipher TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim)
 id 1hycJ5-0006e0-Dn; Fri, 16 Aug 2019 15:30:15 +0200
Received: from berto by mail.igalia.com with local (Exim)
 id 1hycJ5-0002X5-BF; Fri, 16 Aug 2019 15:30:15 +0200
From: Alberto Garcia <berto@igalia.com>
To: Kevin Wolf <kwolf@redhat.com>
In-Reply-To: <20190816125921.GC5014@localhost.localdomain>
References: <20190816121742.29607-1-berto@igalia.com>
 <20190816125921.GC5014@localhost.localdomain>
User-Agent: Notmuch/0.18.2 (http://notmuchmail.org) Emacs/24.4.1
 (i586-pc-linux-gnu)
Date: Fri, 16 Aug 2019 15:30:15 +0200
Message-ID: <w51lfvti6fs.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x (no
 timestamps) [generic] [fuzzy]
X-Received-From: 91.117.99.155
Subject: Re: [Qemu-devel] [PATCH] qcow2: Fix the calculation of the maximum
 L2 cache size
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
Cc: Leonid Bloch <lbloch@janustech.com>, Max Reitz <mreitz@redhat.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org, qemu-stable@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri 16 Aug 2019 02:59:21 PM CEST, Kevin Wolf wrote:
> The requirement so that this bug doesn't affect the user seems to be
> that the image size is a multiple of 64k * 8k = 512 MB. Which means
> that users are probably often lucky enough in practice.

Or rather: cluster_size^2 / 8, which, if my numbers are right:

|--------------+-------------|
| Cluster size | Multiple of |
|--------------+-------------|
|         4 KB |        2 MB |
|         8 KB |        8 MB |
|        16 KB |       32 MB |
|        32 KB |      128 MB |
|        64 KB |      512 MB |
|       128 KB |        2 GB |
|       256 KB |        8 GB |
|       512 KB |       32 GB |
|      1024 KB |      128 GB |
|      2048 KB |      512 GB |
|--------------+-------------|

It get trickier with larger clusters, but if you have a larger cluster
size you probably have a very large image anyway, so yes I also think
that users are probably lucky enough in practice.

(also, the number of cache tables is always >= 2, so if the image size
is less than twice those numbers then it's also safe)

And yes, the odd value on the 512KB row on that we discussed last month
is due to this same bug:

https://lists.gnu.org/archive/html/qemu-block/2019-07/msg00496.html

Berto

