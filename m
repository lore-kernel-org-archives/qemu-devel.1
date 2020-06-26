Return-Path: <SRS0=ZkAM=AH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 176E0C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 05:50:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D45582076E
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 05:50:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I5r9K3M5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D45582076E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58146 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1johG5-0000Tf-4e
	for qemu-devel@archiver.kernel.org; Fri, 26 Jun 2020 01:50:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40208)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1johFD-0008Ix-4A
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 01:49:47 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:40899
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1johFA-0006Jo-MQ
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 01:49:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593150582;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zBB5Kc01AV5iMpHBiKmtIDqnoeqJ0UIzbRx2RkA+DDE=;
 b=I5r9K3M5ZeFoCHoqoRacGnbff65apfdftJOrwGzUWK7SBIXwmQrJotTzRg5CCOa4Y+/qJZ
 TIXhsZ3xJhu64LQIfzuxFgRwEmRHOsRtztyI02kpV5lt3y/CgqvQiCrcwRQmij9DNDZpZl
 8KRB4c2EgBygFWc/3jhPVjE3CnJ2EOg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-451-iwNn_NUaO0-6x3-DFWqX6w-1; Fri, 26 Jun 2020 01:49:38 -0400
X-MC-Unique: iwNn_NUaO0-6x3-DFWqX6w-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B33681800D4A;
 Fri, 26 Jun 2020 05:49:36 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-121.ams2.redhat.com
 [10.36.112.121])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2206571671;
 Fri, 26 Jun 2020 05:49:36 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 810D311384D4; Fri, 26 Jun 2020 07:49:34 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Subject: Re: [PATCH v4 4/8] hw/misc/pca9552: Add a 'description' property for
 debugging purpose
References: <20200620225854.31160-1-f4bug@amsat.org>
 <20200620225854.31160-5-f4bug@amsat.org>
 <4d335933-9669-43e1-0966-5f0255142012@kaod.org>
 <34fe3d2b-6b41-0509-f172-5b45486fdf0c@amsat.org>
 <deccf836-48ef-7112-d66e-a8d3cc4a9681@kaod.org>
 <877dvv4pmg.fsf@dusky.pond.sub.org>
 <2d1b8b24-3b2c-d84e-8026-e369f6531247@amsat.org>
 <03da95ed-399d-53e2-c946-a45f1a771701@amsat.org>
Date: Fri, 26 Jun 2020 07:49:34 +0200
In-Reply-To: <03da95ed-399d-53e2-c946-a45f1a771701@amsat.org> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Thu, 25 Jun 2020 16:23:44
 +0200")
Message-ID: <87bll6tlzl.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.120; envelope-from=armbru@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/26 01:49:42
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Corey Minyard <cminyard@mvista.com>, Andrew Jeffery <andrew@aj.id.au>,
 qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 qemu-arm@nongnu.org, =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Joel Stanley <joel@jms.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> writes:

> On 6/25/20 10:12 AM, Philippe Mathieu-Daud=C3=A9 wrote:
>> On 6/25/20 8:37 AM, Markus Armbruster wrote:
>>> C=C3=A9dric Le Goater <clg@kaod.org> writes:
>>>
>>>> On 6/22/20 10:31 AM, Philippe Mathieu-Daud=C3=A9 wrote:
>>>>> On 6/22/20 8:27 AM, C=C3=A9dric Le Goater wrote:
>>>>>> On 6/21/20 12:58 AM, Philippe Mathieu-Daud=C3=A9 wrote:
>>>>>>> Add a description field to distinguish between multiple devices.
>>>
>>> Pardon my lack of imagination: how does this help you with debugging?
>>=20
>> Ah, the patch subject is indeed incorrect, this should be:
>> "... for *tracing* purpose" (I use tracing when debugging).
>>=20
>> In the next patch, we use the 'description' property:
>>=20
>> +# pca9552.c
>> +pca9552_gpio_status(const char *description, const char *buf) "%s GPIOs
>> 0-15 [%s]"
>>=20
>> So when the machine has multiple PCA9552 and guest accesses both,
>> we can distinct which one is used. For me having "pca1" / "pca0"
>> is easier to follow than the address of the QOM object.
>>=20
>>>
>>>>>> Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>
>>>>>>
>>>>>> Could it be a QOM attribute ?=20
>>>>>
>>>>> What do you call a 'QOM attribute'?
>>>>> Is it what qdev properties implement?
>>>>> (in this case via DEFINE_PROP_STRING).
>>>>
>>>> I meant a default Object property, which would apply to all Objects.=
=20
>>>
>>> Good point.  Many devices have multiple component objects of the same
>>> type.
>>>
>>>> What you did is fine, so :
>>>>
>>>> Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>
>>>>
>>>> but, may be, a well defined child name is enough for the purpose.
>>>
>>> object_get_canonical_path() returns a distinct path for each (component=
)
>>> object.  The path components are the child property names.
>>>
>>> Properties can have descriptions: object_property_set_description().
>>=20
>> TIL object_property_set_description :>
>>=20
>> Ah, there is no equivalent object_property_get_description(),
>> we have to use object_get_canonical_path(). Hmm, not obvious.
>>=20
>>>
>>> Sufficient?
>>=20
>> I don't know... This seems a complex way to do something simple...
>> This is already a QDEV. Having to use QOM API seems going
>> backward, since we have the DEFINE_PROP_STRING() macros available
>> in "hw/qdev-properties.h".
>>=20
>> Maybe I'm not seeing the advantages clearly. I'll try later.
>
> The canonical path is not very helpful in trace log...

Why?

Okay, I checked the code.  Since the devices in question don't get a
composition tree parent assigned, realize puts them in the
/machine/unattached orphanage.  The canonical path is something like
"/machine/unattached/device[6]", which is less than clear.

The components of the canonical path are the names of the QOM child
properties.  object_get_canonical_path_component() returns the last one,
in this case "device[6]".

If we made the devices QOM children of some other device, we could name
the child properties "pca0" and "pca1".
object_get_canonical_path_component() would then return the strings you
want to see.

We make a device a QOM child of some QOM parent device only if the child
is a component device of the parent (hence the name "composition
tree").

Are these devices integral components of something else, or are they
separate chips?

> The description I set matches the hardware definitions
> and is easier to follow, see patch #6 (where it is set)
> where the description comes from:
>
> https://www.mail-archive.com/qemu-devel@nongnu.org/msg714658.html
>
>   Description name taken from:
>   https://github.com/open-power/witherspoon-xml/blob/master/witherspoon.x=
ml
>
> So in this particular case I don't find the canonical pathname
> practical (from an hardware debugging perspective).

Personally, I'd be content with i2c bus and address for debugging
purposes.

The i2c buses *are* components: canonical paths look like
"/machine/soc/i2c/aspeed.i2c.3".  The combination of
object_get_canonical_path_component(dev) and
object_property_get_uint(dev, "address", &error_abort) identifies any
i2c device on this machine, not just the two you decorate with a
description string.


