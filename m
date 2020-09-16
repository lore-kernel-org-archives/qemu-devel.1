Return-Path: <SRS0=+YCa=CZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76E87C433E2
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 14:39:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 095D2221E3
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 14:39:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IWXSmfc4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 095D2221E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38480 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIYaf-0005S2-0J
	for qemu-devel@archiver.kernel.org; Wed, 16 Sep 2020 10:39:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41180)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kIYM1-0000MD-Rr
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 10:24:17 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:54859
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kIYLz-0004Ic-EH
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 10:24:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600266249;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=r611QxqeMfOW63/g4ttXdKfGqWjTxcjLZPKA+RHH62Q=;
 b=IWXSmfc4Eo5hdjz4EiAeo9ocSm1lo3xPkfQiqq/4s3HxV3l4zpld3agm+8dPuwilCUbQAS
 wihKVNxe38TT/Y61+WLhtll+qw7vcR6cO7/Rcf1KnpvW8aZKmtEARjBNXMdPglaMn3x9Xx
 oaLfbMy9e2GdTaL4Ux3zPCDYfgx+/mQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-596-EbUf_7E4NZmvTewXdX815A-1; Wed, 16 Sep 2020 10:24:06 -0400
X-MC-Unique: EbUf_7E4NZmvTewXdX815A-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 64E708015A3;
 Wed, 16 Sep 2020 14:24:05 +0000 (UTC)
Received: from [10.10.119.140] (ovpn-119-140.rdu2.redhat.com [10.10.119.140])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 751655DE71;
 Wed, 16 Sep 2020 14:24:04 +0000 (UTC)
Subject: Re: [PATCH 04/37] qapi: move generator entrypoint into module
To: Markus Armbruster <armbru@redhat.com>
References: <20200915224027.2529813-1-jsnow@redhat.com>
 <20200915224027.2529813-5-jsnow@redhat.com>
 <877dsuos1n.fsf@dusky.pond.sub.org>
From: John Snow <jsnow@redhat.com>
Message-ID: <5b42ff66-9bc3-ea2e-a3f7-5105628e2c43@redhat.com>
Date: Wed, 16 Sep 2020 10:24:03 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <877dsuos1n.fsf@dusky.pond.sub.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jsnow@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Received-SPF: pass client-ip=205.139.110.61; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/16 00:53:39
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -51
X-Spam_score: -5.2
X-Spam_bar: -----
X-Spam_report: (-5.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.999,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.062, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/16/20 7:54 AM, Markus Armbruster wrote:
> John Snow <jsnow@redhat.com> writes:
> 
>> As part of delinting and adding type hints to the QAPI generator, it's
>> helpful for the entrypoint to be part of the module, only leaving a very
>> tiny entrypoint shim outside of the module.
>>
>> As a result, all of the include statements are reworked to be module-aware,
>> as explicit relative imports.
> 
> Should this be split into two commits, one for each of the paragraphs
> above?
> 

Hmm ... I hadn't considered it was possible, but actually ... I guess I 
can split those out, yeah.

> PEP 8 recommends absolute imports, with one exception:
> 
>      However, explicit relative imports are an acceptable alternative to
>      absolute imports, especially when dealing with complex package
>      layouts where using absolute imports would be unnecessarily verbose:
> 
>          from . import sibling
>          from .sibling import example
> 
>      Standard library code should avoid complex package layouts and
>      always use absolute imports.
> 
> Do you think it covers your use of relative imports?
> 

Admittedly I am going by trial and error; my experience is that the 
relative imports behave the nicest.

There is a historical fear of explicit relative imports because they are 
"new" and years of Python2 compatibility rendered many afraid of them. 
It is advice safely ignored in my opinion.

Using absolute imports (e.g. from qapi.sibling import foo) gets messy in 
virtual environments when you have *installed* the module in question: 
it becomes ambiguous as to *which* qapi you meant: the one in this 
folder, or the one installed to the environment?

Python, mypy, pylint, flake8 etc disagree sometimes, or can get 
confused; thinking there are two copies of each module.

Just my experience that relative imports seem to give me the least trouble.

>> This is done primarily for the benefit of python tooling (pylint, mypy,
>> flake8, et al) which otherwise has trouble consistently resolving
>> "qapi.x" to mean "a sibling file in this folder."
> 
> Can you give me an example of some tool having troube?
> 

I'd have to code up some examples. I have some hobby code unrelated to 
QEMU where I struggled to get flake8, mypy, and pylint all cooperating 
with an import regime until I gave up and used explicit relative imports.

>> Signed-off-by: John Snow <jsnow@redhat.com>
>> ---
>>   scripts/qapi-gen.py        | 94 +++-----------------------------------
>>   scripts/qapi/commands.py   |  4 +-
>>   scripts/qapi/doc.py        |  2 +-
>>   scripts/qapi/events.py     |  8 ++--
>>   scripts/qapi/expr.py       |  4 +-
>>   scripts/qapi/gen.py        |  4 +-
>>   scripts/qapi/introspect.py |  8 ++--
>>   scripts/qapi/parser.py     |  4 +-
>>   scripts/qapi/schema.py     |  8 ++--
>>   scripts/qapi/script.py     | 91 ++++++++++++++++++++++++++++++++++++
>>   scripts/qapi/types.py      |  6 +--
>>   scripts/qapi/visit.py      |  6 +--
>>   12 files changed, 124 insertions(+), 115 deletions(-)
>>   create mode 100644 scripts/qapi/script.py
> 
> Naming is hard...  main.py?
> 

I was thinking of changing this myself, so this convinced me.

>>
>> diff --git a/scripts/qapi-gen.py b/scripts/qapi-gen.py
>> index 59becba3e1..e649f8dd44 100644
>> --- a/scripts/qapi-gen.py
>> +++ b/scripts/qapi-gen.py
>> @@ -1,97 +1,15 @@
>>   #!/usr/bin/env python3
>> -
>> -# This work is licensed under the terms of the GNU GPL, version 2 or later.
>> -# See the COPYING file in the top-level directory.
>> -
> 
> Keep the license blurb.
> 

This is a mistake. I tried to convince git to "move" the old file and 
then add a "new" file to preserve history, but of course that's not how 
git manages file histories, so it didn't work.

TLDR: I didn't delete the license blurb, I just didn't "add" it again.
I'll "fix" that.

> [...]
> 


