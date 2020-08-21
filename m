Return-Path: <SRS0=atk5=B7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E370C433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 17:52:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EEE4720702
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 17:52:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com header.i=@bytedance-com.20150623.gappssmtp.com header.b="oUU4E9cx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EEE4720702
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bytedance.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37606 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k9BCt-0002GE-7s
	for qemu-devel@archiver.kernel.org; Fri, 21 Aug 2020 13:52:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35612)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangjiachen.jaycee@bytedance.com>)
 id 1k9BCF-0001id-Pe
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 13:51:23 -0400
Received: from mail-qk1-x743.google.com ([2607:f8b0:4864:20::743]:40499)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangjiachen.jaycee@bytedance.com>)
 id 1k9BCA-0004K4-8V
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 13:51:20 -0400
Received: by mail-qk1-x743.google.com with SMTP id 62so2105309qkj.7
 for <qemu-devel@nongnu.org>; Fri, 21 Aug 2020 10:51:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=tR4r51tFLMgm80llW/On5qVfqJkcL+L5lLJ6jEbmEoU=;
 b=oUU4E9cxAKM8rZPauN8QXmssuFcMwIrCzSoaTmMktpiMRItqHvb6MlO0RtAP8KMQ8j
 YCJ3TBYIpoUMcxauooUJGQvYKsTUIsXhBKkDA5fVRq6mxCwBpdNQtd/UeNQ1mleIwssG
 5sRqKp5rjhW7HnOfOzdldTyysVD9Xs9zgG0hFDl9tXQyk2Q3QMbz6EWo0LDanxfHt9YL
 yNApzgbDT2toeZGKM+Z6hta4RFQUwUKPu8aWqUZRUrc9St5iBb2cDfc1RKSxIqQIoGkz
 RKmpW5Xg98AfRLinnZlm+wXobHR0Lj3PJ6IqbVxb/6zMl92hvgOcJ4iZbKf9Jvetsyu7
 c6HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=tR4r51tFLMgm80llW/On5qVfqJkcL+L5lLJ6jEbmEoU=;
 b=ogdRWL1ccBy4EpY/AenxbMsiG4ZiYp/dByizvZNv12nskHDUG2XXb+2xyW3LBJFA0s
 wVWdb76d79PrN7Xz0c14k5eEeHZuyvPgU0n21b3CGOOVa2234htXWzGpegNSchjKFy47
 i3gEEkK5kKzuhde5r23wRuaBkY8sj+T7ggoAivYmGRzPXc5CYYOfHIffWFYzeqa1nxj9
 5MSlslhfewF6gIexU9Qx0cTix6vNMgrK+JsA32Ezl2lF0YRVdb3FwChDFpVOGi0JRUQP
 1/aSkMTLAafRAXmKcd+f95hxyWi1S5jW7WKCgc5hWCH3UVlrKgM+MuuglOd05Si3BS+o
 gUuQ==
X-Gm-Message-State: AOAM532om1sjc8lEIC0i0kJP87mcHXmsdeM7331Ag21KXfeUMVVlmI3s
 7mgYwYyEbKuZR0SB8F1Eo5JQQWTg+UUHmM6QBYwAhA==
X-Google-Smtp-Source: ABdhPJya8LC6N0a7MEOiEuiSLtwzPUZvaaSqH76uJ7GVy4ryWVYIW0jmc2B7EoW/4un2kPc/4YvMysKRkPH70M1XM9Y=
X-Received: by 2002:a37:2d42:: with SMTP id t63mr3402420qkh.99.1598032276040; 
 Fri, 21 Aug 2020 10:51:16 -0700 (PDT)
MIME-Version: 1.0
References: <20200821034126.8004-1-zhangjiachen.jaycee@bytedance.com>
 <20200821115829.GJ348677@redhat.com>
In-Reply-To: <20200821115829.GJ348677@redhat.com>
From: =?UTF-8?B?5byg5L2z6L6w?= <zhangjiachen.jaycee@bytedance.com>
Date: Sat, 22 Aug 2020 01:51:04 +0800
Message-ID: <CAFQAk7hqGxNdQJCRn2xsKnyuasPJnHS1hq3azkVc54U2VyDm3Q@mail.gmail.com>
Subject: Re: [External] Re: [PATCH] virtiofsd: add -o
 allow_directio|no_directio option
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000275ad805ad66e2b6"
Received-SPF: pass client-ip=2607:f8b0:4864:20::743;
 envelope-from=zhangjiachen.jaycee@bytedance.com; helo=mail-qk1-x743.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000275ad805ad66e2b6
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 21, 2020 at 7:58 PM Daniel P. Berrang=C3=A9 <berrange@redhat.co=
m>
wrote:

> On Fri, Aug 21, 2020 at 11:41:26AM +0800, Jiachen Zhang wrote:
> > Due to the commit 65da4539803373ec4eec97ffc49ee90083e56efd, the O_DIREC=
T
> > open flag of guest applications will be discarded by virtiofsd. While
> > this behavior makes it consistent with the virtio-9p scheme when guest
> > applications using direct I/O, we no longer have any chance to bypass
> > the host page cache.
> >
> > Therefore, we add a flag 'allow_directio' to lo_data. If '-o no_directi=
o'
> > option is added, or none of '-o no_directio' or '-o allow_directio' is
> > added, the 'allow_directio' will be set to 0, and virtiofsd discards
> > O_DIRECT as before. If '-o allow_directio' is added to the stariting
> > command-line, 'allow_directio' will be set to 1, so that the O_DIRECT
> > flags will be retained and host page cache can be bypassed.
> >
> > Signed-off-by: Jiachen Zhang <zhangjiachen.jaycee@bytedance.com>
> > ---
> >  tools/virtiofsd/helper.c         |  4 ++++
> >  tools/virtiofsd/passthrough_ll.c | 20 ++++++++++++++------
> >  2 files changed, 18 insertions(+), 6 deletions(-)
> >
> > diff --git a/tools/virtiofsd/helper.c b/tools/virtiofsd/helper.c
> > index 3105b6c23a..534ff52c64 100644
> > --- a/tools/virtiofsd/helper.c
> > +++ b/tools/virtiofsd/helper.c
> > @@ -180,6 +180,10 @@ void fuse_cmdline_help(void)
> >             "                               (0 leaves rlimit
> unchanged)\n"
> >             "                               default: min(1000000,
> fs.file-max - 16384)\n"
> >             "                                        if the current
> rlimit is lower\n"
> > +           "    -o allow_directio|no_directio\n"
> > +           "                               retain/discard O_DIRECT
> flags passed down\n"
> > +           "                               to virtiofsd from guest
> applications.\n"
> > +           "                               default: no_directio\n"
> >             );
>
> The standard naming convention from existing options is to use
> $OPTNAME and no_$OPTNAME.
>
> IOW, don't use the "allow_" prefix. The options should be just
> "directio" and "no_directio"
>
> Thanks, Daniel. I did consider using "directio" instead of "allow_directi=
o"
before I send out this patch. Although "-o directio" makes it consistent
with other option names, it may confuse the users of virtiofsd.
Because currently, virtiofsd will not add an O_DIRECT to the open flag,
it will just retain or discard the O_DIRECT added by guest applications.
But "-o direct" may make the users think that virtiofsd will do direct IO
all
the time.

Jiachen

>
> Regards,
> Daniel
> --
> |: https://berrange.com      -o-
> https://www.flickr.com/photos/dberrange :|
> |: https://libvirt.org         -o-
> https://fstop138.berrange.com :|
> |: https://entangle-photo.org    -o-
> https://www.instagram.com/dberrange :|
>

--000000000000275ad805ad66e2b6
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">On Fri, Aug 21, 2020 at 7:58 PM Daniel P.=
 Berrang=C3=A9 &lt;<a href=3D"mailto:berrange@redhat.com">berrange@redhat.c=
om</a>&gt; wrote:<br></div><div class=3D"gmail_quote"><blockquote class=3D"=
gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(20=
4,204,204);padding-left:1ex">On Fri, Aug 21, 2020 at 11:41:26AM +0800, Jiac=
hen Zhang wrote:<br>
&gt; Due to the commit 65da4539803373ec4eec97ffc49ee90083e56efd, the O_DIRE=
CT<br>
&gt; open flag of guest applications will be discarded by virtiofsd. While<=
br>
&gt; this behavior makes it consistent with the virtio-9p scheme when guest=
<br>
&gt; applications using direct I/O, we no longer have any chance to bypass<=
br>
&gt; the host page cache.<br>
&gt; <br>
&gt; Therefore, we add a flag &#39;allow_directio&#39; to lo_data. If &#39;=
-o no_directio&#39;<br>
&gt; option is added, or none of &#39;-o no_directio&#39; or &#39;-o allow_=
directio&#39; is<br>
&gt; added, the &#39;allow_directio&#39; will be set to 0, and virtiofsd di=
scards<br>
&gt; O_DIRECT as before. If &#39;-o allow_directio&#39; is added to the sta=
riting<br>
&gt; command-line, &#39;allow_directio&#39; will be set to 1, so that the O=
_DIRECT<br>
&gt; flags will be retained and host page cache can be bypassed.<br>
&gt; <br>
&gt; Signed-off-by: Jiachen Zhang &lt;<a href=3D"mailto:zhangjiachen.jaycee=
@bytedance.com" target=3D"_blank">zhangjiachen.jaycee@bytedance.com</a>&gt;=
<br>
&gt; ---<br>
&gt;=C2=A0 tools/virtiofsd/helper.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=
=A0 4 ++++<br>
&gt;=C2=A0 tools/virtiofsd/passthrough_ll.c | 20 ++++++++++++++------<br>
&gt;=C2=A0 2 files changed, 18 insertions(+), 6 deletions(-)<br>
&gt; <br>
&gt; diff --git a/tools/virtiofsd/helper.c b/tools/virtiofsd/helper.c<br>
&gt; index 3105b6c23a..534ff52c64 100644<br>
&gt; --- a/tools/virtiofsd/helper.c<br>
&gt; +++ b/tools/virtiofsd/helper.c<br>
&gt; @@ -180,6 +180,10 @@ void fuse_cmdline_help(void)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0(0 leaves rlimit unchanged)\n&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0default: min(1000000, fs.file-max - 16384)\n&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if the current rlimit is l=
ower\n&quot;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;=C2=A0 =C2=A0 -o allow=
_directio|no_directio\n&quot;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0retain/discard O_DIRECT flags passed down\n&quot;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0to virtiofsd from guest applications.\n&quot;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0default: no_directio\n&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0);<br>
<br>
The standard naming convention from existing options is to use<br>
$OPTNAME and no_$OPTNAME.<br>
<br>
IOW, don&#39;t use the &quot;allow_&quot; prefix. The options should be jus=
t<br>
&quot;directio&quot; and &quot;no_directio&quot;<br>
<br></blockquote><div>Thanks, Daniel. I did consider using=C2=A0&quot;direc=
tio&quot; instead of &quot;allow_directio&quot;</div><div>before I=C2=A0sen=
d out this patch. Although &quot;-o directio&quot; makes it consistent</div=
><div>with other option names, it may confuse the users of virtiofsd.</div>=
<div>Because currently,=C2=A0virtiofsd will not add an O_DIRECT to the open=
 flag,</div><div>it will just retain=C2=A0or discard the O_DIRECT added by =
guest applications.</div><div>But &quot;-o direct&quot; may=C2=A0make the u=
sers think that virtiofsd=C2=A0will do direct IO all</div><div>the time.</d=
iv><div><br></div><div>Jiachen</div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">
<br>
Regards,<br>
Daniel<br>
-- <br>
|: <a href=3D"https://berrange.com" rel=3D"noreferrer" target=3D"_blank">ht=
tps://berrange.com</a>=C2=A0 =C2=A0 =C2=A0 -o-=C2=A0 =C2=A0 <a href=3D"http=
s://www.flickr.com/photos/dberrange" rel=3D"noreferrer" target=3D"_blank">h=
ttps://www.flickr.com/photos/dberrange</a> :|<br>
|: <a href=3D"https://libvirt.org" rel=3D"noreferrer" target=3D"_blank">htt=
ps://libvirt.org</a>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0-o-=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 <a href=3D"https://fstop138.berrange.com" rel=3D"n=
oreferrer" target=3D"_blank">https://fstop138.berrange.com</a> :|<br>
|: <a href=3D"https://entangle-photo.org" rel=3D"noreferrer" target=3D"_bla=
nk">https://entangle-photo.org</a>=C2=A0 =C2=A0 -o-=C2=A0 =C2=A0 <a href=3D=
"https://www.instagram.com/dberrange" rel=3D"noreferrer" target=3D"_blank">=
https://www.instagram.com/dberrange</a> :|<br></blockquote></div></div>

--000000000000275ad805ad66e2b6--

