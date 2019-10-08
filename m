Return-Path: <SRS0=wvJ7=YB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6344C4360C
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 13:25:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF72B206C0
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 13:25:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cEJnW3++"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF72B206C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55580 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iHpUM-0007v8-Ps
	for qemu-devel@archiver.kernel.org; Tue, 08 Oct 2019 09:25:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41542)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@gmail.com>) id 1iHpTT-0007NW-HY
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 09:24:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1iHpTS-0006pW-CO
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 09:24:23 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:37877)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>)
 id 1iHpTP-0006kG-PX; Tue, 08 Oct 2019 09:24:19 -0400
Received: by mail-wm1-x342.google.com with SMTP id f22so3131940wmc.2;
 Tue, 08 Oct 2019 06:24:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=gKeRC+n/VO9W1X4S4Pth852h/5HkRnBZjuPEdlnecwU=;
 b=cEJnW3++qSoyjuJY8INOmGIYNIKk4/00/Nw4YSiw2yjVi3qf7M19CbWG2gNp2wK+Vq
 031OULkHgoH0UM5QLQ7ZHgFgC6n59ITZLtzB6Ev+XsRFr7C7xAPI7sWnSTDgg6e7q4Nw
 6hDnYDMp08tiOXQmjUR0FKoS2MXUGP7vyoIIX8TGf/Cj1/r0rC9ns112ovBnF5Ia2Usy
 p0KGc+RRruN3IEYhhTEz1gw0/Ml92HjqSOaUgIjPkOypCTaZWfuWwGK6wjrzJp3Jh+U8
 SeyQkioiIXnoWXrChYYSXdWxIpOABqNElYZ7n85pC9Vq1VT+NXsuMshSoxqGunu7GmG3
 1q0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=gKeRC+n/VO9W1X4S4Pth852h/5HkRnBZjuPEdlnecwU=;
 b=BMxP/qmWFf6e710jJ4iI845OnxPAzA0c+eM/fRXo/w9gVdmjdr+GeGLh7AZueb0PFN
 NkmPFj00c+bhl0oaPQI6jCFK2bfYQVuAIXQoEnCynf/as7IzqvT1ptB2kTEA5dT6cHgZ
 NbRRLW3kR3bq5rg70jK5D/5k7AwuYEGmEAf6KTBURBlAq+9n+0WrCMaiDXAvRzyJbMOe
 8Zk02lEyP4pzG2tTUP+r9Jx8f07bw7NjSue186je0GeyN04OMgo8GaSYc7Qk1yA59pY0
 ZnVt8pA0MdjCaL5D6WQTUpvJaqIIgm106HuVDls9pbfaS7u+7/kSV821elpJGet+WTbn
 3g2A==
X-Gm-Message-State: APjAAAVCdB9bfXj1MC8lKDcfB8b+yfgA8mTotIyEAifyvd/EFGYVC7mM
 rO3GkmcLm2IRvQn5Nt/5K44=
X-Google-Smtp-Source: APXvYqyL2EsZpo7m99rijuoONIuWaC0LOeL6gaj3jfc464q4l6HXUz8Rsok+XQZKrDTnTxaFYCZxhg==
X-Received: by 2002:a7b:c34e:: with SMTP id l14mr3508849wmj.123.1570541058409; 
 Tue, 08 Oct 2019 06:24:18 -0700 (PDT)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id h10sm17749565wrq.95.2019.10.08.06.24.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Oct 2019 06:24:17 -0700 (PDT)
Date: Tue, 8 Oct 2019 14:24:16 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Evgeny Yakovlev <wrfsh@yandex-team.ru>
Subject: Re: [RFC PATCH] virtio-blk: advertise F_WCE (F_FLUSH) if
 F_CONFIG_WCE is also advertised
Message-ID: <20191008132416.GA28104@stefanha-x1.localdomain>
References: <1568980590-806043-1-git-send-email-wrfsh@yandex-team.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="UlVJffcvxoiEqYs2"
Content-Disposition: inline
In-Reply-To: <1568980590-806043-1-git-send-email-wrfsh@yandex-team.ru>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
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
Cc: qemu-devel@nongnu.org, yc-core@yandex-team.ru, qemu-block@nongnu.org,
 stefanha@redhat.com, mst@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--UlVJffcvxoiEqYs2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 20, 2019 at 02:56:30PM +0300, Evgeny Yakovlev wrote:
> Virtio spec 1.1 (and earlier), 5.2.5.1 Driver Requirements: Device
> Initialization:
>=20
> "Devices SHOULD always offer VIRTIO_BLK_F_FLUSH, and MUST offer it if
> they offer VIRTIO_BLK_F_CONFIG_WCE.
>=20
> It looks like currently F_CONFIG_WCE and F_WCE are not connected to each
> other. qemu will advertise F_CONFIG_WCE if config-wce argument is
> set for virtio-blk device. While F_WCE is advertised if underlying block
> backend actually has it's caching enabled.
> Those two things are not related to each other.
>=20
> Signed-off-by: Evgeny Yakovlev <wrfsh@yandex-team.ru>
> ---
>  hw/block/virtio-blk.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
> index 1885160..b45dc0c 100644
> --- a/hw/block/virtio-blk.c
> +++ b/hw/block/virtio-blk.c
> @@ -990,7 +990,8 @@ static uint64_t virtio_blk_get_features(VirtIODevice =
*vdev, uint64_t features,
>          virtio_add_feature(&features, VIRTIO_BLK_F_SCSI);
>      }
> =20
> -    if (blk_enable_write_cache(s->blk)) {
> +    if (blk_enable_write_cache(s->blk) ||
> +        virtio_has_feature(features, VIRTIO_BLK_F_CONFIG_WCE)) {
>          virtio_add_feature(&features, VIRTIO_BLK_F_WCE);
>      }
>      if (blk_is_read_only(s->blk)) {
> --=20
> 2.7.4

Sorry for the very late response.  I have been ill and am still
recovering.

The motivation for this change looks correct but this patch may cause
host_features to change across live migration to a newer QEMU version.
If the guest accesses VIRTIO_PCI_HOST_FEATURES before and after live
migration it may see different values, which is unexpected.

The safe way of introducing guest-visible changes like this is to make
the change conditional on the machine type version so that old guests
see old behavior and new guests see new behavior.

Live migration compatibility can be guaranteed by adding a new property
to virtio_blk_properties[]:

  DEFINE_PROP_BOOL("enable-wce-if-config-wce", VirtIOBlock,
                   conf.enable_wce_if_config_wce, true),

Then tweak the patch:

  if (blk_enable_write_cache(s->blk) ||
      (s->conf.enable_wce_if_config_wce &&
       virtio_has_feature(features, VIRTIO_BLK_F_CONFIG_WCE))) {

And finally disable enable_wce_if_config_wce for older machine types to
retain compatibility:

  GlobalProperty hw_compat_4_2[] =3D {
      { "virtio-blk-device", "enable-wce-if-config-wce", "off" },
  };

(I have omitted some steps like defining
VirtIOBlkConf.enable_wce_if_config_wce field and hooking up
hw_compat_4_2[], but you can figure that out from the existing code.)

Stefan

--UlVJffcvxoiEqYs2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl2cjf8ACgkQnKSrs4Gr
c8htcQgAv+p5XmGjGRU5HkAXTIjfsmGcbH9JRGQWgkFAy2aILb4SUygm3Ws44ZQL
MW3w+xHjNEcUCmZAAKbOyrcIEOxMnbM8ArXem5MSREl7UAzse8JlxlVVhhVe8isd
L4oyXe0vXMbYJqD80uQQiex83CeOdD/lCxHMAVmSiSX66y7ksXuYD/7Z0MYuSDW3
xkCMLVasHxGMSPIUcHJ3wdTNdfzJEF4IRs7Dv38MnVUjPzqDGjxyGob4L7iPeIu1
ptWMXkJt5YoC5vxFueLbWISZSJ/zzKz1uNFWXIx6TPTvtjNIVLmNySXQ8sJNmkGH
jxJdCr25IorpzNuGhf5panWZ3Jj4JQ==
=YMyY
-----END PGP SIGNATURE-----

--UlVJffcvxoiEqYs2--

