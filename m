Return-Path: <SRS0=7Gz3=WW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 462BAC3A59E
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Aug 2019 04:30:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0EA7A2173E
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Aug 2019 04:30:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ozlabs-ru.20150623.gappssmtp.com header.i=@ozlabs-ru.20150623.gappssmtp.com header.b="LS4k+Bog"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0EA7A2173E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ozlabs.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49688 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i26du-0000LH-5b
	for qemu-devel@archiver.kernel.org; Mon, 26 Aug 2019 00:30:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46691)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aik@ozlabs.ru>) id 1i26cu-0008Ht-0L
 for qemu-devel@nongnu.org; Mon, 26 Aug 2019 00:29:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aik@ozlabs.ru>) id 1i26cr-0006W2-L4
 for qemu-devel@nongnu.org; Mon, 26 Aug 2019 00:29:07 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:44438)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aik@ozlabs.ru>) id 1i26cr-0006Oc-4u
 for qemu-devel@nongnu.org; Mon, 26 Aug 2019 00:29:05 -0400
Received: by mail-pl1-x642.google.com with SMTP id t14so9337135plr.11
 for <qemu-devel@nongnu.org>; Sun, 25 Aug 2019 21:29:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ozlabs-ru.20150623.gappssmtp.com; s=20150623;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=BHJD8wSaAs01OL8fIeYxXOflqrAu7rSXPaOXrjgd1dA=;
 b=LS4k+BogYokbWNcgrOTCJYTX1fO94WRxeZHNh/82pmWgPAhPl/NY58SrbW87gezRD7
 bWFVkJNC3Y8GXkUo2/soquDYp8TGS7QijE2b4dWPEnZu4FRiS1w9ZqWuSnT8gBujgRK/
 bf2zGlY4+mZMbg2dLwWeo8nTDzYyfZlKfisgc00KHsJxqYzYKbw4A6VU0WvUPuVTyrOL
 VptubqZXowS5lzpIv/AZZagv4K1bnI4StQJ6ICBIsOxIOzdW75G89yOrgddNx531b+WS
 rrtdC9qegGdFKL7aQQuJjNjVVxY3A4oJxGql7cc82sIWn9/I3mMlzIgAdZ7NweA60jLL
 Q/Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=BHJD8wSaAs01OL8fIeYxXOflqrAu7rSXPaOXrjgd1dA=;
 b=PPb6Er3ci0P5ZcdAp60SmOK36sp9Wqw1LrMxJqKzsVSXDVezE9hti3mQ4ja574m4xk
 A++kjl2xYudaoOE2r6uehYbJY0pEWGr8SKT1FNhqLLgfOjG5NnTTS8i3byn/kuIlFgLr
 SSCMf9eOctN9h5vIJoq/KiXJMMkgD4YZahaf7/Ly/ItjViUkKE08K6i0fOzvCmqKcghN
 MzRimuSrZQr7QHJB1fi8TEgwv5WVMfbnIuj0jjKIU7sZ1Bq04i51IE4zzEwzeEAbZlHq
 SVD7KOoxDFzmHM0/KUvq9ZHb9FVK91Aqjgbt0Im23HDOrJDSrQBmF5KsLy0yhK6tBMmH
 0Udw==
X-Gm-Message-State: APjAAAXZxabo8ZGWsFBW8HzD3bJMKOGBrE5w9nADBNenQUOusjb/Jiow
 ysUq65gwmA7hSshssKAgj4xQRA7VMsY=
X-Google-Smtp-Source: APXvYqxyUn9a2dLvFVUrf5Ofbtq+/8D9aw+/sjXcJw+c4CSWxOsRlkQ4RcaivEt9BKLxp+oHFG3e7g==
X-Received: by 2002:a17:902:bd88:: with SMTP id
 q8mr499112pls.290.1566793742762; 
 Sun, 25 Aug 2019 21:29:02 -0700 (PDT)
Received: from [10.61.2.175] ([122.99.82.10])
 by smtp.gmail.com with ESMTPSA id p8sm19135581pfq.129.2019.08.25.21.29.00
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 25 Aug 2019 21:29:02 -0700 (PDT)
To: Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
References: <20190822011620.106337-1-aik@ozlabs.ru>
 <87wof5b7ze.fsf@dusky.pond.sub.org> <20190822144940.GV3267@redhat.com>
 <87blwg77o4.fsf@dusky.pond.sub.org> <20190823092347.GA9654@redhat.com>
 <874l285csz.fsf@dusky.pond.sub.org>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <46c1b646-3833-121e-c322-f26487e92568@ozlabs.ru>
Date: Mon, 26 Aug 2019 14:28:59 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <874l285csz.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::642
Subject: Re: [Qemu-devel] [RFC PATCH qemu] qapi: Add query-memory-checksum
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 23/08/2019 21:41, Markus Armbruster wrote:
> Daniel P. Berrangé <berrange@redhat.com> writes:
> 
>> On Fri, Aug 23, 2019 at 07:49:31AM +0200, Markus Armbruster wrote:
>>> Daniel P. Berrangé <berrange@redhat.com> writes:
>>>
>>>> On Thu, Aug 22, 2019 at 04:16:53PM +0200, Markus Armbruster wrote:
>>>>> Alexey Kardashevskiy <aik@ozlabs.ru> writes:
>>>>>
>>>>>> This returns MD5 checksum of all RAM blocks for migration debugging
>>>>>> as this is way faster than saving the entire RAM to a file and checking
>>>>>> that.
>>>>>>
>>>>>> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
>>>>>
>>>>> Any particular reason for MD5?  Have you measured the other choices
>>>>> offered by GLib?
>>>>>
>>>>> I understand you don't need crypto-strength here.  Both MD5 and SHA-1
>>>>> would be bad choices then.
>>>>
>>>> We have a tests/bench-crypto-hash test but its hardcoded for sha256.
>>>> I hacked it to report all algorithms and got these results for varying
>>>> input chunk sizes:
>>>>
>>>> /crypto/hash/md5/speed-512: 519.12 MB/sec OK
>>>> /crypto/hash/md5/speed-1024: 560.39 MB/sec OK
>>>> /crypto/hash/md5/speed-4096: 591.39 MB/sec OK
>>>> /crypto/hash/md5/speed-16384: 576.46 MB/sec OK
>>>> /crypto/hash/sha1/speed-512: 443.12 MB/sec OK
>>>> /crypto/hash/sha1/speed-1024: 518.82 MB/sec OK
>>>> /crypto/hash/sha1/speed-4096: 555.60 MB/sec OK
>>>> /crypto/hash/sha1/speed-16384: 568.16 MB/sec OK
>>>> /crypto/hash/sha224/speed-512: 221.90 MB/sec OK
>>>> /crypto/hash/sha224/speed-1024: 239.79 MB/sec OK
>>>> /crypto/hash/sha224/speed-4096: 269.37 MB/sec OK
>>>> /crypto/hash/sha224/speed-16384: 274.87 MB/sec OK
>>>> /crypto/hash/sha256/speed-512: 222.75 MB/sec OK
>>>> /crypto/hash/sha256/speed-1024: 253.25 MB/sec OK
>>>> /crypto/hash/sha256/speed-4096: 272.80 MB/sec OK
>>>> /crypto/hash/sha256/speed-16384: 275.59 MB/sec OK
>>>> /crypto/hash/sha384/speed-512: 322.73 MB/sec OK
>>>> /crypto/hash/sha384/speed-1024: 369.84 MB/sec OK
>>>> /crypto/hash/sha384/speed-4096: 406.71 MB/sec OK
>>>> /crypto/hash/sha384/speed-16384: 417.87 MB/sec OK
>>>> /crypto/hash/sha512/speed-512: 320.62 MB/sec OK
>>>> /crypto/hash/sha512/speed-1024: 361.93 MB/sec OK
>>>> /crypto/hash/sha512/speed-4096: 404.91 MB/sec OK
>>>> /crypto/hash/sha512/speed-16384: 418.53 MB/sec OK
>>>> /crypto/hash/ripemd160/speed-512: 226.45 MB/sec OK
>>>> /crypto/hash/ripemd160/speed-1024: 239.25 MB/sec OK
>>>> /crypto/hash/ripemd160/speed-4096: 251.31 MB/sec OK
>>>> /crypto/hash/ripemd160/speed-16384: 255.01 MB/sec OK
>>>>
>>>>
>>>> IOW, md5 is clearly the quickest, by a considerable margin over
>>>> SHA256/512. SHA1 is slightly slower.
>>>>
>>>> Assuming that we document that this command is intentionally
>>>> *not* trying to guarantee collision resistances we're ok.
>>>>
>>>> In fact we should not document what kind of checksum is
>>>> reported by query-memory-checksum. The impl should be a black
>>>> box from user's POV.
>>>>
>>>> If we're just aiming for debugging tool to detect accidental
>>>> corruption, could we even just ignore cryptographic hashs
>>>> entirely and do a crc32 - that'd be way faster than even
>>>> md5.
>>>
>>> Good points.
>>>
>>> The doc strings should spell out "for debugging", like the commit
>>> message does, and both should spell out "weak collision resistance".
>>>
>>> I can't find CRC-32 in GLib, but zlib appears to provide it:
>>> http://refspecs.linuxbase.org/LSB_3.0.0/LSB-Core-generic/LSB-Core-generic/zlib-crc32-1.html
>>>
>>> Care to compare its speed to MD5?
>>
>> I hacked the code to use zlib's crc32 impl and got these for comparison:
>>
>> /crypto/hash/crc32/speed-512: 1089.18 MB/sec OK
>> /crypto/hash/crc32/speed-1024: 1124.63 MB/sec OK
>> /crypto/hash/crc32/speed-4096: 1162.73 MB/sec OK
>> /crypto/hash/crc32/speed-16384: 1171.58 MB/sec OK
>> /crypto/hash/crc32/speed-1048576: 1165.68 MB/sec OK
>> /crypto/hash/md5/speed-512: 476.27 MB/sec OK
>> /crypto/hash/md5/speed-1024: 517.16 MB/sec OK
>> /crypto/hash/md5/speed-4096: 554.70 MB/sec OK
>> /crypto/hash/md5/speed-16384: 564.44 MB/sec OK
>> /crypto/hash/md5/speed-1048576: 566.78 MB/sec OK
> 
> Twice as fast.  Alexey, what do you think?


This is even better. TBH I picked md5 as I could not spot crc32 helper 
in the first minute (I can see it now) and MD5 felt the fastest 
available from glibc :)  I'll probably add start..end range(s) and 
repost. Thanks for all these numbers and reviews.



-- 
Alexey

