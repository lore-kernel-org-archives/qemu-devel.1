Return-Path: <SRS0=XqMt=3J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BC17C2D0DB
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 10:37:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3730B2073A
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 10:37:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Oxtjqd+7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3730B2073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33610 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itUQY-0006gK-Ow
	for qemu-devel@archiver.kernel.org; Mon, 20 Jan 2020 05:37:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36711)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1itULy-0001pe-Dc
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 05:32:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1itULu-0000P1-Of
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 05:32:18 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:21701
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1itULu-0000Nf-Kk
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 05:32:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579516334;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uytL/ZsJj3Kzqat70GZUIKqU5pCnahBfiPhiHQoWwWU=;
 b=Oxtjqd+7fTw8rth2VkgdBdxdjxt3i6+2wJDZz15V/t4UBO39x/tR+I0fBKMc+fMcWDHG5v
 awiRG7+hm8wCuWNU8+lIau9rvhQN8meSbTtaVd3NAUNEygxA9DG3GtR7DGqyC0PweLFW9w
 VIaOuJjMJ8uPMV/8FBGOKPI6SgUPW6I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-238-3GAyyJpTOS633vXR0nQnvQ-1; Mon, 20 Jan 2020 05:32:11 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EE2998017CC;
 Mon, 20 Jan 2020 10:32:09 +0000 (UTC)
Received: from linux.fritz.box (ovpn-116-194.ams2.redhat.com [10.36.116.194])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C99421BC6D;
 Mon, 20 Jan 2020 10:32:08 +0000 (UTC)
Date: Mon, 20 Jan 2020 11:32:07 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Eiichi Tsukata <devel@etsukata.com>
Subject: Re: [PATCH] block/backup: fix memory leak in bdrv_backup_top_append()
Message-ID: <20200120103207.GB4970@linux.fritz.box>
References: <20191223090632.30653-1-devel@etsukata.com>
MIME-Version: 1.0
In-Reply-To: <20191223090632.30653-1-devel@etsukata.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: 3GAyyJpTOS633vXR0nQnvQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
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
Cc: vsementsov@virtuozzo.com, qemu-devel@nongnu.org, qemu-block@nongnu.org,
 mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 23.12.2019 um 10:06 hat Eiichi Tsukata geschrieben:
> bdrv_open_driver() allocates bs->opaque according to drv->instance_size.
> There is no need to allocate it and overwrite opaque in
> bdrv_backup_top_append().
>=20
> Reproducer:
>=20
>   $ QTEST_QEMU_BINARY=3D./x86_64-softmmu/qemu-system-x86_64 valgrind -q -=
-leak-check=3Dfull tests/test-replication -p /replication/secondary/start
>   =3D=3D29792=3D=3D 24 bytes in 1 blocks are definitely lost in loss reco=
rd 52 of 226
>   =3D=3D29792=3D=3D    at 0x483AB1A: calloc (vg_replace_malloc.c:762)
>   =3D=3D29792=3D=3D    by 0x4B07CE0: g_malloc0 (in /usr/lib64/libglib-2.0=
.so.0.6000.7)
>   =3D=3D29792=3D=3D    by 0x12BAB9: bdrv_open_driver (block.c:1289)
>   =3D=3D29792=3D=3D    by 0x12BEA9: bdrv_new_open_driver (block.c:1359)
>   =3D=3D29792=3D=3D    by 0x1D15CB: bdrv_backup_top_append (backup-top.c:=
190)
>   =3D=3D29792=3D=3D    by 0x1CC11A: backup_job_create (backup.c:439)
>   =3D=3D29792=3D=3D    by 0x1CD542: replication_start (replication.c:544)
>   =3D=3D29792=3D=3D    by 0x1401B9: replication_start_all (replication.c:=
52)
>   =3D=3D29792=3D=3D    by 0x128B50: test_secondary_start (test-replicatio=
n.c:427)
>   ...
>=20
> Fixes: 7df7868b9640 ("block: introduce backup-top filter driver")
> Signed-off-by: Eiichi Tsukata <devel@etsukata.com>

Thanks, applied to the block layer.

Kevin


