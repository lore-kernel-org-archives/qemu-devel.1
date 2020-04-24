Return-Path: <SRS0=J7/p=6I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3166C54FD0
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2020 18:42:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 755EC20774
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2020 18:42:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="ps+G3tC6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 755EC20774
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48282 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jS3HE-0003Pd-KD
	for qemu-devel@archiver.kernel.org; Fri, 24 Apr 2020 14:42:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42806)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berto@igalia.com>) id 1jS3GJ-0002AR-Bp
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 14:41:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <berto@igalia.com>) id 1jS3GI-0003O0-R5
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 14:41:19 -0400
Received: from fanzine.igalia.com ([178.60.130.6]:36255)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1jS3GI-0003KK-9W; Fri, 24 Apr 2020 14:41:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
 s=20170329; 
 h=Content-Type:MIME-Version:Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From;
 bh=OqaxqUTc753QtjLloI/nimYGhMIk7My7mLj3f13xTcA=; 
 b=ps+G3tC6UozSNQU9c6nWdcFuSLXOEljFYoC3rsz6w7NlfPhNxj/hmpHpt7XmIC76PNOOJa8U7TXuqgAgoSiEap/AGboJ2Pg8YNysgqLyMMf//o3v85/6Ugl2qlXZBhqrxblxRN4WtHfGeZhJJNT74cllsSWbONWnUD0peuWMjZj0yHGm8sXBno8yE8xgr/ySH+FqL/drdzLYpGkOWKClhqxTnBQExEUkKjEXgv54ZCsvUwlhPoG+Fwb5HgYnecx5g2y4Ii8ZkmMWu0Gzn364jmcfGHWFBZD3Kp6SVMx6Zv1xP+MCAYe7dv+LfQ1wqySiZ4bXPSW7ZVvGtOeSb0IH9A==;
Received: from maestria.local.igalia.com ([192.168.10.14] helo=mail.igalia.com)
 by fanzine.igalia.com with esmtps 
 (Cipher TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim)
 id 1jS3GD-0003ur-AT; Fri, 24 Apr 2020 20:41:13 +0200
Received: from berto by mail.igalia.com with local (Exim)
 id 1jS3GD-0008H6-0u; Fri, 24 Apr 2020 20:41:13 +0200
From: Alberto Garcia <berto@igalia.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH v4 24/30] qcow2: Clear the L2 bitmap when allocating a
 compressed cluster
In-Reply-To: <971a6e4b-ba44-4280-89fa-d454cddf12e1@virtuozzo.com>
References: <cover.1584468723.git.berto@igalia.com>
 <6d596d82ed62615a8565b661691a06bfaf32237e.1584468723.git.berto@igalia.com>
 <w51r1wcn7eu.fsf@maestria.local.igalia.com>
 <1606ecb5-98ea-fefb-bb98-2ecda1d65f5c@redhat.com>
 <w51o8rgn6j6.fsf@maestria.local.igalia.com>
 <57ac1a2f-1632-1a00-b18d-1fc2169175b6@redhat.com>
 <971a6e4b-ba44-4280-89fa-d454cddf12e1@virtuozzo.com>
User-Agent: Notmuch/0.18.2 (http://notmuchmail.org) Emacs/24.4.1
 (i586-pc-linux-gnu)
Date: Fri, 24 Apr 2020 20:41:12 +0200
Message-ID: <w51ftcsn2uv.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=178.60.130.6; envelope-from=berto@igalia.com;
 helo=fanzine.igalia.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/24 13:02:51
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x (no timestamps) [generic] [fuzzy]
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
Cc: Kevin Wolf <kwolf@redhat.com>, "Denis V . Lunev" <den@openvz.org>,
 Anton Nefedov <anton.nefedov@virtuozzo.com>, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri 24 Apr 2020 08:15:04 PM CEST, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com> wrote:
> AFAIK, now compressed clusters can't be used in scenarios with guest,
> as qcow2 driver doesn't support rewriting them.

You can write to those images just fine, it's just not efficient because
you have to COW the compressed clusters.

> Or am I wrong? And we normally don't combine normal and compressed
> clusters together in one image.

As soon as you start writing to an image with compressed clusters you'll
have a combination of both.

But it's true that you don't have an image with compressed clusters if
what you're looking for is performance. So I wouldn't add support for
this if it complicates things too much.

Berto

