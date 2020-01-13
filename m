Return-Path: <SRS0=PCRa=3C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46642C33CA9
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2020 15:31:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 110EF207FD
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2020 15:31:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dvzH6naE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 110EF207FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51910 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ir1gd-0006uC-6T
	for qemu-devel@archiver.kernel.org; Mon, 13 Jan 2020 10:31:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59653)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1ir1fi-0006OO-80
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 10:30:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1ir1fg-0008LV-ID
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 10:30:29 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:29276
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1ir1fg-0008KK-EN
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 10:30:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578929427;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/duRa5/vb9Lj/Vjc4zIyEAeScvgyjgK824vwpH02rQI=;
 b=dvzH6naEc8az6SzXs5arjwhp2kwAD2nYsIiiqP52W9JlOPPxzyS0pMPsjS/7Tt7G8lnKzJ
 +AQqNNNzb9I9T8AoPJu0g6CVnz/KjOuEOY1PM6CSvYeR4pLtQDDuEjgT680fhg1MjVDyiJ
 7rN8yFsxrZBZHyMCtLfIl0IM+tOfv68=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-182-aoXpHxnINHaSsGeDd5zm_Q-1; Mon, 13 Jan 2020 10:30:23 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 93ABE911BC;
 Mon, 13 Jan 2020 15:30:22 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-131.ams2.redhat.com
 [10.36.116.131])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5F3BD5C1B0;
 Mon, 13 Jan 2020 15:30:22 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id E5F731138600; Mon, 13 Jan 2020 16:30:20 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Zhimin Feng <fengzhimin1@huawei.com>
Subject: Re: [PATCH RFC 01/12] migration: Add multiRDMA capability support
References: <20200109045922.904-1-fengzhimin1@huawei.com>
 <20200109045922.904-2-fengzhimin1@huawei.com>
Date: Mon, 13 Jan 2020 16:30:20 +0100
In-Reply-To: <20200109045922.904-2-fengzhimin1@huawei.com> (Zhimin Feng's
 message of "Thu, 9 Jan 2020 12:59:11 +0800")
Message-ID: <875zhfxtkj.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: aoXpHxnINHaSsGeDd5zm_Q-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Cc: zhang.zhanghailiang@huawei.com, quintela@redhat.com, qemu-devel@nongnu.org,
 dgilbert@redhat.com, jemmy858585@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Zhimin Feng <fengzhimin1@huawei.com> writes:

> From: fengzhimin <fengzhimin1@huawei.com>
>
> Signed-off-by: fengzhimin <fengzhimin1@huawei.com>
> ---
[...]
> diff --git a/qapi/migration.json b/qapi/migration.json
> index b7348d0c8b..c995ffdc4c 100644
> --- a/qapi/migration.json
> +++ b/qapi/migration.json
> @@ -421,6 +421,8 @@
>  # @validate-uuid: Send the UUID of the source to allow the destination
>  #                 to ensure it is the same. (since 4.2)
>  #
> +# @multirdma: Use more than one channels for rdma migration. (since 4.2)
> +#
>  # Since: 1.2
>  ##
>  { 'enum': 'MigrationCapability',
> @@ -428,7 +430,7 @@
>             'compress', 'events', 'postcopy-ram', 'x-colo', 'release-ram'=
,
>             'block', 'return-path', 'pause-before-switchover', 'multifd',
>             'dirty-bitmaps', 'postcopy-blocktime', 'late-block-activate',
> -           'x-ignore-shared', 'validate-uuid' ] }
> +           'x-ignore-shared', 'validate-uuid', 'multirdma' ] }
> =20
>  ##
>  # @MigrationCapabilityStatus:

Spell it multi-rdma?


