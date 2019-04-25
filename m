Return-Path: <SRS0=VSQP=S3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7CE1C43219
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2019 16:47:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 315A3206BF
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2019 16:47:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="r1FAJ0a6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 315A3206BF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:60751 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJhXB-0003LU-NE
	for qemu-devel@archiver.kernel.org; Thu, 25 Apr 2019 12:47:41 -0400
Received: from eggs.gnu.org ([209.51.188.92]:56096)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1hJhVv-0002es-TF
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 12:46:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1hJhVv-00087K-0c
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 12:46:23 -0400
Received: from fanzine.igalia.com ([91.117.99.155]:54732)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <berto@igalia.com>)
	id 1hJhVu-00085q-AA; Thu, 25 Apr 2019 12:46:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; 
	h=Content-Type:MIME-Version:Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From;
	bh=rwjaVhS+OKXnDHvpL9TZQxlnLj+yxNk22c7M37T5Bk0=; 
	b=r1FAJ0a6AqbjSdkevFsexsDJ6EU5V+8fAwa/ZfaW5s/uxDw5xyTWeFl0bLe6SxgDmoZxqiYhDKf4OriIYFaxQI3A7yziBp/UhM6akpZPO3TfuZMsUHsvqgZIEYujzD8Ppb4LzSKOaBtO/bXg9MIjotaniU8fxBMVm+A7Uy0GGWvRr6Yv7CIG0paUh47ixyI22rd3ChknpfG6qmBlXHlOHzs1AUyhAY9R65Th4ZSnrU3okZAEJr0SPdyF9VGqJ814SgW695pHD9nAsLCp0rIV4RzzGF2J/iB/sLLH8dkfcBZ3w4gxH9vXtuOTnbgT9OkvtsfBk6xAjoSTpeWG6M+T4w==;
Received: from maestria.local.igalia.com ([192.168.10.14] helo=mail.igalia.com)
	by fanzine.igalia.com with esmtps 
	(Cipher TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim)
	id 1hJhVn-00068N-P3; Thu, 25 Apr 2019 18:46:15 +0200
Received: from berto by mail.igalia.com with local (Exim)
	id 1hJhVn-0005cM-MQ; Thu, 25 Apr 2019 18:46:15 +0200
From: Alberto Garcia <berto@igalia.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
	qemu-devel@nongnu.org, qemu-block@nongnu.org
In-Reply-To: <20190422101900.13897-2-vsementsov@virtuozzo.com>
References: <20190422101900.13897-1-vsementsov@virtuozzo.com>
	<20190422101900.13897-2-vsementsov@virtuozzo.com>
User-Agent: Notmuch/0.18.2 (http://notmuchmail.org) Emacs/24.4.1
	(i586-pc-linux-gnu)
Date: Thu, 25 Apr 2019 18:46:15 +0200
Message-ID: <w51bm0u119k.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x (no
	timestamps) [generic] [fuzzy]
X-Received-From: 91.117.99.155
Subject: Re: [Qemu-devel] [PATCH v5 1/3] block: include base when checking
 image chain for block allocation
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
Cc: fam@euphon.net, kwolf@redhat.com, vsementsov@virtuozzo.com,
	wencongyang2@huawei.com, xiechanglong.d@gmail.com,
	mreitz@redhat.com, stefanha@redhat.com,
	andrey.shinkevich@virtuozzo.com, den@openvz.org, jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190425164615.Qve9cuxIjWX0DKO2iXlQWBgL4Z2hB-6qBEz6zG3QqUc@z>

On Mon 22 Apr 2019 12:18:58 PM CEST, Vladimir Sementsov-Ogievskiy wrote:
>   * Given an image chain: ... -> [BASE] -> [INTER1] -> [INTER2] -> [TOP]
>   *
>   * Return true if (a prefix of) the given range is allocated in any image
> - * between BASE and TOP (inclusive).  BASE can be NULL to check if the given
> - * offset is allocated in any image of the chain.  Return false otherwise,
> - * or negative errno on failure.
> + * between BASE and TOP (BASE is only included if include_base is set).
> + * BASE can be NULL to check if the given offset is allocated in any
> + * image of the chain.  Return false otherwise, or negative errno on
> + * failure.

This is a pre-existing problem and probably a bit pedantic, but I just
realized that this description is not quite correct. This function does
not return true and false (bool), but 1 and 0 (int). This is so in order
to be able to return < 0 on errors.

I think I'd replace true and false with 1 and 0 on that message.

Berto

