Return-Path: <SRS0=WBSu=X2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D9EBC352AA
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 21:19:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C18B2168B
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 21:19:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C18B2168B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48280 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFPYE-0007AG-Ju
	for qemu-devel@archiver.kernel.org; Tue, 01 Oct 2019 17:19:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59408)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1iFOgF-00032m-99
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 16:23:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1iFOgC-0000AH-8u
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 16:23:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43146)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1iFOgC-00009T-0L
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 16:23:28 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id ECA6810C0929;
 Tue,  1 Oct 2019 20:23:26 +0000 (UTC)
Received: from [10.3.116.201] (ovpn-116-201.phx2.redhat.com [10.3.116.201])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 846E75C1D4;
 Tue,  1 Oct 2019 20:23:23 +0000 (UTC)
Subject: Re: [PATCH 4/7] qapi: Speed up frontend tests
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20191001191514.11208-1-armbru@redhat.com>
 <20191001191514.11208-5-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <9049db38-9698-a4f9-78af-c7b8f5a8a263@redhat.com>
Date: Tue, 1 Oct 2019 15:23:22 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20191001191514.11208-5-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.66]); Tue, 01 Oct 2019 20:23:27 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: marcandre.lureau@redhat.com, mdroth@linux.vnet.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/1/19 2:15 PM, Markus Armbruster wrote:
> "make check-qapi-schema" takes around 10s user + system time for me.
> With -j, it takes a bit over 3s real time.  We have worse tests.  It's
> still annoying when you work on the QAPI generator.

All true :)


> test-qapi.py is designed to be the simplest possible building block
> for a shell script to do the complete job (it's actually a Makefile,
> not a shell script; no real difference).  Python is just not meant for
> that.  It's for bigger blocks.
> 
> Move the post-processing and diffing into test-qapi.py, and make it
> capable of testing multiple schema files.

Sounds reasonable.

> 
> Running it once per test case now takes slightly longer than 8s.  But
> running it once for all of them takes under 0.2s.
> 
> Messing with the Makefile to run it only on the tests that need
> retesting is clearly not worth the bother.
> 
> Expected error output changes because the new normalization strips off
> $(SRCDIR)/tests/qapi-schema/ instead of just $(SRCDIR)/.
> 
> The .exit files go away, because there is no exit status to test
> anymore.

So the bulk of the patch is the mechanical fallout.

> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>   tests/Makefile.include                        |  16 +--

>   tests/qapi-schema/test-qapi.py                | 119 +++++++++++++++---

while these are the interesting parts.  (Using git diff -O path/to/file 
with a listing that floats those two files to the top of the diff would 
ease review slightly)

>   364 files changed, 413 insertions(+), 515 deletions(-)

>   delete mode 100644 tests/qapi-schema/struct-member-invalid.exit
>   mode change 100644 => 100755 tests/qapi-schema/test-qapi.py

I'm guessing this one is intentional.

> 
> diff --git a/tests/Makefile.include b/tests/Makefile.include
> index 214fbd941c..1b24b8ba10 100644
> --- a/tests/Makefile.include
> +++ b/tests/Makefile.include
> @@ -1102,17 +1102,11 @@ check-tests/check-block.sh: tests/check-block.sh qemu-img$(EXESUF) \
>   		$(patsubst %,%/all,$(filter %-softmmu,$(TARGET_DIRS)))
>   	@$<
>   
> -.PHONY: $(patsubst %, check-%, $(check-qapi-schema-y))
> -$(patsubst %, check-%, $(check-qapi-schema-y)): check-%.json: $(SRC_PATH)/%.json
> +.PHONY: check-tests/qapi-schema/frontend
> +check-tests/qapi-schema/frontend: $(addprefix $(SRC_PATH)/, $(check-qapi-schema-y))
>   	$(call quiet-command, PYTHONPATH=$(SRC_PATH)/scripts \
> -		PYTHONIOENCODING=utf-8 $(PYTHON) $(SRC_PATH)/tests/qapi-schema/test-qapi.py \
> -		$^ >$*.test.out 2>$*.test.err; \
> -		echo $$? >$*.test.exit, \
> -		"TEST","$*.out")
> -	@# Sanitize error messages (make them independent of build directory)
> -	@perl -p -e 's|\Q$(SRC_PATH)\E/||g' $*.test.err | diff -u $(SRC_PATH)/$*.err -
> -	@diff -u $(SRC_PATH)/$*.out $*.test.out
> -	@diff -u $(SRC_PATH)/$*.exit $*.test.exit
> +	  PYTHONIOENCODING=utf-8 $(PYTHON) $(SRC_PATH)/tests/qapi-schema/test-qapi.py $^, \
> +	  TEST, check-qapi-schema)
>   

So instead of one $(call $(PYTHON)) per test, it is now one call for all 
files at once.


> +++ b/tests/qapi-schema/allow-preconfig-test.err
> @@ -1,2 +1,2 @@
> -tests/qapi-schema/allow-preconfig-test.json: In command 'allow-preconfig-test':
> -tests/qapi-schema/allow-preconfig-test.json:2: flag 'allow-preconfig' may only use true value
> +allow-preconfig-test.json: In command 'allow-preconfig-test':
> +allow-preconfig-test.json:2: flag 'allow-preconfig' may only use true value

Normalization to strip off a longer prefix could have been done in a 
separate patch, but it doesn't matter.

> +++ b/tests/qapi-schema/test-qapi.py
> @@ -1,3 +1,4 @@
> +#!/usr/bin/env python
>   #
>   # QAPI parser test harness
>   #
> @@ -11,7 +12,14 @@
>   #
>   
>   from __future__ import print_function
> +import argparse
> +import difflib
> +import os
>   import sys
> +if sys.version_info[0] < 3:
> +    from cStringIO import StringIO
> +else:
> +    from io import StringIO

I guess we can't get rid of Python 2 during 'make check' just yet?


> +
> +    print("%s %s" % (test_name, 'UPDATE' if update else 'FAIL'),
> +          file=sys.stderr)
> +    out_diff = difflib.unified_diff(expected_out, actual_out, outfp.name)
> +    err_diff = difflib.unified_diff(expected_err, actual_err, errfp.name)
> +    sys.stdout.writelines(out_diff)
> +    sys.stdout.writelines(err_diff)
> +
> +    if not update:
> +        return 1
> +
> +    try:
> +        outfp.truncate(0)
> +        outfp.seek(0)
> +        outfp.writelines(actual_out)

Handy for mass-rebuilding of the directory after an error message tweak.


> +def main(argv):
> +    parser = argparse.ArgumentParser(
> +        description='QAPI schema tester')
> +    parser.add_argument('-d', '--dir', action='store', default='',
> +                        help="directory containing tests")
> +    parser.add_argument('-u', '--update', action='store_true',
> +                        help="update expected test results")
> +    parser.add_argument('tests', nargs='*', metavar='TEST', action='store')
> +    args = parser.parse_args()
> +

No --help mode? Not strictly necessary, but can be useful.

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org

