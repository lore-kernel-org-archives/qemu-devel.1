Return-Path: <SRS0=zL9l=BA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 801D2C433E6
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2020 09:56:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A36920729
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2020 09:56:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TiddanDK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A36920729
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58210 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jxp0r-0007R2-H0
	for qemu-devel@archiver.kernel.org; Tue, 21 Jul 2020 05:56:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44970)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jxozk-0006jR-AW
 for qemu-devel@nongnu.org; Tue, 21 Jul 2020 05:55:32 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:52295
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jxozh-0005ls-Dg
 for qemu-devel@nongnu.org; Tue, 21 Jul 2020 05:55:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595325328;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eo8swKKlxLLv/Ydaq/Ly0zHq7IqIKqQ7OIOeJZv8ltk=;
 b=TiddanDKMi2K6unEs7N2ODTdJBGU/sBw0371JKoAB0jirvqRZDHMB5fYwb2WUN02kdZMLg
 sKirEv9igwsHuCnXYdiyzx4Up0Itdn1tchYhOnOFv5NUGQ+ymb7fcZfNHJxPTfbj+RjuOB
 5dT5kjX7PEW4PnOVC1YIh/fIUOQEImc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-278-tSsqqvo5NzKitirhPF0nCw-1; Tue, 21 Jul 2020 05:55:24 -0400
X-MC-Unique: tSsqqvo5NzKitirhPF0nCw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 19D3858;
 Tue, 21 Jul 2020 09:55:23 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-143.ams2.redhat.com
 [10.36.112.143])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 811575C1BD;
 Tue, 21 Jul 2020 09:55:22 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 0BEB6111CA27; Tue, 21 Jul 2020 11:55:21 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Subject: Re: [PATCH-for-5.1] hw/misc/aspeed_sdmc: Fix incorrect memory size
References: <20200720095829.22839-1-f4bug@amsat.org>
 <ed5e6bd0-0962-b182-3348-d3c6655ef35e@kaod.org>
 <f7dc7d48-6fd7-e1ba-f94b-cd2764490eb7@amsat.org>
 <877duxb819.fsf@dusky.pond.sub.org>
 <cf4153b1-e92d-d12a-6535-c4cf40d87953@amsat.org>
Date: Tue, 21 Jul 2020 11:55:20 +0200
In-Reply-To: <cf4153b1-e92d-d12a-6535-c4cf40d87953@amsat.org> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Tue, 21 Jul 2020 11:06:16
 +0200")
Message-ID: <871rl59oqf.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.61; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/21 01:26:46
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=unavailable autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Andrew Jeffery <andrew@aj.id.au>,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, Joel Stanley <joel@jms.id.au>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> writes:

> On 7/21/20 10:13 AM, Markus Armbruster wrote:
>> Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> writes:
>>=20
>>> On 7/20/20 6:07 PM, C=C3=A9dric Le Goater wrote:
>>>> On 7/20/20 11:58 AM, Philippe Mathieu-Daud=C3=A9 wrote:
>>>>> The SDRAM Memory Controller has a 32-bit address bus, thus
>>>>> supports up to 4 GiB of DRAM. There is a signed to unsigned
>>>>> conversion error with the AST2600 maximum memory size:
>>>>>
>>>>>   (uint64_t)(2048 << 20) =3D (uint64_t)(-2147483648)
>>>>>                          =3D 0xffffffff40000000
>>>>>                          =3D 16 EiB - 2 GiB
>>>>>
>>>>> Fix by using the IEC suffixes which are usually safer, and add
>>>>> a check to verify the memory is valid. This would have catched
>>=20
>> caught
>>=20
>>>>> this bug:
>>>>>
>>>>>     Unexpected error in aspeed_sdmc_realize() at hw/misc/aspeed_sdmc.=
c:261:
>>>>>     qemu-system-arm: Invalid RAM size 16 EiB
>>>>
>>>> Indeed :/
>>>>
>>>>>
>>>>> Fixes: 1550d72679 ("aspeed/sdmc: Add AST2600 support")
>>>>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>>>>> ---
>>>>>  hw/misc/aspeed_sdmc.c | 12 +++++++++---
>>>>>  1 file changed, 9 insertions(+), 3 deletions(-)
>>>>>
>>>>> diff --git a/hw/misc/aspeed_sdmc.c b/hw/misc/aspeed_sdmc.c
>>>>> index 0737d8de81..76dd7e6a20 100644
>>>>> --- a/hw/misc/aspeed_sdmc.c
>>>>> +++ b/hw/misc/aspeed_sdmc.c
>>>>> @@ -256,6 +256,12 @@ static void aspeed_sdmc_realize(DeviceState *dev=
, Error **errp)
>>>>>      AspeedSDMCClass *asc =3D ASPEED_SDMC_GET_CLASS(s);
>>>>> =20
>>>>>      s->max_ram_size =3D asc->max_ram_size;
>>>>> +    if (s->max_ram_size >=3D 4 * GiB) {
>>>>> +        char *szstr =3D size_to_str(s->max_ram_size);
>>>>> +        error_setg(errp, "Invalid RAM size %s", szstr);
>>>>> +        g_free(szstr);
>>>>> +        return;
>>>>> +    }
>>>>>
>>>>
>>>> I would put an assert() since the max RAM size is not user configurabl=
e.=20
>>>
>>> As you wish, at this point I'm completely lost with error reporting.
>>=20
>> :-/
>>=20
>>> Per the manual
>>> (https://www.mail-archive.com/qemu-devel@nongnu.org/msg723217.html):
>>>
>>>  "Many, many devices neglect to clean up properly on error, and get awa=
y
>>>   with it only because all callers treat errors as fatal.
>>>
>>>   If you decide to take cleanup shortcuts, say because the cleanup is
>>>   untestable, consider adding a comment at least."
>>>
>>> So I'll go for address + comment:
>>>
>>>   assert(s->max_ram_size < 4 * GiB); /* 32-bit address bus */
>>=20
>> Makes sense.
>>=20
>> Note this is *not* a cleanup shortcut, at least not the kind I had in
>> mind.
>>=20
>> What I had in mind is unclean failure, i.e. returning on error without
>> proper cleanup: revert changes made so far, free resources.  This is
>> *wrong*.  But the wrongness doesn't matter when all callers treat errors
>> as fatal.
>>=20
>> Checking an impossible condition with assert() is better than treating
>> it as an error and bungling its handling.  If you treat it as an error,
>> do it properly.  Since I'm quite skeptical about the chances of pulling
>> off "properly" for untestable things, I prefer assertions.
>>=20
>> There's another reason.  User errors need to be handled gracefully.
>> Programming errors should (in my opinion) trigger abort(), so they get
>> fixed.
>>=20
>> When the spot that detects the error can't know which kind it is, you
>> have to fail cleanly and let the caller decide how to handle the error.
>>=20
>> Example: object_property_find() errors out when the property doesn't
>> exist.  This may be a programming error, e.g. a well-known property
>> isn't found, because a programmer mistyped the property name.  Or it may
>> be a user error, e.g. a user mistyped the property name argument of
>> qom-get.
>>=20
>> When functions have multiple failure modes, and only some of them are
>> programming errors, the caller typically can't tell them apart, and errs
>> on the side of user error.  Programming errors then get reported as
>> (typically confusing!) user errors.
>
> A big part of your reply is worth adding in a "How to correctly use the
> Error* propagation API for dummies" in docs/devel document.

Right now, that document lives in error.h.  Has it outgrown that home?

>> The #1 reason for such awkward functions is lazy thinking + eager
>> typing: by treating anything that can go wrong as an error for the
>> caller to handle, I can replace thinking about what may go wrong and
>> what must not go wrong by typing up a bunch of error paths.  Great time
>> saver as long as I stick to the time-honored strategy of not bothering
>> to test my error paths.
>
> Not all are easily testable :( Or do you have a recomendation? Like
> forcing an error in the code while developing, so the path is checked?

I prefer to at least understand how errors can happen.  The
understanding often leads to a way to test, or to the realization that
it's actually a programming error.

When the way to test requires some "unobtanium", i.e. hardware or
software I can't access or set up with reasonable effort, I feel okay
adding mockup code for testing, as a best effort.  Proper test coverage
is then up to the people with the necessary access and knowledge.

There will always be the occasional edge case where you have to settle
for less than proper testing.  That's okay, life is short.  All I really
ask for is to at least *think* about the error paths and their testing.


