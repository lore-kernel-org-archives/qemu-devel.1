Return-Path: <SRS0=bVMU=B5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F7A4C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 14:23:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1EF6B2076E
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 14:23:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PDPsZ4po"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1EF6B2076E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56884 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8P0C-0000Gn-EF
	for qemu-devel@archiver.kernel.org; Wed, 19 Aug 2020 10:23:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43536)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1k8Oze-0008Cz-Oz
 for qemu-devel@nongnu.org; Wed, 19 Aug 2020 10:23:10 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:57500
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1k8Ozd-00080b-8Q
 for qemu-devel@nongnu.org; Wed, 19 Aug 2020 10:23:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597846988;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lqXy21QtGqQAVV5HjHgK1+9u7fABr8w+MUxmyLFVeBM=;
 b=PDPsZ4poHo2uv2AarwS8zJN+txSfMBJfrhpj+FpsCV+ym7NW7s/90k5ibnSTPb6gi5J8U7
 BVVB9iUDz2cmDZHiae2FnbEAT/ISz5qCdHvTlFKjkTIdVDm88ZgyDvd2iESv/K237F5AXS
 IZWEOWR7uXwtytP1wWIvUHoxVTOYKac=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-386-GdvAuCNGPlKn4hDL0_-MLg-1; Wed, 19 Aug 2020 10:23:04 -0400
X-MC-Unique: GdvAuCNGPlKn4hDL0_-MLg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2F8661084C89;
 Wed, 19 Aug 2020 14:23:03 +0000 (UTC)
Received: from linux.fritz.box (ovpn-114-24.ams2.redhat.com [10.36.114.24])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 225BE27CD0;
 Wed, 19 Aug 2020 14:23:01 +0000 (UTC)
Date: Wed, 19 Aug 2020 16:23:00 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Max Reitz <mreitz@redhat.com>
Subject: Re: [RFC PATCH 19/22] block/export: Move strong user reference to
 block_exports
Message-ID: <20200819142300.GD10272@linux.fritz.box>
References: <20200813162935.210070-1-kwolf@redhat.com>
 <20200813162935.210070-20-kwolf@redhat.com>
 <5bdf307f-0d1e-b64c-978f-c9075a3e2eb0@redhat.com>
MIME-Version: 1.0
In-Reply-To: <5bdf307f-0d1e-b64c-978f-c9075a3e2eb0@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kwolf@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="s9fJI615cBHmzTOP"
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=kwolf@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/18 23:05:17
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--s9fJI615cBHmzTOP
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 19.08.2020 um 13:56 hat Max Reitz geschrieben:
> On 13.08.20 18:29, Kevin Wolf wrote:
> > The reference owned by the user/monitor that is created when adding the
> > export and dropped when removing it was tied to the 'exports' list in
> > nbd/server.c. Every block export will have a user reference, so move it
> > to the block export level and tie it to the 'block_exports' list in
> > block/export/export.c instead. This is necessary for introducing a QMP
> > command for removing exports.
> >=20
> > Note that exports are present in block_exports even after the user has
> > requested shutdown. This is different from NBD's exports where exports
> > are immediately removed on a shutdown request, even if they are still i=
n
> > the process of shutting down. In order to avoid that the user still
> > interacts with an export that is shutting down (and possibly removes it
> > a second time), we need to remember if the user actually still owns it.
> >=20
> > Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> > ---
> >  include/block/export.h | 8 ++++++++
> >  block/export/export.c  | 4 ++++
> >  blockdev-nbd.c         | 5 -----
> >  nbd/server.c           | 2 --
> >  4 files changed, 12 insertions(+), 7 deletions(-)
>=20
> With this patch, there=E2=80=99s an abort in iotest 281.  Perhaps because
> blk_exp_unref() is now done by blk_exp_request_shutdown() outside of
> where the AIO context is locked?

I have two fixes locally that were related to failing qemu-iotests. I
guess the first one might be for what you're seeing?

Kevin

diff --git a/block/export/export.c b/block/export/export.c
index 71d17bd440..d021b98b74 100644
--- a/block/export/export.c
+++ b/block/export/export.c
@@ -105,9 +105,14 @@ void blk_exp_unref(BlockExport *exp)
 {
     assert(exp->refcount > 0);
     if (--exp->refcount =3D=3D 0) {
+        AioContext *aio_context =3D exp->ctx;
+
+        aio_context_acquire(aio_context);
         QLIST_REMOVE(exp, next);
         exp->drv->delete(exp);
         blk_unref(exp->blk);
+        aio_context_release(aio_context);
+
         g_free(exp->id);
         g_free(exp);
         aio_wait_kick();
diff --git a/tests/qemu-iotests/223.out b/tests/qemu-iotests/223.out
index e1eaaedb55..31ce9e6fe0 100644
--- a/tests/qemu-iotests/223.out
+++ b/tests/qemu-iotests/223.out
@@ -45,7 +45,7 @@ exports available: 0
 {"execute":"nbd-server-add", "arguments":{"device":"nosuch"}}
 {"error": {"class": "GenericError", "desc": "Cannot find device=3Dnosuch n=
or node_name=3Dnosuch"}}
 {"execute":"nbd-server-add", "arguments":{"device":"n"}}
-{"error": {"class": "GenericError", "desc": "NBD server already has export=
 named 'n'"}}
+{"error": {"class": "GenericError", "desc": "Block export id 'n' is alread=
y in use"}}
 {"execute":"nbd-server-add", "arguments":{"device":"n", "name":"n2", "bitm=
ap":"b2"}}
 {"error": {"class": "GenericError", "desc": "Enabled bitmap 'b2' incompati=
ble with readonly export"}}
 {"execute":"nbd-server-add", "arguments":{"device":"n", "name":"n2", "bitm=
ap":"b3"}}
@@ -126,7 +126,7 @@ exports available: 0
 {"execute":"nbd-server-add", "arguments":{"device":"nosuch"}}
 {"error": {"class": "GenericError", "desc": "Cannot find device=3Dnosuch n=
or node_name=3Dnosuch"}}
 {"execute":"nbd-server-add", "arguments":{"device":"n"}}
-{"error": {"class": "GenericError", "desc": "NBD server already has export=
 named 'n'"}}
+{"error": {"class": "GenericError", "desc": "Block export id 'n' is alread=
y in use"}}
 {"execute":"nbd-server-add", "arguments":{"device":"n", "name":"n2", "bitm=
ap":"b2"}}
 {"error": {"class": "GenericError", "desc": "Enabled bitmap 'b2' incompati=
ble with readonly export"}}
 {"execute":"nbd-server-add", "arguments":{"device":"n", "name":"n2", "bitm=
ap":"b3"}}


--s9fJI615cBHmzTOP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE3D3rFZqa+V09dFb+fwmycsiPL9YFAl89NcQACgkQfwmycsiP
L9ZFRA/+Me7GHzdmDH8EFQ2iQqYhau05ltT4Z2TZR9uULlsvHxmiadRiCvY9M7FN
ziBfm/Z0UHTgdnpH58gP6MAL0135wai12HQL8rkWybK5yFJ1Hk12Gy2UMx5U/EWe
iCxpR/3nrsBPE0lqaQduLdOGgkcfOmiadquJyR7nYfKyyladhR4P6xCYKMdpOmGa
GYvwXoAtS9P9dCb9UoNNyUHxf2w6tBHsTHpue8men+3gLruiCdYblfab16DtFjmP
u9TzCE8k8IB0UbKy5GpYC/FquynN8pEtCWQ42PMMDt+y+gI9HTUIbcLUHVLjkngJ
0hIFk6vTE0GSydgXj//DNTV/yUIGfIZh+lC+dFqcnyBLbEQbCXNFq2iYFR3zMpkd
cb5CNdsjxUCzS5EJ+BJqmgBvBC6OOMRYjr/IZ85JwJp7GfuLMzbM5IZM7vCmC3fp
XSUjBCN1vPoAB+sm/3OGEHWtG7CPTDpUq+1G1uTIDEHNy3iG/g0tSVwiO7iIiQPJ
+eFQeD2pljso6NGrYJbEfQXcZNYrOq9WEQAh2WgLTN/EvhHZDdN1ywSW0EN43pZf
fDga4vb9tU3R+PYn+vciRw/ZEfOXlmEGYDittgOwpMA6SavRha3GTJxbrklVVuZK
EylceUL20RWeqUMUuYKnJCLbM9yHhizSmRxZ77/wBmTO0taY33I=
=2wC+
-----END PGP SIGNATURE-----

--s9fJI615cBHmzTOP--


