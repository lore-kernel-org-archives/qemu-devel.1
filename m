Return-Path: <SRS0=6hMH=ZM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15CE1C432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 13:36:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D3FB1224D2
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 13:36:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TU/FjKi+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3FB1224D2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58180 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXQA2-0005ZD-3K
	for qemu-devel@archiver.kernel.org; Wed, 20 Nov 2019 08:36:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41519)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lvivier@redhat.com>) id 1iXQ9I-0004p3-9e
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 08:36:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <lvivier@redhat.com>) id 1iXQ9F-0002NB-Aw
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 08:35:58 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:29858
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <lvivier@redhat.com>) id 1iXQ9F-0002Mt-7C
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 08:35:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574256956;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=WVZeCJfxqtQwM+nOXYocsl0+wSzGuNBvNZzX2aG8yo8=;
 b=TU/FjKi+8ph6ANn4wsdd9QN0JLSNXaak47qjqkYhZxfiewX7jvwz3rGxdnx/82DhcRcYg7
 dmUGsJ3OT0yXmWD/yTMuwpHv/mYHexW8U2dIg6zYOunFuKUok8YhjhgZ6Dicohf8MA410L
 ZzKjddbsrm04kdLOhEU3kWCGATjfhFw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-264-xgJTv3EPORqQTDZVHDZb_Q-1; Wed, 20 Nov 2019 08:35:52 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 38DE5593A0;
 Wed, 20 Nov 2019 13:35:51 +0000 (UTC)
Received: from [10.36.116.216] (ovpn-116-216.ams2.redhat.com [10.36.116.216])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CF93466D46;
 Wed, 20 Nov 2019 13:35:48 +0000 (UTC)
Subject: Re: [PATCH] spapr: Fix VSMT mode when it is not supported by the
 kernel
To: Greg Kurz <groug@kaod.org>
References: <20191108154035.12913-1-lvivier@redhat.com>
 <20191108174759.2d4040f1@bahia.lan> <20191119010012.GI5582@umbus.fritz.box>
 <caa35299-c928-a968-83b5-842d000f0242@redhat.com>
 <20191119164526.0e980a37@bahia.lan> <20191120043653.GG5582@umbus.fritz.box>
 <cb8f7dc7-d6db-6bd9-e825-1ade7d89cdd9@redhat.com>
 <0c1f57ac-0823-4268-429b-d1aee8f7f8d5@redhat.com>
 <20191120134720.3221a6f4@bahia.lan>
From: Laurent Vivier <lvivier@redhat.com>
Autocrypt: addr=lvivier@redhat.com; prefer-encrypt=mutual; keydata=
 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
 D+Ofp0T3KOr1RUHvCZoLURfFhSQ=
Message-ID: <17a17c2f-327a-23e9-8da0-0deedeb47779@redhat.com>
Date: Wed, 20 Nov 2019 14:35:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191120134720.3221a6f4@bahia.lan>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: xgJTv3EPORqQTDZVHDZb_Q-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: =?UTF-8?B?THVrw6HFoSBEb2t0b3I=?= <ldoktor@redhat.com>,
 Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>, qemu-ppc@nongnu.org,
 clg@kaod.org, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 20/11/2019 13:47, Greg Kurz wrote:
> On Wed, 20 Nov 2019 12:28:19 +0100
> Laurent Vivier <lvivier@redhat.com> wrote:
>=20
>> On 20/11/2019 10:00, Laurent Vivier wrote:
>>> On 20/11/2019 05:36, David Gibson wrote:
>>>> On Tue, Nov 19, 2019 at 04:45:26PM +0100, Greg Kurz wrote:
>>>>> On Tue, 19 Nov 2019 15:06:51 +0100
>>>>> Laurent Vivier <lvivier@redhat.com> wrote:
>>>>>
>>>>>> On 19/11/2019 02:00, David Gibson wrote:
>>>>>>> On Fri, Nov 08, 2019 at 05:47:59PM +0100, Greg Kurz wrote:
>>>>>>>> On Fri,  8 Nov 2019 16:40:35 +0100
>>>>>>>> Laurent Vivier <lvivier@redhat.com> wrote:
>>>>>>>>
>>>>>>>>> Commit 29cb4187497d sets by default the VSMT to smp_threads,
>>>>>>>>> but older kernels (< 4.13) don't support that.
>>>>>>>>>
>>>>>>>>> We can reasonably restore previous behavior with this kernel
>>>>>>>>> to allow to run QEMU as before.
>>>>>>>>>
>>>>>>>>> If VSMT is not supported, VSMT will be set to MAX(8, smp_threads)
>>>>>>>>> as it is done for previous machine types (< pseries-4.2)
>>>>>>>>>
>>>>>>>>
>>>>>>>> It is usually _bad_ to base the machine behavior on host capabilit=
ies.
>>>>>>>> What happens if we migrate between an older kernel and a recent on=
e ?
>>>>>>>
>>>>>>> Right.  We're really trying to remove instaces of such behaviour.  =
I'd
>>>>>>> prefer to completely revert Greg's original patch than to re-introd=
uce
>>>>>>> host configuration dependency into the guest configuration..
>>>>>>>
>>>>>>>> I understand this is to fix tests/migration-test on older kernels.
>>>>>>>> Couldn't this be achieved with migration-test doing some introspec=
tion
>>>>>>>> and maybe pass vsmt=3D8 on the QEMU command line ?
>>>>>>>
>>>>>>> ..adjusting the test case like this might be a better idea, though.
>>>>>>>
>>>>>>> What's the test setup where we're using the old kernel?  I really o=
nly
>>>>>>> applied the original patch on the guess that we didn't really care
>>>>>>> about kernels that old.  The fact you've hit this in practice makes=
 me
>>>>>>> doubt that assumption.
>>>>>>>
>>>>>>
>>>>>> The way to fix the tests is to add "-smp threads=3D8" on the command=
 line
>>>>>> (for all tests, so basically in qtest_init_without_qmp_handshake(), =
and
>>>>>> it will impact all the machine types), and we have to check if it is
>>>>>
>>>>> Ohhh... it isn't possible to initialize Qtest with machine specific
>>>>> properties ? That's a bit unfortunate :-\
>>>>
>>>> Uhh... I don't see why we can't.  Couldn't we just put either -machine
>>>> vsmt=3D8 or -smp 8 into the cmd_src / cmd_dst printfs() in the
>>>> strcmp(arch, "ppc64") case?
>>>
>>> Yes, but we need to do that to all other tests that fail. test-migratio=
n
>>> is not the only one impacted by the problem (we have also pxe-test), so
>>> it's why I thought to fix the problem in a generic place.
>>>
>>> But it seems there are only this couple of tests that are impacted so I
>>> can modify both instead. I think only tests that really start CPU have
>>> the problem.
>>>
>>> I'm going to send a patch to fix that.
>>
>> And again, it's a little bit more complicated than expected: setting
>> vsmt to 8 works only with kvm_hv, but breaks in case of TCG or kvm_pr.
>> So the test must check what is in use...
>>
>=20
> AFAICT, migration-test explicitly skip tests if kvm_hv isn't present.
>=20
>     /*
>      * On ppc64, the test only works with kvm-hv, but not with kvm-pr and=
 TCG
>      * is touchy due to race conditions on dirty bits (especially on PPC =
for
>      * some reason)
>      */
>     if (g_str_equal(qtest_get_arch(), "ppc64") &&
>         access("/sys/module/kvm_hv", F_OK)) {
>         g_test_message("Skipping test: kvm_hv not available");
>         return g_test_run();
>     }
>=20
> and I don't see any error in pxe-test if I force tcg and vsmt=3D8.
>=20
> What error do you see with your testing ?

In fact, you're right, it works with vsmt=3D8 and it's better.

Laurent


