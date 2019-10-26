Return-Path: <SRS0=l02z=YT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD285CA9EB9
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Oct 2019 21:53:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 437E6214DA
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Oct 2019 21:53:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="PU72NPVY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 437E6214DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42766 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iOU0L-0008Pn-Ld
	for qemu-devel@archiver.kernel.org; Sat, 26 Oct 2019 17:53:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60642)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berto@igalia.com>) id 1iOTaJ-0000zY-W3
 for qemu-devel@nongnu.org; Sat, 26 Oct 2019 17:26:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berto@igalia.com>) id 1iOTaI-0005c2-Uz
 for qemu-devel@nongnu.org; Sat, 26 Oct 2019 17:26:55 -0400
Received: from fanzine.igalia.com ([178.60.130.6]:42781)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <berto@igalia.com>)
 id 1iOTaI-0005R3-MW; Sat, 26 Oct 2019 17:26:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
 s=20170329; 
 h=Content-Type:MIME-Version:Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From;
 bh=fxHAcZyJ3gNY2kpoywFUNJ1Lvfmt0hiZeLa1hHLprHk=; 
 b=PU72NPVYeFhO6X+M2nxG1PAl0x0T7GfDnCtZyjG5UYiJO2QR/Icmi4v7UpHUcMOGfJiGCUpP2MHXjpCkKFyNCyxS3dCKPRE4sjtKDU9KgBsEFYUHeL/jhcDZJPRXmMoUjrmvwJ9qQCkOX8aYkPLylskQlbSvwEutbyEVHCaaLEplCHwYOVlgunx/lVkfUJS4hIiVL7yNCRmxMKjev9FXDo6uHjhVQofdAQFUB3ug6NLdACSsckl0Jy5V08NYA3QRzczVX9rvRiNbQtJSlGNSq0d7XkDh/Z6KE9Gyw1WqQYpr/wzdYCUUxfmkZIhtSvtrqELPS2tM3femDVOwrJvwrw==;
Received: from maestria.local.igalia.com ([192.168.10.14] helo=mail.igalia.com)
 by fanzine.igalia.com with esmtps 
 (Cipher TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim)
 id 1iOTZu-0004CV-P2; Sat, 26 Oct 2019 23:26:30 +0200
Received: from berto by mail.igalia.com with local (Exim)
 id 1iOTZu-0003DB-M7; Sat, 26 Oct 2019 23:26:30 +0200
From: Alberto Garcia <berto@igalia.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "qemu-devel\@nongnu.org" <qemu-devel@nongnu.org>
Subject: Re: [RFC PATCH 00/23] Add subcluster allocation to qcow2
In-Reply-To: <666d9f71-9279-8d53-ca20-75d9db8aebc0@virtuozzo.com>
References: <cover.1571152571.git.berto@igalia.com>
 <666d9f71-9279-8d53-ca20-75d9db8aebc0@virtuozzo.com>
User-Agent: Notmuch/0.18.2 (http://notmuchmail.org) Emacs/24.4.1
 (i586-pc-linux-gnu)
Date: Sat, 26 Oct 2019 23:26:30 +0200
Message-ID: <w51pnij42rd.fsf@maestria.local.igalia.com>
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
Cc: Kevin Wolf <kwolf@redhat.com>, Anton Nefedov <anton.nefedov@virtuozzo.com>,
 Denis Lunev <den@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed 23 Oct 2019 12:39:14 PM CEST, Vladimir Sementsov-Ogievskiy wrote:
> Hi!
>
> This is very interesting! Could you please export a branch to look at,
> as patches can't be applied on master now :(

I just sent a new version with some updates and rebased on top of the
current master.

Berto

