Return-Path: <SRS0=a3Gm=5D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72CB9C10DCE
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2020 07:00:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 34B122076A
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2020 07:00:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cCPtZ13S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34B122076A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46304 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jESgT-0003mb-BH
	for qemu-devel@archiver.kernel.org; Wed, 18 Mar 2020 03:00:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45101)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jESfp-0003M4-9k
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 02:59:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1jESfn-0004ce-4a
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 02:59:28 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:29646)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1jESfm-0004Tc-UE
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 02:59:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584514766;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=65EaxWF/UaSsGsnIDRqtZZG6yU0n4m7tttOmDa9hXEM=;
 b=cCPtZ13SHPNvUAFLfDOr+lVlSFUS9Qb7y9+BEFbId7+57uTmXp6f5qaZm6etK3G/dyCdfU
 7G4V4etnbK5/WOdCmRAjx7RrAj28b3de+u055Rdd6W9Y43j/X+YkS+yzdOU96EhLtzplCz
 CZXHYMh1HUy5Mnv3RKmTkEf4ZhJHh+g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-471-IuBNTobkPLuHEW7-AVO4xg-1; Wed, 18 Mar 2020 02:59:23 -0400
X-MC-Unique: IuBNTobkPLuHEW7-AVO4xg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A1C40477;
 Wed, 18 Mar 2020 06:59:22 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-130.ams2.redhat.com
 [10.36.112.130])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2A6D95D9E2;
 Wed, 18 Mar 2020 06:59:22 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id ACB6E1138404; Wed, 18 Mar 2020 07:59:20 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH v4 27/34] qemu-options: New -compat to set policy for
 deprecated interfaces
References: <20200317115459.31821-1-armbru@redhat.com>
 <20200317115459.31821-28-armbru@redhat.com>
 <f2466af3-a20d-94f7-950c-2d2cd2e919ae@redhat.com>
Date: Wed, 18 Mar 2020 07:59:20 +0100
In-Reply-To: <f2466af3-a20d-94f7-950c-2d2cd2e919ae@redhat.com> (Eric Blake's
 message of "Tue, 17 Mar 2020 16:05:47 -0500")
Message-ID: <87wo7icfnb.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
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
Cc: marcandre.lureau@gmail.com, qemu-devel@nongnu.org,
 mdroth@linux.vnet.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Eric Blake <eblake@redhat.com> writes:

> On 3/17/20 6:54 AM, Markus Armbruster wrote:
>> Policy is separate for input and output.
>>
>> Input policy can be "accept" (accept silently), or "reject" (reject
>> the request with an error).
>>
>> Output policy can be "accept" (pass on unchanged), or "hide" (filter
>> out the deprecated parts).
>>
>> Default is "accept".  Policies other than "accept" are implemented
>> later in this series.
>>
>> For now, -compat covers only syntactic aspects of QMP, i.e. stuff
>> tagged with feature 'deprecated'.  We may want to extend it to cover
>> semantic aspects, CLI, and experimental features.
>>
>> The option is experimental.
>
> On IRC, we decided that it's probably not worth shoe-horning this (and
> the rest of the series) into 5.0, given the experimental nature.

Yes.  I can't wait for having test suites try this, but releases and
impatience are not a good mix.

> Still, I'll go ahead and review, so we can settle on things early in
> 5.1.

Appreciated!

>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>
>> +++ b/qapi/compat.json
>> @@ -0,0 +1,51 @@
>> +# -*- Mode: Python -*-
>> +
>> +##
>> +# =3D Compatibility policy
>> +##
>> +
>> +##
>> +# @CompatPolicyInput:
>> +#
>> +# Policy for handling "funny" input.
>> +#
>> +# @accept: Accept silently
>> +# @reject: Reject with an error
>> +#
>> +# Since: 5.0
>
> Of course, now that we're slipping this, you'll have to s/5.0/5.1/g
> over the remaining patches.  I won't point it out further.

Acknowledged.

>> +##
>> +# @CompatPolicy:
>> +#
>> +# Policy for handling deprecated management interfaces.
>> +#
>> +# This is intended for testing users of the management interfaces.
>> +#
>> +# Limitation: covers only syntactic aspects of QMP, i.e. stuff tagged
>> +# with feature 'deprecated'.  We may want to extend it to cover
>> +# semantic aspects, CLI, and experimental features.
>
> Hiding/rejecting x- interfaces is probably the easiest of these, but I
> agree that leaving this open-ended to add further coverage (or even
> additional modes) is still reasonable.

Apropos experimental: we may choose to move from the x- naming
convention to a special feature flag "experimental".  That way, we don't
have to rename when we declare the thing stable.

>> +#
>> +# @deprecated-input: how to handle deprecated input (default 'accept')
>> +# @deprecated-output: how to handle deprecated output (default 'accept'=
)
>> +#
>> +# Since: 5.0
>> +##
>> +{ 'struct': 'CompatPolicy',
>> +  'data': { '*deprecated-input': 'CompatPolicyInput',
>> +            '*deprecated-output': 'CompatPolicyOutput' } }
>
> For example, adding
> '*experimental-input': 'CompatPolicyInput'
> would make it easy to hard-code failure on attempt to use x-* commands.

Exactly.

>> +++ b/include/qapi/compat-policy.h
>> @@ -0,0 +1,20 @@
>> +/*
>> + * Policy for handling "funny" management interfaces
>> + *
>> + * Copyright (C) 2019 Red Hat, Inc.
>
> You've had this in-tree for a while. I'll leave it up to you if you
> want to add 2020.

I want to.  Hope I remember when I respin.

>> + *
>> + * Authors:
>> + *  Markus Armbruster <armbru@redhat.com>,
>> + *
>
> Ending with a comma is odd.  Is the Authors: snippet even necessary,
> or are we better off relying on git history (which tends to be more
> accurate anyway)?

The comma is an accident.

The Authors section is custom, not necessity.

>> + * This work is licensed under the terms of the GNU GPL, version 2 or
>> + * later.  See the COPYING file in the top-level directory.
>> + */
>
> Are we trying to use SPDX tags in more files?

No idea :)

>> +++ b/qemu-options.hx
>> @@ -3357,6 +3357,26 @@ DEFHEADING()
>>     DEFHEADING(Debug/Expert options:)
>>   +DEF("compat", HAS_ARG, QEMU_OPTION_compat,
>> +    "-compat [deprecated-input=3Daccept|reject][,deprecated-output=3Dac=
cept|hide]\n"
>> +    "                Policy for handling deprecated management interfac=
es\n",
>> +    QEMU_ARCH_ALL)
>> +SRST
>> +``-compat [deprecated-input=3D@var{input-policy}][,deprecated-output=3D=
@var{output-policy}]``
>> +    Set policy for handling deprecated management interfaces (experimen=
tal):
>
> We'll eventually want to drop (experimental), especially if we get all
> the rest of this into 5.1.
>
> But for now this looks like a good start.

Thanks!


