Return-Path: <SRS0=z9mi=3N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E171C2D0DB
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 09:55:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6DA4F214AF
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 09:55:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GmaiVRcT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DA4F214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39516 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuvgk-0000Bq-Jf
	for qemu-devel@archiver.kernel.org; Fri, 24 Jan 2020 04:55:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36627)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iuvgA-000883-Bi
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 04:55:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iuvg9-0007lv-Ae
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 04:55:06 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:45869
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iuvg9-0007lG-7E
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 04:55:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579859704;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ak+rhJH/FIOkZcylI8ys6SqjteWK9snjvoskCUPE0QI=;
 b=GmaiVRcTeI/UNlLgRiC5hLFurVHAmGLDhxdkcxxJLKxWMTNhH17BoNVlJUn3vwM0JkzsSv
 aERqlHi7IAXyxPkA6o0yhlEJyTqPh5cGI1GPhTnMfJdnti6xhJ3lxkDkH7NdouqUegcF5f
 qFUqMUpOalib1avPQEoAYMo7Y1p0+HU=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-58-Jw8RwwzvPFeyG5pL4FdPZw-1; Fri, 24 Jan 2020 04:55:03 -0500
Received: by mail-wr1-f70.google.com with SMTP id w6so898827wrm.16
 for <qemu-devel@nongnu.org>; Fri, 24 Jan 2020 01:55:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=hs1jzOLeHnK6r0bbRVYiDQP+hlgnSGA8H88E/nsYvuk=;
 b=LDfg2+5phkrg88Wqt3OdVon4QIDgDfkK5vaXUDb9isZlR631kbxwTmsEpRekgIP0mL
 0xRZ3CrXcMo4c8yFGz01Y3PCOpuGYfq11P2LECj+6WVVCY8qiXUqJgNHdos/eywor0ev
 zL9OgL3Yj1J89LW/JM+Xgo7i9Cks3GtgST0Guh+JUdgXk/f8d0eKMOJ0MZwoHV1tAj4M
 a+1dW2Y8yzSEN8k4BptVtpF9h8qX3SUUAFHjAkTXyfA9aWaQX4wQWkFqZXL8kIJUsQA8
 7kid2GPUKJdoWJHwQV5HRMYWGXksQY7PPll/sNRUb/U7lCL1ZbIN1mHbBNNcws3QrsGD
 oVSw==
X-Gm-Message-State: APjAAAVNrf9ZNclol0n75No0Ex9MRBQlIOOTwo9myJgl9A5578Ka5g0Z
 LZwwQXzwI2zHGzqet+ozVLuWaW9IsTn/4cWILL1YCAod6+k64S/EoFwXrkrmSl5beqfOnWPd44U
 exHMdRUb/pII0GdE=
X-Received: by 2002:adf:f8c4:: with SMTP id f4mr3131681wrq.243.1579859701699; 
 Fri, 24 Jan 2020 01:55:01 -0800 (PST)
X-Google-Smtp-Source: APXvYqxILiCnK94tG6egPib49XHtqy9bWXe8aP6Fw7Q09v2zEahh7gpvKee9PDYtwPqz6vGiFR/RzA==
X-Received: by 2002:adf:f8c4:: with SMTP id f4mr3131651wrq.243.1579859701339; 
 Fri, 24 Jan 2020 01:55:01 -0800 (PST)
Received: from [192.168.1.35] (113.red-83-57-172.dynamicip.rima-tde.net.
 [83.57.172.113])
 by smtp.gmail.com with ESMTPSA id o2sm5459679wmh.46.2020.01.24.01.55.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 24 Jan 2020 01:55:00 -0800 (PST)
Subject: Re: [PATCH v3 4/4] travis.yml: Enable acceptance KVM tests
To: Thomas Huth <thuth@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>, qemu-devel@nongnu.org,
 alex.bennee@linaro.org
References: <20200122012753.9846-1-wainersm@redhat.com>
 <20200122012753.9846-5-wainersm@redhat.com>
 <e500a1ce-d2b6-b372-b1cb-f9bddcbf8334@redhat.com>
 <e9461b25-14d6-900c-1558-78a7aa910f92@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <e5689532-cfa7-1db7-ade2-c3a274083b25@redhat.com>
Date: Fri, 24 Jan 2020 10:54:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <e9461b25-14d6-900c-1558-78a7aa910f92@redhat.com>
Content-Language: en-US
X-MC-Unique: Jw8RwwzvPFeyG5pL4FdPZw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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

On 1/24/20 10:44 AM, Thomas Huth wrote:
> On 24/01/2020 10.38, Philippe Mathieu-Daud=C3=A9 wrote:
>> On 1/22/20 2:27 AM, Wainer dos Santos Moschetta wrote:
>>> Some acceptance tests require KVM or they are skipped. Travis
>>> enables nested virtualization by default with Ubuntu
>>> 18.04 (Bionic) on x86_64. So in order to run the kvm tests, this
>>> changed the acceptance builder to run in a Bionic VM. Also
>>> it was needed to ensure the current user has rw permission
>>> to /dev/kvm.
>>>
>>> Signed-off-by: Wainer dos Santos Moschetta <wainersm@redhat.com>
>>> ---
>>>  =C2=A0 .travis.yml | 7 ++++++-
>>>  =C2=A0 1 file changed, 6 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/.travis.yml b/.travis.yml
>>> index 6c1038a0f1..c3edd0a907 100644
>>> --- a/.travis.yml
>>> +++ b/.travis.yml
>>> @@ -2,6 +2,7 @@
>>>  =C2=A0 # Additional builds with specific requirements for a full VM ne=
ed to
>>>  =C2=A0 # be added as additional matrix: entries later on
>>>  =C2=A0 dist: xenial
>>> +sudo: true
>>>  =C2=A0 language: c
>>>  =C2=A0 compiler:
>>>  =C2=A0=C2=A0=C2=A0 - gcc
>>> @@ -83,6 +84,9 @@ git:
>>>  =C2=A0 =C2=A0 before_script:
>>>  =C2=A0=C2=A0=C2=A0 - if command -v ccache ; then ccache --zero-stats ;=
 fi
>>> +=C2=A0 - if [[ -e /dev/kvm ]] && ! [[ -r /dev/kvm && -w /dev/kvm ]]; t=
hen
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sudo chmod o+rw /dev/kvm ;
>>> +=C2=A0=C2=A0=C2=A0 fi
>>>  =C2=A0=C2=A0=C2=A0 - mkdir -p ${BUILD_DIR} && cd ${BUILD_DIR}
>>>  =C2=A0=C2=A0=C2=A0 - ${SRC_DIR}/configure ${BASE_CONFIG} ${CONFIG} || =
{ cat
>>> config.log && exit 1; }
>>>  =C2=A0 script:
>>> @@ -272,12 +276,13 @@ matrix:
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - TEST_CMD=3D"m=
ake check-acceptance"
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 after_script:
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - python3 -c 'i=
mport json; r =3D
>>> json.load(open("tests/results/latest/results.json"));
>>> [print(t["logfile"]) for t in r["tests"] if t["status"] not in
>>> ("PASS", "SKIP")]' | xargs cat
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dist: bionic
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 addons:
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 apt:
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pac=
kages:
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 - python3-pil
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 - python3-pip
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - p=
ython3.5-venv
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - p=
ython3.6-venv
>>
>> This line doesn't seem related to the patch.
>=20
> "dist:" has been switched from xenial to bionic, so I think it is
> required to update to python3.6 here, too?

OK, I got confused because line 4 is still "dist: xenial".

Wainer can you add a comment about this in the commit description?

I'm still not convinced we should enable "sudo: true" on all our jobs.


