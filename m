Return-Path: <SRS0=2GMi=CD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DB0EC433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 09:26:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 09FFC2068F
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 09:26:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A6w4PqPJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09FFC2068F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41274 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAVDT-0004R5-8l
	for qemu-devel@archiver.kernel.org; Tue, 25 Aug 2020 05:26:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42290)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kAVCa-0003tl-J7
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 05:25:12 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:33318
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kAVCX-0006WE-SY
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 05:25:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598347508;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=S5XwUx2k8lGwr2cQbqt/FMml5LeoGNhU39xEYhuWyo0=;
 b=A6w4PqPJyVQTKgZ8kbJ2/17BBfQt+U3JCHeiZdd66V5z3L9pi4pv9d2ZNJ766TV/1RCFdQ
 jIHWIfAHIbTvWlisXuXP3R4h/b8oEvemm2HRjKs1MefqNo9HOqWbwgqDi2QK/Dv27MbEvt
 TlqL2sM84g97jW4sX5875GJ6Akn3tfU=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-314-rdNIQiDiMGKgM1ST2or0NA-1; Tue, 25 Aug 2020 05:25:02 -0400
X-MC-Unique: rdNIQiDiMGKgM1ST2or0NA-1
Received: by mail-ed1-f70.google.com with SMTP id da13so4412296edb.0
 for <qemu-devel@nongnu.org>; Tue, 25 Aug 2020 02:25:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=S5XwUx2k8lGwr2cQbqt/FMml5LeoGNhU39xEYhuWyo0=;
 b=tiqLNxPKNBVfq+SgelRQ1GzqgHgs9YdAcVsrTp3pSfRBnQiEIa3YGUthsU0qIHWSmh
 7ekiLVPTspn9FNLwV5Hla7zR9On5Lqbsx3anHoqMMnRLA9ruME0epLYuo9zcBRwkPXZ7
 oGxFO12UsiUXHOWBG4ffwVmbA7klHdt/gZz+qBfN5452mSwCpEhZTcAAZm0KIs4FIeb3
 3OauYPM9/Klo3VkUGYnUVJEqOYrPIkWXfC0jwvA+mwMcfMZzbuOFobuvTYiNMKLuFG97
 4Zq5LBrdajDqGwXVkW6nGvGIQBAlO3PnDM8qSsAudI21JEIziwxm3OwNx9s/45YlfKg6
 wTLQ==
X-Gm-Message-State: AOAM531OKT//QHHRivLc6f9pwa2PYt0L0vLwQ0BbY93CPyygGapmrqg9
 9A6Pg+whSeySLI5kZu1zfW/qGwp6abw5o6szjEILI79eExZKCkdZHaeqRQ4bkQWvKIefLEkLV3h
 ZKTky0vuJUC8MkKiNlGYzK+13NqUMNzs=
X-Received: by 2002:a50:ee96:: with SMTP id f22mr8790060edr.243.1598347501693; 
 Tue, 25 Aug 2020 02:25:01 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxg8rGSRpjN+DdB75P1e7Y1/yzHRsplUBtIvlSmi/RmAj3SvXpToPkWylOaw/EO2pAHMuP6/sZbMeJf8K72fvw=
X-Received: by 2002:a50:ee96:: with SMTP id f22mr8790053edr.243.1598347501451; 
 Tue, 25 Aug 2020 02:25:01 -0700 (PDT)
MIME-Version: 1.0
References: <20200823090546.47957-1-r.bolshakov@yadro.com>
 <20200824142431.GL10011@redhat.com>
 <20200825090417.GA38400@SPB-NB-133.local>
In-Reply-To: <20200825090417.GA38400@SPB-NB-133.local>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 25 Aug 2020 11:20:51 +0200
Message-ID: <CABgObfZSyKqBs8LP0O7abHCW4Z1tR63PjExuRKo_izRTvCf+bQ@mail.gmail.com>
Subject: Re: [PATCH] meson: Don't make object files for dtrace on macOS
To: Roman Bolshakov <r.bolshakov@yadro.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/alternative; boundary="0000000000000d505f05adb0471d"
Received-SPF: pass client-ip=205.139.110.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/25 02:05:08
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.956,
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
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
 Cameron Esfahani <dirty@apple.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000000d505f05adb0471d
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Yes, I have already queued it.

Paolo

Il mar 25 ago 2020, 11:04 Roman Bolshakov <r.bolshakov@yadro.com> ha
scritto:

> On Mon, Aug 24, 2020 at 03:24:31PM +0100, Daniel P. Berrang=C3=A9 wrote:
> > On Sun, Aug 23, 2020 at 12:05:47PM +0300, Roman Bolshakov wrote:
> > > dtrace on macOS uses unresolved symbols with a special prefix to defi=
ne
> > > probes [1], only headers should be generated for USDT (dtrace(1)). Bu=
t
> > > it doesn't support backwards compatible no-op -G flag [2] and implici=
t
> > > build rules fail.
> > >
> > > 1. https://markmail.org/message/6grq2ygr5nwdwsnb
> > > 2. https://markmail.org/message/5xrxt2w5m42nojkz
> > >
> > > Cc: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> > > Cc: Cameron Esfahani <dirty@apple.com>
> > > Signed-off-by: Roman Bolshakov <r.bolshakov@yadro.com>
> > > ---
> > >  trace/meson.build | 13 ++++++++-----
> > >  1 file changed, 8 insertions(+), 5 deletions(-)
> >
> > Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> >
>
> Paolo, should it go through your meson-fixes tree?
>
> Regards,
> Roman
>
>

--0000000000000d505f05adb0471d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">Yes, I have already queued it.<div dir=3D"auto"><br></div=
><div dir=3D"auto">Paolo</div></div><br><div class=3D"gmail_quote"><div dir=
=3D"ltr" class=3D"gmail_attr">Il mar 25 ago 2020, 11:04 Roman Bolshakov &lt=
;<a href=3D"mailto:r.bolshakov@yadro.com">r.bolshakov@yadro.com</a>&gt; ha =
scritto:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .=
8ex;border-left:1px #ccc solid;padding-left:1ex">On Mon, Aug 24, 2020 at 03=
:24:31PM +0100, Daniel P. Berrang=C3=A9 wrote:<br>
&gt; On Sun, Aug 23, 2020 at 12:05:47PM +0300, Roman Bolshakov wrote:<br>
&gt; &gt; dtrace on macOS uses unresolved symbols with a special prefix to =
define<br>
&gt; &gt; probes [1], only headers should be generated for USDT (dtrace(1))=
. But<br>
&gt; &gt; it doesn&#39;t support backwards compatible no-op -G flag [2] and=
 implicit<br>
&gt; &gt; build rules fail.<br>
&gt; &gt; <br>
&gt; &gt; 1. <a href=3D"https://markmail.org/message/6grq2ygr5nwdwsnb" rel=
=3D"noreferrer noreferrer" target=3D"_blank">https://markmail.org/message/6=
grq2ygr5nwdwsnb</a><br>
&gt; &gt; 2. <a href=3D"https://markmail.org/message/5xrxt2w5m42nojkz" rel=
=3D"noreferrer noreferrer" target=3D"_blank">https://markmail.org/message/5=
xrxt2w5m42nojkz</a><br>
&gt; &gt; <br>
&gt; &gt; Cc: Daniel P. Berrang=C3=A9 &lt;<a href=3D"mailto:berrange@redhat=
.com" target=3D"_blank" rel=3D"noreferrer">berrange@redhat.com</a>&gt;<br>
&gt; &gt; Cc: Cameron Esfahani &lt;<a href=3D"mailto:dirty@apple.com" targe=
t=3D"_blank" rel=3D"noreferrer">dirty@apple.com</a>&gt;<br>
&gt; &gt; Signed-off-by: Roman Bolshakov &lt;<a href=3D"mailto:r.bolshakov@=
yadro.com" target=3D"_blank" rel=3D"noreferrer">r.bolshakov@yadro.com</a>&g=
t;<br>
&gt; &gt; ---<br>
&gt; &gt;=C2=A0 trace/meson.build | 13 ++++++++-----<br>
&gt; &gt;=C2=A0 1 file changed, 8 insertions(+), 5 deletions(-)<br>
&gt; <br>
&gt; Reviewed-by: Daniel P. Berrang=C3=A9 &lt;<a href=3D"mailto:berrange@re=
dhat.com" target=3D"_blank" rel=3D"noreferrer">berrange@redhat.com</a>&gt;<=
br>
&gt; <br>
<br>
Paolo, should it go through your meson-fixes tree?<br>
<br>
Regards,<br>
Roman<br>
<br>
</blockquote></div>

--0000000000000d505f05adb0471d--


