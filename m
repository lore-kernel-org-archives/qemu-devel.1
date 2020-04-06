Return-Path: <SRS0=By5p=5W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C47FC2BA17
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 18:35:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 02701206C3
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 18:35:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J6Cy1uDv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02701206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36866 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLWaT-0002jG-5t
	for qemu-devel@archiver.kernel.org; Mon, 06 Apr 2020 14:35:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38847)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <wrampazz@redhat.com>) id 1jLVye-0000Oh-2B
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 13:56:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <wrampazz@redhat.com>) id 1jLVyc-0007qX-Tk
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 13:56:03 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:31029
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <wrampazz@redhat.com>) id 1jLVyc-0007qP-Qs
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 13:56:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586195762;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+ktaCtJpxQl2oZs+fcyf/bsZk1updY7wGcISlm7FYWk=;
 b=J6Cy1uDvXSV8Mf4OaGPZTpzuX4koT9EkYA3RD/CeQzUpv7r5VWcp+rZ7SldCoVPnpISzmf
 Zaqd8oodZV6ifzsiacYP0hQJk580M8xkMNjZdgdScgOJP4/ek7oV+/eFp7+CrSLoNhQKSP
 31Q1Itw/DoDTJyktFHzud/z56cDHyFk=
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com
 [209.85.217.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-99-jtj6yxNCPKykA0VY8eavmg-1; Mon, 06 Apr 2020 13:56:00 -0400
X-MC-Unique: jtj6yxNCPKykA0VY8eavmg-1
Received: by mail-vs1-f71.google.com with SMTP id w2so75713vsf.7
 for <qemu-devel@nongnu.org>; Mon, 06 Apr 2020 10:55:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=+ktaCtJpxQl2oZs+fcyf/bsZk1updY7wGcISlm7FYWk=;
 b=Nd6Z802jraYSSn6TgUptJZlGegoBYFd0DlwoW9Qs6G3TDBJHFyeFAqFWcyfgTpj9gw
 XNbkjxwUEuM93OFfm8Wj/5pM1Y9SR/D6YM3uZ/YjL4T+dGGFsV49SgbUcHhu+npDctk8
 RL5HWNyeTuE1rj9yThRSDB9qE03CSOjeS4JVK7cjQ1sacCc127zvy+8ZwUoKDqnoSasE
 FgA/PHPEVrVg3hTa0XDrwAk23pSlBdAJnjiYl+swksmK6pO5M2YNtJZujUda5PWJYpuz
 qdZuREQkMjkFLilbeBPmspQmngFatXY7u92QDANk0Qw4DTaQJ81F4Zi0a6tVPp6oaVTd
 srVA==
X-Gm-Message-State: AGi0PuY52YlOJ9np0MVj7C42CtzQHDvIZDLaMzzarS1n+eswCPVrD5aR
 2wKD54s8RmMa58nFo8VRVNZMxDoPNC/u5Ob1pVLOQtzKwPZiLmwOrI06SCXZmS94EDPN7/Yzlx/
 jykadMhy+7qlkGxJ9DTKoeRvXdOX011w=
X-Received: by 2002:a1f:7f1d:: with SMTP id o29mr304356vki.101.1586195759418; 
 Mon, 06 Apr 2020 10:55:59 -0700 (PDT)
X-Google-Smtp-Source: APiQypLq/cV0d65HFZKjGaJmBGNrZHZ27UPcpEEEXApaJfUY/UIn3XiMRljyjzTb6U9YQbcwiG4y7rG5k4DUbdQ4+pY=
X-Received: by 2002:a1f:7f1d:: with SMTP id o29mr304329vki.101.1586195759128; 
 Mon, 06 Apr 2020 10:55:59 -0700 (PDT)
MIME-Version: 1.0
References: <20200403172919.24621-1-philmd@redhat.com>
 <20200403172919.24621-8-philmd@redhat.com>
 <87369gbpgq.fsf@linaro.org> <4b9c706f-b9b0-35c6-457f-e03f746c9287@redhat.com>
In-Reply-To: <4b9c706f-b9b0-35c6-457f-e03f746c9287@redhat.com>
From: Willian Rampazzo <wrampazz@redhat.com>
Date: Mon, 6 Apr 2020 14:55:48 -0300
Message-ID: <CAKJDGDZePOW6Hg9P5WMoP93U2kGEO1=CGF0W7X-G-E7bid_8kQ@mail.gmail.com>
Subject: Re: [PATCH-for-5.1 7/8] .travis.yml: Run fetch-acceptance-assets
 before check-acceptance
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: Fam Zheng <fam@euphon.net>, Eduardo Habkost <ehabkost@redhat.com>,
 KONRAD Frederic <frederic.konrad@adacore.com>,
 qemu-devel <qemu-devel@nongnu.org>, Fabien Chouteau <chouteau@adacore.com>,
 Kamil Rytarowski <kamil@netbsd.org>, qemu-ppc@nongnu.org,
 Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Apr 6, 2020 at 12:39 PM Philippe Mathieu-Daud=C3=A9
<philmd@redhat.com> wrote:
>
> On 4/6/20 5:31 PM, Alex Benn=C3=A9e wrote:
> >
> > Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:
> >
> >> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> >> ---
> >>   .travis.yml | 2 +-
> >>   1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/.travis.yml b/.travis.yml
> >> index 2fd63eceaa..c6b32da447 100644
> >> --- a/.travis.yml
> >> +++ b/.travis.yml
> >> @@ -317,7 +317,7 @@ jobs:
> >>         dist: bionic
> >>         env:
> >>           - CONFIG=3D"--enable-tools --target-list=3Daarch64-softmmu,a=
lpha-softmmu,arm-softmmu,m68k-softmmu,microblaze-softmmu,mips-softmmu,mips6=
4el-softmmu,nios2-softmmu,or1k-softmmu,ppc-softmmu,ppc64-softmmu,s390x-soft=
mmu,sparc-softmmu,x86_64-softmmu,xtensa-softmmu"
> >> -        - TEST_CMD=3D"make check-acceptance"
> >> +        - TEST_CMD=3D"travis_retry make -j1 fetch-acceptance-assets
> >> check-acceptance DEBUG=3D1"
> >
> > You could use TEST_BUILD_CMD for the fetching of acceptance tests - can
> > that be done in parallel?

If by `parallel` you mean running it with other targets, the
fetch-acceptance-assets target can run at any time before the
check-acceptance runs, concurrently with different targets. Now, if by
`parallel` you mean fetch more than one asset at a time, right now it
is not supported by Avocado, assets are fetched one by one, but it is
an excellent idea. I have added it to my list.

>
> I'd say calling fetch-acceptance-assets parallelized is what seems to
> break this Travis job (which is why I enforced -j1), but I'll refer to
> Willian here.
>

As I mentioned above, no problem with running it in parallel to other
targets. The errors we saw when you were testing are not related to
the parallel run. It should be fixed in the next release of Avocado.

> >
> > Also no point in -j1 here - it's implied.
>
> You are right, I wanted to be sure this still work even if the globlal
> script running the tests is updated. But the correct fix is probably to
> use .NOTPARALLEL in the fetch-acceptance-assets rule in the previous patc=
h.
>
> >
> >>           - CACHE_NAME=3D"${TRAVIS_BRANCH}-linux-gcc-acceptance"
> >>         after_script:
> >>           - python3 -c 'import json; r =3D json.load(open("tests/resul=
ts/latest/results.json")); [print(t["logfile"]) for t in r["tests"] if t["s=
tatus"] not in ("PASS", "SKIP")]' | xargs cat
> >
> >
>


