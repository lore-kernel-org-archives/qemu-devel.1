Return-Path: <SRS0=JPH5=CC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1574CC433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 10:02:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C3A342071E
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 10:02:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com header.i=@bytedance-com.20150623.gappssmtp.com header.b="CKhGQ3BX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3A342071E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bytedance.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39806 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kA9JR-0007UN-0t
	for qemu-devel@archiver.kernel.org; Mon, 24 Aug 2020 06:02:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49698)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangjiachen.jaycee@bytedance.com>)
 id 1kA9GX-0002z1-Gk
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 05:59:49 -0400
Received: from mail-qt1-x843.google.com ([2607:f8b0:4864:20::843]:37709)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangjiachen.jaycee@bytedance.com>)
 id 1kA9GT-0006Ar-Di
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 05:59:47 -0400
Received: by mail-qt1-x843.google.com with SMTP id d27so5706009qtg.4
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2020 02:59:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=kqoJCd0JGX40MtyBp+cAcCNcbOZ5omndlK5DPyEk4XU=;
 b=CKhGQ3BXiWobF9RIWPtQ+eYRqHaN+3/gIJAYmNiEZix481P9Sty3/QLKWHnvCZCUFK
 xeM+HADhoboXmPaH+CAxXTe6zD+PXhoO29+myZe3H8k320ozvAsAQjEB1QCkps3s0UZp
 DaGzf6DHagEiSwjPL+7947DDQ6eYDBLJHbjwAe8TxzhehC3uzxovkB/zlk+JYtkUC6BQ
 cCOhyU2LpHVFjWJkr/+hBiKovVHU7NYpiKwuxHm3bTxVmAJXmmelF9edep1r8UtBCXff
 HlGuwnjoyb2a50G7ufICRIVyCT4v5Z3X3wG+MI2CjW+On1NzEDyjg6JkYOwEKWB+BJww
 uRrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=kqoJCd0JGX40MtyBp+cAcCNcbOZ5omndlK5DPyEk4XU=;
 b=Q5R2sKkj9i4R2inHR7atVePLlp8ZMipObsp4sNmkfwfqHpdcVPmJkz8EFPCLKtgos6
 BHUimhxQRrmxnkb3mAlUH2JZfiySxIJyuL3Mo/huE5wREXa1+NXAgex9wP+sPjo/sqTt
 GdmlPqB4vdQpj1FWrEsVM+R6VJytsPqSYK45qB3iUGKCs4aCDtp1bZK1NwpWiFuhcawG
 fBqIfqeFfwAcG/5Gav5mbKV5z2TRs5L2MPWxDwC//riyrEbJ7Xj+BYu3fcmYFHFup+3c
 3mMcCBjqlzHzcDR3gZ5fUCPr6BY2VC+BIAcPCzKMeBKZwxAfCmhfEwHOXyecYw1jeeaE
 3fmQ==
X-Gm-Message-State: AOAM532ahuj/T4DvUedN1pwu0TQHQFfmGfsw+Y365eP98R7p7Fw9ll87
 FhZkdoHVlk3p6zeU/KchzD8L7oisLG0tx81L9+I6JA==
X-Google-Smtp-Source: ABdhPJx4SA7l3lWT45Qs5RJ1fWZpCgRpWH1dCk8seQxpGnWyMs3HR3ioZk5VT+FunudhR1ntwF9lP1twZqEcF6xFR8I=
X-Received: by 2002:ac8:12ca:: with SMTP id b10mr516268qtj.181.1598263183314; 
 Mon, 24 Aug 2020 02:59:43 -0700 (PDT)
MIME-Version: 1.0
References: <20200821034126.8004-1-zhangjiachen.jaycee@bytedance.com>
 <20200821115829.GJ348677@redhat.com>
 <CAFQAk7hqGxNdQJCRn2xsKnyuasPJnHS1hq3azkVc54U2VyDm3Q@mail.gmail.com>
 <20200824093941.GD10011@redhat.com>
In-Reply-To: <20200824093941.GD10011@redhat.com>
From: Jiachen Zhang <zhangjiachen.jaycee@bytedance.com>
Date: Mon, 24 Aug 2020 17:59:32 +0800
Message-ID: <CAFQAk7i7sOEv8htf80JTXc4qXO5MxNSpHVENuvCYpM1RNMJ5Eg@mail.gmail.com>
Subject: Re: [External] Re: [PATCH] virtiofsd: add -o
 allow_directio|no_directio option
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000004cb46d05ad9ca50d"
Received-SPF: pass client-ip=2607:f8b0:4864:20::843;
 envelope-from=zhangjiachen.jaycee@bytedance.com; helo=mail-qt1-x843.google.com
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
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000004cb46d05ad9ca50d
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 24, 2020 at 5:39 PM Daniel P. Berrang=C3=A9 <berrange@redhat.co=
m>
wrote:

> On Sat, Aug 22, 2020 at 01:51:04AM +0800, =E5=BC=A0=E4=BD=B3=E8=BE=B0 wro=
te:
> > On Fri, Aug 21, 2020 at 7:58 PM Daniel P. Berrang=C3=A9 <berrange@redha=
t.com>
> > wrote:
> >
> > > On Fri, Aug 21, 2020 at 11:41:26AM +0800, Jiachen Zhang wrote:
> > > > Due to the commit 65da4539803373ec4eec97ffc49ee90083e56efd, the
> O_DIRECT
> > > > open flag of guest applications will be discarded by virtiofsd. Whi=
le
> > > > this behavior makes it consistent with the virtio-9p scheme when
> guest
> > > > applications using direct I/O, we no longer have any chance to bypa=
ss
> > > > the host page cache.
> > > >
> > > > Therefore, we add a flag 'allow_directio' to lo_data. If '-o
> no_directio'
> > > > option is added, or none of '-o no_directio' or '-o allow_directio'
> is
> > > > added, the 'allow_directio' will be set to 0, and virtiofsd discard=
s
> > > > O_DIRECT as before. If '-o allow_directio' is added to the staritin=
g
> > > > command-line, 'allow_directio' will be set to 1, so that the O_DIRE=
CT
> > > > flags will be retained and host page cache can be bypassed.
> > > >
> > > > Signed-off-by: Jiachen Zhang <zhangjiachen.jaycee@bytedance.com>
> > > > ---
> > > >  tools/virtiofsd/helper.c         |  4 ++++
> > > >  tools/virtiofsd/passthrough_ll.c | 20 ++++++++++++++------
> > > >  2 files changed, 18 insertions(+), 6 deletions(-)
> > > >
> > > > diff --git a/tools/virtiofsd/helper.c b/tools/virtiofsd/helper.c
> > > > index 3105b6c23a..534ff52c64 100644
> > > > --- a/tools/virtiofsd/helper.c
> > > > +++ b/tools/virtiofsd/helper.c
> > > > @@ -180,6 +180,10 @@ void fuse_cmdline_help(void)
> > > >             "                               (0 leaves rlimit
> > > unchanged)\n"
> > > >             "                               default: min(1000000,
> > > fs.file-max - 16384)\n"
> > > >             "                                        if the current
> > > rlimit is lower\n"
> > > > +           "    -o allow_directio|no_directio\n"
> > > > +           "                               retain/discard O_DIRECT
> > > flags passed down\n"
> > > > +           "                               to virtiofsd from guest
> > > applications.\n"
> > > > +           "                               default: no_directio\n"
> > > >             );
> > >
> > > The standard naming convention from existing options is to use
> > > $OPTNAME and no_$OPTNAME.
> > >
> > > IOW, don't use the "allow_" prefix. The options should be just
> > > "directio" and "no_directio"
> > >
> > > Thanks, Daniel. I did consider using "directio" instead of
> "allow_directio"
> > before I send out this patch. Although "-o directio" makes it consisten=
t
> > with other option names, it may confuse the users of virtiofsd.
> > Because currently, virtiofsd will not add an O_DIRECT to the open flag,
> > it will just retain or discard the O_DIRECT added by guest applications=
.
> > But "-o direct" may make the users think that virtiofsd will do direct =
IO
> > all
> > the time.
>
> Then -o allow_direct_io   and  -o no_allow_direct_io
>
>
OK, thanks. I will use these names in the final version.

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
>

--0000000000004cb46d05ad9ca50d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"></div><br><div class=3D"gmail_quote"><div=
 dir=3D"ltr" class=3D"gmail_attr">On Mon, Aug 24, 2020 at 5:39 PM Daniel P.=
 Berrang=C3=A9 &lt;<a href=3D"mailto:berrange@redhat.com">berrange@redhat.c=
om</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margi=
n:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex=
">On Sat, Aug 22, 2020 at 01:51:04AM +0800, =E5=BC=A0=E4=BD=B3=E8=BE=B0 wro=
te:<br>
&gt; On Fri, Aug 21, 2020 at 7:58 PM Daniel P. Berrang=C3=A9 &lt;<a href=3D=
"mailto:berrange@redhat.com" target=3D"_blank">berrange@redhat.com</a>&gt;<=
br>
&gt; wrote:<br>
&gt; <br>
&gt; &gt; On Fri, Aug 21, 2020 at 11:41:26AM +0800, Jiachen Zhang wrote:<br=
>
&gt; &gt; &gt; Due to the commit 65da4539803373ec4eec97ffc49ee90083e56efd, =
the O_DIRECT<br>
&gt; &gt; &gt; open flag of guest applications will be discarded by virtiof=
sd. While<br>
&gt; &gt; &gt; this behavior makes it consistent with the virtio-9p scheme =
when guest<br>
&gt; &gt; &gt; applications using direct I/O, we no longer have any chance =
to bypass<br>
&gt; &gt; &gt; the host page cache.<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; Therefore, we add a flag &#39;allow_directio&#39; to lo_data=
. If &#39;-o no_directio&#39;<br>
&gt; &gt; &gt; option is added, or none of &#39;-o no_directio&#39; or &#39=
;-o allow_directio&#39; is<br>
&gt; &gt; &gt; added, the &#39;allow_directio&#39; will be set to 0, and vi=
rtiofsd discards<br>
&gt; &gt; &gt; O_DIRECT as before. If &#39;-o allow_directio&#39; is added =
to the stariting<br>
&gt; &gt; &gt; command-line, &#39;allow_directio&#39; will be set to 1, so =
that the O_DIRECT<br>
&gt; &gt; &gt; flags will be retained and host page cache can be bypassed.<=
br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; Signed-off-by: Jiachen Zhang &lt;<a href=3D"mailto:zhangjiac=
hen.jaycee@bytedance.com" target=3D"_blank">zhangjiachen.jaycee@bytedance.c=
om</a>&gt;<br>
&gt; &gt; &gt; ---<br>
&gt; &gt; &gt;=C2=A0 tools/virtiofsd/helper.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0|=C2=A0 4 ++++<br>
&gt; &gt; &gt;=C2=A0 tools/virtiofsd/passthrough_ll.c | 20 ++++++++++++++--=
----<br>
&gt; &gt; &gt;=C2=A0 2 files changed, 18 insertions(+), 6 deletions(-)<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; diff --git a/tools/virtiofsd/helper.c b/tools/virtiofsd/help=
er.c<br>
&gt; &gt; &gt; index 3105b6c23a..534ff52c64 100644<br>
&gt; &gt; &gt; --- a/tools/virtiofsd/helper.c<br>
&gt; &gt; &gt; +++ b/tools/virtiofsd/helper.c<br>
&gt; &gt; &gt; @@ -180,6 +180,10 @@ void fuse_cmdline_help(void)<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(0 leaves rlimit<br>
&gt; &gt; unchanged)\n&quot;<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0default: min(1000000,<br>
&gt; &gt; fs.file-max - 16384)\n&quot;<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if the current<=
br>
&gt; &gt; rlimit is lower\n&quot;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;=C2=A0 =C2=
=A0 -o allow_directio|no_directio\n&quot;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0retain/discard O_DIRECT<br>
&gt; &gt; flags passed down\n&quot;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0to virtiofsd from guest<br>
&gt; &gt; applications.\n&quot;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0default: no_directio\n&quot;<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0);<br>
&gt; &gt;<br>
&gt; &gt; The standard naming convention from existing options is to use<br=
>
&gt; &gt; $OPTNAME and no_$OPTNAME.<br>
&gt; &gt;<br>
&gt; &gt; IOW, don&#39;t use the &quot;allow_&quot; prefix. The options sho=
uld be just<br>
&gt; &gt; &quot;directio&quot; and &quot;no_directio&quot;<br>
&gt; &gt;<br>
&gt; &gt; Thanks, Daniel. I did consider using &quot;directio&quot; instead=
 of &quot;allow_directio&quot;<br>
&gt; before I send out this patch. Although &quot;-o directio&quot; makes i=
t consistent<br>
&gt; with other option names, it may confuse the users of virtiofsd.<br>
&gt; Because currently, virtiofsd will not add an O_DIRECT to the open flag=
,<br>
&gt; it will just retain or discard the O_DIRECT added by guest application=
s.<br>
&gt; But &quot;-o direct&quot; may make the users think that virtiofsd will=
 do direct IO<br>
&gt; all<br>
&gt; the time.<br>
<br>
Then -o allow_direct_io=C2=A0 =C2=A0and=C2=A0 -o no_allow_direct_io<br>
<br></blockquote><div><br></div><div>OK, thanks. I will use these names in =
the final version.<div><br></div><div>Jiachen</div></div><div>=C2=A0</div><=
blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-l=
eft:1px solid rgb(204,204,204);padding-left:1ex">
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
https://www.instagram.com/dberrange</a> :|<br>
<br>
</blockquote></div></div>

--0000000000004cb46d05ad9ca50d--

