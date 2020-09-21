Return-Path: <SRS0=MAm8=C6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89395C43468
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 08:09:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A33B20BED
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 08:09:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IXgETKLv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A33B20BED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49622 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKGsk-0000ER-Cj
	for qemu-devel@archiver.kernel.org; Mon, 21 Sep 2020 04:09:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44494)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kKGpK-0004nF-4i
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 04:05:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:25318)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kKGpH-0006tr-Qg
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 04:05:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600675530;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=iiYlmgIuPiZN02xTXUQ6YrLklz+4kq4vloiT1WAKutQ=;
 b=IXgETKLvlLoQgNf4yImqeACm3Vn+6JSEK1Ijr2SUvQqQ7XDWwh99LionrzywCSMeZCeEhF
 Nr6q3E6SN2d21Twoqmr2UET7efOLB2eWO/w4Zxc4dYstJRqlWKbtoN5rFDnABOBw+elW2q
 rN4UGfO55Z5VNUddwNmsBOHayq7HvuU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-167-afXz_0ilPFG6qfFFPOtJdQ-1; Mon, 21 Sep 2020 04:05:27 -0400
X-MC-Unique: afXz_0ilPFG6qfFFPOtJdQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 41DAF801AB7;
 Mon, 21 Sep 2020 08:05:26 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-114-66.ams2.redhat.com
 [10.36.114.66])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D6BC881C42;
 Mon, 21 Sep 2020 08:05:25 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 67E101132E9A; Mon, 21 Sep 2020 10:05:24 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Subject: Re: [PATCH 16/37] qapi: establish mypy type-checking baseline
References: <20200915224027.2529813-1-jsnow@redhat.com>
 <20200915224027.2529813-17-jsnow@redhat.com>
 <874knvguzb.fsf@dusky.pond.sub.org>
 <ccc530c6-4ad5-cf0b-09d0-65b14311a1ec@redhat.com>
Date: Mon, 21 Sep 2020 10:05:24 +0200
In-Reply-To: <ccc530c6-4ad5-cf0b-09d0-65b14311a1ec@redhat.com> (John Snow's
 message of "Fri, 18 Sep 2020 10:27:07 -0400")
Message-ID: <87k0wna723.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Received-SPF: pass client-ip=216.205.24.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/21 01:43:11
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.501,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

John Snow <jsnow@redhat.com> writes:

> On 9/18/20 7:55 AM, Markus Armbruster wrote:
>> Ignorant question: why does this come after PATCH 13 "qapi/common.py:
>> add notational type hints", but before all the other patches adding type
>> hints?
>> John Snow <jsnow@redhat.com> writes:
>> 
>>> Fix two very minor issues, and then establish a mypy type-checking
>>> baseline.
>>>
>>> Like pylint, this should be run from the folder above:
>>>
>>>   > mypy --config-file=qapi/mypy.ini qapi/
>> I get:
>>      $ mypy --config-file qapi/mypy.ini qapi
>>      qapi/mypy.ini: [mypy]: Strict mode is not supported in configuration files: specify individual flags instead (see 'mypy -h' for the list of flags enabled in strict mode)
>>      qapi/types.py:29: error: Need type annotation for 'objects_seen' (hint: "objects_seen: Set[<type>] = ...")
>>      Found 1 error in 1 file (checked 18 source files)
>> Is this expected?
>> 
>
> Nope.
>
>> In case it matters:
>>      $ mypy --version
>>      mypy 0.761
>> 
>
> I am using mypy 0.782.
>
> I will investigate to see if there is an *easy* win to allow older
> versions to work.
>
> In the meantime, please consider trying this:
>
> pip install --user mypy==0.782
> ~/.local/bin/mypy --config-file=qapi/mypy.ini qapi/

I'll consider dragging my feet until upgrading Fedora gives it to me for
free.

The less I interact with package managers, the happier I am.

>>> Signed-off-by: John Snow <jsnow@redhat.com>
>>> ---
>>>   scripts/qapi/doc.py    |  3 +-
>>>   scripts/qapi/mypy.ini  | 65 ++++++++++++++++++++++++++++++++++++++++++
>>>   scripts/qapi/schema.py |  3 +-
>>>   3 files changed, 69 insertions(+), 2 deletions(-)
>>>   create mode 100644 scripts/qapi/mypy.ini
>>>
>>> diff --git a/scripts/qapi/doc.py b/scripts/qapi/doc.py
>>> index cbf7076ed9..70f7cdfaa6 100644
>>> --- a/scripts/qapi/doc.py
>>> +++ b/scripts/qapi/doc.py
>>> @@ -5,7 +5,8 @@
>>>   """This script produces the documentation of a qapi schema in texinfo format"""
>>>     import re
>>> -from .gen import QAPIGenDoc, QAPISchemaVisitor
>>> +from .gen import QAPIGenDoc
>>> +from .schema import QAPISchemaVisitor
>> Your mypy doesn't like such lazy imports?  Mine seems not to care.
>> 
>
> Yeah, it specifically complained that no such definition existed in
> that file.

I sense a certain wobbliness in mypy.  Perhaps to be expected from a
tool with major version zero.  There's a risk that developers' local
"make check" and our gating CI differ too much.  We'll see.

>>>     
>>>   MSG_FMT = """
>>> diff --git a/scripts/qapi/mypy.ini b/scripts/qapi/mypy.ini
>>> new file mode 100644
>>> index 0000000000..a0f2365a53
>>> --- /dev/null
>>> +++ b/scripts/qapi/mypy.ini
>>> @@ -0,0 +1,65 @@
>>> +[mypy]
>>> +strict = True
>>> +strict_optional = False
>>> +disallow_untyped_calls = False
>>> +python_version = 3.6
>>> +
>>> +[mypy-qapi.commands]
>>> +disallow_untyped_defs = False
>>> +disallow_incomplete_defs = False
>>> +check_untyped_defs = False
>>> +
>>> +[mypy-qapi.doc]
>>> +disallow_subclassing_any = False
>>> +disallow_untyped_defs = False
>>> +disallow_incomplete_defs = False
>>> +
>>> +[mypy-qapi.error]
>>> +disallow_untyped_defs = False
>>> +disallow_incomplete_defs = False
>>> +check_untyped_defs = False
>>> +
>>> +[mypy-qapi.events]
>>> +disallow_untyped_defs = False
>>> +disallow_incomplete_defs = False
>>> +check_untyped_defs = False
>>> +
>>> +[mypy-qapi.expr]
>>> +disallow_untyped_defs = False
>>> +disallow_incomplete_defs = False
>>> +check_untyped_defs = False
>>> +
>>> +[mypy-qapi.gen]
>>> +disallow_untyped_defs = False
>>> +disallow_incomplete_defs = False
>>> +check_untyped_defs = False
>>> +
>>> +[mypy-qapi.introspect]
>>> +disallow_untyped_defs = False
>>> +disallow_incomplete_defs = False
>>> +check_untyped_defs = False
>>> +
>>> +[mypy-qapi.parser]
>>> +disallow_untyped_defs = False
>>> +disallow_incomplete_defs = False
>>> +check_untyped_defs = False
>>> +
>>> +[mypy-qapi.schema]
>>> +disallow_untyped_defs = False
>>> +disallow_incomplete_defs = False
>>> +check_untyped_defs = False
>>> +
>>> +[mypy-qapi.source]
>>> +disallow_untyped_defs = False
>>> +disallow_incomplete_defs = False
>>> +check_untyped_defs = False
>>> +
>>> +[mypy-qapi.types]
>>> +disallow_untyped_defs = False
>>> +disallow_incomplete_defs = False
>>> +check_untyped_defs = False
>>> +
>>> +[mypy-qapi.visit]
>>> +disallow_untyped_defs = False
>>> +disallow_incomplete_defs = False
>>> +check_untyped_defs = False
>> Greek to me.  I'll learn in due time.
>> 
>
> I am using these options:
>
> --strict, which is effectively -Wall.
>
> --no-strict-optional, which disables type checking errors on conflict
>   between Optional[T] and T. Namely, when you initialize a class field
>  to None and set that variable after initialization, callers must be 
> prepared to see if that field was None or not. We do that effectively
> nowhere.
>
> As Python will surely explode in a noticeable way if we got an
> unexpected 'None', I am just suppressing these warnings "for now".

Okay.

We may want to rethink how we define and initialize these variables.  We
initialize mostly to keep pylint happy.  We initialize to None precisely
to make use before the real initialization explode.

> --allow-untyped-calls silences errors in files that have calls to
>   functions in files I still have not typed. By the end of the series, 
> this option goes away, because there's nothing untyped left.
>
>
> For each untyped file, we are actually starting with all of the above
> options and then layering these options on top. Any egregious typing 
> errors present in these "ignored" files will be spotted.
>
> To get the bad files to pass, we only need three options:
>
> allow untyped defs -- Simply permits us to have functions without
> annotations.
>
> allow incomplete defs -- allows functions that are only partially typed.
>
> check untyped defs = False -- Don't try to type check untyped definitions.

Thanks!

[...]


