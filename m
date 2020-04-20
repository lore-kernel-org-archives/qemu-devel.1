Return-Path: <SRS0=IvAo=6E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2580C3815B
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 09:30:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7751320A8B
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 09:30:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HbMY+xax"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7751320A8B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60424 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQSlU-0007gw-Kw
	for qemu-devel@archiver.kernel.org; Mon, 20 Apr 2020 05:30:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42070 helo=eggs1p.gnu.org)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1jQSkL-0006Ph-SD
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 05:29:46 -0400
Received: from Debian-exim by eggs1p.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1jQSkL-0006rq-5b
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 05:29:45 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:24819
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jQSkK-0006r4-OF
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 05:29:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587374983;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=47AE8U7RasS6VYCJTM6z4TG4yQCH9LZOAwvoV9saJtY=;
 b=HbMY+xaxSg7SbNnIX8+R+/0Ps+m7ZLbZIVCZJmCXcki2UtkRlohnFf25Wt88iq0ZjmQs4d
 anc3YzmIeAPCbwmB+df9/tEozGfzqgCTPbxXtSH1XCdio9tpMPzebd/NhwX6YBb0zhpotw
 py5ZVnlz0uTYUgicaIVCaCohBIV/G0M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-500-TsMmot2fO761rTr9p9QTfw-1; Mon, 20 Apr 2020 05:29:40 -0400
X-MC-Unique: TsMmot2fO761rTr9p9QTfw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BF660802684;
 Mon, 20 Apr 2020 09:29:38 +0000 (UTC)
Received: from redhat.com (unknown [10.36.110.47])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D290B19C70;
 Mon, 20 Apr 2020 09:29:33 +0000 (UTC)
Date: Mon, 20 Apr 2020 10:29:30 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Wei Wang <wei.w.wang@intel.com>
Subject: Re: [PATCH v1 1/2] migration/xbzrle: replace transferred xbzrle
 bytes with encoded bytes
Message-ID: <20200420092930.GH346737@redhat.com>
References: <1587352003-3312-1-git-send-email-wei.w.wang@intel.com>
 <1587352003-3312-2-git-send-email-wei.w.wang@intel.com>
MIME-Version: 1.0
In-Reply-To: <1587352003-3312-2-git-send-email-wei.w.wang@intel.com>
User-Agent: Mutt/1.13.3 (2020-01-12)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs1p.gnu.org: First seen = 2020/04/20
 03:29:18
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: kevin.tian@intel.com, quintela@redhat.com, qemu-devel@nongnu.org,
 peterx@redhat.com, dgilbert@redhat.com, gloryxiao@tencent.com,
 yi.y.sun@intel.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Apr 20, 2020 at 11:06:42AM +0800, Wei Wang wrote:
> Like compressed_size which indicates how many bytes are compressed, we
> need encoded_size to understand how many bytes are encoded with xbzrle
> during migration.
>=20
> Replace the old xbzrle_counter.bytes, instead of adding a new counter,
> because we don't find a usage of xbzrle_counter.bytes currently, which
> includes 3 more bytes of the migration transfer protocol header (in
> addition to the encoding header). The encoded_size will further be used
> to calculate the encoding rate.
>=20
> Signed-off-by: Yi Sun <yi.y.sun@intel.com>
> Signed-off-by: Wei Wang <wei.w.wang@intel.com>
> ---
>  migration/migration.c |  2 +-
>  migration/ram.c       | 18 +++++++++---------
>  monitor/hmp-cmds.c    |  4 ++--
>  qapi/migration.json   |  6 +++---
>  4 files changed, 15 insertions(+), 15 deletions(-)


> diff --git a/qapi/migration.json b/qapi/migration.json
> index eca2981d0a..bf195ff6ac 100644
> --- a/qapi/migration.json
> +++ b/qapi/migration.json
> @@ -62,7 +62,7 @@
>  #
>  # @cache-size: XBZRLE cache size
>  #
> -# @bytes: amount of bytes already transferred to the target VM
> +# @encoded_size: amount of bytes encoded

Woah, this is part of QEMU's public API, so it isn't permissible to just
arbitrarily remove a field with no warning, and replace it with a new
field reporting different data. Adding a new field is allowed, but any
existing field should be deprecated first, if there is a genuine need
to remove it. If it isn't costly though, just leave the existing field
unchanged.

I would also note that the other fields in this struct use a hyphen, not
an underscore.

>  #
>  # @pages: amount of pages transferred to the target VM
>  #
> @@ -75,7 +75,7 @@
>  # Since: 1.2
>  ##
>  { 'struct': 'XBZRLECacheStats',
> -  'data': {'cache-size': 'int', 'bytes': 'int', 'pages': 'int',
> +  'data': {'cache-size': 'int', 'encoded_size': 'int', 'pages': 'int',
>             'cache-miss': 'int', 'cache-miss-rate': 'number',
>             'overflow': 'int' } }
> =20
> @@ -333,7 +333,7 @@
>  #          },
>  #          "xbzrle-cache":{
>  #             "cache-size":67108864,
> -#             "bytes":20971520,
> +#             "encoded_size":20971520,
>  #             "pages":2444343,
>  #             "cache-miss":2244,
>  #             "cache-miss-rate":0.123,
> --=20
> 2.20.1
>=20
>=20

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange=
 :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com=
 :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange=
 :|


