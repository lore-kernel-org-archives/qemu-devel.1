Return-Path: <SRS0=8p31=3Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FBB0C2D0DB
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 14:08:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B6CE2071E
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 14:08:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MyHzTPk1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B6CE2071E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45812 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iw53Y-0003Qd-Df
	for qemu-devel@archiver.kernel.org; Mon, 27 Jan 2020 09:08:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58159)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <wainersm@redhat.com>) id 1iw51n-0000LM-W1
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 09:06:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <wainersm@redhat.com>) id 1iw51l-0003kV-Fg
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 09:06:11 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:55259
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <wainersm@redhat.com>) id 1iw51l-0003kB-CH
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 09:06:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580133969;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RKpx2tERluPKbOBPaJjvyC/oGqoJkXkMPjh5U9IeBtk=;
 b=MyHzTPk1fhvJIRITvrxkHRjG4K9WZm7KGYbWeR5JehVWCnD+mh4G0z1djGnhwGw9imYL72
 2X9yu9CPWvWNxOiOS967NsZz7xd11bXT/e3OEWXNyLudn3kYiVfjwxxnIzlbxp/Yryi4Sx
 bIIXXme3uCPvlR0ki1/Q2fmYw++jFOg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-200-ea3GnvWPPLyPO4Rd2jgukQ-1; Mon, 27 Jan 2020 09:06:05 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E5CA018A8CAE;
 Mon, 27 Jan 2020 14:06:03 +0000 (UTC)
Received: from localhost.localdomain (ovpn-116-27.gru2.redhat.com
 [10.97.116.27])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 288D88705B;
 Mon, 27 Jan 2020 14:05:58 +0000 (UTC)
Subject: Re: [PATCH] tests/acceptance: Add boot tests for some of the QEMU
 advent calendar images
To: Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?=
 <f4bug@amsat.org>, qemu-devel@nongnu.org
References: <20200124170325.30072-1-thuth@redhat.com>
 <8f085a1a-b9df-29d4-db51-eb345a44a971@redhat.com>
 <1f564925-2ee1-ab17-a946-f9bcd656926f@redhat.com>
 <4d5fe645-0652-893f-4e6b-2929849d3cdc@amsat.org>
 <168c4f7b-fda5-2d9f-15b8-7100d5b0974d@redhat.com>
From: Wainer dos Santos Moschetta <wainersm@redhat.com>
Message-ID: <a7b33bbd-677b-b2e1-ec8b-aa0289510a8d@redhat.com>
Date: Mon, 27 Jan 2020 12:05:57 -0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <168c4f7b-fda5-2d9f-15b8-7100d5b0974d@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: ea3GnvWPPLyPO4Rd2jgukQ-1
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
Cc: qemu-ppc@nongnu.org, qemu-arm@nongnu.org,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 1/27/20 8:38 AM, Thomas Huth wrote:
> On 25/01/2020 19.38, Philippe Mathieu-Daud=C3=A9 wrote:
>> On 1/25/20 5:43 PM, Thomas Huth wrote:
>>> On 24/01/2020 22.28, Wainer dos Santos Moschetta wrote:
>>>> On 1/24/20 3:03 PM, Thomas Huth wrote:
>>>>> The 2018 edition of the QEMU advent calendar 2018 featured Linux imag=
es
>>>>> for various non-x86 machines. We can use them for a boot tests in our
>>>>> acceptance test suite.
>> Excellent idea!
>>
>>>>> Let's also make sure that we build the corresponding machines in Trav=
is,
>>>>> and while we're there, drop the superfluous --python parameter (pytho=
n3
>>>>> is now the only supported version anyway).
>> I'd rather see this change as another commit.
> I thought so, too, often it is good to separate stuff into separate
> commits, but in this case, it's not source code but just the CI yml
> file, and the change is really trivial, so it rather sounds like
> superfluous churn to me in this case to do it in a separate patch...
>
>>>> Yes, please, removal of --python was in my wish list.
>>>>
>>>>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>>>>> ---
>>>>>  =C2=A0 .travis.yml=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 2 +-
>>>>>  =C2=A0 tests/acceptance/boot_linux_console.py | 96 +++++++++++++++++=
+++++++++
>>>>>  =C2=A0 2 files changed, 97 insertions(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/.travis.yml b/.travis.yml
>>>>> index 6c1038a0f1..73ca12c921 100644
>>>>> --- a/.travis.yml
>>>>> +++ b/.travis.yml
>>>>> @@ -268,7 +268,7 @@ matrix:
>>>>>  =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # Acceptance (Functional) test=
s
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - env:
>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - CONFIG=3D"--python=3D/u=
sr/bin/python3
>>>>> --target-list=3Dx86_64-softmmu,mips-softmmu,mips64el-softmmu,aarch64-=
softmmu,arm-softmmu,s390x-softmmu,alpha-softmmu,ppc-softmmu,ppc64-softmmu,m=
68k-softmmu,sparc-softmmu"
>>>>>
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -
>>>>> CONFIG=3D"--target-list=3Daarch64-softmmu,alpha-softmmu,arm-softmmu,m=
68k-softmmu,microblaze-softmmu,mips-softmmu,mips64el-softmmu,nios2-softmmu,=
or1k-softmmu,ppc-softmmu,ppc64-softmmu,s390x-softmmu,sparc-softmmu,x86_64-s=
oftmmu,xtensa-softmmu"
>>>>>
>>>>
>>>> Perhaps use MAIN_SOFTMMU_TARGETS in only append the other targets, lik=
e:
>>>>
>>>> --target-list=3D${MAIN_SOFTMMU_TARGETS},alpha-softmmu,sparc-softmmu,..=
..
>>> Not sure ... while it is a nice way to shorten the line here, it adds a
>>> dependency to that variable ... and MAIN_SOFTMMU_TARGETS has been chang=
ed
>>> a couple of times during the course of time, so we might risk to lose
>>> some testing coverage here in case someone removes a target from
>>> MAIN_SOFTMMU_TARGETS but forgets to add it here again...? I think we
>>> should better use the explicit list here instead.
>> Maybe related: "Split enterprise vs. hobbyist acceptance test job"
>> https://www.mail-archive.com/qemu-devel@nongnu.org/msg644683.html
> I guess naming/splitting is hard in this case ... many targets contain
> both, "enterprise" and "hobbyist" machines ... and as long as the Travis
> job runs reasonably fast, it's also not really necessary to split it.
> The only real ugliness is the very long line - I haven't found a way yet
> to correctly wrap this in the YML file to multiple lines .... does
> anybody know how to do this in YML?


Try to break the lines with '\' (note: next line should not be=20
indented). It worked out on following code:

[wainersm@localhost ~]$ cat /tmp/foo.py
import yaml

yml=3D"""
matrix:
 =C2=A0 include:
 =C2=A0=C2=A0=C2=A0 - env:
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - CONFIG=3D"-target-list=3Dx86_64-softmmu,\
mips-softmmu,mips64el-softmmu"
"""
print(yaml.safe_load(yml))
[wainersm@localhost ~]$ python3 /tmp/foo.py
{'matrix': {'include': [{'env':=20
['CONFIG=3D"-target-list=3Dx86_64-softmmu,mips-softmmu,mips64el-softmmu"']}=
]}}

>
>> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>> Tested-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> Thanks!
>
>   Thomas


