Return-Path: <SRS0=pnX7=37=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82686C352A3
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 15:31:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E3432082F
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 15:31:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="OC1R2rlK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E3432082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51520 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1XVi-0000Y3-DT
	for qemu-devel@archiver.kernel.org; Tue, 11 Feb 2020 10:31:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43986)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berto@igalia.com>) id 1j1XUe-00081m-AZ
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 10:30:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berto@igalia.com>) id 1j1XUc-000289-BC
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 10:30:32 -0500
Received: from fanzine.igalia.com ([178.60.130.6]:51369)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <berto@igalia.com>)
 id 1j1XUW-0001w4-TA; Tue, 11 Feb 2020 10:30:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
 s=20170329; 
 h=Content-Type:MIME-Version:Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From;
 bh=U/abCx78WK/CAKW0Boh2PS3yIsubh7RJ7NzIWC46wEM=; 
 b=OC1R2rlKeXAO9snqk+u7itsrDst1BmHECSHk/+zF5VxUBZ0B4oSzthPyClQnq6bpMq9R0FbFL69MehWI1NETqNrfA0gQkcNlgn1G6b6bY0DYHeQFNdQsO5TtFm7nwwjFSgnIClm0kY4asYUTbGuhLJCPznhd3l1qGuv5dVNDWIjrrN5h6nhdOrtEfJA5zpWrl+IHokrqOkEb4duH32v04TpUJ6MgQhJwqD1YInk1L68TTk0r4x9snyKLVEn4FwQPhfh1gmP9wsOqPtmL5LaPRprHLg+hgljt8/I0Ru9vujDz2LcUkt8MbL11xRzyGqUjR+FLAsqW0E9TZULvTUm3cA==;
Received: from maestria.local.igalia.com ([192.168.10.14] helo=mail.igalia.com)
 by fanzine.igalia.com with esmtps 
 (Cipher TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim)
 id 1j1XUD-0006DH-B9; Tue, 11 Feb 2020 16:30:05 +0100
Received: from berto by mail.igalia.com with local (Exim)
 id 1j1XUC-00083k-W3; Tue, 11 Feb 2020 16:30:04 +0100
From: Alberto Garcia <berto@igalia.com>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Subject: Re: [PATCH v2 01/33] block: Add BlockDriver.is_format
In-Reply-To: <20200204170848.614480-2-mreitz@redhat.com>
References: <20200204170848.614480-1-mreitz@redhat.com>
 <20200204170848.614480-2-mreitz@redhat.com>
User-Agent: Notmuch/0.18.2 (http://notmuchmail.org) Emacs/24.4.1
 (i586-pc-linux-gnu)
Date: Tue, 11 Feb 2020 16:30:04 +0100
Message-ID: <w51sgjhb0qr.fsf@maestria.local.igalia.com>
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue 04 Feb 2020 06:08:16 PM CET, Max Reitz wrote:
> We want to unify child_format and child_file at some point.  One of the
> important things that set format drivers apart from other drivers is
> that they do not expect other format nodes under them (except in the
> backing chain).  That means we need something on which to distinguish
> format drivers from others, and hence this flag.
>
> Signed-off-by: Max Reitz <mreitz@redhat.com>

Reviewed-by: Alberto Garcia <berto@igalia.com>

Berto

