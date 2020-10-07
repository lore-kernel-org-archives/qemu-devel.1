Return-Path: <SRS0=37Ja=DO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9E98C47095
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 16:30:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0FA322064E
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 16:30:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MvxOoLSY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FA322064E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57928 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQCKd-0001MQ-T4
	for qemu-devel@archiver.kernel.org; Wed, 07 Oct 2020 12:30:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36278)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kQC0Y-0003tP-36
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 12:09:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:30760)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kQC0V-00039a-DN
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 12:09:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602086973;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=katADo/Y/OL0goxHUzK5+bflziYjOe1d9usGMhtxLWk=;
 b=MvxOoLSYV5Il01/AAs2483gSBgK5vhu38ZF0w0fbmULl0oh3mU6b7cdIKZFWaWEc8CHsOg
 1gtDeODhbcguxSLNrpAVn7BqU4aunHD8fyko+NuatErpQigig6XjpNU4sSRZeX9C2w3ePy
 6Yb4dyQ9bBP76urG9qU/o9ynOC0eA4Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-584-qpbw-xOsP3eWq7jVoewbSw-1; Wed, 07 Oct 2020 12:09:30 -0400
X-MC-Unique: qpbw-xOsP3eWq7jVoewbSw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 03FF718A822E
 for <qemu-devel@nongnu.org>; Wed,  7 Oct 2020 16:09:30 +0000 (UTC)
Received: from [10.10.120.38] (ovpn-120-38.rdu2.redhat.com [10.10.120.38])
 by smtp.corp.redhat.com (Postfix) with ESMTP id ED9B97664C;
 Wed,  7 Oct 2020 16:09:28 +0000 (UTC)
Subject: Re: [PATCH v5 26/36] qapi/gen.py: Fix edge-case of _is_user_module
To: Markus Armbruster <armbru@redhat.com>
References: <20201005195158.2348217-1-jsnow@redhat.com>
 <20201005195158.2348217-27-jsnow@redhat.com>
 <87eemackge.fsf@dusky.pond.sub.org>
From: John Snow <jsnow@redhat.com>
Message-ID: <7b2f0d13-ecbf-7e4a-4a68-bb31e833db41@redhat.com>
Date: Wed, 7 Oct 2020 12:09:28 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <87eemackge.fsf@dusky.pond.sub.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jsnow@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/07 00:44:56
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.742,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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
Cc: qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>,
 Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/7/20 8:02 AM, Markus Armbruster wrote:
> John Snow <jsnow@redhat.com> writes:
> 
>> The edge case is that if the name is '', this expression returns a
>> string instead of a bool, which violates our declared type.
> 
> The edge case is impossible, as discussed in review of v2.  I figure the
> type checker can't see that, so we need to help it some.  Can we mention
> this in the commit message?
> 

Sure. It's quite possible we will be able to better model and constrain 
these types, but that will come after all of these patches.

Mypy just has no way of knowing that '' is forbidden. That constraint 
does not exist in the type system we have here at present.

You could, by the way, create a type called NonEmptyString and create a 
function that casts from str to NonEmptyString by means of an assertion 
and then annotating the return type.

Anyway, I'll update the commit message for now.

>>
>> Signed-off-by: John Snow <jsnow@redhat.com>
>> Reviewed-by: Cleber Rosa <crosa@redhat.com>
>> Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
>> ---
>>   scripts/qapi/gen.py | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/scripts/qapi/gen.py b/scripts/qapi/gen.py
>> index f2e2746fea5..1bad37fc06b 100644
>> --- a/scripts/qapi/gen.py
>> +++ b/scripts/qapi/gen.py
>> @@ -243,7 +243,7 @@ def __init__(self, prefix, what, user_blurb, builtin_blurb, pydoc):
>>   
>>       @staticmethod
>>       def _is_user_module(name):
>> -        return name and not name.startswith('./')
>> +        return bool(name and not name.startswith('./'))
> 
>             return not (name is None or name.startswith('./')
> 
> Looks slightly clearer to me.
>>   
>>       @staticmethod
>>       def _is_builtin_module(name):


