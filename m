Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C48A4C1975A
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 18:46:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 93DDD20724
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 18:46:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="dUZk+CMP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93DDD20724
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39746 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEHEc-00028V-P4
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 14:46:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39637)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berto@igalia.com>) id 1jEH8C-0003IZ-5h
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 14:40:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berto@igalia.com>) id 1jEH89-0003Dl-VN
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 14:39:59 -0400
Received: from fanzine.igalia.com ([178.60.130.6]:56363)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <berto@igalia.com>)
 id 1jEH89-00032A-Lq; Tue, 17 Mar 2020 14:39:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
 s=20170329; 
 h=Content-Type:MIME-Version:Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From;
 bh=L90L256eetdjrBb3hySz2ppZX/NPByekqjWwyfvU14w=; 
 b=dUZk+CMPZSuvfYH2YhKq3zAdcs+O9zL56s1HA7YtxtyU6PE4OKls+q7WTkrgYRJ1ntqOHJb+HwPel7P6pbF8ULHakg1bINxFVY4OIotWlK5oPofrNvLrcMaPp0kztbkMPDGWnBorXz4I7kMZnEnRFuZh4dUvU85rWkzNibUWcciyA8ELkOxz4OSPlMsFSFYn3gk5thwHNG/fZcBEmoVyzOrf3x7VO5JOxKW8J8RIR7SASHx9kzsyr2GZBQZaUg3veEixqrgrB08PPrIY4NWW51ObxcgGuDEJqcUWw8mhQLI2UPAZGJKo1LZHU3Ep/KHmP4JRlNCyMT5qjAGOkED9+w==;
Received: from maestria.local.igalia.com ([192.168.10.14] helo=mail.igalia.com)
 by fanzine.igalia.com with esmtps 
 (Cipher TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim)
 id 1jEH86-0002yz-Pm; Tue, 17 Mar 2020 19:39:54 +0100
Received: from berto by mail.igalia.com with local (Exim)
 id 1jEH86-0006bv-GQ; Tue, 17 Mar 2020 19:39:54 +0100
From: Alberto Garcia <berto@igalia.com>
To: qemu-devel@nongnu.org
Subject: Re: [PATCH 0/2] Convert qcow2_get_cluster_offset() into
 qcow2_get_host_offset()
In-Reply-To: <cover.1582828123.git.berto@igalia.com>
References: <cover.1582828123.git.berto@igalia.com>
User-Agent: Notmuch/0.18.2 (http://notmuchmail.org) Emacs/24.4.1
 (i586-pc-linux-gnu)
Date: Tue, 17 Mar 2020 19:39:54 +0100
Message-ID: <w51d09a6d1h.fsf@maestria.local.igalia.com>
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu 27 Feb 2020 07:34:24 PM CET, Alberto Garcia wrote:
> Hi,
>
> this is something I did while working on the subcluster series but
> it's independent from it so I thought to send it already.

I included this patches in v4 of the main series so you can ignore this
thread.

Berto

