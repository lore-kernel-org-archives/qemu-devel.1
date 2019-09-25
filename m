Return-Path: <SRS0=SZz4=XU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C84DC432C2
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 10:22:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 003C82082F
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 10:22:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="vlSbzP4N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 003C82082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nongnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47958 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iD4Qr-0007gF-US
	for qemu-devel@archiver.kernel.org; Wed, 25 Sep 2019 06:22:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39716)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <sameid@google.com>) id 1iD4Pu-00079R-7K
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 06:21:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <sameid@google.com>) id 1iD4Ps-00063F-Rn
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 06:21:02 -0400
Received: from mail-qt1-x842.google.com ([2607:f8b0:4864:20::842]:38747)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <sameid@google.com>) id 1iD4Ps-00062o-L5
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 06:21:00 -0400
Received: by mail-qt1-x842.google.com with SMTP id j31so5870210qta.5
 for <qemu-devel@nongnu.org>; Wed, 25 Sep 2019 03:21:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=nVKLmtvT4eegJ7wbFN1YfHwRUscJLPrY0SNwAaz79io=;
 b=vlSbzP4N6R+upGZ0a/EDBvbLIow8C+B+pcZ5VwADw6e3599Aci5tgt3BY6QglMcL8x
 OQKz/0mkPp4YOm8p1Syc8Fkh8sHkCYMDxt0GUgwyHJK6tngiDTxvnyqu9iE3pvaLhIRZ
 rVlKzeUqNnOJQ1aFUxjE9o54YNI354Yq7cNZ2jZNqLM1Hu2VYD6De3IF1TqCNpIYA4yu
 H89Edo57jHebUglQs4J9WmzTrJhLM0LivFmamtVGgkdWX4fFpR9e5D9RGuBvibA7+E/U
 eZO8YybBa3fz3hn4GTTEc7vI68+OMEkVsv2bmikzJR/qbEQoY1RxJ4WXjmG1kQd+H/bl
 ujXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=nVKLmtvT4eegJ7wbFN1YfHwRUscJLPrY0SNwAaz79io=;
 b=SOSm0735o5Fwkbih0qG0JIhH80HUJHu1uaX8GajTBYmzNPfmFPjiBq3VczbpAFRmSw
 DfxoVqxd/m9+VlKfQ7qIsUmPt3tBNYMnDFzoRhrnlU2CdMg70n8r8PKikfHJn4PPLYi3
 0W5E6GY0s2k4/vO7QPHmMYKvCDe7zuQZK3y/pjqigqheo2doZDidtaMblu5ZIEIQ9CZb
 jhHBFUls6Le751k/ADyBYfFsOZns/450hpV4O/Y/DblJAyH2vyQ2aowCKPCtwXrFVgDH
 ySyAALtQX/hH/E9R2BQtE5B5xBZeZXq5YFdLRvUGnKoKYlfasDM/r2vR53fUc9qAgKdB
 gtHg==
X-Gm-Message-State: APjAAAWwU/UZvW834W2e77RDlx6tmOEIy7bh/39yg54TY9Yl5BTIR81H
 Cnr/wCXaokT+599rkb1SW/EYcft5rK6bbt4lCOrc0Q==
X-Google-Smtp-Source: APXvYqxd6ff5nbIaGBKkRFaZy5M82NXzBWR2codAvNH7J7kyzAf3P275kH5Zw+mvRq34bMVWsay3tAi5SYoHPteZh80=
X-Received: by 2002:ac8:611a:: with SMTP id a26mr7995514qtm.68.1569406859256; 
 Wed, 25 Sep 2019 03:20:59 -0700 (PDT)
MIME-Version: 1.0
References: <20190827082427.64280-1-sameid@google.com>
 <474297a9-f051-8068-ee62-21f09a6269eb@redhat.com>
 <82459d98-4586-37f7-eb6b-ebe61618fe44@redhat.com>
In-Reply-To: <82459d98-4586-37f7-eb6b-ebe61618fe44@redhat.com>
Date: Wed, 25 Sep 2019 13:20:48 +0300
Message-ID: <CAFr6bUkb2RB2rP0xjZb7mDEVFCeYoFLhavheNx2C=OBVXz-qFQ@mail.gmail.com>
Subject: Re: [Qemu-block] [PATCH v6 0/8] Add Qemu to SeaBIOS LCHS interface
To: Thomas Huth <thuth@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000005af6cf05935e02df"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::842
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
Cc: kwolf@redhat.com, qemu-block@nongnu.org, seabios@seabios.org,
 qemu-devel@nongnu.org, Kevin OConnor <kevin@koconnor.net>,
 liran.alon@oracle.com, kraxel@redhat.com, John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Reply-to: Sam Eiderman <sameid@google.com>
From: Sam Eiderman via <qemu-devel@nongnu.org>

--0000000000005af6cf05935e02df
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks Thomas,

Resubmitting the tests, all other code will remain the same.

Sam

On Wed, Sep 25, 2019 at 10:58 AM Thomas Huth <thuth@redhat.com> wrote:

> On 24/09/2019 20.49, John Snow wrote:
> > Nobody was making movement on this patch series, and in response to Max
> > acking the whole series, I was just going to send a pull request for th=
e
> > whole thing and see who barked, because nobody likes or hates this
> > series enough to offer any feedback.
> >
> > Unfortunately, it's rotted on the vine a bit and has some conflicts wit=
h
> > the testing infrastructure now:
> >
> > /home/jhuston/src/qemu.git/ide/tests/hd-geo-test.c: In function
> > =E2=80=98test_override=E2=80=99:
> > /home/jhuston/src/qemu.git/ide/tests/hd-geo-test.c:732:5: error:
> > implicit declaration of function =E2=80=98qtest_start=E2=80=99
> > [-Werror=3Dimplicit-function-declaration]
> >   732 |     qtest_start(joined_args);
> >
> >
> > You can jump right to the test by invoking it like this:
> >
> >> export QTEST_QEMU_BINARY=3Dx86_64-softmmu/qemu-system-x86_64
> >> make tests/hd-geo-test
> >
> > It looks like some definitions got moved out from under our feet, but
> > hopefully it won't take long to rectify.
>
> Please replace qtest_start() with qts =3D qtest_init() and qtest_end()
> with qtest_quit(qts).
>
> See this commit for some more details:
>
>  https://git.qemu.org/?p=3Dqemu.git;a=3Dcommitdiff;h=3D44c2364aaa5e366c4
>
>   Thomas
>

--0000000000005af6cf05935e02df
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Thanks Thomas,<div><br></div><div>Resubmitting the tests, =
all other code will remain the same.</div><div><br></div><div>Sam</div></di=
v><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On W=
ed, Sep 25, 2019 at 10:58 AM Thomas Huth &lt;<a href=3D"mailto:thuth@redhat=
.com">thuth@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_q=
uote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,2=
04);padding-left:1ex">On 24/09/2019 20.49, John Snow wrote:<br>
&gt; Nobody was making movement on this patch series, and in response to Ma=
x<br>
&gt; acking the whole series, I was just going to send a pull request for t=
he<br>
&gt; whole thing and see who barked, because nobody likes or hates this<br>
&gt; series enough to offer any feedback.<br>
&gt; <br>
&gt; Unfortunately, it&#39;s rotted on the vine a bit and has some conflict=
s with<br>
&gt; the testing infrastructure now:<br>
&gt; <br>
&gt; /home/jhuston/src/qemu.git/ide/tests/hd-geo-test.c: In function<br>
&gt; =E2=80=98test_override=E2=80=99:<br>
&gt; /home/jhuston/src/qemu.git/ide/tests/hd-geo-test.c:732:5: error:<br>
&gt; implicit declaration of function =E2=80=98qtest_start=E2=80=99<br>
&gt; [-Werror=3Dimplicit-function-declaration]<br>
&gt;=C2=A0 =C2=A0732 |=C2=A0 =C2=A0 =C2=A0qtest_start(joined_args);<br>
&gt; <br>
&gt; <br>
&gt; You can jump right to the test by invoking it like this:<br>
&gt; <br>
&gt;&gt; export QTEST_QEMU_BINARY=3Dx86_64-softmmu/qemu-system-x86_64<br>
&gt;&gt; make tests/hd-geo-test<br>
&gt; <br>
&gt; It looks like some definitions got moved out from under our feet, but<=
br>
&gt; hopefully it won&#39;t take long to rectify.<br>
<br>
Please replace qtest_start() with qts =3D qtest_init() and qtest_end()<br>
with qtest_quit(qts).<br>
<br>
See this commit for some more details:<br>
<br>
=C2=A0<a href=3D"https://git.qemu.org/?p=3Dqemu.git;a=3Dcommitdiff;h=3D44c2=
364aaa5e366c4" rel=3D"noreferrer" target=3D"_blank">https://git.qemu.org/?p=
=3Dqemu.git;a=3Dcommitdiff;h=3D44c2364aaa5e366c4</a><br>
<br>
=C2=A0 Thomas<br>
</blockquote></div>

--0000000000005af6cf05935e02df--

