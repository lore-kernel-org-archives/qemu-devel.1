Return-Path: <SRS0=+pSw=DC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 475EAC4346E
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 01:06:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF1212076B
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 01:06:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UuCWyMFg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF1212076B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53420 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLcC3-0002IF-Un
	for qemu-devel@archiver.kernel.org; Thu, 24 Sep 2020 21:06:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53388)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kLbpx-0006HI-T3
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 20:43:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:58012)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kLbpw-0001sX-2v
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 20:43:45 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600994622;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AgU9/qR3kk5UkT+YBPVrkaoy0g25p/9Q+52BbcqzFa8=;
 b=UuCWyMFgUn2UoT7w632Nr3aNfCILMY8J8UrgaR95AMIoW8N1uLGqdsLnO97+Sy0HdWPCz2
 yfISfV1pA9Ljn1Gu1pcSKhdnFMCqlarvvDdD0TKNRJvz3MkH0P3IiidwHsOv8MlJpFYFx9
 dJlhShnLRLqHqT+00WQnfBXG73mqU9E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-443-pYU6K7cEPN6m1aEoMABn2Q-1; Thu, 24 Sep 2020 20:43:40 -0400
X-MC-Unique: pYU6K7cEPN6m1aEoMABn2Q-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F02A710074BF;
 Fri, 25 Sep 2020 00:43:38 +0000 (UTC)
Received: from [10.10.119.140] (ovpn-119-140.rdu2.redhat.com [10.10.119.140])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6694955761;
 Fri, 25 Sep 2020 00:43:38 +0000 (UTC)
Subject: Re: [PATCH 03/16] qapi/expr.py: constrain incoming expression types
To: Cleber Rosa <crosa@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>
References: <20200922211313.4082880-1-jsnow@redhat.com>
 <20200922211313.4082880-4-jsnow@redhat.com>
 <20200923194224.GD3312949@habkost.net>
 <20200925000507.GE347918@localhost.localdomain>
From: John Snow <jsnow@redhat.com>
Message-ID: <23bf846d-eb5b-47a9-de64-3294e1eb8188@redhat.com>
Date: Thu, 24 Sep 2020 20:43:37 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200925000507.GE347918@localhost.localdomain>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jsnow@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 23:02:20
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
Cc: Michael Roth <mdroth@linux.vnet.ibm.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/24/20 8:05 PM, Cleber Rosa wrote:
> On Wed, Sep 23, 2020 at 03:42:24PM -0400, Eduardo Habkost wrote:
>> On Tue, Sep 22, 2020 at 05:13:00PM -0400, John Snow wrote:
>>> mypy does not know the types of values stored in Dicts that masquerade
>>> as objects. Help the type checker out by constraining the type.
>>>
>>> Signed-off-by: John Snow <jsnow@redhat.com>
>>> ---
>>>   scripts/qapi/expr.py | 25 ++++++++++++++++++++++---
>>>   1 file changed, 22 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/scripts/qapi/expr.py b/scripts/qapi/expr.py
>>> index 1872a8a3cc..f6b55a87c1 100644
>>> --- a/scripts/qapi/expr.py
>>> +++ b/scripts/qapi/expr.py
>>> @@ -15,9 +15,17 @@
>>>   # See the COPYING file in the top-level directory.
>>>   
>>>   import re
>>> +from typing import MutableMapping, Optional
>>>   
>>>   from .common import c_name
>>>   from .error import QAPISemError
>>> +from .parser import QAPIDoc
>>> +from .source import QAPISourceInfo
>>> +
>>> +
>>> +# Expressions in their raw form are JSON-like structures with arbitrary forms.
>>> +# Minimally, their top-level form must be a mapping of strings to values.
>>> +Expression = MutableMapping[str, object]
>>>   
>>>   
>>>   # Names must be letters, numbers, -, and _.  They must start with letter,
>>> @@ -280,9 +288,20 @@ def check_event(expr, info):
>>>   
>>>   def check_exprs(exprs):
>>>       for expr_elem in exprs:
>>> -        expr = expr_elem['expr']
>>> -        info = expr_elem['info']
>>> -        doc = expr_elem.get('doc')
>>> +        # Expression
>>> +        assert isinstance(expr_elem['expr'], dict)
>>> +        expr: Expression = expr_elem['expr']
>>> +        for key in expr.keys():
>>> +            assert isinstance(key, str)
>>
>> mypy doesn't seem to require the key type asserts, on my testing.
>>
> 
> Do you mean that mypy actually takes notice of the type assert?  And
> includes that as source of information for the type check or am I
> misinterpreting you?
> 
> BTW, what I understood from this assert is that a more specific
> type than the MutableMapping is desirable here.  Did I get that
> right John?
> 

Yes, we do want a more specific type. We'll get one somewhere in part 5 
when parser.py gets a workout.

> - Cleber.
> 

mypy takes notice of assert isinstance(x, FooType) because below this 
line, it is not possible for x to be anything other than a FooType.

You can use this to "downcast" types.

you can use cast() too, but those are "unsafe", in that they don't 
actually check. assert *will* check.

You can also constrain types by doing a simple:

if isinstance(x, FooType):
     x.FooMethod()


