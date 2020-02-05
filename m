Return-Path: <SRS0=Tmh/=3Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8669C352A2
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 20:37:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 857B92072B
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 20:37:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aZ0rD8KT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 857B92072B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56118 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izRPv-0004lA-NB
	for qemu-devel@archiver.kernel.org; Wed, 05 Feb 2020 15:36:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35625)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1izRNB-0000YT-E3
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 15:34:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1izRNA-0000J7-Eo
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 15:34:09 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:28228
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1izRNA-0000H9-9q
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 15:34:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580934848;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7JN2k2cLKwotHm2lULx+byWeE7lu315FR7xFVDciwWU=;
 b=aZ0rD8KTBizEw4XAty7Kj9ONnkNOz31V6TvD1N3P8mAAeOcaZjnjIuecUh0HZ3GV0vmAcR
 XEAYRe/rDE/1XRYKl7EEQQMzi7Hqur4tT0JAG38+4bPPpx1P8b3K20UlPcQqs8qkg8GoI0
 YoUeLiK9YynW9aLlO+wE9iN0LMi2jMM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-49-j6eu7z8NOFKjkqfcRRhW1Q-1; Wed, 05 Feb 2020 15:33:45 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 78BDC8010FB;
 Wed,  5 Feb 2020 20:33:43 +0000 (UTC)
Received: from [10.3.116.181] (ovpn-116-181.phx2.redhat.com [10.3.116.181])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 04D5589E81;
 Wed,  5 Feb 2020 20:33:42 +0000 (UTC)
Subject: Re: [PATCH v2 13/33] block: Add child_of_bds
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
References: <20200204170848.614480-1-mreitz@redhat.com>
 <20200204170848.614480-14-mreitz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <04d25165-4152-0696-4c09-b7e6109c945e@redhat.com>
Date: Wed, 5 Feb 2020 14:33:42 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200204170848.614480-14-mreitz@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: j6eu7z8NOFKjkqfcRRhW1Q-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/4/20 11:08 AM, Max Reitz wrote:
> Any current user of child_file, child_format, and child_backing can and
> should use this generic BdrvChildClass instead, as it can handle all of
> these cases.  However, to be able to do so, the users must pass the
> appropriate BdrvChildRole when the child is created/attached.  (The
> following commits will take care of that.)
> 
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>   block.c                   | 27 +++++++++++++++++++++++++++
>   include/block/block_int.h |  1 +
>   2 files changed, 28 insertions(+)
> 
Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


