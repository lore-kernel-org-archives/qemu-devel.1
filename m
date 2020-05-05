Return-Path: <SRS0=1jZz=6T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC99CC47254
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 20:05:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A777C20721
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 20:05:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hKVuaYX9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A777C20721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57900 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jW3ow-0007Uu-N6
	for qemu-devel@archiver.kernel.org; Tue, 05 May 2020 16:05:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41392)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jW3o2-0006cA-Sp
 for qemu-devel@nongnu.org; Tue, 05 May 2020 16:04:43 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:21404
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jW3o1-0008F8-QU
 for qemu-devel@nongnu.org; Tue, 05 May 2020 16:04:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588709078;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yRMZ7ahhe2ztHMPJplOIF8LhXTkhPsZ4Q7I32BQA+uU=;
 b=hKVuaYX9laj3jFOvZlOebJRPf27WcjOj1zWnSJI2CgS2M0kp3Dk8w1l2/95yOjR/Y1g6Y9
 J5eR8GIjCqvMBxR0ImsAbS6dGDiNw6bDmVCabEWsyQKXP0dQv9daTheqgeCO1s3iIPr59c
 qRrDyOmsAfKlLvQRSQu9aMAxUGeg1vI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-140-O0ver4pjPWu79p2aZdCAlg-1; Tue, 05 May 2020 16:04:35 -0400
X-MC-Unique: O0ver4pjPWu79p2aZdCAlg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BF7FF1895A28;
 Tue,  5 May 2020 20:04:33 +0000 (UTC)
Received: from [10.3.114.73] (ovpn-114-73.phx2.redhat.com [10.3.114.73])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 224785C1B2;
 Tue,  5 May 2020 20:04:32 +0000 (UTC)
Subject: Re: [PATCH v5 13/31] qcow2: Update get/set_l2_entry() and add
 get/set_l2_bitmap()
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
References: <cover.1588699789.git.berto@igalia.com>
 <30130e0f4662ea8ba705c5c54afc56bfb1ae70b6.1588699789.git.berto@igalia.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <3295e0e3-8b7b-3440-55d9-a8d9458e5e17@redhat.com>
Date: Tue, 5 May 2020 15:04:32 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <30130e0f4662ea8ba705c5c54afc56bfb1ae70b6.1588699789.git.berto@igalia.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/05 00:37:40
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
> Extended L2 entries are 128-bit wide: 64 bits for the entry itself and
> 64 bits for the subcluster allocation bitmap.
> 
> In order to support them correctly get/set_l2_entry() need to be
> updated so they take the entry width into account in order to
> calculate the correct offset.
> 
> This patch also adds the get/set_l2_bitmap() functions that are
> used to access the bitmaps. For convenience we allow calling
> get_l2_bitmap() on images without subclusters. In this case the
> returned value is always 0 and has no meaning.
> 
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> ---
>   block/qcow2.h | 21 +++++++++++++++++++++
>   1 file changed, 21 insertions(+)
> 

> +static inline void set_l2_bitmap(BDRVQcow2State *s, uint64_t *l2_slice,
> +                                 int idx, uint64_t bitmap)
> +{
> +    assert(has_subclusters(s));
> +    idx *= l2_entry_size(s) / sizeof(uint64_t);
> +    l2_slice[idx + 1] = cpu_to_be64(bitmap);
> +}

Unrelated to this patch, but I just thought of it:

What happens for an image whose size is not cluster-aligned?  Must the 
bits corresponding to subclusters not present in the final cluster 
always be zero, or are they instead ignored regardless of value?

But for this patch:

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


