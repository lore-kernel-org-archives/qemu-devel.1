Return-Path: <SRS0=+ldK=Y7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1483C5DF60
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2019 10:38:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7EA25218AE
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2019 10:38:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V45JiLhq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EA25218AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40658 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSfBS-0007h4-Jg
	for qemu-devel@archiver.kernel.org; Thu, 07 Nov 2019 05:38:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40004)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iSfAL-0007AM-OF
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 05:37:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iSfAK-0002w8-61
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 05:37:25 -0500
Received: from mail-oi1-x22a.google.com ([2607:f8b0:4864:20::22a]:36553)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1iSfAH-0002mV-N2
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 05:37:22 -0500
Received: by mail-oi1-x22a.google.com with SMTP id j7so1535733oib.3
 for <qemu-devel@nongnu.org>; Thu, 07 Nov 2019 02:37:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=SF55EwY0cbAJy4hZ8ZsKKrWvstgFCdY1KUBVJWsYL80=;
 b=V45JiLhqsWemvcutuk4hshcBwuAM1QxFro21unsY0OKH5jhRtZgaJE6b5YGk7uvZRQ
 RKTKxvZR7HoQC1MRmO8KFTW9R6ihcLE95u7BP7/gFMlWEyAxqXQ7OIAXODOMysAXP1RP
 Ek6F4DG01aXf5+KcId9+gYB7OVrKkWu/FITfHY78VBetcyM+ludUSmhoPd8/+4cZFS7x
 xfCl6/H3E6Kjk+hEj8RtqCkFfamnQ3lyk32qTZ4DVm3yHAF1KkXNgb5G7LqmrkoMZSQr
 PvSbq0ThBoPpUqPIrXf0tjuJnX0WuYu98MjpUyJBALpLrmRTCQCJy3Ax3zPUwtGtM+t5
 TwVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=SF55EwY0cbAJy4hZ8ZsKKrWvstgFCdY1KUBVJWsYL80=;
 b=ifsDcZFwlZTBfgF0J6Dj8xef4QcnZ2bMT20XA9WUOp/uZnreAoQZgQnFLbUBhO4be4
 CBHFYFwk0NbTmmbmH8Dt+FiIRAI/fCZeXFtkL5QP6YbgSElltioPESrWCsaKMNQ3kBWB
 9051LUmLm8HJzugmWEJSxEvHF2P+2XcLZmUN4OZF/aHCuvB1FjWLeQrzuupK5CS3LVXf
 EKfGLPp+xHRWkI/7dgHOBSNkbqYQzaYF0I0W2XqWSvtwRmLP2J1/NlCUKHp0J/sJDQJu
 ygTOtf3813+5DgkRtCZkiBgx1tH8R4ifntU+Oh5Iznfj2BVcZCvV4igzFSCDVtx/NziA
 or8Q==
X-Gm-Message-State: APjAAAW8eANJyZBYFFq8g0b9PVfBoaWUak91HzcZ74IgsiC7sVIF/JhR
 vYDgoE5uC+hPunjOyqKHo4HbBD9fpWx2EKRId6MHuw==
X-Google-Smtp-Source: APXvYqw1RhfNM1gIdWAZTjJsAM0k2BArvz/NIBbc8BNoPVFXCgMzztIhIXjF2f2AKsOcbjw0N06wRbSSxh9nu2GXpME=
X-Received: by 2002:a05:6808:90:: with SMTP id
 s16mr2861790oic.62.1573123038411; 
 Thu, 07 Nov 2019 02:37:18 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a9d:5e89:0:0:0:0:0 with HTTP;
 Thu, 7 Nov 2019 02:37:17 -0800 (PST)
In-Reply-To: <f5a16b3c-2c17-60e4-e80b-dd20b3c088cc@cs.utexas.edu>
References: <f5a16b3c-2c17-60e4-e80b-dd20b3c088cc@cs.utexas.edu>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Thu, 7 Nov 2019 11:37:17 +0100
Message-ID: <CAL1e-=g8c=QJiMm1AvBCNmsTyVWoUAjL0na2HWodHCQPiLdWJw@mail.gmail.com>
Subject: Re: Looking for issues/features for my first contribution
To: Rajath Shashidhara <rajaths@cs.utexas.edu>
Content-Type: multipart/alternative; boundary="000000000000e47fc80596bf3ff7"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::22a
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
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000e47fc80596bf3ff7
Content-Type: text/plain; charset="UTF-8"

On Thursday, November 7, 2019, Rajath Shashidhara <rajaths@cs.utexas.edu>
wrote:

> Hi all,
>
> I am a Computer Science graduate student at The University of Texas at
> Austin (UT, Austin). I am looking forward to contributing to qemu !
>
> This semester, I am taking a class in Virtualization (
> https://github.com/vijay03/cs378-f19) and contributing to a
> virtualization related open-source project is a significant part of the
> course.
> I would be interested in contributing a patchset to qemu - possibly a
> self-contained feature or a reasonably complex bug fix that can be
> completed in under a month's time. I did look at both the bugtracker and
> the QEMU Google Summer of Code 2019 page [https://wiki.qemu.org/Google_
> Summer_of_Code_2019] for ideas. However, I would be interested in hearing
> from the community and I would be delighted if somebody can be suggest a
> suitable project !
>
>
Hello, Rajath!

Thank you for expressing interest in QEMU open source project.

There is certainly a place for you and your contributions in QEMU, and you
are very welcomed!

It looks to me the following project would fit your description:

'Implement emulation of DS3231 real time clock in QEMU'

Datasheet:

https://datasheets.maximintegrated.com/en/ds/DS3231.pdf

The steps needed to complete it (in my opinion):

- collect datasheets of as many as possible RTC chips already emulated in
QEMU (there are around of dozen of them, see folder hw/rtc)

- do a comparative analysis of selected RTC implementations in QEMU

- get to know general QEMU device model

- design and implement DS3231 emulation

I can give you (unfortunately constrained by tight time limits) some help
and guidance. But there are other people in community too (more
knowledgable in the area than me).

I salute your initiative!

Yours,
Aleksandar




> I am an advanced C programmer with both professional and academic
> background in systems design & implementation - especially OS & Networks.
> Given my background, I feel fairly confident that I can pickup the QEMU
> codebase quickly.
>
> Eagerly looking forward to hearing from the community !
>
> Thanks,
> Rajath Shashidhara
>
>
>

--000000000000e47fc80596bf3ff7
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<br><br>On Thursday, November 7, 2019, Rajath Shashidhara &lt;<a href=3D"ma=
ilto:rajaths@cs.utexas.edu">rajaths@cs.utexas.edu</a>&gt; wrote:<br><blockq=
uote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc =
solid;padding-left:1ex">Hi all,<br>
<br>
I am a Computer Science graduate student at The University of Texas at Aust=
in (UT, Austin). I am looking forward to contributing to qemu !<br>
<br>
This semester, I am taking a class in Virtualization (<a href=3D"https://gi=
thub.com/vijay03/cs378-f19" target=3D"_blank">https://github.com/vijay03/cs=
<wbr>378-f19</a>) and contributing to a virtualization related open-source =
project is a significant part of the course.<br>
I would be interested in contributing a patchset to qemu - possibly a self-=
contained feature or a reasonably complex bug fix that can be completed in =
under a month&#39;s time. I did look at both the bugtracker and the QEMU Go=
ogle Summer of Code 2019 page [<a href=3D"https://wiki.qemu.org/Google_Summ=
er_of_Code_2019" target=3D"_blank">https://wiki.qemu.org/Google_<wbr>Summer=
_of_Code_2019</a>] for ideas. However, I would be interested in hearing fro=
m the community and I would be delighted if somebody can be suggest a suita=
ble project !<br>
<br></blockquote><div><br></div><div>Hello, Rajath!</div><div><br></div><di=
v>Thank you for expressing interest in QEMU open source project.</div><div>=
<br></div><div>There is certainly a place for you and your contributions in=
 QEMU, and you are very welcomed!</div><div><br></div><div>It looks to me t=
he following project would fit your description:</div><div><br></div><div>&=
#39;Implement emulation of DS3231 real time clock in QEMU&#39;</div><div><b=
r></div><div>Datasheet:</div><div><br></div><div><a href=3D"https://datashe=
ets.maximintegrated.com/en/ds/DS3231.pdf">https://datasheets.maximintegrate=
d.com/en/ds/DS3231.pdf</a><br></div><div><br></div><div>The steps needed to=
 complete it (in my opinion):</div><div><br></div><div>- collect datasheets=
 of as many as possible RTC chips already emulated in QEMU (there are aroun=
d of dozen of them, see folder hw/rtc)</div><div><br></div><div>- do a comp=
arative analysis of selected RTC implementations in QEMU</div><div><br></di=
v><div>- get to know general QEMU device model</div><div><br></div><div>- d=
esign and implement DS3231 emulation</div><div><br></div><div>I can give yo=
u (unfortunately constrained by tight time limits) some help and guidance. =
But there are other people in community too (more knowledgable in the area =
than me).</div><div><br></div><div>I salute your initiative!</div><div><br>=
</div><div>Yours,</div><div>Aleksandar</div><div><br></div><div><br></div><=
div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8e=
x;border-left:1px #ccc solid;padding-left:1ex">
I am an advanced C programmer with both professional and academic backgroun=
d in systems design &amp; implementation - especially OS &amp; Networks. Gi=
ven my background, I feel fairly confident that I can pickup the QEMU codeb=
ase quickly.<br>
<br>
Eagerly looking forward to hearing from the community !<br>
<br>
Thanks,<br>
Rajath Shashidhara<br>
<br>
<br>
</blockquote>

--000000000000e47fc80596bf3ff7--

