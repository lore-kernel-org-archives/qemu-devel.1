Return-Path: <SRS0=IEfc=4J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95EC0C35640
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 07:38:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5FA6C20656
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 07:38:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dE8IUt6G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FA6C20656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53184 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j52tm-0007iQ-JN
	for qemu-devel@archiver.kernel.org; Fri, 21 Feb 2020 02:38:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43989)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1j52t7-0007Cg-HF
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 02:38:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1j52t6-0007R4-9L
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 02:38:17 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:55543
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1j52t6-0007NZ-5h
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 02:38:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582270695;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ivlYN+I1MiRVaAJX3T1ltBTxmac4Df8VdwXtfcMODnw=;
 b=dE8IUt6GAbMgFh7ay9eCIIEC+89He5yXdB3yTVpr47UwS2STt6wpiCVoE4AptsKbSV0PCa
 /PsUvc5zNXprQkZa6/PVVzssRKzJF7Ly1JB69EKjN/M0lnQ1PZbUHWfGbpj+IWULokpcqs
 F5ak5KUHo75WY5zHq1Lm7TpeAn/ED9E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-63-Uj8oUS1wOMeD0qif6IMjEA-1; Fri, 21 Feb 2020 02:38:11 -0500
X-MC-Unique: Uj8oUS1wOMeD0qif6IMjEA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A2DF88018C0;
 Fri, 21 Feb 2020 07:38:09 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-129.ams2.redhat.com
 [10.36.116.129])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9B9EF388;
 Fri, 21 Feb 2020 07:38:03 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 12D6D11386A6; Fri, 21 Feb 2020 08:38:02 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Subject: Re: [PATCH v7 01/11] qapi/error: add (Error **errp) cleaning APIs
References: <20200131130118.1716-1-vsementsov@virtuozzo.com>
 <20200131130118.1716-2-vsementsov@virtuozzo.com>
Date: Fri, 21 Feb 2020 08:38:02 +0100
In-Reply-To: <20200131130118.1716-2-vsementsov@virtuozzo.com> (Vladimir
 Sementsov-Ogievskiy's message of "Fri, 31 Jan 2020 16:01:08 +0300")
Message-ID: <87d0a88k6d.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Kevin Wolf <kwolf@redhat.com>, Stefano Stabellini <sstabellini@kernel.org>,
 Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-block@nongnu.org,
 Paul Durrant <paul@xen.org>, Laszlo Ersek <lersek@redhat.com>,
 qemu-devel@nongnu.org, armbru@redhat.com, Greg Kurz <groug@kaod.org>,
 Gerd Hoffmann <kraxel@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Anthony Perard <anthony.perard@citrix.com>, xen-devel@lists.xenproject.org,
 Max Reitz <mreitz@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Stefan Berger <stefanb@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com> writes:

> Add functions to clean Error **errp: call corresponding Error *err
> cleaning function an set pointer to NULL.
>
> New functions:
>   error_free_errp
>   error_report_errp
>   warn_report_errp
>
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> Reviewed-by: Greg Kurz <groug@kaod.org>
> Reviewed-by: Eric Blake <eblake@redhat.com>
> ---
>
> CC: Eric Blake <eblake@redhat.com>
> CC: Kevin Wolf <kwolf@redhat.com>
> CC: Max Reitz <mreitz@redhat.com>
> CC: Greg Kurz <groug@kaod.org>
> CC: Stefano Stabellini <sstabellini@kernel.org>
> CC: Anthony Perard <anthony.perard@citrix.com>
> CC: Paul Durrant <paul@xen.org>
> CC: Stefan Hajnoczi <stefanha@redhat.com>
> CC: "Philippe Mathieu-Daud=C3=A9" <philmd@redhat.com>
> CC: Laszlo Ersek <lersek@redhat.com>
> CC: Gerd Hoffmann <kraxel@redhat.com>
> CC: Stefan Berger <stefanb@linux.ibm.com>
> CC: Markus Armbruster <armbru@redhat.com>
> CC: Michael Roth <mdroth@linux.vnet.ibm.com>
> CC: qemu-block@nongnu.org
> CC: xen-devel@lists.xenproject.org
>
>  include/qapi/error.h | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
>
> diff --git a/include/qapi/error.h b/include/qapi/error.h
> index ad5b6e896d..d34987148d 100644
> --- a/include/qapi/error.h
> +++ b/include/qapi/error.h
> @@ -309,6 +309,32 @@ void warn_reportf_err(Error *err, const char *fmt, .=
..)
>  void error_reportf_err(Error *err, const char *fmt, ...)
>      GCC_FMT_ATTR(2, 3);
> =20
> +/*
> + * Functions to clean Error **errp: call corresponding Error *err cleani=
ng
> + * function, then set pointer to NULL.
> + */
> +static inline void error_free_errp(Error **errp)
> +{
> +    assert(errp && *errp);
> +    error_free(*errp);
> +    *errp =3D NULL;
> +}
> +
> +static inline void error_report_errp(Error **errp)
> +{
> +    assert(errp && *errp);
> +    error_report_err(*errp);
> +    *errp =3D NULL;
> +}
> +
> +static inline void warn_report_errp(Error **errp)
> +{
> +    assert(errp && *errp);
> +    warn_report_err(*errp);
> +    *errp =3D NULL;
> +}
> +
> +
>  /*
>   * Just like error_setg(), except you get to specify the error class.
>   * Note: use of error classes other than ERROR_CLASS_GENERIC_ERROR is

These appear to be unused apart from the Coccinelle script in PATCH 03.

They are used in the full "[RFC v5 000/126] error: auto propagated
local_err" series.  Options:

1. Pick a few more patches into this part I series, so these guys come
   with users.

2. Punt this patch to the first part that has users, along with the
   part of the Coccinelle script that deals with them.

3. Do nothing: accept the functions without users.

I habitually dislike 3., but reviewing the rest of this series might
make me override that dislike.


