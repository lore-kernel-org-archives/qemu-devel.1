Return-Path: <SRS0=ry7b=4B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B8EEC3B18B
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 14:30:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 29A9620873
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 14:30:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RsyVf6sm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29A9620873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53184 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2FVB-0004ZJ-BW
	for qemu-devel@archiver.kernel.org; Thu, 13 Feb 2020 09:30:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57660)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1j2FU5-0003Yx-9J
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 09:28:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1j2FU3-0005LY-VD
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 09:28:53 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:41468
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1j2FU3-0005JD-Qb
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 09:28:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581604131;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RBSzIVY1Yxxy+SMOPuUm9xVNxtbGI4btvDOaPLwtk5s=;
 b=RsyVf6smgpruS4YBMdG5p6MvafqCFeTLVj8JXh68Rs0xsOlL4KUS5TuIP70aeh+OYrS/RR
 2AcS1Hc5Qv5bNdpjOlOKL0TwPwVoIkWVMcWIeN2uzQtGJL6Jb+aFKLehe1hAw0+pAeDz0H
 3rAPN7RR05v8fY4LFJideh1q1lhiSOs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-210-sZg428NbOd2-gaHU3wFEDg-1; Thu, 13 Feb 2020 09:28:46 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 09F1B8E9EBA;
 Thu, 13 Feb 2020 14:28:45 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-117-234.ams2.redhat.com
 [10.36.117.234])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9F01919C70;
 Thu, 13 Feb 2020 14:28:32 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 19BB911385C9; Thu, 13 Feb 2020 15:28:31 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Eduardo Habkost <ehabkost@redhat.com>
Subject: Re: [PATCH] hw/char/exynos4210_uart: Fix memleaks in
 exynos4210_uart_init
References: <20200212033641.249560-1-kuhn.chenqun@huawei.com>
 <ce5d39c0-d532-4b54-a39c-01c9c97cbb59@redhat.com>
 <7412CDE03601674DA8197E2EBD8937E83B1163F4@dggemm531-mbx.china.huawei.com>
 <99531e05-f8fc-ef0a-ca62-6d477c899e78@redhat.com>
 <20200212161957.GA5028@habkost.net>
Date: Thu, 13 Feb 2020 15:28:31 +0100
In-Reply-To: <20200212161957.GA5028@habkost.net> (Eduardo Habkost's message of
 "Wed, 12 Feb 2020 11:19:57 -0500")
Message-ID: <87r1yy4l4g.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: sZg428NbOd2-gaHU3wFEDg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
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
Cc: "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 Zhanghailiang <zhang.zhanghailiang@huawei.com>,
 "i.mitsyanko@gmail.com" <i.mitsyanko@gmail.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-trivial@nongnu.org" <qemu-trivial@nongnu.org>,
 "Chenqun \(kuhn\)" <kuhn.chenqun@huawei.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Eduardo Habkost <ehabkost@redhat.com> writes:

> On Wed, Feb 12, 2020 at 08:39:55AM +0100, Philippe Mathieu-Daud=C3=A9 wro=
te:
>> Cc'ing Eduardo & Markus.
>>=20
>> On 2/12/20 7:44 AM, Chenqun (kuhn) wrote:
>> > > -----Original Message-----
>> > > From: Philippe Mathieu-Daud=C3=A9 [mailto:philmd@redhat.com]
>> > > Sent: Wednesday, February 12, 2020 2:16 PM
>> > > To: Chenqun (kuhn) <kuhn.chenqun@huawei.com>; qemu-
>> > > devel@nongnu.org; i.mitsyanko@gmail.com; peter.maydell@linaro.org
>> > > Cc: qemu-trivial@nongnu.org; Zhanghailiang
>> > > <zhang.zhanghailiang@huawei.com>
>> > > Subject: Re: [PATCH] hw/char/exynos4210_uart: Fix memleaks in
>> > > exynos4210_uart_init
>> > >=20
>> > > On 2/12/20 4:36 AM, kuhn.chenqun@huawei.com wrote:
>> > > > From: Chen Qun <kuhn.chenqun@huawei.com>
>> > > >=20
>> > > > It's easy to reproduce as follow:
>> > > > virsh qemu-monitor-command vm1 --pretty '{"execute":
>> > > > "device-list-properties", "arguments":{"typename":"exynos4210.uart=
"}}'
>> > > >=20
>> > > > ASAN shows memory leak stack:
>> > > >     #1 0xfffd896d71cb in g_malloc0 (/lib64/libglib-2.0.so.0+0x571c=
b)
>> > > >     #2 0xaaad270beee3 in timer_new_full /qemu/include/qemu/timer.h=
:530
>> > > >     #3 0xaaad270beee3 in timer_new /qemu/include/qemu/timer.h:551
>> > > >     #4 0xaaad270beee3 in timer_new_ns /qemu/include/qemu/timer.h:5=
69
>> > > >     #5 0xaaad270beee3 in exynos4210_uart_init
>> > > /qemu/hw/char/exynos4210_uart.c:677
>> > > >     #6 0xaaad275c8f4f in object_initialize_with_type /qemu/qom/obj=
ect.c:516
>> > > >     #7 0xaaad275c91bb in object_new_with_type /qemu/qom/object.c:6=
84
>> > > >     #8 0xaaad2755df2f in qmp_device_list_properties
>> > > > /qemu/qom/qom-qmp-cmds.c:152
>> > > >=20
>> > > > Reported-by: Euler Robot <euler.robot@huawei.com>
>> > > > Signed-off-by: Chen Qun <kuhn.chenqun@huawei.com>
>> > > > ---
>> > > >    hw/char/exynos4210_uart.c | 8 ++++----
>> > > >    1 file changed, 4 insertions(+), 4 deletions(-)
>> > > >=20
>> > > > diff --git a/hw/char/exynos4210_uart.c b/hw/char/exynos4210_uart.c
>> > > > index 25d6588e41..5048db5410 100644
>> > > > --- a/hw/char/exynos4210_uart.c
>> > > > +++ b/hw/char/exynos4210_uart.c
>> > > > @@ -674,10 +674,6 @@ static void exynos4210_uart_init(Object *obj)
>> > > >        SysBusDevice *dev =3D SYS_BUS_DEVICE(obj);
>> > > >        Exynos4210UartState *s =3D EXYNOS4210_UART(dev);
>> > > >=20
>> > > > -    s->fifo_timeout_timer =3D timer_new_ns(QEMU_CLOCK_VIRTUAL,
>> > > > -                                         exynos4210_uart_timeout_=
int, s);
>> > > > -    s->wordtime =3D NANOSECONDS_PER_SECOND * 10 / 9600;
>> > >=20
>> > > Why are you moving s->wordtime from init() to realize()?
>> > >=20
>> > Hi  Philippe,  thanks for your reply!
>> >=20
>> > Because I found the variable wordtime is usually used with fifo_timeou=
t_timer.
>> > Eg, they are used together in the exynos4210_uart_rx_timeout_set funct=
ion.
>> >=20
>> > I didn't find anything wrong with wordtime in the realize().
>> > Does it have any other effects?
>>=20
>> IIUC when we use both init() and realize(), realize() should only contai=
ns
>> on code that consumes the object properties... But maybe the design is n=
ot
>> clear. Then why not move all the init() code to realize()?
>
> Normally I would recommend the opposite: delay as much as
> possible to realize(), to avoid unwanted side effects when (e.g.)
> running qom-list-properties.

Sadly, our documentation on device initialization and realization is
rather sparse, and developers are left guessing.  Their guesses are
often based on what existing code does.  Some of the existing code even
gets things right.

A few rules from the top of my head:

* Creating and immediately destroying an object must be safe and free of
  side effects: initialization may only touch the object itself, and
  finalization must clean up everything initialization creates.

* unrealize() must clean up everything realize() creates.

* Since initialization cannot fail, code that needs to fail gracefully
  must live in realize().

* Since property values get set between initialization and realization,
  code that uses property values must live in realize().

* Dynamic properties have to be created in initialization to be visible
  in introspection.

> But as s->wordtime is a simple struct field (that we could even
> decide to expose to the outside as a read-only QOM property), it
> doesn't really matter.  Personally, I would keep it where it is
> just to avoid churn.


