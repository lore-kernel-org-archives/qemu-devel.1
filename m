Return-Path: <SRS0=zL9l=BA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1B80C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2020 08:17:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8AE2C20720
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2020 08:17:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HTZKFbRb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8AE2C20720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32840 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jxnSZ-0001Av-R2
	for qemu-devel@archiver.kernel.org; Tue, 21 Jul 2020 04:17:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35548)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jxnOo-0003lJ-AO
 for qemu-devel@nongnu.org; Tue, 21 Jul 2020 04:13:18 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:33557
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jxnOk-0004hN-Mz
 for qemu-devel@nongnu.org; Tue, 21 Jul 2020 04:13:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595319193;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=etk9kK7oYy1kULz5mrxON5H4x+v0+bH7F22JnVaeOcs=;
 b=HTZKFbRbYCQrsrTwDp+EDPuRkKQlr226WmvUd2u8RlpdFKD5pwXiKnoa9o8Vf9cYxgyOVr
 nBy0M9drReEHnWXsGvXUz9eRPIgDLInlWsij1fH1oqBXygQMqtLDwVLgy3TBfuAGlMU0+9
 2WKEb8C0B6abCAl7EPrFvaswPPfLpZ4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-199-7bfwxjCOPDe_FEuCQls2eg-1; Tue, 21 Jul 2020 04:13:09 -0400
X-MC-Unique: 7bfwxjCOPDe_FEuCQls2eg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4A15A80046D;
 Tue, 21 Jul 2020 08:13:08 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-143.ams2.redhat.com
 [10.36.112.143])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B7E926933E;
 Tue, 21 Jul 2020 08:13:07 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 49D50111CA27; Tue, 21 Jul 2020 10:13:06 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Subject: Re: [PATCH-for-5.1] hw/misc/aspeed_sdmc: Fix incorrect memory size
References: <20200720095829.22839-1-f4bug@amsat.org>
 <ed5e6bd0-0962-b182-3348-d3c6655ef35e@kaod.org>
 <f7dc7d48-6fd7-e1ba-f94b-cd2764490eb7@amsat.org>
Date: Tue, 21 Jul 2020 10:13:06 +0200
In-Reply-To: <f7dc7d48-6fd7-e1ba-f94b-cd2764490eb7@amsat.org> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Mon, 20 Jul 2020 19:39:02
 +0200")
Message-ID: <877duxb819.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.81; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/21 03:39:19
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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

> On 7/20/20 6:07 PM, C=C3=A9dric Le Goater wrote:
>> On 7/20/20 11:58 AM, Philippe Mathieu-Daud=C3=A9 wrote:
>>> The SDRAM Memory Controller has a 32-bit address bus, thus
>>> supports up to 4 GiB of DRAM. There is a signed to unsigned
>>> conversion error with the AST2600 maximum memory size:
>>>
>>>   (uint64_t)(2048 << 20) =3D (uint64_t)(-2147483648)
>>>                          =3D 0xffffffff40000000
>>>                          =3D 16 EiB - 2 GiB
>>>
>>> Fix by using the IEC suffixes which are usually safer, and add
>>> a check to verify the memory is valid. This would have catched

caught

>>> this bug:
>>>
>>>     Unexpected error in aspeed_sdmc_realize() at hw/misc/aspeed_sdmc.c:=
261:
>>>     qemu-system-arm: Invalid RAM size 16 EiB
>>=20
>> Indeed :/
>>=20
>>>
>>> Fixes: 1550d72679 ("aspeed/sdmc: Add AST2600 support")
>>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>>> ---
>>>  hw/misc/aspeed_sdmc.c | 12 +++++++++---
>>>  1 file changed, 9 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/hw/misc/aspeed_sdmc.c b/hw/misc/aspeed_sdmc.c
>>> index 0737d8de81..76dd7e6a20 100644
>>> --- a/hw/misc/aspeed_sdmc.c
>>> +++ b/hw/misc/aspeed_sdmc.c
>>> @@ -256,6 +256,12 @@ static void aspeed_sdmc_realize(DeviceState *dev, =
Error **errp)
>>>      AspeedSDMCClass *asc =3D ASPEED_SDMC_GET_CLASS(s);
>>> =20
>>>      s->max_ram_size =3D asc->max_ram_size;
>>> +    if (s->max_ram_size >=3D 4 * GiB) {
>>> +        char *szstr =3D size_to_str(s->max_ram_size);
>>> +        error_setg(errp, "Invalid RAM size %s", szstr);
>>> +        g_free(szstr);
>>> +        return;
>>> +    }
>>>
>>=20
>> I would put an assert() since the max RAM size is not user configurable.=
=20
>
> As you wish, at this point I'm completely lost with error reporting.

:-/

> Per the manual
> (https://www.mail-archive.com/qemu-devel@nongnu.org/msg723217.html):
>
>  "Many, many devices neglect to clean up properly on error, and get away
>   with it only because all callers treat errors as fatal.
>
>   If you decide to take cleanup shortcuts, say because the cleanup is
>   untestable, consider adding a comment at least."
>
> So I'll go for address + comment:
>
>   assert(s->max_ram_size < 4 * GiB); /* 32-bit address bus */

Makes sense.

Note this is *not* a cleanup shortcut, at least not the kind I had in
mind.

What I had in mind is unclean failure, i.e. returning on error without
proper cleanup: revert changes made so far, free resources.  This is
*wrong*.  But the wrongness doesn't matter when all callers treat errors
as fatal.

Checking an impossible condition with assert() is better than treating
it as an error and bungling its handling.  If you treat it as an error,
do it properly.  Since I'm quite skeptical about the chances of pulling
off "properly" for untestable things, I prefer assertions.

There's another reason.  User errors need to be handled gracefully.
Programming errors should (in my opinion) trigger abort(), so they get
fixed.

When the spot that detects the error can't know which kind it is, you
have to fail cleanly and let the caller decide how to handle the error.

Example: object_property_find() errors out when the property doesn't
exist.  This may be a programming error, e.g. a well-known property
isn't found, because a programmer mistyped the property name.  Or it may
be a user error, e.g. a user mistyped the property name argument of
qom-get.

When functions have multiple failure modes, and only some of them are
programming errors, the caller typically can't tell them apart, and errs
on the side of user error.  Programming errors then get reported as
(typically confusing!) user errors.

The #1 reason for such awkward functions is lazy thinking + eager
typing: by treating anything that can go wrong as an error for the
caller to handle, I can replace thinking about what may go wrong and
what must not go wrong by typing up a bunch of error paths.  Great time
saver as long as I stick to the time-honored strategy of not bothering
to test my error paths.


