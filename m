Return-Path: <SRS0=1sPN=D3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D480C4363A
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 19:08:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F6AF2224A
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 19:08:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bZnPQVcE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F6AF2224A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51854 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUwzU-00045o-16
	for qemu-devel@archiver.kernel.org; Tue, 20 Oct 2020 15:08:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35156)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kUwyP-0003aQ-Gt
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 15:07:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:56795)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kUwyL-0005l7-EM
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 15:07:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603220820;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ROCWlIJvRB6Bs3cqTpEsL6Ka3QQpKYW9nJlBLfPEWsc=;
 b=bZnPQVcEAUAFy+aK03Gbo3Yb2Pj4ivxFWA4CMK6Tf3f6i5gwIdBSQyMIBH+IhyrIxkh+gT
 ErR153rCKIN1m7y1BSII3v2zcfeyJZ/DwgEXlYne0eem/QcTSopRMYjLgzPondeHxXirFM
 HspteUWRgmYT3XdKiK6s3jnd1ZNEEoA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-164-FK2T3Fs8PuScfhR5NaILKg-1; Tue, 20 Oct 2020 15:06:57 -0400
X-MC-Unique: FK2T3Fs8PuScfhR5NaILKg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 43CE41868434;
 Tue, 20 Oct 2020 19:06:56 +0000 (UTC)
Received: from [10.10.115.172] (ovpn-115-172.rdu2.redhat.com [10.10.115.172])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1A03860C0F;
 Tue, 20 Oct 2020 19:06:46 +0000 (UTC)
Subject: Re: [PULL 20/21] python/qemu/qmp.py: re-raise OSError when encountered
To: Nir Soffer <nsoffer@redhat.com>
References: <20201020172742.1483258-1-jsnow@redhat.com>
 <20201020172742.1483258-21-jsnow@redhat.com>
 <CAMRbyyuiqFK2biX5ADrx0cDJ1V-naiOHJ7TKD1M-rGFnFH6c4g@mail.gmail.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <3a096ef6-36a3-73ac-e0e8-90a3c4473b5d@redhat.com>
Date: Tue, 20 Oct 2020 15:06:45 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <CAMRbyyuiqFK2biX5ADrx0cDJ1V-naiOHJ7TKD1M-rGFnFH6c4g@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jsnow@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/20 01:15:43
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-block <qemu-block@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Max Reitz <mreitz@redhat.com>,
 Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/20/20 2:15 PM, Nir Soffer wrote:
> On Tue, Oct 20, 2020 at 8:52 PM John Snow <jsnow@redhat.com> wrote:
>>
>> Nested if conditions don't change when the exception block fires; we
>> need to explicitly re-raise the error if we didn't intend to capture and
>> suppress it.
>>
>> Signed-off-by: John Snow <jsnow@redhat.com>
>> Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
>> Message-id: 20201009175123.249009-3-jsnow@redhat.com
>> Signed-off-by: John Snow <jsnow@redhat.com>
>> ---
>>   python/qemu/qmp.py | 11 ++++++-----
>>   1 file changed, 6 insertions(+), 5 deletions(-)
>>
>> diff --git a/python/qemu/qmp.py b/python/qemu/qmp.py
>> index d911999da1..4969e5741c 100644
>> --- a/python/qemu/qmp.py
>> +++ b/python/qemu/qmp.py
>> @@ -165,14 +165,15 @@ def __get_events(self, wait: Union[bool, float] = False) -> None:
>>           """
>>
>>           # Check for new events regardless and pull them into the cache:
>> -        self.__sock.setblocking(False)
>>           try:
>> +            self.__sock.setblocking(False)
> 
> This change is not required. The idiom is:
> 
>       do stuff
>       try:
>           something
>       finally:
>           undo stuff
> 
> If do stuff failed, there is no need to undo it.
> 
> socket.setblocking() should not fail with EAGAIN, so it
> does not need to be inside the try block.
> 

Squashing this change in, will send a new V2 cover letter.

>>               self.__json_read()
>>           except OSError as err:
>> -            if err.errno == errno.EAGAIN:
>> -                # No data available
>> -                pass
>> -        self.__sock.setblocking(True)
>> +            # EAGAIN: No data available; not critical
>> +            if err.errno != errno.EAGAIN:
>> +                raise
> 
> In python 3 this can be simplified to:
> 
>     try:
>         self.__json_read()
>     except BlockingIOError:
>         pass
> 
> https://docs.python.org/3.6/library/exceptions.html#BlockingIOError
> 

I'm a lot less clear on this. We only check for EAGAIN, but that would 
check for EAGAIN, EALREADY, EWOULDBLOCK and EINPROGRESS.

That's probably fine, really, but:

There is something worse lurking in the code here too, and I really 
didn't want to get into it on this series, but we are making use of 
undefined behavior (sockfile.readline() on a non-blocking socket) -- It 
seems to work in practice so far, but it's begging to break.

For that reason (This code should never have worked anyway), I am 
extremely reluctant to change the exception classes we catch here until 
we fix the problem.

--js

>> +        finally:
>> +            self.__sock.setblocking(True)
>>
>>           # Wait for new events, if needed.
>>           # if wait is 0.0, this means "no wait" and is also implicitly false.
>> --
>> 2.26.2
> 
> Nir
> 


