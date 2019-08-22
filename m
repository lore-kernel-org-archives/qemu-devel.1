Return-Path: <SRS0=BhOf=WS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0285CC3A5A1
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 14:51:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C2BFD233FD
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 14:51:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zsg1cacM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2BFD233FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44078 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0oR6-0005BJ-SV
	for qemu-devel@archiver.kernel.org; Thu, 22 Aug 2019 10:51:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36428)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@gmail.com>) id 1i0oO2-0002Pv-MZ
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 10:48:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1i0oO0-0005dn-O2
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 10:48:26 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:33304)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>)
 id 1i0oNw-0005cM-SQ; Thu, 22 Aug 2019 10:48:21 -0400
Received: by mail-wr1-x444.google.com with SMTP id u16so5733692wrr.0;
 Thu, 22 Aug 2019 07:48:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=3t0UCxRyMWHLNgHZZua9ouU2f52NrqWCdflIJCQ4x9Y=;
 b=Zsg1cacM7xZAIHuToWrZCQKqU/e+TK1rAd5nxEc+4EHP/LnzKffQaxRGO1PRCX3HlC
 uE7r4m7Yaq2C2xx4IxMGiD7FvealGjbVfwBeQo3Dl2D4Nwln3DFf/NfFEFI0/x3NwdBA
 p50smioLISi3gy558++YHL1NUmtDSSeWi+XcUXseLuCkBn/4T0sHLsJ6pawM1gQnRqGZ
 SndBLh6624z5R1VExhOWvfSX8ol8gDih16abB1u4Uck2LIIRgddI9/hsfaYfAkTgvZXq
 Y8qrWl6Vc9qEAKC8hs7cQZ+hC7+mmFKne89bjtMtLTPF+D/1dC5MZUJ1/l9R8eCD7XFf
 PwrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=3t0UCxRyMWHLNgHZZua9ouU2f52NrqWCdflIJCQ4x9Y=;
 b=jVK6cUPDHZAYFxIEh5qO7WitVLWk1iz3T5hIYoL/Kq74VZiANJ4NxC4lJ95H4BcliW
 /8JBOLi0oeaj7VAWsnhLyOWwTfgubodKRwlTKoh2nQQBgp+maPegREpWYFvEb27BVUdw
 wlGWDGM3j57N01rpt6Ed1VFYwK+8eUHOeL93A/5S6cL9x6IbtRq4tT4oWC3forEvApD9
 rePr+iVzm/0TS6TStYiZgmpAl12MxhI2yR2nv42bOiv68lB0EGGkAADqbc6vwqLoCFGZ
 Q10air4cb4/p/WsuZCEwXgZtgHe3f6RwuuuSK6azO9lXqpek/QAti60g72TGFbYAqzOX
 kiRA==
X-Gm-Message-State: APjAAAWwkyHRbq3rHVK/OImvuKSLgBpwKaO300RSXREhO5Hj6HxrTysR
 80qaAhOPIsxo6Q02HrLvE2w=
X-Google-Smtp-Source: APXvYqzFfG+HRvFxehcPU/83Ue/Aauvg7cz50GLsZktNr+Gm3q2MkhfIR06/b1tVGS8kzfqcuMhDTA==
X-Received: by 2002:adf:e846:: with SMTP id d6mr1255703wrn.263.1566485299749; 
 Thu, 22 Aug 2019 07:48:19 -0700 (PDT)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id d69sm4200169wmd.4.2019.08.22.07.48.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Aug 2019 07:48:18 -0700 (PDT)
Date: Thu, 22 Aug 2019 15:48:17 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <20190822144817.GA13952@stefanha-x1.localdomain>
References: <20190604161514.262241-1-vsementsov@virtuozzo.com>
 <20190729152400.GB21033@stefanha-x1.localdomain>
 <5936085a-a811-87ee-b1b2-0a12c3c745ec@virtuozzo.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="xHFwDpU9dbj6ez1V"
Content-Disposition: inline
In-Reply-To: <5936085a-a811-87ee-b1b2-0a12c3c745ec@virtuozzo.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v2 00/12] block: qiov_offset
 parameter for io
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
Cc: "fam@euphon.net" <fam@euphon.net>, "kwolf@redhat.com" <kwolf@redhat.com>,
 Denis Lunev <den@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "mreitz@redhat.com" <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--xHFwDpU9dbj6ez1V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 15, 2019 at 11:12:35AM +0000, Vladimir Sementsov-Ogievskiy wrot=
e:
> 29.07.2019 18:24, Stefan Hajnoczi wrote:
> > On Tue, Jun 04, 2019 at 07:15:02PM +0300, Vladimir Sementsov-Ogievskiy =
wrote:
> >> Hi all!
> >>
> >> Here is new parameter qiov_offset for io path, to avoid
> >> a lot of places with same pattern of creating local_qiov or hd_qiov
> >> variables.
> >>
> >> These series also includes my
> >> "[Qemu-devel] [PATCH 0/2] block/io: refactor padding"
> >> with some changes [described in 01 and 03 emails]
> >>
> >> Vladimir Sementsov-Ogievskiy (12):
> >>    util/iov: introduce qemu_iovec_init_extended
> >>    util/iov: improve qemu_iovec_is_zero
> >>    block/io: refactor padding
> >>    block: define .*_part io handlers in BlockDriver
> >>    block/io: bdrv_co_do_copy_on_readv: use and support qiov_offset
> >>    block/io: bdrv_co_do_copy_on_readv: lazy allocation
> >>    block/io: bdrv_aligned_preadv: use and support qiov_offset
> >>    block/io: bdrv_aligned_pwritev: use and support qiov_offset
> >>    block/io: introduce bdrv_co_p{read,write}v_part
> >>    block/qcow2: refactor qcow2_co_preadv to use buffer-based io
> >>    block/qcow2: implement .bdrv_co_preadv_part
> >>    block/qcow2: implement .bdrv_co_pwritev(_compressed)_part
> >>
> >>   block/qcow2.h             |   1 +
> >>   include/block/block_int.h |  21 ++
> >>   include/qemu/iov.h        |  10 +-
> >>   block/backup.c            |   2 +-
> >>   block/io.c                | 532 ++++++++++++++++++++++--------------=
--
> >>   block/qcow2-cluster.c     |  14 +-
> >>   block/qcow2.c             | 131 +++++-----
> >>   qemu-img.c                |   4 +-
> >>   util/iov.c                | 153 +++++++++--
> >>   9 files changed, 559 insertions(+), 309 deletions(-)
> >>
> >> --=20
> >> 2.18.0
> >=20
> > Thanks, applied to my block tree:
> > https://github.com/stefanha/qemu/commits/block
> >=20
> > Stefan
> >=20
>=20
> Could you please squash this into 01:
>=20
> diff --git a/util/iov.c b/util/iov.c
> index 0ed75e764c..5059e10431 100644
> --- a/util/iov.c
> +++ b/util/iov.c
> @@ -422,7 +422,7 @@ void qemu_iovec_init_extended(
>           void *tail_buf, size_t tail_len)
>   {
>       size_t mid_head, mid_tail;
> -    int total_niov, mid_niov;
> +    int total_niov, mid_niov =3D 0;
>       struct iovec *p, *mid_iov;
>=20
>       if (mid_len) {

Done.  Sending the pull request today.

Stefan

--xHFwDpU9dbj6ez1V
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl1eqzEACgkQnKSrs4Gr
c8jnyAf9FcFzYjo8XO87qUM29kiiSaWdFJ40Ri4wocFDfcPu/9lzh23ztlhKyGve
nwX6KXzEeDE/OzzRaUy6YFjX98JsgUOeFdlg9+KAnlf+qmFtIh7SWhnOjGvmcJuC
75bcgPhYfodDbRf1aXMMcwX/TVoB9ednPyntcvYZQ3JGB2zvJ8jtQf0nuE9S1oUX
Zc24t6V36KyLfLQg0wiHCt4uzl5UJ8WNF3GUuGMnNx2wj92ARDXv28Xz2sJKE+fZ
1xerVczMMIkcEvVmUy1p3WRQCK4BRePnPV2kSRtIkuD53B6MLQqQitrfQ6qOk3BK
9mwqzLD3RO9Ekw8o+8a6bTdvvn3msA==
=TBcm
-----END PGP SIGNATURE-----

--xHFwDpU9dbj6ez1V--

