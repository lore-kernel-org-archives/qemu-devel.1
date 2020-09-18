Return-Path: <SRS0=nn+c=C3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8E20C43463
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 11:26:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2539B21D42
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 11:26:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CPabFx5l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2539B21D42
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49570 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJEWz-0007Uq-6R
	for qemu-devel@archiver.kernel.org; Fri, 18 Sep 2020 07:26:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45628)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fziglio@redhat.com>)
 id 1kJEVO-0006eU-Sr
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 07:24:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:21173)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <fziglio@redhat.com>)
 id 1kJEVM-0003GO-SX
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 07:24:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600428280;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6Y65URvj6OZfr9hjiiiymfjWpGSnlAagiFbm/rdUml0=;
 b=CPabFx5l90xB1WsUplj7icHUjPSMPdpkS6KxB+EJ3mg+03YduhHWNtm1IbYNFTODwRl+Pi
 7hGVHErwzGcccDYEBmOA5fSUNG4RDwmGAacyZY9cs6cDQaq8ZxvKa0adSe/klgEOLGfqJ9
 /3U+jFLj8a4eKiHPaG3ckHIFkTwJNpc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-449-IASNFj1gPmS6kBmykUqxQw-1; Fri, 18 Sep 2020 07:24:38 -0400
X-MC-Unique: IASNFj1gPmS6kBmykUqxQw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 476C3640A3
 for <qemu-devel@nongnu.org>; Fri, 18 Sep 2020 11:24:37 +0000 (UTC)
Received: from colo-mx.corp.redhat.com
 (colo-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.20])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 402C619D6C
 for <qemu-devel@nongnu.org>; Fri, 18 Sep 2020 11:24:37 +0000 (UTC)
Received: from zmail25.collab.prod.int.phx2.redhat.com
 (zmail25.collab.prod.int.phx2.redhat.com [10.5.83.31])
 by colo-mx.corp.redhat.com (Postfix) with ESMTP id 21290183D040;
 Fri, 18 Sep 2020 11:24:37 +0000 (UTC)
Date: Fri, 18 Sep 2020 07:24:36 -0400 (EDT)
From: Frediano Ziglio <fziglio@redhat.com>
To: marcandre lureau <marcandre.lureau@redhat.com>
Message-ID: <484338779.1569363.1600428276612.JavaMail.zimbra@redhat.com>
In-Reply-To: <20200918100737.91646-1-marcandre.lureau@redhat.com>
References: <20200918100737.91646-1-marcandre.lureau@redhat.com>
Subject: Re: [PATCH] spice: remove obsolete callback
MIME-Version: 1.0
X-Originating-IP: [10.33.32.2, 10.4.195.12]
Thread-Topic: spice: remove obsolete callback
Thread-Index: Edv3/d4yVzfS+Y4jMioWGmzqWVTM3Q==
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=fziglio@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=216.205.24.124; envelope-from=fziglio@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/18 01:32:10
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.999,
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
Cc: qemu-devel@nongnu.org, kraxel@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

>=20
> From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>=20
> The "attach_worker" callbacks aren't doing anything in QEMU, but they
> were mandatory until Spice server commit
> 6aa1a17c69dc3cc02f338a78b3266e4c00ea1c1a ("spice-qxl: Remove QXLWorker
> definition").
>=20
> Furthermore, the old spelling is deprecated since commit
> 974692bda1e77af92b71ed43b022439448492cb9 ("spice-qxl: Fix typo in
> callback name and remove obsolete parameter")
>=20
> Compile that code out if Spice server version is recent enough.
>=20
> Fix compiler deprecation warnings with Spice > 0.14.3 (not released
> yet). We may want to wait until newer version is actually released to
> apply the patch.
>=20

You could use

#if SPICE_SERVER_VERSION <=3D 0x000e03 /* release 0.14.3 */

> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  hw/display/qxl.c   | 4 ++++
>  ui/spice-display.c | 4 ++++
>  2 files changed, 8 insertions(+)
>=20
> diff --git a/hw/display/qxl.c b/hw/display/qxl.c
> index 11871340e7..a02072dee0 100644
> --- a/hw/display/qxl.c
> +++ b/hw/display/qxl.c
> @@ -518,12 +518,14 @@ static int qxl_track_command(PCIQXLDevice *qxl, str=
uct
> QXLCommandExt *ext)
> =20
>  /* spice display interface callbacks */
> =20
> +#if SPICE_SERVER_VERSION < 0x000e04 /* release 0.14.4 */
>  static void interface_attach_worker(QXLInstance *sin, QXLWorker *qxl_wor=
ker)
>  {
>      PCIQXLDevice *qxl =3D container_of(sin, PCIQXLDevice, ssd.qxl);
> =20
>      trace_qxl_interface_attach_worker(qxl->id);
>  }
> +#endif
> =20
>  static void interface_set_compression_level(QXLInstance *sin, int level)
>  {
> @@ -1156,7 +1158,9 @@ static const QXLInterface qxl_interface =3D {
>      .base.major_version      =3D SPICE_INTERFACE_QXL_MAJOR,
>      .base.minor_version      =3D SPICE_INTERFACE_QXL_MINOR,
> =20
> +#if SPICE_SERVER_VERSION < 0x000e04 /* release 0.14.4 */
>      .attache_worker          =3D interface_attach_worker,
> +#endif

For 0.14.4 you can provide .attached_worker instead, even if version used w=
ould
be downgraded will work. Same function could be used (with a cast) for atta=
che_worker.
It depends on the usefulness of the trace call.

>      .set_compression_level   =3D interface_set_compression_level,
>  #if SPICE_NEEDS_SET_MM_TIME
>      .set_mm_time             =3D interface_set_mm_time,
> diff --git a/ui/spice-display.c b/ui/spice-display.c
> index 19632fdf6c..811936ff7f 100644
> --- a/ui/spice-display.c
> +++ b/ui/spice-display.c
> @@ -500,10 +500,12 @@ void qemu_spice_display_refresh(SimpleSpiceDisplay
> *ssd)
> =20
>  /* spice display interface callbacks */
> =20
> +#if SPICE_SERVER_VERSION < 0x000e04 /* release 0.14.4 */
>  static void interface_attach_worker(QXLInstance *sin, QXLWorker *qxl_wor=
ker)
>  {
>      /* nothing to do */
>  }
> +#endif
> =20
>  static void interface_set_compression_level(QXLInstance *sin, int level)
>  {
> @@ -709,7 +711,9 @@ static const QXLInterface dpy_interface =3D {
>      .base.major_version      =3D SPICE_INTERFACE_QXL_MAJOR,
>      .base.minor_version      =3D SPICE_INTERFACE_QXL_MINOR,
> =20
> +#if SPICE_SERVER_VERSION < 0x000e04 /* release 0.14.4 */
>      .attache_worker          =3D interface_attach_worker,
> +#endif
>      .set_compression_level   =3D interface_set_compression_level,
>  #if SPICE_NEEDS_SET_MM_TIME
>      .set_mm_time             =3D interface_set_mm_time,

Frediano


