Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CB6EC2BB1D
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 10:50:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3AC0C20658
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 10:50:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KGvBdgEs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3AC0C20658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57522 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jE9nn-0007eU-2t
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 06:50:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38621)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jE9mp-0006Nl-Oj
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 06:49:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1jE9mn-0004jx-Kb
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 06:49:26 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:47565)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1jE9mn-0004i5-GQ
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 06:49:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584442165;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dAi1ANiMpRi3UDiR+vwamFLHbiWA1Dg1W5jdDBKoYpI=;
 b=KGvBdgEsPkE0Rmjn94S4AFHV7KyYr322ZT0UtGbZk5wQaa7pBwdJZYpfQ7eSercf+738TZ
 AoHTquRQPdkaD7iK1ZRNrW5F1n8ra1eAB1VOB83X55o22hA7gk4oFNT7/SgRrxS/E5Mtr9
 /UngSAlEFciw9X1v3o1+dZDxiZgrya0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-405-Jodq2SCpNiSgZSXXvU6KKg-1; Tue, 17 Mar 2020 06:49:23 -0400
X-MC-Unique: Jodq2SCpNiSgZSXXvU6KKg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6839C1005510;
 Tue, 17 Mar 2020 10:49:22 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-130.ams2.redhat.com
 [10.36.112.130])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 31A6294940;
 Tue, 17 Mar 2020 10:49:22 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 0683C1138404; Tue, 17 Mar 2020 11:49:21 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Pan Nengyuan <pannengyuan@huawei.com>
Subject: Re: [PATCH] qom-qmp-cmds: remove unnecessary alloc in qmp_object_add
 to fix memleak
References: <20200313075858.15860-1-pannengyuan@huawei.com>
Date: Tue, 17 Mar 2020 11:49:20 +0100
In-Reply-To: <20200313075858.15860-1-pannengyuan@huawei.com> (Pan Nengyuan's
 message of "Fri, 13 Mar 2020 15:58:58 +0800")
Message-ID: <87a74fdznz.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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
Cc: Kevin Wolf <kwolf@redhat.com>, berrange@redhat.com, ehabkost@redhat.com,
 qemu-devel@nongnu.org, euler.robot@huawei.com, pbonzini@redhat.com,
 zhang.zhanghailiang@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Pan Nengyuan <pannengyuan@huawei.com> writes:

> In qmp_object_add(), user_creatable_add_type() may set errp with some err=
or message and
> return NULL. In this case, qmp_object_add() still alloc memory to *ret_da=
ta which return
> to the caller and causes a memory leak.
>
> This patch do this alloc() action only if obj is not NULL to fix it. And =
initialize ret_data
> in xen-block to avoid a possible uninitialized error.
>
> The Leak stack:
> Direct leak of 4120 byte(s) in 1 object(s) allocated from:
>     #0 0x7f6106ce5970 in __interceptor_calloc (/lib64/libasan.so.5+0xef97=
0)
>     #1 0x7f6105e6a49d in g_malloc0 (/lib64/libglib-2.0.so.0+0x5249d)
>     #2 0x55d2c58c17fd in qdict_new /mnt/sdb/qemu-new/qemu_test/qemu/qobje=
ct/qdict.c:29
>     #3 0x55d2c53a0051 in qmp_object_add /mnt/sdb/qemu-new/qemu_test/qemu/=
qom/qom-qmp-cmds.c:291
>     #4 0x55d2c57b47da in do_qmp_dispatch /mnt/sdb/qemu-new/qemu_test/qemu=
/qapi/qmp-dispatch.c:132
>     #5 0x55d2c57b47da in qmp_dispatch /mnt/sdb/qemu-new/qemu_test/qemu/qa=
pi/qmp-dispatch.c:175
>     #6 0x55d2c52f1430 in monitor_qmp_dispatch /mnt/sdb/qemu-new/qemu_test=
/qemu/monitor/qmp.c:145
>     #7 0x55d2c52f3087 in monitor_qmp_bh_dispatcher /mnt/sdb/qemu-new/qemu=
_test/qemu/monitor/qmp.c:234
>     #8 0x55d2c58e6153 in aio_bh_call /mnt/sdb/qemu-new/qemu_test/qemu/uti=
l/async.c:136
>
> Fixes: 5f07c4d60d091320186e7b0edaf9ed2cc16b2d1e
> Reported-by: Euler Robot <euler.robot@huawei.com>
> Signed-off-by: Pan Nengyuan <pannengyuan@huawei.com>

Reviewed-by: Markus Armbruster <armbru@redhat.com>


