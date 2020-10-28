Return-Path: <SRS0=Un+l=ED=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D43BCC388F7
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 14:13:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0767F2475E
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 14:12:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dFNvaPDr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0767F2475E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49390 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXmCA-0005jE-TW
	for qemu-devel@archiver.kernel.org; Wed, 28 Oct 2020 10:12:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56248)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kXm9F-0004HT-FD
 for qemu-devel@nongnu.org; Wed, 28 Oct 2020 10:09:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:37872)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kXm9C-0005SE-Lv
 for qemu-devel@nongnu.org; Wed, 28 Oct 2020 10:09:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603894192;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JBVN+g3e3DOeAmo22ebXYiZVNpCcbUgkpgk34Oc4cOk=;
 b=dFNvaPDrigT4rre9D7ioQB1dgDzD/8c2MT/S2xlK9esDo3Qb0zngOBni7GkNd+imOM5RZq
 k1KELFfU8lQixsxiYcCzdawX6m7heDFO68dttOTlC/lOtnoV43o+2jpSq9KY5HRQu5lj0s
 AyFYyUW0zRqL8ozaOpaAIvbOsRPgKFI=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-415-inu7pz9iMvCSMFVYx2qjRg-1; Wed, 28 Oct 2020 10:09:51 -0400
X-MC-Unique: inu7pz9iMvCSMFVYx2qjRg-1
Received: by mail-ej1-f72.google.com with SMTP id x12so2152954eju.22
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2020 07:09:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=JBVN+g3e3DOeAmo22ebXYiZVNpCcbUgkpgk34Oc4cOk=;
 b=MgOcYR5Y3ZUL+YpBH+s1FCmfVAYbisUamFTWI7ep2Nh7mXEyPV/gKi3Sm1bzNh6M16
 dQ5v1JGahGA1OmGA3PCruYZGmV788d9eTCoAU47JaKe7c0JdxSW2bN2Q4PHrp0qhRd99
 wf6eNTwFao57oOu5yfXDR4RXQsBqAFBYFBaoRwxI/kkZSzsYcVpvgYZG1+Ci5iVIQk+/
 mEop3B70HxEFVERP75PYD8M7qzuhVcmXIuq32vxnevgvPBUuFp6KviVYGtif0QzYbVI0
 vn+ZBSWUF05ufDZhJqpKNFzfU0YMxkTO/QhrSDm6t0BhrlHuhoXs9te/SvoLv2anla0o
 Zqbw==
X-Gm-Message-State: AOAM531Wsnv/DDIA6t3KTujL0Q2kBS9idFohm4bbWV+P9KaZqjSsmY7S
 6d6pDkbE3mX6ccDxM7oJxRMThkzP9IXJFUwDxqidgd+muH/RXTMwAi/9h15xf71Pth4O9nnldDE
 0Fl91V/MSC1plKPE=
X-Received: by 2002:a50:fb06:: with SMTP id d6mr8038049edq.312.1603894189788; 
 Wed, 28 Oct 2020 07:09:49 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxypZeMOe/l8eM+tO7K7w7INe1kkZ3DFyCEPK4vX3fLF/zHU0H9/tgvL2xcogZAXYZjqPBpKg==
X-Received: by 2002:a50:fb06:: with SMTP id d6mr8038021edq.312.1603894189522; 
 Wed, 28 Oct 2020 07:09:49 -0700 (PDT)
Received: from [192.168.1.36] (237.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.237])
 by smtp.gmail.com with ESMTPSA id ds7sm3027884ejc.83.2020.10.28.07.09.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 28 Oct 2020 07:09:48 -0700 (PDT)
Subject: Re: [PATCH 1/5] python: add pytest and tests
To: John Snow <jsnow@redhat.com>, Thomas Huth <thuth@redhat.com>,
 qemu-devel@nongnu.org
References: <20201027223815.159802-1-jsnow@redhat.com>
 <20201027223815.159802-2-jsnow@redhat.com>
 <7440abdc-b01e-ba5e-5238-a6e4573f88b5@redhat.com>
 <c85597c2-a9b3-e8ff-7208-c3f16002f40b@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <0624d33b-16f7-9980-3207-833e56e4fe62@redhat.com>
Date: Wed, 28 Oct 2020 15:09:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <c85597c2-a9b3-e8ff-7208-c3f16002f40b@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/28 01:50:00
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.921, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Daniel_P_=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/28/20 2:23 PM, John Snow wrote:
> On 10/28/20 2:19 AM, Thomas Huth wrote:
>> On 27/10/2020 23.38, John Snow wrote:
>>> Try using pytest to manage our various tests; even though right now
>>> they're only invoking binaries and not really running any python-native
>>> code.
>>>
>>> Create tests/, and add test_lint.py which calls out to mypy, flake8,
>>> pylint and isort to enforce the standards in this directory.
>>>
>>> Add pytest to the setup.cfg development dependencies; add a pytest
>>> configuration section as well; run it in verbose mode.
>>>
>>> Finally, add pytest to the Pipfile environment and lock the new
>>> dependencies. (Note, this also updates an unrelated dependency; but the
>>> only way to avoid this is to pin that dependency at a lower version --
>>> which there is no reason to do at present.)
>>>
>>> Provided you have the right development dependencies (mypy, flake8,
>>> isort, pylint, and now pytest) You should be able to run "pytest" from
>>> the python folder to run all of these linters with the correct
>>> arguments.
>>>
>>> Signed-off-by: John Snow <jsnow@redhat.com>
>>> ---
>>>   python/Pipfile.lock       | 71 ++++++++++++++++++++++++++++++++++++---
>>>   python/setup.cfg          |  5 +++
>>>   python/tests/test_lint.py | 28 +++++++++++++++
>>>   3 files changed, 99 insertions(+), 5 deletions(-)
>>>   create mode 100644 python/tests/test_lint.py
>>>
>>> diff --git a/python/Pipfile.lock b/python/Pipfile.lock
>>> index 05077475d750..105ffbc09a8e 100644
>>> --- a/python/Pipfile.lock
>>> +++ b/python/Pipfile.lock
>>> @@ -30,6 +30,14 @@
>>>               "markers": "python_version >= '3.5'",
>>>               "version": "==2.4.2"
>>>           },
>>> +        "attrs": {
>>> +            "hashes": [
>>> +               
>>> "sha256:26b54ddbbb9ee1d34d5d3668dd37d6cf74990ab23c828c2888dccdceee395594",
>>>
>>> +               
>>> "sha256:fce7fc47dfc976152e82d53ff92fa0407700c21acd20886a13777a0d20e655dc"
>>>
>>> +            ],
>>> +            "markers": "python_version >= '2.7' and python_version
>>> not in '3.0, 3.1, 3.2, 3.3'",
>>
>> Can't you simply use "python_version >= '3.6'" instead?
>>
>>   Thomas
>>
> 
> This file is generated; I don't really actually know what these markers
> mean or to whom. I can't edit it because it's checksummed.

We should remember to add a line such "The Pipfile.lock content
is generated" in the commit message each time it is modified after
a change in setup.cfg :)

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>


