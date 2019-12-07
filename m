Return-Path: <SRS0=SuvF=Z5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3687C43603
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Dec 2019 19:16:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 83D612082E
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Dec 2019 19:16:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FZwX3hed"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83D612082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52718 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1idfZM-0005gf-Ks
	for qemu-devel@archiver.kernel.org; Sat, 07 Dec 2019 14:16:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37910)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1idfXj-00054w-9u
 for qemu-devel@nongnu.org; Sat, 07 Dec 2019 14:15:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1idfXi-0003Pt-1m
 for qemu-devel@nongnu.org; Sat, 07 Dec 2019 14:15:03 -0500
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:35666)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1idfXh-0003OU-Rc
 for qemu-devel@nongnu.org; Sat, 07 Dec 2019 14:15:01 -0500
Received: by mail-oi1-x244.google.com with SMTP id k196so2917926oib.2
 for <qemu-devel@nongnu.org>; Sat, 07 Dec 2019 11:15:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=J9qgqpdcN+zkzuuSy4/yKHBSCjm3Y0opEgx+ay2ZAKs=;
 b=FZwX3hed8dU0IhynQ7/5G/tXRgjSX9E0gyXwcRbjXSoySxObU+DJV4tzFCxS+lsQCE
 FslB0FCErRg3+ZP+vSSNk1x4MkBQnukSPmB/y+EvPjlrWzfFifgcMs55PRrVFnl8UOgl
 oKGpkmDmgWWfYe/xSrSsqxXAzzbw3qTej0LxuZHU/0vDIufVeatZ+1DdM58YFt1Rgom4
 vdmb6ZHVDCaBz7WTKPDcbD5V75KhEvUIZV01PEUZS9TqXukxfqRYHy+JEhLqNW2++TgX
 7SEEipOP6rmR6iDuXMbvBNhQ5pTiM5S/nd3zn+/HQECTYirL1edbZcZg1V/abq+GEZcH
 v/VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=J9qgqpdcN+zkzuuSy4/yKHBSCjm3Y0opEgx+ay2ZAKs=;
 b=naSUvSaAvg+81PA7jzW1oVFOMQW2PRBgLD+OmNPbv+w1HV1bVARm+2bSd6sOSDLtog
 1gh66I8hJxKuQDZvZlN8UJ5yexJvNQnr7XryqOrpDnkzMIZxUMOEWRjmya8PGHHm4uYe
 zG/gg5aJb30b8o/cfCWPQd8IJOzL+1Vd8ZmK9ZJpM13m9uPeYxUu8cnkfVjxzratkbAZ
 HH9wFUSq6GKJjeJx5EOwzMz9DfLLa5SA3IJg4lOcppJ6at6dLA9xwiX6sfodxzpiPMVI
 ismx/p3sUx/hAXLth6jh4n0R67247yPfbDCyVyMmWqXehVQwX4paKRIDQknhQ/XZHmAl
 3T0g==
X-Gm-Message-State: APjAAAWiUrV2yM2kQ+K3rGrsb8aNdY9XFJliChb3ocrFLfu5OoYKyLqV
 hrvRO3K5m4TFsjFIfjzBpBiALhjUGg3/D7BecZE=
X-Google-Smtp-Source: APXvYqyHS+YJC/RauXboJ28KAFSZLxJPOwNn1smyRFekPiC6PF6ORdfD2MO5a7sGMxHNXnjlbh7ptBeKBRNrZ9CbjEI=
X-Received: by 2002:a05:6808:98b:: with SMTP id
 a11mr18356698oic.62.1575746100845; 
 Sat, 07 Dec 2019 11:15:00 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a9d:d21:0:0:0:0:0 with HTTP;
 Sat, 7 Dec 2019 11:15:00 -0800 (PST)
In-Reply-To: <b2bdb632-7f17-85e5-5c8c-079316fe38bd@redhat.com>
References: <1573652826-23987-1-git-send-email-aleksandar.markovic@rt-rk.com>
 <1573652826-23987-4-git-send-email-aleksandar.markovic@rt-rk.com>
 <b2bdb632-7f17-85e5-5c8c-079316fe38bd@redhat.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Sat, 7 Dec 2019 20:15:00 +0100
Message-ID: <CAL1e-=jxootskQhJ29kfuDdSqCpObUdJfO3MW=zsuupqQ-t3Xg@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] MAINTAINERS: Adjust maintainership for Malta board
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: multipart/alternative; boundary="00000000000098e252059921fae1"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::244
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
Cc: Paul Burton <pburton@wavecomp.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Aleksandar Markovic <aleksandar.markovic@rt-rk.com>,
 "hpoussin@reactos.org" <hpoussin@reactos.org>,
 "amarkovic@wavecomp.com" <amarkovic@wavecomp.com>,
 "aleksandar.rikalo@rt-rk.com" <aleksandar.rikalo@rt-rk.com>,
 "aurelien@aurel32.net" <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--00000000000098e252059921fae1
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thursday, November 14, 2019, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.=
com>
wrote:

> +Paul Burton
>
> On 11/13/19 2:47 PM, Aleksandar Markovic wrote:
>
>> From: Aleksandar Markovic <amarkovic@wavecomp.com>
>>
>> Change the maintainership for Malta board to improve its quality.
>>
>> Acked-by: Aurelien Jarno <aurelien@aurel32.net>
>> Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
>> ---
>>   MAINTAINERS | 5 +++--
>>   1 file changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 3bf2144..6afec32 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -955,8 +955,9 @@ F: hw/display/jazz_led.c
>>   F: hw/dma/rc4030.c
>>     Malta
>> -M: Aurelien Jarno <aurelien@aurel32.net>
>>
> > +R: Aurelien Jarno <aurelien@aurel32.net>
>
> Aurelien, do you want to stay co-maintainer with this one?
> Else, thanks for staying listed as designated reviewer :)
>
> -R: Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>
>> +M: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>>
>
> I'm happy to continue Aurelien work with this board :)
> Similarly to the Fuloong board, I mostly use the Malta as a hobby, so I'l=
l
> use my personal email.
>
> Paul, do you mind being co-maintainer or at least listed as designated
> reviewer here?
>
> +R: Herv=C3=A9 Poussineau <hpoussin@reactos.org>
>>
>
> I don't see commits from Herv=C3=A9 with this board, so he is probably no=
t
> interested.
>
>   S: Maintained
>>
>
> Until Paul is interested in co-maintenance, let's change this board statu=
s
> to 'Odd Fixes'.
>
>
Philippe, I'll use your other email address in v3 as you asked, but this
board really has to have Maintained status, since it is used for tests,
within and outside of QEMU official tests, it would be really shame to
degrade it to Odd fixes, unthinkable.

Cheers,
Aleks.




>   F: hw/mips/mips_malta.c
>>   F: hw/mips/gt64xxx_pci.c
>>
>
>
>

--00000000000098e252059921fae1
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<br><br>On Thursday, November 14, 2019, Philippe Mathieu-Daud=C3=A9 &lt;<a =
href=3D"mailto:philmd@redhat.com">philmd@redhat.com</a>&gt; wrote:<br><bloc=
kquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #cc=
c solid;padding-left:1ex">+Paul Burton<br>
<br>
On 11/13/19 2:47 PM, Aleksandar Markovic wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
From: Aleksandar Markovic &lt;<a href=3D"mailto:amarkovic@wavecomp.com" tar=
get=3D"_blank">amarkovic@wavecomp.com</a>&gt;<br>
<br>
Change the maintainership for Malta board to improve its quality.<br>
<br>
Acked-by: Aurelien Jarno &lt;<a href=3D"mailto:aurelien@aurel32.net" target=
=3D"_blank">aurelien@aurel32.net</a>&gt;<br>
Signed-off-by: Aleksandar Markovic &lt;<a href=3D"mailto:amarkovic@wavecomp=
.com" target=3D"_blank">amarkovic@wavecomp.com</a>&gt;<br>
---<br>
=C2=A0 MAINTAINERS | 5 +++--<br>
=C2=A0 1 file changed, 3 insertions(+), 2 deletions(-)<br>
<br>
diff --git a/MAINTAINERS b/MAINTAINERS<br>
index 3bf2144..6afec32 100644<br>
--- a/MAINTAINERS<br>
+++ b/MAINTAINERS<br>
@@ -955,8 +955,9 @@ F: hw/display/jazz_led.c<br>
=C2=A0 F: hw/dma/rc4030.c<br>
=C2=A0 =C2=A0 Malta<br>
-M: Aurelien Jarno &lt;<a href=3D"mailto:aurelien@aurel32.net" target=3D"_b=
lank">aurelien@aurel32.net</a>&gt;<br>
</blockquote>
&gt; +R: Aurelien Jarno &lt;<a href=3D"mailto:aurelien@aurel32.net" target=
=3D"_blank">aurelien@aurel32.net</a>&gt;<br>
<br>
Aurelien, do you want to stay co-maintainer with this one?<br>
Else, thanks for staying listed as designated reviewer :)<br>
<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
-R: Aleksandar Rikalo &lt;<a href=3D"mailto:aleksandar.rikalo@rt-rk.com" ta=
rget=3D"_blank">aleksandar.rikalo@rt-rk.com</a>&gt;<br>
+M: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@redhat.com" ta=
rget=3D"_blank">philmd@redhat.com</a>&gt;<br>
</blockquote>
<br>
I&#39;m happy to continue Aurelien work with this board :)<br>
Similarly to the Fuloong board, I mostly use the Malta as a hobby, so I&#39=
;ll use my personal email.<br>
<br>
Paul, do you mind being co-maintainer or at least listed as designated revi=
ewer here?<br>
<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
+R: Herv=C3=A9 Poussineau &lt;<a href=3D"mailto:hpoussin@reactos.org" targe=
t=3D"_blank">hpoussin@reactos.org</a>&gt;<br>
</blockquote>
<br>
I don&#39;t see commits from Herv=C3=A9 with this board, so he is probably =
not interested.<br>
<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
=C2=A0 S: Maintained<br>
</blockquote>
<br>
Until Paul is interested in co-maintenance, let&#39;s change this board sta=
tus to &#39;Odd Fixes&#39;.<br>
<br></blockquote><div><br></div><div>Philippe, I&#39;ll use your other emai=
l address in v3 as you asked, but this board really has to have Maintained =
status, since it is used for tests, within and outside of QEMU official tes=
ts, it would be really shame to degrade it to Odd fixes, unthinkable.</div>=
<div><br></div><div>Cheers,</div><div>Aleks.</div><div><br></div><div><br><=
/div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0 0=
 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
=C2=A0 F: hw/mips/mips_malta.c<br>
=C2=A0 F: hw/mips/gt64xxx_pci.c<br>
</blockquote>
<br>
<br>
</blockquote>

--00000000000098e252059921fae1--

