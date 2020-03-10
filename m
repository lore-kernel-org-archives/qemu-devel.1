Return-Path: <SRS0=ZRpO=43=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE768C10F27
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 11:56:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 886A62464B
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 11:56:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C2eqVg6H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 886A62464B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58770 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBdV0-00078H-O2
	for qemu-devel@archiver.kernel.org; Tue, 10 Mar 2020 07:56:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55529)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1jBdTF-0005fq-5p
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 07:54:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1jBdTC-0002Vd-SJ
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 07:54:48 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:27582
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1jBdTC-0002ST-OC
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 07:54:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583841285;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QuTzLdYeeDSPwdq8KjUruBMKypL1L9Mm2b7XjAGUqoA=;
 b=C2eqVg6HwJhqMlHZ5hVO81VGv8GrJ95Byfsyc92iZs18Bof953ABjxP3jxK3P04m+VxtfN
 ecYHtSIj/UOztyMCKOxjt5e7+pyJWUPRnSJgtW6U6jqYSMWsIFYSEsIJe/PRFhNgZLLNoj
 XesZIY/aLe9/dAS1hSNoXiWw9brXp3M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-144-H-DM9qrAOESkKmX1llFX3w-1; Tue, 10 Mar 2020 07:54:42 -0400
X-MC-Unique: H-DM9qrAOESkKmX1llFX3w-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2BB081085936;
 Tue, 10 Mar 2020 11:54:41 +0000 (UTC)
Received: from linux.fritz.box (unknown [10.36.118.104])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B42A287B2F;
 Tue, 10 Mar 2020 11:54:39 +0000 (UTC)
Date: Tue, 10 Mar 2020 12:54:38 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Pan Nengyuan <pannengyuan@huawei.com>
Subject: Re: [PATCH v2] qom-qmp-cmds: fix two memleaks in qmp_object_add
Message-ID: <20200310115438.GB6926@linux.fritz.box>
References: <20200310064640.5059-1-pannengyuan@huawei.com>
MIME-Version: 1.0
In-Reply-To: <20200310064640.5059-1-pannengyuan@huawei.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
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
Cc: berrange@redhat.com, ehabkost@redhat.com, qemu-devel@nongnu.org,
 euler.robot@huawei.com, pbonzini@redhat.com, zhang.zhanghailiang@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 10.03.2020 um 07:46 hat Pan Nengyuan geschrieben:
> 'type/id' forgot to free in qmp_object_add, this patch fix that.
>=20
> The leak stack:
> Direct leak of 84 byte(s) in 6 object(s) allocated from:
>     #0 0x7fe2a5ebf768 in __interceptor_malloc (/lib64/libasan.so.5+0xef76=
8)
>     #1 0x7fe2a5044445 in g_malloc (/lib64/libglib-2.0.so.0+0x52445)
>     #2 0x7fe2a505dd92 in g_strdup (/lib64/libglib-2.0.so.0+0x6bd92)
>     #3 0x56344954e692 in qmp_object_add /mnt/sdb/qemu-new/qemu_test/qemu/=
qom/qom-qmp-cmds.c:258
>     #4 0x563449960f5a in do_qmp_dispatch /mnt/sdb/qemu-new/qemu_test/qemu=
/qapi/qmp-dispatch.c:132
>     #5 0x563449960f5a in qmp_dispatch /mnt/sdb/qemu-new/qemu_test/qemu/qa=
pi/qmp-dispatch.c:175
>     #6 0x563449498a30 in monitor_qmp_dispatch /mnt/sdb/qemu-new/qemu_test=
/qemu/monitor/qmp.c:145
>     #7 0x56344949a64f in monitor_qmp_bh_dispatcher /mnt/sdb/qemu-new/qemu=
_test/qemu/monitor/qmp.c:234
>     #8 0x563449a92a3a in aio_bh_call /mnt/sdb/qemu-new/qemu_test/qemu/uti=
l/async.c:136
>=20
> Direct leak of 54 byte(s) in 6 object(s) allocated from:
>     #0 0x7fe2a5ebf768 in __interceptor_malloc (/lib64/libasan.so.5+0xef76=
8)
>     #1 0x7fe2a5044445 in g_malloc (/lib64/libglib-2.0.so.0+0x52445)
>     #2 0x7fe2a505dd92 in g_strdup (/lib64/libglib-2.0.so.0+0x6bd92)
>     #3 0x56344954e6c4 in qmp_object_add /mnt/sdb/qemu-new/qemu_test/qemu/=
qom/qom-qmp-cmds.c:267
>     #4 0x563449960f5a in do_qmp_dispatch /mnt/sdb/qemu-new/qemu_test/qemu=
/qapi/qmp-dispatch.c:132
>     #5 0x563449960f5a in qmp_dispatch /mnt/sdb/qemu-new/qemu_test/qemu/qa=
pi/qmp-dispatch.c:175
>     #6 0x563449498a30 in monitor_qmp_dispatch /mnt/sdb/qemu-new/qemu_test=
/qemu/monitor/qmp.c:145
>     #7 0x56344949a64f in monitor_qmp_bh_dispatcher /mnt/sdb/qemu-new/qemu=
_test/qemu/monitor/qmp.c:234
>     #8 0x563449a92a3a in aio_bh_call /mnt/sdb/qemu-new/qemu_test/qemu/uti=
l/async.c:136
>=20
> Fixes: 5f07c4d60d091320186e7b0edaf9ed2cc16b2d1e
> Reported-by: Euler Robot <euler.robot@huawei.com>
> Signed-off-by: Pan Nengyuan <pannengyuan@huawei.com>

Thanks, applied to the block branch. (It might not be obvious why this
should go through the block tree, but the bug was introduced through my
tree, so I'll take care to get it fixed through my tree, too.)

Kevin


