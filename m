Return-Path: <SRS0=xKpV=2I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF3EEC43603
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 10:41:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E21824650
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 10:41:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F0YO2AB3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E21824650
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52294 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihWlk-0002bv-Jl
	for qemu-devel@archiver.kernel.org; Wed, 18 Dec 2019 05:41:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33728)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1ihWkw-00022b-8r
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 05:40:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1ihWkr-0007rL-EI
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 05:40:34 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:25297
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1ihWkr-0007oQ-85
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 05:40:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576665631;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=62sR75S9g4MyWlUxevCuy2qw0Wow9hIlkllKDSgNdqM=;
 b=F0YO2AB3/XySy1rXwlQ7w4Xf0z/slUbfPFJpKr0SkZFeu6Yeb55wLudx5j5h3K1RAAEfAl
 jKvA9e56xmF/SWPl/s/mnss6v1DI9uHG1mKhXP/VmMmmjBqwmOp1bRKPjBCoAH+HFqkJ2I
 +klOaS+MVxp7Jn5L91rFKMinfjDwBWs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-107-Dw4JBfOvOdmqcuWqN_W14w-1; Wed, 18 Dec 2019 05:40:28 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5A417DB20
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2019 10:40:27 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-116-150.ams2.redhat.com [10.36.116.150])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 156AA60C18;
 Wed, 18 Dec 2019 10:40:25 +0000 (UTC)
Subject: Re: [PATCH v2 01/10] migration-test: Create cmd_soure and cmd_target
To: Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org
References: <20191218015520.2881-1-quintela@redhat.com>
 <20191218015520.2881-2-quintela@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <bd9939c4-9eff-9028-03bd-93e14f3defcd@redhat.com>
Date: Wed, 18 Dec 2019 11:40:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191218015520.2881-2-quintela@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: Dw4JBfOvOdmqcuWqN_W14w-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
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
Cc: Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 18/12/2019 02.55, Juan Quintela wrote:
> We are repeating almost everything for each machine while creating the
> command line for migration.  And once for source and another for
> destination.  We start putting there opts_src and opts_dst.
>=20
> Signed-off-by: Juan Quintela <quintela@redhat.com>
> ---
>  tests/migration-test.c | 44 ++++++++++++++++++++++++------------------
>  1 file changed, 25 insertions(+), 19 deletions(-)
>=20
> diff --git a/tests/migration-test.c b/tests/migration-test.c
> index a5343fdc66..fbddcf2317 100644
> --- a/tests/migration-test.c
> +++ b/tests/migration-test.c
> @@ -557,6 +557,7 @@ static int test_migrate_start(QTestState **from, QTes=
tState **to,
>                                 const char *opts_dst)
>  {
>      gchar *cmd_src, *cmd_dst;
> +    gchar *cmd_source, *cmd_target;

The naming looks quite unfortunate to me ... "cmd_src" can easily be
mixed up with "cmd_source" ... but maybe you could do it without these
additional variables (see below) ...

[...]
> @@ -671,11 +671,17 @@ static int test_migrate_start(QTestState **from, QT=
estState **to,
>          cmd_dst =3D tmp;
>      }
> =20
> -    *from =3D qtest_init(cmd_src);
> +    cmd_source =3D g_strdup_printf("%s %s",
> +                                 cmd_src, opts_src);
>      g_free(cmd_src);
> +    *from =3D qtest_init(cmd_source);
> +    g_free(cmd_source);
> =20
> -    *to =3D qtest_init(cmd_dst);
> +    cmd_target =3D g_strdup_printf("%s %s",
> +                                 cmd_dst, opts_dst);
>      g_free(cmd_dst);
> +    *to =3D qtest_init(cmd_target);
> +    g_free(cmd_target);

May I suggest to qtest_initf() here instead:

  *from =3D qtest_initf("%s %s", cmd_src, opts_src);

  *to =3D qtest_initf("%s %s", cmd_dst, opts_dst);


And maybe you could even move the extra_opts here, too? e.g.:

  *from =3D qtest_initf("%s %s %s", cmd_src, extra_opts ?: "", opts_src);

  *to =3D qtest_initf("%s %s %s", cmd_dst,  extra_opts ?: "", opts_dst);

 Thomas


