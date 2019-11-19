Return-Path: <SRS0=aBJE=ZL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB14AC432C0
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 17:39:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B7A1C20718
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 17:39:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UH9XtQ01"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7A1C20718
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48542 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iX7TC-0001am-VE
	for qemu-devel@archiver.kernel.org; Tue, 19 Nov 2019 12:39:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51373)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iX7ST-00016E-NC
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 12:38:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iX7SR-0005e8-1r
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 12:38:33 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:54167
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iX7SQ-0005c5-6c
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 12:38:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574185105;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Nh3ATgzvebpsn6nItHpxq8jIaWcFZVqf8c6dGhjLuIM=;
 b=UH9XtQ018sX4Bg5umbLnR9DJPwcapIJNOzCjgHqZSjMplB7H/4mfeN0JmVf4hKqY/mx4Nw
 ImbBPTbVXk6oLkaZe2i1377b/GSNRaDVGAyHQeiGwDm/4DoAb+Fg1j/oFlnSfT640Y+Apg
 l0JB7bOlCJoJCG05EQ7Hca3/eNDyvFs=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-384-JLK1uAq7MbO9puOyzQXwhQ-1; Tue, 19 Nov 2019 12:38:23 -0500
Received: by mail-wr1-f71.google.com with SMTP id l3so18906046wrx.21
 for <qemu-devel@nongnu.org>; Tue, 19 Nov 2019 09:38:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=1phOG1ssO12HKIXibBja3UaCWvjQvuxSjByILtHR4xM=;
 b=MLb71bqdjY+TrvMJgqnyCuBJA9eDgXzoxfPB0rfXUpZAcRpXfjeq4MlxKVSejNTl+t
 J/gZPwlwdCnLKoPV7JAdVAxGEMzauLBz78+Q7lyGGkPeMgdCMc2aaUL/qQU4+VsStoYn
 veBkzi7HGs6fS7oR6L0Xe+q8+3Gcckhbu6T0hhitRaUqLCT4nwdNSHzvqb9rYGu1Tl2z
 Feclng0Sh/Q8//feMeSLMWt6X7V4sQcxkgMzh2lt7M08zzfLhsl0Yejr2+cL/nhbXd3D
 OAk7gS401I6kUzJaVPQuKg8yUErc9tgV5OtQR7/mkNoPhrq4uU+r8Sb2UPztgsaDQ8od
 AhgA==
X-Gm-Message-State: APjAAAVrc0w8Lw3/yThu3W3vxtuyQ18br5tXrzfYAo3vCy+QhqgvJ8lc
 IUpiAe42j4r+ksheeQzG6LZXsFR0HreG3LsSVZhg0fmsngFsSxVWWqo4Kr07I8B/4IFSUxguojd
 lKQjSyC0Iri6tYBs=
X-Received: by 2002:a05:600c:2257:: with SMTP id
 a23mr7547459wmm.143.1574185102206; 
 Tue, 19 Nov 2019 09:38:22 -0800 (PST)
X-Google-Smtp-Source: APXvYqxrGgXkrXX9ZK8AwiN/9A6YQoC5HTbcA2X2AyEcITxm7iYCLDx/KiU016woxbkd12ANaZNWpA==
X-Received: by 2002:a05:600c:2257:: with SMTP id
 a23mr7547421wmm.143.1574185101987; 
 Tue, 19 Nov 2019 09:38:21 -0800 (PST)
Received: from [192.168.1.35] (131.red-88-21-102.staticip.rima-tde.net.
 [88.21.102.131])
 by smtp.gmail.com with ESMTPSA id p25sm3811520wma.20.2019.11.19.09.38.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 Nov 2019 09:38:21 -0800 (PST)
Subject: Re: [PATCH 2/6] iotests: Skip test 079 if it is not possible to
 create large files
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
References: <20191119170822.45649-1-thuth@redhat.com>
 <20191119170822.45649-3-thuth@redhat.com>
 <7242d268-6563-246f-4acc-2e714ebfd513@redhat.com>
 <06a31aff-e01b-74ae-3d9a-ff0f8ea2696b@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <1d32c8c3-1cc3-574d-e79f-4b5bc2f376d3@redhat.com>
Date: Tue, 19 Nov 2019 18:38:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <06a31aff-e01b-74ae-3d9a-ff0f8ea2696b@redhat.com>
Content-Language: en-US
X-MC-Unique: JLK1uAq7MbO9puOyzQXwhQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
Cc: Laurent Vivier <lvivier@redhat.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/19/19 6:34 PM, Thomas Huth wrote:
> On 19/11/2019 18.29, Philippe Mathieu-Daud=E9 wrote:
>> On 11/19/19 6:08 PM, Thomas Huth wrote:
>>> Test 079 fails in the arm64, s390x and ppc64le LXD containers, which
>>> apparently do not allow large files to be created. Test 079 tries to
>>> create a 4G sparse file, so check first whether we can really create
>>> such files before executing the test.
>>>
>>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>>> ---
>>>  =A0 tests/qemu-iotests/079 | 6 ++++++
>>>  =A0 1 file changed, 6 insertions(+)
>>>
>>> diff --git a/tests/qemu-iotests/079 b/tests/qemu-iotests/079
>>> index 81f0c21f53..e9b81419b7 100755
>>> --- a/tests/qemu-iotests/079
>>> +++ b/tests/qemu-iotests/079
>>> @@ -39,6 +39,12 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
>>>  =A0 _supported_fmt qcow2
>>>  =A0 _supported_proto file nfs
>>>  =A0 +# Some containers (e.g. non-x86 on Travis) do not allow large fil=
es
>>> +if ! truncate --size=3D4G "$TEST_IMG"; then
>>
>> Shouldn't we restrict that to Travis-CI by checking some environment var=
?
>=20
> I'd rather like to keep it independent from Travis environment
> variables, since somebody might want to run "make check" in other
> non-Travis containers or on weird filesystems, and then the test should
> ideally not fail, but simply skip, too.

I see. But it would be bad if we stop catching normal bugs with this=20
test because we restricted it to contained environments.

Maybe we can add a generic is_contained() routine that only checks for=20
TRAVIS env var, and people using other containers can expand it.


