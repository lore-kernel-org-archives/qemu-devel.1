Return-Path: <SRS0=d4IR=4I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B09DC11D05
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 16:37:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 06E92207FD
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 16:37:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W5lAmqOt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06E92207FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45720 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4oox-0005P3-7N
	for qemu-devel@archiver.kernel.org; Thu, 20 Feb 2020 11:37:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59947)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1j4ooG-0004gk-4B
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 11:36:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1j4ooE-0005Wl-Cn
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 11:36:19 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:26804
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1j4ooE-0005V7-85
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 11:36:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582216577;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=siw/m46itl6vJEcDqDKkBrRUuaGehHTAyHK10+KqwZ0=;
 b=W5lAmqOtj4Ntfvise1kqu0Kb1fCgjnXwdxn0PsV1RtTSCWD6ekqDRTV+6bn5HvrdIsY/Ye
 rf5Ng4OWzb3Ib3UATRvnec3oNIOG40NGPixUOQPOJ6KQzeCCnhH5XTfrHEU0xkLd6qfgv6
 FbrkwGeGt1uWxWuKvCLn1jsHcbXAKZw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-313-YwaDfwr9M_Kpk_IC4kjWiA-1; Thu, 20 Feb 2020 11:36:06 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 619D618C8C00;
 Thu, 20 Feb 2020 16:36:05 +0000 (UTC)
Received: from [10.3.116.180] (ovpn-116-180.phx2.redhat.com [10.3.116.180])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C1FC51001281;
 Thu, 20 Feb 2020 16:36:04 +0000 (UTC)
Subject: Re: [PULL 06/18] qemu-img: Add --target-is-zero to convert
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
References: <20200220160710.533297-1-mreitz@redhat.com>
 <20200220160710.533297-7-mreitz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <2c912ba1-998c-9ddb-55a4-c2ea1bb57edd@redhat.com>
Date: Thu, 20 Feb 2020 10:36:04 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200220160710.533297-7-mreitz@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: YwaDfwr9M_Kpk_IC4kjWiA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 David Edmondson <david.edmondson@oracle.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/20/20 10:06 AM, Max Reitz wrote:
> From: David Edmondson <david.edmondson@oracle.com>
> 
> In many cases the target of a convert operation is a newly provisioned
> target that the user knows is blank (reads as zero). In this situation
> there is no requirement for qemu-img to wastefully zero out the entire
> device.
> 
> Add a new option, --target-is-zero, allowing the user to indicate that
> an existing target device will return zeros for all reads.
> 
> Signed-off-by: David Edmondson <david.edmondson@oracle.com>
> Message-Id: <20200205110248.2009589-2-david.edmondson@oracle.com>
> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> Reviewed-by: Eric Blake <eblake@redhat.com>
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>   docs/interop/qemu-img.rst |  9 ++++++++-
>   qemu-img-cmds.hx          |  4 ++--
>   qemu-img.c                | 26 +++++++++++++++++++++++---
>   3 files changed, 33 insertions(+), 6 deletions(-)
> 
> diff --git a/docs/interop/qemu-img.rst b/docs/interop/qemu-img.rst
> index 42e4451db4..5f40137c10 100644
> --- a/docs/interop/qemu-img.rst
> +++ b/docs/interop/qemu-img.rst
> @@ -214,6 +214,13 @@ Parameters to convert subcommand:
>     will still be printed.  Areas that cannot be read from the source will be
>     treated as containing only zeroes.
>   
> +.. option:: --target-is-zero
> +
> +  Assume that reading the destination image will always return
> +  zeros. This parameter is mutually exclusive with a destination image

Late tweak now that this is in a pull request, so we may want a followup 
patch, but:

The image doesn't always return zeros after we write to it, maybe we 
should tweak this sentence:

Assume that reading the destination image will initially return all zeros.

Also, my earlier comment about 'zeroes' one line before 'zeros' still 
applies - although both spellings are valid, we look inconsistent when 
we can't make up our mind within two adjacent paragraphs.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


