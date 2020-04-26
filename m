Return-Path: <SRS0=j/lF=6K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D94BC55185
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Apr 2020 02:07:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 65E6D2071E
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Apr 2020 02:07:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="UUE6u3iw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65E6D2071E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=163.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50466 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jSWhw-00015o-Jv
	for qemu-devel@archiver.kernel.org; Sat, 25 Apr 2020 22:07:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57090)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <zxq_yx_007@163.com>) id 1jSWhA-0000WX-5Y
 for qemu-devel@nongnu.org; Sat, 25 Apr 2020 22:07:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <zxq_yx_007@163.com>) id 1jSWh7-0003E7-7h
 for qemu-devel@nongnu.org; Sat, 25 Apr 2020 22:06:58 -0400
Received: from m12-14.163.com ([220.181.12.14]:53363)
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <zxq_yx_007@163.com>)
 id 1jSWh5-0002pp-FJ
 for qemu-devel@nongnu.org; Sat, 25 Apr 2020 22:06:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=Subject:From:Message-ID:Date:MIME-Version; bh=9+HjG
 9s5C1njWgOEeVRsZvdUZqRBBgHzhULSthw4fFM=; b=UUE6u3iwHxWppmxkt+0cK
 33oZff9fJiyX5GUcmZa2Fx95AFGTTloKQO86qyO+prz9lndux5QvukcbJOkggAOR
 IKjsMKw7dpR5h0QqnRSecb9mCB9BDd/eqrjcWGxaAPxocATz8z5rDtF6uw5XVLTF
 dzf1o0lS9gHc70WF7mX7vc=
Received: from [10.11.32.40] (unknown [39.155.168.46])
 by smtp10 (Coremail) with SMTP id DsCowAAnMFSw7KRecl_7Bw--.15142S2;
 Sun, 26 Apr 2020 10:06:40 +0800 (CST)
Subject: Re: [PATCH v2] qemu-sockets: add abstract UNIX domain socket support
From: "xiaoqiang.zhao" <zxq_yx_007@163.com>
To: eblake@redhat.com, armbru@redhat.com
References: <20200423035640.29202-1-zxq_yx_007@163.com>
 <20200423090006.GA1077680@redhat.com>
 <b3f0ebc4-08f5-22e2-ead8-e8651d4b5798@163.com>
Message-ID: <9459558f-8c90-9bcb-2775-bd87f3f9c2d9@163.com>
Date: Sun, 26 Apr 2020 10:06:39 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <b3f0ebc4-08f5-22e2-ead8-e8651d4b5798@163.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: DsCowAAnMFSw7KRecl_7Bw--.15142S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxGFy8Cr1rGr17Kw4xAFWkJFb_yoWrCry7pa
 y5Ka1DK397Jr409rsY9w45JrWSyr4rJ3yUCwn8J3sYkws0gF1I9F12q3WY9ry7JrW5G347
 trWYkrW7Z3Z8Ar7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jl6wZUUUUU=
X-Originating-IP: [39.155.168.46]
X-CM-SenderInfo: 520ts5t0bqili6rwjhhfrp/1tbiqBASxlc7OwboLwAAs6
Received-SPF: pass client-ip=220.181.12.14; envelope-from=zxq_yx_007@163.com;
 helo=m12-14.163.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/25 22:06:41
X-ACL-Warn: Detected OS   = Linux 3.1-3.10 [fuzzy]
X-Received-From: 220.181.12.14
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
Cc: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org, kraxel@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Eric , Markus, any comments ?

在 2020/4/23 下午6:51, xiaoqiang.zhao 写道:
> 在 2020/4/23 下午5:00, Daniel P. Berrangé 写道:
>> Adding Eric & Markus for QAPI modelling questions
>>
>> On Thu, Apr 23, 2020 at 11:56:40AM +0800, xiaoqiang zhao wrote:
>>> unix_connect_saddr now support abstract address type
>>>
>>> By default qemu does not support abstract UNIX domain
>>> socket address. Add this ability to make qemu handy
>>> when abstract address is needed.
>> Was that a specific app you're using with QEMU that needs this ?
>
> Thanks for your reply !
>
> I once use qemu to connect a unix domain socket server (with abstract 
> type address written by android java code)
>
>>> Abstract address is marked by prefixing the address name with a '@'.
>> For full support of the abstract namespace we would ned to allow
>> the "sun_path" to contain an arbitrary mix of NULs and non-NULs
>> characters, and allow connect() @addrlen to be an arbitrary size.
>>
>> This patch only allows a single initial NUL, and reqiures @addrlen
>> to be the full size of sun_path, padding with trailing NULs. This
>> limitation is impossible to lift with QEMU's current approach to
>> UNIX sockets, as it relies on passing around a NULL terminated
>> string, so there's no way to have embedded NULs. Since there's
>> no explicit length, we have to chooose between forcing the full
>> sun_path size as @addrlen, or forcing the string length as the
>> @addrlen value.
>>
>> IIUC, socat makes the latter decision by default, but has a
>> flag to switch to the former.
>>
>>    [man socat]
>>    unix-tightsocklen=[0|1]
>>    On  socket  operations,  pass  a  socket  address  length that 
>> does not
>>    include the whole struct sockaddr_un record but (besides other  
>> compo‐
>>    nents)  only  the  relevant  part  of  the filename or abstract 
>> string.
>>    Default is 1.
>>    [/man]
>>
>> This actually is supported for both abstract and non-abstract
>> sockets, though IIUC this doesn't make a semantic difference
>> for non-abstract sockets.
>>
>> The point is we have four possible combinations
>>
>>   NON-ABSTRACT + FULL SIZE
>>   NON-ABSTRACT + MINIMAL SIZE  (default)
>>   ABSTRACT + FULL SIZE
>>   ABSTRACT + MINIMAL SIZE  (default)
>>
>> With your patch doing the latter, it means QEMU supports
>> only two combinations
>>
>>    NON+ABSTRACT + FULL SIZE
>>    ABSTRACT + MINIMAL SIZE
>>
>> and also can't use "@somerealpath" for a non-abstract
>> socket, though admittedly this is unlikely.
>>
>> Socat uses a special option to request use of abstract
>> sockets. eg ABSTRACT:somepath, and automatically adds
>> the leading NUL, so there's no need for a special "@"
>> character. This means that UNIX:@somepath still resolves
>> to a filesystem path and not a abstract socket path.
>>
>> Finally, the patch as only added support for connect()
>> not listen(). I think if QEMU wants to support abstract
>> sockets we must do both, and also have unit tests added
>> to tests/test-util-sockets.c
> Yes , I missed these parts.
>>
>>
>> The question is whether we're ok with this simple
>> approach in QEMU, or should do a full approach with
>> more explicit modelling.
> Agree,  more comments is welcome.
>>
>> ie should we change QAPI thus:
>>
>> { 'struct': 'UnixSocketAddress',
>>    'data': {
>>      'path': 'str',
>>      'tight': 'bool',
>>      'abstract': 'bool' } }
>>
>> where 'tight' is a flag indicating whether to set @addrlen
>> to the minimal string length, or the maximum sun_path length.
>> And 'abstract' indicates that we automagically add a leading
>> NUL.
>>
>> This would *not* allow for NULs in the middle of path,
>> but I'm not so bothered about that, since I can't see that
>> being widely used. If we really did need that it could be
>> added via a 'base64': 'bool' flag, to indicate that @path
>> is base64 encoded and thus may contain NULs
>>
>>  From a CLI POV, this could be mapped to QAPI thus
>>
>>   *  -chardev unix:somepath
>>
>>        @path==somepath
>>        @tight==false
>>        @abstract==false
>>
>>   *  -chardev unix:somepath,tight
>>
>>        @path==somepath
>>        @tight==true
>>        @abstract==false
>>
>>   *  -chardev unix-abstract:somepath
>>
>>        @path==somepath
>>        @tight==false
>>        @abstract==true
>>
>>   *  -chardev unix-abstract:somepath,tight
>>
>>        @path==somepath
>>        @tight==true
>>        @abstract==true
>>
>>
>>
>> Regards,
>> Daniel


