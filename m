Return-Path: <SRS0=fi8h=Z7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79BA8C43603
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 10:13:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 46901206D5
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 10:13:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="t7frp0+K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46901206D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38150 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ieG2Z-00048E-Ga
	for qemu-devel@archiver.kernel.org; Mon, 09 Dec 2019 05:13:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52257)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1ieG1y-0003je-7w
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 05:12:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1ieG1w-0001Cc-P5
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 05:12:42 -0500
Received: from mail-oi1-x22d.google.com ([2607:f8b0:4864:20::22d]:38265)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1ieG1w-0001C7-J2
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 05:12:40 -0500
Received: by mail-oi1-x22d.google.com with SMTP id b8so5819585oiy.5
 for <qemu-devel@nongnu.org>; Mon, 09 Dec 2019 02:12:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=4b0Wi+UuNHKGxE3MUTu5fMGeOASZbL+V6haBStvTEk4=;
 b=t7frp0+KyjVUMm2jZcBPq8XhDQLKTgSgZXY9ML+5OqECBPp9KMsA3UabRXj0xgTcrI
 dCzxGhDgK3cbDg5Og4W8SoE3oET82AY4i/ptzFrTzR+vhii9XzPeoPo/J5cKD0xVNgaa
 AmSV04JEtlWvFEjg2tAKFg5PxrGbL2AwvpOwLIhdCVgJWmtOFZn0KcWYCzNws5lDXbnk
 SVHcxCSXlJ5eKemoLBhNboeAOUH3VoAVhyK86G9OhhXb7JiwygaqCdTtzLqVLuv+yj5x
 OoKpomeM7SxgEpw/rfkxNPoAmoVISaMyt5ZPQ5pU+W6GYHmVQ3BeEIQ4k6ckCPBEShRz
 eonQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=4b0Wi+UuNHKGxE3MUTu5fMGeOASZbL+V6haBStvTEk4=;
 b=UQVrBN45Qp5OqEgDpcMPOpc5zVExjULLmhqQfcFXRt6SR1SqMaeGm00spJPIthWTPg
 a5eErLpFoNcxdUxWPCEVm11ehuP7jZLSzK9FnldO/hVPyVx1Km6kIhnATjrNWCtDC35D
 hWnQcwIpijMh/nQWfwPaJoSQKjN4hIBotWdVVr4yIentJvVhObUKLUBgLMT00EYp2xHK
 /+0XTBBplfOFedRp95R+9nitLJ9EslxEWNDWf0a/XREQemq7TbtOZMBcSoUhzgHmFc04
 TaP4IBez6kkt7mF58tUEQibhemSMR3K2QqmZ7ARPCWUyA3qYBsO943X3AIFc04XYTp8E
 GrgA==
X-Gm-Message-State: APjAAAVpc7s6/YAZug1EoJmsJXHDhmZPVe7OZqLw0LYYdJvnxoGEcAgO
 iU7dYgBwRLFcZpUHbEqufNN831YezP6Cj1ar4zw=
X-Google-Smtp-Source: APXvYqwYCNnb1zmEfLXhg7S5p00IWrKObXjHMCDko0Ru72o00qUs2n1cTCScJeQWEP7xyiSE98lxCp/REQfceMJkjbk=
X-Received: by 2002:a05:6808:98b:: with SMTP id
 a11mr23788673oic.62.1575886359629; 
 Mon, 09 Dec 2019 02:12:39 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a9d:d21:0:0:0:0:0 with HTTP;
 Mon, 9 Dec 2019 02:12:39 -0800 (PST)
In-Reply-To: <9f71601e-de90-86d9-7c6b-352d923bbc06@redhat.com>
References: <4cbaadf8-ae4f-d086-2137-b83d61a5e9a5@redhat.com>
 <CAL1e-=ja7sdqC6sm_AxYkN-m_R__4dofj-WsYreHZB813OG9OA@mail.gmail.com>
 <9f71601e-de90-86d9-7c6b-352d923bbc06@redhat.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Mon, 9 Dec 2019 11:12:39 +0100
Message-ID: <CAL1e-=iRWsWde18AffTOwTesAbGcb5fZWeRytaOsHg5iCQpBgA@mail.gmail.com>
Subject: Re: [RFC] Use of the Nacked-by tag by CI scripts
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000ac12c6059942a240"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::22d
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>,
 Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000ac12c6059942a240
Content-Type: text/plain; charset="UTF-8"

On Monday, December 9, 2019, Paolo Bonzini <pbonzini@redhat.com> wrote:

> On 09/12/19 10:28, Aleksandar Markovic wrote:
> >     If there is a consensus about using this tag, the following patch
> >     can be added to Peter's management scripts:
> >     https://git.linaro.org/people/pmaydell/misc-scripts.git/
> >     <https://git.linaro.org/people/pmaydell/misc-scripts.git/>
> >
> > I always assumed that pull requests by sub-maintainers should contain
> > "ready for merging" code (justified, reviewed, tested, ...). Why would
> > ever a sub-maintainer send something that doesn't comply to these
> > conditions?
>
> Because things can and do go wrong, perhaps someone was on vacation
> while the original patch was posted, perhaps somebody is giving a
> negative review outside his maintenance area, perhaps there would be
> conflicts with a tree-wide series being discussed elsewhere...  It's
> rare and I don't think it would be misused, but I think it's a good idea
> to have a machine-readable way to block patches.
>
>
I'm afraid this would be opening a Pandora's box. For such rare cases, a
message from a person: "Please hold on this patch until I am back from
vacation.", "Please wait until I merge my series acting on the same files",
or similar, would perfectly do the job, as it did in the past.

We are fixing something that is not broken.


> However, I'm not sure why the commits would contain a tag.  Instead, we
> could use the patchew REST API
> (https://patchew.org/api/v1/projects/1/series/MESSAGE-ID/) and search
> for nacked-by tags in there.
>
> Paolo
>
> > I think, in general, this tag would do more harm than good, allowing
> > frivolous blocking of patches, and fixing a process that already works,
> > without any need.
>
>

--000000000000ac12c6059942a240
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<br><br>On Monday, December 9, 2019, Paolo Bonzini &lt;<a href=3D"mailto:pb=
onzini@redhat.com">pbonzini@redhat.com</a>&gt; wrote:<br><blockquote class=
=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padd=
ing-left:1ex">On 09/12/19 10:28, Aleksandar Markovic wrote:<br>
&gt;=C2=A0 =C2=A0 =C2=A0If there is a consensus about using this tag, the f=
ollowing patch<br>
&gt;=C2=A0 =C2=A0 =C2=A0can be added to Peter&#39;s management scripts:<br>
&gt;=C2=A0 =C2=A0 =C2=A0<a href=3D"https://git.linaro.org/people/pmaydell/m=
isc-scripts.git/" target=3D"_blank">https://git.linaro.org/people/<wbr>pmay=
dell/misc-scripts.git/</a><br>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;<a href=3D"https://git.linaro.org/people/pmayde=
ll/misc-scripts.git/" target=3D"_blank">https://git.linaro.org/<wbr>people/=
pmaydell/misc-scripts.<wbr>git/</a>&gt;<br>
&gt; <br>
&gt; I always assumed that pull requests by sub-maintainers should contain<=
br>
&gt; &quot;ready for merging&quot; code (justified, reviewed, tested, ...).=
 Why would<br>
&gt; ever a sub-maintainer send something that doesn&#39;t comply to these<=
br>
&gt; conditions?<br>
<br>
Because things can and do go wrong, perhaps someone was on vacation<br>
while the original patch was posted, perhaps somebody is giving a<br>
negative review outside his maintenance area, perhaps there would be<br>
conflicts with a tree-wide series being discussed elsewhere...=C2=A0 It&#39=
;s<br>
rare and I don&#39;t think it would be misused, but I think it&#39;s a good=
 idea<br>
to have a machine-readable way to block patches.<br>
<br></blockquote><div><br></div><div>I&#39;m afraid this would be opening a=
 Pandora&#39;s box. For such rare cases, a message from a person: &quot;Ple=
ase hold on this patch until I am back from vacation.&quot;, &quot;Please w=
ait until I merge my series acting on the same files&quot;, or similar, wou=
ld perfectly do the job, as it did in the past.</div><div><br></div><div>We=
 are fixing something that is not broken.</div><div>=C2=A0</div><blockquote=
 class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc soli=
d;padding-left:1ex">
However, I&#39;m not sure why the commits would contain a tag.=C2=A0 Instea=
d, we<br>
could use the patchew REST API<br>
(<a href=3D"https://patchew.org/api/v1/projects/1/series/MESSAGE-ID/" targe=
t=3D"_blank">https://patchew.org/api/v1/<wbr>projects/1/series/MESSAGE-ID/<=
/a>) and search<br>
for nacked-by tags in there.<br>
<br>
Paolo<br>
<br>
&gt; I think, in general, this tag would do more harm than good, allowing<b=
r>
&gt; frivolous blocking of patches, and fixing a process that already works=
,<br>
&gt; without any need.<br>
<br>
</blockquote>

--000000000000ac12c6059942a240--

