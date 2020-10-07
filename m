Return-Path: <SRS0=37Ja=DO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 692CEC4363C
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 08:13:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A1BF02076C
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 08:13:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZNenDhSw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1BF02076C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56398 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQ4ZV-0006bl-96
	for qemu-devel@archiver.kernel.org; Wed, 07 Oct 2020 04:13:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43264)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kQ4Yh-0006CD-NH
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 04:12:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:48778)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kQ4Yg-0007E3-0q
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 04:12:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602058341;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CFSaMmhgUPFyRuLi2XnZfbFI1xuF8UsAlQid+PHRtEw=;
 b=ZNenDhSwlnvrVDYgkBB1yO8UruBWxLitBaOkz+CRc/Q0pVxLfWLuH8y7lqbwVZJMj57XLg
 HdKiTUn0Asp939YDsPKXtCtm4zJ/0o0ZNgn1PHORHSap9JpA7+aZrBHwehFT0Ik6Y9JMTd
 vlLz04DlOOihIDjJtEDG+LsWEjVHq8M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-229-m5-uw94oONW1P-XEcJNULQ-1; Wed, 07 Oct 2020 04:12:19 -0400
X-MC-Unique: m5-uw94oONW1P-XEcJNULQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7287957050
 for <qemu-devel@nongnu.org>; Wed,  7 Oct 2020 08:12:18 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-182.ams2.redhat.com
 [10.36.112.182])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3F96F6EF49;
 Wed,  7 Oct 2020 08:12:18 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id BA04211329C1; Wed,  7 Oct 2020 10:12:16 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Subject: Re: [PATCH v5 03/36] qapi-gen: Separate arg-parsing from generation
References: <20201005195158.2348217-1-jsnow@redhat.com>
 <20201005195158.2348217-4-jsnow@redhat.com>
Date: Wed, 07 Oct 2020 10:12:16 +0200
In-Reply-To: <20201005195158.2348217-4-jsnow@redhat.com> (John Snow's message
 of "Mon, 5 Oct 2020 15:51:25 -0400")
Message-ID: <87r1qaihen.fsf@dusky.pond.sub.org>
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
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/07 00:54:30
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.733,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

I keep stumbling over things in later patches that turn out to go back
to this one.

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

PEP 8: For flowing long blocks of text with fewer structural
restrictions (docstrings or comments), the line length should be limited
to 72 characters.

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

PEP 257: The docstring is a phrase ending in a period.  It prescribes
the function or method's effect as a command ("Do this", "Return that"),
not as a description; e.g. don't write "Returns the pathname ...".

Suggest

       Generate C code for the given schema into the target directory.

> +
> +    :param schema_file: The primary QAPI schema file.
> +    :param output_dir: The output directory to store generated code.
> +    :param prefix: Optional C-code prefix for symbol names.
> +    :param unmask: Expose non-ABI names through introspection?
> +    :param builtins: Generate code for built-in types?
> +
> +    :raise QAPIError: On failures.
> +    """
[...]


