Return-Path: <SRS0=3KIA=4V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 592E3C3F2D1
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2020 14:57:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 19A0520732
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2020 14:57:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X27MD7Q3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19A0520732
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35294 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9VSd-0008KK-5m
	for qemu-devel@archiver.kernel.org; Wed, 04 Mar 2020 09:57:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35260)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1j9VRu-0007pk-DQ
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 09:56:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1j9VRs-0006g0-IY
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 09:56:37 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:48083
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1j9VRs-0006fb-76
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 09:56:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583333795;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dMhlNvChTW9zAB9M1obZ6GdzhjzT2fgL9+a5XaNVyLQ=;
 b=X27MD7Q3LnH8U4ZCY8clppnS3LEwiVRn7yOjWrexOt8qaemeJLpN69BNoq5cz8RTFKKV5V
 lQlijt3Ga5T3WrcTq3GAp82pV4wHkexBVATgoAhThBnSujQ8Iz7uklJSaGZ7l9jdXpF1kW
 jhhQYMRoKmBpAOpotabllO2lf9bUalo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-334-DwzA9PmrPx2DwSPe_FlQ-Q-1; Wed, 04 Mar 2020 09:56:32 -0500
X-MC-Unique: DwzA9PmrPx2DwSPe_FlQ-Q-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 259B818A6EC3;
 Wed,  4 Mar 2020 14:56:31 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-129.ams2.redhat.com
 [10.36.116.129])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 67D0190CC3;
 Wed,  4 Mar 2020 14:56:29 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 05A0611386A6; Wed,  4 Mar 2020 15:56:28 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Denis Plotnikov <dplotnikov@virtuozzo.com>
Subject: Re: [PATCH v5 2/5] qcow2: introduce compression type feature
References: <20200304133538.9159-1-dplotnikov@virtuozzo.com>
 <20200304133538.9159-3-dplotnikov@virtuozzo.com>
Date: Wed, 04 Mar 2020 15:56:27 +0100
In-Reply-To: <20200304133538.9159-3-dplotnikov@virtuozzo.com> (Denis
 Plotnikov's message of "Wed, 4 Mar 2020 16:35:35 +0300")
Message-ID: <87d09si2xw.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, berto@igalia.com,
 qemu-block@nongnu.org, qemu-devel@nongnu.org, mreitz@redhat.com,
 den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Denis Plotnikov <dplotnikov@virtuozzo.com> writes:

> The patch adds some preparation parts for incompatible compression type
> feature to qcow2 allowing the use different compression methods for
> image clusters (de)compressing.
>
> It is implied that the compression type is set on the image creation and
> can be changed only later by image conversion, thus compression type
> defines the only compression algorithm used for the image, and thus,
> for all image clusters.
>
> The goal of the feature is to add support of other compression methods
> to qcow2. For example, ZSTD which is more effective on compression than Z=
LIB.
>
> The default compression is ZLIB. Images created with ZLIB compression typ=
e
> are backward compatible with older qemu versions.
>
> Adding of the compression type breaks a number of tests because now the
> compression type is reported on image creation and there are some changes
> in the qcow2 header in size and offsets.
>
> The tests are fixed in the following ways:
>     * filter out compression_type for all the tests
>     * fix header size, feature table size and backing file offset
>       affected tests: 031, 036, 061, 080
>       header_size +=3D8: 1 byte compression type
>                        7 bytes padding
>       feature_table +=3D 48: incompatible feture compression type
>       backing_file_offset +=3D 56 (8 + 48 -> header_change + fature_table=
_change)
>     * add "compression type" for test output matching when it isn't filte=
red
>       affected tests: 049, 060, 061, 065, 144, 182, 242, 255
>
> Signed-off-by: Denis Plotnikov <dplotnikov@virtuozzo.com>
> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  qapi/block-core.json             |  22 ++++++-
>  block/qcow2.h                    |  18 +++++-
>  include/block/block_int.h        |   1 +
>  block/qcow2.c                    | 101 ++++++++++++++++++++++++++++++
>  tests/qemu-iotests/031.out       |  14 ++---
>  tests/qemu-iotests/036.out       |   4 +-
>  tests/qemu-iotests/049.out       | 102 +++++++++++++++----------------
>  tests/qemu-iotests/060.out       |   1 +
>  tests/qemu-iotests/061.out       |  34 ++++++-----
>  tests/qemu-iotests/065           |  28 ++++++---
>  tests/qemu-iotests/080           |   2 +-
>  tests/qemu-iotests/144.out       |   4 +-
>  tests/qemu-iotests/182.out       |   2 +-
>  tests/qemu-iotests/242.out       |   5 ++
>  tests/qemu-iotests/255.out       |   8 +--
>  tests/qemu-iotests/common.filter |   3 +-
>  16 files changed, 253 insertions(+), 96 deletions(-)
>
> diff --git a/qapi/block-core.json b/qapi/block-core.json
> index 85e27bb61f..a67eb8bff4 100644
> --- a/qapi/block-core.json
> +++ b/qapi/block-core.json
> @@ -78,6 +78,8 @@
>  #
>  # @bitmaps: A list of qcow2 bitmap details (since 4.0)
>  #
> +# @compression-type: the image cluster compression method (since 5.0)
> +#
>  # Since: 1.7
>  ##
>  { 'struct': 'ImageInfoSpecificQCow2',
> @@ -89,7 +91,8 @@
>        '*corrupt': 'bool',
>        'refcount-bits': 'int',
>        '*encrypt': 'ImageInfoSpecificQCow2Encryption',
> -      '*bitmaps': ['Qcow2BitmapInfo']
> +      '*bitmaps': ['Qcow2BitmapInfo'],
> +      'compression-type': 'Qcow2CompressionType'
>    } }
> =20
>  ##
> @@ -4392,6 +4395,18 @@
>    'data': [ 'v2', 'v3' ] }
> =20
> =20
> +##
> +# @Qcow2CompressionType:
> +#
> +# Compression type used in qcow2 image file
> +#
> +# @zlib:  zlib compression, see <http://zlib.net/>
> +#
> +# Since: 5.0
> +##
> +{ 'enum': 'Qcow2CompressionType',
> +  'data': [ 'zlib' ] }
> +
>  ##
>  # @BlockdevCreateOptionsQcow2:
>  #
> @@ -4415,6 +4430,8 @@
>  #                 allowed values: off, falloc, full, metadata)
>  # @lazy-refcounts: True if refcounts may be updated lazily (default: off=
)
>  # @refcount-bits: Width of reference counts in bits (default: 16)
> +# @compression-type: The image cluster compression method
> +#                    (default: zlib, since 5.0)
>  #
>  # Since: 2.12
>  ##
> @@ -4430,7 +4447,8 @@
>              '*cluster-size':    'size',
>              '*preallocation':   'PreallocMode',
>              '*lazy-refcounts':  'bool',
> -            '*refcount-bits':   'int' } }
> +            '*refcount-bits':   'int',
> +            '*compression-type':'Qcow2CompressionType' } }
> =20
>  ##
>  # @BlockdevCreateOptionsQed:
[...]

QAPI part:
Acked-by: Markus Armbruster <armbru@redhat.com>


