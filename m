Return-Path: <SRS0=QiA4=7D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 929FFC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 21:06:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5AACE207F9
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 21:06:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MyPhxBFr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5AACE207F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53898 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbsOP-00051z-Hj
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 17:06:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49870)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jbsNZ-0003vf-OD
 for qemu-devel@nongnu.org; Thu, 21 May 2020 17:05:25 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:27877
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jbsNY-0004W2-Cc
 for qemu-devel@nongnu.org; Thu, 21 May 2020 17:05:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590095122;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=L5lV/qtMx5B/2dhFGjICA6mNp9DrYXoZk92TJ1IFlgI=;
 b=MyPhxBFr4bgjc5xGeu2pkA69jVZcu3GNYv/cKAdrvxhFye+F11E06x0Mp5VQwL/PDC2WYK
 xPdpnm2ZXQA8qE8SMEljloqVuoAfJtqgvPLknQ8PEBziCx+2RZwgM+hPXv5ggQXjvsktYh
 Laub57ucSjNOoIbKkAM7xsp0DxahqIg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-306-EvxG1id3Of2-Whvc5qYptw-1; Thu, 21 May 2020 17:05:20 -0400
X-MC-Unique: EvxG1id3Of2-Whvc5qYptw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E029A107ACCD;
 Thu, 21 May 2020 21:05:18 +0000 (UTC)
Received: from [10.3.112.88] (ovpn-112-88.phx2.redhat.com [10.3.112.88])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9FF955D777;
 Thu, 21 May 2020 21:05:14 +0000 (UTC)
Subject: Re: [PATCH v3 7/7] migration/block-dirty-bitmap: forbid migration by
 generated node-name
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org
References: <20200515124024.3491-1-vsementsov@virtuozzo.com>
 <20200515124024.3491-8-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <a15e0061-9f27-225b-427c-77fb088d39b9@redhat.com>
Date: Thu, 21 May 2020 16:05:14 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200515124024.3491-8-vsementsov@virtuozzo.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=eblake@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/21 14:32:18
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
Cc: kwolf@redhat.com, fam@euphon.net, pavel.dovgaluk@ispras.ru,
 quintela@redhat.com, qemu-devel@nongnu.org, dgilbert@redhat.com,
 mreitz@redhat.com, Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>,
 stefanha@redhat.com, den@openvz.org, pbonzini@redhat.com, jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/15/20 7:40 AM, Vladimir Sementsov-Ogievskiy wrote:
> It actually never worked with libvirt, as auto-generated names are
> different on source and destination.
> 
> It's unsafe and useless to migrate by auto-generated node-names, so
> let's forbid it.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> Reviewed-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
> ---
>   migration/block-dirty-bitmap.c | 7 +++++++
>   1 file changed, 7 insertions(+)
> 

Reviewed-by: Eric Blake <eblake@redhat.com>

> diff --git a/migration/block-dirty-bitmap.c b/migration/block-dirty-bitmap.c
> index e0e081ce60..f5744c35e6 100644
> --- a/migration/block-dirty-bitmap.c
> +++ b/migration/block-dirty-bitmap.c
> @@ -285,6 +285,13 @@ static int add_bitmaps_to_list(BlockDriverState *bs, const char *bs_name)
>           return -1;
>       }
>   
> +    if (bs_name[0] == '#') {
> +        error_report("Found bitmap '%s' in a node with auto-generated "
> +                     "name: %s. It can't be migrated",

Maybe compress to:

"Bitmap '%s' in auto-generated node '%s' can't be migrated"

> +                     bdrv_dirty_bitmap_name(bitmap), bs_name);
> +        return -1;
> +    }
> +
>       FOR_EACH_DIRTY_BITMAP(bs, bitmap) {
>           if (!bdrv_dirty_bitmap_name(bitmap)) {
>               continue;
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


