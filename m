Return-Path: <SRS0=PWAB=4X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FF8FC10DCE
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 14:59:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C7CE20848
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 14:59:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="KmnacYjK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C7CE20848
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37906 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jAERf-0005Rq-6T
	for qemu-devel@archiver.kernel.org; Fri, 06 Mar 2020 09:59:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58109)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berto@igalia.com>) id 1jAER6-0004yN-7S
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 09:58:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berto@igalia.com>) id 1jAER5-0004wo-CK
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 09:58:48 -0500
Received: from fanzine.igalia.com ([178.60.130.6]:34418)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <berto@igalia.com>)
 id 1jAER1-0004o7-DM; Fri, 06 Mar 2020 09:58:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
 s=20170329; 
 h=Content-Type:MIME-Version:Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From;
 bh=g51jNg0BYrwU2XOAyLQkzTSo6li/SLPUW4A7N6ddFpE=; 
 b=KmnacYjKNYvh1sXNSgD7IWQupCdrULwFlbsH9me5bC4SHTKBqZvtAvNJ5I7ZmcWiN/UzkvuSiozsqwmk8iKdfK/+cOXAi09fVjz3Te/nmkrXQv7addZcKcoEB36siwsGmAHP3v9HjEP+FcxvDrxHKDL4lz25Z9ZWIX5qxYEyqSaJmtGSvetYuExxVRB8OSMw72L1cN87actRumvF8aeoeAlGXeHX8OJ8rMgUuWsDkMLsF1IbW3VrxBaaAZARa73rll5IMhB9teh5aXH5AfjeSTitdH856MnudYuG2a4JOXzq7EXONv5z23896jFBxSAehohsYDrXZpqFCkU7LUutIg==;
Received: from maestria.local.igalia.com ([192.168.10.14] helo=mail.igalia.com)
 by fanzine.igalia.com with esmtps 
 (Cipher TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim)
 id 1jAEQx-00041G-Du; Fri, 06 Mar 2020 15:58:39 +0100
Received: from berto by mail.igalia.com with local (Exim)
 id 1jAEQx-00079c-4Y; Fri, 06 Mar 2020 15:58:39 +0100
From: Alberto Garcia <berto@igalia.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Subject: Re: [PATCH v2 2/2] block: bdrv_reopen() with backing file in
 different AioContext
In-Reply-To: <20200306141413.30705-3-kwolf@redhat.com>
References: <20200306141413.30705-1-kwolf@redhat.com>
 <20200306141413.30705-3-kwolf@redhat.com>
User-Agent: Notmuch/0.18.2 (http://notmuchmail.org) Emacs/24.4.1
 (i586-pc-linux-gnu)
Date: Fri, 06 Mar 2020 15:58:39 +0100
Message-ID: <w51k13xsf6o.fsf@maestria.local.igalia.com>
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
Cc: kwolf@redhat.com, pkrempa@redhat.com, qemu-devel@nongnu.org,
 mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri 06 Mar 2020 03:14:13 PM CET, Kevin Wolf wrote:
> This patch allows bdrv_reopen() (and therefore the x-blockdev-reopen QMP
> command) to attach a node as the new backing file even if the node is in
> a different AioContext than the parent if one of both nodes can be moved
> to the AioContext of the other node.
>
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> Tested-by: Peter Krempa <pkrempa@redhat.com>

Reviewed-by: Alberto Garcia <berto@igalia.com>

Berto

