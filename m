Return-Path: <SRS0=f7ls=75=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D354C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 21:12:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 527A82085B
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 21:12:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TRl/flKW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 527A82085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47442 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlIsR-0001Hd-KD
	for qemu-devel@archiver.kernel.org; Tue, 16 Jun 2020 17:12:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36042)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jlIrf-0000J0-H8
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 17:11:27 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:40858
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jlIrd-0005Oj-Ck
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 17:11:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592341884;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yNJp7LJrJUTy/mqZDBuwitpEMRxgrfe1gjZUGLSY+QA=;
 b=TRl/flKW+kiTHF8WsAiaJKUAnV1rfpdo212A1V2dHP4IrrHTp6qXz9e9By+0/QPo1OBXgs
 39yCpFokO+z9Ntsn25AC19ax0tifypOmlBaNq7YVAsAfq3MQvPAPN9Z+koaw5824Wm4gmZ
 IQTF275eMAD8ag6ff+Br/N9gUHm5IXg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-443-enB5cgpiOziNW7-u_rvrEw-1; Tue, 16 Jun 2020 17:11:17 -0400
X-MC-Unique: enB5cgpiOziNW7-u_rvrEw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DDD0610AB64B;
 Tue, 16 Jun 2020 21:11:15 +0000 (UTC)
Received: from [10.3.112.27] (ovpn-112-27.phx2.redhat.com [10.3.112.27])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 818AB1944D;
 Tue, 16 Jun 2020 21:11:11 +0000 (UTC)
Subject: Re: [PATCH 4/5] block, migration: add bdrv_flush_vmstate helper
To: "Denis V. Lunev" <den@openvz.org>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org
References: <20200616162035.29857-1-den@openvz.org>
 <20200616162035.29857-5-den@openvz.org>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <091af0f5-c8e9-8749-c329-287fb100f2b6@redhat.com>
Date: Tue, 16 Jun 2020 16:11:11 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200616162035.29857-5-den@openvz.org>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/16 02:45:57
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Juan Quintela <quintela@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Denis Plotnikov <dplotnikov@virtuozzo.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/16/20 11:20 AM, Denis V. Lunev wrote:
> Right now bdrv_fclose() is just calling bdrv_flush().
> 
> The problem is that migration code is working inefficently from black

inefficiently, block

> layer terms and are frequently called for very small pieces of not
> properly aligned data. Block layer is capable to work this way, but

s/not properly aligned/unaligned/

> this is very slow.
> 
> This patch is a preparation for the introduction of the intermediate
> buffer at block driver state. It would be beneficial to separate
> conventional bdrv_flush() from closing QEMU file from migration code.
> 
> The patch also forces bdrv_flush_vmstate() operation inside
> synchronous blk_save_vmstate() operation. This helper is used from
> qemu-io only.
> 

> +++ b/block/block-backend.c
> @@ -2177,16 +2177,20 @@ int blk_truncate(BlockBackend *blk, int64_t offset, bool exact,
>   int blk_save_vmstate(BlockBackend *blk, const uint8_t *buf,
>                        int64_t pos, int size)
>   {
> -    int ret;
> +    int ret, ret2;
>   
>       if (!blk_is_available(blk)) {
>           return -ENOMEDIUM;
>       }
>   
>       ret = bdrv_save_vmstate(blk_bs(blk), buf, pos, size);
> +    ret2 = bdrv_flush_vmstate(blk_bs(blk));

Do you really want to be attempting bdrv_flush_vmstate() even after 
bdrv_save_vmstate() failed?  Better might be...

>       if (ret < 0) {
>           return ret;
>       }

...attempting it here, at which point it looks like the only reason you 
need ret2 is to preserve ret long enough...

> +    if (ret2 < 0) {
> +        return ret2;
> +    }
>   
>       if (ret == size && !blk->enable_write_cache) {

...for this check.  But a quick look at bdrv_save_vmstate() says this 
check is dead: the function can only return negative error or exactly 
size, and we already filtered out negative error above.


-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


