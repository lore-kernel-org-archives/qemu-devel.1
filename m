Return-Path: <SRS0=hbhd=3T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4D5FC2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 22:36:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 756CE20708
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 22:36:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Dy+kgqXp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 756CE20708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40410 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixIQa-0006SG-Kc
	for qemu-devel@archiver.kernel.org; Thu, 30 Jan 2020 17:36:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51646)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1ixIPq-000612-I7
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 17:36:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1ixIPp-00034Q-Go
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 17:36:02 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:56722
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1ixIPp-00032E-CU
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 17:36:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580423760;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tcwc4R2ejW1/skE/D5qkDWDhUcsHytZJs8qPdBjqIMk=;
 b=Dy+kgqXpNV9D+EPIycooJlvTnxtAWAVNT5Szx1+GeVhtCeeAxBfzfa1zhc8uTkbHLAAtsm
 Akh86aUMFRedyABdhEskKLevnyA8Ad3sEcPn0FF3U1OV9nIfWaIO+XVoQ5Aq4uDY/bdbzA
 kEqHUeNQeiKjpVVEjazZ+dxUYIjB37M=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-153-zOIH5TmYP0W11na1QpzxKQ-1; Thu, 30 Jan 2020 17:35:54 -0500
Received: by mail-wr1-f72.google.com with SMTP id s13so2360318wru.7
 for <qemu-devel@nongnu.org>; Thu, 30 Jan 2020 14:35:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=tcwc4R2ejW1/skE/D5qkDWDhUcsHytZJs8qPdBjqIMk=;
 b=MEzeZZkRENGgGXJXubW8NAer39IodVFK3xIeW1f4GpUyD2Iqm8Slvynkd+SV4Yj3aB
 hzRqtwu8b/xPmxVq9pCqPgEdVLT/7NMJa+g55GLhhE6kRQWFrHGMZirx4NVwtGmSFEqd
 KrIyBlZ0J62L/xD9QSbcnX8Xd66uU9/aBujiZXYOkO0Me2uKYSt0c43fVUOZ1lvHqq7u
 XRFrjpOCZBtB9DdC0xLnU1ITIciA2BDOHAhRUUmN+pcPoFMZ7S48pwdrbkV/pATcbFVi
 zb8vDbUvK/3/+vK00wqmBVykQzonjZs+aPZ96TC2glv1WZW5ztCJFNizATkUS/bFsY06
 +mFw==
X-Gm-Message-State: APjAAAUCijWr9ptQGr5h87Fn8DV1K8U0DmequCNx2u0oYBdDUt3l06F1
 m919hVDrfhqDWfhp83EasLuRVFf9Ir/ZoT+7V97/R0V2raaxkTJaE1MJqV1oDf7jTgrMmIOhzFY
 yKFe6jfAIIIJTckI=
X-Received: by 2002:a05:600c:22d3:: with SMTP id
 19mr7800431wmg.20.1580423753161; 
 Thu, 30 Jan 2020 14:35:53 -0800 (PST)
X-Google-Smtp-Source: APXvYqwrKXue/QbZtv69FV+vWHbJysRXIX2vdDiuEUTOnRNk+olSrdPGh86M1iBKQfOe0FhHte+cVw==
X-Received: by 2002:a05:600c:22d3:: with SMTP id
 19mr7800417wmg.20.1580423752965; 
 Thu, 30 Jan 2020 14:35:52 -0800 (PST)
Received: from [192.168.1.35] (113.red-83-57-172.dynamicip.rima-tde.net.
 [83.57.172.113])
 by smtp.gmail.com with ESMTPSA id f127sm8128865wma.4.2020.01.30.14.35.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Jan 2020 14:35:52 -0800 (PST)
Subject: Re: [PATCH 3/5] python/qemu: qmp: Make accept()'s timeout configurable
To: John Snow <jsnow@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>, qemu-devel@nongnu.org
References: <20191227134101.244496-1-wainersm@redhat.com>
 <20191227134101.244496-4-wainersm@redhat.com>
 <303e47ef-22be-89b4-c9fe-eebc9e568a1f@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <bb8e63aa-2543-5a5e-ad06-d5087a666175@redhat.com>
Date: Thu, 30 Jan 2020 23:35:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <303e47ef-22be-89b4-c9fe-eebc9e568a1f@redhat.com>
Content-Language: en-US
X-MC-Unique: zOIH5TmYP0W11na1QpzxKQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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

On 1/9/20 1:18 AM, John Snow wrote:
> On 12/27/19 8:40 AM, Wainer dos Santos Moschetta wrote:
>> Currently the timeout of QEMUMonitorProtocol.accept() is
>> hard-coded to 15 seconds. This added the parameter `timeout`
>> so the value can be configured by the user.
>>
>> Signed-off-by: Wainer dos Santos Moschetta <wainersm@redhat.com>
>> ---
>>   python/qemu/qmp.py | 5 +++--
>>   1 file changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/python/qemu/qmp.py b/python/qemu/qmp.py
>> index f4e04a6683..914b8c6774 100644
>> --- a/python/qemu/qmp.py
>> +++ b/python/qemu/qmp.py
>> @@ -154,16 +154,17 @@ class QEMUMonitorProtocol:
>>               return self.__negotiate_capabilities()
>>           return None
>>   
>> -    def accept(self):
>> +    def accept(self, timeout=15):

Since it is a float, it is clearer to use 15.0 as default IMHO.

>>           """
>>           Await connection from QMP Monitor and perform capabilities negotiation.
>>   
>> +        @param timeout (float): timeout in seconds. Default is 15.
> 
> What happens if I pass -1 or 0? Please document the valid range for this
> parameter.
> 
>>           @return QMP greeting dict
>>           @raise OSError on socket connection errors
>>           @raise QMPConnectError if the greeting is not received
>>           @raise QMPCapabilitiesError if fails to negotiate capabilities
>>           """
>> -        self.__sock.settimeout(15)
>> +        self.__sock.settimeout(timeout)
>>           self.__sock, _ = self.__sock.accept()
>>           self.__sockfile = self.__sock.makefile()
>>           return self.__negotiate_capabilities()
>>
> 
> 


