Return-Path: <SRS0=Tmh/=3Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53B66C35254
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 13:52:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2010D2082E
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 13:52:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hAo6obG9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2010D2082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47400 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izL6s-0004d0-8F
	for qemu-devel@archiver.kernel.org; Wed, 05 Feb 2020 08:52:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52385)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1izL6E-00049T-B7
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 08:52:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1izL6C-0001jI-9U
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 08:52:13 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:48808
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1izL6C-0001fD-2o
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 08:52:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580910731;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=D+bn0gY58nI+S26rHTO5iBso8u7mogSdW8XAPF8jiZs=;
 b=hAo6obG9DbXV89Vae5RSr5mfKJKXt75YpXEJLKXF6x5jWeHZZkQayWrKCkPIFHwJ+BkS5U
 iUD74OGM2lk3fUktT5f+EsfNCP830Jrrmk2YG+R24zt+IsD5tdYkExwL7cQI/ugIUpLcIj
 ZCynEMH7fGd+NCk7i4GhQiOayADiqOY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-429-FDeXKmWZOT-Fvh2zD2Gwfg-1; Wed, 05 Feb 2020 08:51:57 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7AFA41007282;
 Wed,  5 Feb 2020 13:51:56 +0000 (UTC)
Received: from [10.3.116.181] (ovpn-116-181.phx2.redhat.com [10.3.116.181])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0483A87B15;
 Wed,  5 Feb 2020 13:51:55 +0000 (UTC)
Subject: Re: [PATCH v2 01/33] block: Add BlockDriver.is_format
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
References: <20200204170848.614480-1-mreitz@redhat.com>
 <20200204170848.614480-2-mreitz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <b7d80192-bc07-c1d4-2aa8-c729894cd183@redhat.com>
Date: Wed, 5 Feb 2020 07:51:55 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200204170848.614480-2-mreitz@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: FDeXKmWZOT-Fvh2zD2Gwfg-1
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/4/20 11:08 AM, Max Reitz wrote:
> We want to unify child_format and child_file at some point.  One of the
> important things that set format drivers apart from other drivers is
> that they do not expect other format nodes under them (except in the
> backing chain).  That means we need something on which to distinguish
> format drivers from others, and hence this flag.

It _is_ possible to set up a format node on top of another; in fact, our 
testsuite does that in at least iotest 072.  I agree that setups like 
'qcow2 - qcow2 - file' are uncommon, but the setup 'qcow2 - raw - file' 
may be useful for extracting a partition of a raw disk when it is known 
that the partition in that disk itself contains qcow2 data.

> 
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---

> +++ b/include/block/block_int.h
> @@ -94,6 +94,13 @@ struct BlockDriver {
>        * must implement them and return -ENOTSUP.
>        */
>       bool is_filter;
> +    /*
> +     * Set to true if the BlockDriver is a format driver.  Format nodes
> +     * generally do not expect their children to be other format nodes
> +     * (except for backing files), and so format probing is disabled
> +     * on those children.

Aha - nested formats ARE still allowed when you explicitly request it 
(which is what iotest 72 does) - what you are stating here is that 
implicit probing of is forbidden for a parent declared as a format 
driver.  That makes more sense.

I'm not sure if the commit message needs a tweak, but the patch itself 
is sane as-is.

Reviewed-by: Eric Blake <eblake@redhat.com>

> +     */
> +    bool is_format;
>       /*
>        * Return true if @to_replace can be replaced by a BDS with the
>        * same data as @bs without it affecting @bs's behavior (that is,
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


