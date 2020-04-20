Return-Path: <SRS0=IvAo=6E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AA56C3815B
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 10:05:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0023520857
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 10:05:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VPiVDN4q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0023520857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60898 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQTJG-0004Li-0g
	for qemu-devel@archiver.kernel.org; Mon, 20 Apr 2020 06:05:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50626 helo=eggs1p.gnu.org)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1jQTI3-00033i-UY
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 06:04:40 -0400
Received: from Debian-exim by eggs1p.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1jQTI2-0006Bb-Bi
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 06:04:35 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:37581
 helo=us-smtp-1.mimecast.com)
 by eggs1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jQTI1-00068g-VI
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 06:04:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587377072;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Rd8ck0rG+VWuzFUfCUtC6WQUhQmJdODGU2whSWDpkIs=;
 b=VPiVDN4q8AlvP45hwCWaEp0Ko0JbnVz0VgNJ0XcZSZitGV5LpM43V9h0Lunem9udEUaf4X
 rmY4B9YtYpoaRVPILtVa/65Q/ejgKRcIwNshNlZaEjol0wwjKeQ03VONZA01F8wFUvq6Zy
 haPFWFJCkQ4bsLu0HtMcFoMmovDz4+k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-203-Mc9FX2lBPEibQ-G84ty2Dw-1; Mon, 20 Apr 2020 06:04:08 -0400
X-MC-Unique: Mc9FX2lBPEibQ-G84ty2Dw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 550DB18C8C02;
 Mon, 20 Apr 2020 10:04:06 +0000 (UTC)
Received: from redhat.com (unknown [10.36.110.47])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4B053A188D;
 Mon, 20 Apr 2020 10:03:53 +0000 (UTC)
Date: Mon, 20 Apr 2020 11:03:50 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Chen Qun <kuhn.chenqun@huawei.com>
Subject: Re: [PATCH] block/iscsi:fix heap-buffer-overflow in iscsi_aio_ioctl_cb
Message-ID: <20200420100350.GL346737@redhat.com>
References: <20200418062602.10776-1-kuhn.chenqun@huawei.com>
MIME-Version: 1.0
In-Reply-To: <20200418062602.10776-1-kuhn.chenqun@huawei.com>
User-Agent: Mutt/1.13.3 (2020-01-12)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=berrange@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs1p.gnu.org: First seen = 2020/04/20
 03:29:13
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Kevin Wolf <kwolf@redhat.com>, zhang.zhanghailiang@huawei.com,
 qemu-block@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>,
 qemu-trivial@nongnu.org, Peter Lieven <pl@kamp.de>, qemu-devel@nongnu.org,
 Prasad J Pandit <ppandit@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Euler Robot <euler.robot@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Ronnie Sahlberg <ronniesahlberg@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, Apr 18, 2020 at 02:26:02PM +0800, Chen Qun wrote:
> There is an overflow, the source 'datain.data[2]' is 100 bytes,
>  but the 'ss' is 252 bytes.This may cause a security issue because
>  we can access a lot of unrelated memory data.
>=20
> The len for sbp copy data should take the minimum of mx_sb_len and
>  sb_len_wr, not the maximum.
>=20
> If we use iscsi device for VM backend storage, ASAN show stack:
>=20
> READ of size 252 at 0xfffd149dcfc4 thread T0
>     #0 0xaaad433d0d34 in __asan_memcpy (aarch64-softmmu/qemu-system-aarch=
64+0x2cb0d34)
>     #1 0xaaad45f9d6d0 in iscsi_aio_ioctl_cb /qemu/block/iscsi.c:996:9
>     #2 0xfffd1af0e2dc  (/usr/lib64/iscsi/libiscsi.so.8+0xe2dc)
>     #3 0xfffd1af0d174  (/usr/lib64/iscsi/libiscsi.so.8+0xd174)
>     #4 0xfffd1af19fac  (/usr/lib64/iscsi/libiscsi.so.8+0x19fac)
>     #5 0xaaad45f9acc8 in iscsi_process_read /qemu/block/iscsi.c:403:5
>     #6 0xaaad4623733c in aio_dispatch_handler /qemu/util/aio-posix.c:467:=
9
>     #7 0xaaad4622f350 in aio_dispatch_handlers /qemu/util/aio-posix.c:510=
:20
>     #8 0xaaad4622f350 in aio_dispatch /qemu/util/aio-posix.c:520
>     #9 0xaaad46215944 in aio_ctx_dispatch /qemu/util/async.c:298:5
>     #10 0xfffd1bed12f4 in g_main_context_dispatch (/lib64/libglib-2.0.so.=
0+0x512f4)
>     #11 0xaaad46227de0 in glib_pollfds_poll /qemu/util/main-loop.c:219:9
>     #12 0xaaad46227de0 in os_host_main_loop_wait /qemu/util/main-loop.c:2=
42
>     #13 0xaaad46227de0 in main_loop_wait /qemu/util/main-loop.c:518
>     #14 0xaaad43d9d60c in qemu_main_loop /qemu/softmmu/vl.c:1662:9
>     #15 0xaaad4607a5b0 in main /qemu/softmmu/main.c:49:5
>     #16 0xfffd1a460b9c in __libc_start_main (/lib64/libc.so.6+0x20b9c)
>     #17 0xaaad43320740 in _start (aarch64-softmmu/qemu-system-aarch64+0x2=
c00740)
>=20
> 0xfffd149dcfc4 is located 0 bytes to the right of 100-byte region [0xfffd=
149dcf60,0xfffd149dcfc4)
> allocated by thread T0 here:
>     #0 0xaaad433d1e70 in __interceptor_malloc (aarch64-softmmu/qemu-syste=
m-aarch64+0x2cb1e70)
>     #1 0xfffd1af0e254  (/usr/lib64/iscsi/libiscsi.so.8+0xe254)
>     #2 0xfffd1af0d174  (/usr/lib64/iscsi/libiscsi.so.8+0xd174)
>     #3 0xfffd1af19fac  (/usr/lib64/iscsi/libiscsi.so.8+0x19fac)
>     #4 0xaaad45f9acc8 in iscsi_process_read /qemu/block/iscsi.c:403:5
>     #5 0xaaad4623733c in aio_dispatch_handler /qemu/util/aio-posix.c:467:=
9
>     #6 0xaaad4622f350 in aio_dispatch_handlers /qemu/util/aio-posix.c:510=
:20
>     #7 0xaaad4622f350 in aio_dispatch /qemu/util/aio-posix.c:520
>     #8 0xaaad46215944 in aio_ctx_dispatch /qemu/util/async.c:298:5
>     #9 0xfffd1bed12f4 in g_main_context_dispatch (/lib64/libglib-2.0.so.0=
+0x512f4)
>     #10 0xaaad46227de0 in glib_pollfds_poll /qemu/util/main-loop.c:219:9
>     #11 0xaaad46227de0 in os_host_main_loop_wait /qemu/util/main-loop.c:2=
42
>     #12 0xaaad46227de0 in main_loop_wait /qemu/util/main-loop.c:518
>     #13 0xaaad43d9d60c in qemu_main_loop /qemu/softmmu/vl.c:1662:9
>     #14 0xaaad4607a5b0 in main /qemu/softmmu/main.c:49:5
>     #15 0xfffd1a460b9c in __libc_start_main (/lib64/libc.so.6+0x20b9c)
>     #16 0xaaad43320740 in _start (aarch64-softmmu/qemu-system-aarch64+0x2=
c00740)
>=20
> Reported-by: Euler Robot <euler.robot@huawei.com>
> Signed-off-by: Chen Qun <kuhn.chenqun@huawei.com>
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
> v1->v2:
> Use MIN() macro for mx_sb_len and sb_len_wr.
> (Base comments from Michael S. Tsirkin, Stefan Hajnoczi, Kevin Wolf)
>=20
> Cc: Stefan Hajnoczi <stefanha@redhat.com>
> Cc: Kevin Wolf <kwolf@redhat.com>
> Cc: Michael S. Tsirkin <mst@redhat.com>
> Cc: Prasad J Pandit <ppandit@redhat.com>
> Cc: Max Reitz <mreitz@redhat.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Peter Lieven <pl@kamp.de>
> Cc: Ronnie Sahlberg <ronniesahlberg@gmail.com>
> Cc: qemu-block@nongnu.org
> ---
>  block/iscsi.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>

I think it is resonable to include this in 5.0 too.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange=
 :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com=
 :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange=
 :|


