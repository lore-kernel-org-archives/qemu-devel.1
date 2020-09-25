Return-Path: <SRS0=+pSw=DC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4465C4363D
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 11:35:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4DD44206C9
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 11:35:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ce8LlW+i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DD44206C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37740 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLm0j-0004uY-BE
	for qemu-devel@archiver.kernel.org; Fri, 25 Sep 2020 07:35:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59358)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kLlzw-0004OS-Fc
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 07:34:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:41125)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kLlzu-00005k-83
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 07:34:44 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601033680;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2tdPJ5EKowE8mjiA2GEYq3JC4e1DV/J3PJ42fjXpJPI=;
 b=Ce8LlW+iRmJQLsIeaJi8ODN3T4gF6KaUPKcNleRz5JYsmupouS4elAylnS6kOBiLXpGR5O
 KS1LHZXYYyFFNF2Bcqoy12Z48dfKFlRl8FfwG7x6yxMhX+hA6FqzJCrRpdiDKF46HAl6sO
 TaFn84XMRxB8hmePsVGIPc4AKu2QANk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-526-9F_N25HnMNCFNzpE8HOz9A-1; Fri, 25 Sep 2020 07:34:37 -0400
X-MC-Unique: 9F_N25HnMNCFNzpE8HOz9A-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8B77D10BBEDA;
 Fri, 25 Sep 2020 11:34:36 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-70.ams2.redhat.com
 [10.36.112.70])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 31FEC7368C;
 Fri, 25 Sep 2020 11:34:36 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id B204B113865F; Fri, 25 Sep 2020 13:34:34 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Cleber Rosa <crosa@redhat.com>
Subject: Re: [PATCH v2 02/38] qapi-gen: Separate arg-parsing from generation
References: <20200922210101.4081073-1-jsnow@redhat.com>
 <20200922210101.4081073-3-jsnow@redhat.com>
 <20200923000031.GB191229@localhost.localdomain>
Date: Fri, 25 Sep 2020 13:34:34 +0200
In-Reply-To: <20200923000031.GB191229@localhost.localdomain> (Cleber Rosa's
 message of "Tue, 22 Sep 2020 20:00:31 -0400")
Message-ID: <87zh5et7hx.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Received-SPF: pass client-ip=63.128.21.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/25 01:07:33
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.199,
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>, John Snow <jsnow@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-devel@nongnu.org,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Cleber Rosa <crosa@redhat.com> writes:

> On Tue, Sep 22, 2020 at 05:00:25PM -0400, John Snow wrote:
>> This is a minor re-work of the entrypoint script. It isolates a
>> generate() method from the actual command-line mechanism.
>> 
>> Signed-off-by: John Snow <jsnow@redhat.com>
>> ---
>>  scripts/qapi-gen.py | 87 ++++++++++++++++++++++++++++++++-------------
>>  1 file changed, 63 insertions(+), 24 deletions(-)
>> 
>> diff --git a/scripts/qapi-gen.py b/scripts/qapi-gen.py
>> index 4b03f7d53b..59becba3e1 100644
>> --- a/scripts/qapi-gen.py
>> +++ b/scripts/qapi-gen.py
>> @@ -1,9 +1,13 @@
>>  #!/usr/bin/env python3
>> -# QAPI generator
>> -#
>> +
>>  # This work is licensed under the terms of the GNU GPL, version 2 or later.
>>  # See the COPYING file in the top-level directory.
>>  
>> +"""
>> +QAPI Generator
>> +
>> +This script is the main entry point for generating C code from the QAPI schema.
>> +"""
>>  
>>  import argparse
>>  import re
>> @@ -11,21 +15,65 @@
>>  
>>  from qapi.commands import gen_commands
>>  from qapi.doc import gen_doc
>> +from qapi.error import QAPIError
>>  from qapi.events import gen_events
>>  from qapi.introspect import gen_introspect
>> -from qapi.schema import QAPIError, QAPISchema
>> +from qapi.schema import QAPISchema
>>  from qapi.types import gen_types
>>  from qapi.visit import gen_visit
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

Please do not sneak additional checking into patches advertized as pure
refactoring.  It makes me look for more sneakery with a microscope.

This re.match() cannot possibly fail.  Three cases:

* First character is funny

  The regexp matches the empty string.  There's a reason the regexp ends
  with '?'.

* Non-first character is funny

  The regexp matches the non-funny prefix.

* No character is funny

  The regexp matches the complete string.

Checking impossible conditions as if they were possible is confusing.
Please drop the additional check.

We can talk about checking this impossible condition with

        assert(match)

if you believe it makes the code easier to understand (it does not
improve its behavior).

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
>   sys.exit(0 if main() else 1)
>
> But that's probably overkill.

Yuck :)

>> +    """
>> +    gapi-gen shell script entrypoint.
>> +    Expects arguments via sys.argv, see --help for details.
>> +
>> +    :return: int, 0 on success, 1 on failure.
>> +    """
>>      parser = argparse.ArgumentParser(
>>          description='Generate code from a QAPI schema')
>>      parser.add_argument('-b', '--builtins', action='store_true',
>>                          help="generate code for built-in types")
>> -    parser.add_argument('-o', '--output-dir', action='store', default='',
>> +    parser.add_argument('-o', '--output-dir', action='store',
>> +                        default=DEFAULT_OUTPUT_DIR,
>>                          help="write output to directory OUTPUT_DIR")
>> -    parser.add_argument('-p', '--prefix', action='store', default='',
>> +    parser.add_argument('-p', '--prefix', action='store',
>> +                        default=DEFAULT_PREFIX,
>>                          help="prefix for symbols")
>>      parser.add_argument('-u', '--unmask-non-abi-names', action='store_true',
>>                          dest='unmask',
>> @@ -33,26 +81,17 @@ def main(argv):
>>      parser.add_argument('schema', action='store')
>>      args = parser.parse_args()
>>  
>> -    match = re.match(r'([A-Za-z_.-][A-Za-z0-9_.-]*)?', args.prefix)
>> -    if match.end() != len(args.prefix):
>> -        print("%s: 'funny character '%s' in argument of --prefix"
>> -              % (sys.argv[0], args.prefix[match.end()]),
>> -              file=sys.stderr)
>> -        sys.exit(1)
>> -
>>      try:
>> -        schema = QAPISchema(args.schema)
>> +        generate(args.schema,
>> +                 output_dir=args.output_dir,
>> +                 prefix=args.prefix,
>> +                 unmask=args.unmask,
>> +                 builtins=args.builtins)
>>      except QAPIError as err:
>> -        print(err, file=sys.stderr)
>> -        exit(1)
>> -
>
> Glad to see that this "quitter" is gone in favor of one and only
> sys.exit().

I'm totally fine with having multiple sys.exit() in main().  They become
icky only when buried too deeply.

I'm fine with John's patch regardless.

[...]


