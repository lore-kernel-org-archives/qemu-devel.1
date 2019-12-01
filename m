Return-Path: <SRS0=Jz4r=ZX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7101C432C0
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Dec 2019 14:08:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8AD5C20867
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Dec 2019 14:08:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N/VGa+QZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8AD5C20867
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51748 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ibPtU-0007Bh-NW
	for qemu-devel@archiver.kernel.org; Sun, 01 Dec 2019 09:08:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53387)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1ibPsd-0006Rz-Vl
 for qemu-devel@nongnu.org; Sun, 01 Dec 2019 09:07:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1ibPsc-0005yM-FI
 for qemu-devel@nongnu.org; Sun, 01 Dec 2019 09:07:19 -0500
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:40404)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1ibPsc-0005y4-7d
 for qemu-devel@nongnu.org; Sun, 01 Dec 2019 09:07:18 -0500
Received: by mail-ot1-x343.google.com with SMTP id m15so28778383otq.7
 for <qemu-devel@nongnu.org>; Sun, 01 Dec 2019 06:07:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=gRawsvgs4OJ6D+Z1o/4xYJ+008Myc/KRhGCba1HeNO0=;
 b=N/VGa+QZIdeCXPVu47Q1Lfv1uppeVotdA4uTBaq/45CVzOc4Z6LmHNl5mfXKmFCnS1
 /bGhNPWCYk9G+421Rkf9FFzax1X2I/htOF3048wRcuoU/Ou5Oa3Dl7JQoJ7HM3yf0vYx
 O80OnNEWCB6bKJ02lv/rlZQ2X2Grh8P/QedmexK+6tVJNrOJMq7PYR23yal2b/Dbvu2X
 DQD5d05llBeO0Mvu0nJFNzPg/vszm1E39vwDrNLxSEkjSGhykYN7Lhvh8K4yeMmQQc9n
 Q6zW3Xd43tJ+wn+ZbVWy5niLTp2u/Hnuc8Yq3Unq3uJlHp0Hxs+6zlezLFtMB3Vd3rKj
 l7LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=gRawsvgs4OJ6D+Z1o/4xYJ+008Myc/KRhGCba1HeNO0=;
 b=VZkgKDdrgJT/CxQANfS/Mq71drT7Ekv7i8GoDVJgOUsctBygJNI/SU4xMvoozWwQg9
 LiCEZ6ZlWLIut/F/QQnya3oda8/9gNI/HKw+/T2mOVyhZa2YmqYlnv9B66K5KRwFwDzv
 ZKEGSbxvu8SpMOBu3EqLNIb0V9FqkCg9ftHA+0OTilKGRldzBFyJq1NErVk0TK6+jao+
 luJ2Kc6QteUflhtaY7sICw5rfGKhhsBdHnMcPcDs+ThslmaUGW+qdYQOUQqlKlNIiyZH
 +3FFrYNMwH4Pif5z3B9O3xHbQzExhDwKBcw5ZRMp9rFS6+R5eI5pk1b1o612x+z9jyVn
 vosw==
X-Gm-Message-State: APjAAAWyuNIo4geZXCv5FUCRIlReVaT99RIGqMMlZL3+3RrT6xGVH0KG
 mUJkIyeSQXjAM+Juav304KgSjFU5ofaCpqxW5jo=
X-Google-Smtp-Source: APXvYqwHPKFTnktFaHMJ76OmojUshcup0Uxm9o0bCkLzg1H8QKGIJ/ypXuWth5bRfvxJoAyd7L90svNXskdjcYPm0c0=
X-Received: by 2002:a9d:3d05:: with SMTP id a5mr19096311otc.295.1575209237309; 
 Sun, 01 Dec 2019 06:07:17 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6830:1391:0:0:0:0 with HTTP; Sun, 1 Dec 2019 06:07:16
 -0800 (PST)
In-Reply-To: <CAL1e-=jst9hGBXy0zm-975QDvW0F0xBNJAypqM4KooWEUvJfjQ@mail.gmail.com>
References: <20191130194240.10517-18-armbru@redhat.com>
 <9C97FEE6-D390-4CEB-9B00-50AE00AEA4D2@redhat.com>
 <CAL1e-=jst9hGBXy0zm-975QDvW0F0xBNJAypqM4KooWEUvJfjQ@mail.gmail.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Sun, 1 Dec 2019 15:07:16 +0100
Message-ID: <CAL1e-=jP3kYhxSFsGg2=w2rAK8mfMBFg5MvvFZd_4z_t3LSmcA@mail.gmail.com>
Subject: Re: [PATCH 17/21] s390x: Fix latent query-cpu-model-FOO error
 handling bugs
To: David Hildenbrand <dhildenb@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000096de10598a4fb9a"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::343
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
Cc: David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 "vsementsov@virtuozzo.com" <vsementsov@virtuozzo.com>,
 Markus Armbruster <armbru@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000096de10598a4fb9a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sunday, December 1, 2019, Aleksandar Markovic <
aleksandar.m.mail@gmail.com> wrote:

>
>
> On Saturday, November 30, 2019, David Hildenbrand <dhildenb@redhat.com>
> wrote:
>
>>
>>
>> > Am 30.11.2019 um 20:42 schrieb Markus Armbruster <armbru@redhat.com>:
>> >
>> > =EF=BB=BFcpu_model_from_info() is a helper for qmp_query_cpu_model_exp=
ansion(),
>> > qmp_query_cpu_model_comparison(), qmp_query_cpu_model_baseline().  It
>> > crashes when the visitor or the QOM setter fails, and its @errp
>> > argument is null.  Messed up in commit 137974cea3 's390x/cpumodel:
>> > implement QMP interface "query-cpu-model-expansion"'.
>> >
>> > Its three callers have the same bug.  Messed up in commit 4e82ef0502
>> > 's390x/cpumodel: implement QMP interface "query-cpu-model-comparison"'
>> > and commit f1a47d08ef 's390x/cpumodel: implement QMP interface
>> > "query-cpu-model-baseline"'.
>> >
>> > The bugs can't bite as no caller actually passes null.  Fix them
>> > anyway.
>>
>> https://en.m.wikipedia.org/wiki/Software_bug
>>
>>   =E2=80=9E A software bug is an error, flaw or fault in a computer prog=
ram or
>> system that causes it to produce an incorrect or unexpected result, or t=
o
>> behave in unintended ways. =E2=80=9E
>>
>> Please make it clear in the descriptions that these are cleanups and not
>> bugfixes. It might be very confusing for people looking out for real bug=
s.
>
>
>>
> Disclaimer: I am not entirely familiar with the code in question, so take
> my opinion with reasonablereservation.
>
> It looks that we here deal with latent bugs. As you probably know from
> experience, a latent bugs, when they are activated with some ostensibly
> unrelated code change, can be much more difficult to diagnose and fix tha=
n
> regular bugs.
>
>
Oops, I didn't even realize that the patch title contains the word
"latent". (I wrote the previous message without that knowledge. For some
strange reason, my email client doesn't display email subject while
replying.)

In this case, I would suggest usage of phrase "latent bug" instead of
"latent error" or so in the message title, to strenghten the point that
this is not a cleanup.

Yours, Aleksandar



> In that light, this change is not a clean up. It is a fix of a latent
> bugs, and Markus' aproach to treat it as a bug fix looks right to me. I
> would just add a word "latent" or similar, which would even more distance
> the patch from "cleanup" meaning.
>
> David, if I understand well, this patch fixes the commit done by you. I
> definitely understand this is not a pleasant position, but we all
> (definitelly including myself too) should learn to handle such situations
> as gracefully as we can.
>
> Yours,
> Aleksandar
>
>
>
>>
>>
>>
>> Also, please change the terminology =E2=80=9Emessed up=E2=80=9C to =E2=
=80=9Eintroduced in=E2=80=9C or
>> similar.
>>
>> (applies to all s390x patches)
>>
>> Thanks.
>
>

--000000000000096de10598a4fb9a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<br><br>On Sunday, December 1, 2019, Aleksandar Markovic &lt;<a href=3D"mai=
lto:aleksandar.m.mail@gmail.com">aleksandar.m.mail@gmail.com</a>&gt; wrote:=
<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-lef=
t:1px #ccc solid;padding-left:1ex"><br><br>On Saturday, November 30, 2019, =
David Hildenbrand &lt;<a href=3D"mailto:dhildenb@redhat.com" target=3D"_bla=
nk">dhildenb@redhat.com</a>&gt; wrote:<br><blockquote class=3D"gmail_quote"=
 style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><b=
r>
<br>
&gt; Am 30.11.2019 um 20:42 schrieb Markus Armbruster &lt;<a href=3D"mailto=
:armbru@redhat.com" target=3D"_blank">armbru@redhat.com</a>&gt;:<br>
&gt; <br>
&gt; =EF=BB=BFcpu_model_from_info() is a helper for qmp_query_cpu_model_exp=
ansion(<wbr>),<br>
&gt; qmp_query_cpu_model_comparison<wbr>(), qmp_query_cpu_model_baseline()<=
wbr>.=C2=A0 It<br>
&gt; crashes when the visitor or the QOM setter fails, and its @errp<br>
&gt; argument is null.=C2=A0 Messed up in commit 137974cea3 &#39;s390x/cpum=
odel:<br>
&gt; implement QMP interface &quot;query-cpu-model-expansion&quot;&#39;.<br=
>
&gt; <br>
&gt; Its three callers have the same bug.=C2=A0 Messed up in commit 4e82ef0=
502<br>
&gt; &#39;s390x/cpumodel: implement QMP interface &quot;query-cpu-model-com=
parison&quot;&#39;<br>
&gt; and commit f1a47d08ef &#39;s390x/cpumodel: implement QMP interface<br>
&gt; &quot;query-cpu-model-baseline&quot;&#39;.<br>
&gt; <br>
&gt; The bugs can&#39;t bite as no caller actually passes null.=C2=A0 Fix t=
hem<br>
&gt; anyway.<br>
<br>
<a href=3D"https://en.m.wikipedia.org/wiki/Software_bug" target=3D"_blank">=
https://en.m.wikipedia.org/wik<wbr>i/Software_bug</a><br>
<br>
=C2=A0 =E2=80=9E A software bug is an error, flaw or fault in a computer pr=
ogram or system that causes it to produce an incorrect or unexpected result=
, or to behave in unintended ways. =E2=80=9E<br>
<br>
Please make it clear in the descriptions that these are cleanups and not bu=
gfixes. It might be very confusing for people looking out for real bugs.</b=
lockquote><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bord=
er-left:1px #ccc solid;padding-left:1ex"><br></blockquote><div><br></div><d=
iv>Disclaimer: I am not entirely familiar with the code in question, so tak=
e my opinion with reasonablereservation.</div><div><br></div><div>It looks =
that we here deal with latent bugs. As you probably know from experience, a=
 latent bugs, when they are activated with some ostensibly unrelated code c=
hange, can be much more difficult to diagnose and fix than regular bugs.</d=
iv><div><br></div></blockquote><div><br></div><div>Oops, I didn&#39;t even =
realize that the patch title contains the word &quot;latent&quot;. (I wrote=
 the previous message without that knowledge. For some strange reason, my e=
mail client doesn&#39;t display email subject while replying.)</div><div><b=
r></div><div>In this case, I would suggest usage of phrase &quot;latent bug=
&quot; instead of &quot;latent error&quot; or so in the message title, to s=
trenghten the point that this is not a cleanup.</div><div><br></div><div>Yo=
urs, Aleksandar</div><div><br></div><div>=C2=A0</div><blockquote class=3D"g=
mail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-l=
eft:1ex"><div>In that light, this change is not a clean up. It is a fix of =
a latent bugs, and Markus&#39; aproach to treat it as a bug fix looks right=
 to me. I would just add a word &quot;latent&quot; or similar, which would =
even more distance the patch from &quot;cleanup&quot; meaning.</div><div><b=
r></div><div>David, if I understand well, this patch fixes the commit done =
by you. I definitely understand this is not a pleasant position, but we all=
 (definitelly including myself too) should learn to handle such situations =
as gracefully as we can.</div><div><br></div><div>Yours,</div><div>Aleksand=
ar</div><div><br></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" s=
tyle=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><br>=
</blockquote><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;b=
order-left:1px #ccc solid;padding-left:1ex"><br></blockquote><blockquote cl=
ass=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;p=
adding-left:1ex"><br></blockquote><blockquote class=3D"gmail_quote" style=
=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">Also, pl=
ease change the terminology =E2=80=9Emessed up=E2=80=9C to =E2=80=9Eintrodu=
ced in=E2=80=9C or similar.<br>
<br>
(applies to all s390x patches)<br>
<br>
Thanks.</blockquote>
</blockquote>

--000000000000096de10598a4fb9a--

