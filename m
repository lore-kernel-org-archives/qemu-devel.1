Return-Path: <SRS0=xDnh=4A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D468C2BA83
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 16:24:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2AA2D20714
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 16:24:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J6nBcEv9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2AA2D20714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40062 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1uoS-0004Zn-Dq
	for qemu-devel@archiver.kernel.org; Wed, 12 Feb 2020 11:24:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33733)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ehabkost@redhat.com>) id 1j1ukL-0004W9-NP
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 11:20:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1j1ukK-0006Mj-96
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 11:20:17 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:36381
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1j1ukK-0006LE-4C
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 11:20:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581524414;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BM6DvFfcyBg0xwynaujoMvVPGVp26/oDIm7OSSoZEOc=;
 b=J6nBcEv9/0bIi0Xsi7oTwlD2ZqBlXEBr4BWnkd7moM6MfxCDDIsWh6vMEjlc6jSYpJh4Q2
 jA8arkG6nEGUkynAsl/h+QB2354kptOo50sxDJ8ih+PDkYvJIXofUiC9cfHcUU3c2nUVwZ
 d7w5TUlU4TAxA3tkQg34IPftfG0uWEw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-139-NJbIHmGgPhuyPPC9-Myjyw-1; Wed, 12 Feb 2020 11:20:11 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 50D61800D48;
 Wed, 12 Feb 2020 16:20:10 +0000 (UTC)
Received: from localhost (ovpn-126-54.rdu2.redhat.com [10.10.126.54])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DD7645DA8C;
 Wed, 12 Feb 2020 16:19:58 +0000 (UTC)
Date: Wed, 12 Feb 2020 11:19:57 -0500
From: Eduardo Habkost <ehabkost@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: [PATCH] hw/char/exynos4210_uart: Fix memleaks in
 exynos4210_uart_init
Message-ID: <20200212161957.GA5028@habkost.net>
References: <20200212033641.249560-1-kuhn.chenqun@huawei.com>
 <ce5d39c0-d532-4b54-a39c-01c9c97cbb59@redhat.com>
 <7412CDE03601674DA8197E2EBD8937E83B1163F4@dggemm531-mbx.china.huawei.com>
 <99531e05-f8fc-ef0a-ca62-6d477c899e78@redhat.com>
MIME-Version: 1.0
In-Reply-To: <99531e05-f8fc-ef0a-ca62-6d477c899e78@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: NJbIHmGgPhuyPPC9-Myjyw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 Zhanghailiang <zhang.zhanghailiang@huawei.com>,
 "i.mitsyanko@gmail.com" <i.mitsyanko@gmail.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Markus Armbruster <armbru@redhat.com>,
 "qemu-trivial@nongnu.org" <qemu-trivial@nongnu.org>,
 "Chenqun \(kuhn\)" <kuhn.chenqun@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Feb 12, 2020 at 08:39:55AM +0100, Philippe Mathieu-Daud=E9 wrote:
> Cc'ing Eduardo & Markus.
>=20
> On 2/12/20 7:44 AM, Chenqun (kuhn) wrote:
> > > -----Original Message-----
> > > From: Philippe Mathieu-Daud=E9 [mailto:philmd@redhat.com]
> > > Sent: Wednesday, February 12, 2020 2:16 PM
> > > To: Chenqun (kuhn) <kuhn.chenqun@huawei.com>; qemu-
> > > devel@nongnu.org; i.mitsyanko@gmail.com; peter.maydell@linaro.org
> > > Cc: qemu-trivial@nongnu.org; Zhanghailiang
> > > <zhang.zhanghailiang@huawei.com>
> > > Subject: Re: [PATCH] hw/char/exynos4210_uart: Fix memleaks in
> > > exynos4210_uart_init
> > >=20
> > > On 2/12/20 4:36 AM, kuhn.chenqun@huawei.com wrote:
> > > > From: Chen Qun <kuhn.chenqun@huawei.com>
> > > >=20
> > > > It's easy to reproduce as follow:
> > > > virsh qemu-monitor-command vm1 --pretty '{"execute":
> > > > "device-list-properties", "arguments":{"typename":"exynos4210.uart"=
}}'
> > > >=20
> > > > ASAN shows memory leak stack:
> > > >     #1 0xfffd896d71cb in g_malloc0 (/lib64/libglib-2.0.so.0+0x571cb=
)
> > > >     #2 0xaaad270beee3 in timer_new_full /qemu/include/qemu/timer.h:=
530
> > > >     #3 0xaaad270beee3 in timer_new /qemu/include/qemu/timer.h:551
> > > >     #4 0xaaad270beee3 in timer_new_ns /qemu/include/qemu/timer.h:56=
9
> > > >     #5 0xaaad270beee3 in exynos4210_uart_init
> > > /qemu/hw/char/exynos4210_uart.c:677
> > > >     #6 0xaaad275c8f4f in object_initialize_with_type /qemu/qom/obje=
ct.c:516
> > > >     #7 0xaaad275c91bb in object_new_with_type /qemu/qom/object.c:68=
4
> > > >     #8 0xaaad2755df2f in qmp_device_list_properties
> > > > /qemu/qom/qom-qmp-cmds.c:152
> > > >=20
> > > > Reported-by: Euler Robot <euler.robot@huawei.com>
> > > > Signed-off-by: Chen Qun <kuhn.chenqun@huawei.com>
> > > > ---
> > > >    hw/char/exynos4210_uart.c | 8 ++++----
> > > >    1 file changed, 4 insertions(+), 4 deletions(-)
> > > >=20
> > > > diff --git a/hw/char/exynos4210_uart.c b/hw/char/exynos4210_uart.c
> > > > index 25d6588e41..5048db5410 100644
> > > > --- a/hw/char/exynos4210_uart.c
> > > > +++ b/hw/char/exynos4210_uart.c
> > > > @@ -674,10 +674,6 @@ static void exynos4210_uart_init(Object *obj)
> > > >        SysBusDevice *dev =3D SYS_BUS_DEVICE(obj);
> > > >        Exynos4210UartState *s =3D EXYNOS4210_UART(dev);
> > > >=20
> > > > -    s->fifo_timeout_timer =3D timer_new_ns(QEMU_CLOCK_VIRTUAL,
> > > > -                                         exynos4210_uart_timeout_i=
nt, s);
> > > > -    s->wordtime =3D NANOSECONDS_PER_SECOND * 10 / 9600;
> > >=20
> > > Why are you moving s->wordtime from init() to realize()?
> > >=20
> > Hi  Philippe,  thanks for your reply!
> >=20
> > Because I found the variable wordtime is usually used with fifo_timeout=
_timer.
> > Eg, they are used together in the exynos4210_uart_rx_timeout_set functi=
on.
> >=20
> > I didn't find anything wrong with wordtime in the realize().
> > Does it have any other effects?
>=20
> IIUC when we use both init() and realize(), realize() should only contain=
s
> on code that consumes the object properties... But maybe the design is no=
t
> clear. Then why not move all the init() code to realize()?

Normally I would recommend the opposite: delay as much as
possible to realize(), to avoid unwanted side effects when (e.g.)
running qom-list-properties.

But as s->wordtime is a simple struct field (that we could even
decide to expose to the outside as a read-only QOM property), it
doesn't really matter.  Personally, I would keep it where it is
just to avoid churn.

--=20
Eduardo


