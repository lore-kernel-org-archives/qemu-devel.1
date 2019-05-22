Return-Path: <SRS0=8zLO=TW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C6A9C282CE
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 11:35:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 08571217D4
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 11:35:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="HGf/bsZL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08571217D4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:40613 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTPWq-0001uB-6L
	for qemu-devel@archiver.kernel.org; Wed, 22 May 2019 07:35:28 -0400
Received: from eggs.gnu.org ([209.51.188.92]:40359)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1hTPVE-000177-VG
	for qemu-devel@nongnu.org; Wed, 22 May 2019 07:33:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1hTPVE-0004hS-41
	for qemu-devel@nongnu.org; Wed, 22 May 2019 07:33:48 -0400
Received: from fanzine.igalia.com ([91.117.99.155]:42696)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <berto@igalia.com>)
	id 1hTPVA-0004ce-N4; Wed, 22 May 2019 07:33:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; 
	h=Content-Type:MIME-Version:Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From;
	bh=Z3sYTZKE5cE0JRAhwVpAcT4DghEAXZ3uWDj7KxVhDDA=; 
	b=HGf/bsZLDndm+q1mpcjCVxbRKGWVOOnzhODccpAFeI354OXCMKTQwczZhc0DtBg0+SO3wZ+rspQLx/N5E9wkshLAlDQezGpQATu7PXpWrtdTVZHgF4BhRnbKS9r7XXKC6lp8OyvK5Q4wgIyb8VFgF3bOUVBRWgUzfVXCu8DwjitZryMWWgiDPbxLoKs9GHtkjfMNfD/HDM5bVj3Snuv+s0Vhkirf9ZqOnhEZuxeHalDuNG8PrbE2HeckfqgwXpxtK8cdAiN/pM6rsPqc0TBkEPoCxh7HnW0Y+A6v0sIiulgirXJFthrWMLArMqjewvo7zSdmqguuoZr/+S3PtB8z5w==;
Received: from maestria.local.igalia.com ([192.168.10.14] helo=mail.igalia.com)
	by fanzine.igalia.com with esmtps 
	(Cipher TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim)
	id 1hTPV8-0008Hf-2M; Wed, 22 May 2019 13:33:42 +0200
Received: from berto by mail.igalia.com with local (Exim)
	id 1hTPV7-0003Pc-WA; Wed, 22 May 2019 13:33:41 +0200
From: Alberto Garcia <berto@igalia.com>
To: Anton Nefedov <anton.nefedov@virtuozzo.com>, qemu-block@nongnu.org
In-Reply-To: <20190516142749.81019-2-anton.nefedov@virtuozzo.com>
References: <20190516142749.81019-1-anton.nefedov@virtuozzo.com>
	<20190516142749.81019-2-anton.nefedov@virtuozzo.com>
User-Agent: Notmuch/0.18.2 (http://notmuchmail.org) Emacs/24.4.1
	(i586-pc-linux-gnu)
Date: Wed, 22 May 2019 13:33:41 +0200
Message-ID: <w51d0kag1uy.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x (no
	timestamps) [generic] [fuzzy]
X-Received-From: 91.117.99.155
Subject: Re: [Qemu-devel] [PATCH v14 1/1] qcow2: skip writing zero buffers
 to empty COW areas
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, den@virtuozzo.com,
	qemu-devel@nongnu.org, mreitz@redhat.com,
	Anton Nefedov <anton.nefedov@virtuozzo.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu 16 May 2019 04:27:49 PM CEST, Anton Nefedov wrote:
> If COW areas of the newly allocated clusters are zeroes on the backing
> image, efficient bdrv_write_zeroes(flags=BDRV_REQ_NO_FALLBACK) can be
> used on the whole cluster instead of writing explicit zero buffers later
> in perform_cow().
>
> iotest 060:
> write to the discarded cluster does not trigger COW anymore.
> Use a backing image instead.
>
> Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>

Reviewed-by: Alberto Garcia <berto@igalia.com>

Berto

