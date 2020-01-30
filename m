Return-Path: <SRS0=hbhd=3T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF5BFC33CB3
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 17:19:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD7F7206F0
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 17:19:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AQTsYfHL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD7F7206F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36560 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixDTL-0003XZ-Rn
	for qemu-devel@archiver.kernel.org; Thu, 30 Jan 2020 12:19:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40102)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1ixDSZ-00038G-JX
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 12:18:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1ixDSX-0001OD-Nb
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 12:18:30 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:45041
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1ixDSX-0001NC-Ee
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 12:18:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580404708;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=l2QXb1dALbrh+fmFKCa294wQN7HhBW8Kfs+BXrVWeJ0=;
 b=AQTsYfHLaT7efqCue3dhm9zOJ439FYFth7Gwwk7AUBT3ALgoWnuEzdzrq+gk6bO27vxNkw
 kJan5+szrn24ZkM+QCl0SfCIKeb9YFWvXTsAeEpknC4AAgB5tiST48e6sTonLTmP2Wpem3
 NERi4y0yCUM9ptZ61g/3NgSJ5GaWhD0=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-113-dEtoiT-bMciFhqoNczeTkQ-1; Thu, 30 Jan 2020 12:18:26 -0500
Received: by mail-wr1-f72.google.com with SMTP id b13so1997922wrx.22
 for <qemu-devel@nongnu.org>; Thu, 30 Jan 2020 09:18:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=7xW8zrbKzGldmcf8xuZ3DRH/Q8utytZEcUPhRJfW+e0=;
 b=mXm8VncYA14+NsxJdeNaQv0b2V9/7dp+dSQY6NwGNs1OP6/rL7xnnPRpRmWnG+i7hN
 Wo8aaPSooRYvc8oivMwF28MfRVfHdrfYoIRSkzjC6wv7eGhqGnBaoow00vf4FztkhN4v
 fzhtPKST6P9fdv/aJScmNIggJgHE3JFXnnVf9cN5CUyJ9p8ktoNA1g1onnIKMhncRW5w
 OsDTFbG5NWeBaLwhK8uVuOlW7dwGoM3ttBsQpkDN67rY2cNDwSwNxc3iTDeUSpQ2JUSo
 NcPkf0dU0mZrn6zEps0QSMcNF5DUAeTURpPdaW0crtdG0+h0pxJTPhf1PdCrrcOfRiwA
 uclg==
X-Gm-Message-State: APjAAAXupvcJ+dndTlIZf6EwAoih8OMnrfntuBb9ZC/GMtrBe6penQDs
 zYRqP1Txjxj6jFT0inmc6oqFZhZDN/RsyWoeWyK5NBJfVprwnnXA8z88YlHfH4PBMFIAnGFqG1u
 3hSQLvRSeAb7mTrs=
X-Received: by 2002:a7b:c935:: with SMTP id h21mr6471876wml.173.1580404704100; 
 Thu, 30 Jan 2020 09:18:24 -0800 (PST)
X-Google-Smtp-Source: APXvYqy6+tQ3Tva9D8d393l1+3GFobIGMxM8GfMKxga1T8rJLm7c8riYcxdPVXbsgavMXCF2HgDweQ==
X-Received: by 2002:a7b:c935:: with SMTP id h21mr6471849wml.173.1580404703836; 
 Thu, 30 Jan 2020 09:18:23 -0800 (PST)
Received: from [192.168.1.35] (113.red-83-57-172.dynamicip.rima-tde.net.
 [83.57.172.113])
 by smtp.gmail.com with ESMTPSA id e18sm7832511wrw.70.2020.01.30.09.18.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Jan 2020 09:18:23 -0800 (PST)
Subject: Re: [PATCH v2 04/29] tests/acceptance: Use 'version-min' tag to
 verify QEMU binary version
To: Cornelia Huck <cohuck@redhat.com>
References: <20200129212345.20547-1-philmd@redhat.com>
 <20200129212345.20547-5-philmd@redhat.com>
 <20200130132625.533fb4ca.cohuck@redhat.com>
 <ee877d12-c0a4-4f82-5d59-2e0235158479@redhat.com>
 <20200130180859.43954c22.cohuck@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <1eee2851-8b65-8343-2847-1e6634bae46f@redhat.com>
Date: Thu, 30 Jan 2020 18:18:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200130180859.43954c22.cohuck@redhat.com>
Content-Language: en-US
X-MC-Unique: dEtoiT-bMciFhqoNczeTkQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>, qemu-devel@nongnu.org,
 Denis Plotnikov <dplotnikov@virtuozzo.com>, Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Cc'ing Markus

On 1/30/20 6:08 PM, Cornelia Huck wrote:
> On Thu, 30 Jan 2020 14:28:19 +0100
> Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> wrote:
>=20
>> On 1/30/20 1:26 PM, Cornelia Huck wrote:
>>> On Wed, 29 Jan 2020 22:23:20 +0100
>>> Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> wrote:
>>>   =20
>>>> Introduce the 'version-min' tag.
>>>> Tests can set it to the minimum version of QEMU they require.
>>>> If QEMU is older, the tests will be cancelled (skipped):
>>>>
>>>>     $ python -m avocado --show=3Dapp run tests/acceptance/x86_cpu_mode=
l_versions.py
>>>>      (01/11) X86CPUModelAliases.test_4_0_alias_compatibility: CANCEL: =
Test expects version '4.1' but QEMU binary is '3.1.1' (0.10 s)
>>>>      (02/11) X86CPUModelAliases.test_4_1_alias: CANCEL: Test expects v=
ersion '4.1' but QEMU binary is '3.1.1' (0.10 s)
>>>>      (03/11) X86CPUModelAliases.test_none_alias: CANCEL: Test expects =
version '4.1' but QEMU binary is '3.1.1' (0.10 s)
>>>>      ...
>>>>
>>>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>>>> ---
>>>>    tests/acceptance/avocado_qemu/__init__.py | 18 ++++++++++++++++++
>>>>    1 file changed, 18 insertions(+)
>>>
>>> Hm... this might cause headaches if someone tries to backport tests on
>>> distro versions; but we probably won't be able to test for the feature
>>> in many cases anyway?
>>>   =20
>>
>> Are you saying a distro version might not match upstream version when a
>> feature is introduced? Isn't it the point of versioning? If you are
>> thinking of some case you point me at it so I can improve this patch?
>=20
> Something like the following:
>=20
> - a feature together with a test is introduced in QEMU version n
> - a distro is using m (where m < n), but wants the new feature and
>    backports it
>=20
> If that distro now wants to include the acceptance test as well (to run
> in their internal testing), they need to adapt the version check as
> well, or the test simply won't run. Depending on how this is reported,
> it might not be easily noticed. If the test depends on another feature
> (but the feature does not), it might get a bit more complicated.
>=20
> It's probably not a big problem, but I wanted to point it out.

OK now I understand better.

I wrote that patch having QAPI versioned features in mind, which are=20
versioned/documented.
For example:

   ##
   # @qom-list-types:
   #
   ...
   #
   # Since: 1.1

Now it is true that we add a new feature to a device, we do not document=20
that in QAPI, and I don't see how we can test it via QMP.


