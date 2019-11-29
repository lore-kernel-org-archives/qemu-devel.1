Return-Path: <SRS0=xfvu=ZV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 164DBC432C0
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 06:08:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D319B21835
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 06:08:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CRUCElt5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D319B21835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55188 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iaZRl-0001Oi-2E
	for qemu-devel@archiver.kernel.org; Fri, 29 Nov 2019 01:08:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55298)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1iaZAl-0002hV-7n
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 00:50:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1iaZAe-0001qU-GF
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 00:50:26 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:25744
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1iaZAe-0001gA-6m
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 00:50:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575006620;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7bPNp2OTc0T1mcFn9q891GOnTUFND2miNZ+SWYu5D+k=;
 b=CRUCElt58ItYII4e4Dfl8AG6x+bENecPqv79e3rQEjG5fZWfQCMIPns8abQBdmPM6IXS0B
 ROj20wSmThAs4QATKgsuwWE+tpYy0irXPllguI+37ajIps96Tm33qbMQ0d913yBLQkeKtb
 cVUUIVSg7vTnSjBv96+Y3RLe0xjN9t8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-385-5zKDrNG9N3-RYQ928bIcWQ-1; Fri, 29 Nov 2019 00:50:19 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3B43D10054E3;
 Fri, 29 Nov 2019 05:50:18 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-134.ams2.redhat.com
 [10.36.116.134])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 28B4919C6A;
 Fri, 29 Nov 2019 05:50:15 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id AE17C1138606; Fri, 29 Nov 2019 06:50:13 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Subject: Re: [PATCH v6] vnc: drop Error pointer indirection in
 vnc_client_io_error
References: <20191127184140.15264-1-vsementsov@virtuozzo.com>
Date: Fri, 29 Nov 2019 06:50:13 +0100
In-Reply-To: <20191127184140.15264-1-vsementsov@virtuozzo.com> (Vladimir
 Sementsov-Ogievskiy's message of "Wed, 27 Nov 2019 21:41:40 +0300")
Message-ID: <87imn3z0x6.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: 5zKDrNG9N3-RYQ928bIcWQ-1
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
Cc: qemu-devel@nongnu.org, kraxel@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com> writes:

> We don't need Error **, as all callers pass local Error object, which
> isn't used after the call, or NULL. Use Error * instead.
>
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  ui/vnc.h |  2 +-
>  ui/vnc.c | 20 +++++++-------------
>  2 files changed, 8 insertions(+), 14 deletions(-)
>
> diff --git a/ui/vnc.h b/ui/vnc.h
> index fea79c2fc9..4e2637ce6c 100644
> --- a/ui/vnc.h
> +++ b/ui/vnc.h
> @@ -547,7 +547,7 @@ uint32_t read_u32(uint8_t *data, size_t offset);
> =20
>  /* Protocol stage functions */
>  void vnc_client_error(VncState *vs);
> -size_t vnc_client_io_error(VncState *vs, ssize_t ret, Error **errp);
> +size_t vnc_client_io_error(VncState *vs, ssize_t ret, Error *err);
> =20
>  void start_client_init(VncState *vs);
>  void start_auth_vnc(VncState *vs);
> diff --git a/ui/vnc.c b/ui/vnc.c
> index 87b8045afe..4100d6e404 100644
> --- a/ui/vnc.c
> +++ b/ui/vnc.c
> @@ -1312,7 +1312,7 @@ void vnc_disconnect_finish(VncState *vs)
>      g_free(vs);
>  }
> =20
> -size_t vnc_client_io_error(VncState *vs, ssize_t ret, Error **errp)
> +size_t vnc_client_io_error(VncState *vs, ssize_t ret, Error *err)
>  {
>      if (ret <=3D 0) {
>          if (ret =3D=3D 0) {
> @@ -1320,15 +1320,11 @@ size_t vnc_client_io_error(VncState *vs, ssize_t =
ret, Error **errp)
>              vnc_disconnect_start(vs);
>          } else if (ret !=3D QIO_CHANNEL_ERR_BLOCK) {
>              trace_vnc_client_io_error(vs, vs->ioc,
> -                                      errp ? error_get_pretty(*errp) :
> -                                      "Unknown");
> +                                      err ? error_get_pretty(err) : "Unk=
nown");
>              vnc_disconnect_start(vs);
>          }
> =20
> -        if (errp) {
> -            error_free(*errp);
> -            *errp =3D NULL;
> -        }
> +        error_free(err);
>          return 0;
>      }
>      return ret;

Not visible in this patch: the vnc_client_io_error(vs, -1, NULL) in
ui/vnc-auth-sasl.c.  They trace "Unknown", vnc_disconnect_start() as
before.  They additionally execute error_free(NULL), which does nothing.
Good.

> @@ -1361,10 +1357,9 @@ size_t vnc_client_write_buf(VncState *vs, const ui=
nt8_t *data, size_t datalen)
>  {
>      Error *err =3D NULL;
>      ssize_t ret;
> -    ret =3D qio_channel_write(
> -        vs->ioc, (const char *)data, datalen, &err);
> +    ret =3D qio_channel_write(vs->ioc, (const char *)data, datalen, &err=
);
>      VNC_DEBUG("Wrote wire %p %zd -> %ld\n", data, datalen, ret);
> -    return vnc_client_io_error(vs, ret, &err);
> +    return vnc_client_io_error(vs, ret, err);
>  }
> =20
> =20
> @@ -1488,10 +1483,9 @@ size_t vnc_client_read_buf(VncState *vs, uint8_t *=
data, size_t datalen)
>  {
>      ssize_t ret;
>      Error *err =3D NULL;
> -    ret =3D qio_channel_read(
> -        vs->ioc, (char *)data, datalen, &err);
> +    ret =3D qio_channel_read(vs->ioc, (char *)data, datalen, &err);
>      VNC_DEBUG("Read wire %p %zd -> %ld\n", data, datalen, ret);
> -    return vnc_client_io_error(vs, ret, &err);
> +    return vnc_client_io_error(vs, ret, err);
>  }

Nothing changes for these guys.

Reviewed-by: Markus Armbruster <armbru@redhat.com>


