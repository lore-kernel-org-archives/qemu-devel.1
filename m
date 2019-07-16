Return-Path: <SRS0=+QfZ=VN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E3EBC7618F
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 14:42:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E458F20880
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 14:42:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MWJeChwE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E458F20880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49638 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hnOeq-0003rh-7T
	for qemu-devel@archiver.kernel.org; Tue, 16 Jul 2019 10:42:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46104)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <stefanha@gmail.com>) id 1hnOef-0003S8-SW
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 10:42:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1hnOed-0007ZP-TC
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 10:42:09 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:34632)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1hnOed-0007Vo-Ae
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 10:42:07 -0400
Received: by mail-wr1-x441.google.com with SMTP id 31so21290964wrm.1
 for <qemu-devel@nongnu.org>; Tue, 16 Jul 2019 07:42:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=oBHMeO7Ax4mX5qPrPwUKCC+sukU+Mq1DnTmAERX1ljw=;
 b=MWJeChwEQGTnuIRxA4GlVopVqTrsoWZMj8cjiuuIaAZU0wOReOX2KACUC0TlzDGZON
 CwXMiqyxJW0G/JFwjcreNdlQmqQNEWXyOBnI8V//PYe6t6293+Q7JdEAuwJ+xVv978P3
 5NHD64CVDwBq8V5c/tTjeBnt8iIs/Xx+r2V/21BYLdWeGV3lcick1sEEl6ZKIxi0o5TJ
 xRt+viH1Z/AugGeIMPNpobMN0eShdHAFH9Kv+IuV0ebo7McSVH+I3c4A3J0aG6Hcxgkv
 /VV81oBivZ0Ku0fPN565GnWlnDN8n4EV7G6Ozusbh530HNeBM63gZd/jmeZIh1kRIN1A
 HSbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=oBHMeO7Ax4mX5qPrPwUKCC+sukU+Mq1DnTmAERX1ljw=;
 b=qzf0wg1IEOl71U3CSIdTn1X/QOci70KDFfALvjyIFDrZPjFVr82P3Q+PwXCZUE4St5
 quKhuegG3wz3WJrxpdVrNhMDiQAgyzL6qtriZ5UmAEVXN6ibdsyCnowGO4KocsCI2KOz
 Bm9rk2BsS89rwR7P+e8TjY47HLVtMNGj4JfOcBWTanUhD20kX3AmYVjnQ66EDb5LE9J5
 6k2V5x6+wBKeB5eRl/1rtrC6Z1kM53/1QAb0l9YtWPxRMjKYw3v/hAwlGZ2/qvdSXDg1
 cPhtFFqtjEPCFvSRj7bZuYcNpskoP69fYz3eegxIbLsv1jqOv1JmV2yvhJ7mdRZYcDqa
 PdaA==
X-Gm-Message-State: APjAAAUwPyXLdCt2RI2S6cv0VVgzFaGxce0udcRSHUJb/z3iIsACh5ep
 dwbDDh4qxNkz4RxKXziLNvM=
X-Google-Smtp-Source: APXvYqyflS/iEGx1wqPle67rsloakYHmnglNHnsL3mXDMMx609daq8eEyRS1g4lLjfRnWLgBzS13hw==
X-Received: by 2002:a05:6000:12c8:: with SMTP id
 l8mr37782171wrx.72.1563288123734; 
 Tue, 16 Jul 2019 07:42:03 -0700 (PDT)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id f10sm13118620wrs.22.2019.07.16.07.42.02
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Tue, 16 Jul 2019 07:42:02 -0700 (PDT)
Date: Tue, 16 Jul 2019 15:42:02 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
To: elohimes@gmail.com
Message-ID: <20190716144202.GB18691@stefanha-x1.localdomain>
References: <20190715102326.2805-1-xieyongji@baidu.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="kXdP64Ggrk/fb43R"
Content-Disposition: inline
In-Reply-To: <20190715102326.2805-1-xieyongji@baidu.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
Subject: Re: [Qemu-devel] [PATCH 1/2] vhost-scsi: Call
 virtio_scsi_common_unrealize() when device realize failed
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
Cc: fam@euphon.net, pbonzini@redhat.com, Xie Yongji <xieyongji@baidu.com>,
 qemu-devel@nongnu.org, mst@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--kXdP64Ggrk/fb43R
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 15, 2019 at 06:23:25PM +0800, elohimes@gmail.com wrote:
> From: Xie Yongji <xieyongji@baidu.com>
>=20
> This avoids memory leak when device hotplug is failed.
>=20
> Signed-off-by: Xie Yongji <xieyongji@baidu.com>
> ---
>  hw/scsi/vhost-scsi.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/hw/scsi/vhost-scsi.c b/hw/scsi/vhost-scsi.c
> index 4090f99ee4..db4a090576 100644
> --- a/hw/scsi/vhost-scsi.c
> +++ b/hw/scsi/vhost-scsi.c
> @@ -210,7 +210,7 @@ static void vhost_scsi_realize(DeviceState *dev, Erro=
r **errp)
>          if (err) {
>              error_propagate(errp, err);
>              error_free(vsc->migration_blocker);
> -            goto close_fd;
> +            goto free_virtio;
>          }
>      }
> =20
> @@ -240,6 +240,8 @@ static void vhost_scsi_realize(DeviceState *dev, Erro=
r **errp)
>          migrate_del_blocker(vsc->migration_blocker);
>      }
>      g_free(vsc->dev.vqs);
> + free_virtio:
> +    virtio_scsi_common_unrealize(dev, errp);

error_set*() requires that *errp =3D=3D NULL:

  static void error_setv(Error **errp, ...
  ...
      assert(*errp =3D=3D NULL);

Today virtio_scsi_common_unrealize() doesn't use the errp argument but
if it ever uses it then QEMU will hit an assertion failure.

Please do this instead:

  virtio_scsi_common_unrealize(dev, &error_abort);

If virtio_scsi_common_unrealize() ever produces an error there will be
an message explaining that errors are unexpected.

This also applies to Patch 2.

Alternatively you could do this to handle all cases and propagate the
error:

  Error *local_err =3D NULL;
  virtio_scsi_common_unrealize(dev, &local_err);
  error_propagate(errp, local_err);

--kXdP64Ggrk/fb43R
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl0t4jkACgkQnKSrs4Gr
c8jelAgArsi+liV90e7nYgSGmGJMBSyJS8Yu53VkFesPM9pAqJ3EhOXYSxezre6U
CRBGvSroYVxjggbU6auii7oGgZ4GE5H6MMHFgEuPT9Bxf/O5Wa5BSCjLOLMRNNOA
vTnD1VPqPjNxjzjkq43gxKjG1ugoLgfjJAEnzIxOtzREsZBHcoxnUtORaW2XdIR8
MxWMYTk16kqut7MgCT4i8nwrSIzMhWvcPQO4SMzrFjdTenDpd/W/AaEzPEFhjbH0
suDZm4wxeN3Nj55/EzxWuhDDU0VLfimuPiwbut/WcOYd0miC75VspaCrlNA0GhuW
k1x2vE60bBuVPiKHlg2hkNPKKbRBOw==
=YGzy
-----END PGP SIGNATURE-----

--kXdP64Ggrk/fb43R--

