Return-Path: <SRS0=ZEKs=WJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EB4DC32750
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2019 07:57:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 52721206C2
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2019 07:57:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52721206C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50012 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hxRgm-0002tL-AX
	for qemu-devel@archiver.kernel.org; Tue, 13 Aug 2019 03:57:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38589)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <pbonzini@redhat.com>) id 1hxRgP-0002Ud-DV
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 03:57:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1hxRgO-0004eC-3o
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 03:57:29 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:52126)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hxRgN-0004cj-Tp
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 03:57:28 -0400
Received: by mail-wm1-f67.google.com with SMTP id 207so590879wma.1
 for <qemu-devel@nongnu.org>; Tue, 13 Aug 2019 00:57:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ewe2or9v/fuL9iirL+I+ya79ry58pPkCw+6fEbyKDws=;
 b=LpAm4K6Ivze2z+w/sIuLnYLRQIQVP2rbRr6rUY4zHwUoqJLBZTDkPmYocbVHjYhPno
 kZoFxhrhbqi5UDgP6xGyx6tbbDs3rhu7E2Gxxg9NeKTM83X+wUwZxKmOBCmhzR7leRGz
 6DzMXGr3lImZWVXzvD5c5wXUyayx1i2tQVGsYnvxMWdRIJnIabOkkf2Qw/tJl8edgQ9m
 8N56F5TF4UPO5xIu1FWPK9JJH6j1ceYibHO4gNF1CCaLvyZOVg6zglzHPnRIKdprT7YT
 G+/OMI/e8u84WVNuq0Iww9PofJyTbQ2Ew8TTIyx20WtbeH/Tu6UnruWv+9vb2NFybC4k
 A9/A==
X-Gm-Message-State: APjAAAWNGMmMHLRiBgXX0A4/rxJaSMHZY/iSDNyRx3j4Ebp/Lfj9dz/T
 yh+WpgkbBV22dHyMUJhUsbFy5w==
X-Google-Smtp-Source: APXvYqyOFohNmNuLZEuREGwIaDYblgSnmMRKLHSSEUMmKlTeOb8or3kf3D7jnptVMWhKBkIfKqMTUQ==
X-Received: by 2002:a7b:cf3a:: with SMTP id m26mr1595365wmg.111.1565683046476; 
 Tue, 13 Aug 2019 00:57:26 -0700 (PDT)
Received: from [192.168.10.150] ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id 74sm1359173wma.15.2019.08.13.00.57.24
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Tue, 13 Aug 2019 00:57:25 -0700 (PDT)
To: Thomas Huth <thuth@redhat.com>, John Snow <jsnow@redhat.com>,
 Qemu-block <qemu-block@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
References: <f95cecc3-9ba2-0aed-9b17-fb76c6558929@redhat.com>
 <e5cc1268-428f-b3c0-3eb1-9291a9fe5688@redhat.com>
 <5e5822d2-41eb-a4e9-1d47-e29409b14b1e@redhat.com>
 <a2f5b94f-ce87-a8d2-b751-a38e44ad3b76@redhat.com>
 <6efe2b44-5914-b8fd-d4e6-74a35223b895@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <0055d070-160d-babe-8dec-a51184b5512a@redhat.com>
Date: Tue, 13 Aug 2019 09:57:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <6efe2b44-5914-b8fd-d4e6-74a35223b895@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.67
Subject: Re: [Qemu-devel] [Qemu-block] qemu-iotests 069 and 111 are failing
 on NetBSD
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
Cc: Kamil Rytarowski <kamil@netbsd.org>, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 13/08/19 08:17, Thomas Huth wrote:
> On 8/12/19 9:16 PM, John Snow wrote:
>>
>>
>> On 7/25/19 4:34 AM, Thomas Huth wrote:
>>> On 24/07/2019 18.29, Paolo Bonzini wrote:
>>>> On 24/07/19 11:34, Thomas Huth wrote:
>>>>> In case somebody is interested, two of the "auto" iotests are failing
>>>>> on NetBSD due to non-matching output:
>>>>>
>>>>>   TEST    iotest-qcow2: 069 [fail]
>>>>> --- /var/tmp/qemu-test.1BMupF/tests/qemu-iotests/069.out        2019-07-24 09:19:22.000000000 +0000
>>>>> +++ /var/tmp/qemu-test.1BMupF/tests/qemu-iotests/069.out.bad    2019-07-24 09:21:34.000000000 +0000
>>>>> @@ -4,5 +4,5 @@
>>>>>  
>>>>>  Formatting 'TEST_DIR/t.IMGFMT.base', fmt=IMGFMT size=131072
>>>>>  Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=131072 backing_file=TEST_DIR/t.IMGFMT.base
>>>>> -qemu-io: can't open device TEST_DIR/t.IMGFMT: Could not open backing file: Could not open 'TEST_DIR/t.IMGFMT.base': No such file or directory
>>>>> +qemu-io: can't open device TEST_DIR/t.IMGFMT: Could not open backing file: TEST_DIR/t.IMGFMT.base: stat failed: No such file or directory
>>>>>  *** done
>>>>>
>>>>> and:
>>>>>
>>>>>   TEST    iotest-qcow2: 111 [fail]
>>>>> --- /var/tmp/qemu-test.1BMupF/tests/qemu-iotests/111.out        2019-07-24 09:19:22.000000000 +0000
>>>>> +++ /var/tmp/qemu-test.1BMupF/tests/qemu-iotests/111.out.bad    2019-07-24 09:21:40.000000000 +0000
>>>>> @@ -1,4 +1,4 @@
>>>>>  QA output created by 111
>>>>> -qemu-img: TEST_DIR/t.IMGFMT: Could not open 'TEST_DIR/t.IMGFMT.inexistent': No such file or directory
>>>>> +qemu-img: TEST_DIR/t.IMGFMT: TEST_DIR/t.IMGFMT.inexistent: stat failed: No such file or directory
>>>>>  Could not open backing image to determine size.
>>>>>  *** done
>>>>>
>>>>> It's currently not a problem yet since we're not running the
>>>>> iotests on NetBSD yet (since our netbsd VM image does not have
>>>>> bash and gsed installed yet), but if somebody has some spare
>>>>> minutes, it would be great if this could be fixed so that we
>>>>> can enable the iotests on NetBSD, too, one day...
>>>>
>>>> Is this (slightly ridiculous but effective) patch enough?
>>>>
>>>> diff --git a/block/file-posix.c b/block/file-posix.c
>>>> index 73a001ceb7..ce847f4d62 100644
>>>> --- a/block/file-posix.c
>>>> +++ b/block/file-posix.c
>>>> @@ -217,7 +217,7 @@ static int raw_normalize_devicepath(const char **filename, Error **errp)
>>>>      fname = *filename;
>>>>      dp = strrchr(fname, '/');
>>>>      if (lstat(fname, &sb) < 0) {
>>>> -        error_setg_errno(errp, errno, "%s: stat failed", fname);
>>>> +        error_setg_errno(errp, errno, "Could not open: '%s'", fname);
>>>>          return -errno;
>>>>      }
>>>
>>> Yes, good idea! It works after removing the colon after "open"! :-)
>>>
>>> With the colon removed:
>>>
>>> Tested-by: Thomas Huth <thuth@redhat.com>
>>>
>>>  Thomas
>>>
>>
>> Does someone intend to submit this patch formally?
> 
> Yes, Paolo did it:
> 
>  https://www.mail-archive.com/qemu-devel@nongnu.org/msg633351.html

I can also include it in my pull request for 4.2.

Paolo


