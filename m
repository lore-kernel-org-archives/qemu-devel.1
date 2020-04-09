Return-Path: <SRS0=qpXq=5Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98C69C2BA2B
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2020 14:50:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 59DD020692
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2020 14:50:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BLVX+mCI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59DD020692
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51030 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jMYVL-0004Iy-J7
	for qemu-devel@archiver.kernel.org; Thu, 09 Apr 2020 10:50:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42826)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jMYUi-0003aC-En
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 10:49:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1jMYUh-0000HL-8D
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 10:49:28 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:49382
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1jMYUg-0000GZ-KN
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 10:49:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586443765;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PvqwSjbrl7g4cxcyYsFWpP+EQRxsQkAigZC0N5QtIvI=;
 b=BLVX+mCIOuTFuySOo2s/yZniircMvADPR/qIOmMrQ2hkJbAw6594F3WN6DiSnTS4KFEBAp
 CQqomydLgcurPRNKMfmUTWK0TfYzLsRvEGtXBeNPM/QvG42BJewfa3ZOBLqSF5gdzyPD92
 pqkbHcbW3CwrqtWt/aswZYPmLqQv2AY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-210-hWN2cZU9PHKJBrQ_zX8gFQ-1; Thu, 09 Apr 2020 10:49:23 -0400
X-MC-Unique: hWN2cZU9PHKJBrQ_zX8gFQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6219F18C43C7;
 Thu,  9 Apr 2020 14:49:22 +0000 (UTC)
Received: from [10.3.114.49] (ovpn-114-49.phx2.redhat.com [10.3.114.49])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9EAE160BF3;
 Thu,  9 Apr 2020 14:49:21 +0000 (UTC)
Subject: Re: [PATCH v4 28/30] qcow2: Add the 'extended_l2' option and the
 QCOW2_INCOMPAT_EXTL2 bit
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
References: <cover.1584468723.git.berto@igalia.com>
 <3de25a8fec2085e835c0f167ad91f05bd9002fa4.1584468724.git.berto@igalia.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <eef91c39-dcf2-1b37-af4d-80d2ee5bf77e@redhat.com>
Date: Thu, 9 Apr 2020 09:49:21 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <3de25a8fec2085e835c0f167ad91f05bd9002fa4.1584468724.git.berto@igalia.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "Denis V . Lunev" <den@openvz.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/17/20 1:16 PM, Alberto Garcia wrote:
> Now that the implementation of subclusters is complete we can finally
> add the necessary options to create and read images with this feature,
> which we call "extended L2 entries".
> 
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> Reviewed-by: Max Reitz <mreitz@redhat.com>
> ---

> +++ b/qapi/block-core.json
> @@ -66,6 +66,9 @@
>   #                 standalone (read-only) raw image without looking at qcow2
>   #                 metadata (since: 4.0)
>   #
> +# @extended-l2: true if the image has extended L2 entries; only valid for
> +#               compat >= 1.1 (since 5.0)

Looks like we'll have to tweak this to 5.1 now (multiple spots).

> +++ b/block/qcow2.h
> @@ -231,13 +231,16 @@ enum {
>       QCOW2_INCOMPAT_DIRTY_BITNR      = 0,
>       QCOW2_INCOMPAT_CORRUPT_BITNR    = 1,
>       QCOW2_INCOMPAT_DATA_FILE_BITNR  = 2,
> +    QCOW2_INCOMPAT_EXTL2_BITNR      = 4,

Why are we skipping bit 3?  (Hmm, now I have to go find the earlier 
patch that touched the spec...)

aha - the spec documented compression bits (the spec change for those 
made 5.0, but the qcow2 implementation did not); we'll have to rebase 
depending on what lands first.  But the resolution of that merge 
conflict will result in both feature bits eventually existing here.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


