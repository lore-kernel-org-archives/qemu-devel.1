Return-Path: <SRS0=192v=3S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F277AC2D0DB
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 20:08:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BDE6A206F0
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 20:08:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BOgtSrCy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDE6A206F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50754 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwtd1-0002If-WE
	for qemu-devel@archiver.kernel.org; Wed, 29 Jan 2020 15:08:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34857)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <wainersm@redhat.com>) id 1iwtcT-0001tD-Nq
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 15:07:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <wainersm@redhat.com>) id 1iwtcR-0006fF-CP
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 15:07:24 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:56279
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <wainersm@redhat.com>) id 1iwtcR-0006cX-7V
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 15:07:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580328442;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0P2o0/phqblrjEdbXPs8WmUrGIzVAbFM+ZED37HU6u4=;
 b=BOgtSrCy5WX6eKerbFlGpIvPiryihqpvqwHMgXRObeOxW9/wXNQ7XEt0yaziNDunmmipvc
 B9aDeQdc77Jm8PibmK1SrUpO/sjMZNd4Zj7uduJ7I7E/GFwHD/CVYbmFYxT32IfO+WFmWT
 B2S91ut7nFLUPfL1t14zpsx5mAiC4TI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-185-59uGBL_AOb2aItqlCqQwUg-1; Wed, 29 Jan 2020 15:07:20 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 384A5107ACC7
 for <qemu-devel@nongnu.org>; Wed, 29 Jan 2020 20:07:19 +0000 (UTC)
Received: from localhost.localdomain (ovpn-116-51.gru2.redhat.com
 [10.97.116.51])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 764785DA7B;
 Wed, 29 Jan 2020 20:07:15 +0000 (UTC)
Subject: Re: [PATCH 4/5] python/qemu: qmp: Make QEMUMonitorProtocol a context
 manager
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
References: <20191227134101.244496-1-wainersm@redhat.com>
 <20191227134101.244496-5-wainersm@redhat.com>
 <b32d57ea-de80-bbe2-b771-ae736ef485b1@redhat.com>
From: Wainer dos Santos Moschetta <wainersm@redhat.com>
Message-ID: <7ff9fed1-45af-80d7-3214-1d3df86882c4@redhat.com>
Date: Wed, 29 Jan 2020 18:07:14 -0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <b32d57ea-de80-bbe2-b771-ae736ef485b1@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: 59uGBL_AOb2aItqlCqQwUg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: ehabkost@redhat.com, crosa@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 1/8/20 10:23 PM, John Snow wrote:
>
> On 12/27/19 8:41 AM, Wainer dos Santos Moschetta wrote:
>> This implement the __enter__ and __exit__ functions on
>> QEMUMonitorProtocol class so that it can be used on 'with'
>> statement and the resources will be free up on block end:
>>
>> with QEMUMonitorProtocol(socket_path) as qmp:
>>      qmp.connect()
>>      qmp.command('query-status')
>>
>> Signed-off-by: Wainer dos Santos Moschetta <wainersm@redhat.com>
>> ---
>>   python/qemu/qmp.py | 15 +++++++++++++--
>>   1 file changed, 13 insertions(+), 2 deletions(-)
>>
>> diff --git a/python/qemu/qmp.py b/python/qemu/qmp.py
>> index 914b8c6774..6d55f53595 100644
>> --- a/python/qemu/qmp.py
>> +++ b/python/qemu/qmp.py
>> @@ -139,6 +139,15 @@ class QEMUMonitorProtocol:
>>                   raise QMPConnectError("Error while reading from socket")
>>               self.__sock.settimeout(None)
>>   
>> +    def __enter__(self):
>> +        # Implement context manager enter function.
>> +        return self
>> +
>> +    def __exit__(self, exc_type, exc_value, exc_traceback):
>> +        # Implement context manager exit function.
>> +        self.close()
>> +        return False
>> +
>>       def connect(self, negotiate=True):
>>           """
>>           Connect to the QMP Monitor and perform capabilities negotiation.
>> @@ -259,8 +268,10 @@ class QEMUMonitorProtocol:
>>           """
>>           Close the socket and socket file.
>>           """
>> -        self.__sock.close()
>> -        self.__sockfile.close()
>> +        if self.__sock:
>> +            self.__sock.close()
>> +        if self.__sockfile:
>> +            self.__sockfile.close()
> Not evident on cold read: does self.close() change self.__sock and
> self.__sockfile such that they are false-ish?


Because self.__exit__() calls self.close() even when a runtime exception 
raises, there isn't any guarantee that self.__sockfile and self.__sock 
were initialized. That's the reason why I added those guards.


>
> close() I suspect might need to actually unset the __sock and __sockfile
> fields.

The QEMUMonitorProtocol object is designed to be disposed after close() 
being called. So I don't see any reason to unset those fields. Unless I 
am missing something here...

Thanks for the comments!

- Wainer

>
>>   
>>       def settimeout(self, timeout):
>>           """
>>


