Received: from eggs.gnu.org ([2001:4830:134:3::10]:34608)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1eqP0E-0000AD-03
	for qemu-devel@nongnu.org; Mon, 26 Feb 2018 15:04:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1eqP0A-0006o2-QL
	for qemu-devel@nongnu.org; Mon, 26 Feb 2018 15:04:02 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43416 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1eqP0A-0006nq-LW
	for qemu-devel@nongnu.org; Mon, 26 Feb 2018 15:03:58 -0500
Date: Mon, 26 Feb 2018 20:03:55 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180226200354.GG2873@work-vm>
References: <CC0ED444C2C80B429092A9F3715307D9D456F102@H3CMLB12-EX.srv.huawei-3com.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CC0ED444C2C80B429092A9F3715307D9D456F102@H3CMLB12-EX.srv.huawei-3com.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] HMP: Initialize err before using
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Zhangjixiang <jixiang_zhang@h3c.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

* Zhangjixiang (jixiang_zhang@h3c.com) wrote:
> From 295640e6f4aa83b843e245bb1af9995be37de84d Mon Sep 17 00:00:00 2001
> From: zhangjixiang <jixiang_zhang@h3c.com>
> Date: Sun, 25 Feb 2018 09:47:51 +0800
> Subject: [PATCH] HMP: Initialize err before using
>=20
> When bdrv_snapshot_delete return fail, the errp will not be
> assigned a valid value in error_propagate as errp didn't be
> initialized in hmp_delvm, then error_reportf_err will use an
> uninitialized value(call by hmp_delvm), and qemu crash.
>=20
> Signed-off-by: zhangjixiang <jixiang_zhang@h3c.com>
> ---
> hmp.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/hmp.c b/hmp.c
> index 7870d6a300..4a4da004e9 100644
> --- a/hmp.c
> +++ b/hmp.c
> @@ -1340,7 +1340,7 @@ void hmp_savevm(Monitor *mon, const QDict *qdict)
> void hmp_delvm(Monitor *mon, const QDict *qdict)
> {
>      BlockDriverState *bs;
> -    Error *err;
> +    Error *err =3D NULL;
>      const char *name =3D qdict_get_str(qdict, "name");
>      if (bdrv_all_delete_snapshot(name, &bs, &err) < 0) {

OK, that looks right; and that bug seems to have been around for a
while; thank you:

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

(I think the headers on the mail look a bit broken; it's probably best
to use git send-email  when possible).

Dave

> --
> 2.11.0
> -----------------------------------------------------------------------=
--------------------------------------------------------------
> =E6=9C=AC=E9=82=AE=E4=BB=B6=E5=8F=8A=E5=85=B6=E9=99=84=E4=BB=B6=E5=90=AB=
=E6=9C=89=E6=96=B0=E5=8D=8E=E4=B8=89=E6=8A=80=E6=9C=AF=E6=9C=89=E9=99=90=E5=
=85=AC=E5=8F=B8=E7=9A=84=E4=BF=9D=E5=AF=86=E4=BF=A1=E6=81=AF=EF=BC=8C=E4=BB=
=85=E9=99=90=E4=BA=8E=E5=8F=91=E9=80=81=E7=BB=99=E4=B8=8A=E9=9D=A2=E5=9C=B0=
=E5=9D=80=E4=B8=AD=E5=88=97=E5=87=BA
> =E7=9A=84=E4=B8=AA=E4=BA=BA=E6=88=96=E7=BE=A4=E7=BB=84=E3=80=82=E7=A6=81=
=E6=AD=A2=E4=BB=BB=E4=BD=95=E5=85=B6=E4=BB=96=E4=BA=BA=E4=BB=A5=E4=BB=BB=E4=
=BD=95=E5=BD=A2=E5=BC=8F=E4=BD=BF=E7=94=A8=EF=BC=88=E5=8C=85=E6=8B=AC=E4=BD=
=86=E4=B8=8D=E9=99=90=E4=BA=8E=E5=85=A8=E9=83=A8=E6=88=96=E9=83=A8=E5=88=86=
=E5=9C=B0=E6=B3=84=E9=9C=B2=E3=80=81=E5=A4=8D=E5=88=B6=E3=80=81
> =E6=88=96=E6=95=A3=E5=8F=91=EF=BC=89=E6=9C=AC=E9=82=AE=E4=BB=B6=E4=B8=AD=
=E7=9A=84=E4=BF=A1=E6=81=AF=E3=80=82=E5=A6=82=E6=9E=9C=E6=82=A8=E9=94=99=E6=
=94=B6=E4=BA=86=E6=9C=AC=E9=82=AE=E4=BB=B6=EF=BC=8C=E8=AF=B7=E6=82=A8=E7=AB=
=8B=E5=8D=B3=E7=94=B5=E8=AF=9D=E6=88=96=E9=82=AE=E4=BB=B6=E9=80=9A=E7=9F=A5=
=E5=8F=91=E4=BB=B6=E4=BA=BA=E5=B9=B6=E5=88=A0=E9=99=A4=E6=9C=AC
> =E9=82=AE=E4=BB=B6=EF=BC=81
> This e-mail and its attachments contain confidential information from N=
ew H3C, which is
> intended only for the person or entity whose address is listed above. A=
ny use of the
> information contained herein in any way (including, but not limited to,=
 total or partial
> disclosure, reproduction, or dissemination) by persons other than the i=
ntended
> recipient(s) is prohibited. If you receive this e-mail in error, please=
 notify the sender
> by phone or email immediately and delete it!
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
