Return-Path: <SRS0=bySr=YS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A388CA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 20:16:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 34BAB21D81
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 20:16:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SJV2Mfab"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34BAB21D81
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35838 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iO60s-0003eb-08
	for qemu-devel@archiver.kernel.org; Fri, 25 Oct 2019 16:16:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54947)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1iO4y4-0007Mo-JN
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 15:09:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1iO4y2-0007hl-AT
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 15:09:47 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:40638
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1iO4y1-0007gr-Tv
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 15:09:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572030585;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=byH6n30ESDquSyudzxZjAe76G1/YwCVzLTKOc1bKQjU=;
 b=SJV2MfabV1HN1zuEnhd7vxLZXUYd3DnDPNpJScsGXA4ICF7RJCNpABmWVDPkySCHu7UIlr
 wdqlCAc7HSHOTOCs2XCv1Kibj0HJbshK16nTFixZvIvxleE22XXfUxDdBgMqzz5/Vb2FGr
 5XgeYl2Rl+nfbsDupCro8nUq4mzXHM8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-8-FB0XUHuRPlGWdIWmpxULsQ-1; Fri, 25 Oct 2019 15:09:41 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E14A880183D;
 Fri, 25 Oct 2019 19:09:40 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.36.118.123])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5B8DC5D9C9;
 Fri, 25 Oct 2019 19:09:31 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id CD0921138619; Fri, 25 Oct 2019 21:09:24 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH v2 02/15] qapi/block-core: add option for io_uring
References: <20191025160444.31632-1-stefanha@redhat.com>
 <20191025160444.31632-3-stefanha@redhat.com>
Date: Fri, 25 Oct 2019 21:09:24 +0200
In-Reply-To: <20191025160444.31632-3-stefanha@redhat.com> (Stefan Hajnoczi's
 message of "Fri, 25 Oct 2019 18:04:31 +0200")
Message-ID: <874kzwprq3.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: FB0XUHuRPlGWdIWmpxULsQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
Cc: Fam Zheng <fam@euphon.net>, oleksandr@redhat.com, qemu-block@nongnu.org,
 Julia Suvorova <jusual@redhat.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Aarushi Mehta <mehta.aaru20@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Stefan Hajnoczi <stefanha@redhat.com> writes:

> From: Aarushi Mehta <mehta.aaru20@gmail.com>
>
> Only enumerates option for devices that support it.

I'm not sure I get this sentence.

>                                                     Since QAPI schema
> supports io_uring, which is the actual name of the Linux API, it is
> preferred over io-uring.

I guess this one means something like "Since io_uring is the actual name
of the Linux API, we use it as enum value even though the QAPI schema
conventions would prefer io-uring."

> Signed-off-by: Aarushi Mehta <mehta.aaru20@gmail.com>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  qapi/block-core.json | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/qapi/block-core.json b/qapi/block-core.json
> index b274aef713..3196f40178 100644
> --- a/qapi/block-core.json
> +++ b/qapi/block-core.json
> @@ -2851,11 +2851,13 @@
>  #
>  # @threads:     Use qemu's thread pool
>  # @native:      Use native AIO backend (only Linux and Windows)
> +# @io_uring:    Use linux io_uring (since 4.2)
>  #
>  # Since: 2.9
>  ##
>  { 'enum': 'BlockdevAioOptions',
> -  'data': [ 'threads', 'native' ] }
> +  'data': [ 'threads', 'native',
> +            { 'name': 'io_uring', 'if': 'defined(CONFIG_LINUX_IO_URING)'=
 } ] }
> =20
>  ##
>  # @BlockdevCacheOptions:

I encourage you to polish the commit message some.

Acked-by: Markus Armbruster <armbru@redhat.com>


