Return-Path: <SRS0=/hVT=5E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F9A3C4332D
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2020 07:02:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A3D720714
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2020 07:02:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J5ystxaY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A3D720714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34074 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEpCF-0001GG-8V
	for qemu-devel@archiver.kernel.org; Thu, 19 Mar 2020 03:02:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41100)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jEpBL-0000q3-4X
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 03:01:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1jEpBJ-0003a0-E2
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 03:01:30 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:54040)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1jEpBJ-0003Y6-99
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 03:01:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584601288;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HQGnhuPWkiyxBaYlw7XMm3vhxrUCyibzC+CGqCTjaRE=;
 b=J5ystxaYkc9GI1Lg2QLry9GPGeAR9WcoClpFRrbdW9dFv4DMrTc6o/+rwZciQ0MYiIpUQS
 hEV0YK8ozuq8+MqHxIIabeeSKbuN9kAYih82laOB0Mrs4jogertQXQ7s/WvqRXqrRUwGgs
 6T6F974iLwIeBxFthYSMWlkxTwAATno=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-255-5fVzutVBNUyyZmE9VvWFKQ-1; Thu, 19 Mar 2020 03:01:24 -0400
X-MC-Unique: 5fVzutVBNUyyZmE9VvWFKQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8A0F9107ACCA;
 Thu, 19 Mar 2020 07:01:22 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-130.ams2.redhat.com
 [10.36.112.130])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 478E862673;
 Thu, 19 Mar 2020 07:01:21 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 9EF041138404; Thu, 19 Mar 2020 08:01:19 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v4 2/3] mac_via: fix incorrect creation of mos6522 device
 in mac_via
References: <20200305065422.12707-1-pannengyuan@huawei.com>
 <20200305065422.12707-3-pannengyuan@huawei.com>
 <CAFEAcA_twjUHpvf5ZpzA_bKyf8MZ4BuSY0MvNTgSEyVTYf9mXQ@mail.gmail.com>
 <0b2d3222-d122-e0db-db04-1c4e3028f8f8@huawei.com>
 <CAFEAcA9PQd=PwuF+j=3kOA_eCiRd_8TLEwPx8qB-jWvV_9CcMQ@mail.gmail.com>
 <0c3ae5aa-36c3-a809-4a42-159348f44780@huawei.com>
 <CAFEAcA8_RkECOT=YJ3ML0wxBrKiqVw=CssORU=jyryfcNueB0w@mail.gmail.com>
 <871rq08tn9.fsf@dusky.pond.sub.org>
 <eca27715-554d-2c2e-5e58-ffd01abb654c@ilande.co.uk>
 <e1ae65dd-f9cd-b0ee-0ea6-f3c2b010fdab@redhat.com>
 <87tv2p8y5j.fsf@dusky.pond.sub.org>
 <3f512e33-5875-eee4-bbe8-61e7b313743d@redhat.com>
 <87mu8g3kgj.fsf@dusky.pond.sub.org>
 <bd83fe53-6541-b04d-04d9-76ddd29e2b99@redhat.com>
 <875zf1ak9e.fsf@dusky.pond.sub.org>
 <d94927af-eb46-f704-6658-e3f321c4d8ed@redhat.com>
 <87d0997lei.fsf@dusky.pond.sub.org>
 <37da8765-267e-948b-a96f-24c43be7573f@redhat.com>
Date: Thu, 19 Mar 2020 08:01:19 +0100
In-Reply-To: <37da8765-267e-948b-a96f-24c43be7573f@redhat.com> (Paolo
 Bonzini's message of "Wed, 18 Mar 2020 17:44:36 +0100")
Message-ID: <87v9n025hc.fsf@dusky.pond.sub.org>
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 "Daniel P. =?utf-8?Q?Berrang?= =?utf-8?Q?=C3=A9?=" <berrange@redhat.com>,
 zhanghailiang <zhang.zhanghailiang@huawei.com>,
 Pan Nengyuan <pannengyuan@huawei.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Laurent Vivier <laurent@vivier.eu>, QEMU Developers <qemu-devel@nongnu.org>,
 Euler Robot <euler.robot@huawei.com>, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Paolo Bonzini <pbonzini@redhat.com> writes:

> On 18/03/20 16:06, Markus Armbruster wrote:
>>> - object initialization should cause no side effects outside the subtre=
e
>>> of the object
>>=20
>> object_initialize_child() and its users like sysbus_init_child_obj()
>> violate this rule: they add a child property to the subtree's parent.
>> Correct?
>
> At least object_initialize_child() adds the property to the object
> itself, so it's fine.

It seems to

1. Initialize @childobj
2. Set a bunch of properties
3. Add the child property to @parentobj
4. Call .complete() if it's a TYPE_USER_CREATABLE
5. Adjust reference count

Step 3. modifies outside the sub-tree rooted at @childobj.  What am I
missing?

Hmm, maybe this: using object_initialize_child() when initializing
@parentobj is fine; while object_initialize_child() leaves the sub-tree
rooted at @childobj, it still stays within the sub-tree rooted at
@parentobj.

If this is how the function must be used, its contract should spell it
out!

A review of existing uses for misuses may be in order.

> sysbus_init_child_obj() adds a link to the object to the sysbus object
> (via qdev_set_parent_bus/bus_add_child).  This does violate the rule.
> However, currently we have:
>
> - create link on qdev_set_parent_bus, before realizing
>
> - remove link on device_unparent, after unrealizing

By "create link", do you mean bus_add_child() in qdev_set_parent_bus()?

By "remove link", do you mean bus_remove_child() in device_unparent()?

> which makes the device setup even more complicated than necessary.  In
> other words I don't think the bug is in the function, instead it
> probably makes sense to do something else:
>
> - create link in device_set_realized, before calling ->pre_plug (undo on
> failure)
>
> - remove link in device_set_realized, after calling ->unrealize (if it
> succeeds)
>
> and leave sysbus_init_child_obj() as is.

I'm barely following you.  Me reviewing an actual patch could help.

>>> - setting properties can cause side effects outside the subtree of the
>>> object (e.g. marking an object as "in use"), but they must be undone by
>>> finalization.
>>=20
>> Textbook example is the 1:1 connection between device frontend and
>> backend: block frontend's property "drive", char frontend's property
>> "chardev", NIC frontend property "netdev", ...
>>=20
>> Can we come up with some guardrails for what property setting may do?
>> Affecting guest-visible state is off limits.  What else is?
>
> Yes, guest-visible state is off limits until realization.
>
>>> - realization can also cause side effects outside the subtree of the
>>> object, but if unrealization is possible, they must be undone by
>>> unrealization. if an object is realized and unrealization is not
>>> possible, finalization will never run (and in that case, side effects o=
f
>>> realization need not be undone at all).
>>=20
>> One possible answer the question what should be done in realize() is
>> whatever must not be done earlier.  Is that the best we can do?
>
> That's the lower bound of descriptivity.  The upper bound is anything
> that is visible from the guest.  The truth could be in the middle.

Can we set aside a bit of time to write docs/devel/qom.rst together?  I
know object.h is lovingly commented, but unless you already know how QOM
works, you're drowning in detail there.  You'd have to provide most of
the contents, I'm afraid, because you know so much more about it.  Could
save you time in the long run, though: fewer questions to answer, fewer
mistakes to correct.


