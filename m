Return-Path: <SRS0=UKTp=CS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BFE7C43461
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 11:07:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 75B17207DE
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 11:07:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E5BzF0oV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75B17207DE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58490 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFxww-0000EK-W8
	for qemu-devel@archiver.kernel.org; Wed, 09 Sep 2020 07:07:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53772)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kFxwA-00088d-HP
 for qemu-devel@nongnu.org; Wed, 09 Sep 2020 07:06:50 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:42340
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kFxw5-0003jI-TW
 for qemu-devel@nongnu.org; Wed, 09 Sep 2020 07:06:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599649603;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qCIqDCl8Ci59gGUJz8sD9q8hDr2VI+p9f+dBICCGzlU=;
 b=E5BzF0oVjLrHJ7RZ4lq7hhwWR0JDKU2HOVCqs1vg2jOZSOTh/+2mq7DAicnSLRJpuQjh60
 xAr/mIDYMIvA4f9MNE5mKNPER7jszxVWPbYBEzPMerWaVh8Ax8pNHWsMRm/KExflcgqVZO
 ep/mOk1MyDIdiZJpb8Zq6LGYJuYhqs0=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-396-WYTiiCsCP9S2Oq3nUVdvbA-1; Wed, 09 Sep 2020 07:06:35 -0400
X-MC-Unique: WYTiiCsCP9S2Oq3nUVdvbA-1
Received: by mail-ej1-f72.google.com with SMTP id rs9so1118149ejb.17
 for <qemu-devel@nongnu.org>; Wed, 09 Sep 2020 04:06:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=qCIqDCl8Ci59gGUJz8sD9q8hDr2VI+p9f+dBICCGzlU=;
 b=GsVGPkOquxPU7R4axf6vRSvf7dBTTZpAvVkrF1yyYN26zwDohZ2Hgb92pJNfP6bs/o
 v+uss7Elsndi+NifDfU15AKFQdVluUiuYVfHPtWmFtyBFqLpdUjuLR3rDRn5A1I0a1zr
 AfX1IWB7ml6vWJgYGxH4savuEgHRHsU71Ti+5fo/bXQmOItMhXJY6npi1n7+Q3vPizTD
 KuVIsoG9p1hURoeNiI4tlQswYJ7Udwd9fSyc6qMMjErXdGr68/WTiYR+zoHtFUhJ9ksw
 sRrdL4Aper99SV9vqMlZPyNp2KZgEqIJbIJc7F5qS2y5EnXzbyUPmVn8VzVhYQV5VTyC
 6qVA==
X-Gm-Message-State: AOAM530qdiJoSMpIhejv3U4S1cbuwAO1pg5qTutYZ5i4qMAwD8/xP68h
 JDaWRaHMEFeGecHsQ6s2C50CqZQjwDeNol/HHlboYejJL0N7PnE+cb8CcZGi4UOyB+FHFmJHdd8
 jN2wuI/FlXgJuy6Casx/NLt2qNijl+eI=
X-Received: by 2002:a17:906:8508:: with SMTP id
 i8mr3209690ejx.390.1599649594227; 
 Wed, 09 Sep 2020 04:06:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw04ozcXrljfVPCYcppRso2pEWpC3R0p0ErHMIpJqV5m4AcQS0Z1I0gNxkCPp9VGlrS/seuXQlDwyqEKAx7lwY=
X-Received: by 2002:a17:906:8508:: with SMTP id
 i8mr3209671ejx.390.1599649593986; 
 Wed, 09 Sep 2020 04:06:33 -0700 (PDT)
MIME-Version: 1.0
References: <c9971e27-fded-3e5d-d489-b1fb539b8ec1@suse.de>
 <41c09bb2-1704-47c0-9638-9f1eff010e8c@redhat.com>
 <462d6cfa-f4ba-d001-200b-9fc017f7e2fc@suse.de>
 <3981cd71-deaf-b939-d6fa-09b9b3b94521@suse.de>
In-Reply-To: <3981cd71-deaf-b939-d6fa-09b9b3b94521@suse.de>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 9 Sep 2020 13:06:20 +0200
Message-ID: <CABgObfaXVJWbco-eFTBXOfu8RdEWqyyqEx3rKHKS7Y+6mPVF1A@mail.gmail.com>
Subject: Re: meson build failure, configure without tcg,
 fixed by running make again
To: Claudio Fontana <cfontana@suse.de>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: multipart/alternative; boundary="000000000000d0a49105aedf7129"
Received-SPF: pass client-ip=205.139.110.61; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/09 03:20:45
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000d0a49105aedf7129
Content-Type: text/plain; charset="UTF-8"

Ok, that's a separate failure. I will take a look.

Paolo

Il mer 9 set 2020, 12:56 Claudio Fontana <cfontana@suse.de> ha scritto:

> On 9/2/20 3:02 PM, Claudio Fontana wrote:
> > On 9/2/20 12:27 PM, Paolo Bonzini wrote:
> >> On 02/09/20 12:03, Claudio Fontana wrote:
> >>> Hi Paolo,
> >>>
> >>> there seems to be some parallelism or race condition somewhere?
> >>>
> >>> with master, commit 8d90bfc5c31ad60f6049dd39be636b06bc00b652
> >>> I am doing:
> >>>
> >>> mkdir build-nontcg
> >>> cd build-nontcg
> >>> ../configure --disable-tcg --enable-kvm --enable-hax
> >>> make -j120
> >>> make -j120 check
> >>>
> >>> I am getting:
> >>
> >> Yes:
> >>
> >> diff --git a/tests/qtest/libqos/meson.build
> b/tests/qtest/libqos/meson.build
> >> index 19931b9248..268ea23803 100644
> >> --- a/tests/qtest/libqos/meson.build
> >> +++ b/tests/qtest/libqos/meson.build
> >> @@ -52,6 +52,6 @@ libqos = static_library('qos',
> >>          'arm-xilinx-zynq-a9-machine.c',
> >>          'ppc64_pseries-machine.c',
> >>          'x86_64_pc-machine.c',
> >> -), build_by_default: false)
> >> +) + genh, build_by_default: false)
> >>
> >>  qos = declare_dependency(link_whole: libqos)
> >>
> >> Paolo
> >>
> >
> > Hi Paolo,
> >
> > this one worked for me just fine, I did not try your latest patch which
> is a bit different.
> >
> > Ciao,
> >
> > Claudio
> >
>
> Hi Paolo,
>
> a heads-up on this: while the diff above worked for me just fine, your
> latest patch committed to master does _not_ solve the issue for me.
> Same errors as before during parallel builds with large number of cpus.
>
> I replaced the solution currently in master with the meson.build as per
> the diff above, but still I got problems:
>
> In file included from tests/test-qapi-events-sub-sub-module.c:16:0:
> tests/test-qapi-visit-sub-sub-module.h:16:10: fatal error:
> qapi/qapi-builtin-visit.h: No such file or directory
>  #include "qapi/qapi-builtin-visit.h"
>           ^~~~~~~~~~~~~~~~~~~~~~~~~~~
> In file included from tests/include/test-qapi-events-sub-module.c:16:0:
> tests/include/test-qapi-visit-sub-module.h:16:10: fatal error:
> qapi/qapi-builtin-visit.h: No such file or directory
>  #include "qapi/qapi-builtin-visit.h"
>           ^~~~~~~~~~~~~~~~~~~~~~~~~~~
> compilation terminated.
> compilation terminated.
> In file included from tests/test-qapi-visit-sub-sub-module.c:16:0:
> tests/test-qapi-visit-sub-sub-module.h:16:10: fatal error:
> qapi/qapi-builtin-visit.h: No such file or directory
>  #include "qapi/qapi-builtin-visit.h"
>           ^~~~~~~~~~~~~~~~~~~~~~~~~~~
> compilation terminated.
> In file included from tests/include/test-qapi-visit-sub-module.c:16:0:
> tests/include/test-qapi-visit-sub-module.h:16:10: fatal error:
> qapi/qapi-builtin-visit.h: No such file or directory
>  #include "qapi/qapi-builtin-visit.h"
>           ^~~~~~~~~~~~~~~~~~~~~~~~~~~
> compilation terminated.
> tests/qapi-builtin-visit.c:15:10: fatal error: qapi/qapi-builtin-visit.h:
> No such file or directory
>  #include "qapi/qapi-builtin-visit.h"
>           ^~~~~~~~~~~~~~~~~~~~~~~~~~~
> compilation terminated.
> In file included from tests/test-qapi-commands-sub-sub-module.c:20:0:
> tests/test-qapi-visit-sub-sub-module.h:16:10: fatal error:
> qapi/qapi-builtin-visit.h: No such file or directory
>  #include "qapi/qapi-builtin-visit.h"
>           ^~~~~~~~~~~~~~~~~~~~~~~~~~~
> compilation terminated.
> In file included from tests/include/test-qapi-types-sub-module.c:16:0:
> tests/include/test-qapi-visit-sub-module.h:16:10: fatal error:
> qapi/qapi-builtin-visit.h: No such file or directory
>  #include "qapi/qapi-builtin-visit.h"
>           ^~~~~~~~~~~~~~~~~~~~~~~~~~~
> compilation terminated.
> tests/qapi-builtin-types.c:16:10: fatal error: qapi/qapi-builtin-visit.h:
> No such file or directory
>  #include "qapi/qapi-builtin-visit.h"
>           ^~~~~~~~~~~~~~~~~~~~~~~~~~~
> compilation terminated.
> In file included from tests/test-qapi-events.c:16:0:
> tests/test-qapi-visit.h:16:10: fatal error: qapi/qapi-builtin-visit.h: No
> such file or directory
>  #include "qapi/qapi-builtin-visit.h"
>           ^~~~~~~~~~~~~~~~~~~~~~~~~~~
> compilation terminated.
> In file included from tests/test-qapi-types-sub-sub-module.c:16:0:
> tests/test-qapi-visit-sub-sub-module.h:16:10: fatal error:
> qapi/qapi-builtin-visit.h: No such file or directory
>  #include "qapi/qapi-builtin-visit.h"
>           ^~~~~~~~~~~~~~~~~~~~~~~~~~~
> compilation terminated.
> make: *** [Makefile.ninja:1760:
> tests/libtestqapi.a.p/meson-generated_.._qapi-builtin-types.c.o] Error 1
> make: *** Waiting for unfinished jobs....
> make: *** [Makefile.ninja:1761:
> tests/libtestqapi.a.p/meson-generated_.._qapi-builtin-visit.c.o] Error 1
> make: *** [Makefile.ninja:1762:
> tests/libtestqapi.a.p/meson-generated_.._test-qapi-commands-sub-sub-module.c.o]
> Error 1
> make: *** [Makefile.ninja:1765:
> tests/libtestqapi.a.p/meson-generated_.._test-qapi-events-sub-sub-module.c.o]
> Error 1
> make: *** [Makefile.ninja:1766:
> tests/libtestqapi.a.p/meson-generated_.._test-qapi-events.c.o] Error 1
> make: *** [Makefile.ninja:1771:
> tests/libtestqapi.a.p/meson-generated_.._test-qapi-visit-sub-sub-module.c.o]
> Error 1
> make: *** [Makefile.ninja:1774:
> tests/libtestqapi.a.p/meson-generated_.._include_test-qapi-events-sub-module.c.o]
> Error 1
> make: *** [Makefile.ninja:1775:
> tests/libtestqapi.a.p/meson-generated_.._include_test-qapi-types-sub-module.c.o]
> Error 1
> make: *** [Makefile.ninja:1776:
> tests/libtestqapi.a.p/meson-generated_.._include_test-qapi-visit-sub-module.c.o]
> Error 1
> make: *** [Makefile.ninja:1769:
> tests/libtestqapi.a.p/meson-generated_.._test-qapi-types-sub-sub-module.c.o]
> Error 1
> In file included from tests/test-qapi-types.c:16:0:
> tests/test-qapi-visit.h:16:10: fatal error: qapi/qapi-builtin-visit.h: No
> such file or directory
>  #include "qapi/qapi-builtin-visit.h"
>           ^~~~~~~~~~~~~~~~~~~~~~~~~~~
> compilation terminated.
> In file included from tests/test-qapi-visit.c:16:0:
> tests/test-qapi-visit.h:16:10: fatal error: qapi/qapi-builtin-visit.h: No
> such file or directory
>  #include "qapi/qapi-builtin-visit.h"
>           ^~~~~~~~~~~~~~~~~~~~~~~~~~~
> compilation terminated.
> In file included from tests/test-qapi-commands.c:20:0:
> tests/test-qapi-visit.h:16:10: fatal error: qapi/qapi-builtin-visit.h: No
> such file or directory
>  #include "qapi/qapi-builtin-visit.h"
>           ^~~~~~~~~~~~~~~~~~~~~~~~~~~
> compilation terminated.
> make: *** [Makefile.ninja:1772:
> tests/libtestqapi.a.p/meson-generated_.._test-qapi-visit.c.o] Error 1
> make: *** [Makefile.ninja:1770:
> tests/libtestqapi.a.p/meson-generated_.._test-qapi-types.c.o] Error 1
> In file included from tests/include/test-qapi-commands-sub-module.c:20:0:
> tests/include/test-qapi-visit-sub-module.h:16:10: fatal error:
> qapi/qapi-builtin-visit.h: No such file or directory
>  #include "qapi/qapi-builtin-visit.h"
>           ^~~~~~~~~~~~~~~~~~~~~~~~~~~
> compilation terminated.
> make: *** [Makefile.ninja:1763:
> tests/libtestqapi.a.p/meson-generated_.._test-qapi-commands.c.o] Error 1
> make: *** [Makefile.ninja:1773:
> tests/libtestqapi.a.p/meson-generated_.._include_test-qapi-commands-sub-module.c.o]
> Error 1
>
>
> Thanks!
>
> Claudio
>
>
>
>

--000000000000d0a49105aedf7129
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">Ok, that&#39;s a separate failure. I will take a look.<di=
v dir=3D"auto"><br></div><div dir=3D"auto">Paolo</div></div><br><div class=
=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">Il mer 9 set 2020, 1=
2:56 Claudio Fontana &lt;<a href=3D"mailto:cfontana@suse.de">cfontana@suse.=
de</a>&gt; ha scritto:<br></div><blockquote class=3D"gmail_quote" style=3D"=
margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">On 9/2/20 3:=
02 PM, Claudio Fontana wrote:<br>
&gt; On 9/2/20 12:27 PM, Paolo Bonzini wrote:<br>
&gt;&gt; On 02/09/20 12:03, Claudio Fontana wrote:<br>
&gt;&gt;&gt; Hi Paolo,<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; there seems to be some parallelism or race condition somewhere=
?<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; with master, commit 8d90bfc5c31ad60f6049dd39be636b06bc00b652<b=
r>
&gt;&gt;&gt; I am doing:<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; mkdir build-nontcg<br>
&gt;&gt;&gt; cd build-nontcg<br>
&gt;&gt;&gt; ../configure --disable-tcg --enable-kvm --enable-hax<br>
&gt;&gt;&gt; make -j120<br>
&gt;&gt;&gt; make -j120 check<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; I am getting:<br>
&gt;&gt;<br>
&gt;&gt; Yes:<br>
&gt;&gt;<br>
&gt;&gt; diff --git a/tests/qtest/libqos/meson.build b/tests/qtest/libqos/m=
eson.build<br>
&gt;&gt; index 19931b9248..268ea23803 100644<br>
&gt;&gt; --- a/tests/qtest/libqos/meson.build<br>
&gt;&gt; +++ b/tests/qtest/libqos/meson.build<br>
&gt;&gt; @@ -52,6 +52,6 @@ libqos =3D static_library(&#39;qos&#39;,<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;arm-xilinx-zynq-a9-machine.=
c&#39;,<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;ppc64_pseries-machine.c&#39=
;,<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;x86_64_pc-machine.c&#39;,<b=
r>
&gt;&gt; -), build_by_default: false)<br>
&gt;&gt; +) + genh, build_by_default: false)<br>
&gt;&gt;=C2=A0 <br>
&gt;&gt;=C2=A0 qos =3D declare_dependency(link_whole: libqos)<br>
&gt;&gt;<br>
&gt;&gt; Paolo<br>
&gt;&gt;<br>
&gt; <br>
&gt; Hi Paolo,<br>
&gt; <br>
&gt; this one worked for me just fine, I did not try your latest patch whic=
h is a bit different.<br>
&gt; <br>
&gt; Ciao,<br>
&gt; <br>
&gt; Claudio<br>
&gt; <br>
<br>
Hi Paolo,<br>
<br>
a heads-up on this: while the diff above worked for me just fine, your late=
st patch committed to master does _not_ solve the issue for me.<br>
Same errors as before during parallel builds with large number of cpus.<br>
<br>
I replaced the solution currently in master with the meson.build as per the=
 diff above, but still I got problems:<br>
<br>
In file included from tests/test-qapi-events-sub-sub-module.c:16:0:<br>
tests/test-qapi-visit-sub-sub-module.h:16:10: fatal error: qapi/qapi-builti=
n-visit.h: No such file or directory<br>
=C2=A0#include &quot;qapi/qapi-builtin-visit.h&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ^~~~~~~~~~~~~~~~~~~~~~~~~~~<br>
In file included from tests/include/test-qapi-events-sub-module.c:16:0:<br>
tests/include/test-qapi-visit-sub-module.h:16:10: fatal error: qapi/qapi-bu=
iltin-visit.h: No such file or directory<br>
=C2=A0#include &quot;qapi/qapi-builtin-visit.h&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ^~~~~~~~~~~~~~~~~~~~~~~~~~~<br>
compilation terminated.<br>
compilation terminated.<br>
In file included from tests/test-qapi-visit-sub-sub-module.c:16:0:<br>
tests/test-qapi-visit-sub-sub-module.h:16:10: fatal error: qapi/qapi-builti=
n-visit.h: No such file or directory<br>
=C2=A0#include &quot;qapi/qapi-builtin-visit.h&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ^~~~~~~~~~~~~~~~~~~~~~~~~~~<br>
compilation terminated.<br>
In file included from tests/include/test-qapi-visit-sub-module.c:16:0:<br>
tests/include/test-qapi-visit-sub-module.h:16:10: fatal error: qapi/qapi-bu=
iltin-visit.h: No such file or directory<br>
=C2=A0#include &quot;qapi/qapi-builtin-visit.h&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ^~~~~~~~~~~~~~~~~~~~~~~~~~~<br>
compilation terminated.<br>
tests/qapi-builtin-visit.c:15:10: fatal error: qapi/qapi-builtin-visit.h: N=
o such file or directory<br>
=C2=A0#include &quot;qapi/qapi-builtin-visit.h&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ^~~~~~~~~~~~~~~~~~~~~~~~~~~<br>
compilation terminated.<br>
In file included from tests/test-qapi-commands-sub-sub-module.c:20:0:<br>
tests/test-qapi-visit-sub-sub-module.h:16:10: fatal error: qapi/qapi-builti=
n-visit.h: No such file or directory<br>
=C2=A0#include &quot;qapi/qapi-builtin-visit.h&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ^~~~~~~~~~~~~~~~~~~~~~~~~~~<br>
compilation terminated.<br>
In file included from tests/include/test-qapi-types-sub-module.c:16:0:<br>
tests/include/test-qapi-visit-sub-module.h:16:10: fatal error: qapi/qapi-bu=
iltin-visit.h: No such file or directory<br>
=C2=A0#include &quot;qapi/qapi-builtin-visit.h&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ^~~~~~~~~~~~~~~~~~~~~~~~~~~<br>
compilation terminated.<br>
tests/qapi-builtin-types.c:16:10: fatal error: qapi/qapi-builtin-visit.h: N=
o such file or directory<br>
=C2=A0#include &quot;qapi/qapi-builtin-visit.h&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ^~~~~~~~~~~~~~~~~~~~~~~~~~~<br>
compilation terminated.<br>
In file included from tests/test-qapi-events.c:16:0:<br>
tests/test-qapi-visit.h:16:10: fatal error: qapi/qapi-builtin-visit.h: No s=
uch file or directory<br>
=C2=A0#include &quot;qapi/qapi-builtin-visit.h&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ^~~~~~~~~~~~~~~~~~~~~~~~~~~<br>
compilation terminated.<br>
In file included from tests/test-qapi-types-sub-sub-module.c:16:0:<br>
tests/test-qapi-visit-sub-sub-module.h:16:10: fatal error: qapi/qapi-builti=
n-visit.h: No such file or directory<br>
=C2=A0#include &quot;qapi/qapi-builtin-visit.h&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ^~~~~~~~~~~~~~~~~~~~~~~~~~~<br>
compilation terminated.<br>
make: *** [Makefile.ninja:1760: tests/libtestqapi.a.p/meson-generated_.._qa=
pi-builtin-types.c.o] Error 1<br>
make: *** Waiting for unfinished jobs....<br>
make: *** [Makefile.ninja:1761: tests/libtestqapi.a.p/meson-generated_.._qa=
pi-builtin-visit.c.o] Error 1<br>
make: *** [Makefile.ninja:1762: tests/libtestqapi.a.p/meson-generated_.._te=
st-qapi-commands-sub-sub-module.c.o] Error 1<br>
make: *** [Makefile.ninja:1765: tests/libtestqapi.a.p/meson-generated_.._te=
st-qapi-events-sub-sub-module.c.o] Error 1<br>
make: *** [Makefile.ninja:1766: tests/libtestqapi.a.p/meson-generated_.._te=
st-qapi-events.c.o] Error 1<br>
make: *** [Makefile.ninja:1771: tests/libtestqapi.a.p/meson-generated_.._te=
st-qapi-visit-sub-sub-module.c.o] Error 1<br>
make: *** [Makefile.ninja:1774: tests/libtestqapi.a.p/meson-generated_.._in=
clude_test-qapi-events-sub-module.c.o] Error 1<br>
make: *** [Makefile.ninja:1775: tests/libtestqapi.a.p/meson-generated_.._in=
clude_test-qapi-types-sub-module.c.o] Error 1<br>
make: *** [Makefile.ninja:1776: tests/libtestqapi.a.p/meson-generated_.._in=
clude_test-qapi-visit-sub-module.c.o] Error 1<br>
make: *** [Makefile.ninja:1769: tests/libtestqapi.a.p/meson-generated_.._te=
st-qapi-types-sub-sub-module.c.o] Error 1<br>
In file included from tests/test-qapi-types.c:16:0:<br>
tests/test-qapi-visit.h:16:10: fatal error: qapi/qapi-builtin-visit.h: No s=
uch file or directory<br>
=C2=A0#include &quot;qapi/qapi-builtin-visit.h&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ^~~~~~~~~~~~~~~~~~~~~~~~~~~<br>
compilation terminated.<br>
In file included from tests/test-qapi-visit.c:16:0:<br>
tests/test-qapi-visit.h:16:10: fatal error: qapi/qapi-builtin-visit.h: No s=
uch file or directory<br>
=C2=A0#include &quot;qapi/qapi-builtin-visit.h&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ^~~~~~~~~~~~~~~~~~~~~~~~~~~<br>
compilation terminated.<br>
In file included from tests/test-qapi-commands.c:20:0:<br>
tests/test-qapi-visit.h:16:10: fatal error: qapi/qapi-builtin-visit.h: No s=
uch file or directory<br>
=C2=A0#include &quot;qapi/qapi-builtin-visit.h&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ^~~~~~~~~~~~~~~~~~~~~~~~~~~<br>
compilation terminated.<br>
make: *** [Makefile.ninja:1772: tests/libtestqapi.a.p/meson-generated_.._te=
st-qapi-visit.c.o] Error 1<br>
make: *** [Makefile.ninja:1770: tests/libtestqapi.a.p/meson-generated_.._te=
st-qapi-types.c.o] Error 1<br>
In file included from tests/include/test-qapi-commands-sub-module.c:20:0:<b=
r>
tests/include/test-qapi-visit-sub-module.h:16:10: fatal error: qapi/qapi-bu=
iltin-visit.h: No such file or directory<br>
=C2=A0#include &quot;qapi/qapi-builtin-visit.h&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ^~~~~~~~~~~~~~~~~~~~~~~~~~~<br>
compilation terminated.<br>
make: *** [Makefile.ninja:1763: tests/libtestqapi.a.p/meson-generated_.._te=
st-qapi-commands.c.o] Error 1<br>
make: *** [Makefile.ninja:1773: tests/libtestqapi.a.p/meson-generated_.._in=
clude_test-qapi-commands-sub-module.c.o] Error 1<br>
<br>
<br>
Thanks!<br>
<br>
Claudio<br>
<br>
<br>
<br>
</blockquote></div>

--000000000000d0a49105aedf7129--


