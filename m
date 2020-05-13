Return-Path: <SRS0=Qw6D=63=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CDEEC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 16:13:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 70149204EC
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 16:13:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GclDdcwP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70149204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60954 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYu0B-0008Js-A4
	for qemu-devel@archiver.kernel.org; Wed, 13 May 2020 12:12:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44842)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jYtyb-0005xR-Ly
 for qemu-devel@nongnu.org; Wed, 13 May 2020 12:11:21 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:20469
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jYtyZ-0004oE-Gc
 for qemu-devel@nongnu.org; Wed, 13 May 2020 12:11:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589386277;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=x3ta2Cc+RLR7oyKiUv06YfgE2Yyg5qIhsWsI+b+KJ8Q=;
 b=GclDdcwP/nK1thvNGog0sMgyFSNwXTBRlf+5XBSxwCnSC+KQA4hc7ioW/jdFKiXbj3Y58Y
 w7FU7pybeBI5KauSSeENu/RugJFlLG+1Mazjq7uljNu2JD/qpFl5eVemqcS2bsd2aMB7HV
 n4868cUGpnUZbB4UcmA5dKemdzBLneQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-478--Xci6wEjMaCB3dPjuSOKvQ-1; Wed, 13 May 2020 12:11:14 -0400
X-MC-Unique: -Xci6wEjMaCB3dPjuSOKvQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E2EC3461;
 Wed, 13 May 2020 16:11:13 +0000 (UTC)
Received: from [10.3.116.145] (ovpn-116-145.phx2.redhat.com [10.3.116.145])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4CC3E605FC;
 Wed, 13 May 2020 16:11:13 +0000 (UTC)
Subject: Re: [RFC v2] migration: Add migrate-set-bitmap-node-mapping
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
References: <20200513145610.1484567-1-mreitz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <0270abbd-3fa7-dcca-bbf5-80dd0fad1733@redhat.com>
Date: Wed, 13 May 2020 11:11:12 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200513145610.1484567-1-mreitz@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=eblake@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/13 01:56:38
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
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Juan Quintela <quintela@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 qemu-devel@nongnu.org, Peter Krempa <pkrempa@redhat.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/13/20 9:56 AM, Max Reitz wrote:
> This command allows mapping block node names to aliases for the purpose
> of block dirty bitmap migration.
> 
> This way, management tools can use different node names on the source
> and destination and pass the mapping of how bitmaps are to be
> transferred to qemu (on the source, the destination, or even both with
> arbitrary aliases in the migration stream).
> 
> Suggested-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---

> @@ -713,6 +731,44 @@ static bool dirty_bitmap_has_postcopy(void *opaque)
>       return true;
>   }
>   
> +void qmp_migrate_set_bitmap_node_mapping(MigrationBlockNodeMappingList *mapping,
> +                                         Error **errp)
> +{
> +    QDict *in_mapping = qdict_new();
> +    QDict *out_mapping = qdict_new();
> +
> +    for (; mapping; mapping = mapping->next) {
> +        MigrationBlockNodeMapping *entry = mapping->value;
> +
> +        if (qdict_haskey(out_mapping, entry->node_name)) {
> +            error_setg(errp, "Cannot map node name '%s' twice",
> +                       entry->node_name);
> +            goto fail;
> +        }

Can we call this command more than once?  Is it cumulative (call it once 
to set mapping for "a", second time to also set mapping for "b"), or 
should it reset (second call wipes out all mappings from first call, any 
mappings that must exist must be passed in the final call)?

The idea makes sense, and the interface seems usable.  It's nice that 
either source, destination, or both sides of migration can use it (which 
helps in upgrade vs. downgrade scenarios).

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


