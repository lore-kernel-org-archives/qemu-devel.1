Return-Path: <SRS0=QQWF=WY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A0F0C3A5A1
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 09:37:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4467F20856
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 09:37:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ikqjvM7e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4467F20856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34252 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2uNv-0002xh-2K
	for qemu-devel@archiver.kernel.org; Wed, 28 Aug 2019 05:36:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43923)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@gmail.com>) id 1i2uLu-0001BW-NM
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 05:34:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1i2uLt-0008Lc-O2
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 05:34:54 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:36336)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>)
 id 1i2uLt-0008Kx-HJ; Wed, 28 Aug 2019 05:34:53 -0400
Received: by mail-wr1-x442.google.com with SMTP id y19so1778973wrd.3;
 Wed, 28 Aug 2019 02:34:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=M7pr/LS9qdFwwInkf9CzKZNtbmS5/tpQHUbLM1mdSdE=;
 b=ikqjvM7eXhORtTbwOJiuXrFTFz4HbmM8WUBz8SR7HVDHX0cRYJMjLw1f81gHUkN6j/
 evFywIIwIfTRIz3oYOKT5eMmab6EOxgrSsQxn7SgvVFHASLzaDxZGxQFUr//yHnKcHlY
 k7GuL9ch9pTeRvHc2+gWJUC8fdG4C3kZ38h5qXGPMOmC392vo/xTexKknTNT3Cq3CAfJ
 c7pg6usx+vN8XEjkIsCfiKsKtttaMu1H28mIcvKZ06NdTEr9CkNaZGUy6ywBGAV6Aq2k
 zDWOCU8SBF+u1g+g11A2h3BfWJWC77zar3pshX3E+jdIIrRs6KzYbaG1ppg3oN7u4jvN
 4EQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=M7pr/LS9qdFwwInkf9CzKZNtbmS5/tpQHUbLM1mdSdE=;
 b=m5En7vERRKgtpPJwXuD/FUvl6cgREL+4Kh+i1pHGEv4PF8G+aRDaSoAVczPnKxV44P
 bZKqDGwLfLWxEMWG0OlKR+5l5fTJWCIUEHI2bpyku14cmvTBLoENoushx/wus0+5/mTL
 gDgvpBZ+A9KTeuRWvXLlGaqVISJHgMwpQDTAOViMQCMvFOdXx+hTnmPtMzONr9V5oUOI
 WMnGSW2Jl9PluTkV3XbmC4weFYC+oLb/s8Orwvu8SbROqiTSShGvIOfgvZqMWPuxjM6H
 19EDEdHLuQI5yHIdXM8U/DTsZHvEnjDbsLsUnviIcMXq2e5lBd/GyHm+h3+cqTDVjWIS
 WqNw==
X-Gm-Message-State: APjAAAVmkro+XROJiYbnZOyNYiw3yjVvKJmlHS+lgPMyqr8YdL5fogq2
 0JFSsa1x6szfxDQgjfXHeVXM5gdJeMA=
X-Google-Smtp-Source: APXvYqwJ7Z7enpycD3jbnPcmVhR5Vcl2elPSiYjv0vIOEW5b9FM73G2tBtZAOqZ4Xm04rXsTbEaD9w==
X-Received: by 2002:adf:fe08:: with SMTP id n8mr3363126wrr.60.1566984892205;
 Wed, 28 Aug 2019 02:34:52 -0700 (PDT)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id w7sm2116303wrn.11.2019.08.28.02.34.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Aug 2019 02:34:51 -0700 (PDT)
Date: Wed, 28 Aug 2019 10:34:49 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Dmitry Fomichev <dmitry.fomichev@wdc.com>
Message-ID: <20190828093449.GE5573@stefanha-x1.localdomain>
References: <20190823194927.23278-1-dmitry.fomichev@wdc.com>
 <20190823194927.23278-4-dmitry.fomichev@wdc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="EgVrEAR5UttbsTXg"
Content-Disposition: inline
In-Reply-To: <20190823194927.23278-4-dmitry.fomichev@wdc.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v5 3/4] block/ide/scsi: Set
 BLK_PERM_SUPPORT_ZONED
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 "Michael S . Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>, Alistair Francis <alistair.francis@wdc.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--EgVrEAR5UttbsTXg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 23, 2019 at 03:49:26PM -0400, Dmitry Fomichev wrote:
> Added a new boolean argument to blkconf_apply_backend_options()
> to let the common block code know whether the chosen block
> backend can handle zoned block devices or not.
>=20
> blkconf_apply_backend_options() then sets BLK_PERM_SUPPORT_ZONED
> permission accordingly. The raw code can then use this permission
> to allow or deny opening a zone device by a particular block driver.
>=20
> Signed-off-by: Dmitry Fomichev <dmitry.fomichev@wdc.com>
> Acked-by: Paul Durrant <paul.durrant@citrix.com>
> ---
>  hw/block/block.c         |  8 ++++++--
>  hw/block/fdc.c           |  5 +++--
>  hw/block/nvme.c          |  2 +-
>  hw/block/virtio-blk.c    |  2 +-
>  hw/block/xen-block.c     |  2 +-
>  hw/ide/qdev.c            |  2 +-
>  hw/scsi/scsi-disk.c      | 13 +++++++------
>  hw/scsi/scsi-generic.c   |  2 +-
>  hw/usb/dev-storage.c     |  2 +-
>  include/hw/block/block.h |  3 ++-
>  10 files changed, 24 insertions(+), 17 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--EgVrEAR5UttbsTXg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl1mSrkACgkQnKSrs4Gr
c8i1+gf+LHjKybBg3TFxY628Q1Xm0b8OlYQPwYBj+ICNxuiORH4VgGJdAPqhvBi0
Mrdy6fL98OmfMKu+Wo/FXGk2WQrkeW3zhkYJesLwNLc8/AlI6XueRv2onBHBeIA2
smdxPCxqkL1VODMI3zQYPkDKUXM0RmUG+JL7u64HUU0WvcijAnBcTiJzKro4yuNa
c041YeXDeARjaGcz0ReEabC2dDapEPEO3JiRDhBT5KmqCsCabUKNJKTuW8gr4w/9
lTT7x7cUwvDIvxUCQxMSxO5LYrpj16Qhk5QTn/4f9ZOn0aUlN5S+AvcFla+9ry5S
2A3rumFkx4opmTAL3sg0zOzDnlWajw==
=AAr3
-----END PGP SIGNATURE-----

--EgVrEAR5UttbsTXg--

