Return-Path: <SRS0=+pSw=DC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D7EBC4363D
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 16:41:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE545206BE
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 16:41:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LBGOjUHV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE545206BE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59232 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLqmm-0002up-3C
	for qemu-devel@archiver.kernel.org; Fri, 25 Sep 2020 12:41:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50536)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kLqfM-0002vJ-E3
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 12:33:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:27680)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kLqfK-0008Gm-Jr
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 12:33:48 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601051625;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=njVxwsFBl5qqvocgMMqfLHI/WZSPERi0+KklB2rnKQA=;
 b=LBGOjUHVazDsAQzGffw58EfJYvOsp4juvqlwH/IscKyZRVP0W0hMv0tEUBybaofAJzCg5U
 hntz780Zh32kegXQPUDeJ0ECPLZz3sb+ni4MKm16QrsKmyhtT1nMhnVnxfg2PgWU6Z8QUt
 453RNrk9egp5rC3QFYzU7QqC9cHQkC4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-506--1TbFKiIOZONdUwNEv13tw-1; Fri, 25 Sep 2020 12:33:42 -0400
X-MC-Unique: -1TbFKiIOZONdUwNEv13tw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 307A780734F;
 Fri, 25 Sep 2020 16:33:41 +0000 (UTC)
Received: from [10.10.119.140] (ovpn-119-140.rdu2.redhat.com [10.10.119.140])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0E6BE5C1D7;
 Fri, 25 Sep 2020 16:33:37 +0000 (UTC)
Subject: Re: [PATCH v2 28/38] qapi/gen.py: update write() to be more idiomatic
To: Eduardo Habkost <ehabkost@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
References: <20200922210101.4081073-1-jsnow@redhat.com>
 <20200922210101.4081073-29-jsnow@redhat.com>
 <20200923152624.GO3312949@habkost.net>
 <c0b8ed9e-c66a-a6fa-43e1-c3c61581d928@redhat.com>
 <20200924155959.GC191229@localhost.localdomain>
 <87r1qqro8i.fsf@dusky.pond.sub.org> <20200925132607.GP3717385@habkost.net>
From: John Snow <jsnow@redhat.com>
Message-ID: <73455868-86f9-e1a7-52e7-a61a8484a999@redhat.com>
Date: Fri, 25 Sep 2020 12:33:37 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200925132607.GP3717385@habkost.net>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
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
Cc: Michael Roth <mdroth@linux.vnet.ibm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org,
 Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/25/20 9:26 AM, Eduardo Habkost wrote:
> On Fri, Sep 25, 2020 at 03:15:57PM +0200, Markus Armbruster wrote:
>> Cleber Rosa <crosa@redhat.com> writes:
>>
>>> On Wed, Sep 23, 2020 at 02:37:27PM -0400, John Snow wrote:
>>>> On 9/23/20 11:26 AM, Eduardo Habkost wrote:
>>>>> On Tue, Sep 22, 2020 at 05:00:51PM -0400, John Snow wrote:
>>>>>> Make the file handling here just a tiny bit more idiomatic.
>>>>>> (I realize this is heavily subjective.)
>>>>>>
>>>>>> Use exist_ok=True for os.makedirs and remove the exception,
>>>>>> use fdopen() to wrap the file descriptor in a File-like object,
>>>>>> and use a context manager for managing the file pointer.
>>>>>>
>>>>>> Signed-off-by: John Snow <jsnow@redhat.com>
>>>>>
>>>>> Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
>>>>>
>>>>> I really miss a comment below explaining why we use
>>>>> open(os.open(pathname, ...), ...) instead of open(pathname, ...).
>>
>> This code:
>>
>>          fd = os.open(pathname, os.O_RDWR | os.O_CREAT, 0o666)
>>          f = open(fd, 'r+', encoding='utf-8')
>>
>>>> Not known to me. It was introduced in 907b846653 as part of an effort to
>>>> reduce rebuild times. Maybe this avoids a modification time change if the
>>>> file already exists?
>>>>
>>>> Markus?
>>>
>>> AFACIT the change on 907b846653 is effective because of the "is new
>>> text different from old text?" conditional.  I can not see how the
>>> separate/duplicate open/fdopen would contribute to that.
>>>
>>> But, let's hear from Markus.
>>
>> This was my best attempt to open the file read/write, creating it if it
>> doesn't exist.
>>
>> Plain
>>
>>          f = open(pathname, "r+", encoding='utf-8')
>>
>> fails instead of creates, and
>>
>>          f = open(pathname, "w+", encoding='utf-8')
>>
>> truncates.
>>
>> If you know a better way, tell me!
> 
> Thanks for the explanation!
> 
> Yeah, it looks like there's no combination of open() flags that
> would get translated to O_RDWR|O_CREAT.
> 
> Using os.open() like you did seems more straightforward than
> catching FileNotFoundError.
> 

OK. Using fdopen works for us, so let's stick with it. I will add a 
comment explaining our reasoning.

Thanks!

--js


