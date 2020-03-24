Return-Path: <SRS0=M7c2=5J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BB3EC4332B
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 09:57:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0149C2070A
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 09:57:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iZPHlP6g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0149C2070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45220 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGgJl-0002pg-5N
	for qemu-devel@archiver.kernel.org; Tue, 24 Mar 2020 05:57:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48732)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yuval.shaia.ml@gmail.com>) id 1jGgJ6-0002Qs-WA
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 05:57:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yuval.shaia.ml@gmail.com>) id 1jGgJ5-00064s-PI
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 05:57:12 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:43135)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <yuval.shaia.ml@gmail.com>)
 id 1jGgJ5-00062a-KK
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 05:57:11 -0400
Received: by mail-ot1-x344.google.com with SMTP id a6so16343442otb.10
 for <qemu-devel@nongnu.org>; Tue, 24 Mar 2020 02:57:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=WB9MSPo9ouLwsmrJFSAYjX2HjolEvHiU+UeMQqTtN28=;
 b=iZPHlP6gTuKbNHtOioF3fKUfsCPBHEFIWdI1MEXvaJeYmIfcXd82pi+A7W+FdgzGar
 pwlppxT5kVdgJevBmwEMGDR87cNYTBNlX1UKNSrvBP7xf8K0w68Q4tQuylf0g7B1U7KB
 AYQUswneANQyrhsnxzpNKHYvmUO6zvMttwDWI6NPWatmt7mCr9p2L4c91ulUexuRk6p6
 tw69Ks0l20rh6HI/LP+ZFkuYTC6tHNftbay6JLCqxlCfLKgkuaQZ0ifA/Qp4K4XmYgkI
 RdT5UZbC4kFv53tc4D/L6ToF8SL3v7xhhupE7pDxalppv3gG1bNOuP4UVb0dWVLqui/u
 rcvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=WB9MSPo9ouLwsmrJFSAYjX2HjolEvHiU+UeMQqTtN28=;
 b=BArhQVeYhHmxoDqrHDedS8Sz74yjjJrFDcXODPr2VbY1PZ1RgW6LK060RyDDxCud2m
 Sj1HXQ1++VPN3fjs4TmjW8a/iGZl+kP6/AMxBD3dIRI+Gq3NAjyKz9ihyiQDju6Fj83s
 cFW7kZE5ljdD1EogkYvzdy1W6OCFNVjuKEcWdJEgsO+qqtfeQHQdCaVnQXgRuMACElDt
 p8TKPxC0Tvd8z0euFYHVgfGBKYJ4bcNB18bqLMWS6+fsfcnBO8hhIxEm5Pv1cvDsMLXU
 XC+C6YNXC8ZfWfgEY1VFCgD+v7k5Tm3NKttBlMmuNjiu7cv0VFuTPWdEcirYduse6JyS
 G4Mw==
X-Gm-Message-State: ANhLgQ2XozQADqG9DTHW7WH9S/te22a469T9zHOyfVbXAiPP2uKYzVIb
 IxyEikZVJnX8NrQs0RVjMVCe4clMUyaF2UbBGPCe2g==
X-Google-Smtp-Source: ADFU+vuxUxAYiasu64L0Uy4zkgGqa73YlTPfqGpZ/725v8aq9Y/hzNr0z176zbioKC/gJpNKlbZaDtV8nVKBbrzht/k=
X-Received: by 2002:a9d:470c:: with SMTP id a12mr20401451otf.372.1585043830745; 
 Tue, 24 Mar 2020 02:57:10 -0700 (PDT)
MIME-Version: 1.0
References: <20190310084610.23077-1-yuval.shaia@oracle.com>
 <20190310084610.23077-8-yuval.shaia@oracle.com>
 <CAFEAcA86hGnX5MfZjzfR0486qNOXfLmC+YSfc7GOc7d9jakrFQ@mail.gmail.com>
In-Reply-To: <CAFEAcA86hGnX5MfZjzfR0486qNOXfLmC+YSfc7GOc7d9jakrFQ@mail.gmail.com>
From: Yuval Shaia <yuval.shaia.ml@gmail.com>
Date: Tue, 24 Mar 2020 11:56:59 +0200
Message-ID: <CAMPkWoML1fuZht6-doBPjEKMMb77O+diA=5Eg+bFV0OM7ZhcYg@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH v5 07/10] hw/rdma: Free all receive buffers
 when QP is destroyed
To: Peter Maydell <peter.maydell@linaro.org>
Content-Type: multipart/alternative; boundary="0000000000007c2eb205a196c613"
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
Cc: Markus Armbruster <armbru@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Yuval Shaia <yuval.shaia@oracle.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000007c2eb205a196c613
Content-Type: text/plain; charset="UTF-8"

On Mon, 23 Mar 2020 at 12:32, Peter Maydell <peter.maydell@linaro.org>
wrote:

> On Sun, 10 Mar 2019 at 09:25, Yuval Shaia <yuval.shaia@oracle.com> wrote:
> >
> > When QP is destroyed the backend QP is destroyed as well. This ensures
> > we clean all received buffer we posted to it.
> > However, a contexts of these buffers are still remain in the device.
> > Fix it by maintaining a list of buffer's context and free them when QP
> > is destroyed.
> >
> > Signed-off-by: Yuval Shaia <yuval.shaia@oracle.com>
> > Reviewed-by: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
>
> Hi; Coverity has just raised an issue on this code (CID 1421951):
>
> > diff --git a/hw/rdma/rdma_utils.c b/hw/rdma/rdma_utils.c
> > index 0a8abe572d..73f279104c 100644
> > --- a/hw/rdma/rdma_utils.c
> > +++ b/hw/rdma/rdma_utils.c
> > @@ -90,3 +90,32 @@ int64_t
> rdma_protected_qlist_pop_int64(RdmaProtectedQList *list)
> >
> >      return qnum_get_uint(qobject_to(QNum, obj));
> >  }
> > +
> > +void rdma_protected_gslist_init(RdmaProtectedGSList *list)
> > +{
> > +    qemu_mutex_init(&list->lock);
> > +}
> > +
> > +void rdma_protected_gslist_destroy(RdmaProtectedGSList *list)
> > +{
> > +    if (list->list) {
> > +        g_slist_free(list->list);
> > +        list->list = NULL;
> > +    }
>
> Coverity wonders whether this function should take the list->lock
> before freeing the list, because the other places which manipulate
> list->list take the lock.
>
> > +}
>
> This is one of those Coverity checks which is quite prone to
> false positives because it's just heuristically saying "you
> look like you take the lock when you modify this field elsewhere,
> maybe this place should take the lock too". Does this function
> need to take a lock, or does the code that uses it guarantee
> that it's never possible for another thread to be running
> with access to the structure once we decide to destroy it?
>

It hit a real error here.

Will fix and post a patch soon.

Thanks,
Yuval


> thanks
> -- PMM
>
>

--0000000000007c2eb205a196c613
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Mon, 23 Mar 2020 at 12:32, Peter M=
aydell &lt;<a href=3D"mailto:peter.maydell@linaro.org">peter.maydell@linaro=
.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"mar=
gin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1=
ex">On Sun, 10 Mar 2019 at 09:25, Yuval Shaia &lt;<a href=3D"mailto:yuval.s=
haia@oracle.com" target=3D"_blank">yuval.shaia@oracle.com</a>&gt; wrote:<br=
>
&gt;<br>
&gt; When QP is destroyed the backend QP is destroyed as well. This ensures=
<br>
&gt; we clean all received buffer we posted to it.<br>
&gt; However, a contexts of these buffers are still remain in the device.<b=
r>
&gt; Fix it by maintaining a list of buffer&#39;s context and free them whe=
n QP<br>
&gt; is destroyed.<br>
&gt;<br>
&gt; Signed-off-by: Yuval Shaia &lt;<a href=3D"mailto:yuval.shaia@oracle.co=
m" target=3D"_blank">yuval.shaia@oracle.com</a>&gt;<br>
&gt; Reviewed-by: Marcel Apfelbaum &lt;<a href=3D"mailto:marcel.apfelbaum@g=
mail.com" target=3D"_blank">marcel.apfelbaum@gmail.com</a>&gt;<br>
<br>
Hi; Coverity has just raised an issue on this code (CID 1421951):<br>
<br>
&gt; diff --git a/hw/rdma/rdma_utils.c b/hw/rdma/rdma_utils.c<br>
&gt; index 0a8abe572d..73f279104c 100644<br>
&gt; --- a/hw/rdma/rdma_utils.c<br>
&gt; +++ b/hw/rdma/rdma_utils.c<br>
&gt; @@ -90,3 +90,32 @@ int64_t rdma_protected_qlist_pop_int64(RdmaProtecte=
dQList *list)<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 return qnum_get_uint(qobject_to(QNum, obj));<br>
&gt;=C2=A0 }<br>
&gt; +<br>
&gt; +void rdma_protected_gslist_init(RdmaProtectedGSList *list)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 qemu_mutex_init(&amp;list-&gt;lock);<br>
&gt; +}<br>
&gt; +<br>
&gt; +void rdma_protected_gslist_destroy(RdmaProtectedGSList *list)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 if (list-&gt;list) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_slist_free(list-&gt;list);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 list-&gt;list =3D NULL;<br>
&gt; +=C2=A0 =C2=A0 }<br>
<br>
Coverity wonders whether this function should take the list-&gt;lock<br>
before freeing the list, because the other places which manipulate<br>
list-&gt;list take the lock.<br>
<br>
&gt; +}<br>
<br>
This is one of those Coverity checks which is quite prone to<br>
false positives because it&#39;s just heuristically saying &quot;you<br>
look like you take the lock when you modify this field elsewhere,<br>
maybe this place should take the lock too&quot;. Does this function<br>
need to take a lock, or does the code that uses it guarantee<br>
that it&#39;s never possible for another thread to be running<br>
with access to the structure once we decide to destroy it?<br></blockquote>=
<div><br></div><div>It hit a real error here.</div><div><br></div><div>Will=
 fix and post a patch soon.</div><div><br></div><div>Thanks,</div><div>Yuva=
l</div><div><br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px=
 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
thanks<br>
-- PMM<br>
<br>
</blockquote></div></div>

--0000000000007c2eb205a196c613--

