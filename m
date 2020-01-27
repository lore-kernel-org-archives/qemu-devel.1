Return-Path: <SRS0=8p31=3Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C02BDC32771
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 09:52:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A751214AF
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 09:52:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DVc0IJyL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A751214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42230 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iw143-0006kO-Mo
	for qemu-devel@archiver.kernel.org; Mon, 27 Jan 2020 04:52:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34393)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iw13S-000686-DS
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 04:51:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iw13P-00019A-Tb
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 04:51:37 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:33181
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iw13P-00017n-EJ
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 04:51:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580118694;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zwZCL5wBu1NIZ/DIv4niW4278B/U8X0VsRA/lDxqZhQ=;
 b=DVc0IJyLNNMEMLY/LSura8U6UaWgF8uUin5RcBpXii9PQ+o0sA8b3/K5PkiLk1opybVcHT
 WMbHdhGWfNw5FUclSE+a0OHIsHi7IWH2FwZ7CUAXGX/A3N39x2SBCpfOc2LCN93YoXzUui
 hbQsIr6Y6iiqDBIoHJHn/8zarhwOGns=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-59-lQxG0s5INw-bGZyR9w5e5A-1; Mon, 27 Jan 2020 04:51:31 -0500
Received: by mail-wr1-f71.google.com with SMTP id 90so5818218wrq.6
 for <qemu-devel@nongnu.org>; Mon, 27 Jan 2020 01:51:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=YwRija6fr59JSZlGjZxMMOZOYDLnwcI6tndIg8/bg5Y=;
 b=A+ZY38tVfPM7nGUsWfHjloZFUvNO3FmRFoODOvT4+EJA1xCOH9AihRufC+PAPf5Yut
 ugSnnkKn6CDpiuuSrTlYL+qriZKpsPwB2h285kP0+uDZ0BDLYUJrp2m4sFdKdRAMX3VE
 I8KtQd6yl0qdewrwxTfxnb7xNqGRC6/FrSbhhwBiBz1DhIevYztk5F28Nm5rOnEDxPvw
 eMEdJ+J912BbgVYFnpvrMpPjKWiPRQDRJJ+6o3APGiYPlbrxwWNQMrQVz/oeni2yUBOu
 oyJjXj+npPgjQgiQhDYKQJL/kcE/clcVpVpeCiSojYNTwdydJw19YT+ZhP1FaMu6IGDi
 palA==
X-Gm-Message-State: APjAAAWYQjqIpCNVdaJZSVrMfzCWwRwaXrbqFu30LVLlQG/jksX2WjTN
 WvQUT6NYiMJj2kDKeXeURX3V141Z/Zc6hFAnw6VSf9UXKzlSe31ZAVOQUKJWAPezXInN1r3GLdI
 gMWGDyOeB9te7CUY=
X-Received: by 2002:adf:ebc6:: with SMTP id v6mr20177424wrn.75.1580118690278; 
 Mon, 27 Jan 2020 01:51:30 -0800 (PST)
X-Google-Smtp-Source: APXvYqwVwj3YAV0csTZTYTaqtny6cUuCGqwP/LQfyFY1gmkSfXtC9uy40cyl3PIRVTraQavshELcJA==
X-Received: by 2002:adf:ebc6:: with SMTP id v6mr20177379wrn.75.1580118689882; 
 Mon, 27 Jan 2020 01:51:29 -0800 (PST)
Received: from [192.168.1.35] (113.red-83-57-172.dynamicip.rima-tde.net.
 [83.57.172.113])
 by smtp.gmail.com with ESMTPSA id d16sm22844347wrg.27.2020.01.27.01.51.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Jan 2020 01:51:29 -0800 (PST)
Subject: Re: [PATCH v3 4/4] travis.yml: Enable acceptance KVM tests
To: Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, alex.bennee@linaro.org
References: <20200122012753.9846-1-wainersm@redhat.com>
 <20200122012753.9846-5-wainersm@redhat.com>
 <e500a1ce-d2b6-b372-b1cb-f9bddcbf8334@redhat.com>
 <e9461b25-14d6-900c-1558-78a7aa910f92@redhat.com>
 <e5689532-cfa7-1db7-ade2-c3a274083b25@redhat.com>
 <86ba7b67-a69a-bfc3-2d70-d4328acda2de@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <6bfb56d0-c386-0aad-dbbc-43481fe31a05@redhat.com>
Date: Mon, 27 Jan 2020 10:51:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <86ba7b67-a69a-bfc3-2d70-d4328acda2de@redhat.com>
Content-Language: en-US
X-MC-Unique: lQxG0s5INw-bGZyR9w5e5A-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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

On 1/24/20 8:55 PM, Wainer dos Santos Moschetta wrote:
> On 1/24/20 7:54 AM, Philippe Mathieu-Daud=C3=A9 wrote:
>> On 1/24/20 10:44 AM, Thomas Huth wrote:
>>> On 24/01/2020 10.38, Philippe Mathieu-Daud=C3=A9 wrote:
>>>> On 1/22/20 2:27 AM, Wainer dos Santos Moschetta wrote:
>>>>> Some acceptance tests require KVM or they are skipped. Travis
>>>>> enables nested virtualization by default with Ubuntu
>>>>> 18.04 (Bionic) on x86_64. So in order to run the kvm tests, this
>>>>> changed the acceptance builder to run in a Bionic VM. Also
>>>>> it was needed to ensure the current user has rw permission
>>>>> to /dev/kvm.
>>>>>
>>>>> Signed-off-by: Wainer dos Santos Moschetta <wainersm@redhat.com>
>>>>> ---
>>>>> =C2=A0=C2=A0 .travis.yml | 7 ++++++-
>>>>> =C2=A0=C2=A0 1 file changed, 6 insertions(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/.travis.yml b/.travis.yml
>>>>> index 6c1038a0f1..c3edd0a907 100644
>>>>> --- a/.travis.yml
>>>>> +++ b/.travis.yml
>>>>> @@ -2,6 +2,7 @@
>>>>> =C2=A0=C2=A0 # Additional builds with specific requirements for a ful=
l VM=20
>>>>> need to
>>>>> =C2=A0=C2=A0 # be added as additional matrix: entries later on
>>>>> =C2=A0=C2=A0 dist: xenial
>>>>> +sudo: true
>>>>> =C2=A0=C2=A0 language: c
>>>>> =C2=A0=C2=A0 compiler:
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0 - gcc
>>>>> @@ -83,6 +84,9 @@ git:
>>>>> =C2=A0=C2=A0 =C2=A0 before_script:
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0 - if command -v ccache ; then ccache --zero-=
stats ; fi
>>>>> +=C2=A0 - if [[ -e /dev/kvm ]] && ! [[ -r /dev/kvm && -w /dev/kvm ]];=
 then
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sudo chmod o+rw /dev/kvm =
;
>>>>> +=C2=A0=C2=A0=C2=A0 fi
>=20
>=20
> Philippe, anwsering here your question about 'sudo'.
>=20
> The above statement runs on before_script for all the builders. As far=20
> as I know only on Bionic-based builders 'chmod' (that needs sudo) will=20
> be executed, so technically 'sudo' should=C2=A0 be enabled only on those=
=20
> builders. But I thought that would be error-prone not enable it globally=
=20
> since the code requiring it is globally declared too. All in all, I=20
> don't have a strong option for this.
>=20
>=20
>>>>>
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0 - mkdir -p ${BUILD_DIR} && cd ${BUILD_DIR}
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0 - ${SRC_DIR}/configure ${BASE_CONFIG} ${CONF=
IG} || { cat
>>>>> config.log && exit 1; }
>>>>> =C2=A0=C2=A0 script:
>>>>> @@ -272,12 +276,13 @@ matrix:
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - TEST_C=
MD=3D"make check-acceptance"
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 after_script:
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - python=
3 -c 'import json; r =3D
>>>>> json.load(open("tests/results/latest/results.json"));
>>>>> [print(t["logfile"]) for t in r["tests"] if t["status"] not in
>>>>> ("PASS", "SKIP")]' | xargs cat
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dist: bionic
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 addons:
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 apt:
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 packages:
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 - python3-pil
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 - python3-pip
>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -=
 python3.5-venv
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -=
 python3.6-venv
>>>>
>>>> This line doesn't seem related to the patch.
>>>
>>> "dist:" has been switched from xenial to bionic, so I think it is
>>> required to update to python3.6 here, too?
>=20
>=20
> Thomas is right, python3.5-venv isn't available on Ubuntu Bionic.
>=20
>=20
>>>
>>
>> OK, I got confused because line 4 is still "dist: xenial".
>=20
>=20
> I'm about to send a proposal to bump dist to bionic. There are some=20
> non-acceptance tests being skipped because of the lack of nested kvm on=
=20
> Travis's xenial VMs, so that would be beneficial to them as well.
>=20
> Thomas mentioned in another email thread that there is a build problem=20
> with the libssh version of Bionic (I hope that can be worked out). Other=
=20
> than that, do you see any impediment to switch all builders completely?

No, this is a distribution bug, we can use "--disable-libssh" in the=20
Bionic jobs.
>>
>>
>> Wainer can you add a comment about this in the commit description?
>=20
>=20
> Sure, actually I should have done it. Thanks for raising that point too.
>=20
> - Wainer
>=20
>>
>>
>> I'm still not convinced we should enable "sudo: true" on all our jobs.
>>
>=20


