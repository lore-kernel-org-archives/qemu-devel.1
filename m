Return-Path: <SRS0=1YIe=ZE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 527A0C43331
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2019 16:08:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D706214E0
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2019 16:08:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BblIpJm8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D706214E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37158 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iUYii-0008Ah-Pu
	for qemu-devel@archiver.kernel.org; Tue, 12 Nov 2019 11:08:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50566)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pkrempa@redhat.com>) id 1iUYhc-0006tQ-N7
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 11:07:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pkrempa@redhat.com>) id 1iUYhb-0000ch-8u
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 11:07:36 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:60937
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pkrempa@redhat.com>) id 1iUYhb-0000bu-3n
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 11:07:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573574854;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4oOB2ggRZJk7OJKiTCYznI5HKAK/lgPZDPGYp0Psjzc=;
 b=BblIpJm8bidg7SgjDh23rq7r2m1fECwwWBYu6Cw6LNUcn+iyu2/pLBA3+fU+7Ufa9eCeT9
 cIkxyQHTm0ZuP+Ke4Ih2qwKAV0lHijYW+whZ58AiUOgM4UvKgwDJ+qwx6GXycUzvLTLS7a
 hG6Tya12s4AIc2aZLk7gUIfLMhTJpdk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-236-6ROENHTMMSelwjjX7A5csg-1; Tue, 12 Nov 2019 11:07:33 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EB73C107B7DD;
 Tue, 12 Nov 2019 16:07:31 +0000 (UTC)
Received: from angien.pipo.sk (unknown [10.43.2.48])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 90BA4101E815;
 Tue, 12 Nov 2019 16:07:28 +0000 (UTC)
Date: Tue, 12 Nov 2019 17:07:26 +0100
From: Peter Krempa <pkrempa@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Subject: Re: [PATCH 2/2] iotests: Test multiple blockdev-snapshot calls
Message-ID: <20191112160726.GC163480@angien.pipo.sk>
References: <20191108085312.27049-1-kwolf@redhat.com>
 <20191108085312.27049-3-kwolf@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20191108085312.27049-3-kwolf@redhat.com>
X-PGP-Key-ID: 0xD018682B
X-PGP-Key-Fingerprint: D294 FF38 A6A2 BF40 6C75  5DEF 36EC 16AC D018 682B
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: 6ROENHTMMSelwjjX7A5csg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Nov 08, 2019 at 09:53:12 +0100, Kevin Wolf wrote:
> Test that doing a second blockdev-snapshot doesn't make the first
> overlay's backing file go away.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  tests/qemu-iotests/273     |  76 +++++++++
>  tests/qemu-iotests/273.out | 337 +++++++++++++++++++++++++++++++++++++
>  tests/qemu-iotests/group   |   1 +
>  3 files changed, 414 insertions(+)
>  create mode 100755 tests/qemu-iotests/273
>  create mode 100644 tests/qemu-iotests/273.out

Didn't apply cleanly for me.

>=20
> diff --git a/tests/qemu-iotests/273 b/tests/qemu-iotests/273
> new file mode 100755
> index 0000000000..60076de7ce
> --- /dev/null
> +++ b/tests/qemu-iotests/273
> @@ -0,0 +1,76 @@
> +#!/usr/bin/env bash
> +#
> +# Test large write to a qcow2 image

Cut&paste?


Rest looks good

Reviewed-by: Peter Krempa <pkrempa@redhat.com>

> +#
> +# Copyright (C) 2019 Red Hat, Inc.
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
> +seq=3D$(basename "$0")
> +echo "QA output created by $seq"
> +
> +status=3D1=09# failure is the default!
> +
> +_cleanup()
> +{
> +    _cleanup_test_img
> +}
> +trap "_cleanup; exit \$status" 0 1 2 3 15
> +
> +# get standard environment, filters and checks
> +. ./common.rc
> +. ./common.filter
> +
> +# This is a qcow2 regression test
> +_supported_fmt qcow2
> +_supported_proto file
> +_supported_os Linux
> +
> +do_run_qemu()
> +{
> +    echo Testing: "$@"
> +    $QEMU -nographic -qmp-pretty stdio -nodefaults "$@"

-qmp-pretty, that's useful

> +    echo
> +}
> +
> +run_qemu()
> +{
> +    do_run_qemu "$@" 2>&1 | _filter_testdir | _filter_qemu | _filter_qmp=
 |
> +        _filter_generated_node_ids | _filter_imgfmt | _filter_actual_ima=
ge_size
> +}
> +
> +TEST_IMG=3D"$TEST_IMG.base" _make_test_img 64M
> +TEST_IMG=3D"$TEST_IMG.mid" _make_test_img -b "$TEST_IMG.base"
> +_make_test_img -b "$TEST_IMG.mid"
> +
> +run_qemu \
> +    -blockdev file,node-name=3Dbase,filename=3D"$TEST_IMG.base" \
> +     -blockdev file,node-name=3Dmidf,filename=3D"$TEST_IMG.mid" \
> +     -blockdev '{"driver":"qcow2","node-name":"mid","file":"midf","backi=
ng":null}' \
> +     -blockdev file,node-name=3Dtopf,filename=3D"$TEST_IMG" \
> +     -blockdev '{"driver":"qcow2","file":"topf","node-name":"top","backi=
ng":null}' \
> +<<EOF
> +{"execute":"qmp_capabilities"}
> +{"execute":"blockdev-snapshot","arguments":{"node":"base","overlay":"mid=
"}}
> +{"execute":"blockdev-snapshot","arguments":{"node":"mid","overlay":"top"=
}}
> +{"execute":"query-named-block-nodes"}
> +{"execute":"x-debug-query-block-graph"}

Oh, this too!

> +{"execute":"quit"}
> +EOF
> +
> +# success, all done
> +echo "*** done"
> +rm -f $seq.full
> +status=3D0


