Return-Path: <SRS0=IEfc=4J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61360C35646
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 15:18:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 25D46206EF
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 15:18:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OxDuygZI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25D46206EF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59596 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j5A4n-0008FC-8G
	for qemu-devel@archiver.kernel.org; Fri, 21 Feb 2020 10:18:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33283)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@gmail.com>) id 1j5A3x-0007M2-Tk
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 10:17:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1j5A3w-0002F7-4f
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 10:17:57 -0500
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:33427)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1j5A3v-0002Ec-R7
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 10:17:56 -0500
Received: by mail-wm1-x344.google.com with SMTP id m10so5404352wmc.0
 for <qemu-devel@nongnu.org>; Fri, 21 Feb 2020 07:17:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=WDehYQnO9cBRJejNVybQcQivMdxlGD5Ay4hdrdrMZ9o=;
 b=OxDuygZITukKKpFdcZqmlA7/aRdvVn2mxkWRglkpkLRMAavIzpngUgU/2lDTeMKIyj
 cAxNfRC/+nVexLg2Ir/ZKLWjEUVihRgjeCbgCLowpv669rT8F6rhf3KnNsg/jNv2Vi+H
 iun8b23d8em0lXnGNd8BnpSBIdr/CpXuY0UQ6YvcGpI4UeFtSuXuGVm+B/NHtEwCMHe7
 1dJ9xh+x9ZjIx9bKf7Gvh9DimuyHpS9R9p8ddIlKDRmJJNkeG1SLPJ8zhAHE+v3jLHXo
 8mo0DI45X1pJJUhmyYRcJZYGSSREF/KLJmdh+0+HdTr2OqWIPnxjG+eI2d3w+gcEJFOV
 J3tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=WDehYQnO9cBRJejNVybQcQivMdxlGD5Ay4hdrdrMZ9o=;
 b=uK+iWYKdbHshDiBdqpcM9QUdEdjTTU6WXRLmFSrr2Riwt2ZgrxJwhwCrsgOWxQH2qB
 P1dDsRyzcmcS4n8TPLhICMB2zCDuiG22ktlrexzk5d6+aHnT6osCCoRoA2oqsMgY+Dvb
 x3qxBouWSZ4/QUCN64XIEIMLtaJacc3jVDpGtcQ+mSqevMGASeRlO8CWtODuPMU2EXrF
 glqKS5L8M3bw1yAteCYB8lIFcaK4lZLSxZ37owjEAZq4ysyuuDkO5HLg+ch9aem7VJDC
 tZ4N6JDN0fNmbPAyxG8fKmy2U4KxR3pBP+PoDiwNHZ682BA6R6WxIZW0urJOQVW5Inr4
 BogQ==
X-Gm-Message-State: APjAAAXt78bq2llEhUO4UZW5YzfCeRYochJR2J6Ju+ldl7OTeEIq0ABF
 9YYQ4aGOIwP3HNq2En3IWFQ=
X-Google-Smtp-Source: APXvYqw7NS/FxbgRUF2rSuuSang3OEz5pRLABqruJbZ6f8X7fjF8X8DqR5U3Bveq2/7Y4pqIw8c9qg==
X-Received: by 2002:a1c:a752:: with SMTP id q79mr4253061wme.64.1582298273852; 
 Fri, 21 Feb 2020 07:17:53 -0800 (PST)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id e17sm4783713wrn.62.2020.02.21.07.17.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Feb 2020 07:17:53 -0800 (PST)
Date: Fri, 21 Feb 2020 15:17:51 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Alexander Bulekov <alxndr@bu.edu>
Subject: Re: [PATCH v10 00/22] Add virtual device fuzzing support
Message-ID: <20200221151751.GR1484511@stefanha-x1.localdomain>
References: <20200220041118.23264-1-alxndr@bu.edu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="CPn8Wy5ME997YUMW"
Content-Disposition: inline
In-Reply-To: <20200220041118.23264-1-alxndr@bu.edu>
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
Cc: pbonzini@redhat.com, bsd@redhat.com, qemu-devel@nongnu.org,
 stefanha@redhat.com, darren.kenny@oracle.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--CPn8Wy5ME997YUMW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 19, 2020 at 11:10:56PM -0500, Alexander Bulekov wrote:
> Hello,
>=20
> This series adds a framework for coverage-guided fuzzing of
> virtual-devices. Fuzzing targets are based on qtest and can make use of
> libqos. Fuzzing can help discover device bugs, such as
> assertion-failures, timeouts, and overflows, triggerable from within
> guests.
>=20
> V10:
>  * Update MAINTAINERS for vl.c, main.c and tests/qtest/fuzz
>  * Fix changes to checkpatch
>  * Fix typos in virtio-scsi fuzzer
>=20
> V9:
>  * Fix bug in the virtio-scsi fuzzer. Virtqueues were being kicked only
>    if free_head !=3D 0 (which it never was).
>  * Move vl.c and main.c into a new directory: softmmu/
>  * virtio-net-fuzz: refactor the looop over used descriptor.
>  * Improve comments for i440fx and virtio-scsi fuzzers.
>=20
> V8:
>  * Small fixes to the virtio-net.
>  * Keep rcu_atfork when not using qtest.
>=20
> V7:
>  * virtio-net: add virtio-net-check-used which waits for inputs on
>  the tx/ctrl vq by watching the used vring.
>  * virtio-net: add virtio-net-socket which uses the socket backend and can
>  exercise the rx components of virtio-net.
>  * virtio-net: add virtio-net-slirp which uses the user backend and exerc=
ises
>  slirp. This may lead to real traffic emitted by qemu so it is best to
>  run in an isolated network environment.
>  * build should succeed after each commit
>=20
> V5/V6:
>  * added virtio-scsi fuzzer
>  * add support for using fork-based fuzzers with multiple libfuzzer
>    workers
>  * misc fixes addressing V4 comments
>  * cleanup in-process handlers/globals in libqtest.c
>  * small fixes to fork-based fuzzing and support for multiple workers
>  * changes to the virtio-net fuzzer to kick after each vq add
>=20
> V4:
>  * add/transfer license headers to new files
>  * restructure the added QTestClientTransportOps struct
>  * restructure the FuzzTarget struct and fuzzer skeleton
>  * fork-based fuzzer now directly mmaps shm over the coverage bitmaps
>  * fixes to i440 and virtio-net fuzz targets
>  * undo the changes to qtest_memwrite
>  * possible to build /fuzz and /all in the same build-dir
>  * misc fixes to address V3 comments
>=20
> V3:
>  * rebased onto v4.1.0+
>  * add the fuzzer as a new build-target type in the build-system
>  * add indirection to qtest client/server communication functions
>  * remove ramfile and snapshot-based fuzzing support
>  * add i440fx fuzz-target as a reference for developers.
>  * add linker-script to assist with fork-based fuzzer
>=20
> V2:
>  * split off changes to qos virtio-net and qtest server to other patches
>  * move vl:main initialization into new func: qemu_init
>  * moved useful functions from qos-test.c to a separate object
>  * use struct of function pointers for add_fuzz_target(), instead of
>    arguments
>  * move ramfile to migration/qemu-file
>  * rewrite fork-based fuzzer pending patch to libfuzzer
>  * pass check-patch
>=20
> Alexander Bulekov (22):
>   softmmu: move vl.c to softmmu/
>   softmmu: split off vl.c:main() into main.c
>   module: check module wasn't already initialized
>   fuzz: add FUZZ_TARGET module type
>   qtest: add qtest_server_send abstraction
>   libqtest: add a layer of abstraction to send/recv
>   libqtest: make bufwrite rely on the TransportOps
>   qtest: add in-process incoming command handler
>   libqos: rename i2c_send and i2c_recv
>   libqos: split qos-test and libqos makefile vars
>   libqos: move useful qos-test funcs to qos_external
>   fuzz: add fuzzer skeleton
>   exec: keep ram block across fork when using qtest
>   main: keep rcu_atfork callback enabled for qtest
>   fuzz: support for fork-based fuzzing.
>   fuzz: add support for qos-assisted fuzz targets
>   fuzz: add target/fuzz makefile rules
>   fuzz: add configure flag --enable-fuzzing
>   fuzz: add i440fx fuzz targets
>   fuzz: add virtio-net fuzz target
>   fuzz: add virtio-scsi fuzz target
>   fuzz: add documentation to docs/devel/
>=20
>  MAINTAINERS                         |  11 +-
>  Makefile                            |  15 +-
>  Makefile.objs                       |   2 -
>  Makefile.target                     |  19 ++-
>  configure                           |  39 +++++
>  docs/devel/fuzzing.txt              | 116 ++++++++++++++
>  exec.c                              |  12 +-
>  include/qemu/module.h               |   4 +-
>  include/sysemu/qtest.h              |   4 +
>  include/sysemu/sysemu.h             |   4 +
>  qtest.c                             |  31 +++-
>  scripts/checkpatch.pl               |   2 +-
>  scripts/get_maintainer.pl           |   3 +-
>  softmmu/Makefile.objs               |   3 +
>  softmmu/main.c                      |  53 +++++++
>  vl.c =3D> softmmu/vl.c                |  48 +++---
>  tests/qtest/Makefile.include        |  72 ++++-----
>  tests/qtest/fuzz/Makefile.include   |  18 +++
>  tests/qtest/fuzz/fork_fuzz.c        |  55 +++++++
>  tests/qtest/fuzz/fork_fuzz.h        |  23 +++
>  tests/qtest/fuzz/fork_fuzz.ld       |  37 +++++
>  tests/qtest/fuzz/fuzz.c             | 179 +++++++++++++++++++++
>  tests/qtest/fuzz/fuzz.h             |  95 +++++++++++
>  tests/qtest/fuzz/i440fx_fuzz.c      | 193 +++++++++++++++++++++++
>  tests/qtest/fuzz/qos_fuzz.c         | 234 ++++++++++++++++++++++++++++
>  tests/qtest/fuzz/qos_fuzz.h         |  33 ++++
>  tests/qtest/fuzz/virtio_net_fuzz.c  | 198 +++++++++++++++++++++++
>  tests/qtest/fuzz/virtio_scsi_fuzz.c | 213 +++++++++++++++++++++++++
>  tests/qtest/libqos/i2c.c            |  10 +-
>  tests/qtest/libqos/i2c.h            |   4 +-
>  tests/qtest/libqos/qos_external.c   | 168 ++++++++++++++++++++
>  tests/qtest/libqos/qos_external.h   |  28 ++++
>  tests/qtest/libqtest.c              | 119 ++++++++++++--
>  tests/qtest/libqtest.h              |   4 +
>  tests/qtest/pca9552-test.c          |  10 +-
>  tests/qtest/qos-test.c              | 132 +---------------
>  util/module.c                       |   7 +
>  37 files changed, 1969 insertions(+), 229 deletions(-)
>  create mode 100644 docs/devel/fuzzing.txt
>  create mode 100644 softmmu/Makefile.objs
>  create mode 100644 softmmu/main.c
>  rename vl.c =3D> softmmu/vl.c (99%)
>  create mode 100644 tests/qtest/fuzz/Makefile.include
>  create mode 100644 tests/qtest/fuzz/fork_fuzz.c
>  create mode 100644 tests/qtest/fuzz/fork_fuzz.h
>  create mode 100644 tests/qtest/fuzz/fork_fuzz.ld
>  create mode 100644 tests/qtest/fuzz/fuzz.c
>  create mode 100644 tests/qtest/fuzz/fuzz.h
>  create mode 100644 tests/qtest/fuzz/i440fx_fuzz.c
>  create mode 100644 tests/qtest/fuzz/qos_fuzz.c
>  create mode 100644 tests/qtest/fuzz/qos_fuzz.h
>  create mode 100644 tests/qtest/fuzz/virtio_net_fuzz.c
>  create mode 100644 tests/qtest/fuzz/virtio_scsi_fuzz.c
>  create mode 100644 tests/qtest/libqos/qos_external.c
>  create mode 100644 tests/qtest/libqos/qos_external.h

Thomas Huth (tests/ maintainer) is away on leave and the device fuzzer
covers virtio-blk/scsi, so I will merge this.

Thanks, applied to my block tree:
https://github.com/stefanha/qemu/commits/block

Stefan

--CPn8Wy5ME997YUMW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl5P9J8ACgkQnKSrs4Gr
c8hCWwf/UKzyrqhJdcfVP+tP4BQdIDZ8u/FxjswWfDLPzXjFLj1+tM3vnkhLTVAV
uSi2w/5vdXawuRKCVeJRf0u5rZGGFbKOMcht3GK+8ke4RvRQU3nBb8Lcty8Y1Vxb
dzy6BLrlPHhiIWW0HIHqakKaaQ7J9Fu0AVkAJfQ9TAGuMqnnl5TfhVrXW7Q+RJQY
/UOnsAeQgsuRWtM9yxPUIThZpb58qgRFSOluTPisBmBV9wbFFdCyuY+5hihidXoh
3eYYW5IHMUa1N6K7z5w7p4i/cTNnJHHCenQpKFg6tnJBU96cGXDHpNh0D3dGTPCg
yvFTnD55KmpdXfQYIoVKiHyolxKKxw==
=+P1d
-----END PGP SIGNATURE-----

--CPn8Wy5ME997YUMW--

