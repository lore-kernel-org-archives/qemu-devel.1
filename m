Return-Path: <SRS0=+sEj=XT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CC06C432C1
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 20:44:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F0B12146E
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 20:44:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F0B12146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50926 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCrfN-0004Jq-P9
	for qemu-devel@archiver.kernel.org; Tue, 24 Sep 2019 16:44:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52827)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1iCrdI-0002rS-FS
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 16:42:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1iCrdG-0003Ho-O2
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 16:42:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50070)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1iCrdG-0003Gd-F4
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 16:41:58 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id AC3968665A;
 Tue, 24 Sep 2019 20:41:55 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-117-142.ams2.redhat.com
 [10.36.117.142])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 031FC60603;
 Tue, 24 Sep 2019 20:41:51 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 89D7A113864E; Tue, 24 Sep 2019 22:41:49 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH 16/25] qapi: Move context-sensitive checking to the proper
 place
References: <20190924132830.15835-1-armbru@redhat.com>
 <20190924132830.15835-17-armbru@redhat.com>
 <15b817d6-afa5-53c0-1fdd-2af4ad2a0bd8@redhat.com>
Date: Tue, 24 Sep 2019 22:41:49 +0200
In-Reply-To: <15b817d6-afa5-53c0-1fdd-2af4ad2a0bd8@redhat.com> (Eric Blake's
 message of "Tue, 24 Sep 2019 12:49:34 -0500")
Message-ID: <87zhit8m0i.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.26]); Tue, 24 Sep 2019 20:41:55 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: mdroth@linux.vnet.ibm.com, marcandre.lureau@redhat.com,
 Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Eric Blake <eblake@redhat.com> writes:

> On 9/24/19 8:28 AM, Markus Armbruster wrote:
>> When we introduced the QAPISchema intermediate representation (commit
>> ac88219a6c7), we took a shortcut: we left check_exprs() & friends
>> alone instead of moving semantic checks into the
>> QAPISchemaFOO.check().  The .check() assert check_exprs() did its job.
>> 
>> Time to finish the conversion job.  Move exactly the context-sensitive
>> checks to the .check().  They replace assertions there.  Context-free
>> checks stay put.
>> 
>> Fixes the misleading optional tag error demonstrated by test
>> flat-union-optional-discriminator.
>> 
>> A few other error message improve.
>> 
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>
>> diff --git a/scripts/qapi/common.py b/scripts/qapi/common.py
>> index f5599559ac..ac4c898e51 100644
>> --- a/scripts/qapi/common.py
>
> Thankfully, our large coverage of tests goes a long way to show that the
> conversion is correct.  I didn't notice anything obvious that might have
> been overlooked (we may still find things down the road, but I'm not
> going to hold up this patch trying to find those things).  Meanwhile,
> the conversion from assert to conditionals inside .check() looks complete.

Additional arguments supporting correctness:

* Every deleted check gets added back.

* Every added check replaces an assertion.

>> +++ b/tests/qapi-schema/args-union.err
>> @@ -1,2 +1,2 @@
>>  tests/qapi-schema/args-union.json: In command 'oops':
>> -tests/qapi-schema/args-union.json:3: 'data' for command 'oops' cannot use union type 'Uni'
>> +tests/qapi-schema/args-union.json:3: command's 'data' can take union type 'Uni' only with 'boxed': true
>
> This one is definitely nicer.
>
>> +++ b/tests/qapi-schema/flat-union-discriminator-bad-name.err
>> @@ -1,2 +1,2 @@
>>  tests/qapi-schema/flat-union-discriminator-bad-name.json: In union 'MyUnion':
>> -tests/qapi-schema/flat-union-discriminator-bad-name.json:7: discriminator of flat union 'MyUnion' uses invalid name '*switch'
>> +tests/qapi-schema/flat-union-discriminator-bad-name.json:6: discriminator '*switch' is not a member of 'base'
>> diff --git a/tests/qapi-schema/flat-union-discriminator-bad-name.json b/tests/qapi-schema/flat-union-discriminator-bad-name.json
>> index ea84b75cac..3ae8c06a89 100644
>> --- a/tests/qapi-schema/flat-union-discriminator-bad-name.json
>> +++ b/tests/qapi-schema/flat-union-discriminator-bad-name.json
>> @@ -1,5 +1,4 @@
>>  # discriminator '*switch' isn't a member of base, 'switch' is
>> -# reports "uses invalid name", which is good enough
>>  { 'enum': 'Enum', 'data': [ 'one', 'two' ] }
>>  { 'struct': 'Base',
>>    'data': { '*switch': 'Enum' } }
>
> I find this one to be borderline in quality (if we have '*switch' in the
> base, claiming that '*switch' is not a member of base is confusing until
> you realize that base actually has an optional member named 'switch') -
> but anyone that actually stumbles into this one will probably quickly
> figure out their problem, and we may be revisiting it later anyways when
> we finally include patches for a default discriminator.
>
>> +++ b/tests/qapi-schema/flat-union-optional-discriminator.err
>> @@ -1,2 +1,2 @@
>>  tests/qapi-schema/flat-union-optional-discriminator.json: In union 'MyUnion':
>> -tests/qapi-schema/flat-union-optional-discriminator.json:7: discriminator 'switch' is not a member of 'base'
>> +tests/qapi-schema/flat-union-optional-discriminator.json:6: discriminator member 'switch' of base type 'Base' must not be optional
>> diff --git a/tests/qapi-schema/flat-union-optional-discriminator.json b/tests/qapi-schema/flat-union-optional-discriminator.json
>> index 143ab23a0d..2e7f766f60 100644
>> --- a/tests/qapi-schema/flat-union-optional-discriminator.json
>> +++ b/tests/qapi-schema/flat-union-optional-discriminator.json
>> @@ -1,5 +1,4 @@
>>  # we require the discriminator to be non-optional
>> -# FIXME reports "discriminator 'switch' is not a member of base struct 'Base'"
>>  { 'enum': 'Enum', 'data': [ 'one', 'two' ] }
>>  { 'struct': 'Base',
>>    'data': { '*switch': 'Enum' } }
>
> And while the other one is borderline, I agree that this one is better.
>
>> +++ b/tests/qapi-schema/union-unknown.err
>> @@ -1,2 +1,2 @@
>>  tests/qapi-schema/union-unknown.json: In union 'Union':
>> -tests/qapi-schema/union-unknown.json:2: member 'unknown' of union 'Union' uses unknown type 'MissingType'
>> +tests/qapi-schema/union-unknown.json:2: union uses unknown type 'MissingType'
>> diff --git a/tests/qapi-schema/union-unknown.json b/tests/qapi-schema/union-unknown.json
>> index aa7e8143d8..64d3666176 100644
>> --- a/tests/qapi-schema/union-unknown.json
>> +++ b/tests/qapi-schema/union-unknown.json
>> @@ -1,3 +1,3 @@
>>  # we reject a union with unknown type in branch
>>  { 'union': 'Union',
>> -  'data': { 'unknown': 'MissingType' } }
>> +  'data': { 'unknown': ['MissingType'] } }
>> 
>
> And here you covered one more code path by going through an array type.
>
> Overall looks good.
>
> Reviewed-by: Eric Blake <eblake@redhat.com>

Thanks!

