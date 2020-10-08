Return-Path: <SRS0=Ajie=DP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73A44C433E7
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 23:43:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 601D02224C
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 23:43:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JX4dE5zJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 601D02224C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56066 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQfZK-0004RV-1i
	for qemu-devel@archiver.kernel.org; Thu, 08 Oct 2020 19:43:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56292)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kQfY1-0003qz-S8
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 19:42:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:38421)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kQfXy-0005MQ-3b
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 19:42:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602200523;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2dK82r0PeBGatJo2ZPECK89HMmgWEnOlfYi+A69SJEA=;
 b=JX4dE5zJk0RL7TPvjMiofUtA7Fx/ERqdjiL1gimzk+VES9XjpbBpRvFSi1I9pHxCOWmn74
 TA/pwaC5eC9j57zvTgME2rGM55fqkbd1fnVCVLFokj0I3NhNnhFjwoD4+Qu6vP7B83ZwAA
 2i7ueZR1cm4XT9IaE7qI3VHAWh8fgss=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-214-ZiO-mBy8Mi-OFyMAS4Gllg-1; Thu, 08 Oct 2020 19:42:01 -0400
X-MC-Unique: ZiO-mBy8Mi-OFyMAS4Gllg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id ECE5A1019625;
 Thu,  8 Oct 2020 23:42:00 +0000 (UTC)
Received: from [10.10.112.203] (ovpn-112-203.rdu2.redhat.com [10.10.112.203])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3C3CD1A835;
 Thu,  8 Oct 2020 23:42:00 +0000 (UTC)
Subject: Re: [PATCH 18/20] python/qemu/qmp.py: re-raise OSError when
 encountered
From: John Snow <jsnow@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
References: <20201006235817.3280413-1-jsnow@redhat.com>
 <20201006235817.3280413-19-jsnow@redhat.com>
 <20201007113043.GL7212@linux.fritz.box>
 <c0ab4401-3c13-47ab-8b07-b1046e488a61@redhat.com>
Message-ID: <dd7c4b82-8e29-db84-4f27-dc0ac42c4245@redhat.com>
Date: Thu, 8 Oct 2020 19:41:59 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <c0ab4401-3c13-47ab-8b07-b1046e488a61@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jsnow@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/08 01:56:49
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
Cc: qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org,
 Eduardo Habkost <ehabkost@redhat.com>, Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/7/20 3:17 PM, John Snow wrote:
> On 10/7/20 7:30 AM, Kevin Wolf wrote:
>> Am 07.10.2020 um 01:58 hat John Snow geschrieben:
>>> Nested if conditions don't change when the exception block fires; we
>>> need to explicitly re-raise the error if we didn't intend to capture and
>>> suppress it.
>>>
>>> Signed-off-by: John Snow <jsnow@redhat.com>
>>> ---
>>>   python/qemu/qmp.py | 6 +++---
>>>   1 file changed, 3 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/python/qemu/qmp.py b/python/qemu/qmp.py
>>> index d911999da1f..bdbd1e9bdbb 100644
>>> --- a/python/qemu/qmp.py
>>> +++ b/python/qemu/qmp.py
>>> @@ -169,9 +169,9 @@ def __get_events(self, wait: Union[bool, float] = 
>>> False) -> None:
>>>           try:
>>>               self.__json_read()
>>>           except OSError as err:
>>> -            if err.errno == errno.EAGAIN:
>>> -                # No data available
>>> -                pass
>>> +            # EAGAIN: No data available; not critical
>>> +            if err.errno != errno.EAGAIN:
>>> +                raise
>>
>> Hm, if we re-raise the exception here, the socket remains non-blocking.
>> I think we intended to have it like that only temporarily.
>>
> 
> Whoops. Yep, no good to go from one kind of broken to a different kind 
> of broken.
> 

Actually, wanna know a funny story?

I think the reason this never broke anything is because sockfiles aren't 
suppose to be used in nonblocking mode -- their behavior is not 
documented in this case.

In practice, what actually seems to happen when you set non-blocking 
mode and then call sockfile.readline() is that you get an empty string.

This means you get 'None' from __json_read, and so on.

Why doesn't this bite us more often? Well, we don't actually check the 
return value when we're using this in non-blocking mode, so I suppose 
that's the primary reason.

I don't know if the behavior of Python changed at some point, I can try 
to patch this up for how Python *seems* to work, but we should probably 
do a more meaningful fix to get away from undefined behavior sometime soon.

I had some async prototypes hanging around, maybe it's time to try and 
give that a more solid effort ...



Related note:

Even in blocking mode, you might get an empty reply from readline which 
means EOF and not just "try again."

You'll see this in the case where you already have QEMU running from a 
previous failed test, and you start a new iotest up. When QMP calls 
accept(), the QMP capabilities handshake fails because it gets "None" 
from __json_read.

Confusing error for what's actually going on there. It's actually that 
the socket is at EOF.


