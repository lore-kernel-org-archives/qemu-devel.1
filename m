Return-Path: <SRS0=+pSw=DC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4932BC4363D
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 16:47:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 18AF221D42
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 16:47:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Vz+HO1JO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18AF221D42
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45036 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLqsx-0000h0-1g
	for qemu-devel@archiver.kernel.org; Fri, 25 Sep 2020 12:47:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49382)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kLqbA-0005lo-06
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 12:29:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:22479)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kLqb7-0007br-G3
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 12:29:27 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601051363;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wzmZ2eoBsEQK1WfB7VJoaFOaHLA9tx1r6GMhTOnY/i0=;
 b=Vz+HO1JOw/GVPy0tZl08238NwT6NZUmpkfGY9OCkYlm25XjIK6BLtlI9vUozp9na5UTCvX
 bMf7/C3uMv2J0J3eM+SgnQB4tSACqhSdQ7YecEfZlGfPeq4OJ7ia7RtnUE9NwT/5P/NMGK
 2vy8dc/GGRBgbwRU2J1FWJwexQiFXMQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-452-tmp6xR_EMJqr3MXcKX4eHA-1; Fri, 25 Sep 2020 12:29:17 -0400
X-MC-Unique: tmp6xR_EMJqr3MXcKX4eHA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0D29918BA286;
 Fri, 25 Sep 2020 16:29:16 +0000 (UTC)
Received: from [10.10.119.140] (ovpn-119-140.rdu2.redhat.com [10.10.119.140])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2DACF60CCC;
 Fri, 25 Sep 2020 16:29:15 +0000 (UTC)
Subject: Re: [PATCH v2 24/38] qapi/gen.py: Fix edge-case of _is_user_module
To: Markus Armbruster <armbru@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>
References: <20200922210101.4081073-1-jsnow@redhat.com>
 <20200922210101.4081073-25-jsnow@redhat.com>
 <20200923151743.GK3312949@habkost.net> <87wo0iroxo.fsf@dusky.pond.sub.org>
From: John Snow <jsnow@redhat.com>
Message-ID: <b9b4ded3-4e55-f987-b6ff-dc52178f7238@redhat.com>
Date: Fri, 25 Sep 2020 12:29:14 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <87wo0iroxo.fsf@dusky.pond.sub.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jsnow@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/25 01:07:33
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.199,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.238, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org,
 Michael Roth <mdroth@linux.vnet.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/25/20 9:00 AM, Markus Armbruster wrote:
> Eduardo Habkost <ehabkost@redhat.com> writes:
> 
>> On Tue, Sep 22, 2020 at 05:00:47PM -0400, John Snow wrote:
>>> The edge case is that if the name is '', this expression returns a
>>> string instead of a bool, which violates our declared type.
>>>
>>> Signed-off-by: John Snow <jsnow@redhat.com>
>>> ---
>>>   scripts/qapi/gen.py | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/scripts/qapi/gen.py b/scripts/qapi/gen.py
>>> index 9898d513ae..cb2b2655c3 100644
>>> --- a/scripts/qapi/gen.py
>>> +++ b/scripts/qapi/gen.py
>>> @@ -251,7 +251,7 @@ def __init__(self, prefix, what, user_blurb, builtin_blurb, pydoc):
>>>   
>>>       @staticmethod
>>>       def _is_user_module(name):
>>> -        return name and not name.startswith('./')
>>> +        return name is not None and not name.startswith('./')
>>
>> This changes behavior if name=='', and I guess this is OK, but
>> I'm not sure.
> 
> @name is either
> 
> (1) A module pathname relative to the main module
> 
>      This is a module defined by the user.
> 
> (2) system module name, starting with './'
> 
>      This is a named system module.  We currently have two: './init' in
>      commands.py, and and './emit' in events.py.
> 
> (3) None
> 
>      This is the (nameless) system module for built-in stuff.  It
>      predates (2).  Using './builtin' would probably be better now.
> 

Yes please! This would help simplify Optional[str] to str in many 
places, and removes doubt as to what "None" might imply.

Let's queue that idea up as a cleanup for after this typing series.

> Note that (1) and (2) are disjoint: relative pathnames do not begin with
> './'.
> 
> name='' is not possible, because '' is not a valid pathname.
> 
>>                 I miss documentation on `visit_module()`,
>> `visit_include()`, and `_is_user_module()`.  I don't know what
>> `name` means here, and what is a "user module".
> 
> Valid complaints!  The code is subtle in places, without helping its
> readers along with comments or doc strings.
> 
>>
>>>   
>>>       @staticmethod
>>>       def _is_builtin_module(name):
>>> -- 
>>> 2.26.2
>>>

For now, I've done the simpler thing and wrapped the return in 
bool(...), but we will be able to do much more cleanups if we eliminate 
the possibility of "None" module names later. I'll get it all at once.

I'm adding it to my python TODO: https://gitlab.com/jsnow/qemu/-/issues/8

--js


