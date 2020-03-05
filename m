Return-Path: <SRS0=BVCf=4W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22807C3F2D1
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 19:12:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E46EF2073D
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 19:12:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="elsPeukk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E46EF2073D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55056 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9vua-0003mn-5l
	for qemu-devel@archiver.kernel.org; Thu, 05 Mar 2020 14:12:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59499)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berto@igalia.com>) id 1j9vtv-0003Ga-SS
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 14:11:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berto@igalia.com>) id 1j9vtt-0006MX-Ky
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 14:11:19 -0500
Received: from fanzine.igalia.com ([178.60.130.6]:55783)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <berto@igalia.com>)
 id 1j9vtt-0006IV-1i; Thu, 05 Mar 2020 14:11:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
 s=20170329; 
 h=Content-Type:MIME-Version:Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From;
 bh=j0+jRYnTgDNhdp0ezCbcxCSawper4FIGhsnnH3SVGco=; 
 b=elsPeukk3tbQOALr4NhCh5jxSvdczXw5iBx+IZ5MfzKW3lAgjvizolVYgjMA1Q6QDUqLjjp6eC43xwGmZSnW0nwlQt3Z+SPbjKYXzcuzOjxHAy92JeQ8SpXhy10eWEXhH6Co5zQOqtsp1jj7odAUOeD3BJ7Znnnlo+bp+QLsnC7Zcg0gEAGusG/Ju7prbx1oWB0MAQSHmdsaQCXeVsfoQUcV1vTQ6EcexYOZJWadfnxVLtbo/hav27bAl9EVaWVq6pAOUqeAVR8EE4NRH5OCv81SgQvU8iQ689aVC90lvIZjtOWVRxTjkzhhZQIqQE7O6JsEXht4yUmon5cuLgYUag==;
Received: from maestria.local.igalia.com ([192.168.10.14] helo=mail.igalia.com)
 by fanzine.igalia.com with esmtps 
 (Cipher TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim)
 id 1j9vto-0007oz-O7; Thu, 05 Mar 2020 20:11:12 +0100
Received: from berto by mail.igalia.com with local (Exim)
 id 1j9vto-0003mN-EE; Thu, 05 Mar 2020 20:11:12 +0100
From: Alberto Garcia <berto@igalia.com>
To: Denis Plotnikov <dplotnikov@virtuozzo.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH v5 2/5] qcow2: introduce compression type feature
In-Reply-To: <20200304133538.9159-3-dplotnikov@virtuozzo.com>
References: <20200304133538.9159-1-dplotnikov@virtuozzo.com>
 <20200304133538.9159-3-dplotnikov@virtuozzo.com>
User-Agent: Notmuch/0.18.2 (http://notmuchmail.org) Emacs/24.4.1
 (i586-pc-linux-gnu)
Date: Thu, 05 Mar 2020 20:11:12 +0100
Message-ID: <w51a74umxbj.fsf@maestria.local.igalia.com>
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

On Wed 04 Mar 2020 02:35:35 PM CET, Denis Plotnikov wrote:
> +##
> +# @Qcow2CompressionType:

I realized that we have a bit of a mix in the way we write this type of
identifiers between QCow2FooBar (capital C) and Qcow2FooBar ... what's
the recommended one?

> @@ -146,6 +146,12 @@ typedef struct QCowHeader {
>  
>      uint32_t refcount_order;
>      uint32_t header_length;
> +
> +    /* Additional fields */
> +    uint8_t  compression_type;
> +
> +    /* header must be a multiple of 8 */
> +    uint8_t  padding[7];
>  } QEMU_PACKED QCowHeader;

Is it worth adding a static assertion here ?

Berto

