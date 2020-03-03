Return-Path: <SRS0=3Wv1=4U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 939A1C3F2C6
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 14:43:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C7BB20842
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 14:43:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aNWQU0qk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C7BB20842
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48258 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j98lk-0001g0-KB
	for qemu-devel@archiver.kernel.org; Tue, 03 Mar 2020 09:43:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38198)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1j98jZ-0000in-GJ
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 09:41:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1j98jX-0006Qc-RW
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 09:41:21 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:25760
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1j98jX-0006Oj-Gg
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 09:41:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583246476;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/V+ogDNCn7ZHL7gzwvFYWd0TIRyJOcHFyw7zoBLJimQ=;
 b=aNWQU0qkRQYCqWHqBuL/MVZbWD0eE71Or0QruBZn7vA79ccxiteROuZ8jl3Fuu25Jx0OhS
 1jCNA7z56sQ9G3BSlHeKM7bTZ9XJITG7H0dLcGPrslrDff8AEiAQkdmjR6w/1CEg+AcqMa
 G8Ts81gRiNyH9jVnR7H4ebRcbVtu3jg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-220-bMagQIqHO627dTL909SXkQ-1; Tue, 03 Mar 2020 09:41:12 -0500
X-MC-Unique: bMagQIqHO627dTL909SXkQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 215FC107ACC4;
 Tue,  3 Mar 2020 14:41:10 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-129.ams2.redhat.com
 [10.36.116.129])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6092A10013A1;
 Tue,  3 Mar 2020 14:41:09 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id A451C11386A6; Tue,  3 Mar 2020 15:41:07 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Denis Plotnikov <dplotnikov@virtuozzo.com>
Subject: Re: [PATCH v4 4/5] qcow2: add zstd cluster compression
References: <20200303133425.24471-1-dplotnikov@virtuozzo.com>
 <20200303133425.24471-5-dplotnikov@virtuozzo.com>
Date: Tue, 03 Mar 2020 15:41:07 +0100
In-Reply-To: <20200303133425.24471-5-dplotnikov@virtuozzo.com> (Denis
 Plotnikov's message of "Tue, 3 Mar 2020 16:34:24 +0300")
Message-ID: <87d09txzzw.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
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

> zstd significantly reduces cluster compression time.
> It provides better compression performance maintaining
> the same level of the compression ratio in comparison with
> zlib, which, at the moment, is the only compression
> method available.
>
> The performance test results:
> Test compresses and decompresses qemu qcow2 image with just
> installed rhel-7.6 guest.
> Image cluster size: 64K. Image on disk size: 2.2G
>
> The test was conducted with brd disk to reduce the influence
> of disk subsystem to the test results.
> The results is given in seconds.
>
> compress cmd:
>   time ./qemu-img convert -O qcow2 -c -o compression_type=3D[zlib|zstd]
>                   src.img [zlib|zstd]_compressed.img
> decompress cmd
>   time ./qemu-img convert -O qcow2
>                   [zlib|zstd]_compressed.img uncompressed.img
>
>            compression               decompression
>          zlib       zstd           zlib         zstd
> ------------------------------------------------------------
> real     65.5       16.3 (-75 %)    1.9          1.6 (-16 %)
> user     65.0       15.8            5.3          2.5
> sys       3.3        0.2            2.0          2.0
>
> Both ZLIB and ZSTD gave the same compression ratio: 1.57
> compressed image size in both cases: 1.4G
>
> Signed-off-by: Denis Plotnikov <dplotnikov@virtuozzo.com>
[...]
> diff --git a/qapi/block-core.json b/qapi/block-core.json
> index a67eb8bff4..84889fb741 100644
> --- a/qapi/block-core.json
> +++ b/qapi/block-core.json
> @@ -4401,11 +4401,12 @@
>  # Compression type used in qcow2 image file
>  #
>  # @zlib:  zlib compression, see <http://zlib.net/>
> +# @zstd:  zstd compression, see <http://github.com/facebook/zstd>
>  #
>  # Since: 5.0
>  ##
>  { 'enum': 'Qcow2CompressionType',
> -  'data': [ 'zlib' ] }
> +  'data': [ 'zlib', { 'name': 'zstd', 'if': 'defined(CONFIG_ZSTD)' } ] }
> =20
>  ##
>  # @BlockdevCreateOptionsQcow2:

Like MultiFDCompression less value @none.

QAPI part:
Acked-by: Markus Armbruster <armbru@redhat.com>

[...]


