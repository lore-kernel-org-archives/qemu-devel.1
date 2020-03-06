Return-Path: <SRS0=PWAB=4X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4075C10DCE
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 10:32:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ADD922073D
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 10:32:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="lpx0aFZI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADD922073D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34200 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jAAHD-00068X-PY
	for qemu-devel@archiver.kernel.org; Fri, 06 Mar 2020 05:32:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46247)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berto@igalia.com>) id 1jAAGO-0005iu-3k
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 05:31:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berto@igalia.com>) id 1jAAGM-0006m1-5S
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 05:31:27 -0500
Received: from fanzine.igalia.com ([178.60.130.6]:42550)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <berto@igalia.com>)
 id 1jAAGL-0006eF-IA; Fri, 06 Mar 2020 05:31:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
 s=20170329; 
 h=Content-Type:MIME-Version:Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From;
 bh=o0quDIOENhDpbUPH48rla7ahU6LVMD08QVwDu8spE8o=; 
 b=lpx0aFZIpi2IBqLfxDHJUu2aLxBlxy/v6UcEA9bfV7wk9NDQWPJcLJqK9fJraq2nhqzQttGcAgPNOCH1OoQx/vGeItiLO03+lkhNRif1994c5q9G08gncFmsBPJy8OaC6HgDs/+kxwwQyQsz7SLTx+HGZCuqhYOBIHD6ACx+x05mdHn71mIUItHYVmSHDpB5xW5QMTCc+uKUQ6uEclMqQ1EXYtwowUprpKQDRVrXvOjzDTa0hch9+g4RGyiBaLmWtYLK0EC8sTS3qesNzbDK6YEYN46cUw+ChuiQfZvZRLlTrMKEkYaCQ+tI3FmXLJw99O0D08+NeNODFFGdL8g6sg==;
Received: from maestria.local.igalia.com ([192.168.10.14] helo=mail.igalia.com)
 by fanzine.igalia.com with esmtps 
 (Cipher TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim)
 id 1jAAGG-0000C4-TE; Fri, 06 Mar 2020 11:31:20 +0100
Received: from berto by mail.igalia.com with local (Exim)
 id 1jAAGG-00031d-Jd; Fri, 06 Mar 2020 11:31:20 +0100
From: Alberto Garcia <berto@igalia.com>
To: Denis Plotnikov <dplotnikov@virtuozzo.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH v5 3/5] qcow2: rework the cluster compression routine
In-Reply-To: <20200304133538.9159-4-dplotnikov@virtuozzo.com>
References: <20200304133538.9159-1-dplotnikov@virtuozzo.com>
 <20200304133538.9159-4-dplotnikov@virtuozzo.com>
User-Agent: Notmuch/0.18.2 (http://notmuchmail.org) Emacs/24.4.1
 (i586-pc-linux-gnu)
Date: Fri, 06 Mar 2020 11:31:20 +0100
Message-ID: <w51sgilsrk7.fsf@maestria.local.igalia.com>
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
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, qemu-block@nongnu.org,
 armbru@redhat.com, mreitz@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed 04 Mar 2020 02:35:36 PM CET, Denis Plotnikov wrote:
> The patch enables processing the image compression type defined
> for the image and chooses an appropriate method for image clusters
> (de)compression.
>
> Signed-off-by: Denis Plotnikov <dplotnikov@virtuozzo.com>
> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

Reviewed-by: Alberto Garcia <berto@igalia.com>

Berto

