Return-Path: <SRS0=muh1=7E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3BF5C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 21:34:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 56E3F20723
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 21:34:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KIK1pHvh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56E3F20723
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39124 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jcFJB-0004D7-EQ
	for qemu-devel@archiver.kernel.org; Fri, 22 May 2020 17:34:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43356)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jcFI8-0003Rc-GI
 for qemu-devel@nongnu.org; Fri, 22 May 2020 17:33:21 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:52901
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jcFI4-0008Ul-39
 for qemu-devel@nongnu.org; Fri, 22 May 2020 17:33:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590183193;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rNmW1dtOFZFiL12rM2ng33/5ZSrlUM4H4uxn+6m12vA=;
 b=KIK1pHvhnOKVnHEleKO7MNcYyURn6pfVVnmOaKqfteepZlwyM68uFb0UZLV3YbiJBKFSV5
 K8kLYN/BJlA5k3LiBpWEd5FkdS9m/WWsRWKqmZ9lG8dydrXCbtbur1blOAWqRiG9X+i1al
 xDRqoHWQSu46kw6m9jeFajA9q8xFTos=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-345-7Ka_OUrUND-rmE_IoSEZFA-1; Fri, 22 May 2020 17:33:07 -0400
X-MC-Unique: 7Ka_OUrUND-rmE_IoSEZFA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 082531005512;
 Fri, 22 May 2020 21:33:06 +0000 (UTC)
Received: from [10.3.112.88] (ovpn-112-88.phx2.redhat.com [10.3.112.88])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 79A2E5D788;
 Fri, 22 May 2020 21:33:01 +0000 (UTC)
Subject: Re: [PATCH v3 1/3] block/io: refactor coroutine wrappers
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org
References: <20200522161950.2839-1-vsementsov@virtuozzo.com>
 <20200522161950.2839-2-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <d3e7dbc9-ba3b-965d-726b-8a99007a8e08@redhat.com>
Date: Fri, 22 May 2020 16:33:00 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200522161950.2839-2-vsementsov@virtuozzo.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/22 17:33:13
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: kwolf@redhat.com, fam@euphon.net, ehabkost@redhat.com,
 qemu-devel@nongnu.org, mreitz@redhat.com, stefanha@redhat.com,
 crosa@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/22/20 11:19 AM, Vladimir Sementsov-Ogievskiy wrote:
> Most of coroutine wrappers already follow this notation:

s/of/of our/
s/notation/convention/

> 
> We have coroutine_fn bdrv_co_<something>(<normal argument list>), which
> is the core functions, and wrapper, which does polling loope is called
> bdrv_<something>(<same argument list>).

We have 'coroutine_fn bdrv_co_<something>(<normal argument list>)' as 
the core function, and a wrapper 'bdrv_<something>(<same argument 
list>)' which does a polling loop.

> 
> The only outsiders are bdrv_prwv_co and bdrv_common_block_status_above

s/are/are the/

> wrappers. Let's refactor the to behave as the others, it simplifies

s/the/them/

> further conversion of coroutine wrappers.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>   block/io.c | 61 +++++++++++++++++++++++++++++-------------------------
>   1 file changed, 33 insertions(+), 28 deletions(-)
> 
> diff --git a/block/io.c b/block/io.c
> index 121ce17a49..bd00a70b47 100644
> --- a/block/io.c
> +++ b/block/io.c
> @@ -900,28 +900,32 @@ typedef struct RwCo {
>       BdrvRequestFlags flags;
>   } RwCo;
>   
> +static int coroutine_fn bdrv_co_prwv(BdrvChild *child, int64_t offset,
> +                                     QEMUIOVector *qiov, bool is_write,
> +                                     BdrvRequestFlags flags)
> +{
> +    if (is_write) {
> +        return bdrv_co_pwritev(child, offset, qiov->size, qiov, flags);
> +    } else {
> +        return bdrv_co_preadv(child, offset, qiov->size, qiov, flags);
> +    }
> +}
> +

If we're trying to avoid needless indirection, wouldn't it be simpler to 
quit trying to slam reads and writes through a single prwv function that 
then has to split back out, and instead make two separate coroutine 
wrappers, one for just reads, and the other for just writes, without 
having to mess with a 'bool is_write' parameter?

>   static void coroutine_fn bdrv_rw_co_entry(void *opaque)
>   {

That is, should we have bdrv_co_preadv_entry and bdrv_co_pwritev_entry 
instead of just one bdrv_rw_co_entry?

At any rate, the renames done here are mechanical enough that if we make 
further changes, it could be a separate commit.

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


