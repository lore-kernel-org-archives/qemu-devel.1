Return-Path: <SRS0=7MIY=3D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E012C33C9E
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 16:35:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D482D24656
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 16:35:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qQ2ADBe1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D482D24656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43188 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irP9k-0007Fu-Sd
	for qemu-devel@archiver.kernel.org; Tue, 14 Jan 2020 11:35:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58705)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@gmail.com>) id 1irP8V-0006RX-0l
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 11:33:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1irP8T-00033u-Tl
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 11:33:46 -0500
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:34678)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1irP8T-00032A-NK
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 11:33:45 -0500
Received: by mail-wm1-x344.google.com with SMTP id w5so2694592wmi.1
 for <qemu-devel@nongnu.org>; Tue, 14 Jan 2020 08:33:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=uSVjhKQsmno1HV3Rle2p3/1U6G4RIKrGADGf8fxNEWs=;
 b=qQ2ADBe1EDNwoJ4GQjRgZrJEVFfIDiU1pus6PrGVNXqFDjgNtvf68Z202xv95PaXlz
 FBkyVqC2vFYeD62Rt+hYc9LOhid+zFtlfAaAE+Q2xSve7F2IqIqRt11q3M0uEAn6hK1R
 KBmPCzKrFCi0Kcb3mQfYRIzKzJeydOTjpTQhPKVMxDrX8zRETT+C67PphdeoWDJ/ekXA
 6l7fTnvz/cfPtkDPl/ln6Wc54RD1GnZwWHUIZYskffZpCbXetwAUt+WpkU41P6+xURFL
 PYODMIAYqWep+UtqI2xR0g/rJS70WPfVGeY/mViHWs0aH0QSvBlo/0ZH4wxcESyFelq1
 1lFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=uSVjhKQsmno1HV3Rle2p3/1U6G4RIKrGADGf8fxNEWs=;
 b=flVcf/Pov/r5pGUSKeUQ7O/Vh54q0fXIMH9jztYAhof9PCUb54cLnrQDubpDgAKeCm
 8g8C29ldFACs3AXzpmrT82Vtng/Kferz/vuEoHY+DnmqaJV+V0i67dv5vyEs0hMPkB2d
 Q10+BkchnS2mMZvLwosYY4pTsGHvNDRjpQPsDNETj11ZIolwwviyMDzE7Vj1+pXoF4+g
 +8r3HObh0T8fKomznas+0mUKzKYUO419C92J/IpSkyk41kTv/nYUXBxVAUODP9QY4WnG
 Lkt9PwOmMQ84xfSchuovMWjTYPasCwieRVFd4KZMlD9eDGM+XMu9xh8StQEZmtLieJBE
 mWlw==
X-Gm-Message-State: APjAAAU0lZyj+n9Bu58XJ3uA+YxH+pI5xKv8FiPnTDinePRT26X821Bj
 fdZ0LTjWu66myNnrE3V7DFg=
X-Google-Smtp-Source: APXvYqwHElGwd68i4uVc0ufpBzUq+GhT1i3h+Mpv+l/VI/x6GWz5PcjIpEnVv3rYEI49U0lUBhM2DQ==
X-Received: by 2002:a1c:7e0b:: with SMTP id z11mr26264682wmc.88.1579019624120; 
 Tue, 14 Jan 2020 08:33:44 -0800 (PST)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id p5sm19332492wrt.79.2020.01.14.08.33.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jan 2020 08:33:42 -0800 (PST)
Date: Tue, 14 Jan 2020 16:33:41 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Yang Zhong <yang.zhong@intel.com>
Subject: Re: [PATCH] vhost-user-blk: reset the device if supported
Message-ID: <20200114163341.GF132666@stefanha-x1.localdomain>
References: <20200110122203.6735-1-yang.zhong@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="0hHDr/TIsw4o3iPK"
Content-Disposition: inline
In-Reply-To: <20200110122203.6735-1-yang.zhong@intel.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
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
Cc: pbonzini@redhat.com, qemu-devel@nongnu.org, stefanha@redhat.com,
 mst@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--0hHDr/TIsw4o3iPK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 10, 2020 at 08:22:03PM +0800, Yang Zhong wrote:
> As the vhost-user-scsi did in f04724, if the vhost-user-blk backend
> supports the VHOST_USER_F_RESET_DEVICE protocol feature, then the
> device can be reset when requested.
>=20
> If this feature is not supported, this reset will directly return.
>=20
> Signed-off-by: Yang Zhong <yang.zhong@intel.com>
> ---
>  hw/block/vhost-user-blk.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
>=20
> diff --git a/hw/block/vhost-user-blk.c b/hw/block/vhost-user-blk.c
> index 63da9bb619..16ddc9b70c 100644
> --- a/hw/block/vhost-user-blk.c
> +++ b/hw/block/vhost-user-blk.c
> @@ -50,6 +50,10 @@ static const int user_feature_bits[] =3D {
>      VHOST_INVALID_FEATURE_BIT
>  };
> =20
> +enum VhostUserProtocolFeature {
> +    VHOST_USER_PROTOCOL_F_RESET_DEVICE =3D 13,
> +};

vhost-user protocol constants should be defined in
hw/virtio/vhost-user.h and not duplicated in device implementations.

> +
>  static void vhost_user_blk_update_config(VirtIODevice *vdev, uint8_t *co=
nfig)
>  {
>      VHostUserBlk *s =3D VHOST_USER_BLK(vdev);
> @@ -290,8 +294,23 @@ static void vhost_user_blk_handle_output(VirtIODevic=
e *vdev, VirtQueue *vq)
>  static void vhost_user_blk_reset(VirtIODevice *vdev)
>  {
>      VHostUserBlk *s =3D VHOST_USER_BLK(vdev);
> +    struct vhost_dev *dev =3D &s->dev;
> =20
>      vhost_dev_free_inflight(s->inflight);
> +
> +    /*
> +     * Historically, reset was not implemented so only reset devices
> +     * that are expecting it.
> +     */
> +    if (!virtio_has_feature(dev->protocol_features,
> +                            VHOST_USER_PROTOCOL_F_RESET_DEVICE)) {
> +        return;
> +    }
> +
> +    if (dev->vhost_ops->vhost_reset_device) {
> +        dev->vhost_ops->vhost_reset_device(dev);
> +    }
> +
>  }

This should be a generic protocol feature that all vhost-user device
implementations benefit from.  Devices shouldn't have to explicitly
implement it over and over again.

Why isn't vhost_user_reset_device() called already?  Then it wouldn't be
necessary to modify vhost_user_blk_reset().

Stefan

--0hHDr/TIsw4o3iPK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl4d7WUACgkQnKSrs4Gr
c8j3uggAtWp5qme0p0tkKlMFzuyeqSVcAxCCBWwL23tqr52/nMbBEUzoKxbmHIFG
s5+Bd7J2b3kck3wz+7eK315NqA5cPODI90LlvI/M8hgEZm380j+6flh4LvoorroL
QC3ZZMuguN5kc69OXDCuGQ26amgKoDWevShbszyGHFG36HCes3E5NkZZAxuDe6iD
22H3Mg60/jBXGkBY4SLNzN3SVLrlZXJygRkQScHEId66svqi/iRWuf5exJo4s9WP
cmpKJGMDE1pOB2j07QCMGCNmJxOI81Avs4YMYKm/cuOxg1rZC9lFGk1B1LydJyFg
glgGJsGDyBoJHXhh82NoiJvSaQl89A==
=rbdU
-----END PGP SIGNATURE-----

--0hHDr/TIsw4o3iPK--

