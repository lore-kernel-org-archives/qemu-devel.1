Return-Path: <SRS0=1jZz=6T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FA7CC47256
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 07:37:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE13920663
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 07:37:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C7KsGfe+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE13920663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43922 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVs8T-00032B-1n
	for qemu-devel@archiver.kernel.org; Tue, 05 May 2020 03:37:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51704)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jVs7S-0001n4-Ae
 for qemu-devel@nongnu.org; Tue, 05 May 2020 03:35:58 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:23148
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jVs7Q-0005SH-Dg
 for qemu-devel@nongnu.org; Tue, 05 May 2020 03:35:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588664154;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dk6joryfLMUt1u8O/3LCoo8IvM11JO10lsE771xWXM8=;
 b=C7KsGfe+7Mfclq9DXwLiFo9z4LYNFHwZJJ+RFsqmCig0S4KOJWEYtl4PEFhM0ARSQd6VHY
 MjdCgrJtEbHB+jsx57rVTrtGycIq7lAsSfPpEIYFJI5925oXPGQbyCDMhey71XB0z+phXZ
 uN8HIcozINgcEK+A9kpn8/Ncdc+b3PM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-218-uObyAx3cNFGd77xDn-Kq7A-1; Tue, 05 May 2020 03:35:50 -0400
X-MC-Unique: uObyAx3cNFGd77xDn-Kq7A-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E95FD8015D1;
 Tue,  5 May 2020 07:35:49 +0000 (UTC)
Received: from linux.fritz.box (ovpn-112-11.ams2.redhat.com [10.36.112.11])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E4E7A7054A;
 Tue,  5 May 2020 07:35:43 +0000 (UTC)
Date: Tue, 5 May 2020 09:35:42 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH v5 3/7] qcow: Tolerate backing_fmt=, but warn on
 backing_fmt=raw
Message-ID: <20200505073542.GA5759@linux.fritz.box>
References: <20200403175859.863248-1-eblake@redhat.com>
 <20200403175859.863248-4-eblake@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200403175859.863248-4-eblake@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/05 00:37:40
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: pkrempa@redhat.com, qemu-block@nongnu.org, kchamart@redhat.com,
 libvir-list@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 03.04.2020 um 19:58 hat Eric Blake geschrieben:
> qcow has no space in the metadata to store a backing format, and there
> are existing qcow images backed both by raw or by other formats
> (usually qcow) images, reliant on probing to tell the difference.
> While we don't recommend the creation of new qcow images (as qcow2 is
> hands-down better), we can at least insist that if the user does
> request a specific format without using -u, then it must be non-raw
> (as a raw backing file that gets inadvertently edited into some other
> format can form a security hole); if the user does not request a
> specific format or lies when using -u, then the status quo of probing
> for the backing format remains intact (although an upcoming patch will
> warn when omitting a format request).  Thus, when this series is
> complete, the only way to use a backing file for qcow without
> triggering a warning is when using -F if the backing file is non-raw
> to begin with.  Note that this is only for QemuOpts usage; there is no
> change to the QAPI to allow a format through -blockdev.
>=20
> Add a new iotest 290 just for qcow, to demonstrate the new warning.
>=20
> Signed-off-by: Eric Blake <eblake@redhat.com>

Somehow this feels backwards. Not specifying the backing file format at
all isn't any safer than explicitly specifying raw.

If there is a difference at all, I would say that explicitly specifying
raw means that the user is aware what they are doing. So we would have
more reason to warn against raw images if the backing format isn't
specified at all because then the user might not be aware that they are
using a backing file that probes as raw.

>  block/qcow.c               | 16 ++++++++-
>  tests/qemu-iotests/290     | 72 ++++++++++++++++++++++++++++++++++++++
>  tests/qemu-iotests/290.out | 42 ++++++++++++++++++++++
>  tests/qemu-iotests/group   |  1 +
>  4 files changed, 130 insertions(+), 1 deletion(-)
>  create mode 100755 tests/qemu-iotests/290
>  create mode 100644 tests/qemu-iotests/290.out
>=20
> diff --git a/block/qcow.c b/block/qcow.c
> index 8973e4e565a1..bbe48b7db4d7 100644
> --- a/block/qcow.c
> +++ b/block/qcow.c
> @@ -940,11 +940,12 @@ static int coroutine_fn qcow_co_create_opts(BlockDr=
iver *drv,
>  {
>      BlockdevCreateOptions *create_options =3D NULL;
>      BlockDriverState *bs =3D NULL;
> -    QDict *qdict;
> +    QDict *qdict =3D NULL;
>      Visitor *v;
>      const char *val;
>      Error *local_err =3D NULL;
>      int ret;
> +    char *backing_fmt;
>=20
>      static const QDictRenames opt_renames[] =3D {
>          { BLOCK_OPT_BACKING_FILE,       "backing-file" },
> @@ -953,6 +954,13 @@ static int coroutine_fn qcow_co_create_opts(BlockDri=
ver *drv,
>      };
>=20
>      /* Parse options and convert legacy syntax */
> +    backing_fmt =3D qemu_opt_get_del(opts, BLOCK_OPT_BACKING_FMT);
> +    if (backing_fmt && !strcmp(backing_fmt, "raw")) {
> +        error_setg(errp, "qcow cannot store backing format; an explicit =
"
> +                   "backing format of raw is unsafe");

Does this message tell that an implicit backing format of raw is safe?

> +        ret =3D -EINVAL;
> +        goto fail;
> +    }

The commit message promises a warning. This is not a warning, but a hard
error.

>      qdict =3D qemu_opts_to_qdict_filtered(opts, NULL, &qcow_create_opts,=
 true);
>=20
>      val =3D qdict_get_try_str(qdict, BLOCK_OPT_ENCRYPT);
> @@ -1018,6 +1026,7 @@ static int coroutine_fn qcow_co_create_opts(BlockDr=
iver *drv,
>=20
>      ret =3D 0;
>  fail:
> +    g_free(backing_fmt);
>      qobject_unref(qdict);
>      bdrv_unref(bs);
>      qapi_free_BlockdevCreateOptions(create_options);
> @@ -1152,6 +1161,11 @@ static QemuOptsList qcow_create_opts =3D {
>              .type =3D QEMU_OPT_STRING,
>              .help =3D "File name of a base image"
>          },
> +        {
> +            .name =3D BLOCK_OPT_BACKING_FMT,
> +            .type =3D QEMU_OPT_STRING,
> +            .help =3D "Format of the backing image (caution: raw backing=
 is unsafe)",
> +        },
>          {
>              .name =3D BLOCK_OPT_ENCRYPT,
>              .type =3D QEMU_OPT_BOOL,
> diff --git a/tests/qemu-iotests/290 b/tests/qemu-iotests/290
> new file mode 100755
> index 000000000000..8482de58cb4b
> --- /dev/null
> +++ b/tests/qemu-iotests/290
> @@ -0,0 +1,72 @@
> +#!/usr/bin/env bash
> +#
> +# Test qcow backing file warnings
> +#
> +# Copyright (C) 2020 Red Hat, Inc.
> +#
> +# This program is free software; you can redistribute it and/or modify
> +# it under the terms of the GNU General Public License as published by
> +# the Free Software Foundation; either version 2 of the License, or
> +# (at your option) any later version.
> +#
> +# This program is distributed in the hope that it will be useful,
> +# but WITHOUT ANY WARRANTY; without even the implied warranty of
> +# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> +# GNU General Public License for more details.
> +#
> +# You should have received a copy of the GNU General Public License
> +# along with this program.  If not, see <http://www.gnu.org/licenses/>.
> +#
> +
> +seq=3D`basename $0`
> +echo "QA output created by $seq"
> +
> +status=3D1=09# failure is the default!
> +
> +_cleanup()
> +{
> +=09_cleanup_test_img
> +}
> +trap "_cleanup; exit \$status" 0 1 2 3 15
> +
> +# get standard environment, filters and checks
> +. ./common.rc
> +. ./common.filter
> +
> +_supported_fmt qcow
> +_supported_proto file
> +_supported_os Linux
> +
> +size=3D128M
> +
> +echo
> +echo "=3D=3D qcow backed by qcow =3D=3D"
> +
> +TEST_IMG=3D"$TEST_IMG.base" _make_test_img $size
> +_make_test_img -b "$TEST_IMG.base"
> +_img_info
> +_make_test_img -b "$TEST_IMG.base" -F $IMGFMT
> +_img_info
> +
> +echo
> +echo "=3D=3D mismatched command line detection =3D=3D"
> +
> +_make_test_img -b "$TEST_IMG.base" -F vmdk
> +# Use of -u bypasses the backing format sanity check
> +_make_test_img -u -b "$TEST_IMG.base" -F vmdk $size
> +_img_info
> +
> +echo
> +echo "=3D=3D qcow backed by raw =3D=3D"
> +
> +rm "$TEST_IMG.base"
> +truncate --size=3D$size "$TEST_IMG.base"
> +_make_test_img -b "$TEST_IMG.base"
> +_img_info
> +_make_test_img -b "$TEST_IMG.base" -F raw
> +_img_info

This test doesn't tell the difference between a warning and an error. In
both cases, the image would look the same: Either because it was
successfully created or because the old version is still there.

Kevin


