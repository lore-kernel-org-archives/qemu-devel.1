Return-Path: <SRS0=DsKm=5S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 860EBC43331
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 13:41:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 51DF82078B
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 13:41:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OAnXXvAv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51DF82078B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40158 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jK05k-0003Z1-Hb
	for qemu-devel@archiver.kernel.org; Thu, 02 Apr 2020 09:41:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49609)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jK05A-00033j-06
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 09:40:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1jK057-0002j5-V9
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 09:40:31 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:41883
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1jK057-0002is-NZ
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 09:40:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585834828;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fPrH97uYA4nj/Hf8iwS+1vi+hqfz3ZFIH3Un/VX4YYg=;
 b=OAnXXvAvBhQTVXFwPpwjSvPnOnGHG1tSVas5djYeF8PcX8KB2rnB7AF2hm57jk49AMkUrk
 iiHun+cEP1hOrvVEvob7tbSDBlOKH3T1L4yK+PuRfwEYnl+Kh6eCfhje/IRgygWcGkj352
 26L5s1txks8lLVUXt1Nq5yFTgj7Bdws=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-96-oe02F-X6NqeCf3IyGeg_Jg-1; Thu, 02 Apr 2020 09:40:25 -0400
X-MC-Unique: oe02F-X6NqeCf3IyGeg_Jg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CB527107ACC9;
 Thu,  2 Apr 2020 13:40:23 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-69.ams2.redhat.com
 [10.36.112.69])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B79105D9C9;
 Thu,  2 Apr 2020 13:40:21 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id E064F11385E2; Thu,  2 Apr 2020 15:40:19 +0200 (CEST)
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
 <87v9n025hc.fsf@dusky.pond.sub.org>
 <5ae352b1-2653-c69f-f2b7-73e86b804d13@redhat.com>
Date: Thu, 02 Apr 2020 15:40:19 +0200
In-Reply-To: <5ae352b1-2653-c69f-f2b7-73e86b804d13@redhat.com> (Paolo
 Bonzini's message of "Thu, 19 Mar 2020 09:43:29 +0100")
Message-ID: <87369m3t18.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
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

> On 19/03/20 08:01, Markus Armbruster wrote:
>> Paolo Bonzini <pbonzini@redhat.com> writes:
>>=20
>>> On 18/03/20 16:06, Markus Armbruster wrote:
>>>>> - object initialization should cause no side effects outside the subt=
ree
>>>>> of the object
>>>>
>>>> object_initialize_child() and its users like sysbus_init_child_obj()
>>>> violate this rule: they add a child property to the subtree's parent.
>>>> Correct?
>>>
>>> At least object_initialize_child() adds the property to the object
>>> itself, so it's fine.
>>=20
>> It seems to
>>=20
>> 1. Initialize @childobj
>> 2. Set a bunch of properties
>> 3. Add the child property to @parentobj
>> 4. Call .complete() if it's a TYPE_USER_CREATABLE
>> 5. Adjust reference count
>>=20
>> Step 3. modifies outside the sub-tree rooted at @childobj.  What am I
>> missing?
>>=20
>> Hmm, maybe this: using object_initialize_child() when initializing
>> @parentobj is fine; while object_initialize_child() leaves the sub-tree
>> rooted at @childobj, it still stays within the sub-tree rooted at
>> @parentobj.
>>=20
>> If this is how the function must be used, its contract should spell it
>> out!
>
> Yes, this is what I meant.
>
>>>>> - realization can also cause side effects outside the subtree of the
>>>>> object, but if unrealization is possible, they must be undone by
>>>>> unrealization. if an object is realized and unrealization is not
>>>>> possible, finalization will never run (and in that case, side effects=
 of
>>>>> realization need not be undone at all).
>>>>
>>>> One possible answer the question what should be done in realize() is
>>>> whatever must not be done earlier.  Is that the best we can do?
>>>
>>> That's the lower bound of descriptivity.  The upper bound is anything
>>> that is visible from the guest.  The truth could be in the middle.
>>=20
>> Can we set aside a bit of time to write docs/devel/qom.rst together?  I
>> know object.h is lovingly commented, but unless you already know how QOM
>> works, you're drowning in detail there.  You'd have to provide most of
>> the contents, I'm afraid, because you know so much more about it.  Could
>> save you time in the long run, though: fewer questions to answer, fewer
>> mistakes to correct.
>
> Yes, this is sorely needed.  I will do it; if you have more random
> questions you'd like an answer for, that can help.  I can then stitch
> them together in a coherent text.

A year ago, we discussed QOM interfaces:

    Subject: Issues around TYPE_INTERFACE
    Message-ID: <87h8c82woh.fsf@dusky.pond.sub.org>

We touched naming conventions, the fact that interfaces can't have
state, how an interface type should be defined (even though it has no
state), and what it means to convert to such a type.

I'd love to see this covered in qom.rst.


