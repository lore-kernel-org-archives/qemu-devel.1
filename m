Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29525C433E7
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 07:01:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB77920716
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 07:01:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T/n55/vK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB77920716
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47134 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDjFJ-0001wg-VF
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 03:01:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34548)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kDjEe-0001TC-9I
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 03:00:40 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:36651
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kDjEa-00079O-RM
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 03:00:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599116434;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UOhIuKb91ZgLbbqnpLv+zcw199I4dcnG+wjrOz6G44c=;
 b=T/n55/vKSVmInBqa1JgVdKxn9ASh/GrWoUfx8f/DXYsz0bk6jYzw2JrgaMP0pTIGnJEaOd
 OcVZJ9YNQQjx2eFFaqAPWcfxx9Vdw2QKFSpniXslwkoI4tzieh01XSXvsqn1gs9HcQfBJR
 JsXapMzUTQRVLHVmlprtUa6sPV/XeDE=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-24-rQOmKyBiO3uKP7-PNxDC2g-1; Thu, 03 Sep 2020 03:00:29 -0400
X-MC-Unique: rQOmKyBiO3uKP7-PNxDC2g-1
Received: by mail-ed1-f69.google.com with SMTP id m88so893248ede.0
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2020 00:00:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=UOhIuKb91ZgLbbqnpLv+zcw199I4dcnG+wjrOz6G44c=;
 b=EAkslkQiUeqK5xQfX5x3dNyVXT+msk/010/3vPiztlMBOJj85V+aDdm82K2gF+tBR2
 qHGoZPFdt07yGNywkifBf2dMUYiiBW7pbgcJbupbaiP+L5wc5WYP6SJQNv//SfgBH8nz
 mtjvWh/UAocBvi3IIox+vMGGhsQ/IAvgy/yrVH3Mwttp+ALkChpBz5qs3ORGctxKUY/c
 jUB/7d7E9kvbg/zTAxbS+iUsmzEnPnWorNMvvQbgX5V319ezB5sDqEAqkMQLc7WWQM5u
 mqWLuch0XsymINOa2tjKcVkte/OrM17/2ndKr7AiMzAUUFfDATlEoSVx7578OmN12OGS
 n6Bw==
X-Gm-Message-State: AOAM531Kxjmb/s0h+GVT1LkREhaD9IY1cPUkgJ3VpvpMmcVmwdlcwhKT
 bERrSwD/O+rzpQWYUXrQuI8ALmIqTgoqDtnV9xrrmpzHfhmcxB55NbuPATFPwLuio9+Cp2eql6S
 GdLhoMIJOUfWmhNUudeWPF1eKXuCysKs=
X-Received: by 2002:a17:906:5046:: with SMTP id
 e6mr687081ejk.449.1599116427878; 
 Thu, 03 Sep 2020 00:00:27 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy/e4jxEU4xrLsi1mCSC8N83oAEPd3xkI7lyOPW2z3gOLBk2B2PFssrhQcwzuxAns9/4SGHVfkKm1D332TLfKk=
X-Received: by 2002:a17:906:5046:: with SMTP id
 e6mr687057ejk.449.1599116427701; 
 Thu, 03 Sep 2020 00:00:27 -0700 (PDT)
MIME-Version: 1.0
References: <20200902170054.810-1-luoyonggang@gmail.com>
 <20200902170054.810-6-luoyonggang@gmail.com>
 <26c3fe4a-009e-dfa2-f824-515f470924b1@redhat.com>
 <c9e56ee7-1938-7fdc-f2fe-b905a7ede189@redhat.com>
In-Reply-To: <c9e56ee7-1938-7fdc-f2fe-b905a7ede189@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 3 Sep 2020 09:00:15 +0200
Message-ID: <CABgObfbHOaVxsKR2n-25LPqkJMDcT3na81S7C_nW7HqshS8bTA@mail.gmail.com>
Subject: Re: [PATCH 5/6] tests: handling signal on win32 properly
To: Thomas Huth <thuth@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: multipart/alternative; boundary="000000000000a0c86a05ae634ec7"
Received-SPF: pass client-ip=205.139.110.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/03 01:58:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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
Cc: Yonggang Luo <luoyonggang@gmail.com>, qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000a0c86a05ae634ec7
Content-Type: text/plain; charset="UTF-8"

Yes, I guess that's true. I will queue it instead.

Paolo

Il gio 3 set 2020, 07:58 Thomas Huth <thuth@redhat.com> ha scritto:

> On 02/09/2020 19.04, Paolo Bonzini wrote:
> > On 02/09/20 19:00, Yonggang Luo wrote:
> >> SIGABRT should use signal(SIGABRT, sigabrt_handler) to handle on win32
> >>
> >> The error:
> >> E:/CI-Cor-Ready/xemu/qemu.org/tests/test-replication.c:559:33: error:
> invalid use of undefined type 'struct sigaction'
> >>   559 |     sigact = (struct sigaction) {
> >>       |                                 ^
> >>
> >> Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
> >> ---
> >>  tests/test-replication.c | 4 ++++
> >>  1 file changed, 4 insertions(+)
> >>
> >> diff --git a/tests/test-replication.c b/tests/test-replication.c
> >> index e0b03dafc2..9ab3666a90 100644
> >> --- a/tests/test-replication.c
> >> +++ b/tests/test-replication.c
> >> @@ -554,6 +554,9 @@ static void sigabrt_handler(int signo)
> >>
> >>  static void setup_sigabrt_handler(void)
> >>  {
> >> +#ifdef _WIN32
> >> +    signal(SIGABRT, sigabrt_handler);
> >> +#else
> >>      struct sigaction sigact;
> >>
> >>      sigact = (struct sigaction) {
> >> @@ -562,6 +565,7 @@ static void setup_sigabrt_handler(void)
> >>      };
> >>      sigemptyset(&sigact.sa_mask);
> >>      sigaction(SIGABRT, &sigact, NULL);
> >> +#endif
> >>  }
> >>
> >>  int main(int argc, char **argv)
> >>
> >
> > This is already fixed by a patch from Thomas.
>
> Well, my patch was to simply disable test-replication on Windows ... if
> it is working with this modification here, that's certainly better than
> disabling it.
>
>  Thomas
>
>

--000000000000a0c86a05ae634ec7
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">Yes, I guess that&#39;s true. I will queue it instead.<di=
v dir=3D"auto"><br></div><div dir=3D"auto">Paolo</div></div><br><div class=
=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">Il gio 3 set 2020, 0=
7:58 Thomas Huth &lt;<a href=3D"mailto:thuth@redhat.com">thuth@redhat.com</=
a>&gt; ha scritto:<br></div><blockquote class=3D"gmail_quote" style=3D"marg=
in:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">On 02/09/2020 19=
.04, Paolo Bonzini wrote:<br>
&gt; On 02/09/20 19:00, Yonggang Luo wrote:<br>
&gt;&gt; SIGABRT should use signal(SIGABRT, sigabrt_handler) to handle on w=
in32<br>
&gt;&gt;<br>
&gt;&gt; The error:<br>
&gt;&gt; E:/CI-Cor-Ready/xemu/<a href=3D"http://qemu.org/tests/test-replica=
tion.c:559:33" rel=3D"noreferrer noreferrer" target=3D"_blank">qemu.org/tes=
ts/test-replication.c:559:33</a>: error: invalid use of undefined type &#39=
;struct sigaction&#39;<br>
&gt;&gt;=C2=A0 =C2=A0559 |=C2=A0 =C2=A0 =C2=A0sigact =3D (struct sigaction)=
 {<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0^<br>
&gt;&gt;<br>
&gt;&gt; Signed-off-by: Yonggang Luo &lt;<a href=3D"mailto:luoyonggang@gmai=
l.com" target=3D"_blank" rel=3D"noreferrer">luoyonggang@gmail.com</a>&gt;<b=
r>
&gt;&gt; ---<br>
&gt;&gt;=C2=A0 tests/test-replication.c | 4 ++++<br>
&gt;&gt;=C2=A0 1 file changed, 4 insertions(+)<br>
&gt;&gt;<br>
&gt;&gt; diff --git a/tests/test-replication.c b/tests/test-replication.c<b=
r>
&gt;&gt; index e0b03dafc2..9ab3666a90 100644<br>
&gt;&gt; --- a/tests/test-replication.c<br>
&gt;&gt; +++ b/tests/test-replication.c<br>
&gt;&gt; @@ -554,6 +554,9 @@ static void sigabrt_handler(int signo)<br>
&gt;&gt;=C2=A0 <br>
&gt;&gt;=C2=A0 static void setup_sigabrt_handler(void)<br>
&gt;&gt;=C2=A0 {<br>
&gt;&gt; +#ifdef _WIN32<br>
&gt;&gt; +=C2=A0 =C2=A0 signal(SIGABRT, sigabrt_handler);<br>
&gt;&gt; +#else<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 struct sigaction sigact;<br>
&gt;&gt;=C2=A0 <br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 sigact =3D (struct sigaction) {<br>
&gt;&gt; @@ -562,6 +565,7 @@ static void setup_sigabrt_handler(void)<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 };<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 sigemptyset(&amp;sigact.sa_mask);<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 sigaction(SIGABRT, &amp;sigact, NULL);<br>
&gt;&gt; +#endif<br>
&gt;&gt;=C2=A0 }<br>
&gt;&gt;=C2=A0 <br>
&gt;&gt;=C2=A0 int main(int argc, char **argv)<br>
&gt;&gt;<br>
&gt; <br>
&gt; This is already fixed by a patch from Thomas.<br>
<br>
Well, my patch was to simply disable test-replication on Windows ... if<br>
it is working with this modification here, that&#39;s certainly better than=
<br>
disabling it.<br>
<br>
=C2=A0Thomas<br>
<br>
</blockquote></div>

--000000000000a0c86a05ae634ec7--


