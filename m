Return-Path: <SRS0=6hMH=ZM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A0E2C432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 19:27:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4526E2071F
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 19:27:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f8crrLle"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4526E2071F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33860 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXVdF-0002d0-Dj
	for qemu-devel@archiver.kernel.org; Wed, 20 Nov 2019 14:27:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46191)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1iXVcJ-00025q-Ho
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 14:26:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1iXVcH-0006Il-UT
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 14:26:18 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:49225
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1iXVcH-0006GY-OY
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 14:26:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574277976;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=m9G0QnWyJtlnaa4ciDPMU08KAUMzNK6Q2FYWrJjjmLA=;
 b=f8crrLleziEf/mTGr7DFBwa/jYdE92gs5hQOr3uBcq+RcB8NTJt7IlgDwQEGrmQIHL2LO3
 utcPYthH379kpuOUOtaUE6pnWO0roQxs268yaVOelHnjEQWG7xjarSO2zOFnjtTvf3O3jg
 jTqNDMJiQMyB6Who328I8EaldkxKezE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-288-lWtNNVGiNiuz5Rh3B0UlPQ-1; Wed, 20 Nov 2019 14:26:13 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 157C1DBA3;
 Wed, 20 Nov 2019 19:26:12 +0000 (UTC)
Received: from [10.3.116.221] (ovpn-116-221.phx2.redhat.com [10.3.116.221])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8A5B360BC0;
 Wed, 20 Nov 2019 19:26:11 +0000 (UTC)
Subject: Re: [PATCH 3/6] qapi: Generate command registration stuff into
 separate files
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20191120182551.23795-1-armbru@redhat.com>
 <20191120182551.23795-4-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <d9fc4c2a-61d0-43b9-e792-35f5f5d39798@redhat.com>
Date: Wed, 20 Nov 2019 13:26:10 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191120182551.23795-4-armbru@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: lWtNNVGiNiuz5Rh3B0UlPQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
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
Cc: mdroth@linux.vnet.ibm.com, kwolf@pond.sub.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/20/19 12:25 PM, Markus Armbruster wrote:
> Having to include qapi-commands.h just for qmp_init_marshal() is
> suboptimal.  Generate it into separate files.  This lets
> monitor/misc.c, qga/main.c, and the generated qapi-commands-FOO.h
> include less.
>=20
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---

> +++ b/docs/devel/qapi-code-gen.txt
> @@ -1493,6 +1493,10 @@ $(prefix)qapi-commands.c: Command marshal/dispatch=
 functions for each
>   $(prefix)qapi-commands.h: Function prototypes for the QMP commands
>                             specified in the schema
>  =20
> +$(prefix)qapi-init-commands.h - Command initialization prototype
> +
> +$(prefix)qapi-init-commands.h - Command initialization code

Looks like you meant s/h/c/


> +    #endif /* EXAMPLE_QAPI_INIT_COMMANDS_H */
> +    $ cat qapi-generated/example-qapi-init-commands.
> +[Uninteresting stuff omitted...]

missing a 'c'

> +++ b/Makefile

>  =20
> -QGALIB_GEN=3D$(addprefix qga/qapi-generated/, qga-qapi-types.h qga-qapi-=
visit.h qga-qapi-commands.h)
> +QGALIB_GEN=3D$(addprefix qga/qapi-generated/, qga-qapi-types.h qga-qapi-=
visit.h qga-qapi-commands.h qga-qapi-init-commands.h)

Worth using \ for line-wrapping?

With those addressed,
Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


