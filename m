Return-Path: <SRS0=CnYV=4F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D1A1C34022
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 19:37:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 08DDC20578
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 19:37:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QnCeZMd9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08DDC20578
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52078 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3mCW-0004Si-7L
	for qemu-devel@archiver.kernel.org; Mon, 17 Feb 2020 14:37:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56184)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1j3m9H-00075R-SX
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 14:33:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1j3m9F-0005Gp-4v
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 14:33:42 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:27309
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1j3m9E-0005GX-UM
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 14:33:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581968020;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=evv7hGCaEjWP3NFyQveQTAWSsDuWIdyR1deSn/adqqg=;
 b=QnCeZMd9XOw/tRgtN9zFY74UsWdnaNmTZQlN8BrWajQqqjhZlWlwx6KM9DJ7tERe53OStp
 BXVrR/gbgRHANJ4cGhDXOUmZdpJbIxdw+WC60exbB9QnJSzS788LKZFEKkzQVvP7RrZYdA
 3hxAaCZzh+Y+HILypBFtxL2sYq7/zOY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-370-1jMCkWymPTaxWB0hWHosIw-1; Mon, 17 Feb 2020 14:33:38 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4344C1005516;
 Mon, 17 Feb 2020 19:33:37 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-117-234.ams2.redhat.com
 [10.36.117.234])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5F91660BE1;
 Mon, 17 Feb 2020 19:33:30 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id D9A4611385C9; Mon, 17 Feb 2020 20:33:28 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH 1/2] hw/ipmi/bmc: Delay timer_new_ns() from init to
 realize to avoid memleaks
References: <20200215154706.19837-1-philmd@redhat.com>
 <20200215154706.19837-2-philmd@redhat.com>
 <CAFEAcA9cZHWziyk6VzfaxrqjCNNOmnmSkB=uuGJMp0TL521mAQ@mail.gmail.com>
 <8c4570e1-cd9b-9d33-2756-5c223df282ee@redhat.com>
 <CAFEAcA-hyEVPeT1wakaft6m3_WD9XG3eYFAwJJgoHRAZ1nntag@mail.gmail.com>
Date: Mon, 17 Feb 2020 20:33:28 +0100
In-Reply-To: <CAFEAcA-hyEVPeT1wakaft6m3_WD9XG3eYFAwJJgoHRAZ1nntag@mail.gmail.com>
 (Peter Maydell's message of "Mon, 17 Feb 2020 14:06:10 +0000")
Message-ID: <87k14lm2k7.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: 1jMCkWymPTaxWB0hWHosIw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, Corey Minyard <minyard@acm.org>,
 David Hildenbrand <david@redhat.com>, Pan Nengyuan <pannengyuan@huawei.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Peter Maydell <peter.maydell@linaro.org> writes:

> On Mon, 17 Feb 2020 at 13:48, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.=
com> wrote:
>>
>> On 2/17/20 2:25 PM, Peter Maydell wrote:
>
>> > So we now call timer_new in realize, and timer_del in unrealize,
>> > but timer_free in finalize. This seems unbalanced -- why not
>> > call timer_free in unrealize too, if we're moving things?
>> >
>> > Also, this is a case of code that's actually doing things right:
>> > we free the memory that we allocated in init in finalize. So
>> > we're not fixing any leak here, we're just moving code around
>> > (which is reasonable if we're trying to standardize on "call
>> > timer_new in realize, not init", but should be noted in the
>> > commit message).
>>
>> While I understand your point, I am confused because the documentation
>> on unrealize() and finalize() is rather scarce (and not obvious for
>> non-native english speaker). I think I'm not understanding QOM instance
>> lifetime well (in particular hotplug devices) so I will let this series =
go.
>
> Yes, the documentation is really not good at all. The
> basic structure as I understand it is that we have two-part
> creation and two-part destruction:
>  * instance_init is creation part 1
>  * realize is creation part 2
>  * unrealize is destruction part 1 and is the opposite of realize
>  * instance_finalize is destruction part 2 and is the
>    opposite of instance_init
>
> (Base QOM objects only have instance_init/instance_finalize;
> realize/unrealize exists only for DeviceState objects
> and their children.)

The split exists so you can set property values between instance_init()
and realize().  It's how qdev has always worked.  It permits setting
properties one by one even when this results in intermediate states
where invariants involving multiple property values are violated: delay
checking them until realize(), rely on them only while the device is
realized.

Note that both realize() and unrealize() can fail.  instance_init() and
instance_finalize() can't.

> ASCII-art state diagram:
>
>   [start] --instance_init-> [inited] --realize-> [realized]
>      ^                       |   ^                     |
>      \---instance_finalize---/   \-----unrealize-------/
>
> In practice the only sequences we really care about are:
>  instance_init; realize; unrealize; instance_finalize
>    (a full object creation-use-destruction cycle;
>     even if realize fails, unrealize will be called)
>  instance_init; realize
>    (a subset of the above: for non-hot-pluggable devices
>     we will never try to unrealize them, so this is
>     as far as it goes for most devices unless they
>     returned an error from their realize function)
>  instance_init; instance_finalize
>    (the monitor does this for introspection of an object
>     without actually wanting to create and use it; it's
>     also the basic lifecycle for non-DeviceState objects)

In theory, you can realize + unrealize multiple times.  It might even
work in practice sometimes.

> The difference between hot-pluggable and not is just
> whether it's valid to try to unrealize the device.
>
> We should definitely be clearer about what belongs in
> instance_init vs what belongs in realize. But where we
> have both a "do thing" and a "clean up that thing" task,
> we should put the cleanup code in the operation that is
> the pair of the operation we put the "do thing" code in
> (i.e. do thing in instance_init, clean it up in finalize;
> or do thing in realize, clean it up in unrealize).

Not doing so risks introspection leaks or double-frees.


