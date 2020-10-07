Return-Path: <SRS0=37Ja=DO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CABFCC4363D
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 14:47:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4BE18208C7
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 14:47:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QAi2k7kY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BE18208C7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36326 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQAii-0001iu-CX
	for qemu-devel@archiver.kernel.org; Wed, 07 Oct 2020 10:47:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45114)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kQAdh-0005ad-IF
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 10:41:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:57593)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kQAdd-0005Mr-Fh
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 10:41:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602081712;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XeGmzCDaRela4Pk592WzllU2rX1jMa7IHTWvw+NIfD4=;
 b=QAi2k7kYoTj55Q6oEuRDvtcEYQO0Wwwe8hsbgPwvvvZPApPON/AFLel98Ga/Dk7zv8kt6e
 9dr8rYkII2uxJJjHecxIht8GzVHLUbdENUSWlP4GFrw4NrQ/5VMuOc0mUCeLcWqoEz/ksM
 VTrvnnUzXu7+lheq80r0Vmo0xfjKg2w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-388-gxJ2yjCPORyBKhRWu_1acA-1; Wed, 07 Oct 2020 10:41:49 -0400
X-MC-Unique: gxJ2yjCPORyBKhRWu_1acA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B9FFAAFD07
 for <qemu-devel@nongnu.org>; Wed,  7 Oct 2020 14:41:48 +0000 (UTC)
Received: from [10.10.120.38] (ovpn-120-38.rdu2.redhat.com [10.10.120.38])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 193125D9F7;
 Wed,  7 Oct 2020 14:41:48 +0000 (UTC)
Subject: Re: [PATCH v5 03/36] qapi-gen: Separate arg-parsing from generation
To: Markus Armbruster <armbru@redhat.com>
References: <20201005195158.2348217-1-jsnow@redhat.com>
 <20201005195158.2348217-4-jsnow@redhat.com>
 <87r1qaihen.fsf@dusky.pond.sub.org>
From: John Snow <jsnow@redhat.com>
Message-ID: <50e590af-deff-3864-9abd-710a30eaa804@redhat.com>
Date: Wed, 7 Oct 2020 10:41:47 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <87r1qaihen.fsf@dusky.pond.sub.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jsnow@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/07 00:44:56
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.742,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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
Cc: qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>,
 Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/7/20 4:12 AM, Markus Armbruster wrote:
> I keep stumbling over things in later patches that turn out to go back
> to this one.
> 
> John Snow <jsnow@redhat.com> writes:
> 
>> This is a minor re-work of the entrypoint script. It isolates a
>> generate() method from the actual command-line mechanism.
>>
>> Signed-off-by: John Snow <jsnow@redhat.com>
>> Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
>> Reviewed-by: Cleber Rosa <crosa@redhat.com>
>> Tested-by: Cleber Rosa <crosa@redhat.com>
>> ---
>>   scripts/qapi-gen.py | 85 +++++++++++++++++++++++++++++++++------------
>>   1 file changed, 62 insertions(+), 23 deletions(-)
>>
>> diff --git a/scripts/qapi-gen.py b/scripts/qapi-gen.py
>> index 541e8c1f55d..117b396a595 100644
>> --- a/scripts/qapi-gen.py
>> +++ b/scripts/qapi-gen.py
>> @@ -1,30 +1,77 @@
>>   #!/usr/bin/env python3
>> -# QAPI generator
>> -#
>> +
>>   # This work is licensed under the terms of the GNU GPL, version 2 or later.
>>   # See the COPYING file in the top-level directory.
>>   
>> +"""
>> +QAPI Generator
>> +
>> +This script is the main entry point for generating C code from the QAPI schema.
> 
> PEP 8: For flowing long blocks of text with fewer structural
> restrictions (docstrings or comments), the line length should be limited
> to 72 characters.
> 

Eugh. OK, but I don't have a good way to check or enforce this, 
admittedly. I have to change my emacs settings to understand this when I 
hit the reflow key. I don't know if the python mode has a context-aware 
reflow length.

("I don't disagree, but I'm not immediately sure right now how I will 
make sure I, or anyone else, complies with this. Low priority as a result?")

>> +"""
>>   
>>   import argparse
>>   import re
>>   import sys
>>   
>>   from qapi.commands import gen_commands
>> +from qapi.error import QAPIError
>>   from qapi.events import gen_events
>>   from qapi.introspect import gen_introspect
>> -from qapi.schema import QAPIError, QAPISchema
>> +from qapi.schema import QAPISchema
>>   from qapi.types import gen_types
>>   from qapi.visit import gen_visit
>>   
>>   
>> -def main(argv):
>> +DEFAULT_OUTPUT_DIR = ''
>> +DEFAULT_PREFIX = ''
>> +
>> +
>> +def generate(schema_file: str,
>> +             output_dir: str,
>> +             prefix: str,
>> +             unmask: bool = False,
>> +             builtins: bool = False) -> None:
>> +    """
>> +    generate uses a given schema to produce C code in the target directory.
> 
> PEP 257: The docstring is a phrase ending in a period.  It prescribes
> the function or method's effect as a command ("Do this", "Return that"),
> not as a description; e.g. don't write "Returns the pathname ...".
> 
> Suggest
> 
>         Generate C code for the given schema into the target directory.
> 

OK. I don't mind trying to foster a consistent tone. I clearly didn't. I 
will add a note to my style guide todo.

I give you permission to change the voice in any of my docstrings, or to 
adjust the phrasing to be more technically accurate as you see fit. You 
are the primary maintainer of this code, of course, and you will know best.

It will be quicker to give you full permission to just change any of the 
docstrings as you see fit than it will be to play review-respin ping-pong.

>> +
>> +    :param schema_file: The primary QAPI schema file.
>> +    :param output_dir: The output directory to store generated code.
>> +    :param prefix: Optional C-code prefix for symbol names.
>> +    :param unmask: Expose non-ABI names through introspection?
>> +    :param builtins: Generate code for built-in types?
>> +
>> +    :raise QAPIError: On failures.
>> +    """
> [...]
> 


