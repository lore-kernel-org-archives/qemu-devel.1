Return-Path: <SRS0=hbhd=3T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26BB3C33C9E
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 07:55:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D3A4020702
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 07:55:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PVixmbkF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3A4020702
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56918 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ix4fF-00019q-Ty
	for qemu-devel@archiver.kernel.org; Thu, 30 Jan 2020 02:55:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48918)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1ix4eb-0000it-E3
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 02:54:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1ix4eY-0001Pi-WD
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 02:54:20 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:28641
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1ix4eY-0001NP-Lw
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 02:54:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580370857;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rGQ69w+Xq2LY83gCIPAfICLdBPRKu4brB7rtymNx1iU=;
 b=PVixmbkFkJA/nO5eaooGRKuoZ98+xVPFemHFiZGb51y2UaAZ22NvIuYssAjvAUv1TgPswg
 nJU90W5fNuXDc7/A2PUb6BL9It9+81xLk5zzgEUYfBym28UhnpzHcPPmQw7XqZOGA6llnA
 l1yGnEziavZonnPovznZy7oSRiTFvUA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-312-ESc6vqtNMl2fjhoKxvCkUg-1; Thu, 30 Jan 2020 02:54:11 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EA60D107ACC4
 for <qemu-devel@nongnu.org>; Thu, 30 Jan 2020 07:54:10 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-131.ams2.redhat.com
 [10.36.116.131])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id AD88C60BE0;
 Thu, 30 Jan 2020 07:54:10 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 26EE91138404; Thu, 30 Jan 2020 08:54:09 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Juan Quintela <quintela@redhat.com>
Subject: Re: [PATCH v5 1/8] multifd: Add multifd-method parameter
References: <20200129115655.10414-1-quintela@redhat.com>
 <20200129115655.10414-2-quintela@redhat.com>
Date: Thu, 30 Jan 2020 08:54:09 +0100
In-Reply-To: <20200129115655.10414-2-quintela@redhat.com> (Juan Quintela's
 message of "Wed, 29 Jan 2020 12:56:48 +0100")
Message-ID: <87lfppxtum.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: ESc6vqtNMl2fjhoKxvCkUg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 "Daniel P. =?utf-8?Q?Berrang=C3=A9?=" <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 qemu-devel@nongnu.org, "Dr. David
 Alan Gilbert" <dgilbert@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Juan Quintela <quintela@redhat.com> writes:

> This will store the compression method to use.  We start with none.
>
> Signed-off-by: Juan Quintela <quintela@redhat.com>
> Reviewed-by: Markus Armbruster <armbru@redhat.com>

I don't remember giving my R-by.  I gave my Acked-by for
[PATCH v2 06/10] migration: Add multifd-compress parameter
Message-ID: <87d0cku5hq.fsf@dusky.pond.sub.org>
https://lists.nongnu.org/archive/html/qemu-devel/2019-12/msg04153.html

If I did give my R-by for a later revision, let me know.

One small suggestion below.

> Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
[...]
> diff --git a/qapi/migration.json b/qapi/migration.json
> index b7348d0c8b..96a126751c 100644
> --- a/qapi/migration.json
> +++ b/qapi/migration.json
> @@ -488,6 +488,19 @@
>  ##
>  { 'command': 'query-migrate-capabilities', 'returns':   ['MigrationCapab=
ilityStatus']}
> =20
> +##
> +# @MultiFDMethod:
> +#
> +# An enumeration of multifd compression.

Suggest "compression methods."

> +#
> +# @none: no compression.
> +#
> +# Since: 5.0
> +#
> +##
> +{ 'enum': 'MultiFDMethod',
> +  'data': [ 'none' ] }
> +
>  ##
>  # @MigrationParameter:
>  #
> @@ -586,6 +599,9 @@
>  # @max-cpu-throttle: maximum cpu throttle percentage.
>  #                    Defaults to 99. (Since 3.1)
>  #
> +# @multifd-method: Which compression method to use.
> +#                  Defaults to none. (Since 5.0)
> +#
>  # Since: 2.4
>  ##
>  { 'enum': 'MigrationParameter',
> @@ -598,7 +614,7 @@
>             'downtime-limit', 'x-checkpoint-delay', 'block-incremental',
>             'multifd-channels',
>             'xbzrle-cache-size', 'max-postcopy-bandwidth',
> -           'max-cpu-throttle' ] }
> +           'max-cpu-throttle', 'multifd-method' ] }
> =20
>  ##
>  # @MigrateSetParameters:
> @@ -688,6 +704,9 @@
>  # @max-cpu-throttle: maximum cpu throttle percentage.
>  #                    The default value is 99. (Since 3.1)
>  #
> +# @multifd-method: Which compression method to use.
> +#                  Defaults to none. (Since 5.0)
> +#
>  # Since: 2.4
>  ##
>  # TODO either fuse back into MigrationParameters, or make
> @@ -713,7 +732,8 @@
>              '*multifd-channels': 'int',
>              '*xbzrle-cache-size': 'size',
>              '*max-postcopy-bandwidth': 'size',
> -=09    '*max-cpu-throttle': 'int' } }
> +            '*max-cpu-throttle': 'int',
> +            '*multifd-method': 'MultiFDMethod' } }
> =20
>  ##
>  # @migrate-set-parameters:
> @@ -823,6 +843,9 @@
>  #                    Defaults to 99.
>  #                     (Since 3.1)
>  #
> +# @multifd-method: Which compression method to use.
> +#                  Defaults to none. (Since 5.0)
> +#
>  # Since: 2.4
>  ##
>  { 'struct': 'MigrationParameters',
> @@ -846,7 +869,8 @@
>              '*multifd-channels': 'uint8',
>              '*xbzrle-cache-size': 'size',
>  =09    '*max-postcopy-bandwidth': 'size',
> -            '*max-cpu-throttle':'uint8'} }
> +            '*max-cpu-throttle': 'uint8',
> +            '*multifd-method': 'MultiFDMethod' } }
> =20
>  ##
>  # @query-migrate-parameters:
[...]


