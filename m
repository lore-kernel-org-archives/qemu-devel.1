Return-Path: <SRS0=0TZc=4P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6854C4BA24
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 11:07:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 851AB24691
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 11:07:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KY3AKVlH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 851AB24691
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57380 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7H18-0002Yf-Kk
	for qemu-devel@archiver.kernel.org; Thu, 27 Feb 2020 06:07:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59216)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1j7H0R-0001us-O1
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 06:07:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1j7H0Q-0000Su-Ii
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 06:07:03 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:51478
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1j7H0Q-0000Rp-F9
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 06:07:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582801622;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=f1RDikHjMuEMm5c5nGEz67lZrv93tK+Qel+QeJZrsug=;
 b=KY3AKVlHdc7IYR7BAhFnKehK9/Wqn+PbHtAqJGb0lBkqUEy22GOzdAKfCn6HosNHP6D83G
 7LN+O/y1w0+zGeQoNljIQ+BKxWwlN8pb464E0WsUAhGH0WwAy2HAIqLrb/238kdLGs7lD6
 P90RoTgMEjOi7HsikFskI4PE/E/dO/c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-318-g-kMWyd0MyOmAQoYKspYWQ-1; Thu, 27 Feb 2020 06:06:58 -0500
X-MC-Unique: g-kMWyd0MyOmAQoYKspYWQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id ED58013E5;
 Thu, 27 Feb 2020 11:06:56 +0000 (UTC)
Received: from gondolin (ovpn-117-2.ams2.redhat.com [10.36.117.2])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8CDE260BE2;
 Thu, 27 Feb 2020 11:06:52 +0000 (UTC)
Date: Thu, 27 Feb 2020 12:06:49 +0100
From: Cornelia Huck <cohuck@redhat.com>
To: Pan Nengyuan <pannengyuan@huawei.com>
Subject: Re: [PATCH v3 1/6] s390x: fix memleaks in cpu_finalize
Message-ID: <20200227120649.50e6ea68.cohuck@redhat.com>
In-Reply-To: <20200227025055.14341-2-pannengyuan@huawei.com>
References: <20200227025055.14341-1-pannengyuan@huawei.com>
 <20200227025055.14341-2-pannengyuan@huawei.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: peter.maydell@linaro.org, zhang.zhanghailiang@huawei.com, David
 Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org, qemu-s390x@nongnu.org,
 qemu-arm@nongnu.org, euler.robot@huawei.com,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 27 Feb 2020 10:50:50 +0800
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
hilippe Mathieu-Daud=C3=83=C2=A9)
> v3->v2:
> - Also do the timer_free in unrealize, it seems more balance.
> ---
>  target/s390x/cpu.c | 22 ++++++++++++++++++----
>  1 file changed, 18 insertions(+), 4 deletions(-)
>=20
> diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
> index cf84d307c6..cc63c9db22 100644
> --- a/target/s390x/cpu.c
> +++ b/target/s390x/cpu.c
> @@ -170,7 +170,12 @@ static void s390_cpu_realizefn(DeviceState *dev, Err=
or **errp)
>      S390CPUClass *scc =3D S390_CPU_GET_CLASS(dev);
>  #if !defined(CONFIG_USER_ONLY)
>      S390CPU *cpu =3D S390_CPU(dev);
> +    cpu->env.tod_timer =3D
> +        timer_new_ns(QEMU_CLOCK_VIRTUAL, s390x_tod_timer, cpu);
> +    cpu->env.cpu_timer =3D
> +        timer_new_ns(QEMU_CLOCK_VIRTUAL, s390x_cpu_timer, cpu);
>  #endif

It does not seem you addressed the comments I had last time, namely
- memory leak on error (we do not go through unrealize if the device
  was never completely realized)
- coding style (initialization in middle of declaration section)

> +
>      Error *err =3D NULL;
> =20
>      /* the model has to be realized before qemu_init_vcpu() due to kvm *=
/


