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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F5E9C4332B
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 10:06:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 688AE20775
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 10:06:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PlkQ1tgO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 688AE20775
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45316 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGgRu-00007Y-D2
	for qemu-devel@archiver.kernel.org; Tue, 24 Mar 2020 06:06:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49639)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yuval.shaia.ml@gmail.com>) id 1jGgQR-0007BS-8Y
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 06:04:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yuval.shaia.ml@gmail.com>) id 1jGgQP-0001FH-Sp
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 06:04:47 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:44695)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <yuval.shaia.ml@gmail.com>)
 id 1jGgQP-0001Eg-Mn
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 06:04:45 -0400
Received: by mail-ot1-x341.google.com with SMTP id a49so16412578otc.11
 for <qemu-devel@nongnu.org>; Tue, 24 Mar 2020 03:04:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ScsCWkCC1HMSXVs54n3zmnU3aeTPc9GMhd1nGtsZZs0=;
 b=PlkQ1tgOxqR9lNcjMP6EHx3i9W3MS7lglegfh+4At8bmKeUDyZ6ccjKztOG+/2tLP6
 i4HeXRjsJudaR2iOyJmSci5whJcfu+inbbFfUWJCRl6p0R5xNmSGRtVvFvo3Km0XwUNt
 WkL4q4oBhPUf7VNiY99+3O7yBJZgSKIBKFJQbaaJ+VwJ1VQIdUCW6Cid9BMBgSBvzAb5
 p6yufokc8HILdYMBBQYHnb7vB855RCqGwn1HVfYxTxF0FwF6Nqwu2RA3ezAkVCjrMGYl
 6HjWQ6rWT1l86FLXbV424ZKR0ef6VaEOVV1r96AW1DCUTUovuQ2BaxqNzEemFKQi0RAq
 wuzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ScsCWkCC1HMSXVs54n3zmnU3aeTPc9GMhd1nGtsZZs0=;
 b=DpxmrFzrdP2NbfIriVDJ8X2cexBL0jugFRGfeBd1YtPh7rF/V7LNc6SLdHMwWyq/CC
 kATX+/LgM2jA2hp32osaZcbcBwoqnJCYj6ABBoKkj5J3Hd+TrAsHIPMdg0gGcyJT6FNk
 YpLuMlxCw1kZLYdivpnpFvYehQ8hINjVBrz3GQmqGwaeuqRQVdfSvI04zoVfGfpeYoBS
 KiBgFu9t794n6j+j00VnAQ2k1gvCHh0poecVLTQRHnwcUqioO8/5CsaskYlSCv05zKew
 LzDk4agpu+WrGmTdwtMdHkhteUkHjHbrwvwTscj1xWTlvfjZdI1KVgt0xJ2Yp43vLInk
 Z53Q==
X-Gm-Message-State: ANhLgQ2R1xdD0iRgss0+NhLn+Ds3d/GXHKrSKIj/F+5XcNuJxpJpq/m8
 p4fvXK0N3fguNjLhQ6nANH6MZ6cmZC0vENSUXgY=
X-Google-Smtp-Source: ADFU+vuwiOKQazsduZii1zTNVYD18dkVT97Xy/NcCzKJupS4RATwPW/k6QepXjECRDyy7DqIuP8o/WAmIpSOXbfkXM4=
X-Received: by 2002:a9d:4009:: with SMTP id m9mr4363468ote.132.1585044284278; 
 Tue, 24 Mar 2020 03:04:44 -0700 (PDT)
MIME-Version: 1.0
References: <20190310084610.23077-1-yuval.shaia@oracle.com>
 <20190310084610.23077-8-yuval.shaia@oracle.com>
 <CAFEAcA86hGnX5MfZjzfR0486qNOXfLmC+YSfc7GOc7d9jakrFQ@mail.gmail.com>
 <CAMPkWoML1fuZht6-doBPjEKMMb77O+diA=5Eg+bFV0OM7ZhcYg@mail.gmail.com>
In-Reply-To: <CAMPkWoML1fuZht6-doBPjEKMMb77O+diA=5Eg+bFV0OM7ZhcYg@mail.gmail.com>
From: Yuval Shaia <yuval.shaia.ml@gmail.com>
Date: Tue, 24 Mar 2020 12:04:33 +0200
Message-ID: <CAMPkWoNg4KvAQTRGw0M=mx6V=-5My5JeiV8+OVhRxqnhuF6LVw@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH v5 07/10] hw/rdma: Free all receive buffers
 when QP is destroyed
To: Peter Maydell <peter.maydell@linaro.org>
Content-Type: multipart/alternative; boundary="000000000000848a4b05a196e1c1"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::341
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

--000000000000848a4b05a196e1c1
Content-Type: text/plain; charset="UTF-8"

On Tue, 24 Mar 2020 at 11:56, Yuval Shaia <yuval.shaia.ml@gmail.com> wrote:

>
>
> On Mon, 23 Mar 2020 at 12:32, Peter Maydell <peter.maydell@linaro.org>
> wrote:
>
>> On Sun, 10 Mar 2019 at 09:25, Yuval Shaia <yuval.shaia@oracle.com> wrote:
>> >
>> > When QP is destroyed the backend QP is destroyed as well. This ensures
>> > we clean all received buffer we posted to it.
>> > However, a contexts of these buffers are still remain in the device.
>> > Fix it by maintaining a list of buffer's context and free them when QP
>> > is destroyed.
>> >
>> > Signed-off-by: Yuval Shaia <yuval.shaia@oracle.com>
>> > Reviewed-by: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
>>
>> Hi; Coverity has just raised an issue on this code (CID 1421951):
>>
>> > diff --git a/hw/rdma/rdma_utils.c b/hw/rdma/rdma_utils.c
>> > index 0a8abe572d..73f279104c 100644
>> > --- a/hw/rdma/rdma_utils.c
>> > +++ b/hw/rdma/rdma_utils.c
>> > @@ -90,3 +90,32 @@ int64_t
>> rdma_protected_qlist_pop_int64(RdmaProtectedQList *list)
>> >
>> >      return qnum_get_uint(qobject_to(QNum, obj));
>> >  }
>> > +
>> > +void rdma_protected_gslist_init(RdmaProtectedGSList *list)
>> > +{
>> > +    qemu_mutex_init(&list->lock);
>> > +}
>> > +
>> > +void rdma_protected_gslist_destroy(RdmaProtectedGSList *list)
>> > +{
>> > +    if (list->list) {
>> > +        g_slist_free(list->list);
>> > +        list->list = NULL;
>> > +    }
>>
>> Coverity wonders whether this function should take the list->lock
>> before freeing the list, because the other places which manipulate
>> list->list take the lock.
>>
>> > +}
>>
>> This is one of those Coverity checks which is quite prone to
>> false positives because it's just heuristically saying "you
>> look like you take the lock when you modify this field elsewhere,
>> maybe this place should take the lock too". Does this function
>> need to take a lock, or does the code that uses it guarantee
>> that it's never possible for another thread to be running
>> with access to the structure once we decide to destroy it?
>>
>
> It hit a real error here.
>
> Will fix and post a patch soon.
>
> Thanks,
> Yuval
>

For clarification: The code that uses this API make sure not to access the
qlist after it is destroyed *but* we cannot trust that in the future caller
will not do that.


>
>> thanks
>> -- PMM
>>
>>

--000000000000848a4b05a196e1c1
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Tue, 24 Mar 2020 at 11:56, Yuval S=
haia &lt;<a href=3D"mailto:yuval.shaia.ml@gmail.com">yuval.shaia.ml@gmail.c=
om</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margi=
n:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex=
"><div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote=
"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, 23 Mar 2020 at 12:32, Peter=
 Maydell &lt;<a href=3D"mailto:peter.maydell@linaro.org" target=3D"_blank">=
peter.maydell@linaro.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail=
_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204=
,204);padding-left:1ex">On Sun, 10 Mar 2019 at 09:25, Yuval Shaia &lt;<a hr=
ef=3D"mailto:yuval.shaia@oracle.com" target=3D"_blank">yuval.shaia@oracle.c=
om</a>&gt; wrote:<br>
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
l</div></div></div></blockquote><div><br></div><div>For clarification: The =
code that uses this API make sure not to access the=C2=A0 qlist after it is=
 destroyed *but* we cannot trust that in the future caller will not do that=
.</div><div><br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px=
 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><di=
v dir=3D"ltr"><div class=3D"gmail_quote"><div><br></div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex">
<br>
thanks<br>
-- PMM<br>
<br>
</blockquote></div></div>
</blockquote></div></div>

--000000000000848a4b05a196e1c1--

