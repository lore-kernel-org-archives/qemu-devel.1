Return-Path: <SRS0=1jZz=6T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05037C47254
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 19:44:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C44AE2068E
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 19:44:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Dt4iRgtt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C44AE2068E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40680 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jW3U6-0005aa-TO
	for qemu-devel@archiver.kernel.org; Tue, 05 May 2020 15:44:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37708)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jW3SK-0004A6-Rv
 for qemu-devel@nongnu.org; Tue, 05 May 2020 15:42:16 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:37845
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jW3SJ-0003aS-Il
 for qemu-devel@nongnu.org; Tue, 05 May 2020 15:42:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588707733;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=C8f9K7F+eJHJpQuOINMtg9A20kuepug//bPpjFpfnnU=;
 b=Dt4iRgttffKJwcq5WVwfKib2RccWaoX29ePLX533Uy5RDfPn1QzZT55X8DLUwN4preDO4O
 8OXY/iLkzhnUSn84NVrDvBBvB6P7G61Pp6tOPA7FArECaVSc+XXWXYBGZgj2km8JtvdGzT
 sufeEwnPXM3qjcNFIyKwzJxzGVjixWY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-318-eucTj2nMNvGHRTkg1E2HOw-1; Tue, 05 May 2020 15:42:11 -0400
X-MC-Unique: eucTj2nMNvGHRTkg1E2HOw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CE65318FF671;
 Tue,  5 May 2020 19:42:09 +0000 (UTC)
Received: from [10.3.114.73] (ovpn-114-73.phx2.redhat.com [10.3.114.73])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 329015D9C5;
 Tue,  5 May 2020 19:42:09 +0000 (UTC)
Subject: Re: [PATCH v5 11/31] qcow2: Add offset_into_subcluster() and
 size_to_subclusters()
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
References: <cover.1588699789.git.berto@igalia.com>
 <bf2f5e0e41d5c51cde60cd457fd6d69d0f6ab030.1588699789.git.berto@igalia.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <1697e9b7-c895-4f92-bb69-d43ff9bd4c44@redhat.com>
Date: Tue, 5 May 2020 14:42:08 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <bf2f5e0e41d5c51cde60cd457fd6d69d0f6ab030.1588699789.git.berto@igalia.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
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
> Like offset_into_cluster() and size_to_clusters(), but for
> subclusters.
> 
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> ---
>   block/qcow2.h | 10 ++++++++++
>   1 file changed, 10 insertions(+)
> 
> diff --git a/block/qcow2.h b/block/qcow2.h
> index e68febb15b..8b1ed1cbcf 100644
> --- a/block/qcow2.h
> +++ b/block/qcow2.h
> @@ -537,11 +537,21 @@ static inline int64_t offset_into_cluster(BDRVQcow2State *s, int64_t offset)
>       return offset & (s->cluster_size - 1);
>   }
>   
> +static inline int64_t offset_into_subcluster(BDRVQcow2State *s, int64_t offset)
> +{
> +    return offset & (s->subcluster_size - 1);
> +}
> +
>   static inline uint64_t size_to_clusters(BDRVQcow2State *s, uint64_t size)
>   {
>       return (size + (s->cluster_size - 1)) >> s->cluster_bits;
>   }

Pre-existing, but this could use DIV_ROUND_UP.

>   
> +static inline uint64_t size_to_subclusters(BDRVQcow2State *s, uint64_t size)
> +{
> +    return (size + (s->subcluster_size - 1)) >> s->subcluster_bits;
> +}

at which point, your addition could be:

return DIV_ROUND_UP(size, s->subcluster_size);

Either way,

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


