Return-Path: <SRS0=+pSw=DC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50D7BC4346E
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 01:23:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E7E15207C4
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 01:23:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CvkJR8hh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7E15207C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44954 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLcRz-0006DW-2y
	for qemu-devel@archiver.kernel.org; Thu, 24 Sep 2020 21:23:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52914)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kLbmi-0003Fk-N5
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 20:40:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:47292)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kLbmg-0001UD-OX
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 20:40:24 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600994421;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pIgCJsDWrPMoLzDXWHgi0HhWA5fyK63n3w5Th+6p1dA=;
 b=CvkJR8hh+kmDV3t2j3XyF+uKxXPKW5NuSkUVBXrpP7PYMuLuZfgaLep+xHtnhJSOaSs8lO
 hExWYcbjK6K40wE3KlVUF57BZAhyrcIVUPgrmcosfec7fJgWwYdC9cfddVWjNPXa28vXgY
 8kqshcfQ1XU1RbPegR//TRH8I/ZGy/8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-480-4iYwdXcEN4mkGjU_uKavFQ-1; Thu, 24 Sep 2020 20:40:19 -0400
X-MC-Unique: 4iYwdXcEN4mkGjU_uKavFQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DA8976408A;
 Fri, 25 Sep 2020 00:40:18 +0000 (UTC)
Received: from [10.10.119.140] (ovpn-119-140.rdu2.redhat.com [10.10.119.140])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 882D873694;
 Fri, 25 Sep 2020 00:40:17 +0000 (UTC)
Subject: Re: [PATCH 03/16] qapi/expr.py: constrain incoming expression types
To: Eduardo Habkost <ehabkost@redhat.com>
References: <20200922211313.4082880-1-jsnow@redhat.com>
 <20200922211313.4082880-4-jsnow@redhat.com>
 <20200923194224.GD3312949@habkost.net>
From: John Snow <jsnow@redhat.com>
Message-ID: <130816d7-64b7-acb5-fdb8-619e1c0dfb98@redhat.com>
Date: Thu, 24 Sep 2020 20:40:16 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200923194224.GD3312949@habkost.net>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jsnow@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/24 01:10:00
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.199,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.214, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>, Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/23/20 3:42 PM, Eduardo Habkost wrote:
> On Tue, Sep 22, 2020 at 05:13:00PM -0400, John Snow wrote:
>> mypy does not know the types of values stored in Dicts that masquerade
>> as objects. Help the type checker out by constraining the type.
>>
>> Signed-off-by: John Snow <jsnow@redhat.com>
>> ---
>>   scripts/qapi/expr.py | 25 ++++++++++++++++++++++---
>>   1 file changed, 22 insertions(+), 3 deletions(-)
>>
>> diff --git a/scripts/qapi/expr.py b/scripts/qapi/expr.py
>> index 1872a8a3cc..f6b55a87c1 100644
>> --- a/scripts/qapi/expr.py
>> +++ b/scripts/qapi/expr.py
>> @@ -15,9 +15,17 @@
>>   # See the COPYING file in the top-level directory.
>>   
>>   import re
>> +from typing import MutableMapping, Optional
>>   
>>   from .common import c_name
>>   from .error import QAPISemError
>> +from .parser import QAPIDoc
>> +from .source import QAPISourceInfo
>> +
>> +
>> +# Expressions in their raw form are JSON-like structures with arbitrary forms.
>> +# Minimally, their top-level form must be a mapping of strings to values.
>> +Expression = MutableMapping[str, object]
>>   
>>   
>>   # Names must be letters, numbers, -, and _.  They must start with letter,
>> @@ -280,9 +288,20 @@ def check_event(expr, info):
>>   
>>   def check_exprs(exprs):
>>       for expr_elem in exprs:
>> -        expr = expr_elem['expr']
>> -        info = expr_elem['info']
>> -        doc = expr_elem.get('doc')
>> +        # Expression
>> +        assert isinstance(expr_elem['expr'], dict)
>> +        expr: Expression = expr_elem['expr']
>> +        for key in expr.keys():
>> +            assert isinstance(key, str)
> 
> mypy doesn't seem to require the key type asserts, on my testing.
> 

Strictly no. This code is removed somewhere in part 5 when I introduce a 
typed structure to carry this data from the Parser to the Expression 
checker.

(Sometimes, these asserts were for my own sake.)

>> +
>> +        # QAPISourceInfo
>> +        assert isinstance(expr_elem['info'], QAPISourceInfo)
>> +        info: QAPISourceInfo = expr_elem['info']
>> +
>> +        # Optional[QAPIDoc]
>> +        tmp = expr_elem.get('doc')
>> +        assert tmp is None or isinstance(tmp, QAPIDoc)
>> +        doc: Optional[QAPIDoc] = tmp
> 
> Do you need a separate variable here?  This seems to work too:
> 
>          doc = expr_elem.get('doc')
>          assert doc is None or isinstance(doc, QAPIDoc)
> 
> after the assert, mypy will infer the type of doc to be
> Optional[QAPIDoc].
> 

In full honesty, I don't recall... but this code does get replaced by 
the end of this marathon.

> None of this should block a useful 120-patch cleanup series, so:
> 
> Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
> 

Thanks!


