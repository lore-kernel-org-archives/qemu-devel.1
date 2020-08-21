Return-Path: <SRS0=atk5=B7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEF3AC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 17:59:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8000C20702
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 17:59:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com header.i=@bytedance-com.20150623.gappssmtp.com header.b="j2o2tnpm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8000C20702
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bytedance.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53632 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k9BJd-00011D-QJ
	for qemu-devel@archiver.kernel.org; Fri, 21 Aug 2020 13:59:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37300)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangjiachen.jaycee@bytedance.com>)
 id 1k9BHi-0006YZ-51
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 13:57:02 -0400
Received: from mail-qt1-x844.google.com ([2607:f8b0:4864:20::844]:45202)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangjiachen.jaycee@bytedance.com>)
 id 1k9BHe-00052q-Lu
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 13:57:00 -0400
Received: by mail-qt1-x844.google.com with SMTP id s23so1795916qtq.12
 for <qemu-devel@nongnu.org>; Fri, 21 Aug 2020 10:56:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=vtq1nfJ72CL4LQ9kPU9VgoVl+yPIf6Z0H4zoNF+a9Zg=;
 b=j2o2tnpmjYOLVB5VR5BtHWYR2uKIJJcg7IWqtJeO9IX3r10lO2yCqDYKIbMF066oUl
 qgDbM6gouatKQIn7btXeMr54WNUnyOdMTOtQnc5g5h7uyGQJUc3vA8Hkz5O1IVnbJ0Wn
 eGhIy8lNWAYx4YWnKVinFgkDCW6Py+EuS6GMcOzBzw8uGDCWzsgF3Bqrw6r1/CDOnE70
 CGzUaoOHoKXiM3I6P3VkXDj8lSrZpC4P2R3FZj3PWgro1oygBAsnWahM3XhCbiNlQ31j
 bp7Yx9OhHs8+LBR9CeCnGvRgb0VRiLpyMhD7B0wvfbzlS1A/ehqZKXG9caqO4ifmplM2
 GIcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=vtq1nfJ72CL4LQ9kPU9VgoVl+yPIf6Z0H4zoNF+a9Zg=;
 b=WIMsjkyAY8CChxqKv2+09APHmAqjdhjGTfCip8U5nEHRtebVNAGDb56/c9QzyyzmfV
 CpBWedA5H+bLeK+HTzYEsgwPvMSsMYQzkzI8UTJACdY+hmIf10/CuKexCM9SX3cp2tYf
 O1JDxgLTbxRTTMpRqb5kkTckF3UlONXuTkv7A/4qWKfKzBMIUNb79wTj40InQM1DrfI2
 BP7pVHc8HbGbEDwCgJLYgsMMF37SvGCDhvKuuuI7Yo+tika84Gk3Pp0ZACpkxWYvYhKK
 EkbpRNaqPmSj633jw/5mCNQnapjUWPFTVQyOZ8oeHp78MseNo9f42/JzLr2jAq+fiU2u
 DBVQ==
X-Gm-Message-State: AOAM532EXYUZh7qtM8aqeZyItP0w0BVe3/JOsguOdDBVmBBPkxi9iq5G
 rbx8rFLV79EoBIAdGrh3Iuz0xTBI9YAn93mndySqyA==
X-Google-Smtp-Source: ABdhPJywPbg4tl6cpgKxeqkGZCC12sGjdhrAG9+xb71aZz4NDWax4V+XRBKRGKXpfxqFiFeZxvq/ZFU83tgYL/mhbDc=
X-Received: by 2002:aed:3404:: with SMTP id w4mr3880402qtd.181.1598032617066; 
 Fri, 21 Aug 2020 10:56:57 -0700 (PDT)
MIME-Version: 1.0
References: <20200821034126.8004-1-zhangjiachen.jaycee@bytedance.com>
 <20200821115829.GJ348677@redhat.com>
 <7371d876-37d8-63b6-679e-656a98d8ecb3@redhat.com>
In-Reply-To: <7371d876-37d8-63b6-679e-656a98d8ecb3@redhat.com>
From: =?UTF-8?B?5byg5L2z6L6w?= <zhangjiachen.jaycee@bytedance.com>
Date: Sat, 22 Aug 2020 01:56:45 +0800
Message-ID: <CAFQAk7iRxkcHKTz-R2mq=3Fe1ZRqQ=e2v9k53q59yQ=LnwwiEQ@mail.gmail.com>
Subject: Re: [External] Re: [PATCH] virtiofsd: add -o
 allow_directio|no_directio option
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000007af50205ad66f625"
Received-SPF: pass client-ip=2607:f8b0:4864:20::844;
 envelope-from=zhangjiachen.jaycee@bytedance.com; helo=mail-qt1-x844.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Yongji Xie <xieyongji@bytedance.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000007af50205ad66f625
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 21, 2020 at 9:40 PM Philippe Mathieu-Daud=C3=A9 <philmd@redhat.=
com>
wrote:

> On 8/21/20 1:58 PM, Daniel P. Berrang=C3=A9 wrote:
> > On Fri, Aug 21, 2020 at 11:41:26AM +0800, Jiachen Zhang wrote:
> >> Due to the commit 65da4539803373ec4eec97ffc49ee90083e56efd, the O_DIRE=
CT
> >> open flag of guest applications will be discarded by virtiofsd. While
> >> this behavior makes it consistent with the virtio-9p scheme when guest
> >> applications using direct I/O, we no longer have any chance to bypass
> >> the host page cache.
> >>
> >> Therefore, we add a flag 'allow_directio' to lo_data. If '-o
> no_directio'
> >> option is added, or none of '-o no_directio' or '-o allow_directio' is
> >> added, the 'allow_directio' will be set to 0, and virtiofsd discards
> >> O_DIRECT as before. If '-o allow_directio' is added to the stariting
> >> command-line, 'allow_directio' will be set to 1, so that the O_DIRECT
> >> flags will be retained and host page cache can be bypassed.
> >>
> >> Signed-off-by: Jiachen Zhang <zhangjiachen.jaycee@bytedance.com>
> >> ---
> >>  tools/virtiofsd/helper.c         |  4 ++++
> >>  tools/virtiofsd/passthrough_ll.c | 20 ++++++++++++++------
> >>  2 files changed, 18 insertions(+), 6 deletions(-)
> >>
> >> diff --git a/tools/virtiofsd/helper.c b/tools/virtiofsd/helper.c
> >> index 3105b6c23a..534ff52c64 100644
> >> --- a/tools/virtiofsd/helper.c
> >> +++ b/tools/virtiofsd/helper.c
> >> @@ -180,6 +180,10 @@ void fuse_cmdline_help(void)
> >>             "                               (0 leaves rlimit
> unchanged)\n"
> >>             "                               default: min(1000000,
> fs.file-max - 16384)\n"
> >>             "                                        if the current
> rlimit is lower\n"
> >> +           "    -o allow_directio|no_directio\n"
> >> +           "                               retain/discard O_DIRECT
> flags passed down\n"
> >> +           "                               to virtiofsd from guest
> applications.\n"
> >> +           "                               default: no_directio\n"
> >>             );
> >
> > The standard naming convention from existing options is to use
> > $OPTNAME and no_$OPTNAME.
> >
> > IOW, don't use the "allow_" prefix. The options should be just
> > "directio" and "no_directio"
>
> As we have 'max_idle_threads' (and not maxidlethreads), can we
> use 'direct_io' instead?
>
> Thanks. I will split them in the next version.

Jiachen

>
> > Regards,
> > Daniel
> >
>
>

--0000000000007af50205ad66f625
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">On Fri, Aug 21, 2020 at 9:40 PM Philippe =
Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@redhat.com">philmd@redhat.c=
om</a>&gt; wrote:<br></div><div class=3D"gmail_quote"><blockquote class=3D"=
gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(20=
4,204,204);padding-left:1ex">On 8/21/20 1:58 PM, Daniel P. Berrang=C3=A9 wr=
ote:<br>
&gt; On Fri, Aug 21, 2020 at 11:41:26AM +0800, Jiachen Zhang wrote:<br>
&gt;&gt; Due to the commit 65da4539803373ec4eec97ffc49ee90083e56efd, the O_=
DIRECT<br>
&gt;&gt; open flag of guest applications will be discarded by virtiofsd. Wh=
ile<br>
&gt;&gt; this behavior makes it consistent with the virtio-9p scheme when g=
uest<br>
&gt;&gt; applications using direct I/O, we no longer have any chance to byp=
ass<br>
&gt;&gt; the host page cache.<br>
&gt;&gt;<br>
&gt;&gt; Therefore, we add a flag &#39;allow_directio&#39; to lo_data. If &=
#39;-o no_directio&#39;<br>
&gt;&gt; option is added, or none of &#39;-o no_directio&#39; or &#39;-o al=
low_directio&#39; is<br>
&gt;&gt; added, the &#39;allow_directio&#39; will be set to 0, and virtiofs=
d discards<br>
&gt;&gt; O_DIRECT as before. If &#39;-o allow_directio&#39; is added to the=
 stariting<br>
&gt;&gt; command-line, &#39;allow_directio&#39; will be set to 1, so that t=
he O_DIRECT<br>
&gt;&gt; flags will be retained and host page cache can be bypassed.<br>
&gt;&gt;<br>
&gt;&gt; Signed-off-by: Jiachen Zhang &lt;<a href=3D"mailto:zhangjiachen.ja=
ycee@bytedance.com" target=3D"_blank">zhangjiachen.jaycee@bytedance.com</a>=
&gt;<br>
&gt;&gt; ---<br>
&gt;&gt;=C2=A0 tools/virtiofsd/helper.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=
=C2=A0 4 ++++<br>
&gt;&gt;=C2=A0 tools/virtiofsd/passthrough_ll.c | 20 ++++++++++++++------<b=
r>
&gt;&gt;=C2=A0 2 files changed, 18 insertions(+), 6 deletions(-)<br>
&gt;&gt;<br>
&gt;&gt; diff --git a/tools/virtiofsd/helper.c b/tools/virtiofsd/helper.c<b=
r>
&gt;&gt; index 3105b6c23a..534ff52c64 100644<br>
&gt;&gt; --- a/tools/virtiofsd/helper.c<br>
&gt;&gt; +++ b/tools/virtiofsd/helper.c<br>
&gt;&gt; @@ -180,6 +180,10 @@ void fuse_cmdline_help(void)<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;=C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0(0 leaves rlimit unchanged)\n&quot;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;=C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0default: min(1000000, fs.file-max - 16384)\n&quot;<=
br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;=C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if the current rlimit =
is lower\n&quot;<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;=C2=A0 =C2=A0 -o a=
llow_directio|no_directio\n&quot;<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0retain/discard O_DIRECT flags passed down\n&quot;<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0to virtiofsd from guest applications.\n&quot;<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0default: no_directio\n&quot;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0);<br>
&gt; <br>
&gt; The standard naming convention from existing options is to use<br>
&gt; $OPTNAME and no_$OPTNAME.<br>
&gt; <br>
&gt; IOW, don&#39;t use the &quot;allow_&quot; prefix. The options should b=
e just<br>
&gt; &quot;directio&quot; and &quot;no_directio&quot;<br>
<br>
As we have &#39;max_idle_threads&#39; (and not maxidlethreads), can we<br>
use &#39;direct_io&#39; instead?<br>
<br></blockquote><div><div>Thanks. I will split them in the next version.</=
div><div><br></div><div>Jiachen</div></div><div><br></div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex">
&gt; <br>
&gt; Regards,<br>
&gt; Daniel<br>
&gt; <br>
<br>
</blockquote></div></div>

--0000000000007af50205ad66f625--

