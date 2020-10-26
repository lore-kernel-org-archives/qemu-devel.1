Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21436C2D0A3
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 14:26:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 715F52075B
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 14:26:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GL5ACBTO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 715F52075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35122 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kX3SE-0000B1-Ka
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 10:26:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49314)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kX3RB-0007zf-DJ
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 10:25:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:50407)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kX3R9-00078r-MU
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 10:25:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603722326;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LYWoOMgxGsf+PYYcP411Dpl0wEkiafrSnIY+uwXUOSI=;
 b=GL5ACBTO/EzYQw3O0migc+gvPXcBiJZ/DJzMatERJ+yhHZy/VCKFZIYFriad1fl6cS5LWN
 jruVi9XObXrnVMbjQRZZ5ZQkzPQr1YPvBxSaVvG6ZEhz+fcdw/ES0AW5qaPMYgxNyLX2n1
 G3amJgH1IZmLgOw7xIV25nQbls54GsA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-98-etO65KdYPb2x_FQ8pe8tAQ-1; Mon, 26 Oct 2020 10:25:24 -0400
X-MC-Unique: etO65KdYPb2x_FQ8pe8tAQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8CE0B86ABDC;
 Mon, 26 Oct 2020 14:25:23 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-182.ams2.redhat.com
 [10.36.112.182])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 50B0510016DA;
 Mon, 26 Oct 2020 14:25:20 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id C8A47113865F; Mon, 26 Oct 2020 15:25:18 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH v5 02/12] qapi: Make QAPI_LIST_ADD() public
References: <20201023183652.478921-1-eblake@redhat.com>
 <20201023183652.478921-3-eblake@redhat.com>
Date: Mon, 26 Oct 2020 15:25:18 +0100
In-Reply-To: <20201023183652.478921-3-eblake@redhat.com> (Eric Blake's message
 of "Fri, 23 Oct 2020 13:36:42 -0500")
Message-ID: <87v9ex3vzl.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Received-SPF: pass client-ip=63.128.21.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/25 21:03:19
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com,
 Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-block@nongnu.org,
 rjones@redhat.com, qemu-devel@nongnu.org, stefanha@redhat.com,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Eric Blake <eblake@redhat.com> writes:

> We have a useful macro for inserting at the front of any
> QAPI-generated list; move it from block.c to qapi/util.h so more
> places can use it, including one earlier place in block.c.
>
> Suggested-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>  include/qapi/util.h |  8 ++++++++
>  block.c             | 15 +++------------
>  2 files changed, 11 insertions(+), 12 deletions(-)
>
> diff --git a/include/qapi/util.h b/include/qapi/util.h
> index 50201896c7a4..b6083055ce69 100644
> --- a/include/qapi/util.h
> +++ b/include/qapi/util.h
> @@ -30,4 +30,12 @@ int qapi_enum_parse(const QEnumLookup *lookup, const char *buf,
>
>  int parse_qapi_name(const char *name, bool complete);
>
> +/* For any GenericList @list, insert @element at the front. */
> +#define QAPI_LIST_ADD(list, element) do { \
> +    typeof(list) _tmp = g_new(typeof(*(list)), 1); \

g_new(typeof(*p), 1) is an rather roundabout way to say
g_malloc(sizeof(*p).  Yes, it returns typeof(p) instead of void *, but
the chance of this catching mistakes here rounds to zero.

Not this patch's problem.  Ignore me :)

> +    _tmp->value = (element); \
> +    _tmp->next = (list); \
> +    (list) = _tmp; \
> +} while (0)
> +
>  #endif
> diff --git a/block.c b/block.c
> index 430edf79bb10..45bd79299611 100644
> --- a/block.c
> +++ b/block.c
> @@ -39,6 +39,7 @@
>  #include "qapi/qmp/qstring.h"
>  #include "qapi/qobject-output-visitor.h"
>  #include "qapi/qapi-visit-block-core.h"
> +#include "qapi/util.h"
>  #include "sysemu/block-backend.h"
>  #include "sysemu/sysemu.h"
>  #include "qemu/notify.h"
> @@ -5211,7 +5212,7 @@ BlockDriverState *bdrv_find_node(const char *node_name)
>  BlockDeviceInfoList *bdrv_named_nodes_list(bool flat,
>                                             Error **errp)
>  {
> -    BlockDeviceInfoList *list, *entry;
> +    BlockDeviceInfoList *list;
>      BlockDriverState *bs;
>
>      list = NULL;
> @@ -5221,22 +5222,12 @@ BlockDeviceInfoList *bdrv_named_nodes_list(bool flat,
>              qapi_free_BlockDeviceInfoList(list);
>              return NULL;
>          }
> -        entry = g_malloc0(sizeof(*entry));
> -        entry->value = info;
> -        entry->next = list;
> -        list = entry;
> +        QAPI_LIST_ADD(list, info);
>      }
>
>      return list;
>  }

PATCH 12 has more.  I wonder whether PATCH 12 should be squashed into
this one.  You decide.

>
> -#define QAPI_LIST_ADD(list, element) do { \
> -    typeof(list) _tmp = g_new(typeof(*(list)), 1); \
> -    _tmp->value = (element); \
> -    _tmp->next = (list); \
> -    (list) = _tmp; \
> -} while (0)
> -
>  typedef struct XDbgBlockGraphConstructor {
>      XDbgBlockGraph *graph;
>      GHashTable *graph_nodes;

Reviewed-by: Markus Armbruster <armbru@redhat.com>


