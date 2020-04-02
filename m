Return-Path: <SRS0=DsKm=5S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 353D5C2BA15
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 13:52:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 043802073B
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 13:52:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YgSKFV1n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 043802073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40368 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jK0Gi-0005wE-5y
	for qemu-devel@archiver.kernel.org; Thu, 02 Apr 2020 09:52:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50977)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jK0Bw-000801-41
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 09:47:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1jK0Bu-0004HZ-ET
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 09:47:32 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:41891
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1jK0Bu-0004GQ-AA
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 09:47:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585835249;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pWD7O1HxTYjNj1puh1fmFI6Lsj+CFiJCyC/FAin4oTI=;
 b=YgSKFV1nwz5YubnlOY9C0CFLwu4DeABAEI7z5c0SZvWaaDjpHj+YcrVWJEe2VhQArSVcM4
 U+HUiqDkkwSBJZrN2adCxajD9gBRrtr8pFSzCKj3GiTlOvQGgX1Om74eKuZQuh5BXZcd1H
 qQEANjyL5c8ZFo9GLEWt8cNIFbGLYRg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-36-_hpKKDiBMeGSe3RGsJhZBA-1; Thu, 02 Apr 2020 09:47:16 -0400
X-MC-Unique: _hpKKDiBMeGSe3RGsJhZBA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 77DA6101FC6E;
 Thu,  2 Apr 2020 13:47:15 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-69.ams2.redhat.com
 [10.36.112.69])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 614F15ED3F;
 Thu,  2 Apr 2020 13:47:14 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id C40BC11385E2; Thu,  2 Apr 2020 15:47:12 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: Function-like macro with the same name as a typedef confuses
 Coccinelle
References: <87k12y5by1.fsf@dusky.pond.sub.org>
 <31eed279-5ef9-4d11-62de-51c0eeaff589@redhat.com>
Date: Thu, 02 Apr 2020 15:47:12 +0200
In-Reply-To: <31eed279-5ef9-4d11-62de-51c0eeaff589@redhat.com> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Thu, 2 Apr 2020 14:29:58
 +0200")
Message-ID: <871rp63spr.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:

> On 4/2/20 2:06 PM, Markus Armbruster wrote:
>> I discovered that Vladimir's auto-propagated-errp.cocci leaves
>> hw/arm/armsse.c unchanged, even though it clearly should change it.
>> Running spatch with --debug prints (among lots of other things)
>>
>>      let's go
>>      -------------------------------------------------------------------=
----
>>      -------------------------------------------------------------------=
----
>>      parse error
>>       =3D error in hw/arm/armsse.c; set verbose_parsing for more info
>>      badcount: 7
>>      bad: }
>>      bad:
>>      bad: static void nsccfg_handler(void *opaque, int n, int level)
>>      bad: {
>>      BAD:!!!!!     ARMSSE *s =3D ARMSSE(opaque);
>>      bad:
>>      bad:     s->nsccfg =3D level;
>>      bad: }
>>      parse error
>>
>> Alright, what's wrong with this?  ARMSSE is both a function-like macro
>> and a typedef:
>>
>>      #define ARMSSE(obj) OBJECT_CHECK(ARMSSE, (obj), TYPE_ARMSSE)
>>
>>      typedef struct ARMSSE {
>>          ...
>>      } ARMSSE;
>>
>> This appears to spook Coccinelle badly enough to skip code using ARMSSE.
>>
>> If I rename the macro to ARMSSE_() just for testing, it produces the
>> transformation I'd expect.
>>
>> Grepping for typedef names is bothersome, so I used ctags -x to build a
>> cross reference table, and searched that for function-like macros
>> clashing with typedefs.  Result:
>>
>> include/hw/arm/armsse.h:#define ARMSSE(obj) OBJECT_CHECK(ARMSSE, (obj), =
TYPE_ARMSSE)
>> include/hw/arm/armsse.h:} ARMSSE;
>> include/hw/block/swim.h:#define SWIM(obj) OBJECT_CHECK(SWIM, (obj), TYPE=
_SWIM)
>> include/hw/block/swim.h:} SWIM;
>> target/rx/cpu-qom.h:#define RXCPU(obj) \
>> target/rx/cpu.h:typedef struct RXCPU RXCPU;
>> target/s390x/translate.c:#define BD(N, BB, BD) { BB,  4, 0, FLD_C_b##N, =
FLD_O_b##N }, \
>> hw/audio/ac97.c:} BD;
>>
>> The last one is a name clash in unrelated files; should not bother
>> Coccinelle.
>>
>> The first three are due to QOM.  By convention, the name of the
>> function-like macro to convert to the QOM type is the QOM type in
>> ALL_CAPS.  Clash when the QOM type is ALL_CAPS already.
>
> To add to this list, another problem I'm having is with QOM interfaces.
>
> For example this line:
>
>   isa_bus_dma(bus, ISADMA(isa1), ISADMA(isa2));
>
> The definitions are:
>
> #define ISADMA(obj) INTERFACE_CHECK(IsaDma, (obj), TYPE_ISADMA)
> typedef struct IsaDma IsaDma;
>
> This is used as opaque pointer, so it compiles fine, but coccinelle is
> confused because the actual 'struct IsaDma' is never defined.

Can you give me an example where Coccinelle gets confused by it?

> The only 'documentation' I found about this is commit 00ed3da9b5 which
> describes this as 'common practice'.

We discussed this in the thread

    Subject: Issues around TYPE_INTERFACE
    To: qemu-devel@nongnu.org
    Date: Tue, 12 Mar 2019 11:50:54 +0100
    Message-ID: <87h8c82woh.fsf@dusky.pond.sub.org>

Perhaps start with Paolo's reply:

    Message-ID: <fdaa779c-ed79-647b-6038-3df2353fe502@redhat.com>
    https://lists.nongnu.org/archive/html/qemu-devel/2019-04/msg00749.html

I just suggested to have a future docs/devel/qom.rst cover the topic:

    Subject: Re: [PATCH v4 2/3] mac_via: fix incorrect creation of mos6522 =
device in mac_via
    Message-ID: <87369m3t18.fsf@dusky.pond.sub.org>


