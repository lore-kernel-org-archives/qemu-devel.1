Return-Path: <SRS0=mmJ2=A2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 362E3C433E4
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2020 08:33:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0460E206D5
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2020 08:33:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QUowBz1W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0460E206D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36248 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvcqs-00065K-An
	for qemu-devel@archiver.kernel.org; Wed, 15 Jul 2020 04:33:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60636)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jvcq2-0005C8-5B
 for qemu-devel@nongnu.org; Wed, 15 Jul 2020 04:32:26 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:30186)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jvcpw-0002Co-3c
 for qemu-devel@nongnu.org; Wed, 15 Jul 2020 04:32:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594801938;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QxKYQUe/K6Gz0DOdZZxNbMSH4SROcUZgqAdUv98mQyU=;
 b=QUowBz1WoMmfpJqJ+23iBukF2uSRwFkxfoqjvbM/JcZzzu5l5Y9serduJHqCZGHfuvJS8B
 3p/IbeN4PEe7Q8Mc1ET8mokQR6YHhQ+taV5OeKMXCZW56ic6ETnlKux9bMkqzBmTDGnqlS
 dSJym8hHe3jszKWZ86pX47KOrbxJSbQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-3-yIMlYJLcMfK63HV4u_oO7Q-1; Wed, 15 Jul 2020 04:32:17 -0400
X-MC-Unique: yIMlYJLcMfK63HV4u_oO7Q-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1CEA219200C0;
 Wed, 15 Jul 2020 08:32:16 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-143.ams2.redhat.com
 [10.36.112.143])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E067F6FED1;
 Wed, 15 Jul 2020 08:32:15 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 58DE71370108; Wed, 15 Jul 2020 10:32:14 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: sysbus_create_simple Vs qdev_create
References: <CA+aXn+EkkyiXmKpNhbggy0pjKVpiHxa+TUqEnZLB4v_D=T+7tA@mail.gmail.com>
 <CA+aXn+HHXAmT6Ljj2tpovGAYSurHKSdtUL3y-89t31B0e7jpsA@mail.gmail.com>
 <adb25c78-2edc-115a-5264-ca9f97864ec7@redhat.com>
Date: Wed, 15 Jul 2020 10:32:14 +0200
In-Reply-To: <adb25c78-2edc-115a-5264-ca9f97864ec7@redhat.com> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Tue, 14 Jul 2020 19:02:24
 +0200")
Message-ID: <87365t18mp.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.81; envelope-from=armbru@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/15 02:01:40
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: qemu-devel@nongnu.org, Pratik Parvati <pratikp@vayavyalabs.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:

> Hi Pratik,
>
> On 7/14/20 6:17 PM, Pratik Parvati wrote:
>> Here is a brief context that might help you.
>> I am referring hw/arm/versatilepb.c
>>=20
>> The ARM PrimeCell UART (PL011) device created as follows
>>=20
>>     dev =3D qdev_create(NULL, "pl011");
>>     s =3D SYS_BUS_DEVICE(dev);
>>     qdev_prop_set_chr(dev, "chardev", chr);
>>     qdev_init_nofail(dev);
>>     sysbus_mmio_map(s, 0, addr);
>>     sysbus_connect_irq(s, 0, irq);

This is pl011_create().

Since recent merge commit 6675a653d2e, it's

       dev =3D qdev_new("pl011");
       s =3D SYS_BUS_DEVICE(dev);
       qdev_prop_set_chr(dev, "chardev", chr);
       sysbus_realize_and_unref(s, &error_fatal);
       sysbus_mmio_map(s, 0, addr);
       sysbus_connect_irq(s, 0, irq);

>>
>> Whereas the PL031 RTC device is created as
>>=20
>>     /* Add PL031 Real Time Clock. */
>>     sysbus_create_simple("pl031", 0x101e8000, pic[10]);
>>=20
>> What is the difference between these two devices creation?
>
> Both devices inherit SysBusDevice, which itself inherits QDev.

Yes: TYPE_SYS_BUS_DEVICE is a subtype of TYPE_DEVICE.

> You can create QDev objects with the qdev API, and
> SysBusDevice objects with the sysbus API.

Yes.

qdev_new(), qdev_realize_and_unref(), ... work with DeviceState * (the C
type of an instance of QOM TYPE_DEVICE).

sysbus_realize_and_unref(), ... work with SysBusDevice * (the C type of
an instance of QOM TYPE_SYS_BUS_DEVICE).

Since TYPE_SYS_BUS_DEVICE is a subtype of TYPE_DEVICE, you can safely
use qdev_ functions with sysbus devices.  Example: pl011_create() uses
qdev_new() to create a sysbus device.  That's fine.

> sysbus_create_simple() is a condensed helper, but only allow you
> to pass qemu_irq objects, not a 'chardev' property. So for this
> case you have to use the qdev API instead.

Yes.  It's a helper that combines creating a sysbus device, wiring up
one MMIO region and one IRQ, and realizing.  If you need to configure or
wire up more than that, you can't use it.

>> How do I know
>> which method to use while creating an object?
>
> SysBusDevice are plugged onto a bus. QDev aren't.
> The sysbus API results in smaller code, easier to review.

The general pattern for a stand-alone device is

    dev =3D qdev_new(type_name);
    set properties and wire up stuff...
    qdev_realize_and_unref(dev, bus, &err);

When this is to be done in device code, say to create a component
device, the split between .instance_init() and .realize() complicates
things.  If interested, ask and I'll explain.

There are quite a few wrappers around qdev_ functions for various
subtypes of TYPE_DEVICE.  Use them to make your code more concise and
easier to understand.  Example: sysbus_realize_and_unref().

There are also convenience functions that capture special cases of the
entire general pattern.  Example: sysbus_create_simple().

Hope this helps!


