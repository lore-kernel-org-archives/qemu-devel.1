Return-Path: <SRS0=qJMs=D2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45C04C433E7
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 07:36:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 87D8A22243
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 07:36:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Qz1rl/j7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87D8A22243
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43204 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUPiF-0001Co-8c
	for qemu-devel@archiver.kernel.org; Mon, 19 Oct 2020 03:36:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50742)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kUPfr-0008So-Cu
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 03:33:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:40840)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kUPfn-0001DE-Sd
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 03:33:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603092811;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WnKuNCdVRpWx6kuMuePRfBsq8+jsStZlWRTxB8BJ8W0=;
 b=Qz1rl/j7HcwhM7eUbHtVeUb/1JjxGn/0Gh8miiZfeZthoPm1ANayi1qOEESZLq0qLXD/S1
 D/I3pmkYr1+Vul1PRIQ73cHwMKNdpLP+pCBj4X3fmmLTKzZ56va1pb21G/5px3vDfjcCh6
 vhEQ/sVgZIYnGXQmMlW6OFDMSqseL8E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-297-js2KfTeoNia4zf2MCamgqw-1; Mon, 19 Oct 2020 03:33:29 -0400
X-MC-Unique: js2KfTeoNia4zf2MCamgqw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1C6AC100746A;
 Mon, 19 Oct 2020 07:33:28 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-182.ams2.redhat.com
 [10.36.112.182])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id BDCD81002388;
 Mon, 19 Oct 2020 07:33:27 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 202621132A08; Mon, 19 Oct 2020 09:33:26 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Subject: Re: [PATCH v6 03/36] qapi-gen: Separate arg-parsing from generation
References: <20201009161558.107041-1-jsnow@redhat.com>
 <20201009161558.107041-4-jsnow@redhat.com>
 <87y2kfcnuo.fsf@dusky.pond.sub.org>
 <93202490-23fa-af72-85f4-75325e84f655@redhat.com>
Date: Mon, 19 Oct 2020 09:33:26 +0200
In-Reply-To: <93202490-23fa-af72-85f4-75325e84f655@redhat.com> (John Snow's
 message of "Mon, 12 Oct 2020 10:57:20 -0400")
Message-ID: <87r1pu1xh5.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Received-SPF: pass client-ip=216.205.24.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/19 01:44:30
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-devel@nongnu.org,
 Eduardo Habkost <ehabkost@redhat.com>, Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

John Snow <jsnow@redhat.com> writes:

> On 10/9/20 1:26 PM, Markus Armbruster wrote:
>> John Snow <jsnow@redhat.com> writes:
>> 
>>> This is a minor re-work of the entrypoint script. It isolates a
>> <pedantic>entrypoint is not a word</>  ;-P
>> 
>
> I'm not entirely sure why a German is complaining about the birth of a
> new and beautiful compound noun.

Ha!

> (I started to make sure I wrote it out as two words, but missed a
> spot. Too late now, unless you fixed it already.)

I didn't.

>>> generate() method from the actual command-line mechanism.
>>>
>>> Signed-off-by: John Snow <jsnow@redhat.com>
>>> Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
>>> Reviewed-by: Cleber Rosa <crosa@redhat.com>
>>> Tested-by: Cleber Rosa <crosa@redhat.com>
>>> ---
>>>   scripts/qapi-gen.py | 89 ++++++++++++++++++++++++++++++++++-----------
>>>   1 file changed, 67 insertions(+), 22 deletions(-)
>>>
>>> diff --git a/scripts/qapi-gen.py b/scripts/qapi-gen.py
>>> index 541e8c1f55d..054554ed846 100644
>>> --- a/scripts/qapi-gen.py
>>> +++ b/scripts/qapi-gen.py
>>> @@ -1,30 +1,77 @@
>>>   #!/usr/bin/env python3
>>> -# QAPI generator
>>> -#
>>> +
>>>   # This work is licensed under the terms of the GNU GPL, version 2 or later.
>>>   # See the COPYING file in the top-level directory.
>>>   +"""
>>> +QAPI Generator
>>> +
>>> +This is the main entry point for generating C code from the QAPI schema.
>>> +"""
>>>     import argparse
>>>   import re
>>>   import sys
>>> +from typing import Optional
>>>     from qapi.commands import gen_commands
>>> +from qapi.error import QAPIError
>>>   from qapi.events import gen_events
>>>   from qapi.introspect import gen_introspect
>>> -from qapi.schema import QAPIError, QAPISchema
>>> +from qapi.schema import QAPISchema
>>>   from qapi.types import gen_types
>>>   from qapi.visit import gen_visit
>>>     
>>> -def main(argv):
>>> +def invalid_char(prefix: str) -> Optional[str]:
>> 
>> Naming is hard...  invalid_char() makes sense because it returns the
>> invalid character.  The name's a tad generic, though.  Would
>> first_invalid_prefix_char() be easier to understand?
>
> Sounds like an improvement to me. I guess that should be in a follow-up now.

I took the liberty to rename it to invalid_prefix_char() in my tree.
Has since been merged into master as commit 52a474180ae.

>>> +    match = re.match(r'([A-Za-z_.-][A-Za-z0-9_.-]*)?', prefix)
>>> +    if match.end() != len(prefix):
>>> +        return prefix[match.end()]
>>> +    return None
>> [...]
>> 


