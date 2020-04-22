Return-Path: <SRS0=gSpC=6G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6CB4C54FCB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 15:35:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7BFBB2082E
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 15:35:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RrGze3Ny"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BFBB2082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52910 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRHP9-0003j8-2x
	for qemu-devel@archiver.kernel.org; Wed, 22 Apr 2020 11:35:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39598)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jRHNX-0001wc-UA
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 11:33:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jRHNX-0006IJ-DX
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 11:33:35 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:20322
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jRHNW-0006Fm-WF
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 11:33:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587569614;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MNTvpnxmpvg/ukbCJQ71DC8JDazmmNF4hvooQE2wAlk=;
 b=RrGze3NyDED6wyN2EFDUQ7PvAQY7i5mb/4ld7ibauy2SIpcpykBl+t12Th2OF2wfg7mkRb
 jGiqlomJtuikNA+fZWPms8e+DWNky3Ft64TK1AxWwgW6d/cScBmxVwMYvUQgfXAUVMR/Th
 kOKzUaFbUvnX+37HbOvLLGDy5d91ZzI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-117-K8UrEQyfMICSJmGLZgm4Pw-1; Wed, 22 Apr 2020 11:33:29 -0400
X-MC-Unique: K8UrEQyfMICSJmGLZgm4Pw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DC798107ACC7;
 Wed, 22 Apr 2020 15:33:27 +0000 (UTC)
Received: from [10.10.116.80] (ovpn-116-80.rdu2.redhat.com [10.10.116.80])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 20FFD5DA66;
 Wed, 22 Apr 2020 15:33:26 +0000 (UTC)
Subject: Re: [PATCH v5 4/9] qcow2: Support BDRV_REQ_ZERO_WRITE for truncate
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
References: <20200422152129.167074-1-kwolf@redhat.com>
 <20200422152129.167074-5-kwolf@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <84c6ca49-aef3-adf4-2efe-68357dd20ce8@redhat.com>
Date: Wed, 22 Apr 2020 10:33:25 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200422152129.167074-5-kwolf@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/22 02:12:04
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
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
Cc: vsementsov@virtuozzo.com, berto@igalia.com, qemu-devel@nongnu.org,
 mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/22/20 10:21 AM, Kevin Wolf wrote:
> If BDRV_REQ_ZERO_WRITE is set and we're extending the image, calling
> qcow2_cluster_zeroize() with flags=0 does the right thing: It doesn't
> undo any previous preallocation, but just adds the zero flag to all
> relevant L2 entries. If an external data file is in use, a write_zeroes
> request to the data file is made instead.
> 
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>   block/qcow2.c | 30 ++++++++++++++++++++++++++++++
>   1 file changed, 30 insertions(+)
> 

> @@ -4214,6 +4215,35 @@ static int coroutine_fn qcow2_co_truncate(BlockDriverState *bs, int64_t offset,
>           g_assert_not_reached();
>       }
>   
> +    if ((flags & BDRV_REQ_ZERO_WRITE) && offset > old_length) {
> +        uint64_t zero_start = QEMU_ALIGN_UP(old_length, s->cluster_size);
> +        uint64_t zero_end = QEMU_ALIGN_UP(offset, s->cluster_size);

This rounds up beyond the new size...

> +
> +        /* Use zero clusters as much as we can */
> +        ret = qcow2_cluster_zeroize(bs, zero_start, zero_end - zero_start, 0);

and then requests that the extra be zeroed.  Does that always work, even 
when it results in pdrv_co_pwrite_zeroes beyond the end of s->data_file? 
  If so,

Reviewed-by: Eric Blake <eblake@redhat.com>

otherwise, you may have to treat the tail specially, the same way you 
treated an unaligned head.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


