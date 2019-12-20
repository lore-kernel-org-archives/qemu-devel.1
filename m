Return-Path: <SRS0=uEni=2K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB5B5C43603
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 10:10:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 969192467F
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 10:10:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sPF74auD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 969192467F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52614 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iiFEr-0004We-9C
	for qemu-devel@archiver.kernel.org; Fri, 20 Dec 2019 05:10:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58959)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@gmail.com>) id 1iiFDP-0003C8-T3
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 05:09:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1iiFDM-0005lL-BQ
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 05:08:58 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:33008)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>)
 id 1iiFDG-0005ed-Mj; Fri, 20 Dec 2019 05:08:50 -0500
Received: by mail-wm1-x341.google.com with SMTP id d139so9084338wmd.0;
 Fri, 20 Dec 2019 02:08:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=rtZBsVLSBYCjk374CX2DLP4U49cbg04HyjEssp7XZU8=;
 b=sPF74auDr8qlPAb4o7t4vonHtknb/Mv4fiXUOkV61bXOv1rWWY7sYxf4sE47Z4dWKz
 4q81Og67I6RrImrKWFIcgZIYVzL/l+ihyjZjIitCEYZhrfENPmFLkZqVm37+CokbYAz8
 PCYAm+i4LFu+SkeFZ3VKgUsB5VLyh8TtK+IfYiTHS9EZ7+QUydjb9Nj5PMyL6jO//UYS
 S6Wi9My+fa0ChS+7CAT2SNrF5KIyOK4YK1nA01NMD68WkhxKgMn6bRVPjvBmeF76RjWF
 6H5W37rnZSLa/yFupPO2QHjIA90G8RpxvVRPnEP+upz6ighD8A23v/4ZIqCltxO+yBne
 sygg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=rtZBsVLSBYCjk374CX2DLP4U49cbg04HyjEssp7XZU8=;
 b=kbU9VvMAV/DXsngvwkD4LHSX8xp/RJB8hWwOyFl2rKR/lOKmZXkjf0PNRDzGAGMoaS
 kuVh8HcneYMldxCJwXX8g/VtCFXfXQRUtzQBGsATmUnBnTeg2Gq4xX4Z3GU8MQceRcBE
 ZCbMYr22PXHxwGO04kr8gkXpmJYCV9yZ1+KdDK3+/PfO0u0oSzjdWDdpbaHcGDIRKYsg
 zz70LRFB6eopF89S69fpBBhpY8QJR180eUI7J5XTxZ39DGZ0yWkTqblR7oFq5OeuLgIW
 KjBaI2eSHwuwM+BzjPDobdK9qXLJsyzcxnuF5m8ihl1b1WbRVu56Ea9IHl8zrMrob+pk
 TrdQ==
X-Gm-Message-State: APjAAAUur6xoJiDF1DUIXtdCj+zPwAAZ0zMGMCvGvz7dGoI8Duz08+qn
 WfTbLhJJDc0CRe1gRn0ZJAQ=
X-Google-Smtp-Source: APXvYqx60LLMnltYtpeHzScdIiU0A7Rtdz22tUwV3sOECaI3UrmqVn+RoDGvlOYDUFcZncoZSjn3Pw==
X-Received: by 2002:a05:600c:21ce:: with SMTP id
 x14mr14490064wmj.120.1576836528641; 
 Fri, 20 Dec 2019 02:08:48 -0800 (PST)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id z6sm9486010wrw.36.2019.12.20.02.08.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Dec 2019 02:08:47 -0800 (PST)
Date: Fri, 20 Dec 2019 10:08:46 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Max Reitz <mreitz@redhat.com>
Subject: Re: [PATCH 00/18] block: Allow exporting BDSs via FUSE
Message-ID: <20191220100846.GC1635864@stefanha-x1.localdomain>
References: <20191219143818.1646168-1-mreitz@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="w7PDEPdKQumQfZlR"
Content-Disposition: inline
In-Reply-To: <20191219143818.1646168-1-mreitz@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
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


--w7PDEPdKQumQfZlR
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 19, 2019 at 03:38:00PM +0100, Max Reitz wrote:
> Preamble: This series is based on a combination of my (current) block
> branch and =E2=80=9Ciotests: Minor fixes=E2=80=9D.  I=E2=80=99ve pushed i=
t here:
>=20
>   https://git.xanclic.moe/XanClic/qemu fuse-exports-v1
>=20
> (The base is on fuse-exports-v1-base.)
>=20
>=20
> Hi,
>=20
> Ever since I found out that you can mount FUSE filesystems on regular
> files (not just directories), I had the idea of adding FUSE block
> exports to qemu where you can export block nodes as raw images.  The
> best thing is that you=E2=80=99d be able to mount an image on itself, so
> whatever format it may be in, qemu lets it appear as a raw image (and
> you can then use regular tools like dd on it).
>=20
> I started with some concept of a qemu-blkfuse daemon (similar to
> qemu-nbd), but never sent patches, for two reasons: (1) Performance was
> not good, (2) it didn=E2=80=99t seem right, for some reason.
>=20
> Now Kevin is proposing a storage daemon for multiple export types like
> NBD, and he also mentioned FUSE (while knowing of my previous attempts).
> Now it does seem right to add FUSE exports to qemu, but only in the form
> of some module with a proper QAPI/QMP binding.
>=20
> Performance is still quite bad, but who cares.  We can always improve
> it, if the need arises.
>=20
>=20
> This series does the following:
>=20
> First, add the FUSE export module (block/fuse.c) that implements the
> basic file access functions.  (Note that you need libfuse 3.8.0 or later
> for SEEK_HOLE/SEEK_DATA.)
>=20
> Second, it allows using FUSE exports as a protocol in the iotests and
> makes many iotests work with it.  (The file node is exported by a
> background qemu instance to $SOCK_DIR.)
> Note that I only ran raw and qcow2 on it; I=E2=80=99m sure other formats
> currently have some failing tests.
>=20
> This gives us a lot of coverage for, well, not free (it does take ten
> patches), but for cheap; but there are still some more specialized
> things we want to test, so third and last, this series adds an iotest
> dedicated to FUSE exports.
>=20
>=20
> Final rather important notice: I didn=E2=80=99t really run the iotests wi=
th this
> yet.  I wanted to, but they appear rather broken on current master,
> actually.  I=E2=80=99m not yet sure whether that=E2=80=99s because someth=
ing in my setup
> broke in the last two weeks, or because there=E2=80=99s quite something b=
roken
> in master (it does look like there are a couple things broken in master
> currently).
>=20
>=20
> Max Reitz (18):
>   configure: Detect libfuse
>   fuse: Allow exporting BDSs via FUSE
>   fuse: Implement standard FUSE operations
>   fuse: Add fuse-export-remove
>   fuse: Allow growable exports
>   fuse: (Partially) implement fallocate()
>   fuse: Implement hole detection through lseek
>   iotests: Do not needlessly filter _make_test_img
>   iotests: Do not pipe _make_test_img
>   iotests: Use convert -n in some cases
>   iotests: Avoid renaming images
>   iotests: Derive image names from $TEST_IMG
>   iotests/091: Use _cleanup_qemu instad of "wait"
>   iotests: Restrict some Python tests to file
>   iotests: Let _make_test_img guess $TEST_IMG_FILE
>   iotests: Allow testing FUSE exports
>   iotests: Enable fuse for many tests
>   iotests/281: Add test for FUSE exports
>=20
>  block.c                          |   4 +
>  block/Makefile.objs              |   3 +
>  block/fuse.c                     | 668 +++++++++++++++++++++++++++++++
>  configure                        |  68 ++++
>  include/block/fuse.h             |  24 ++
>  qapi/block.json                  |  42 ++
>  tests/qemu-iotests/013           |   9 +-
>  tests/qemu-iotests/013.out       |   3 +-
>  tests/qemu-iotests/018           |   5 +-
>  tests/qemu-iotests/018.out       |   1 +
>  tests/qemu-iotests/020           |   2 +-
>  tests/qemu-iotests/025           |   2 +-
>  tests/qemu-iotests/026           |   2 +-
>  tests/qemu-iotests/028           |  16 +-
>  tests/qemu-iotests/028.out       |   3 +
>  tests/qemu-iotests/031           |   2 +-
>  tests/qemu-iotests/034           |   2 +-
>  tests/qemu-iotests/036           |   2 +-
>  tests/qemu-iotests/037           |   2 +-
>  tests/qemu-iotests/038           |   2 +-
>  tests/qemu-iotests/039           |   2 +-
>  tests/qemu-iotests/046           |   7 +-
>  tests/qemu-iotests/046.out       |   2 +-
>  tests/qemu-iotests/050           |   2 +-
>  tests/qemu-iotests/054           |   2 +-
>  tests/qemu-iotests/060           |   2 +-
>  tests/qemu-iotests/071           |  21 +-
>  tests/qemu-iotests/072           |   5 +-
>  tests/qemu-iotests/072.out       |   1 +
>  tests/qemu-iotests/079           |   2 +-
>  tests/qemu-iotests/080           |   2 +-
>  tests/qemu-iotests/089           |   5 +-
>  tests/qemu-iotests/089.out       |   1 +
>  tests/qemu-iotests/090           |   2 +-
>  tests/qemu-iotests/091           |   5 +-
>  tests/qemu-iotests/095           |   2 +-
>  tests/qemu-iotests/097           |   2 +-
>  tests/qemu-iotests/098           |   2 +-
>  tests/qemu-iotests/102           |   2 +-
>  tests/qemu-iotests/103           |   2 +-
>  tests/qemu-iotests/106           |   2 +-
>  tests/qemu-iotests/107           |   2 +-
>  tests/qemu-iotests/108           |   2 +-
>  tests/qemu-iotests/111           |   2 +-
>  tests/qemu-iotests/112           |   2 +-
>  tests/qemu-iotests/115           |   2 +-
>  tests/qemu-iotests/117           |   2 +-
>  tests/qemu-iotests/120           |   2 +-
>  tests/qemu-iotests/121           |   2 +-
>  tests/qemu-iotests/127           |   2 +-
>  tests/qemu-iotests/133           |   2 +-
>  tests/qemu-iotests/137           |   2 +-
>  tests/qemu-iotests/138           |   2 +-
>  tests/qemu-iotests/140           |   2 +-
>  tests/qemu-iotests/154           |   2 +-
>  tests/qemu-iotests/161           |  14 +-
>  tests/qemu-iotests/171           |   2 +-
>  tests/qemu-iotests/174           |  10 +-
>  tests/qemu-iotests/175           |   8 +-
>  tests/qemu-iotests/176           |   2 +-
>  tests/qemu-iotests/177           |   2 +-
>  tests/qemu-iotests/179           |   2 +-
>  tests/qemu-iotests/183           |   2 +-
>  tests/qemu-iotests/186           |   2 +-
>  tests/qemu-iotests/187           |   2 +-
>  tests/qemu-iotests/191           |   2 +-
>  tests/qemu-iotests/195           |   2 +-
>  tests/qemu-iotests/200           |   5 +-
>  tests/qemu-iotests/200.out       |   4 +-
>  tests/qemu-iotests/204           |   2 +-
>  tests/qemu-iotests/206           |   1 +
>  tests/qemu-iotests/214           |   2 +-
>  tests/qemu-iotests/217           |   2 +-
>  tests/qemu-iotests/220           |   2 +-
>  tests/qemu-iotests/221           |   2 +-
>  tests/qemu-iotests/229           |   5 +-
>  tests/qemu-iotests/229.out       |   6 +-
>  tests/qemu-iotests/242           |   1 +
>  tests/qemu-iotests/247           |   2 +-
>  tests/qemu-iotests/249           |   8 +-
>  tests/qemu-iotests/250           |   2 +-
>  tests/qemu-iotests/252           |   2 +-
>  tests/qemu-iotests/265           |   2 +-
>  tests/qemu-iotests/268           |   2 +-
>  tests/qemu-iotests/272           |   2 +-
>  tests/qemu-iotests/273           |   2 +-
>  tests/qemu-iotests/279           |   2 +-
>  tests/qemu-iotests/281           | 328 +++++++++++++++
>  tests/qemu-iotests/281.out       |  92 +++++
>  tests/qemu-iotests/check         |   6 +
>  tests/qemu-iotests/common.filter |   5 +-
>  tests/qemu-iotests/common.rc     | 190 ++++++++-
>  tests/qemu-iotests/group         |   1 +
>  93 files changed, 1571 insertions(+), 120 deletions(-)
>  create mode 100644 block/fuse.c
>  create mode 100644 include/block/fuse.h
>  create mode 100755 tests/qemu-iotests/281
>  create mode 100644 tests/qemu-iotests/281.out

A lot of qemu-iotests changes but the actual FUSE code is small and well
worth it for the flexibility and convenience that this feature brings.
Nice!

Please send a follow-up patch that adds a qemu(1) -blockdev
'Driver-specific options for "fuse"' documentation section.

Acked-by: Stefan Hajnoczi <stefanha@redhat.com>

--w7PDEPdKQumQfZlR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl38na4ACgkQnKSrs4Gr
c8hh9gf/SBnEDz1vTAXqZhl7/pqpg6HKvNI/N3tB7GJww6pIh51oflsnL3qQLCWY
ajeRKwuoz6bEmmnp8XGojGj39fY06V2jEKcDpRyvSV7Wx2jcFqFqRzcxPwp3gn5H
dWPWefPRrBzmLt7CqdHfjgAWJ4eCICkvwO8QA29z8mf2m9LUQx6qNEPuz2rc4I79
lvmSYOBKz6MzYzXbXTH48URzAYrfq92h25khJ0cDRr7vXX2H0eM6Z6sB2bN+t0hQ
ez37/tB8O6qh4shwfb8X/AH006SZRLym4PhkfNo64vuLJ59wFI3hl7clJ5SCo79A
AL+Zq6oKPr1YC5hJw33Kspmo6YxYaA==
=qIti
-----END PGP SIGNATURE-----

--w7PDEPdKQumQfZlR--

