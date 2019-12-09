Return-Path: <SRS0=fi8h=Z7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,HTML_OBFUSCATE_05_10,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0DB1C43603
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 09:29:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B0522073D
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 09:29:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HxFA9Ao1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B0522073D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37784 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ieFMC-00049m-OJ
	for qemu-devel@archiver.kernel.org; Mon, 09 Dec 2019 04:29:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46570)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1ieFLI-0003TG-SL
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 04:28:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1ieFLH-0004c2-9p
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 04:28:36 -0500
Received: from mail-ot1-x32c.google.com ([2607:f8b0:4864:20::32c]:44468)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1ieFLH-0004VR-1F
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 04:28:35 -0500
Received: by mail-ot1-x32c.google.com with SMTP id x3so11538924oto.11
 for <qemu-devel@nongnu.org>; Mon, 09 Dec 2019 01:28:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=wtCBeeIODP4ZTHeQP6vQOKTiOaSPA7vj4C/8ChadAX4=;
 b=HxFA9Ao1uRjeHb7xupooH+triNrD/5ZIvTf2JV1qzzYjPAVNCEnOyVRskR9uVX69px
 vbEJdzEJB9XsrtE+ZNHf/V3YHJSGd3vGF+XImCoEBe9fmlVNFg0LrvlalJWJcxDxcBrK
 UNirP0ktJ2BDt2JQ7uR8zp/3Y1QtqQuUS5FvPgU6H4m1V/J+oRyuKZHZC/+0Mr51oMwL
 NpggLLhbAZXv0Jl1BCwM9q8nasrJqQXb+CmARwrLYjyKqDWX4V9r7B57L9eWeMqR9GvQ
 6WNgaCBGWhabr7OGpvEsy8kwWVvNFGE82vpFXBcgmyDdQOx0wrpzNvatzuyRoT/LZ71V
 3gug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=wtCBeeIODP4ZTHeQP6vQOKTiOaSPA7vj4C/8ChadAX4=;
 b=DsdqVt7sdcqZgUOzxjkXdYK9mCd/VtPO1MbKTNbDEBR7j9TPitTbYbxs+r4AsaIKqy
 I4fBNf5IH0F3ESJDsNFEEPRuVydJYP8rgOPBupLklJKVqkHpmEzPfxs5hlSUh39vrFbw
 cG3hdB1w5NVmXjvQAaU5rbZG3VJ09UzUNi3hda0Irg5Y8qX0H6mh2NCDy2D1/RWVAyvY
 NcyJwoUweWBPAM3byEXkFl+Q5n0O3YzEbqeRKvH90wjmf9++2tU3rQ5x2Wi7Fbz8LizT
 LND/TLiZr7elQ5fQubWv4B3e3mHWj2/eW7Q68ubNWUrBb+qPCSZLBMIC7Y4VoUX40IQ7
 IY+g==
X-Gm-Message-State: APjAAAXFNdBc5Lrx6kJeepvkK8Ti5pJOIEN8qYB6v8TixQOTbfYdC/WQ
 HTjLsDe0ebssyJPbZLkzcaHLFqRRlTzeB4Mk8d4=
X-Google-Smtp-Source: APXvYqyTAIRgCvQuUiYwPSv1PNSd2Cqqrn8wfBlO9Uar82rhMSHp93heNRa5oSBIAwKRxMAzl0l4nBXe0OvHU9YBUQ8=
X-Received: by 2002:a9d:7c8f:: with SMTP id q15mr11492355otn.341.1575883713713; 
 Mon, 09 Dec 2019 01:28:33 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a9d:d21:0:0:0:0:0 with HTTP;
 Mon, 9 Dec 2019 01:28:33 -0800 (PST)
In-Reply-To: <4cbaadf8-ae4f-d086-2137-b83d61a5e9a5@redhat.com>
References: <4cbaadf8-ae4f-d086-2137-b83d61a5e9a5@redhat.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Mon, 9 Dec 2019 10:28:33 +0100
Message-ID: <CAL1e-=ja7sdqC6sm_AxYkN-m_R__4dofj-WsYreHZB813OG9OA@mail.gmail.com>
Subject: Re: [RFC] Use of the Nacked-by tag by CI scripts
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000f69cab05994204fc"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::32c
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
 qemu-devel <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000f69cab05994204fc
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Monday, December 9, 2019, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com=
>
wrote:

> Hi,
>
> The Nacked-by tag can be used to manually hold a patch for further review=
,
> or by automatic CI because of failing test.
>
> We often miss travis-ci and shippable failures. These CI provide a easy
> way to send email on failure, we can integrate the Nacked-by use there.
>
> We can easily have patchew script send a Nacked-by tag.
>
> If there is a consensus about using this tag, the following patch can be
> added to Peter's management scripts:
> https://git.linaro.org/people/pmaydell/misc-scripts.git/
>


I always assumed that pull requests by sub-maintainers should contain
"ready for merging" code (justified, reviewed, tested, ...). Why would ever
a sub-maintainer send something that doesn't comply to these conditions?

I think, in general, this tag would do more harm than good, allowing
frivolous blocking of patches, and fixing a process that already works,
without any need.

Not acknowledged by me.

Sincerely,
Aleksandar




> If we move to another workflow, having this uniform tag can help future
> merging scripts to avoid patch on hold to get automatically merged.
>
> -- >8 --
> Subject: make-pullreq: Do not automatically merge NAcked commits
>
> The 'Nacked-by' tag is a polite way of holding a patch for
> further review. Reviewers might share their disapproval with
> it (see [1]).
>
> CI scripts might NAck a patch if it breaks testing.
> QEMU already thought about using this tag for CI by the past
> (see [2]).
>
> The patchwork tool already collects this tag (see [3]).
>
> Also, there was a discussion at the last Open Source Summit
> about standardizing it ([4]).
>
> Maintainers might miss a such Nacked-by tag. Help them by
> providing a last resort check before merging pull requests.
>
> [1] https://www.x.org/wiki/Development/Documentation/SubmittingP
> atches/#index1h1
> [2] https://lists.gnu.org/archive/html/qemu-devel/2013-01/msg00196.html
> [3] http://git.ozlabs.org/?p=3Dpatchwork;a=3Dblobdiff;f=3Dapps/patchwo
> rk/models.py;h=3Dfa213dc03e;hp=3D8871df0259e;hb=3D487b53576f;hpb=3Da59ebf=
107d84b
> [4] https://lore.kernel.org/workflows/CACT4Y+bxPxQ64HEO2uGRkbk9v
> JSeg64y10Lak4c2K54J7GyFFA@mail.gmail.com/
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  make-pullreq | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/make-pullreq b/make-pullreq
> index 61c0f1d..fff0b2d 100755
> --- a/make-pullreq
> +++ b/make-pullreq
> @@ -108,6 +108,17 @@ if [ "$bad" =3D "yes" ]; then
>     exit 1
>  fi
>
> +# Check no commit contains a nacked-by tag
> +for rev in $(git rev-list master..HEAD); do
> +    if git log ${rev}^! | grep -iq "Nacked-by:"; then
> +        echo "Error: commit ${rev} nacked"
> +        bad=3Dyes
> +    fi
> +done
> +if [ "$bad" =3D "yes" ]; then
> +   exit 1
> +fi
> +
>  # Check whether any authors needs to be corrected after SPF rewrites
>  if git shortlog --author=3Dqemu-devel@nongnu.org master..HEAD | grep .;
> then
>      echo "ERROR: pull request includes commits attributed to list"
> --
> 2.21.0
>
>
>

--000000000000f69cab05994204fc
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<br><br>On Monday, December 9, 2019, Philippe Mathieu-Daud=C3=A9 &lt;<a hre=
f=3D"mailto:philmd@redhat.com">philmd@redhat.com</a>&gt; wrote:<br><blockqu=
ote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc s=
olid;padding-left:1ex">Hi,<br>
<br>
The Nacked-by tag can be used to manually hold a patch for further review, =
or by automatic CI because of failing test.<br>
<br>
We often miss travis-ci and shippable failures. These CI provide a easy way=
 to send email on failure, we can integrate the Nacked-by use there.<br>
<br>
We can easily have patchew script send a Nacked-by tag.<br>
<br>
If there is a consensus about using this tag, the following patch can be ad=
ded to Peter&#39;s management scripts:<br>
<a href=3D"https://git.linaro.org/people/pmaydell/misc-scripts.git/" target=
=3D"_blank">https://git.linaro.org/people/<wbr>pmaydell/misc-scripts.git/</=
a><br></blockquote><div><br></div><div><br></div><div>I always assumed that=
 pull requests by sub-maintainers should contain &quot;ready for merging&qu=
ot; code (justified, reviewed, tested, ...). Why would ever a sub-maintaine=
r send something that doesn&#39;t comply to these conditions?</div><div><br=
></div><div>I think, in general, this tag would do more harm than good, all=
owing frivolous blocking of patches, and fixing a process that already work=
s, without any need.</div><div><br></div><div>Not acknowledged by me.</div>=
<div><br></div><div>Sincerely,</div><div>Aleksandar</div><div><br></div><di=
v><br></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"mar=
gin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
If we move to another workflow, having this uniform tag can help future mer=
ging scripts to avoid patch on hold to get automatically merged.<br>
<br>
-- &gt;8 --<br>
Subject: make-pullreq: Do not automatically merge NAcked commits<br>
<br>
The &#39;Nacked-by&#39; tag is a polite way of holding a patch for<br>
further review. Reviewers might share their disapproval with<br>
it (see [1]).<br>
<br>
CI scripts might NAck a patch if it breaks testing.<br>
QEMU already thought about using this tag for CI by the past<br>
(see [2]).<br>
<br>
The patchwork tool already collects this tag (see [3]).<br>
<br>
Also, there was a discussion at the last Open Source Summit<br>
about standardizing it ([4]).<br>
<br>
Maintainers might miss a such Nacked-by tag. Help them by<br>
providing a last resort check before merging pull requests.<br>
<br>
[1] <a href=3D"https://www.x.org/wiki/Development/Documentation/SubmittingP=
atches/#index1h1" target=3D"_blank">https://www.x.org/wiki/Develop<wbr>ment=
/Documentation/SubmittingP<wbr>atches/#index1h1</a><br>
[2] <a href=3D"https://lists.gnu.org/archive/html/qemu-devel/2013-01/msg001=
96.html" target=3D"_blank">https://lists.gnu.org/archive/<wbr>html/qemu-dev=
el/2013-01/msg001<wbr>96.html</a><br>
[3] <a href=3D"http://git.ozlabs.org/?p=3Dpatchwork;a=3Dblobdiff;f=3Dapps/p=
atchwork/models.py;h=3Dfa213dc03e;hp=3D8871df0259e;hb=3D487b53576f;hpb=3Da5=
9ebf107d84b" target=3D"_blank">http://git.ozlabs.org/?p=3Dpatch<wbr>work;a=
=3Dblobdiff;f=3Dapps/patchwo<wbr>rk/models.py;h=3Dfa213dc03e;hp=3D<wbr>8871=
df0259e;hb=3D487b53576f;hpb=3D<wbr>a59ebf107d84b</a><br>
[4] <a href=3D"https://lore.kernel.org/workflows/CACT4Y+bxPxQ64HEO2uGRkbk9v=
JSeg64y10Lak4c2K54J7GyFFA@mail.gmail.com/" target=3D"_blank">https://lore.k=
ernel.org/workfl<wbr>ows/CACT4Y+bxPxQ64HEO2uGRkbk9v<wbr>JSeg64y10Lak4c2K54J=
7GyFFA@<wbr>mail.gmail.com/</a><br>
<br>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@red=
hat.com" target=3D"_blank">philmd@redhat.com</a>&gt;<br>
---<br>
=C2=A0make-pullreq | 11 +++++++++++<br>
=C2=A01 file changed, 11 insertions(+)<br>
<br>
diff --git a/make-pullreq b/make-pullreq<br>
index 61c0f1d..fff0b2d 100755<br>
--- a/make-pullreq<br>
+++ b/make-pullreq<br>
@@ -108,6 +108,17 @@ if [ &quot;$bad&quot; =3D &quot;yes&quot; ]; then<br>
=C2=A0 =C2=A0 exit 1<br>
=C2=A0fi<br>
<br>
+# Check no commit contains a nacked-by tag<br>
+for rev in $(git rev-list master..HEAD); do<br>
+=C2=A0 =C2=A0 if git log ${rev}^! | grep -iq &quot;Nacked-by:&quot;; then<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 echo &quot;Error: commit ${rev} nacked&quot;<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 bad=3Dyes<br>
+=C2=A0 =C2=A0 fi<br>
+done<br>
+if [ &quot;$bad&quot; =3D &quot;yes&quot; ]; then<br>
+=C2=A0 =C2=A0exit 1<br>
+fi<br>
+<br>
=C2=A0# Check whether any authors needs to be corrected after SPF rewrites<=
br>
=C2=A0if git shortlog --author=3D<a href=3D"mailto:qemu-devel@nongnu.org" t=
arget=3D"_blank">qemu-devel@nongnu.org</a> master..HEAD | grep .; then<br>
=C2=A0 =C2=A0 =C2=A0echo &quot;ERROR: pull request includes commits attribu=
ted to list&quot;<br>
-- <br>
2.21.0<br>
<br>
<br>
</blockquote>

--000000000000f69cab05994204fc--

