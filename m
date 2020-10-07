Return-Path: <SRS0=37Ja=DO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACCA2C4363C
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 19:18:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3CE522076B
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 19:18:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ep2C/GpC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CE522076B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57462 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQExE-0005Uo-7i
	for qemu-devel@archiver.kernel.org; Wed, 07 Oct 2020 15:18:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52422)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kQEwA-0004ay-EY
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 15:17:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:53294)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kQEw7-0006Qk-VQ
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 15:17:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602098234;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mum544dG8yZ2KjV6+g4J2EnHu/A69+Eox0a//bwLX1E=;
 b=ep2C/GpCfBnaFBDFOodnJ9/NKQuCgzYplJcvKYMxnm9iteZG3Z95Do03xtDlHsr0PTRULD
 cSwM4xV0Vz2zDUnaXH0bh+dxbR2Xr/22udPO2Ne79sxxnDqzyf+5oiMQb7z/iHLumGyvQI
 +RPwMlsjRlC/KdsqKvrLr6o4HI4adMk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-99-CKLkoO4RPKmy_4qsCjNRpQ-1; Wed, 07 Oct 2020 15:17:13 -0400
X-MC-Unique: CKLkoO4RPKmy_4qsCjNRpQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0AD38186DD32;
 Wed,  7 Oct 2020 19:17:12 +0000 (UTC)
Received: from [10.10.120.38] (ovpn-120-38.rdu2.redhat.com [10.10.120.38])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4D26A100164C;
 Wed,  7 Oct 2020 19:17:11 +0000 (UTC)
Subject: Re: [PATCH 18/20] python/qemu/qmp.py: re-raise OSError when
 encountered
To: Kevin Wolf <kwolf@redhat.com>
References: <20201006235817.3280413-1-jsnow@redhat.com>
 <20201006235817.3280413-19-jsnow@redhat.com>
 <20201007113043.GL7212@linux.fritz.box>
From: John Snow <jsnow@redhat.com>
Message-ID: <c0ab4401-3c13-47ab-8b07-b1046e488a61@redhat.com>
Date: Wed, 7 Oct 2020 15:17:10 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20201007113043.GL7212@linux.fritz.box>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jsnow@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/07 00:54:30
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.742,
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
Cc: qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org,
 Eduardo Habkost <ehabkost@redhat.com>, Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/7/20 7:30 AM, Kevin Wolf wrote:
> Am 07.10.2020 um 01:58 hat John Snow geschrieben:
>> Nested if conditions don't change when the exception block fires; we
>> need to explicitly re-raise the error if we didn't intend to capture and
>> suppress it.
>>
>> Signed-off-by: John Snow <jsnow@redhat.com>
>> ---
>>   python/qemu/qmp.py | 6 +++---
>>   1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/python/qemu/qmp.py b/python/qemu/qmp.py
>> index d911999da1f..bdbd1e9bdbb 100644
>> --- a/python/qemu/qmp.py
>> +++ b/python/qemu/qmp.py
>> @@ -169,9 +169,9 @@ def __get_events(self, wait: Union[bool, float] = False) -> None:
>>           try:
>>               self.__json_read()
>>           except OSError as err:
>> -            if err.errno == errno.EAGAIN:
>> -                # No data available
>> -                pass
>> +            # EAGAIN: No data available; not critical
>> +            if err.errno != errno.EAGAIN:
>> +                raise
> 
> Hm, if we re-raise the exception here, the socket remains non-blocking.
> I think we intended to have it like that only temporarily.
> 

Whoops. Yep, no good to go from one kind of broken to a different kind 
of broken.

> The same kind of exception would raise QMPConnectError below instead of
> directly OSError. Should we try to make this consistent?
> 

Yeah, honestly I'm a bit confused about the error plumbing myself. We 
like to return "None" a lot, and I have been trying to remove that 
whenever possible, because the nature of what None can mean semantically 
is ambiguous.

I need to sit down with this code and learn all of the different ways it 
can actually and genuinely fail, and what each failure actually 
semantically means.

I suspect it would probably be best to always catch socket errors and 
wrap them in QMPConnectError just to be consistent about that.

I also need to revise the docstrings to be clear about what errors get 
raised where, when, and why. I almost included that for this series, but 
decided against it because I need to also adjust the docstring 
formatting and so on -- and pending discussion in the qapi series -- 
felt it would be best to tackle that just a little bit later.

Here's a docstring convention question:

I think that any method that directly raises an exception should always 
mention that with :raise X:. How far up the call chain, however, should 
anticipated exceptions be documented with :raise:?

My gut feeling is that it should stop at the first public call boundary, 
so accept() should repeat any :raise: comments that appear in private 
helpers.

>>           self.__sock.setblocking(True)
>>   
>>           # Wait for new events, if needed.
> 
> Kevin
> 

Thanks for the review! Things seem like they're looking good.

--js


