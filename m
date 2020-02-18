Return-Path: <SRS0=v1sw=4G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F015FC34026
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 09:30:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B97F4206EF
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 09:30:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XFDEn6bM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B97F4206EF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58866 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3zDH-0005BC-W7
	for qemu-devel@archiver.kernel.org; Tue, 18 Feb 2020 04:30:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41260)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1j3zCY-0004XB-Vq
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 04:29:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1j3zCX-00080J-Kv
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 04:29:58 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:55389
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1j3zCX-0007zw-HH
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 04:29:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582018196;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QvwWWbk2wNRCtKvS/3pRfQIJZqAFG1GugwebnQqDjFA=;
 b=XFDEn6bMpiw6ULsnEGy+uiq4qiGxACY504QFQ2f5q79mR/J8jiaCh9m0OhS+gE+Vhc0R20
 p0EArWy/rwGo7iuPG3Jc9X8bECorBdSrssaY32XIjq5T4ERtGYSRidW7v/tJ9W6WGfz8Ke
 NTSaz5DbXiDXambSUCjuD9cm1JUbGLA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-222-MRpMCXrdNUedAX-w8Hxm2w-1; Tue, 18 Feb 2020 04:29:52 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DA120477;
 Tue, 18 Feb 2020 09:29:51 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-117-234.ams2.redhat.com
 [10.36.117.234])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 567A71001B07;
 Tue, 18 Feb 2020 09:29:46 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id AFE0411385C9; Tue, 18 Feb 2020 10:29:44 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH 1/2] hw/ipmi/bmc: Delay timer_new_ns() from init to
 realize to avoid memleaks
References: <20200215154706.19837-1-philmd@redhat.com>
 <20200215154706.19837-2-philmd@redhat.com>
 <CAFEAcA9cZHWziyk6VzfaxrqjCNNOmnmSkB=uuGJMp0TL521mAQ@mail.gmail.com>
 <8c4570e1-cd9b-9d33-2756-5c223df282ee@redhat.com>
 <CAFEAcA-hyEVPeT1wakaft6m3_WD9XG3eYFAwJJgoHRAZ1nntag@mail.gmail.com>
 <e530629d-c029-1d7c-b5b7-cdbbeb397a4d@redhat.com>
 <CAFEAcA-KzWv=_kZUPNE6yyUSA36XY+q91ihJ_xh4euJ9RsyaLA@mail.gmail.com>
 <c2ae28d4-3864-dfc6-2033-93bbd7aa865e@redhat.com>
 <b9f520ba-d279-6a46-1142-e82f415f3e8a@redhat.com>
 <CAFEAcA8AD30UPqDxZ6myimhsYsgRu9A8pTCnq7WoAXewKUDN8g@mail.gmail.com>
Date: Tue, 18 Feb 2020 10:29:44 +0100
In-Reply-To: <CAFEAcA8AD30UPqDxZ6myimhsYsgRu9A8pTCnq7WoAXewKUDN8g@mail.gmail.com>
 (Peter Maydell's message of "Mon, 17 Feb 2020 17:27:13 +0000")
Message-ID: <87v9o4gs53.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: MRpMCXrdNUedAX-w8Hxm2w-1
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
 QEMU Developers <qemu-devel@nongnu.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Peter Maydell <peter.maydell@linaro.org> writes:

> On Mon, 17 Feb 2020 at 17:20, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.=
com> wrote:
>> Quick check with TYPE_BITBAND which is a SysBus device, we have:
>>
>> static void bitband_realize(DeviceState *dev, Error **errp)
>> {
>>      BitBandState *s =3D BITBAND(dev);
>>
>>      if (!s->source_memory) {
>>          error_setg(errp, "source-memory property not set");
>>          return;
>>      }
>>
>>      address_space_init(&s->source_as, s->source_memory, "bitband-source=
");
>> }
>>
>> Do we need the equivalent:
>>
>> static void bitband_unrealize(DeviceState *dev, Error **errp)
>> {
>>      BitBandState *s =3D BITBAND(dev);
>>
>>      address_space_destroy(&s->source_as);
>> }
>>
>> Or instead mark the device user_creatable=3Dfalse because of the link to=
 a
>> TYPE_MEMORY_REGION?
>
> I don't believe that this device is user-creatable. The
> base class sysbus_device_class_init() sets user_creatable
> to false by default for all sysbus devices, and a sysbus
> device which wants to opt into being user-created has to
> set it to true.

As far as I can tell, you additionally have to
machine_class_allow_dynamic_sysbus_dev().  Sysbus is special.

> Also the device's type name string is "ARM,bitband-memory"
> and the -device option at least does not like the comma
> in the middle of the name, so I don't know how you'd
> create it on the command line even if it wasn't marked
> not user-creatable.

Double the comma.

If I remember correctly, the use of comma in type comes from IEEE-1275.
It's quite inappropriate for QEMU.


