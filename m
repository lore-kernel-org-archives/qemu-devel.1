Return-Path: <SRS0=H0ck=CE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCD3EC433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 11:37:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7DC9C2087C
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 11:37:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gsRgTwFy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DC9C2087C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39554 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAtk7-0008PW-PO
	for qemu-devel@archiver.kernel.org; Wed, 26 Aug 2020 07:37:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53824)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kAtiy-00079j-HS
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 07:36:16 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:47257
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kAtiw-00072J-HI
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 07:36:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598441773;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XgMEYJQyjSZzggV1LelfBT8sKxR8y5RBUh6LVsQ+OQ8=;
 b=gsRgTwFyKuJN7zknKrPZhRjdUx+W5tGhzhSHmX0lrxj+iwX+tyBzjTl3xhlK4Zqqx5QDQF
 xbFox3/yPM7W6oOs4kMxI8ntoWr0Gi6KI+uh46rblNHvOXGga0rLcpjLBY8MEuF8DTGmd8
 3MEyEyj6gfzpOrdZu0fAnbObiR5NtaQ=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-557-fvxtE61LNCCVSF2FtNQ9QA-1; Wed, 26 Aug 2020 07:36:09 -0400
X-MC-Unique: fvxtE61LNCCVSF2FtNQ9QA-1
Received: by mail-ej1-f70.google.com with SMTP id n12so837340ejz.6
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2020 04:36:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=XgMEYJQyjSZzggV1LelfBT8sKxR8y5RBUh6LVsQ+OQ8=;
 b=TNPfLErgdJdILrFL99H7kKSyOX1fnZCyY3DuALiWHz+/E9E0YDgDk4GFFJ1pkvaiF8
 fWYoXwJnXHxGgSf3K10wJ3V4hvlrm4F95oXUGf61IV0h/0dmLXk1ICfsi9hFBjlukQPH
 0KP5dcFxMW0KKOR6Fn2yLN/+hPQ7ieXhFw4UAROl7s2uGpRxl4MP56ks01Rv1So277UR
 ydAagGVGWAGE5SBDVPReZp4ygdvnoqb7DWxrhDPdK34W4TxeR98BHEz76lCKazFAwPfO
 lFGcm1TV18Ty+VmmlpzJJqrzpAVHqeiZowUZsm9JiUrb7+Co9WYIzEtPX+QJk2jSpyVw
 Xwbg==
X-Gm-Message-State: AOAM5337/3W/A+SW1x1FYsgKuOwL2/ilEGc4H7AkEkR01LhrKn+oIhCj
 JUeGSX9+fEO0EMawG+mDPwS7IT6aoUP8Hk1Hb3D8GFJwe6qA630LcCXz0kw3sAhLZ4bHCclGz89
 7YHm2d+Ys2w/R7p9Rbl/KMVoVUFjEfIc=
X-Received: by 2002:a50:9f0c:: with SMTP id b12mr13985824edf.129.1598441768703; 
 Wed, 26 Aug 2020 04:36:08 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzw55gC/x915vFRa5Rv07iy1PcoHhlvN+JguiUxXryhjQNBvI0Xde6hve72qxoII3QbnaHvOJhvE+nJA6k6D7U=
X-Received: by 2002:a50:9f0c:: with SMTP id b12mr13985802edf.129.1598441768371; 
 Wed, 26 Aug 2020 04:36:08 -0700 (PDT)
MIME-Version: 1.0
References: <40710b94-094f-f91a-6ddb-94e51199a8c3@vivier.eu>
 <20200826084442.GH168515@redhat.com>
 <cabd3284-bca8-07ff-e0bc-22ba41df7298@vivier.eu>
 <CABgObfbHtkmp0C5nN+kyAr2a80eRO3LRYa9=MwVqME0O6XMHWQ@mail.gmail.com>
 <9c4310b6-c9fc-91d6-08c3-2c5b5140b1b9@vivier.eu>
In-Reply-To: <9c4310b6-c9fc-91d6-08c3-2c5b5140b1b9@vivier.eu>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 26 Aug 2020 13:35:55 +0200
Message-ID: <CABgObfbUEm5ZpMUysns2WqEKe_QW2+L3qJ737JaHbBkhNZDOZw@mail.gmail.com>
Subject: Re: linux-user static build broken
To: Laurent Vivier <laurent@vivier.eu>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: multipart/alternative; boundary="000000000000cc62da05adc639f2"
Received-SPF: pass client-ip=207.211.31.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/26 03:56:58
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.959,
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
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000cc62da05adc639f2
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Let me take a look tonight as I plan to prepare a pull request.

Paolo

Il mer 26 ago 2020, 12:53 Laurent Vivier <laurent@vivier.eu> ha scritto:

> Le 26/08/2020 =C3=A0 11:08, Paolo Bonzini a =C3=A9crit :
> > $ORIGIN is a special literal used by ld.so. It's probably fixed by the
> > same patch that was posted for msys.
>
> If I remove the "-Wl,-rpath,RIGIN/" from the command line to build
> qemu-m68k, it works again.
>
> What the patch name or series?
>
> Thanks,
> Laurent
>
> > Paolo
> >
> > Il mer 26 ago 2020, 10:51 Laurent Vivier <laurent@vivier.eu
> > <mailto:laurent@vivier.eu>> ha scritto:
> >
> >     Le 26/08/2020 =C3=A0 10:44, Daniel P. Berrang=C3=A9 a =C3=A9crit :
> >     > On Tue, Aug 25, 2020 at 10:36:13PM +0200, Laurent Vivier wrote:
> >     >> Hi,
> >     >>
> >     >> since we have switched to meson, the statically linked binaries
> >     of qemu
> >     >> linux-user are broken:
> >     >>
> >     >> cd $OBJ
> >     >> $SRC/configure --static --target-list=3Dm68k-linux-user
> >     >> make
> >     >> ./qemu-m68k
> >     >> Segmentation fault (core dumped)
> >     >>
> >     >> Program received signal SIGSEGV, Segmentation fault.
> >     >> 0x00007ffff7bd6833 in __dcigettext ()
> >     >> (gdb) bt
> >     >> #0  0x00007ffff7bd6833 in __dcigettext ()
> >     >> #1  0x00007ffff7bd5352 in __assert_fail ()
> >     >> #2  0x00007ffff7c4d74c in _dl_relocate_static_pie ()
> >     >> #3  0x00007ffff7bc713e in __libc_start_main ()
> >     >> #4  0x00007ffff7a0029e in _start ()
> >     >>
> >     >> If I build with --disable-pie it works again.
> >     >>
> >     >> Any idea?
> >     >
> >     > I'd suggest checking the compiler args used with v5.1.0 vs git
> master
> >     > and see if any flags related to PIE or similar changed. I already
> >     found
> >     > one bug wrt PIE on Windows builds this way.
> >     >
> >     > Regards,
> >     > Daniel
> >     >
> >
> >     It's what I'm doing.
> >
> >     There are both "--static-pie" and "--pie" on the new command line,
> but
> >     keeping only the first doesn't fix the problem.
> >
> >     There is also a strange '-Wl,-rpath,RIGIN/' that would mean "make" =
is
> >     not using $(ORIGIN) but $ORIGIN...
> >
> >     Thanks,
> >     Laurent
> >
>
>

--000000000000cc62da05adc639f2
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">Let me take a look tonight as I plan to prepare a pull re=
quest.<div dir=3D"auto"><br></div><div dir=3D"auto">Paolo</div></div><br><d=
iv class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">Il mer 26 ag=
o 2020, 12:53 Laurent Vivier &lt;<a href=3D"mailto:laurent@vivier.eu">laure=
nt@vivier.eu</a>&gt; ha scritto:<br></div><blockquote class=3D"gmail_quote"=
 style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">Le=
 26/08/2020 =C3=A0 11:08, Paolo Bonzini a =C3=A9crit=C2=A0:<br>
&gt; $ORIGIN is a special literal used by ld.so. It&#39;s probably fixed by=
 the<br>
&gt; same patch that was posted for msys.<br>
<br>
If I remove the &quot;-Wl,-rpath,RIGIN/&quot; from the command line to buil=
d<br>
qemu-m68k, it works again.<br>
<br>
What the patch name or series?<br>
<br>
Thanks,<br>
Laurent<br>
<br>
&gt; Paolo<br>
&gt; <br>
&gt; Il mer 26 ago 2020, 10:51 Laurent Vivier &lt;<a href=3D"mailto:laurent=
@vivier.eu" target=3D"_blank" rel=3D"noreferrer">laurent@vivier.eu</a><br>
&gt; &lt;mailto:<a href=3D"mailto:laurent@vivier.eu" target=3D"_blank" rel=
=3D"noreferrer">laurent@vivier.eu</a>&gt;&gt; ha scritto:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0Le 26/08/2020 =C3=A0 10:44, Daniel P. Berrang=C3=A9=
 a =C3=A9crit=C2=A0:<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; On Tue, Aug 25, 2020 at 10:36:13PM +0200, Laur=
ent Vivier wrote:<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt; Hi,<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt; since we have switched to meson, the stati=
cally linked binaries<br>
&gt;=C2=A0 =C2=A0 =C2=A0of qemu<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt; linux-user are broken:<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt; cd $OBJ<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt; $SRC/configure --static --target-list=3Dm6=
8k-linux-user<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt; make<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt; ./qemu-m68k<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt; Segmentation fault (core dumped)<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt; Program received signal SIGSEGV, Segmentat=
ion fault.<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt; 0x00007ffff7bd6833 in __dcigettext ()<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt; (gdb) bt<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt; #0=C2=A0 0x00007ffff7bd6833 in __dcigettex=
t ()<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt; #1=C2=A0 0x00007ffff7bd5352 in __assert_fa=
il ()<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt; #2=C2=A0 0x00007ffff7c4d74c in _dl_relocat=
e_static_pie ()<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt; #3=C2=A0 0x00007ffff7bc713e in __libc_star=
t_main ()<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt; #4=C2=A0 0x00007ffff7a0029e in _start ()<b=
r>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt; If I build with --disable-pie it works aga=
in.<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt; Any idea?<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; I&#39;d suggest checking the compiler args use=
d with v5.1.0 vs git master<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; and see if any flags related to PIE or similar=
 changed. I already<br>
&gt;=C2=A0 =C2=A0 =C2=A0found<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; one bug wrt PIE on Windows builds this way.<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; Regards,<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; Daniel<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0It&#39;s what I&#39;m doing.<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0There are both &quot;--static-pie&quot; and &quot;-=
-pie&quot; on the new command line, but<br>
&gt;=C2=A0 =C2=A0 =C2=A0keeping only the first doesn&#39;t fix the problem.=
<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0There is also a strange &#39;-Wl,-rpath,RIGIN/&#39;=
 that would mean &quot;make&quot; is<br>
&gt;=C2=A0 =C2=A0 =C2=A0not using $(ORIGIN) but $ORIGIN...<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0Thanks,<br>
&gt;=C2=A0 =C2=A0 =C2=A0Laurent<br>
&gt; <br>
<br>
</blockquote></div>

--000000000000cc62da05adc639f2--


