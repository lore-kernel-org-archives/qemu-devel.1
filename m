Return-Path: <SRS0=QWrs=3F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68E4AC33CB1
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 09:46:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 307BB20661
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 09:46:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LokzOWwy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 307BB20661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39074 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1is1js-0005b7-Ct
	for qemu-devel@archiver.kernel.org; Thu, 16 Jan 2020 04:46:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40308)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1is1iw-0004aH-8q
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 04:45:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1is1ir-0002Nw-Tx
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 04:45:58 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:21690
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1is1io-0002MK-PD
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 04:45:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579167949;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gd9SSKEi2ZBDSVId4mrFm3zCFOvqWyOdRqSIeUJb+i8=;
 b=LokzOWwyi/8V8l4nJIb6Z0akvdTcNRaT35IcPnVfIhW2Ksa/8aBceto/xHCzWziq/dCtRt
 DviUxAO/sXec4csRuKikaER2mQ+ESc7MhcjuIigIStMIFma6fyXvonC30fBT3yl/21Sm8N
 zTTpAR3vC0nIhauaQ4ujumn/fD45+yg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-168-oMtgTksKOoa0EuOQ52BE6Q-1; Thu, 16 Jan 2020 04:45:45 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 99883477;
 Thu, 16 Jan 2020 09:45:44 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-131.ams2.redhat.com
 [10.36.116.131])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0477C101F942;
 Thu, 16 Jan 2020 09:45:42 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 8998A1138600; Thu, 16 Jan 2020 10:45:40 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Subject: Re: [PATCH v3 4/4] block: Mark 'block_resize' as coroutine
References: <20200115122326.26393-1-kwolf@redhat.com>
 <20200115122326.26393-5-kwolf@redhat.com>
Date: Thu, 16 Jan 2020 10:45:40 +0100
In-Reply-To: <20200115122326.26393-5-kwolf@redhat.com> (Kevin Wolf's message
 of "Wed, 15 Jan 2020 13:23:26 +0100")
Message-ID: <87tv4vzqd7.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: oMtgTksKOoa0EuOQ52BE6Q-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: stefanha@redhat.com, marcandre.lureau@gmail.com, qemu-devel@nongnu.org,
 qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Kevin Wolf <kwolf@redhat.com> writes:

> block_resize is safe to run in a coroutine, so use it as an example for
> the new 'coroutine': true annotation in the QAPI schema.
>
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  qapi/block-core.json | 3 ++-
>  blockdev.c           | 6 +++---
>  2 files changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/qapi/block-core.json b/qapi/block-core.json
> index 7ff5e5edaf..1dbb2a9901 100644
> --- a/qapi/block-core.json
> +++ b/qapi/block-core.json
> @@ -1341,7 +1341,8 @@
>  { 'command': 'block_resize',
>    'data': { '*device': 'str',
>              '*node-name': 'str',
> -            'size': 'int' } }
> +            'size': 'int' },
> +  'coroutine': true }
> =20
>  ##
>  # @NewImageMode:
> diff --git a/blockdev.c b/blockdev.c
> index 8e029e9c01..b5e5d1e072 100644
> --- a/blockdev.c
> +++ b/blockdev.c
> @@ -3161,9 +3161,9 @@ void hmp_drive_del(Monitor *mon, const QDict *qdict=
)
>      aio_context_release(aio_context);
>  }
> =20
> -void qmp_block_resize(bool has_device, const char *device,
> -                      bool has_node_name, const char *node_name,
> -                      int64_t size, Error **errp)
> +void coroutine_fn qmp_block_resize(bool has_device, const char *device,
> +                                   bool has_node_name, const char *node_=
name,
> +                                   int64_t size, Error **errp)
>  {
>      Error *local_err =3D NULL;
>      BlockBackend *blk =3D NULL;

Pardon my ignorant question: what exactly makes a function a
coroutine_fn?


