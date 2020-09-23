Return-Path: <SRS0=UzyQ=DA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 989DEC4727E
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 17:08:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB9AA20C09
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 17:08:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OUhsVPkC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB9AA20C09
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41872 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kL8FP-0001ZO-P4
	for qemu-devel@archiver.kernel.org; Wed, 23 Sep 2020 13:08:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35496)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kL8DY-0000z5-Jq
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 13:06:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:43173)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kL8DV-00078d-Oa
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 13:06:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600880763;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xv4fJvwcsuFYStcoTWCzUFo0EuYYWPNewfgTX/m+rDU=;
 b=OUhsVPkCubi/ua/rXiUeRtFgBZg5RmWLQGbq9bDw1vwM7sEE7jdpYti6OQl15FOioyqzjY
 HwrsIQpBjLrbY95cmbbgi/ZxPkVY9ye/C1ap8OZvPBdeD+APhoK6sSrlUqoRl5/PqwRCxS
 BUt0bZP2iid2AXLi8RbVmvr3pMouaO4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-108-WvjsGDxJPdSIVCtqFs3Klg-1; Wed, 23 Sep 2020 13:05:50 -0400
X-MC-Unique: WvjsGDxJPdSIVCtqFs3Klg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 87B1E1084C80;
 Wed, 23 Sep 2020 17:05:49 +0000 (UTC)
Received: from [10.10.119.140] (ovpn-119-140.rdu2.redhat.com [10.10.119.140])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1E1AB19728;
 Wed, 23 Sep 2020 17:05:48 +0000 (UTC)
Subject: Re: [PATCH v2 02/38] qapi-gen: Separate arg-parsing from generation
To: Cleber Rosa <crosa@redhat.com>
References: <20200922210101.4081073-1-jsnow@redhat.com>
 <20200922210101.4081073-3-jsnow@redhat.com>
 <20200923000031.GB191229@localhost.localdomain>
From: John Snow <jsnow@redhat.com>
Message-ID: <7920bff4-dd4b-4ef6-ce85-90e693efc749@redhat.com>
Date: Wed, 23 Sep 2020 13:05:47 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200923000031.GB191229@localhost.localdomain>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jsnow@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/23 00:53:58
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.228,
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org,
 Michael Roth <mdroth@linux.vnet.ibm.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/22/20 8:00 PM, Cleber Rosa wrote:
> On Tue, Sep 22, 2020 at 05:00:25PM -0400, John Snow wrote:
>> This is a minor re-work of the entrypoint script. It isolates a
>> generate() method from the actual command-line mechanism.
>>
>> Signed-off-by: John Snow <jsnow@redhat.com>
>> ---
>>   scripts/qapi-gen.py | 87 ++++++++++++++++++++++++++++++++-------------
>>   1 file changed, 63 insertions(+), 24 deletions(-)
>>
>> diff --git a/scripts/qapi-gen.py b/scripts/qapi-gen.py
>> index 4b03f7d53b..59becba3e1 100644
>> --- a/scripts/qapi-gen.py
>> +++ b/scripts/qapi-gen.py
>> @@ -1,9 +1,13 @@
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
>> @@ -11,21 +15,65 @@
>>   
>>   from qapi.commands import gen_commands
>>   from qapi.doc import gen_doc
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
> 
> I did not understand the purpose of these.  If they're used only as
> the default value for the command line option parsing, I'd suggest
> dropping them.
> 

The alternative is setting default='' inline below, which is fine, but 
found them kind of buried; and looking a bit too much like a weird magic 
constant. Aesthetically, I liked making them obvious.

You found them! My plan worked.

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
>> +    if match and match.end() != len(prefix):
> 
> Nice catch with the extra check here.  Maybe worth mentioning and/or
> splitting the change?
> 

If you review all 125 patches, I will do this for you ;)

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
>> +    gen_doc(schema, output_dir, prefix)
>> +
>> +
>> +def main() -> int:
> 
> One extra Pythonic touch would be to use a bool here, and then:
> 
>    sys.exit(0 if main() else 1)
> 
> But that's probably overkill.
> 

I think a function named main() is fair enough to return int -- we are 
declaring that this is a shell script pretty explicitly, and it is 
allowed to return a status code.

Shifting the knowledge of how shell codes work up one more layer is 
probably not ... urgent.

>> +    """
>> +    gapi-gen shell script entrypoint.
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
>> @@ -33,26 +81,17 @@ def main(argv):
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
> 
> Glad to see that this "quitter" is gone in favor of one and only
> sys.exit().
> 
> - Cleber.
> 
>> -    gen_types(schema, args.output_dir, args.prefix, args.builtins)
>> -    gen_visit(schema, args.output_dir, args.prefix, args.builtins)
>> -    gen_commands(schema, args.output_dir, args.prefix)
>> -    gen_events(schema, args.output_dir, args.prefix)
>> -    gen_introspect(schema, args.output_dir, args.prefix, args.unmask)
>> -    gen_doc(schema, args.output_dir, args.prefix)
>> +        print(f"{sys.argv[0]}: {str(err)}", file=sys.stderr)
>> +        return 1
>> +    return 0
>>   
>>   
>>   if __name__ == '__main__':
>> -    main(sys.argv)
>> +    sys.exit(main())
>> -- 
>> 2.26.2
>>


