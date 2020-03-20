Return-Path: <SRS0=cIHa=5F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CED2BC4332D
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 10:35:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 94F992072D
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 10:35:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E6YWBkeb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94F992072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50654 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jFF03-0001Wq-PA
	for qemu-devel@archiver.kernel.org; Fri, 20 Mar 2020 06:35:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38043)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1jFEzI-0000MX-9n
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 06:34:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1jFEzH-0003MO-0C
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 06:34:48 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:57098)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1jFEzG-0003M5-T3
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 06:34:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584700486;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5nQBqgX8dTFMR+iTcBptqJeLUG46KV7yCRvVKv7Hbpc=;
 b=E6YWBkeblPUTOUOEmWYdyOQiQIhaAkEd/fXA1KsdUf5Rkhz+9CWBZhG2yo4Y4xHBZ81TOK
 floa1/9SqFzll5rL0MGu5gIg/tiVwx0ohROZAeyttUAEGDDwDDSLOb/8E5V0LNx6ZQbi5L
 vbT4JsGLwjJF7RXAzjPOYegVNRoY0vA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-17-Zt-VInNENDSk4v_1fzs-bg-1; Fri, 20 Mar 2020 06:34:43 -0400
X-MC-Unique: Zt-VInNENDSk4v_1fzs-bg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7C57C800D50;
 Fri, 20 Mar 2020 10:34:41 +0000 (UTC)
Received: from gondolin (ovpn-113-89.ams2.redhat.com [10.36.113.89])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9AC5D19C58;
 Fri, 20 Mar 2020 10:34:34 +0000 (UTC)
Date: Fri, 20 Mar 2020 11:34:30 +0100
From: Cornelia Huck <cohuck@redhat.com>
To: Pan Nengyuan <pannengyuan@huawei.com>
Subject: Re: [PATCH v5 1/4] s390x: fix memleaks in cpu_finalize
Message-ID: <20200320113430.75c381fe.cohuck@redhat.com>
In-Reply-To: <20200314084730.25876-2-pannengyuan@huawei.com>
References: <20200314084730.25876-1-pannengyuan@huawei.com>
 <20200314084730.25876-2-pannengyuan@huawei.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
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
Cc: peter.maydell@linaro.org, zhang.zhanghailiang@huawei.com,
 David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org, euler.robot@huawei.com, Richard
 Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, 14 Mar 2020 16:47:27 +0800
Pan Nengyuan <pannengyuan@huawei.com> wrote:

> This patch fix memleaks when we call tests/qtest/cpu-plug-test on s390x. =
The leak stack is as follow:
>=20
> Direct leak of 48 byte(s) in 1 object(s) allocated from:
>     #0 0x7fb43c7cd970 in __interceptor_calloc (/lib64/libasan.so.5+0xef97=
0)
>     #1 0x7fb43be2149d in g_malloc0 (/lib64/libglib-2.0.so.0+0x5249d)
>     #2 0x558ba96da716 in timer_new_full /mnt/sdb/qemu-new/qemu/include/qe=
mu/timer.h:530
>     #3 0x558ba96da716 in timer_new /mnt/sdb/qemu-new/qemu/include/qemu/ti=
mer.h:551
>     #4 0x558ba96da716 in timer_new_ns /mnt/sdb/qemu-new/qemu/include/qemu=
/timer.h:569
>     #5 0x558ba96da716 in s390_cpu_initfn /mnt/sdb/qemu-new/qemu/target/s3=
90x/cpu.c:285
>     #6 0x558ba9c969ab in object_init_with_type /mnt/sdb/qemu-new/qemu/qom=
/object.c:372
>     #7 0x558ba9c9eb5f in object_initialize_with_type /mnt/sdb/qemu-new/qe=
mu/qom/object.c:516
>     #8 0x558ba9c9f053 in object_new_with_type /mnt/sdb/qemu-new/qemu/qom/=
object.c:684
>     #9 0x558ba967ede6 in s390x_new_cpu /mnt/sdb/qemu-new/qemu/hw/s390x/s3=
90-virtio-ccw.c:64
>     #10 0x558ba99764b3 in hmp_cpu_add /mnt/sdb/qemu-new/qemu/hw/core/mach=
ine-hmp-cmds.c:57
>     #11 0x558ba9b1c27f in handle_hmp_command /mnt/sdb/qemu-new/qemu/monit=
or/hmp.c:1082
>     #12 0x558ba96c1b02 in qmp_human_monitor_command /mnt/sdb/qemu-new/qem=
u/monitor/misc.c:142
>=20
> Reported-by: Euler Robot <euler.robot@huawei.com>
> Signed-off-by: Pan Nengyuan <pannengyuan@huawei.com>
> ---
> Cc: Richard Henderson <rth@twiddle.net>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Cornelia Huck <cohuck@redhat.com>
> Cc: qemu-s390x@nongnu.org
> ---
> v2->v1:
> - Similarly to other cleanups, move timer_new into realize(Suggested by P=
hilippe Mathieu-Daud=C3=A9)
> v3->v2:
> - Also do the timer_free in unrealize, it seems balanced.
> v4->v3:
> - Also do timer_free on the error path in realize() and fix some coding s=
tyle.
> - Use device_class_set_parent_unrealize to declare unrealize.
> v5->v4:
> - remove timer_del on the error path of realize(), it's redundant. (Sugge=
sted by David Hildenbrand)
> - Simply use errp instead a temporary variable. (Suggested by David Hilde=
nbrand)
> ---
>  target/s390x/cpu-qom.h |  1 +
>  target/s390x/cpu.c     | 30 ++++++++++++++++++++++++++----
>  2 files changed, 27 insertions(+), 4 deletions(-)

Patch seems fine now (more review still welcome :)

Question: should I take this through the s390-fixes branch, or will
somebody else queue the whole series?


