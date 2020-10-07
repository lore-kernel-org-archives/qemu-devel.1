Return-Path: <SRS0=37Ja=DO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CEE0C4363C
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 08:08:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D0F7B2076C
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 08:08:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QB4Jf0xg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0F7B2076C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54146 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQ4VD-0005QG-SV
	for qemu-devel@archiver.kernel.org; Wed, 07 Oct 2020 04:08:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42428)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kQ4UG-0004z1-Eo
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 04:07:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:40548)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kQ4UE-0006kM-5p
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 04:07:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602058064;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=d9kXh7RoL4YQiju0TzamBUAGNFVfrkHjAVWK0nDJBQI=;
 b=QB4Jf0xgRNR2T/ngsu8vhHb9rWcha4EyFsJxMvGQuHUMdOa2YJXI0MclHZU+4OSc9JYRAN
 OKAAjjqKkIjoq8bMC9188cMIiY2aWWSmhLH3E8r5+4tsM7G6XgWEvWoyp4Rii4DzBba+WM
 hiGI84pF+lTuYBNxCWpryVPXfqJijkM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-524-MJAZebrbNQmLzVe-zh9UxQ-1; Wed, 07 Oct 2020 04:07:41 -0400
X-MC-Unique: MJAZebrbNQmLzVe-zh9UxQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F2B1B805F04
 for <qemu-devel@nongnu.org>; Wed,  7 Oct 2020 08:07:39 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-182.ams2.redhat.com
 [10.36.112.182])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9586A5C1BD;
 Wed,  7 Oct 2020 08:07:39 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 1AB9C11329C1; Wed,  7 Oct 2020 10:07:38 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Subject: Re: [PATCH v5 03/36] qapi-gen: Separate arg-parsing from generation
References: <20201005195158.2348217-1-jsnow@redhat.com>
 <20201005195158.2348217-4-jsnow@redhat.com>
Date: Wed, 07 Oct 2020 10:07:38 +0200
In-Reply-To: <20201005195158.2348217-4-jsnow@redhat.com> (John Snow's message
 of "Mon, 5 Oct 2020 15:51:25 -0400")
Message-ID: <877ds2jw6t.fsf@dusky.pond.sub.org>
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
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/07 00:44:56
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.733,
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
Cc: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 Eduardo Habkost <ehabkost@redhat.com>, Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

John Snow <jsnow@redhat.com> writes:

> This is a minor re-work of the entrypoint script. It isolates a
> generate() method from the actual command-line mechanism.
>
> Signed-off-by: John Snow <jsnow@redhat.com>
> Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
> Reviewed-by: Cleber Rosa <crosa@redhat.com>
> Tested-by: Cleber Rosa <crosa@redhat.com>
> ---
>  scripts/qapi-gen.py | 85 +++++++++++++++++++++++++++++++++------------
>  1 file changed, 62 insertions(+), 23 deletions(-)
>
> diff --git a/scripts/qapi-gen.py b/scripts/qapi-gen.py
> index 541e8c1f55d..117b396a595 100644
> --- a/scripts/qapi-gen.py
> +++ b/scripts/qapi-gen.py
> @@ -1,30 +1,77 @@
>  #!/usr/bin/env python3
> -# QAPI generator
> -#
> +
>  # This work is licensed under the terms of the GNU GPL, version 2 or later.
>  # See the COPYING file in the top-level directory.
>  
> +"""
> +QAPI Generator
> +
> +This script is the main entry point for generating C code from the QAPI schema.
> +"""
>  
>  import argparse
>  import re
>  import sys
>  
>  from qapi.commands import gen_commands
> +from qapi.error import QAPIError
>  from qapi.events import gen_events
>  from qapi.introspect import gen_introspect
> -from qapi.schema import QAPIError, QAPISchema
> +from qapi.schema import QAPISchema
>  from qapi.types import gen_types
>  from qapi.visit import gen_visit
>  
>  
> -def main(argv):
> +DEFAULT_OUTPUT_DIR = ''
> +DEFAULT_PREFIX = ''
> +
> +
> +def generate(schema_file: str,
> +             output_dir: str,
> +             prefix: str,
> +             unmask: bool = False,
> +             builtins: bool = False) -> None:
> +    """
> +    generate uses a given schema to produce C code in the target directory.
> +
> +    :param schema_file: The primary QAPI schema file.
> +    :param output_dir: The output directory to store generated code.
> +    :param prefix: Optional C-code prefix for symbol names.
> +    :param unmask: Expose non-ABI names through introspection?
> +    :param builtins: Generate code for built-in types?
> +
> +    :raise QAPIError: On failures.
> +    """
> +    match = re.match(r'([A-Za-z_.-][A-Za-z0-9_.-]*)?', prefix)
> +    if match.end() != len(prefix):
> +        msg = "funny character '{:s}' in prefix '{:s}'".format(
> +            prefix[match.end()], prefix)
> +        raise QAPIError('', None, msg)
> +
> +    schema = QAPISchema(schema_file)
> +    gen_types(schema, output_dir, prefix, builtins)
> +    gen_visit(schema, output_dir, prefix, builtins)
> +    gen_commands(schema, output_dir, prefix)
> +    gen_events(schema, output_dir, prefix)
> +    gen_introspect(schema, output_dir, prefix, unmask)
> +
> +
> +def main() -> int:
> +    """
> +    gapi-gen shell script entrypoint.

What's a "shell script entrypoint"?

Python docs talk about "when [...] run as a script":
https://docs.python.org/3/library/__main__.html

Similar:
https://docs.python.org/3/tutorial/modules.html#executing-modules-as-scripts

> +    Expects arguments via sys.argv, see --help for details.
> +
> +    :return: int, 0 on success, 1 on failure.
> +    """
>      parser = argparse.ArgumentParser(
>          description='Generate code from a QAPI schema')
>      parser.add_argument('-b', '--builtins', action='store_true',
>                          help="generate code for built-in types")
> -    parser.add_argument('-o', '--output-dir', action='store', default='',
> +    parser.add_argument('-o', '--output-dir', action='store',
> +                        default=DEFAULT_OUTPUT_DIR,
>                          help="write output to directory OUTPUT_DIR")
> -    parser.add_argument('-p', '--prefix', action='store', default='',
> +    parser.add_argument('-p', '--prefix', action='store',
> +                        default=DEFAULT_PREFIX,
>                          help="prefix for symbols")
>      parser.add_argument('-u', '--unmask-non-abi-names', action='store_true',
>                          dest='unmask',
> @@ -32,25 +79,17 @@ def main(argv):
>      parser.add_argument('schema', action='store')
>      args = parser.parse_args()
>  
> -    match = re.match(r'([A-Za-z_.-][A-Za-z0-9_.-]*)?', args.prefix)
> -    if match.end() != len(args.prefix):
> -        print("%s: 'funny character '%s' in argument of --prefix"
> -              % (sys.argv[0], args.prefix[match.end()]),
> -              file=sys.stderr)
> -        sys.exit(1)
> -
>      try:
> -        schema = QAPISchema(args.schema)
> +        generate(args.schema,
> +                 output_dir=args.output_dir,
> +                 prefix=args.prefix,
> +                 unmask=args.unmask,
> +                 builtins=args.builtins)
>      except QAPIError as err:
> -        print(err, file=sys.stderr)
> -        exit(1)
> -
> -    gen_types(schema, args.output_dir, args.prefix, args.builtins)
> -    gen_visit(schema, args.output_dir, args.prefix, args.builtins)
> -    gen_commands(schema, args.output_dir, args.prefix)
> -    gen_events(schema, args.output_dir, args.prefix)
> -    gen_introspect(schema, args.output_dir, args.prefix, args.unmask)
> +        print(f"{sys.argv[0]}: {str(err)}", file=sys.stderr)
> +        return 1
> +    return 0
>  
>  
>  if __name__ == '__main__':
> -    main(sys.argv)
> +    sys.exit(main())

What does sys.exit() really buy us here?  I'm asking because both spots
in the Python docs I referenced above do without.


