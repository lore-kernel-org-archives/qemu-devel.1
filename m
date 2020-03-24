Return-Path: <SRS0=M7c2=5J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFFE6C4332B
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 12:49:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B421207FF
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 12:49:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DMqywKWn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B421207FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48180 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGj0I-0005oC-Pt
	for qemu-devel@archiver.kernel.org; Tue, 24 Mar 2020 08:49:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44571)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yuval.shaia.ml@gmail.com>) id 1jGizN-0005PR-T5
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 08:49:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yuval.shaia.ml@gmail.com>) id 1jGizL-0005rG-Oj
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 08:49:00 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:34580)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <yuval.shaia.ml@gmail.com>)
 id 1jGizL-0005qt-HU
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 08:48:59 -0400
Received: by mail-ot1-x342.google.com with SMTP id j16so16868598otl.1
 for <qemu-devel@nongnu.org>; Tue, 24 Mar 2020 05:48:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Zc5odsz8Zn1SvgSHeKWaYmzlpr++Cr8HPeHQdbUIL/M=;
 b=DMqywKWnnNT0y6udoR7akVb+1yPl8hV/kcZaejqzT7bVNJLnUlKIvlTulZEgCPFSRy
 2Ano+od8bl9bqZi0wnB+Xi455lTttMZcDGX/KM9PqIsgEYff1ZuNgZzNXdj09egRzr99
 iLDPLcV7wQlKG2VUWVaJvmirsaej5qLzdZPV16vCXyr8B4SGcyR9+d7ovkf4EWoBHarl
 9tP5QBD7S1+/zD4+hMEr7m+lv9C3ZPLYi+eyQJ3Pos3lLtKvWP+gTFaUeqQ9rqiOP2zs
 rCVWyKrDxLowYjcSBwfMdc2NwGeNvufaiTq9WL88yG0XYugYzP8YfHl0QmvbKLM7kPOZ
 27RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Zc5odsz8Zn1SvgSHeKWaYmzlpr++Cr8HPeHQdbUIL/M=;
 b=jWVaXjmmLsAbZuNwxDtEkwvuOopsFIkFdsEFrklK7pNO149hG7/nT7qagJIa7EESwC
 gEH+lo9gGjyV+e4xij+2jtbsstRQqohSnXO+qU647xxWv1wRg4aTLxPFF6YZ6ebi7kCX
 wn1xlE17SbSetYKcFSAcbVSqwm0vHyqk/gW7nXr44t5FlsnD9p1UMfWoodW+MnniuSv2
 m9XbMVvZKKMKTRj3qdSpfTT0oTZdONQgqOP8yhM5Cowi2/qcBlfhIycJ1dc+hyPAt79W
 BfPawMjJnP6jVK4tPvYJlrLTz2RWSa4z3HVOgPiSxj3bHrA0xaKvdKuxLtBmLlx3yTOI
 5ABA==
X-Gm-Message-State: ANhLgQ3Py5TyH+F+bbybe+yH1e/PBjtfaSociWnzJm6tZhAn6PDKhvuB
 fkvHAhBa3yW2BcnqHtVNi6Tmkukl7QX+YLYA5pg=
X-Google-Smtp-Source: ADFU+vurXkRwxjoMe/aJjLa/HX6rcjRQ5KPSZgHxsPcAllF3YPpaKvSODoP5Jx7kI45SLmDMtSSJ0ySfOklT3ddw9Xk=
X-Received: by 2002:a9d:748e:: with SMTP id t14mr11688726otk.334.1585054138447; 
 Tue, 24 Mar 2020 05:48:58 -0700 (PDT)
MIME-Version: 1.0
References: <20200324105356.7998-1-yuval.shaia.ml@gmail.com>
 <CAFEAcA_D3ykX2mJwtJhvdQg3psCX9NdcG0xq4qmP3CkqHtnY8Q@mail.gmail.com>
 <72691a5a-8992-ec54-f2de-6209cafcc426@gmail.com>
 <CAFEAcA-YC7qBBt7Omakgk9-nA3EP-m3M7f2YGEt3PM4f8YFe7A@mail.gmail.com>
In-Reply-To: <CAFEAcA-YC7qBBt7Omakgk9-nA3EP-m3M7f2YGEt3PM4f8YFe7A@mail.gmail.com>
From: Yuval Shaia <yuval.shaia.ml@gmail.com>
Date: Tue, 24 Mar 2020 14:48:47 +0200
Message-ID: <CAMPkWoNCjF7e--3zYXkJnBtzX45gNv43u_gfQ6=QqNFWXoDeOg@mail.gmail.com>
Subject: Re: [PATCH] hw/rdma: Lock before destroy
To: Peter Maydell <peter.maydell@linaro.org>
Content-Type: multipart/alternative; boundary="000000000000df3da405a1992cca"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::342
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000df3da405a1992cca
Content-Type: text/plain; charset="UTF-8"

On Tue, 24 Mar 2020 at 13:25, Peter Maydell <peter.maydell@linaro.org>
wrote:

> On Tue, 24 Mar 2020 at 11:18, Marcel Apfelbaum
> <marcel.apfelbaum@gmail.com> wrote:
> >
> > Hi Peter,Yuval
> >
> > On 3/24/20 1:05 PM, Peter Maydell wrote:
> > > So I think we require that the user of a protected-qlist
> > > ensures that there are no more users of it before it is
> > > destroyed (which is fairly normal semantics), and the code
> > > as it stands is correct (ie coverity false-positive).
> >
> > I agree is a false positive for our case.
> > "rdma_protected_qlist_destroy" is called by "mad_fini" which in turn is
> > called by "rdma_backend_fini"
> > *after* the VM shutdown, at this point there is no active lock user.
>
> Also, the function coverity queried was rdma_protected_gslist_destroy(),
> not rdma_protected_qlist_destroy().
>

Yeah but pattern is the same, if we agree to threat it as false-positive
then it applies to the two cases.


>
> I notice that the gslist_destroy function does not destroy
> the mutex -- is this an intentional difference ?
>

No - it is a bug!


>
> thanks
> -- PMM
>

--000000000000df3da405a1992cca
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Tue, 24 Mar 2020 at 13:25, Peter M=
aydell &lt;<a href=3D"mailto:peter.maydell@linaro.org">peter.maydell@linaro=
.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"mar=
gin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1=
ex">On Tue, 24 Mar 2020 at 11:18, Marcel Apfelbaum<br>
&lt;<a href=3D"mailto:marcel.apfelbaum@gmail.com" target=3D"_blank">marcel.=
apfelbaum@gmail.com</a>&gt; wrote:<br>
&gt;<br>
&gt; Hi Peter,Yuval<br>
&gt;<br>
&gt; On 3/24/20 1:05 PM, Peter Maydell wrote:<br>
&gt; &gt; So I think we require that the user of a protected-qlist<br>
&gt; &gt; ensures that there are no more users of it before it is<br>
&gt; &gt; destroyed (which is fairly normal semantics), and the code<br>
&gt; &gt; as it stands is correct (ie coverity false-positive).<br>
&gt;<br>
&gt; I agree is a false positive for our case.<br>
&gt; &quot;rdma_protected_qlist_destroy&quot; is called by &quot;mad_fini&q=
uot; which in turn is<br>
&gt; called by &quot;rdma_backend_fini&quot;<br>
&gt; *after* the VM shutdown, at this point there is no active lock user.<b=
r>
<br>
Also, the function coverity queried was rdma_protected_gslist_destroy(),<br=
>
not rdma_protected_qlist_destroy().<br></blockquote><div><br></div><div>Yea=
h but pattern is the same, if we agree to threat it as false-positive then =
it applies to the two cases.</div><div>=C2=A0</div><blockquote class=3D"gma=
il_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,2=
04,204);padding-left:1ex">
<br>
I notice that the gslist_destroy function does not destroy<br>
the mutex -- is this an intentional difference ?<br></blockquote><div><br><=
/div><div>No - it is a bug!</div><div>=C2=A0</div><blockquote class=3D"gmai=
l_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,20=
4,204);padding-left:1ex">
<br>
thanks<br>
-- PMM<br>
</blockquote></div></div>

--000000000000df3da405a1992cca--

