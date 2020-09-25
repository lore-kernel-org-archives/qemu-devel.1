Return-Path: <SRS0=+pSw=DC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B54BC4363D
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 15:39:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB66920809
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 15:39:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BhHugwpF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB66920809
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44164 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLpoU-00013B-Vl
	for qemu-devel@archiver.kernel.org; Fri, 25 Sep 2020 11:39:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35204)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kLpml-0007mH-AO
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 11:37:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:28615)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kLpmf-0007Dl-A1
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 11:37:19 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601048235;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AoCy5b99+EYcJjUs4iGXU3DO2q+DP1rEYmMpCxtpZjY=;
 b=BhHugwpFv70eTCiiT7PEPRd2nmy/N4CeVGoxK4NXzOuYSVSqRyhvIfqbarRzNfzdYbwxzU
 P/zaes4/iB9WRYxeqFY5CO2IB1hyEMns7V6eJzYj2TrIznic4c9wsXE2ZmCQdNjf6emv9s
 m/DMzkFA3WI/EyBj31iE8+KrNWCIy7w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-543-Q8lNYf_aNWatH2iq7T3QDg-1; Fri, 25 Sep 2020 11:37:13 -0400
X-MC-Unique: Q8lNYf_aNWatH2iq7T3QDg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 724BB420F0;
 Fri, 25 Sep 2020 15:37:11 +0000 (UTC)
Received: from [10.10.119.140] (ovpn-119-140.rdu2.redhat.com [10.10.119.140])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 93B0573692;
 Fri, 25 Sep 2020 15:37:10 +0000 (UTC)
Subject: Re: [PATCH v2 02/38] qapi-gen: Separate arg-parsing from generation
To: Markus Armbruster <armbru@redhat.com>, Cleber Rosa <crosa@redhat.com>
References: <20200922210101.4081073-1-jsnow@redhat.com>
 <20200922210101.4081073-3-jsnow@redhat.com>
 <20200923000031.GB191229@localhost.localdomain>
 <87zh5et7hx.fsf@dusky.pond.sub.org>
From: John Snow <jsnow@redhat.com>
Message-ID: <c38cbc07-4878-ae05-8871-8cb1c46acde2@redhat.com>
Date: Fri, 25 Sep 2020 11:37:10 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <87zh5et7hx.fsf@dusky.pond.sub.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jsnow@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/25 02:48:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.199,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.238, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/25/20 7:34 AM, Markus Armbruster wrote:
> Cleber Rosa <crosa@redhat.com> writes:
> 
>> On Tue, Sep 22, 2020 at 05:00:25PM -0400, John Snow wrote:
>>> This is a minor re-work of the entrypoint script. It isolates a
>>> generate() method from the actual command-line mechanism.
>>>
>>> Signed-off-by: John Snow <jsnow@redhat.com>
>>> ---
>>>   scripts/qapi-gen.py | 87 ++++++++++++++++++++++++++++++++-------------
>>>   1 file changed, 63 insertions(+), 24 deletions(-)
>>>
>>> diff --git a/scripts/qapi-gen.py b/scripts/qapi-gen.py
>>> index 4b03f7d53b..59becba3e1 100644
>>> --- a/scripts/qapi-gen.py
>>> +++ b/scripts/qapi-gen.py
>>> @@ -1,9 +1,13 @@
>>>   #!/usr/bin/env python3
>>> -# QAPI generator
>>> -#
>>> +
>>>   # This work is licensed under the terms of the GNU GPL, version 2 or later.
>>>   # See the COPYING file in the top-level directory.
>>>   
>>> +"""
>>> +QAPI Generator
>>> +
>>> +This script is the main entry point for generating C code from the QAPI schema.
>>> +"""
>>>   
>>>   import argparse
>>>   import re
>>> @@ -11,21 +15,65 @@
>>>   
>>>   from qapi.commands import gen_commands
>>>   from qapi.doc import gen_doc
>>> +from qapi.error import QAPIError
>>>   from qapi.events import gen_events
>>>   from qapi.introspect import gen_introspect
>>> -from qapi.schema import QAPIError, QAPISchema
>>> +from qapi.schema import QAPISchema
>>>   from qapi.types import gen_types
>>>   from qapi.visit import gen_visit
>>>   
>>>   
>>> -def main(argv):
>>> +DEFAULT_OUTPUT_DIR = ''
>>> +DEFAULT_PREFIX = ''
>>
>> I did not understand the purpose of these.  If they're used only as
>> the default value for the command line option parsing, I'd suggest
>> dropping them.
>>
>>> +
>>> +
>>> +def generate(schema_file: str,
>>> +             output_dir: str,
>>> +             prefix: str,
>>> +             unmask: bool = False,
>>> +             builtins: bool = False) -> None:
>>> +    """
>>> +    generate uses a given schema to produce C code in the target directory.
>>> +
>>> +    :param schema_file: The primary QAPI schema file.
>>> +    :param output_dir: The output directory to store generated code.
>>> +    :param prefix: Optional C-code prefix for symbol names.
>>> +    :param unmask: Expose non-ABI names through introspection?
>>> +    :param builtins: Generate code for built-in types?
>>> +
>>> +    :raise QAPIError: On failures.
>>> +    """
>>> +    match = re.match(r'([A-Za-z_.-][A-Za-z0-9_.-]*)?', prefix)
>>> +    if match and match.end() != len(prefix):
>>
>> Nice catch with the extra check here.  Maybe worth mentioning and/or
>> splitting the change?
> 
> Please do not sneak additional checking into patches advertized as pure
> refactoring.  It makes me look for more sneakery with a microscope.
> 
> This re.match() cannot possibly fail.  Three cases:
> 
> * First character is funny
> 
>    The regexp matches the empty string.  There's a reason the regexp ends
>    with '?'.
> 
> * Non-first character is funny
> 
>    The regexp matches the non-funny prefix.
> 
> * No character is funny
> 
>    The regexp matches the complete string.
> 
> Checking impossible conditions as if they were possible is confusing.
> Please drop the additional check.
> 
> We can talk about checking this impossible condition with
> 
>          assert(match)
> 
> if you believe it makes the code easier to understand (it does not
> improve its behavior).
> 

My use of strict_optional=False is what prevents this from exhibiting as 
an error in mypy. An assert will help convince mypy that 'match' cannot 
possibly be 'None'.

eh, well. I will fix this when I remove strict_optional, so I will just 
remove this additional check for now to avoid adding another patch to 
this series.

--js


