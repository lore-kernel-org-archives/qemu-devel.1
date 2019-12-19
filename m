Return-Path: <SRS0=p/0J=2J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3F1DC2D0C1
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 12:19:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F77520716
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 12:19:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Oqmv4HvF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F77520716
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39892 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihum8-0002j5-LT
	for qemu-devel@archiver.kernel.org; Thu, 19 Dec 2019 07:19:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48382)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1ihulV-0002Fi-9i
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 07:18:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1ihulT-0005u2-O7
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 07:18:48 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:50174
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1ihulT-0005nB-Hc
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 07:18:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576757922;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=b6+CzsAINpd92w2JvJ4d0m8/UJSjpb2V1nUm54xWpio=;
 b=Oqmv4HvFFyE6PsIAnxHZul9pzWuZxmLsJcc/nRGisviVB6++G2/MIdkLVxFbGwGfJkQCDS
 u2Z4QjOJ+2zkab3v+6QI2kX+Ndsx2K8uV/TtMzsxzQJSO5RrEQid/UnGjPgP/38heAR2p5
 CUMbFyboahKO8sCuguvhROlMoDg4i0M=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-239-5LHWmbMAPTSv67yIQc8IUg-1; Thu, 19 Dec 2019 07:18:41 -0500
Received: by mail-ed1-f70.google.com with SMTP id w3so96121edt.23
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2019 04:18:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=2ozqnJmbndidDG6aIjRCtjB4OKxQTFe/UlvcDlRXOu4=;
 b=mNOmwckbrLEEyfxgFXfiCJ6fLvBGb5ihhK7M0BQin3hWKmdjPzcQl4e6W0gxOQ8izX
 6F9LMNluXN3iy3jw/uAtwRXMV3+A7+ldDcxB+MySQ16H4wWRXS51mJiCXnPpK7XcOXOk
 dBz2BBM+XFkKNHVoHR1agYgBtzX5+Gw1BTtAmn+neBHVomx0v4Iub3s1YMusGTtY9BS9
 a/jGBQd48QAk1Yiu2fdKofiqYVaETsXRvi+OrGhHlONtBw5n1+iCMK5jYcdWlyom89Wp
 iMyPKn9uXVi+KaOZKEtsFULJWVmAOB+GyL9JzE9sBSWst0JGcM2Y7z3P7ND+TngeMIuy
 CBnw==
X-Gm-Message-State: APjAAAXQd4tgx4ah5G09dGBopghC+WsgHFPX7wNEPkFM5EZQPDsgqtnD
 wBkYkWUZCnSTFUcjNjqOO2IPl51UqZ4JvuFP2HLhca7XpFahwI73S1cywJ1zRuwLLBIZ+KkwAGI
 iQr/V5N01ldpxBGk=
X-Received: by 2002:a17:906:c299:: with SMTP id
 r25mr8975886ejz.272.1576757920184; 
 Thu, 19 Dec 2019 04:18:40 -0800 (PST)
X-Google-Smtp-Source: APXvYqz2O5SGipLcob53h5lCh4BDuBaQsR4wrjjy+dj/LqK60q4t1KSJNdA2voMnO5ojkguUAM7Nzg==
X-Received: by 2002:a17:906:c299:: with SMTP id
 r25mr8975856ejz.272.1576757919888; 
 Thu, 19 Dec 2019 04:18:39 -0800 (PST)
Received: from [192.168.1.35] (34.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.34])
 by smtp.gmail.com with ESMTPSA id x15sm353852edl.48.2019.12.19.04.18.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Dec 2019 04:18:39 -0800 (PST)
Subject: Re: [PATCH v8 3/4] Acceptance tests: add make targets to download
 images
To: Cleber Rosa <crosa@redhat.com>
References: <20191218232500.23530-1-crosa@redhat.com>
 <20191218232500.23530-4-crosa@redhat.com>
 <e1dc21f1-a349-508e-db11-5aee59f31f2e@redhat.com>
 <20191219004147.GC29918@localhost.localdomain>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <2c5bf75a-af86-da23-19e4-28123b7dff66@redhat.com>
Date: Thu, 19 Dec 2019 13:18:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191219004147.GC29918@localhost.localdomain>
Content-Language: en-US
X-MC-Unique: 5LHWmbMAPTSv67yIQc8IUg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
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
Cc: Fam Zheng <fam@euphon.net>, Beraldo Leal <bleal@redhat.com>,
 qemu-devel@nongnu.org, Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Willian Rampazzo <wrampazz@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/19/19 1:41 AM, Cleber Rosa wrote:
> On Thu, Dec 19, 2019 at 01:16:12AM +0100, Philippe Mathieu-Daud=E9 wrote:
>> On 12/19/19 12:24 AM, Cleber Rosa wrote:
>>> The newly introduced "boot linux" tests make use of Linux images that
>>> are larger than usual, and fall into what Avocado calls "vmimages",
>>> and can be referred to by name, version and architecture.
>>>
>>> The images can be downloaded automatically during the test. But, to
>>> make for more reliable test results, this introduces a target that
>>> will download the vmimages for the architectures that have been
>>> configured and are available for the currently used distro (Fedora
>>> 31).
>>>
>>> Signed-off-by: Cleber Rosa <crosa@redhat.com>
>>> ---
>>>    tests/Makefile.include | 17 +++++++++++++++--
>>>    1 file changed, 15 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/tests/Makefile.include b/tests/Makefile.include
>>> index b381387048..78a6f089ff 100644
>>> --- a/tests/Makefile.include
>>> +++ b/tests/Makefile.include
>>> @@ -1177,7 +1177,20 @@ $(TESTS_RESULTS_DIR):
>>>    check-venv: $(TESTS_VENV_DIR)
>>> -check-acceptance: check-venv $(TESTS_RESULTS_DIR)
>>> +FEDORA_31_ARCHES_CANDIDATES=3D$(patsubst ppc64,ppc64le,$(TARGETS))
>>> +FEDORA_31_ARCHES :=3D x86_64 aarch64 ppc64le s390x
>>> +FEDORA_31_DOWNLOAD=3D$(filter $(FEDORA_31_ARCHES),$(FEDORA_31_ARCHES_C=
ANDIDATES))
>>> +
>>> +# download one specific Fedora 31 image
>>> +get-vmimage-fedora-31-%: $(check-venv)
>>> +=09$(call quiet-command, \
>>> +             $(TESTS_VENV_DIR)/bin/python -m avocado vmimage get \
>>> +             --distro=3Dfedora --distro-version=3D31 --arch=3D$*)

Another thing we can do here is check the host has sufficient storage.

>>> +
>>> +# download all vm images, according to defined targets
>>> +get-vmimage: $(patsubst %,get-vmimage-fedora-31-%, $(FEDORA_31_DOWNLOA=
D))
>>> +
>>> +check-acceptance: check-venv $(TESTS_RESULTS_DIR) get-vmimage
>>>    =09$(call quiet-command, \
>>>                $(TESTS_VENV_DIR)/bin/python -m avocado \
>>>                --show=3D$(AVOCADO_SHOW) run --job-results-dir=3D$(TESTS=
_RESULTS_DIR) \
>>> @@ -1188,7 +1201,7 @@ check-acceptance: check-venv $(TESTS_RESULTS_DIR)
>>>    # Consolidated targets
>>> -.PHONY: check-block check-qapi-schema check-qtest check-unit check che=
ck-clean
>>> +.PHONY: check-block check-qapi-schema check-qtest check-unit check che=
ck-clean get-vmimage
>>>    check-qapi-schema: check-tests/qapi-schema/frontend check-tests/qapi=
-schema/doc-good.texi
>>>    check-qtest: $(patsubst %,check-qtest-%, $(QTEST_TARGETS))
>>>    check-block: $(patsubst %,check-%, $(check-block-y))
>>>
>>
>> We have both 'make vm-help' and 'make check-help'. The check-acceptance
>> target is in check-help. We get vm image... confusing.
>>
>=20
> I know... I had a hard time coming up with a name, and I'm aware it's not
> a very good one.
>=20
>> Anyway, can you list this new target, with a hint about the storage size
>> required?
>=20
> Sure thing, good point.
>=20
>> Can you add an entry in the 'make
>>
>=20
> I suspect you mean adding an entry in the 'make check-help' output, right=
?

Hehe I'm not sure what happened here. I probably fell asleep on the=20
keyboard. Since 'check-acceptance' is listed in 'check-help', this seems=20
the best place.

Thanks,

Phil.


