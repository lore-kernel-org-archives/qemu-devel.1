Return-Path: <SRS0=IEfc=4J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15F7CC3565B
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 18:30:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D28F3206DB
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 18:30:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i6xw2HBW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D28F3206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34904 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j5D4R-0006Yd-14
	for qemu-devel@archiver.kernel.org; Fri, 21 Feb 2020 13:30:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49483)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@gmail.com>) id 1j5D3c-00060u-Mv
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 13:29:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1j5D3b-0003ha-89
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 13:29:48 -0500
Received: from mail-qk1-x742.google.com ([2607:f8b0:4864:20::742]:40236)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>)
 id 1j5D3b-0003fq-3d; Fri, 21 Feb 2020 13:29:47 -0500
Received: by mail-qk1-x742.google.com with SMTP id b7so2714651qkl.7;
 Fri, 21 Feb 2020 10:29:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=UxX7xlphznSD4tanR1YW8iehBtkVcYlveVGaoEOGnMY=;
 b=i6xw2HBWLHfQ2GPT19C9keVOMxbUdyXXo5G7iQ9d7hqC5X1rodw2YSwaKPlf28Qk7N
 kpf6vOr5eE9aQilvCVWoATaQzt2lqm3qpLQIm1YtqlPqSJFQnqRxw9Os81D5ugOwjYj8
 6f0+JKw6eNAgcgjUOn3IExAP0MTYfO/IaCIFln/b3KHwPXYry+hCsai00rkVoi188a0F
 PVr6CQNx4CWRWHhOwNAOlpZy+jpiwjzXFj6R53txsDPeBY6gfdKfGhtus/sXwSQBGqJV
 OAAZY//b4Y/ZW2Tt2mXMqxHkHhaN7phI7vgvFW/b8D0BeEr5hScxE5eMDsmNOvd0as1y
 2lbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=UxX7xlphznSD4tanR1YW8iehBtkVcYlveVGaoEOGnMY=;
 b=L7e3Sn5TQTSwHYm9U+If6/e0fZFLEXetc0AEKE8qABYOsuj+Y/wkR9UP4mr0IGWWhW
 Dz9lBFWNKqxwOana58729U7C1SBq5eJAd2ningRI+Y0qSzBVTs4rnFsHI9oLoXjBYTS/
 FYI1hEjD1pZuvAUDKVEl65mk6THNLXyxkszTqfxAAYMKdEhEHWIBWbRWyFTioYLYdZQq
 AECKUC1DdaasyQkhGESLhb1qoSt6+a5wuBW9zYK/5DrMEPOVBliN/hj/Nsw4tGYqaWlk
 LI7MT+L/ZG4BbTPY4iaomiu8dyz1GA21/yHghILkGNEzBOPg5R91hi2BAyFDWatpLarx
 v2RQ==
X-Gm-Message-State: APjAAAV0c4d/KzhyP3BDfji5YOUgmp5+naCEEWRAqUEvi6ChbnZflRIE
 rTFE2AQmeQdZ+g9qhewE79QwpWu52JtThvb6YoM=
X-Google-Smtp-Source: APXvYqyb7t6GGXj0MQBvKCBXPeQql/dWwocjINefHx+CsjiKpLk8aH+jFGcS0zTWnU4abIMRKbj2qIAqGDAryd2RibQ=
X-Received: by 2002:ae9:e518:: with SMTP id w24mr34018180qkf.236.1582309786409; 
 Fri, 21 Feb 2020 10:29:46 -0800 (PST)
MIME-Version: 1.0
References: <20200218224811.30050-1-andrzej.jakowski@linux.intel.com>
 <20200221134555.GK1484511@stefanha-x1.localdomain>
 <e8aa39fd-b5eb-8ed2-445b-02cce3301748@linux.intel.com>
 <CAJSP0QWXsZXBr_iVJp11FHYYj2Zb1NU62vA6kaR36mOH9B8abA@mail.gmail.com>
 <20200221175042.GJ2931@work-vm>
In-Reply-To: <20200221175042.GJ2931@work-vm>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Fri, 21 Feb 2020 18:29:35 +0000
Message-ID: <CAJSP0QVdyNFvfkOHXektAd_JLajEiadk4LtmMeO+0HmQTex5UA@mail.gmail.com>
Subject: Re: [PATCH v1] block/nvme: introduce PMR support from NVMe 1.4 spec
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000be601d059f1a34a1"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::742
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
Cc: Kevin Wolf <kwolf@redhat.com>, Haozhong Zhang <haozhong.zhang@intel.com>,
 qemu block <qemu-block@nongnu.org>, qemu-devel <qemu-devel@nongnu.org>,
 Max Reitz <mreitz@redhat.com>, Keith Busch <keith.busch@intel.com>,
 Zhang Yi <yi.z.zhang@linux.intel.com>,
 Andrzej Jakowski <andrzej.jakowski@linux.intel.com>,
 Junyan He <junyan.he@intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000be601d059f1a34a1
Content-Type: text/plain; charset="UTF-8"

On Fri, Feb 21, 2020, 17:50 Dr. David Alan Gilbert <dgilbert@redhat.com>
wrote:

> * Stefan Hajnoczi (stefanha@gmail.com) wrote:
> > On Fri, Feb 21, 2020 at 3:36 PM Andrzej Jakowski
> > <andrzej.jakowski@linux.intel.com> wrote:
> > > On 2/21/20 6:45 AM, Stefan Hajnoczi wrote:
> > > > Why is msync(2) done on memory loads instead of stores?
> > >
> > > This is my interpretation of NVMe spec wording with regards to PMRWBM
> field
> > > which says:
> > >
> > > "The completion of a memory read from any Persistent
> > > Memory Region address ensures that all prior writes to the
> > > Persistent Memory Region have completed and are
> > > persistent."
> >
> > Thanks, I haven't read the PMR section of the spec :).
> >
> > A synchronous operation is bad for virtualization performance.  While
> > the sync may be a cheap operation in hardware, it can be arbitrarily
> > expensive with msync(2).  The vCPU will be stuck until msync(2)
> > completes on the host.
> >
> > It's also a strange design choice since performance will suffer when
> > an unrelated read has to wait for writes to complete.  This is
> > especially problematic for multi-threaded applications or multi-core
> > systems where I guess this case is hit frequently.  Maybe it's so
> > cheap in hardware that it doesn't matter?  But then why didn't NVDIMM
> > use this mechanism?
> >
> > If anyone knows the answer I'd be interested in learning.  But this
> > isn't a criticism of the patch - of course it needs to implement the
> > hardware spec and we can't change it.
>
> Is this coming from the underlying PCIe spec ?
> In PCIe Base 4.0 Rev 0.3 Feb19-2014, section 2.4.1 Transaction ordering,
> there's a Table 2-39 and entry B2a in that table is:
>
>
>   'A Read Request must not pass a Posted Request unless B2b applies.'
>
> and a posted request is defined as a 'Memory Write Request or a Message
> Request'.
>
> ???
>

No, that relates to transaction ordering in PCI, not data persistence in
PMR.  PMR can define whatever persistence semantics it wants.

The completion of the write transaction at the PCI level does not mean data
has to be persistent at the PMR level.

Stefan

>

--000000000000be601d059f1a34a1
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D=
"gmail_attr">On Fri, Feb 21, 2020, 17:50 Dr. David Alan Gilbert &lt;<a href=
=3D"mailto:dgilbert@redhat.com">dgilbert@redhat.com</a>&gt; wrote:<br></div=
><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1=
px #ccc solid;padding-left:1ex">* Stefan Hajnoczi (<a href=3D"mailto:stefan=
ha@gmail.com" target=3D"_blank" rel=3D"noreferrer">stefanha@gmail.com</a>) =
wrote:<br>
&gt; On Fri, Feb 21, 2020 at 3:36 PM Andrzej Jakowski<br>
&gt; &lt;<a href=3D"mailto:andrzej.jakowski@linux.intel.com" target=3D"_bla=
nk" rel=3D"noreferrer">andrzej.jakowski@linux.intel.com</a>&gt; wrote:<br>
&gt; &gt; On 2/21/20 6:45 AM, Stefan Hajnoczi wrote:<br>
&gt; &gt; &gt; Why is msync(2) done on memory loads instead of stores?<br>
&gt; &gt;<br>
&gt; &gt; This is my interpretation of NVMe spec wording with regards to PM=
RWBM field<br>
&gt; &gt; which says:<br>
&gt; &gt;<br>
&gt; &gt; &quot;The completion of a memory read from any Persistent<br>
&gt; &gt; Memory Region address ensures that all prior writes to the<br>
&gt; &gt; Persistent Memory Region have completed and are<br>
&gt; &gt; persistent.&quot;<br>
&gt; <br>
&gt; Thanks, I haven&#39;t read the PMR section of the spec :).<br>
&gt; <br>
&gt; A synchronous operation is bad for virtualization performance.=C2=A0 W=
hile<br>
&gt; the sync may be a cheap operation in hardware, it can be arbitrarily<b=
r>
&gt; expensive with msync(2).=C2=A0 The vCPU will be stuck until msync(2)<b=
r>
&gt; completes on the host.<br>
&gt; <br>
&gt; It&#39;s also a strange design choice since performance will suffer wh=
en<br>
&gt; an unrelated read has to wait for writes to complete.=C2=A0 This is<br=
>
&gt; especially problematic for multi-threaded applications or multi-core<b=
r>
&gt; systems where I guess this case is hit frequently.=C2=A0 Maybe it&#39;=
s so<br>
&gt; cheap in hardware that it doesn&#39;t matter?=C2=A0 But then why didn&=
#39;t NVDIMM<br>
&gt; use this mechanism?<br>
&gt; <br>
&gt; If anyone knows the answer I&#39;d be interested in learning.=C2=A0 Bu=
t this<br>
&gt; isn&#39;t a criticism of the patch - of course it needs to implement t=
he<br>
&gt; hardware spec and we can&#39;t change it.<br>
<br>
Is this coming from the underlying PCIe spec ?<br>
In PCIe Base 4.0 Rev 0.3 Feb19-2014, section 2.4.1 Transaction ordering,<br=
>
there&#39;s a Table 2-39 and entry B2a in that table is:<br>
<br>
<br>
=C2=A0 &#39;A Read Request must not pass a Posted Request unless B2b applie=
s.&#39;<br>
<br>
and a posted request is defined as a &#39;Memory Write Request or a Message=
<br>
Request&#39;.<br>
<br>
???<br></blockquote></div></div><div dir=3D"auto"><br></div><div dir=3D"aut=
o">No, that relates to transaction ordering in PCI, not data persistence in=
 PMR.=C2=A0 PMR can define whatever persistence semantics it wants.</div><d=
iv dir=3D"auto"><br></div><div dir=3D"auto">The completion of the write tra=
nsaction at the PCI level does not mean data has to be persistent at the PM=
R level.</div><div dir=3D"auto"><br></div><div dir=3D"auto">Stefan</div><di=
v dir=3D"auto"><div class=3D"gmail_quote"><blockquote class=3D"gmail_quote"=
 style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
</blockquote></div></div></div>

--000000000000be601d059f1a34a1--

