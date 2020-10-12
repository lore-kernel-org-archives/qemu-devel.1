Return-Path: <SRS0=wjGh=DT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4DC4C433E7
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 15:01:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C55520838
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 15:01:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eSc11Mqr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C55520838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33752 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kRzK8-0008NN-3v
	for qemu-devel@archiver.kernel.org; Mon, 12 Oct 2020 11:01:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46334)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kRzGd-0005NG-6V
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 10:57:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:39205)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kRzGb-0002Ts-Ci
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 10:57:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602514656;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UoQVhh1GBa37hTY7zvk3btIIkUgMm/QHkZmkaHDhutk=;
 b=eSc11Mqrp3mk3WEQlSMaZpm7X264iHoRcUAF6Ay+whP9ShBGa6tfy6QzqCZ+6QaGpRF+o7
 mtW1EzhiH1gqw7rWv5tizy0/dBE9KciaYGqeBszwWe5JIsR4G06afhj0qYTjq8MUt0cGB2
 acy5MFC7vhVn+/8mQFkYSi+7Lx21K3Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-197-CLSut8eGPJiqVCLt4CG3UA-1; Mon, 12 Oct 2020 10:57:33 -0400
X-MC-Unique: CLSut8eGPJiqVCLt4CG3UA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A7B52CF982;
 Mon, 12 Oct 2020 14:57:21 +0000 (UTC)
Received: from [10.10.117.231] (ovpn-117-231.rdu2.redhat.com [10.10.117.231])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 14B535D99B;
 Mon, 12 Oct 2020 14:57:20 +0000 (UTC)
Subject: Re: [PATCH v6 03/36] qapi-gen: Separate arg-parsing from generation
To: Markus Armbruster <armbru@redhat.com>
References: <20201009161558.107041-1-jsnow@redhat.com>
 <20201009161558.107041-4-jsnow@redhat.com>
 <87y2kfcnuo.fsf@dusky.pond.sub.org>
From: John Snow <jsnow@redhat.com>
Message-ID: <93202490-23fa-af72-85f4-75325e84f655@redhat.com>
Date: Mon, 12 Oct 2020 10:57:20 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <87y2kfcnuo.fsf@dusky.pond.sub.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jsnow@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/11 23:52:29
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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
Cc: Cleber Rosa <crosa@redhat.com>, qemu-devel@nongnu.org,
 Eduardo Habkost <ehabkost@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/9/20 1:26 PM, Markus Armbruster wrote:
> John Snow <jsnow@redhat.com> writes:
> 
>> This is a minor re-work of the entrypoint script. It isolates a
> 
> <pedantic>entrypoint is not a word</>  ;-P
> 

I'm not entirely sure why a German is complaining about the birth of a 
new and beautiful compound noun.

(I started to make sure I wrote it out as two words, but missed a spot. 
Too late now, unless you fixed it already.)

>> generate() method from the actual command-line mechanism.
>>
>> Signed-off-by: John Snow <jsnow@redhat.com>
>> Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
>> Reviewed-by: Cleber Rosa <crosa@redhat.com>
>> Tested-by: Cleber Rosa <crosa@redhat.com>
>> ---
>>   scripts/qapi-gen.py | 89 ++++++++++++++++++++++++++++++++++-----------
>>   1 file changed, 67 insertions(+), 22 deletions(-)
>>
>> diff --git a/scripts/qapi-gen.py b/scripts/qapi-gen.py
>> index 541e8c1f55d..054554ed846 100644
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
>> +This is the main entry point for generating C code from the QAPI schema.
>> +"""
>>   
>>   import argparse
>>   import re
>>   import sys
>> +from typing import Optional
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
>> +def invalid_char(prefix: str) -> Optional[str]:
> 
> Naming is hard...  invalid_char() makes sense because it returns the
> invalid character.  The name's a tad generic, though.  Would
> first_invalid_prefix_char() be easier to understand?
> 

Sounds like an improvement to me. I guess that should be in a follow-up now.

>> +    match = re.match(r'([A-Za-z_.-][A-Za-z0-9_.-]*)?', prefix)
>> +    if match.end() != len(prefix):
>> +        return prefix[match.end()]
>> +    return None
> [...]
> 


