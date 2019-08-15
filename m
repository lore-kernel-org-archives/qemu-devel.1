Return-Path: <SRS0=gzPR=WL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFE65C3A589
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 13:54:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE6442086C
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 13:54:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UuCrYHGR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE6442086C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42080 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hyGCc-0005XQ-Pq
	for qemu-devel@archiver.kernel.org; Thu, 15 Aug 2019 09:54:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49922)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@gmail.com>) id 1hyGBn-000512-P2
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 09:53:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1hyGBk-000063-TP
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 09:53:15 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:35265)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>)
 id 1hyGBk-00005s-Mj; Thu, 15 Aug 2019 09:53:12 -0400
Received: by mail-wm1-x344.google.com with SMTP id l2so1323937wmg.0;
 Thu, 15 Aug 2019 06:53:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=Wn/K6TyKkAfA96NrFqoPly88RvSOM+kMolzJJ+VA9GM=;
 b=UuCrYHGRuI3CSEzBrYZDiZ89Yz7KTY6dPJPaFGtRlmgDy2q6GIKBrNGeDzF6U+S8cZ
 uiI8GBA7ubutjNki+KKN/2UoL+A8ejnTlGrQQ0mDmbTtDl0wopClU+by5LAVVA/HZhwc
 IXTaFMkba3WFCqPCoRSVTNsI/+ePhwNetkIhI7kgWRFpSnILkiJ9ySjUIoMLpnp+TgoJ
 iaFWREPsdI4077Uwu+wH6T1Ba18IZU/HlWRCEsiDNrd5RtD4KXHH+CrFd9xNlEZJxHjf
 wuPeGE+aTJD3EyQwrwyOeszuxeTGzwtoupWwLCODJSDyfk6zCEnlQQh2R8BADnN+rVle
 SHKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=Wn/K6TyKkAfA96NrFqoPly88RvSOM+kMolzJJ+VA9GM=;
 b=HuK/9Ml/cnuVoCj5rbhJig8VHToNWu8cfrBeHuGceTbh95l3m7utPDroV8z8bX7Sv6
 t1xPQdW+V6YSS7134LOQA5RuHsUpr9bkC1esCbgPPWoO29B40uXtXe0mj0nOrQHN4RI3
 DpkYMrlpOWtE0oRCaSEVSwIucXfern303NUu2d13OEFUmw0teYhOl1DBVKawzM0RkIKs
 jYXeHmdIR+A4dJet9G8/zIBURxV47jRzlyjnY8Q44SMB9GrBdwipvoeSL0tEd080ZNYD
 JgAzbHY90a+ZzAlAUMpI2gV9V0Wo+BCTGEQbLqq+TBeiYnGwS7ZETXXskRMqynWc8YHC
 UgcA==
X-Gm-Message-State: APjAAAUYsWuIVlgsvE3J1NFIuaTPCOizn8F7Fe4/M3boLAwvHXKysR1l
 VcmTz6eIqVqlI8UAEC659bU=
X-Google-Smtp-Source: APXvYqwGpdxpwWecZQJ7cJRgjdBrlx2yVplJhTvO0FYYLqr2a27Dg9iHEaslMp0Oqkvg6wFkWH+WhQ==
X-Received: by 2002:a1c:200a:: with SMTP id g10mr2733625wmg.160.1565877191415; 
 Thu, 15 Aug 2019 06:53:11 -0700 (PDT)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id c15sm8761730wrb.80.2019.08.15.06.53.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Aug 2019 06:53:10 -0700 (PDT)
Date: Thu, 15 Aug 2019 14:53:09 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Artemy Kapitula <dalt74@gmail.com>
Message-ID: <20190815135309.GC10996@stefanha-x1.localdomain>
References: <2c685097-1647-e2d3-8b8a-21f76551ce3c@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="CblX+4bnyfN0pR09"
Content-Disposition: inline
In-Reply-To: <2c685097-1647-e2d3-8b8a-21f76551ce3c@gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
Subject: Re: [Qemu-devel] [PATCH v0] Implement new cache mode "target"
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--CblX+4bnyfN0pR09
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 07, 2019 at 04:09:54PM +0300, Artemy Kapitula wrote:

Hi,
Please use "scripts/get_maintainer.pl -f block.c" to find out which
maintainers to email.  qemu-devel@nongnu.org is a high-traffic list and
patches not CCed to the right maintainer may not get quick review.

> There is an issue with databases in VM that perform too slow
> on generic SAN storages. The key point is fdatasync that flushes
> disk on SCSI target.
>=20
> The QEMU blockdev "target" cache mode intended to be used with
> SAN storages and is a mix of "none" by using direct I/O and
> "unsafe" that omit device flush.
>=20
> Such storages has its own data integrity protection and can
> be operated with direct I/O without additional fdatasyc().
>=20
> With generic SCSI targets like LIO or SCST it boost performance
> up to 100% on some profiles like database with transaction journal
> (postrgesql/mssql/oracle etc) or virtualized SDS (ceph/rook inside
> VMs) which performs block device cache flush on journal record.

If the physical storage controller has a Battery Backed Unit (BBU) or
similar then flush requests are not required with O_DIRECT.  This has
been a common enterprise storage configuration for many years and is
already supported in QEMU today:

Configure the guest with cache=3Dnone and disable the emulated storage
controller's write cache (e.g. -device virtio-blk-pci,write-cache=3Doff).
Inside the guest /sys/block/$BLKDEV/queue/write_cache should show "write
through".

I think this patch is not necessary since write-cache=3Doff already
exists.  cache=3Dtarget is also slower since the guest sends unnecessary
flush requests to the emulated storage controller.

Thanks,
Stefan

> Signed-off-by: Artemy Kapitula <dalt74@gmail.com>
> ---
>  block.c                | 4 ++++
>  qemu-options.hx        | 3 ++-
>  tests/qemu-iotests/026 | 2 +-
>  tests/qemu-iotests/091 | 2 +-
>  4 files changed, 8 insertions(+), 3 deletions(-)
>=20
> diff --git a/block.c b/block.c
> index cbd8da5f3b..60919d82ff 100644
> --- a/block.c
> +++ b/block.c
> @@ -884,6 +884,10 @@ int bdrv_parse_cache_mode(const char *mode, int *fla=
gs, bool *writethrough)
>      } else if (!strcmp(mode, "unsafe")) {
>          *writethrough =3D false;
>          *flags |=3D BDRV_O_NO_FLUSH;
> +    } else if (!strcmp(mode, "target")) {
> +        *writethrough =3D false;
> +        *flags |=3D BDRV_O_NOCACHE;
> +        *flags |=3D BDRV_O_NO_FLUSH;
>      } else if (!strcmp(mode, "writethrough")) {
>          *writethrough =3D true;
>      } else {
> diff --git a/qemu-options.hx b/qemu-options.hx
> index 9621e934c0..01f1f4ad34 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -1065,7 +1065,7 @@ This option defines the type of the media: disk or =
cdrom.
>  @var{snapshot} is "on" or "off" and controls snapshot mode for the given=
 drive
>  (see @option{-snapshot}).
>  @item cache=3D@var{cache}
> -@var{cache} is "none", "writeback", "unsafe", "directsync" or "writethro=
ugh"
> +@var{cache} is "none", "writeback", "unsafe", "target", "directsync" or =
"writethrough"
>  and controls how the host cache is used to access block data. This is a
>  shortcut that sets the @option{cache.direct} and @option{cache.no-flush}
>  options (as in @option{-blockdev}), and additionally @option{cache.write=
back},
> @@ -1084,6 +1084,7 @@ none         =E2=94=82 on                on        =
     off
>  writethrough =E2=94=82 off               off            off
>  directsync   =E2=94=82 off               on             off
>  unsafe       =E2=94=82 on                off            on
> +target       =E2=94=82 on                on             on
>  @end example
>  The default mode is @option{cache=3Dwriteback}.
> diff --git a/tests/qemu-iotests/026 b/tests/qemu-iotests/026
> index e30243608b..e7179b0de4 100755
> --- a/tests/qemu-iotests/026
> +++ b/tests/qemu-iotests/026
> @@ -42,7 +42,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
>  _supported_fmt qcow2
>  _supported_proto file
>  _default_cache_mode "writethrough"
> -_supported_cache_modes "writethrough" "none"
> +_supported_cache_modes "writethrough" "none" "target"
>  # The refcount table tests expect a certain minimum width for refcount e=
ntries
>  # (so that the refcount table actually needs to grow); that minimum is 1=
6 bits,
>  # being the default refcount entry width.
> diff --git a/tests/qemu-iotests/091 b/tests/qemu-iotests/091
> index d62ef18a02..2eaf258c8a 100755
> --- a/tests/qemu-iotests/091
> +++ b/tests/qemu-iotests/091
> @@ -47,7 +47,7 @@ _supported_fmt qcow2
>  _supported_proto file
>  _supported_os Linux
>  _default_cache_mode "none"
> -_supported_cache_modes "writethrough" "none" "writeback"
> +_supported_cache_modes "writethrough" "none" "writeback" "target"
>  size=3D1G
> --=20
> 2.21.0
>=20
>=20
>=20

--CblX+4bnyfN0pR09
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl1VY8UACgkQnKSrs4Gr
c8hCLQf/X3cD1YCccg01il8Z0Ar+prFZPbma4VnGZYu7+K0I7hjQme8H9j9rMK9W
PnnMAy5Nt2cfrk6T1SlgjIprwYxVZbnWVm8ksXXifo2S/mz/OECowijV3OC1peBm
sUxEvI6GUBB5EG8OFsg7Uwa6JwaGIXQB8KDNR1PH4+UPti4kCpGAi6KVhFYqiA26
yqwW7AuuuuiRf4IE0TkNxgpWIDooNg6nniI+SURE3B/bRWqss4X2HNT11E3NqTcX
PD1QSIazKW1Ic6D0c+DeJR+UwRgOvJ+kypMXOi5jDqxYsKhA9C/VovUvl6wu7qOM
iH/Xi4xuOQibAF4ffy0bNgvK4Le4zw==
=6L0g
-----END PGP SIGNATURE-----

--CblX+4bnyfN0pR09--

