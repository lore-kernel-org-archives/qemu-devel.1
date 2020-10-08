Return-Path: <SRS0=Ajie=DP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A823C4363C
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 05:57:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B298D20725
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 05:57:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WUsXBho2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B298D20725
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51716 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQOvj-00089P-Fy
	for qemu-devel@archiver.kernel.org; Thu, 08 Oct 2020 01:57:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41454)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kQOvA-0007i9-8f
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 01:56:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:37788)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kQOv5-00031T-UF
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 01:56:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602136609;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=s67eH0tgKifQwmHHpZEfnpmOofXqqYirTgNV+l2gbP8=;
 b=WUsXBho269SGgJcXtepwj2fqD8X61zzyYbY/PU/P83mGxcnyjmO4zxYEHBa4pgeR7vfAHw
 qi7orDozTFzOyJt+JzOu1xbUPcl7YvdaHxdU08FMtJiC15LNnYdB8yy1VItoSY/TKmTKDB
 up+LOO78bmGJ9knyIDW59H4VVPH72MM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-174-11jW0I4MNkSQR92homIH4Q-1; Thu, 08 Oct 2020 01:56:47 -0400
X-MC-Unique: 11jW0I4MNkSQR92homIH4Q-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5EDA8186DD25
 for <qemu-devel@nongnu.org>; Thu,  8 Oct 2020 05:56:46 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-182.ams2.redhat.com
 [10.36.112.182])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 08C385C1BD;
 Thu,  8 Oct 2020 05:56:45 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 777AE11329C1; Thu,  8 Oct 2020 07:56:44 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Subject: Re: [PATCH v5 03/36] qapi-gen: Separate arg-parsing from generation
References: <20201005195158.2348217-1-jsnow@redhat.com>
 <20201005195158.2348217-4-jsnow@redhat.com>
 <87imbntvw9.fsf@dusky.pond.sub.org>
 <69effb8e-3d83-a2e7-c484-feea8ed850b9@redhat.com>
 <87h7r6jws4.fsf@dusky.pond.sub.org>
 <65c2a120-e29e-b572-680a-ee6d141ff9c8@redhat.com>
Date: Thu, 08 Oct 2020 07:56:44 +0200
In-Reply-To: <65c2a120-e29e-b572-680a-ee6d141ff9c8@redhat.com> (John Snow's
 message of "Wed, 7 Oct 2020 10:52:54 -0400")
Message-ID: <87h7r545wj.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Received-SPF: pass client-ip=63.128.21.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/08 01:56:49
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.742,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>,
 Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

John Snow <jsnow@redhat.com> writes:

> On 10/7/20 3:54 AM, Markus Armbruster wrote:
>> John Snow <jsnow@redhat.com> writes:
>> 
>>> On 10/6/20 7:51 AM, Markus Armbruster wrote:
>>>> John Snow <jsnow@redhat.com> writes:
>>>>
>>>>> This is a minor re-work of the entrypoint script. It isolates a
>>>>> generate() method from the actual command-line mechanism.
>>>>>
>>>>> Signed-off-by: John Snow <jsnow@redhat.com>
>>>>> Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
>>>>> Reviewed-by: Cleber Rosa <crosa@redhat.com>
>>>>> Tested-by: Cleber Rosa <crosa@redhat.com>
>>>>> ---
>>>>>    scripts/qapi-gen.py | 85 +++++++++++++++++++++++++++++++++------------
>>>>>    1 file changed, 62 insertions(+), 23 deletions(-)
>>>>>
>>>>> diff --git a/scripts/qapi-gen.py b/scripts/qapi-gen.py
>>>>> index 541e8c1f55d..117b396a595 100644
>>>>> --- a/scripts/qapi-gen.py
>>>>> +++ b/scripts/qapi-gen.py
>>>>> @@ -1,30 +1,77 @@
>>>>>    #!/usr/bin/env python3
>>>>> -# QAPI generator
>>>>> -#
>>>>> +
>>>>>    # This work is licensed under the terms of the GNU GPL, version 2 or later.
>>>>>    # See the COPYING file in the top-level directory.
>>>>>    +"""
>>>>> +QAPI Generator
>>>>> +
>>>>> +This script is the main entry point for generating C code from the QAPI schema.
>>>>> +"""
>>>>>      import argparse
>>>>>    import re
>>>>>    import sys
>>>>>      from qapi.commands import gen_commands
>>>>> +from qapi.error import QAPIError
>>>>>    from qapi.events import gen_events
>>>>>    from qapi.introspect import gen_introspect
>>>>> -from qapi.schema import QAPIError, QAPISchema
>>>>> +from qapi.schema import QAPISchema
>>>>>    from qapi.types import gen_types
>>>>>    from qapi.visit import gen_visit
>>>> Unrelated cleanup.  Okay.
>>>>
>>>>>      -def main(argv):
>>>>> +DEFAULT_OUTPUT_DIR = ''
>>>>> +DEFAULT_PREFIX = ''
>>>>> +
>>>>> +
>>>>> +def generate(schema_file: str,
>>>>> +             output_dir: str,
>>>>> +             prefix: str,
>>>>> +             unmask: bool = False,
>>>>> +             builtins: bool = False) -> None:
>>>>> +    """
>>>>> +    generate uses a given schema to produce C code in the target directory.
>>>>> +
>>>>> +    :param schema_file: The primary QAPI schema file.
>>>>> +    :param output_dir: The output directory to store generated code.
>>>>> +    :param prefix: Optional C-code prefix for symbol names.
>>>>> +    :param unmask: Expose non-ABI names through introspection?
>>>>> +    :param builtins: Generate code for built-in types?
>>>>> +
>>>>> +    :raise QAPIError: On failures.
>>>>> +    """
>>>>> +    match = re.match(r'([A-Za-z_.-][A-Za-z0-9_.-]*)?', prefix)
>>>>> +    if match.end() != len(prefix):
>>>>> +        msg = "funny character '{:s}' in prefix '{:s}'".format(
>>>>> +            prefix[match.end()], prefix)
>>>>> +        raise QAPIError('', None, msg)
>>>> Uh...
>>>>       $ python3 scripts/qapi-gen.py --prefix=@ x
>>>>       scripts/qapi-gen.py: : funny character '@' in prefix '@'
>>>> Unwanted " :".
>>>> This is due to a hack: you pass '' for info (*quack*).  Everything
>>>> else
>>>> passes QAPISourceInfo (I believe).
>>>>
>>>
>>> Quack indeed - why does our base error class require so much
>>> information from a specific part of the generation process?
>> Because it's not "a base error class", it's a base error class for
>> the
>> QAPI schema compiler frontend.
>> 
>
> Well. It's the base for every error we /had/.

You asked why the class has the init it has, and I answered :)

>>> Ah, someone changes this in part 4 so that we have a more generic
>>> error class to use as a base when we are missing such information.
>> Evolving it to satisfy a need for a more widely usable error class
>> is
>> okay.
>> 
>
> Yep. It's helpful to keep a very generic form on which we grow other
> errors from, so that things like the entry point can be written
> legibly.

If you have a non-trivial error message format convention, you have a
use for a function formatting error messages.

If you have a separation between diagnose and report of errors, you you
have a use for a transport from diagnose to report.  In Python, that's
raise.

The existing error message in main() has neither.

The existing error class QAPIError caters for the existing users.

>>> You are witnessing some more future-bleed.
>>>> Is it really a good idea to do this in generate?  It's not about
>>>> generating code, it's about validating a CLI option.
>>>>
>>>
>>> One might also ask: Is it a good idea to only validate this on a
>>> frontend, and not in the implementation?
>> Yes, because that's where you can emit the better error message more
>> easily.
>>      $ python3 scripts/qapi-gen.py --prefix=@ x
>>      scripts/qapi-gen.py: 'funny character '@' in argument of --prefix
>> is better than
>>      $ python3 scripts/qapi-gen.py --prefix=@ x
>>      scripts/qapi-gen.py: funny character '@' in prefix '@'
>> In generate(), the knowledge where the offending prefix value comes
>> from
>> is no longer available.
>> To emit this error message, you'd have to raise a sufficiently
>> distinct
>> error in generate, catch it in main(), then put the error message
>> together somehow.  Bah.
>> Aside: there's a stray ' in the old error message.
>> 
>>> The idea here was to create a function that could be used in a script
>>> (for tests, debugging interfaces, other python packages) to do all of
>>> the same things that the CLI tool did, just sans the actual CLI.
>> YAGNI.
>> 
>
> It's useful for testing and debugging to be able to just call it
> outside of the CLI, though. Maybe you won't use it, but I will.

For testing and debugging, treating "prefix is sane" as a precondition
is fine.  I wouldn't even bother checking it.  A check would catch
accidents, and these accidents seem vanishingly unlikely to me.

Evidence: we did without *any* prefix checking for *years*.  I added it
in commit 1cf47a15f18 just for completeness.

> I could always add the prefix check into a tiny function and give the
> good error message in main(), and just assert in generate() if you 
> insist on the slightly more specific error message from the CLI script.

If you genuinely think a check is needed there, that's the way to go.

>>> Wouldn't make sense to allow garbage to flow in from one interface but
>>> not the other; so the check is here.
>> "@prefix is sane" is a precondition of generate().
>> When there's a real risk of preconditions getting violated, or
>> readers
>> getting confused about preconditions, check them with assert.
[...]


