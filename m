Return-Path: <SRS0=PCRa=3C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4E65C33CA9
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2020 15:35:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F616207FD
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2020 15:35:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YKMAOedD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F616207FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51950 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ir1ko-0001pQ-Lz
	for qemu-devel@archiver.kernel.org; Mon, 13 Jan 2020 10:35:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60879)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1ir1jw-0000o1-R3
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 10:34:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1ir1jv-0005Ur-EY
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 10:34:52 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:52571
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1ir1jv-0005Tt-B0
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 10:34:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578929690;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0CdWt5hd1oCnf6LcNIRVU2ZxFmyC+UbXE6ZzEXrRlwQ=;
 b=YKMAOedDdaBz9ptVgNxIplxs9BPSRZJZtUTpjOx0yJYNqse1Dhh2dy8NgOZFoS7BADwE4h
 D/MJuYhbBISCwIOUsvKszUNLKvZS5IyCswgLA8b4DbxvQjl/PtCbqdsEFdBuStUn35woQ/
 a8vRDWjFaTiWJcrislbaWfwnAXu+ZUg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-427--9bl688PM-GAaih9yzFasg-1; Mon, 13 Jan 2020 10:34:49 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AF26F18C43C0;
 Mon, 13 Jan 2020 15:34:47 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-131.ams2.redhat.com
 [10.36.116.131])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7C6E687EEC;
 Mon, 13 Jan 2020 15:34:47 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 139881138600; Mon, 13 Jan 2020 16:34:46 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Zhimin Feng <fengzhimin1@huawei.com>
Subject: Re: [PATCH RFC 03/12] migration: Create the multi-rdma-channels
 parameter
References: <20200109045922.904-1-fengzhimin1@huawei.com>
 <20200109045922.904-4-fengzhimin1@huawei.com>
Date: Mon, 13 Jan 2020 16:34:46 +0100
In-Reply-To: <20200109045922.904-4-fengzhimin1@huawei.com> (Zhimin Feng's
 message of "Thu, 9 Jan 2020 12:59:13 +0800")
Message-ID: <87v9pfwesp.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: -9bl688PM-GAaih9yzFasg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
> Indicates the number of RDMA threads that we would create.
> By default we create 2 threads for RDMA migration.
>
> Signed-off-by: fengzhimin <fengzhimin1@huawei.com>
[...]
> diff --git a/qapi/migration.json b/qapi/migration.json
> index c995ffdc4c..ab79bf0600 100644
> --- a/qapi/migration.json
> +++ b/qapi/migration.json
> @@ -588,6 +588,10 @@
>  # @max-cpu-throttle: maximum cpu throttle percentage.
>  #                    Defaults to 99. (Since 3.1)
>  #
> +# @multi-rdma-channels: Number of channels used to migrate data in
> +#                       parallel. This is the same number that the

same number as

> +#                       number of multiRDMA used for migration.  The

Pardon my ignorance: what's "the number of multiRDMA used for
migration"?

> +#                       default value is 2 (since 4.2)

(since 5.0)

>  # Since: 2.4
>  ##
>  { 'enum': 'MigrationParameter',
> @@ -600,7 +604,8 @@
>             'downtime-limit', 'x-checkpoint-delay', 'block-incremental',
>             'multifd-channels',
>             'xbzrle-cache-size', 'max-postcopy-bandwidth',
> -           'max-cpu-throttle' ] }
> +           'max-cpu-throttle',
> +           'multi-rdma-channels'] }
> =20
>  ##
>  # @MigrateSetParameters:
> @@ -690,6 +695,10 @@
>  # @max-cpu-throttle: maximum cpu throttle percentage.
>  #                    The default value is 99. (Since 3.1)
>  #
> +# @multi-rdma-channels: Number of channels used to migrate data in
> +#                       parallel. This is the same number that the
> +#                       number of multiRDMA used for migration.  The
> +#                       default value is 2 (since 4.2)

See above.

>  # Since: 2.4
>  ##
>  # TODO either fuse back into MigrationParameters, or make
> @@ -715,7 +724,8 @@
>              '*multifd-channels': 'int',
>              '*xbzrle-cache-size': 'size',
>              '*max-postcopy-bandwidth': 'size',
> -=09    '*max-cpu-throttle': 'int' } }
> +     =09    '*max-cpu-throttle': 'int',

Please use spaces instead of tab.

> +            '*multi-rdma-channels': 'int'} }
> =20
>  ##
>  # @migrate-set-parameters:
> @@ -825,6 +835,10 @@
>  #                    Defaults to 99.
>  #                     (Since 3.1)
>  #
> +# @multi-rdma-channels: Number of channels used to migrate data in
> +#                       parallel. This is the same number that the
> +#                       number of multiRDMA used for migration.  The
> +#                       default value is 2 (since 4.2)
>  # Since: 2.4

See above.

>  ##
>  { 'struct': 'MigrationParameters',
> @@ -847,8 +861,9 @@
>              '*block-incremental': 'bool' ,
>              '*multifd-channels': 'uint8',
>              '*xbzrle-cache-size': 'size',
> -=09    '*max-postcopy-bandwidth': 'size',
> -            '*max-cpu-throttle':'uint8'} }
> +     =09    '*max-postcopy-bandwidth': 'size',
> +            '*max-cpu-throttle':'uint8',
> +            '*multi-rdma-channels':'uint8'} }
> =20
>  ##
>  # @query-migrate-parameters:

Please use spaces instead of tab.


