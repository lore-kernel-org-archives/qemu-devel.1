Return-Path: <SRS0=LLOU=EL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FC75C00A89
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 09:41:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4918D20679
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 09:41:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=daynix-com.20150623.gappssmtp.com header.i=@daynix-com.20150623.gappssmtp.com header.b="yBDG2sVe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4918D20679
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54714 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kablg-0007qz-7r
	for qemu-devel@archiver.kernel.org; Thu, 05 Nov 2020 04:41:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41464)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuri.benditovich@daynix.com>)
 id 1kabks-0007Ma-0W
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 04:40:30 -0500
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:32848)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yuri.benditovich@daynix.com>)
 id 1kabkq-0003Il-7Q
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 04:40:29 -0500
Received: by mail-ot1-x342.google.com with SMTP id i18so865246ots.0
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2020 01:40:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=dQooAPuqESekVraoH6cKv9hp3PmfBpUoswYbcTiPVTc=;
 b=yBDG2sVelpo1y+FwELesMmZsZTw3R7o5e4h716d3cKuprV34gN+1f8vZWh0Hxf3PXX
 b905egYy3u4RR9Gkz7NTPmlSj5SnZA1WJmA6CXGIV0DWuHkknhLpMu9LVvru82D9vJRY
 ekXh4I/3htRHd/KznvLgb42msUfRPHuwrVbLoTtF0bBn1nDps1lqJygmvloICd2/WlH8
 w2fAJ/4sLSsqPCHJGTWmnsjblIShqeaGygmPDYw3CHTJ23iVUpdx61as6NM7UYtykI1A
 u/dmj9HSyAsmcRsIUCaauIvc1evHb0KnBD7BJzx7MvVy1WfZbuB5ZJ4JEoWvmyGnbYu1
 rZvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=dQooAPuqESekVraoH6cKv9hp3PmfBpUoswYbcTiPVTc=;
 b=Phfkt73yQPt89u/u6BQ8EyG9ZulMEJno6+W9Ng1KH/umH0HWdcHdJtsDpmUokyYpNK
 rQBMojU7OU+LNj/nV4QsEpHN/JAuX+xyAHU9+BqnV1HcYVbcvdatz3Km85l4ON0Ru1UJ
 eEhroXKYz4hiuJrZ0njvNv8yihrpNKitwj3nqE6WRuXXX4Dd0zQk8GGLpPSuTdoctNx5
 Zk5yKE+E8mMl7LqQ7K1UdhzgE/AUzMewECKfyENmXhXiM7Mlc6dxzqsJYp8CMSy3FXSC
 A+mzz7L7JYVavgqQtyU6Pgr2mlGkKgVgEjjZkZi+Hggcc9w+Ql18KK8NKsC4hSmruWgl
 5Oww==
X-Gm-Message-State: AOAM533u2DDznAUqZ2Oe6EKPTHEyLPjKQuBmW6+x/riF5f7tKXjVLhaI
 XA58SzUyoAFkg1PXtsREO3njLU7snYG9zAr4emH7MA==
X-Google-Smtp-Source: ABdhPJx6iKHxBSxIpDuyMjGhcBYj/UXKf7Ev2G9XE51zglV+vqjKSiHMHTHG6DI7w/ufPOKl9ryxraYRFqUY/JRQuxM=
X-Received: by 2002:a9d:61:: with SMTP id 88mr1023134ota.109.1604569226847;
 Thu, 05 Nov 2020 01:40:26 -0800 (PST)
MIME-Version: 1.0
References: <20201102185115.7425-1-andrew@daynix.com>
 <20201102185115.7425-7-andrew@daynix.com>
 <af85ed7a-1394-e1a4-e224-6ad232328800@redhat.com>
In-Reply-To: <af85ed7a-1394-e1a4-e224-6ad232328800@redhat.com>
From: Yuri Benditovich <yuri.benditovich@daynix.com>
Date: Thu, 5 Nov 2020 11:40:15 +0200
Message-ID: <CAOEp5Oe+W3qcN1Tfa3Z-Nb7+yxmy-G0FVZJU=ejZA8th92P3-w@mail.gmail.com>
Subject: Re: [RFC PATCH 6/6] docs: Added eBPF documentation.
To: Jason Wang <jasowang@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000c8c12905b358e200"
Received-SPF: none client-ip=2607:f8b0:4864:20::342;
 envelope-from=yuri.benditovich@daynix.com; helo=mail-ot1-x342.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: Yan Vugenfirer <yan@daynix.com>, Andrew Melnychenko <andrew@daynix.com>,
 qemu-devel@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000c8c12905b358e200
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 5, 2020 at 5:56 AM Jason Wang <jasowang@redhat.com> wrote:

>
> On 2020/11/3 =E4=B8=8A=E5=8D=882:51, Andrew Melnychenko wrote:
> > From: Andrew<andrew@daynix.com>
> >
> > Also, added maintainers information.
> >
> > Signed-off-by: Yuri Benditovich<yuri.benditovich@daynix.com>
> > Signed-off-by: Andrew Melnychenko<andrew@daynix.com>
> > ---
> >   MAINTAINERS       |   6 +++
> >   docs/ebpf.rst     |  29 +++++++++++
> >   docs/ebpf_rss.rst | 129 +++++++++++++++++++++++++++++++++++++++++++++=
+
> >   3 files changed, 164 insertions(+)
> >   create mode 100644 docs/ebpf.rst
> >   create mode 100644 docs/ebpf_rss.rst
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 2c22bbca5a..464b3f3c95 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -3111,6 +3111,12 @@ S: Maintained
> >   F: hw/semihosting/
> >   F: include/hw/semihosting/
> >
> > +EBPF:
> > +M: Andrew Melnychenko<andrew@daynix.com>
> > +M: Yuri Benditovich<yuri.benditovich@daynix.com>
> > +S: Maintained
> > +F: ebpf/*
> > +
>
>
> If it's possible, I would like to be one of the maintainer or at least
> reviewer :)
>
> With pleasure. We did not know who would want to maintain eBPF related
things, so we added ourselves as maintainers.
If you agree, we'll place you as a maintainer and ourselves as reviewers to
be informed about changes before they happen.

Thanks



> Thanks
>
>

--000000000000c8c12905b358e200
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Thu, Nov 5, 2020 at 5:56 AM Jason =
Wang &lt;<a href=3D"mailto:jasowang@redhat.com">jasowang@redhat.com</a>&gt;=
 wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px =
0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><br>
On 2020/11/3 =E4=B8=8A=E5=8D=882:51, Andrew Melnychenko wrote:<br>
&gt; From: Andrew&lt;<a href=3D"mailto:andrew@daynix.com" target=3D"_blank"=
>andrew@daynix.com</a>&gt;<br>
&gt;<br>
&gt; Also, added maintainers information.<br>
&gt;<br>
&gt; Signed-off-by: Yuri Benditovich&lt;<a href=3D"mailto:yuri.benditovich@=
daynix.com" target=3D"_blank">yuri.benditovich@daynix.com</a>&gt;<br>
&gt; Signed-off-by: Andrew Melnychenko&lt;<a href=3D"mailto:andrew@daynix.c=
om" target=3D"_blank">andrew@daynix.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 =C2=A0MAINTAINERS=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A06 +++<=
br>
&gt;=C2=A0 =C2=A0docs/ebpf.rst=C2=A0 =C2=A0 =C2=A0|=C2=A0 29 +++++++++++<br=
>
&gt;=C2=A0 =C2=A0docs/ebpf_rss.rst | 129 ++++++++++++++++++++++++++++++++++=
++++++++++++<br>
&gt;=C2=A0 =C2=A03 files changed, 164 insertions(+)<br>
&gt;=C2=A0 =C2=A0create mode 100644 docs/ebpf.rst<br>
&gt;=C2=A0 =C2=A0create mode 100644 docs/ebpf_rss.rst<br>
&gt;<br>
&gt; diff --git a/MAINTAINERS b/MAINTAINERS<br>
&gt; index 2c22bbca5a..464b3f3c95 100644<br>
&gt; --- a/MAINTAINERS<br>
&gt; +++ b/MAINTAINERS<br>
&gt; @@ -3111,6 +3111,12 @@ S: Maintained<br>
&gt;=C2=A0 =C2=A0F: hw/semihosting/<br>
&gt;=C2=A0 =C2=A0F: include/hw/semihosting/<br>
&gt;=C2=A0 =C2=A0<br>
&gt; +EBPF:<br>
&gt; +M: Andrew Melnychenko&lt;<a href=3D"mailto:andrew@daynix.com" target=
=3D"_blank">andrew@daynix.com</a>&gt;<br>
&gt; +M: Yuri Benditovich&lt;<a href=3D"mailto:yuri.benditovich@daynix.com"=
 target=3D"_blank">yuri.benditovich@daynix.com</a>&gt;<br>
&gt; +S: Maintained<br>
&gt; +F: ebpf/*<br>
&gt; +<br>
<br>
<br>
If it&#39;s possible, I would like to be one of the maintainer or at least =
<br>
reviewer :)<br>
<br></blockquote><div>With pleasure. We did not know who would want to main=
tain eBPF related things, so we added ourselves as maintainers.</div><div>I=
f you agree, we&#39;ll place you as a maintainer and ourselves as reviewers=
 to be informed about changes before they happen.</div><div><br></div><div>=
Thanks</div><div><br></div><div>=C2=A0</div><blockquote class=3D"gmail_quot=
e" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204)=
;padding-left:1ex">
Thanks<br>
<br>
</blockquote></div></div>

--000000000000c8c12905b358e200--

