Return-Path: <SRS0=+pSw=DC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19F36C4363D
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 01:12:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9474120791
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 01:12:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iVxiuHSm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9474120791
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45616 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLcHU-0002aR-MM
	for qemu-devel@archiver.kernel.org; Thu, 24 Sep 2020 21:12:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55858)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kLc4B-0000yF-P1
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 20:58:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:45275)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kLc49-0003hV-Nv
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 20:58:27 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600995505;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9pSe8/+Y+rhn7qmvv6XutEPl9Ip12p8ZldXL1inVQds=;
 b=iVxiuHSm6evgVbq2RjE9wJyEvB2eRYKS9eKxR7qYC54DIN+EPv3MM0e8n8c3LdRftGvMao
 DNK6zAusIBp5DBpJpDKhizHZOnnLK5ev7VtqenlrWm932u+QY8um5I0BVaqNiS7R4aZBBI
 Iq3YJaUzjrymNwuIRt7zH6qzJu7hmkE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-134-tWi0YUslMZC_ZL-ttXI0ug-1; Thu, 24 Sep 2020 20:58:22 -0400
X-MC-Unique: tWi0YUslMZC_ZL-ttXI0ug-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0343D1006708;
 Fri, 25 Sep 2020 00:58:22 +0000 (UTC)
Received: from [10.10.119.140] (ovpn-119-140.rdu2.redhat.com [10.10.119.140])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5F0D873673;
 Fri, 25 Sep 2020 00:58:21 +0000 (UTC)
Subject: Re: [PATCH 15/16] qapi/expr.py: move related checks inside check_xxx
 functions
To: Eduardo Habkost <ehabkost@redhat.com>
References: <20200922211313.4082880-1-jsnow@redhat.com>
 <20200922211313.4082880-16-jsnow@redhat.com>
 <20200923202509.GK3717385@habkost.net>
From: John Snow <jsnow@redhat.com>
Message-ID: <4ab923a8-ff03-474a-4702-2534e3744b5e@redhat.com>
Date: Thu, 24 Sep 2020 20:58:20 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200923202509.GK3717385@habkost.net>
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

On 9/23/20 4:25 PM, Eduardo Habkost wrote:
> On Tue, Sep 22, 2020 at 05:13:12PM -0400, John Snow wrote:
>> There's not a big obvious difference between the types of checks that
>> happen in the main function versus the kind that happen in the
>> functions. Now they're in one place for each of the main types.
>>
>> As part of the move, spell out the required and optional keywords so
>> they're obvious at a glance.
>>
>> Signed-off-by: John Snow <jsnow@redhat.com>
>> ---
>>   scripts/qapi/expr.py | 55 ++++++++++++++++++++++++++------------------
>>   1 file changed, 33 insertions(+), 22 deletions(-)
>>
>> diff --git a/scripts/qapi/expr.py b/scripts/qapi/expr.py
>> index 69ee9e3f18..74b2681ef8 100644
>> --- a/scripts/qapi/expr.py
>> +++ b/scripts/qapi/expr.py
>> @@ -333,6 +333,10 @@ def check_enum(expr: Expression, info: QAPISourceInfo) -> None:
>>       :param expr: `Expression` to validate.
>>       :param info: QAPI source file information.
>>       """
>> +    check_keys(expr, info, 'enum',
>> +               required=('enum', 'data'),
>> +               optional=('if', 'features', 'prefix'))
>> +
>>       name = expr['enum']
>>       members = expr['data']
>>       prefix = expr.get('prefix')
>> @@ -363,6 +367,11 @@ def check_struct(expr: Expression, info: QAPISourceInfo) -> None:
>>       :param expr: `Expression` to validate.
>>       :param info: QAPI source file information.
>>       """
>> +    check_keys(expr, info, 'struct',
>> +               required=('struct', 'data'),
>> +               optional=('base', 'if', 'features'))
>> +    normalize_members(expr['data'])
>> +
>>       name = cast(str, expr['struct'])  # Asserted in check_exprs
>>       members = expr['data']
>>   
>> @@ -377,6 +386,13 @@ def check_union(expr: Expression, info: QAPISourceInfo) -> None:
>>       :param expr: `Expression` to validate.
>>       :param info: QAPI source file information.
>>       """
>> +    check_keys(expr, info, 'union',
>> +               required=('union', 'data'),
>> +               optional=('base', 'discriminator', 'if', 'features'))
>> +
>> +    normalize_members(expr.get('base'))
>> +    normalize_members(expr['data'])
>> +
>>       name = cast(str, expr['union'])  # Asserted in check_exprs
>>       base = expr.get('base')
>>       discriminator = expr.get('discriminator')
>> @@ -409,6 +425,11 @@ def check_alternate(expr: Expression, info: QAPISourceInfo) -> None:
>>       :param expr: Expression to validate.
>>       :param info: QAPI source file information.
>>       """
>> +    check_keys(expr, info, 'alternate',
>> +               required=('alternate', 'data'),
>> +               optional=('if', 'features'))
>> +    normalize_members(expr['data'])
>> +
>>       members = expr['data']
>>   
>>       if not members:
>> @@ -432,6 +453,13 @@ def check_command(expr: Expression, info: QAPISourceInfo) -> None:
>>       :param expr: `Expression` to validate.
>>       :param info: QAPI source file information.
>>       """
>> +    check_keys(expr, info, 'command',
>> +               required=['command'],
>> +               optional=('data', 'returns', 'boxed', 'if', 'features',
>> +                         'gen', 'success-response', 'allow-oob',
>> +                         'allow-preconfig'))
>> +    normalize_members(expr.get('data'))
>> +
>>       args = expr.get('data')
>>       rets = expr.get('returns')
>>       boxed = expr.get('boxed', False)
>> @@ -453,6 +481,11 @@ def check_event(expr: Expression, info: QAPISourceInfo) -> None:
>>           if:       `Optional[Ifcond]`
>>           features: `Optional[Features]`
>>       """
>> +    normalize_members(expr.get('data'))
>> +    check_keys(expr, info, 'event',
>> +               required=['event'],
>> +               optional=('data', 'boxed', 'if', 'features'))
> 
> Why is the order reversed here?  The other functions call
> check_keys() before normalize_members().
> 

Oops! This was from an earlier experiment. I am dabbling with factoring 
out all of the normalization into a step that occurs discretely before 
data shape validation.

I have deep, ulterior reasons for doing this.

...But they shouldn't have leaked into this patch series, so I'll fix 
that. Thanks!

--js


