Return-Path: <SRS0=M7c2=5J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EC80C43331
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 11:26:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED6BF20786
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 11:26:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wes6WVd/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED6BF20786
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47010 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGhhc-00046w-69
	for qemu-devel@archiver.kernel.org; Tue, 24 Mar 2020 07:26:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34397)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yuval.shaia.ml@gmail.com>) id 1jGhgr-0003Fp-LN
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 07:25:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yuval.shaia.ml@gmail.com>) id 1jGhgq-0001m3-5a
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 07:25:49 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:34955)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <yuval.shaia.ml@gmail.com>)
 id 1jGhgp-0001lp-WB
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 07:25:48 -0400
Received: by mail-ot1-x344.google.com with SMTP id k26so16668901otr.2
 for <qemu-devel@nongnu.org>; Tue, 24 Mar 2020 04:25:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=rt6x2BSCwcyDqYYf/33zOpvifF/bsmBQW/NcutrNWKw=;
 b=Wes6WVd/J+O3Aw0ewL6GBFUev4PV3T/4SaKqWMFm+z4hlPwOh3ppGLTr4oztcsiir1
 58ROsKFaGun2tYimfy7NeP0cLwc01P2yHTWCDFLnXBdLv1fL8rLRSRiZp+PBXSsMx4ul
 tGMjmsuk9c5lJ1soZuuLI1NMARQKaHovRI6BY50JIYzY94470jgPNNMyMjBDWJnJze4p
 xYqBTzmkNFnb/7YeVlm1utu3DmcKTtz1HuX0Jl1n687qcCyc2SIRXb90WKAOKoL1WHEK
 TxgDE4P7aXBjG5qcM5sX/LuJHt2seIFYT28+Ob70xJgXMSB/c3SdG8Yab02fYjtv7t6L
 NTPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=rt6x2BSCwcyDqYYf/33zOpvifF/bsmBQW/NcutrNWKw=;
 b=bt+vDdA92DcVmzdYhVTL5X+Da7KFEUn0aqstcV4eD5zBZytYWrPm9Ntp1Tjg1Q6KnN
 +vfyLbI1XZJJIlZnBO0ystuNuxwRlWb6wsMzA4JPxVWJ4jf+ml7P+u2uC/qMqkI9jMmc
 gPtvvHEatopZSQRbhddT5/oVZ/jlGtfHkGrOAEkMqhzATYePbPR/sgIRRkykLE9eAh7f
 iZ6+bCu9RU6opj4fWqSPY8l0csxx2z0QQjyTroAw6wvghVVoli7PO+wU8G4FqVh6FTGj
 wCpURVEByC8fZzv8MK8JH4ZDmdfOEqAb0WC7tWseqF0ljo9+Th/LZK2/12pR10PVsaCj
 vxhQ==
X-Gm-Message-State: ANhLgQ2U7mbG/ZhFcmGVZxnIWabVlUBxxwdQ4oPwxa/ZtnC5gIDjaMJU
 iaCW2IA+4PIx+4gr4DWOpZvwIPl5ouCcJs6NWg4=
X-Google-Smtp-Source: ADFU+vsmOdPjnaief2qXnb5uveUANr2mv0MP0T1k5d4XPnaVxYeB+V8i5uChEZzrHF+TJnzTnYbBMGMPKbOO1RYX1Rc=
X-Received: by 2002:a9d:470c:: with SMTP id a12mr20638055otf.372.1585049147033; 
 Tue, 24 Mar 2020 04:25:47 -0700 (PDT)
MIME-Version: 1.0
References: <20200324105356.7998-1-yuval.shaia.ml@gmail.com>
 <CAFEAcA_D3ykX2mJwtJhvdQg3psCX9NdcG0xq4qmP3CkqHtnY8Q@mail.gmail.com>
 <72691a5a-8992-ec54-f2de-6209cafcc426@gmail.com>
In-Reply-To: <72691a5a-8992-ec54-f2de-6209cafcc426@gmail.com>
From: Yuval Shaia <yuval.shaia.ml@gmail.com>
Date: Tue, 24 Mar 2020 13:25:36 +0200
Message-ID: <CAMPkWoNqKpn22Y70vZizFqd3BQjVJaSwjE25KwHOcMJaZsY17w@mail.gmail.com>
Subject: Re: [PATCH] hw/rdma: Lock before destroy
To: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Content-Type: multipart/alternative; boundary="0000000000005c4c2f05a19803ad"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::344
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
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000005c4c2f05a19803ad
Content-Type: text/plain; charset="UTF-8"

On Tue, 24 Mar 2020 at 13:18, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
wrote:

> Hi Peter,Yuval
>
> On 3/24/20 1:05 PM, Peter Maydell wrote:
> > On Tue, 24 Mar 2020 at 10:54, Yuval Shaia <yuval.shaia.ml@gmail.com>
> wrote:
> >> To protect from the case that users of the protected_qlist are still
> >> using the qlist let's lock before detsroying it.
> >>
> >> Reported-by: Coverity (CID 1421951)
> >> Signed-off-by: Yuval Shaia <yuval.shaia.ml@gmail.com>
> >> ---
> >>   hw/rdma/rdma_utils.c | 1 +
> >>   1 file changed, 1 insertion(+)
> >>
> >> diff --git a/hw/rdma/rdma_utils.c b/hw/rdma/rdma_utils.c
> >> index 73f279104c..55779cbef6 100644
> >> --- a/hw/rdma/rdma_utils.c
> >> +++ b/hw/rdma/rdma_utils.c
> >> @@ -63,6 +63,7 @@ void rdma_protected_qlist_init(RdmaProtectedQList
> *list)
> >>   void rdma_protected_qlist_destroy(RdmaProtectedQList *list)
> >>   {
> >>       if (list->list) {
> >> +        qemu_mutex_lock(&list->lock);
> >>           qlist_destroy_obj(QOBJECT(list->list));
> >>           qemu_mutex_destroy(&list->lock);
> >>           list->list = NULL;
> > Looking at the code a bit more closely, I don't think that taking
> > the lock here helps. If there really could be another thread
> > that might be calling eg rdma_protected_qlist_append_int64()
> > at the same time that we're calling rdma_protected_qlist_destroy()
> > then it's just as likely that the code calling destroy could
> > finish just before the append starts: in that case the append
> > will crash because the list has been freed and the mutex destroyed.
> >
> > So I think we require that the user of a protected-qlist
> > ensures that there are no more users of it before it is
> > destroyed (which is fairly normal semantics), and the code
> > as it stands is correct (ie coverity false-positive).
>
> I agree is a false positive for our case.
> "rdma_protected_qlist_destroy" is called by "mad_fini" which in turn is
> called by "rdma_backend_fini"
> *after* the VM shutdown, at this point there is no active lock user.
>

As i already said, current code makes sure it will not happen however it
better that API will ensure this and will not trust callers.


>
> Thanks,
> Marcel
>
> > thanks
> > -- PMM
>
>

--0000000000005c4c2f05a19803ad
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Tue, 24 Mar 2020 at 13:18, Marcel =
Apfelbaum &lt;<a href=3D"mailto:marcel.apfelbaum@gmail.com">marcel.apfelbau=
m@gmail.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">Hi Peter,Yuval<br>
<br>
On 3/24/20 1:05 PM, Peter Maydell wrote:<br>
&gt; On Tue, 24 Mar 2020 at 10:54, Yuval Shaia &lt;<a href=3D"mailto:yuval.=
shaia.ml@gmail.com" target=3D"_blank">yuval.shaia.ml@gmail.com</a>&gt; wrot=
e:<br>
&gt;&gt; To protect from the case that users of the protected_qlist are sti=
ll<br>
&gt;&gt; using the qlist let&#39;s lock before detsroying it.<br>
&gt;&gt;<br>
&gt;&gt; Reported-by: Coverity (CID 1421951)<br>
&gt;&gt; Signed-off-by: Yuval Shaia &lt;<a href=3D"mailto:yuval.shaia.ml@gm=
ail.com" target=3D"_blank">yuval.shaia.ml@gmail.com</a>&gt;<br>
&gt;&gt; ---<br>
&gt;&gt;=C2=A0 =C2=A0hw/rdma/rdma_utils.c | 1 +<br>
&gt;&gt;=C2=A0 =C2=A01 file changed, 1 insertion(+)<br>
&gt;&gt;<br>
&gt;&gt; diff --git a/hw/rdma/rdma_utils.c b/hw/rdma/rdma_utils.c<br>
&gt;&gt; index 73f279104c..55779cbef6 100644<br>
&gt;&gt; --- a/hw/rdma/rdma_utils.c<br>
&gt;&gt; +++ b/hw/rdma/rdma_utils.c<br>
&gt;&gt; @@ -63,6 +63,7 @@ void rdma_protected_qlist_init(RdmaProtectedQLis=
t *list)<br>
&gt;&gt;=C2=A0 =C2=A0void rdma_protected_qlist_destroy(RdmaProtectedQList *=
list)<br>
&gt;&gt;=C2=A0 =C2=A0{<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (list-&gt;list) {<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_mutex_lock(&amp;list-&gt;lock);<=
br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0qlist_destroy_obj(QOBJECT(=
list-&gt;list));<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0qemu_mutex_destroy(&amp;li=
st-&gt;lock);<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0list-&gt;list =3D NULL;<br=
>
&gt; Looking at the code a bit more closely, I don&#39;t think that taking<=
br>
&gt; the lock here helps. If there really could be another thread<br>
&gt; that might be calling eg rdma_protected_qlist_append_int64()<br>
&gt; at the same time that we&#39;re calling rdma_protected_qlist_destroy()=
<br>
&gt; then it&#39;s just as likely that the code calling destroy could<br>
&gt; finish just before the append starts: in that case the append<br>
&gt; will crash because the list has been freed and the mutex destroyed.<br=
>
&gt;<br>
&gt; So I think we require that the user of a protected-qlist<br>
&gt; ensures that there are no more users of it before it is<br>
&gt; destroyed (which is fairly normal semantics), and the code<br>
&gt; as it stands is correct (ie coverity false-positive).<br>
<br>
I agree is a false positive for our case.<br>
&quot;rdma_protected_qlist_destroy&quot; is called by &quot;mad_fini&quot; =
which in turn is <br>
called by &quot;rdma_backend_fini&quot;<br>
*after* the VM shutdown, at this point there is no active lock user.<br></b=
lockquote><div><br></div><div>As i already said, current code makes sure it=
 will not happen however it better that API will ensure this and will not t=
rust callers.</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">
<br>
Thanks,<br>
Marcel<br>
<br>
&gt; thanks<br>
&gt; -- PMM<br>
<br>
</blockquote></div></div>

--0000000000005c4c2f05a19803ad--

