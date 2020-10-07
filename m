Return-Path: <SRS0=37Ja=DO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CB71C4363C
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 18:46:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C75342173E
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 18:46:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SQXwHzlq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C75342173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56768 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQESO-0005Tp-EV
	for qemu-devel@archiver.kernel.org; Wed, 07 Oct 2020 14:46:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45774)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kQER5-0004ar-Lz
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 14:45:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:49137)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kQER1-0001vm-NY
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 14:45:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602096304;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=O50JvdE6O3m7niQGqOmjacB96FiibHC6wH/Rs+YRiRA=;
 b=SQXwHzlq3eZDP5l7NzF3p7/nvKb9wl5J321DVzmn6J734j7yvZVw5CPTTlmk2XhkNvy0z0
 eUTH7jGtakKSthkHYcxoTqmIgj9hPCvNbrOQt+iIO/tCoxELqN+qBA/Sy+D7H8xmS23bNV
 H5MsSxtqCPckLNynEMOx1yv/oGAf8y8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-556-Q6t_9CebOMOo6n5MIM8ggw-1; Wed, 07 Oct 2020 14:45:02 -0400
X-MC-Unique: Q6t_9CebOMOo6n5MIM8ggw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 41CB1804013;
 Wed,  7 Oct 2020 18:45:01 +0000 (UTC)
Received: from [10.10.120.38] (ovpn-120-38.rdu2.redhat.com [10.10.120.38])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4054A757DF;
 Wed,  7 Oct 2020 18:44:57 +0000 (UTC)
Subject: Re: [PATCH 08/20] python/machine.py: fix _popen access
To: Kevin Wolf <kwolf@redhat.com>
References: <20201006235817.3280413-1-jsnow@redhat.com>
 <20201006235817.3280413-9-jsnow@redhat.com>
 <20201007100705.GD7212@linux.fritz.box>
From: John Snow <jsnow@redhat.com>
Message-ID: <1c562773-6216-7cbe-eddf-fa18cdcc84f3@redhat.com>
Date: Wed, 7 Oct 2020 14:44:56 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20201007100705.GD7212@linux.fritz.box>
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
Cc: qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org,
 Eduardo Habkost <ehabkost@redhat.com>, Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/7/20 6:07 AM, Kevin Wolf wrote:
> Am 07.10.2020 um 01:58 hat John Snow geschrieben:
>> As always, Optional[T] causes problems with unchecked access. Add a
>> helper that asserts the pipe is present before we attempt to talk with
>> it.
>>
>> Signed-off-by: John Snow <jsnow@redhat.com>
> 
> First a question about the preexisting state: I see that after
> initialising self._popen once, we never reset it to None. Should we do
> so on shutdown?
> 

Yup, we should.

>>   python/qemu/machine.py | 16 +++++++++++-----
>>   1 file changed, 11 insertions(+), 5 deletions(-)
>>
>> diff --git a/python/qemu/machine.py b/python/qemu/machine.py
>> index 3e9cf09fd2d..4e762fcd529 100644
>> --- a/python/qemu/machine.py
>> +++ b/python/qemu/machine.py
>> @@ -131,7 +131,7 @@ def __init__(self, binary, args=None, wrapper=None, name=None,
>>           # Runstate
>>           self._qemu_log_path = None
>>           self._qemu_log_file = None
>> -        self._popen = None
>> +        self._popen: Optional['subprocess.Popen[bytes]'] = None
> 
> Another option that we have, especially if it's an attribute that is
> never reset, would be to set the attribute only when it first gets a
> value other than None. Accessing it while it hasn't been set yet
> automatically results in an AttributeError. I don't think that's much
> worse than the exception raised explicitly in a property wrapper.
> 
> In this case, you would only declare the type in __init__, but not
> assign a value to it:
> 
>      self._popen: Optional['subprocess.Popen[bytes]']
> 

If you do this, you can just declare it as non-Optional. Whenever it 
exists, it is definitely a subprocess.Popen[bytes].

> Maybe a nicer alternative in some cases than adding properties around
> everything.
> 
> Instead of checking for None, you would then have to use hasattr(),
> which is a bit uglier, so I guess it's mainly for attributes where you
> can assume that you will always have a value (if the caller isn't buggy)
> and therefore don't even have a check in most places.
> 

As long as the style checkers are OK with that sort of thing. After a 
very quick test, it seems like they might be.

Generally, we run into trouble because pylint et al want variables to be 
declared in __init__, but doing so requires Optional[T] most of the time 
to allow something to be initialized later.

A lot of our stateful objects have this kind of pattern. QAPIGen has a 
ton of it. machine.py has a ton of it too.

You can basically imply the stateful check by just foregoing the actual 
initialization, which trades the explicit check for the implicit one 
when you get the AttributeError.

This is maybe more convenient -- less code to write, certainly. The 
error message you get I think is going to be a little worse, though.

I think I have been leaning towards the cute little @property shims 
because it follows a familiar OO model where a specific class always has 
a finite set of properties that does not grow or shrink. You can also 
use the shim to give a meaningful error that might be nicer to read than 
the AttributeError.

I'm open to suggestions on better patterns. I had considered at one 
point that it might be nice to split Machine out into a version with and 
without the console to make stronger typing guarantees. It has 
implications for how shutdown and cleanup and so on is handled, too.

(I had some WIP patches to do this, but I think I got a little stuck 
making the code pretty, and then the release, and then I got busy, and...)

>>           self._events = []
>>           self._iolog = None
>>           self._qmp_set = True   # Enable QMP monitor by default.
>> @@ -244,6 +244,12 @@ def is_running(self):
>>           """Returns true if the VM is running."""
>>           return self._popen is not None and self._popen.poll() is None
>>   
>> +    @property
>> +    def _subp(self) -> 'subprocess.Popen[bytes]':
>> +        if self._popen is None:
>> +            raise QEMUMachineError('Subprocess pipe not present')
>> +        return self._popen
>> +
>>       def exitcode(self):
>>           """Returns the exit code if possible, or None."""
>>           if self._popen is None:
> 
> Of course, even if an alternative is possible, what you have is still
> correct.
> 
> Reviewed-by: Kevin Wolf <kwolf@redhat.com>
> 

Thanks; I'll continue with this for now, but I really am open to talking 
about better ways to model the common pattern of "Optional sub-feature 
for a class that can be engaged post-initialization".

It's an interesting typing problem. If we were using semantic types, 
what we are describing is an f(x) such that:

f(object-without-feature) -> object-with-feature

It's a kind of semantic cast where we are doing something akin to an 
in-place transformation of a base type to a subtype. I'm not sure I have 
encountered any language that actually intentionally supports such a 
paradigm.

(Maybe haskell? I just assume haskell can do everything if you learn to 
lie to computers well enough.)

--js


