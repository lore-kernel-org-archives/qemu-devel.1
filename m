Return-Path: <SRS0=37Ja=DO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7AF6C4363D
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 14:44:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 291A3212CC
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 14:44:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GrvxXxbp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 291A3212CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58558 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQAg7-0007Ug-0k
	for qemu-devel@archiver.kernel.org; Wed, 07 Oct 2020 10:44:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43930)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kQAYs-0008FO-FP
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 10:36:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:42211)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kQAYq-0004eB-BC
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 10:36:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602081411;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KH60z3c4e7TSImkVUVFDTvQN8hYp6vZ+gCsP9qaq6tE=;
 b=GrvxXxbpGCXMg35gjCVhMCyZ6fvux2jjsGqsF7fH/r7s66So5CRGk/wDuTRlvYkoRhdjij
 IIc8YOQ/1/x/TRsGuAVqp26gOYbyZBRPOlWR90aFrphq/iQL5Qv0PWIC8FOyBiasqlQHIt
 iCbBz3RGQLa1NeX2Ov/myiHyzbfyh9s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-574-jmNJXD8tPtuYDdMLL6Vh6w-1; Wed, 07 Oct 2020 10:36:48 -0400
X-MC-Unique: jmNJXD8tPtuYDdMLL6Vh6w-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EC9371018F7E
 for <qemu-devel@nongnu.org>; Wed,  7 Oct 2020 14:36:47 +0000 (UTC)
Received: from [10.10.120.38] (ovpn-120-38.rdu2.redhat.com [10.10.120.38])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5125A5C1BD;
 Wed,  7 Oct 2020 14:36:47 +0000 (UTC)
Subject: Re: [PATCH v5 03/36] qapi-gen: Separate arg-parsing from generation
To: Markus Armbruster <armbru@redhat.com>
References: <20201005195158.2348217-1-jsnow@redhat.com>
 <20201005195158.2348217-4-jsnow@redhat.com>
 <877ds2jw6t.fsf@dusky.pond.sub.org>
From: John Snow <jsnow@redhat.com>
Message-ID: <007985f2-2872-1ab7-16aa-19414ba8cc78@redhat.com>
Date: Wed, 7 Oct 2020 10:36:46 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <877ds2jw6t.fsf@dusky.pond.sub.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
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

On 10/7/20 4:07 AM, Markus Armbruster wrote:
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
>> +
>> +    :param schema_file: The primary QAPI schema file.
>> +    :param output_dir: The output directory to store generated code.
>> +    :param prefix: Optional C-code prefix for symbol names.
>> +    :param unmask: Expose non-ABI names through introspection?
>> +    :param builtins: Generate code for built-in types?
>> +
>> +    :raise QAPIError: On failures.
>> +    """
>> +    match = re.match(r'([A-Za-z_.-][A-Za-z0-9_.-]*)?', prefix)
>> +    if match.end() != len(prefix):
>> +        msg = "funny character '{:s}' in prefix '{:s}'".format(
>> +            prefix[match.end()], prefix)
>> +        raise QAPIError('', None, msg)
>> +
>> +    schema = QAPISchema(schema_file)
>> +    gen_types(schema, output_dir, prefix, builtins)
>> +    gen_visit(schema, output_dir, prefix, builtins)
>> +    gen_commands(schema, output_dir, prefix)
>> +    gen_events(schema, output_dir, prefix)
>> +    gen_introspect(schema, output_dir, prefix, unmask)
>> +
>> +
>> +def main() -> int:
>> +    """
>> +    gapi-gen shell script entrypoint.
> 
> What's a "shell script entrypoint"?
> 
> Python docs talk about "when [...] run as a script":
> https://docs.python.org/3/library/__main__.html
> 
> Similar:
> https://docs.python.org/3/tutorial/modules.html#executing-modules-as-scripts
> 

"entrypoint" is Python garble for a function that can be registered as a 
callable from the command line.

So in a theoretical setup.py, you'd do something like:

'entry_points': {
   'console_scripts': [
     'qapi-gen = qapi.main:main',
   ]
}

so when I say "shell script entrypoint", I am referring to a shell 
script (I mean: it has a shebang and can be executed by an interactive 
shell process) that calls the entrypoint.

Once (if) QAPI migrates to ./python/qemu/qapi, it will be possible to 
just generate that script.

(i.e. doing `pip install qemu.qapi` will install a 'qapi-gen' CLI script 
for you. this is how packages like sphinx create the 'sphinx-build' 
script, etc.)

>> +    Expects arguments via sys.argv, see --help for details.
>> +
>> +    :return: int, 0 on success, 1 on failure.
>> +    """
>>       parser = argparse.ArgumentParser(
>>           description='Generate code from a QAPI schema')
>>       parser.add_argument('-b', '--builtins', action='store_true',
>>                           help="generate code for built-in types")
>> -    parser.add_argument('-o', '--output-dir', action='store', default='',
>> +    parser.add_argument('-o', '--output-dir', action='store',
>> +                        default=DEFAULT_OUTPUT_DIR,
>>                           help="write output to directory OUTPUT_DIR")
>> -    parser.add_argument('-p', '--prefix', action='store', default='',
>> +    parser.add_argument('-p', '--prefix', action='store',
>> +                        default=DEFAULT_PREFIX,
>>                           help="prefix for symbols")
>>       parser.add_argument('-u', '--unmask-non-abi-names', action='store_true',
>>                           dest='unmask',
>> @@ -32,25 +79,17 @@ def main(argv):
>>       parser.add_argument('schema', action='store')
>>       args = parser.parse_args()
>>   
>> -    match = re.match(r'([A-Za-z_.-][A-Za-z0-9_.-]*)?', args.prefix)
>> -    if match.end() != len(args.prefix):
>> -        print("%s: 'funny character '%s' in argument of --prefix"
>> -              % (sys.argv[0], args.prefix[match.end()]),
>> -              file=sys.stderr)
>> -        sys.exit(1)
>> -
>>       try:
>> -        schema = QAPISchema(args.schema)
>> +        generate(args.schema,
>> +                 output_dir=args.output_dir,
>> +                 prefix=args.prefix,
>> +                 unmask=args.unmask,
>> +                 builtins=args.builtins)
>>       except QAPIError as err:
>> -        print(err, file=sys.stderr)
>> -        exit(1)
>> -
>> -    gen_types(schema, args.output_dir, args.prefix, args.builtins)
>> -    gen_visit(schema, args.output_dir, args.prefix, args.builtins)
>> -    gen_commands(schema, args.output_dir, args.prefix)
>> -    gen_events(schema, args.output_dir, args.prefix)
>> -    gen_introspect(schema, args.output_dir, args.prefix, args.unmask)
>> +        print(f"{sys.argv[0]}: {str(err)}", file=sys.stderr)
>> +        return 1
>> +    return 0
>>   
>>   
>>   if __name__ == '__main__':
>> -    main(sys.argv)
>> +    sys.exit(main())
> 
> What does sys.exit() really buy us here?  I'm asking because both spots
> in the Python docs I referenced above do without.
> 

It just pushes the sys.exit out of the main function so it can be 
invoked by other machinery. (And takes the return code from main and 
turns it into the return code for the process.)

I don't think it winds up mattering for simple "console_script" entry 
points, but you don't want the called function to exit and deny the 
caller the chance to do their own tidying post-call.

You've already offered a "YAGNI", but it's just the convention I tend to 
stick to for how to structure entry points.

--js


