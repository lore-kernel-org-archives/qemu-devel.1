Return-Path: <SRS0=Ajie=DP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A499FC433E7
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 17:16:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C0A06221FC
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 17:16:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R4QaytcP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0A06221FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45042 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQZWe-00042C-By
	for qemu-devel@archiver.kernel.org; Thu, 08 Oct 2020 13:16:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50092)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kQZVG-0003cY-PY
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 13:14:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:33370)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kQZVE-0006JL-Rf
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 13:14:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602177291;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=q4h577DG8nuyqkApXoYK+eU7+hyGiZV9ReHnxTD7QGA=;
 b=R4QaytcPeCf3MVV0vm/hFKDtpELfBcJY9DIeFmULbiq634jiAR4DjRKBxLWqBF3KFuPPIZ
 x/Ow5joJltnFGI4olr6sFl7ciXdrV6Jl+t2Ktq+bPDXpfppSOMg9wimEEUCxcQ/Badtl1c
 L5K+kUIsOYXAZ9cjt1vm248qAH7jI3I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-257-IBElIZ8SOIORiZem2_bXSw-1; Thu, 08 Oct 2020 13:14:50 -0400
X-MC-Unique: IBElIZ8SOIORiZem2_bXSw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DB40287950B
 for <qemu-devel@nongnu.org>; Thu,  8 Oct 2020 17:14:48 +0000 (UTC)
Received: from [10.10.120.38] (ovpn-120-38.rdu2.redhat.com [10.10.120.38])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1916C60BFA;
 Thu,  8 Oct 2020 17:14:47 +0000 (UTC)
Subject: Re: [PATCH v5 03/36] qapi-gen: Separate arg-parsing from generation
To: Markus Armbruster <armbru@redhat.com>
References: <20201005195158.2348217-1-jsnow@redhat.com>
 <20201005195158.2348217-4-jsnow@redhat.com>
 <87r1qaihen.fsf@dusky.pond.sub.org>
 <50e590af-deff-3864-9abd-710a30eaa804@redhat.com>
 <878sch429q.fsf@dusky.pond.sub.org>
From: John Snow <jsnow@redhat.com>
Message-ID: <98cec6c2-fd10-42f5-873d-ae6748d2feff@redhat.com>
Date: Thu, 8 Oct 2020 13:14:47 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <878sch429q.fsf@dusky.pond.sub.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jsnow@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/08 02:56:27
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.214, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Cleber Rosa <crosa@redhat.com>, qemu-devel@nongnu.org,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/8/20 3:15 AM, Markus Armbruster wrote:
> John Snow <jsnow@redhat.com> writes:
> 
>> On 10/7/20 4:12 AM, Markus Armbruster wrote:
>>> I keep stumbling over things in later patches that turn out to go back
>>> to this one.
>>> John Snow <jsnow@redhat.com> writes:
>>>
>>>> This is a minor re-work of the entrypoint script. It isolates a
>>>> generate() method from the actual command-line mechanism.
>>>>
>>>> Signed-off-by: John Snow <jsnow@redhat.com>
>>>> Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
>>>> Reviewed-by: Cleber Rosa <crosa@redhat.com>
>>>> Tested-by: Cleber Rosa <crosa@redhat.com>
>>>> ---
>>>>    scripts/qapi-gen.py | 85 +++++++++++++++++++++++++++++++++------------
>>>>    1 file changed, 62 insertions(+), 23 deletions(-)
>>>>
>>>> diff --git a/scripts/qapi-gen.py b/scripts/qapi-gen.py
>>>> index 541e8c1f55d..117b396a595 100644
>>>> --- a/scripts/qapi-gen.py
>>>> +++ b/scripts/qapi-gen.py
>>>> @@ -1,30 +1,77 @@
>>>>    #!/usr/bin/env python3
>>>> -# QAPI generator
>>>> -#
>>>> +
>>>>    # This work is licensed under the terms of the GNU GPL, version 2 or later.
>>>>    # See the COPYING file in the top-level directory.
>>>>    +"""
>>>> +QAPI Generator
>>>> +
>>>> +This script is the main entry point for generating C code from the QAPI schema.
>>> PEP 8: For flowing long blocks of text with fewer structural
>>> restrictions (docstrings or comments), the line length should be limited
>>> to 72 characters.
>>>
>>
>> Eugh. OK, but I don't have a good way to check or enforce this,
>> admittedly. I have to change my emacs settings to understand this when
>> I hit the reflow key. I don't know if the python mode has a
>> context-aware reflow length.
>>
>> ("I don't disagree, but I'm not immediately sure right now how I will
>> make sure I, or anyone else, complies with this. Low priority as a
>> result?")
> 
> Emacs Python mode is close enough by default: fill-paragraph (bound to
> M-q) uses variable fill-column, which defaults to 70.  If you want the
> extra two columns PEP 8 grants you, I can show you how to bump it to 72
> just for Python mode.
> 
> You can use fill-paragraph for code, too.  I don't myself, because I
> disagree with its line breaking decisions too often (and so does PEP 8).
> A better Python mode would break code lines more neatly, and with the
> width defaulting to 79.
> 

Yeah, how do I set the reflow to 72 for specific modes?

I tend to do a lot of refactoring and "prototyping" in Pycharm, but when 
it comes to bread and butter edits I still prefer emacs. I kinda bounce 
between 'em a lot. Having emacs DTRT is still useful to me.

>>>> +"""
>>>>      import argparse
>>>>    import re
>>>>    import sys
>>>>      from qapi.commands import gen_commands
>>>> +from qapi.error import QAPIError
>>>>    from qapi.events import gen_events
>>>>    from qapi.introspect import gen_introspect
>>>> -from qapi.schema import QAPIError, QAPISchema
>>>> +from qapi.schema import QAPISchema
>>>>    from qapi.types import gen_types
>>>>    from qapi.visit import gen_visit
>>>>      
>>>> -def main(argv):
>>>> +DEFAULT_OUTPUT_DIR = ''
>>>> +DEFAULT_PREFIX = ''
>>>> +
>>>> +
>>>> +def generate(schema_file: str,
>>>> +             output_dir: str,
>>>> +             prefix: str,
>>>> +             unmask: bool = False,
>>>> +             builtins: bool = False) -> None:
>>>> +    """
>>>> +    generate uses a given schema to produce C code in the target directory.
>>> PEP 257: The docstring is a phrase ending in a period.  It
>>> prescribes
>>> the function or method's effect as a command ("Do this", "Return that"),
>>> not as a description; e.g. don't write "Returns the pathname ...".
>>> Suggest
>>>          Generate C code for the given schema into the target
>>> directory.
>>>
>>
>> OK. I don't mind trying to foster a consistent tone. I clearly
>> didn't. I will add a note to my style guide todo.
>>
>> I give you permission to change the voice in any of my docstrings, or
>> to adjust the phrasing to be more technically accurate as you see
>> fit. You are the primary maintainer of this code, of course, and you
>> will know best.
>>
>> It will be quicker to give you full permission to just change any of
>> the docstrings as you see fit than it will be to play review-respin
>> ping-pong.
> 
> Me rewriting your commits without your consent is putting words in your
> mouth, which I don't want to do.
> 
> We can still reduce ping-pong: whenever I can, I don't just say "this
> needs improvement", I propose improvements.  If you disagree, we talk.
> Else, if you have to respin, you make a reasonable effort to take them.
> Else, the remaining improvements are trivial (because no respin), and
> I'll make them in my tree.
> 

I appreciate the consideration. They're not just "my" words, though, 
they are "our" words!

I do give you permission to touch up things like punctuation, voice, 
etc. If I dislike the changes I can always yelp at you post-hoc when you 
post the PR email.

So I'll reiterate that I am definitely happy with such changes -- the 
precision of the technical writing here is not my strong suit as I do 
not know QAPI as intimately as you, and it's not the focus of this 
series. I don't think of it as a personal offense that someone would 
copy-edit these things.

If you're not comfortable doing it, that's OK too, but I'm definitely 
okay with things like comment and docstring edits in particular. It's 
just something that feels hard to predict.

(Anyway, I made this change. There are likely other voice and line 
length changes needed, but I think I will try to address those 
systematically when I lift missing-docstring for pylint. Probably I will 
craft a series that creates a style guide, enables sphinx, lifts 
missing-docstring, and performs this same style of cleanup, going 
module-by-module.)

>>>> +
>>>> +    :param schema_file: The primary QAPI schema file.
>>>> +    :param output_dir: The output directory to store generated code.
>>>> +    :param prefix: Optional C-code prefix for symbol names.
>>>> +    :param unmask: Expose non-ABI names through introspection?
>>>> +    :param builtins: Generate code for built-in types?
>>>> +
>>>> +    :raise QAPIError: On failures.
>>>> +    """
>>> [...]
>>>


