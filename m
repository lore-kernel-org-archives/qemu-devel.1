Return-Path: <SRS0=Q7uJ=36=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5073C352A4
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2020 18:14:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 823BD2082F
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2020 18:14:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="JRpN/7tm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 823BD2082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37225 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1DZi-00074G-Pc
	for qemu-devel@archiver.kernel.org; Mon, 10 Feb 2020 13:14:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57778)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berto@igalia.com>) id 1j1DZ7-0006bN-Bj
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 13:13:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berto@igalia.com>) id 1j1DZ6-0003uS-Fd
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 13:13:49 -0500
Received: from fanzine.igalia.com ([178.60.130.6]:46808)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <berto@igalia.com>)
 id 1j1DZ6-0003s7-6f; Mon, 10 Feb 2020 13:13:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
 s=20170329; 
 h=Content-Type:MIME-Version:Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From;
 bh=qWMlBpLMOw2Kqp+43+zTeTd8DI5zbbaMNH70aj22CYA=; 
 b=JRpN/7tm4CUDThUK8jy0ip3ezVZQnz8Df1/4fwX7LbAtg4gOR1Vx0QV54GQAUv69x3FaCbXLKYBk8r3SxCieyLAglFb+EbZKftuoPBu4q1xyRExfJ/aVSyyO3hB7Mr9GJyFW73ajT1jS16wBVP/JZKX3KLbn0d42fVxR0egSpjpVF0z+YwjZF+Z9c57OmfI3uTW5pOkshZ3Eg+lT8Fo4c1bYZP/mskt+LVmWtawEtpHH62XFOLO9xpHmGANhoClFVcwcMv5jdFW0zOAxLTbDmFLs6RN9G1RqrFeIrImTZJXLoamR7lV6t1O6WsgyN+RWVQ7o1i1VP7ezMBQMRYQMdQ==;
Received: from maestria.local.igalia.com ([192.168.10.14] helo=mail.igalia.com)
 by fanzine.igalia.com with esmtps 
 (Cipher TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim)
 id 1j1DZ4-0004cB-Ro; Mon, 10 Feb 2020 19:13:46 +0100
Received: from berto by mail.igalia.com with local (Exim)
 id 1j1DZ4-0002KW-If; Mon, 10 Feb 2020 19:13:46 +0100
From: Alberto Garcia <berto@igalia.com>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH 06/17] block: Improve bdrv_has_zero_init_truncate with
 backing file
In-Reply-To: <20200131174436.2961874-7-eblake@redhat.com>
References: <20200131174436.2961874-1-eblake@redhat.com>
 <20200131174436.2961874-7-eblake@redhat.com>
User-Agent: Notmuch/0.18.2 (http://notmuchmail.org) Emacs/24.4.1
 (i586-pc-linux-gnu)
Date: Mon, 10 Feb 2020 19:13:46 +0100
Message-ID: <w51eev2fgyt.fsf@maestria.local.igalia.com>
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
Cc: david.edmondson@oracle.com, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri 31 Jan 2020 06:44:25 PM CET, Eric Blake wrote:
> When we added bdrv_has_zero_init_truncate(), we chose to blindly
> return 0 if a backing file was present, because we knew of the corner
> case where a backing layer larger than the current layer might leak
> the tail of the backing layer into the resized region.  But as this
> setup is rare, it penalizes the more common case of a backing layer
> smaller than the current layer.
>
> Signed-off-by: Eric Blake <eblake@redhat.com>

Reviewed-by: Alberto Garcia <berto@igalia.com>

Berto

