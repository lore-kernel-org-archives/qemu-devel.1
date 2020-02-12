Return-Path: <SRS0=xDnh=4A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9AADC2BA83
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 16:52:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 74AA021569
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 16:52:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U2A8BTuk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74AA021569
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40430 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1vFh-0001SV-Mv
	for qemu-devel@archiver.kernel.org; Wed, 12 Feb 2020 11:52:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37858)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j1vF7-00010C-9m
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 11:52:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j1vF5-0004xF-5v
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 11:52:04 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:49759
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j1vF4-0004vM-Si
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 11:52:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581526321;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=toe4BjHH54jWEJIIy/UXqtIJdBa4oxQY7Nao6USFnDc=;
 b=U2A8BTukSZhaUaIEGWZFOJLFwiZEAC0Fn1sV1CR+cL8Wdl2S+WsRzbPpXRXfkDh6C5nR1i
 eddswiTHcmV8jVcukVI91NFDZ9+NHaicYN/06QM97DgzCckqtb20Nn6wX4AOCq/6PJc+XA
 Ayqym2kYh2WvzT7mrtokerReuegK6ZM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-375-J3PEHnlMOE-urghzVc5GtA-1; Wed, 12 Feb 2020 11:51:51 -0500
Received: by mail-wm1-f69.google.com with SMTP id g26so949644wmk.6
 for <qemu-devel@nongnu.org>; Wed, 12 Feb 2020 08:51:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Bmj1HjtlA0nso458bDh9QxOkDXHjGZe6SMViR4xHzRU=;
 b=TkiRq9U2UQerbk44+TwcC/Np7eRfkGVT2XI3DSfZXK+sCJrYNVoaIvcN3faoOrMlkA
 Ye1q6f4DYnxYFG23iJaahsMz9rZ/FIkAkU1zcAcwh9K8Us3BHHJRjWidfHmYnfzjfrgA
 EEfpkiQ9vB76fe0+S9PzpfD9qiDT/KaUpLFvDuXqRr8rrxK9KzbPpaEVAgj6v7YRBUi6
 b9tjgAHT9EfAAA6EGNHBJwS/+S0GNNDuYY7Jb3ydkXPfcjl8m7jbanu8vdO1+pGiLDyf
 FZRUErv1Eq20849sEeJs0C0UnbwXM8aL7lCPNjR5DgpF6F79Sss7gPf/R9qYy1lS6I5w
 h4IQ==
X-Gm-Message-State: APjAAAXV4Zc6bQOh0mgNjVqIQlEOneEXMOzoSHo/EhjNpLZzj/+uhuUj
 NxdO/rVunBd7kxrY7I4ePcgj3OWIYNqymOtIse6lmp9bAhAF3H76J1iGhBiIWaYJdHkPRjc+L0u
 zp6fUNqrqsWtFA3c=
X-Received: by 2002:adf:e68d:: with SMTP id r13mr15947127wrm.349.1581526309919; 
 Wed, 12 Feb 2020 08:51:49 -0800 (PST)
X-Google-Smtp-Source: APXvYqym45x/Km+Q6kp/cs5HG2Q9R1RxXwH9oPr00YIZFgEqcMl5YFze3Y2h6Z0sY5eGPaVyIaYmOA==
X-Received: by 2002:adf:e68d:: with SMTP id r13mr15947104wrm.349.1581526309692; 
 Wed, 12 Feb 2020 08:51:49 -0800 (PST)
Received: from [192.168.1.35] (78.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.78])
 by smtp.gmail.com with ESMTPSA id x6sm1269094wmi.44.2020.02.12.08.51.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Feb 2020 08:51:48 -0800 (PST)
Subject: Re: [PATCH] docs: Fix virtiofsd.1 location
To: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
References: <1908428819.7192207.1581512184275.JavaMail.zimbra@redhat.com>
 <1608747495.7195569.1581513386780.JavaMail.zimbra@redhat.com>
 <CAFEAcA-F-F1C4si7OXNkMnzE+9DHXtNnvCYv1eTx-nEpb4_OZw@mail.gmail.com>
 <20200212142832.GC434563@redhat.com>
 <CAFEAcA_VsdWJELxDuMJW9iaRsB-At_Dyf3Z6paOHWEp+VEhSgw@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <625cd959-6031-0a27-f25b-e2be6dc7ec3a@redhat.com>
Date: Wed, 12 Feb 2020 17:51:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_VsdWJELxDuMJW9iaRsB-At_Dyf3Z6paOHWEp+VEhSgw@mail.gmail.com>
Content-Language: en-US
X-MC-Unique: J3PEHnlMOE-urghzVc5GtA-1
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
Cc: Miroslav Rezanina <mrezanin@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/12/20 5:02 PM, Peter Maydell wrote:
> On Wed, 12 Feb 2020 at 14:28, Daniel P. Berrang=C3=A9 <berrange@redhat.co=
m> wrote:
>>
>> On Wed, Feb 12, 2020 at 02:18:19PM +0000, Peter Maydell wrote:
>>> On Wed, 12 Feb 2020 at 13:16, Miroslav Rezanina <mrezanin@redhat.com> w=
rote:
>>>>
>>>> Patch 6a7e2bbee5 docs: add virtiofsd(1) man page introduced new man
>>>> page virtiofsd.1. Unfortunately, wrong file location is used as
>>>> source for install command. This cause installation of docs fail.
>>>>
>>>> Fixing wrong location so installation is successful.
>>>>
>>>> Signed-off-by: Miroslav Rezanina <mrezanin@redhat.com>
>>>
>>> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
>>>
>>> I noticed this in review of v1 of the patch
>>> https://patchew.org/QEMU/20200127162514.56784-1-stefanha@redhat.com/
>>> but missed that it hadn't been fixed in v2/v3.
>>
>> How come the mistake didn't break any of our CI ?  Looks like it
>> should have failed due to non-existing source file

We stopped testing in-tree builds 2 months ago:

commit bc4486fb233573e77b6e9ad6d6379afb5e37ad8c
Author: Paolo Bonzini <pbonzini@redhat.com>
Date:   Wed Dec 11 15:33:49 2019 +0100

     ci: build out-of-tree

     Most developers are using out-of-tree builds and it was discussed=20
in the past
     to only allow those.  To prepare for the transition, use=20
out-of-tree builds
     in all continuous integration jobs.

>=20
> I imagine all our CI setups use separate-build-dir and don't
> test 'make install'. This only shows up if you do build-in-source-tree
> and then 'make install'. (In a separate-build-dir setup, the
> MANUAL_BUILDDIR is the same as the actual build dir,
> which is the same as make's current working directory, so
> forgetting it in the install rune doesn't matter. In a build from
> the source tree, Sphinx requires the output to be to a
> different directory than the source, so we have to create
> a subdirectory to be the MANUAL_BUILDDIR.)
>=20
> thanks
> -- PMM
>=20


