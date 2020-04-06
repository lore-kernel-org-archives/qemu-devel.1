Return-Path: <SRS0=By5p=5W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70143C2BA17
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 18:42:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 45166206C3
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 18:42:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iWuazGS8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45166206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37060 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLWhJ-0004LZ-Fj
	for qemu-devel@archiver.kernel.org; Mon, 06 Apr 2020 14:42:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47431)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <wrampazz@redhat.com>) id 1jLWem-0000wE-H6
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 14:39:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <wrampazz@redhat.com>) id 1jLWel-0007hh-C1
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 14:39:36 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:52381
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <wrampazz@redhat.com>) id 1jLWel-0007hN-9H
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 14:39:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586198375;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DeAWlO5vJfr2ThBmMfaoNKVM9ILwy+uFoNIbMctgBhw=;
 b=iWuazGS8qRrVRtxFSfRs1p6bcrcQeVvGO2E2/a5nrWp5pnASbLmOzicf0tG51V2K/Xrgh9
 rRUJ/e/F0pXnxyc/wSv/9wBIQTvBr9rQosEsBv9fvuehhj+xH1FIleMI4lnYEsFqGOUAX5
 o/npLkZctSPa0kIonsfc5HPxfAbzwmc=
Received: from mail-vk1-f199.google.com (mail-vk1-f199.google.com
 [209.85.221.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-269-9tzWeHD6Pv-GSFUA4MW5_A-1; Mon, 06 Apr 2020 14:39:31 -0400
X-MC-Unique: 9tzWeHD6Pv-GSFUA4MW5_A-1
Received: by mail-vk1-f199.google.com with SMTP id v203so247073vkd.13
 for <qemu-devel@nongnu.org>; Mon, 06 Apr 2020 11:39:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=DeAWlO5vJfr2ThBmMfaoNKVM9ILwy+uFoNIbMctgBhw=;
 b=F9E4JZ4lp6/NCfiP6afhle2wo0oh9SGNWQzZs7PHmvo/u8CxYx+bRIMoguE85SbSkw
 K4Vs4rzmHmAo//zqW6R5S5eUV2KhYE8GUZBFnL72+SWR6kCZ2mbMcHuJQ6aSiBNzN7B/
 rYu8WgMx8cZlGWI9fzXV9AdBQNqow8kkJU4Wj5ISiLtwhFZn8rXou70RE4CAtagstdgw
 UwmUVfr3wUQRynN8KZLF/99S8rQ+/d+Ollg67lhrASY+pQGCbxBG9jky+UQ2ydPqpEM+
 VqLQhFYPvQYw7rwSWAUfCwdb1kY0ryz5wBC5Z1Wq7gyHNnvred7tKdUSnmuiTS5UX/c8
 HXGQ==
X-Gm-Message-State: AGi0PuaYPIsooxk+hSfChzFHYrhpVIo/OzrJYyPXb6IYFElZMBXvEG9F
 y/gIMIjJdCua+w6FjhJV0UXjuHMmqWS4SYIlSDwyt01/MwyW6VV9W0tOrgQhzN8JehZ7DAcuE3q
 rhkd/N6DaFsPmnJoGFeITmTSK/ZMJ7f4=
X-Received: by 2002:a67:fd16:: with SMTP id f22mr981312vsr.48.1586198370985;
 Mon, 06 Apr 2020 11:39:30 -0700 (PDT)
X-Google-Smtp-Source: APiQypK3tJd/LgVCk8qoxg3FgWcI+fvEXlHiYTiL02jxwVat4WKH2mn1hdr7x/GR7yv06Mnj5DdVRJToPx6QQW61NUU=
X-Received: by 2002:a67:fd16:: with SMTP id f22mr981287vsr.48.1586198370671;
 Mon, 06 Apr 2020 11:39:30 -0700 (PDT)
MIME-Version: 1.0
References: <20200403172919.24621-1-philmd@redhat.com>
 <20200403172919.24621-8-philmd@redhat.com>
 <87369gbpgq.fsf@linaro.org> <4b9c706f-b9b0-35c6-457f-e03f746c9287@redhat.com>
 <CAKJDGDZePOW6Hg9P5WMoP93U2kGEO1=CGF0W7X-G-E7bid_8kQ@mail.gmail.com>
 <87r1x0a31t.fsf@linaro.org>
In-Reply-To: <87r1x0a31t.fsf@linaro.org>
From: Willian Rampazzo <wrampazz@redhat.com>
Date: Mon, 6 Apr 2020 15:39:19 -0300
Message-ID: <CAKJDGDaGf2gaMUf_7d0LQbUd8f8tUVWQcggdUGAa=Nz9yoewDQ@mail.gmail.com>
Subject: Re: [PATCH-for-5.1 7/8] .travis.yml: Run fetch-acceptance-assets
 before check-acceptance
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
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
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Apr 6, 2020 at 3:21 PM Alex Benn=C3=A9e <alex.bennee@linaro.org> wr=
ote:
>
>
> Willian Rampazzo <wrampazz@redhat.com> writes:
>
> > On Mon, Apr 6, 2020 at 12:39 PM Philippe Mathieu-Daud=C3=A9
> > <philmd@redhat.com> wrote:
> >>
> >> On 4/6/20 5:31 PM, Alex Benn=C3=A9e wrote:
> >> >
> >> > Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:
> >> >
> >> >> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> >> >> ---
> >> >>   .travis.yml | 2 +-
> >> >>   1 file changed, 1 insertion(+), 1 deletion(-)
> >> >>
> >> >> diff --git a/.travis.yml b/.travis.yml
> >> >> index 2fd63eceaa..c6b32da447 100644
> >> >> --- a/.travis.yml
> >> >> +++ b/.travis.yml
> >> >> @@ -317,7 +317,7 @@ jobs:
> >> >>         dist: bionic
> >> >>         env:
> >> >>           - CONFIG=3D"--enable-tools --target-list=3Daarch64-softmm=
u,alpha-softmmu,arm-softmmu,m68k-softmmu,microblaze-softmmu,mips-softmmu,mi=
ps64el-softmmu,nios2-softmmu,or1k-softmmu,ppc-softmmu,ppc64-softmmu,s390x-s=
oftmmu,sparc-softmmu,x86_64-softmmu,xtensa-softmmu"
> >> >> -        - TEST_CMD=3D"make check-acceptance"
> >> >> +        - TEST_CMD=3D"travis_retry make -j1 fetch-acceptance-asset=
s
> >> >> check-acceptance DEBUG=3D1"
> >> >
> >> > You could use TEST_BUILD_CMD for the fetching of acceptance tests - =
can
> >> > that be done in parallel?
> >
> > If by `parallel` you mean running it with other targets, the
> > fetch-acceptance-assets target can run at any time before the
> > check-acceptance runs, concurrently with different targets. Now, if by
> > `parallel` you mean fetch more than one asset at a time, right now it
> > is not supported by Avocado, assets are fetched one by one, but it is
> > an excellent idea. I have added it to my list.
>
> See the comment I made about the make file. We could expand the
> fetch-acceptance-assets target to have one dependency per python file so
> you could invoke avocado in parallel to fetch the assets for each test
> group in parallel. Of course this works best if the assets mentioned in
> each file are unique otherwise avocado might race with itself.

I see what you mean. About the unique asset definitions, this should
not be a big problem as Avocado downloads the asset on a temporary
file first and then copy it to the target file. In the worst case,
multiple instances of Avocado will download the same asset at the same
time, but just one will make it the target asset. The other instances
will fail, but as one already succeeded, the downside is the time and
bandwidth spent by the other instances.

>
> >> I'd say calling fetch-acceptance-assets parallelized is what seems to
> >> break this Travis job (which is why I enforced -j1), but I'll refer to
> >> Willian here.
> >>
> >
> > As I mentioned above, no problem with running it in parallel to other
> > targets. The errors we saw when you were testing are not related to
> > the parallel run. It should be fixed in the next release of Avocado.
> >
> >> >
> >> > Also no point in -j1 here - it's implied.
> >>
> >> You are right, I wanted to be sure this still work even if the globlal
> >> script running the tests is updated. But the correct fix is probably t=
o
> >> use .NOTPARALLEL in the fetch-acceptance-assets rule in the previous p=
atch.
> >>
> >> >
> >> >>           - CACHE_NAME=3D"${TRAVIS_BRANCH}-linux-gcc-acceptance"
> >> >>         after_script:
> >> >>           - python3 -c 'import json; r =3D json.load(open("tests/re=
sults/latest/results.json")); [print(t["logfile"]) for t in r["tests"] if t=
["status"] not in ("PASS", "SKIP")]' | xargs cat
> >> >
> >> >
> >>
>
>
> --
> Alex Benn=C3=A9e
>


