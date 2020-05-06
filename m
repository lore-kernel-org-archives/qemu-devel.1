Return-Path: <SRS0=CRBd=6U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9029C28CBC
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 17:59:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7553320735
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 17:59:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H61IAXKl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7553320735
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42296 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWOKU-0004pv-Jb
	for qemu-devel@archiver.kernel.org; Wed, 06 May 2020 13:59:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52388)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jWOJG-0003sI-0j
 for qemu-devel@nongnu.org; Wed, 06 May 2020 13:58:18 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:57737
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jWOJB-0007jr-CZ
 for qemu-devel@nongnu.org; Wed, 06 May 2020 13:58:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588787892;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hSTOOIalaWGnZ+dbJrtVhjQRnJMahqdaWubn8fu9D6M=;
 b=H61IAXKlbrNyXuMFvT5XC+CMcUc/XA1QQj7G4C3j5y9E/E22QY0sKTIvOi60dNlLAn9Tdm
 RxQFgcP761vBiKYLI0kfLDezjaCyaKE12iCjC+Jg394akCCcSp0Z5ZQaGXQiyIBXRrRsje
 JiUhwd2lm7U50rXnoZi5Q3aJjdliGok=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-174-RtVkCKzxMJeXjd4g0r-jwg-1; Wed, 06 May 2020 13:58:11 -0400
X-MC-Unique: RtVkCKzxMJeXjd4g0r-jwg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CC35C100A8EB;
 Wed,  6 May 2020 17:58:08 +0000 (UTC)
Received: from [10.3.114.73] (ovpn-114-73.phx2.redhat.com [10.3.114.73])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 579035C1D4;
 Wed,  6 May 2020 17:58:08 +0000 (UTC)
Subject: Re: [PATCH v5 23/31] qcow2: Add subcluster support to
 check_refcounts_l2()
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
References: <cover.1588699789.git.berto@igalia.com>
 <659488f9bf4bf0291191f3d426a5567698924084.1588699789.git.berto@igalia.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <9f0bf382-b8e2-78eb-411b-02ebbd0c22be@redhat.com>
Date: Wed, 6 May 2020 12:58:07 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <659488f9bf4bf0291191f3d426a5567698924084.1588699789.git.berto@igalia.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=eblake@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/06 04:02:22
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/5/20 12:38 PM, Alberto Garcia wrote:
> Setting the QCOW_OFLAG_ZERO bit of the L2 entry is forbidden if an
> image has subclusters. Instead, the individual 'all zeroes' bits must
> be used.

Should we s/is forbidden/is ignored/ based on your spec changes?

But the patch itself is right.
Reviewed-by: Eric Blake <eblake@redhat.com>

> 
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> Reviewed-by: Max Reitz <mreitz@redhat.com>
> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>   block/qcow2-refcount.c | 9 +++++++--
>   1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/block/qcow2-refcount.c b/block/qcow2-refcount.c
> index dfdcdd3c25..9bb161481e 100644
> --- a/block/qcow2-refcount.c
> +++ b/block/qcow2-refcount.c
> @@ -1686,8 +1686,13 @@ static int check_refcounts_l2(BlockDriverState *bs, BdrvCheckResult *res,
>                           int ign = active ? QCOW2_OL_ACTIVE_L2 :
>                                              QCOW2_OL_INACTIVE_L2;
>   
> -                        l2_entry = QCOW_OFLAG_ZERO;
> -                        set_l2_entry(s, l2_table, i, l2_entry);
> +                        if (has_subclusters(s)) {
> +                            set_l2_entry(s, l2_table, i, 0);
> +                            set_l2_bitmap(s, l2_table, i,
> +                                          QCOW_L2_BITMAP_ALL_ZEROES);
> +                        } else {
> +                            set_l2_entry(s, l2_table, i, QCOW_OFLAG_ZERO);
> +                        }
>                           ret = qcow2_pre_write_overlap_check(bs, ign,
>                                   l2e_offset, l2_entry_size(s), false);
>                           if (ret < 0) {
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


