Return-Path: <SRS0=yZS3=YK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06686ECE597
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 17:30:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CDB6320872
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 17:30:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TiyN4x/m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDB6320872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54382 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iL9bJ-0001bq-UT
	for qemu-devel@archiver.kernel.org; Thu, 17 Oct 2019 13:30:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37772)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iL8Wg-00038Z-35
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 12:21:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iL8We-0005oz-Pc
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 12:21:21 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:39625)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1iL8We-0005oS-KJ
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 12:21:20 -0400
Received: by mail-ot1-x343.google.com with SMTP id s22so2397561otr.6
 for <qemu-devel@nongnu.org>; Thu, 17 Oct 2019 09:21:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=mdvV1MJ9vbmguRopOY7RzixX0dFrk6bLj+zB/Mf7OlI=;
 b=TiyN4x/mlQS1ut3OscYEOuG2MuDtmT0kkDZA+izAjyCOn84oJ37p5gznUdNBWWECXg
 wQIG2baUdh1Zg2q7TJBLTw1f49iyN07vRUXIbvC9RIfTrHRRC/u87cY4jw3pSObAyybI
 FRxAhH+QUxyT0wBccisPlvaBgU+aPrvC4+LUICMHT93jmS1MlY6wnUReN4WE3QMRj21x
 pq6N2kWr13GV5O6+UyjBVuWFi9AEKodB7n2h21TfKf+DpZxGchobNdWlKXp14+6BmIZJ
 LNzrz9gWSBU9CcVif2O3VUUcDtPU4dO7t8yiTGx7HTCUpIB2cMJFUA6siYIYS/IxiJ+q
 xEWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=mdvV1MJ9vbmguRopOY7RzixX0dFrk6bLj+zB/Mf7OlI=;
 b=U+7KL3LmapUDBMJeVApfYr51Wo5v2O80OHmq4arO8t9bjITTwY7/LvVzthRseb5FuZ
 +p+Lx+Edr0EvOub8P5Y2Hcr2ded/o5+2nIyyyBdzyIzRghHOmsIwMsvO3c/XKbNrjpei
 Rny8yQOhll5/x7ZosxWKFpWka7AJHXcDZPH6TK26OxQ3dtfIUv9Sh99/BWxjUvfs8xOk
 uC8qra0K2UByL+N74FBBoHG+dsf8ZkDrQCFIDLXNjm6ETuZtmntZq8AFkUfM45NU9EQp
 H8k7ywjbmPv9UUEOkhH1SU4nO8S5X2/oX5OaQn1cl73b49+07hyfOmNGPLrkLsEweqLQ
 gODg==
X-Gm-Message-State: APjAAAWYEwr330m5qooI8ti2GD6JVGc247uQgAOShT0SqVDKsg4sxWZN
 YB+V3b858zeFFv3r3O0Wod4kPUHm0yITgAzqLzI=
X-Google-Smtp-Source: APXvYqxwl8OjwvMtj3/L18E83XJdrk+Ga7+vS3bhMSv/uc58naNDuhYqfQhgQIfEVzEDQ142A368k0axqE7nSwDGGeQ=
X-Received: by 2002:a05:6830:452:: with SMTP id
 d18mr3850352otc.295.1571329279681; 
 Thu, 17 Oct 2019 09:21:19 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:340a:0:0:0:0:0 with HTTP; Thu, 17 Oct 2019 09:21:19
 -0700 (PDT)
In-Reply-To: <8bcf9189-efbe-1575-7e57-fd7bdd202547@redhat.com>
References: <20191015162705.28087-1-philmd@redhat.com>
 <20191015162705.28087-22-philmd@redhat.com>
 <CAL1e-=hLUDDqFiV8W1f2PFGYJMomvmZUXmjA55X7WEEYMykjHQ@mail.gmail.com>
 <8bcf9189-efbe-1575-7e57-fd7bdd202547@redhat.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Thu, 17 Oct 2019 18:21:19 +0200
Message-ID: <CAL1e-=g4nA1iCWYgoCSK4v53r+_dywkbf8_jfEVShrYyDDxZgg@mail.gmail.com>
Subject: Re: [PATCH 21/32] hw/i386/pc: Reduce gsi_handler scope
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000008a8c0005951d9bf8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::343
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Eduardo Habkost <ehabkost@redhat.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>, Paul Durrant <paul@xen.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
 Anthony Perard <anthony.perard@citrix.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000008a8c0005951d9bf8
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thursday, October 17, 2019, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.c=
om>
wrote:

> On 10/17/19 5:16 PM, Aleksandar Markovic wrote:
>
>> On Tuesday, October 15, 2019, Philippe Mathieu-Daud=C3=A9 <philmd@redhat=
.com
>> <mailto:philmd@redhat.com>> wrote:
>>
>>     pc_gsi_create() is the single function that uses gsi_handler.
>>     Make it a static variable.
>>
>>     Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com
>>     <mailto:philmd@redhat.com>>
>>     ---
>>       hw/i386/pc.c         | 2 +-
>>       include/hw/i386/pc.h | 2 --
>>       2 files changed, 1 insertion(+), 3 deletions(-)
>>
>>     diff --git a/hw/i386/pc.c b/hw/i386/pc.c
>>     index a7597c6c44..59de0c8a1f 100644
>>     --- a/hw/i386/pc.c
>>     +++ b/hw/i386/pc.c
>>     @@ -346,7 +346,7 @@ GlobalProperty pc_compat_1_4[] =3D {
>>       };
>>       const size_t pc_compat_1_4_len =3D G_N_ELEMENTS(pc_compat_1_4);
>>
>>     -void gsi_handler(void *opaque, int n, int level)
>>     +static void gsi_handler(void *opaque, int n, int level)
>>       {
>>           GSIState *s =3D opaque;
>>
>>     diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
>>     index d0c6b9d469..75b44e156c 100644
>>     --- a/include/hw/i386/pc.h
>>     +++ b/include/hw/i386/pc.h
>>     @@ -172,8 +172,6 @@ typedef struct GSIState {
>>           qemu_irq ioapic_irq[IOAPIC_NUM_PINS];
>>       } GSIState;
>>
>>     -void gsi_handler(void *opaque, int n, int level);
>>     -
>>       GSIState *pc_gsi_create(qemu_irq **irqs, bool pci_enabled);
>>
>>
>> Philippe, this 2-line deletion seems not to belong to this patch. If
>> true, please place it in another or a separate patch.
>>
>
> It does, this is the point of the change, make it static and remove its
> declaration :)
>


OK, I see.

Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>

--0000000000008a8c0005951d9bf8
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<br><br>On Thursday, October 17, 2019, Philippe Mathieu-Daud=C3=A9 &lt;<a h=
ref=3D"mailto:philmd@redhat.com">philmd@redhat.com</a>&gt; wrote:<br><block=
quote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc=
 solid;padding-left:1ex">On 10/17/19 5:16 PM, Aleksandar Markovic wrote:<br=
>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
On Tuesday, October 15, 2019, Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"ma=
ilto:philmd@redhat.com" target=3D"_blank">philmd@redhat.com</a> &lt;mailto:=
<a href=3D"mailto:philmd@redhat.com" target=3D"_blank">philmd@redhat.com</a=
>&gt;&gt; wrote:<br>
<br>
=C2=A0 =C2=A0 pc_gsi_create() is the single function that uses gsi_handler.=
<br>
=C2=A0 =C2=A0 Make it a static variable.<br>
<br>
=C2=A0 =C2=A0 Signed-off-by: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mai=
lto:philmd@redhat.com" target=3D"_blank">philmd@redhat.com</a><br>
=C2=A0 =C2=A0 &lt;mailto:<a href=3D"mailto:philmd@redhat.com" target=3D"_bl=
ank">philmd@redhat.com</a>&gt;&gt;<br>
=C2=A0 =C2=A0 ---<br>
=C2=A0 =C2=A0 =C2=A0=C2=A0hw/i386/pc.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 2=
 +-<br>
=C2=A0 =C2=A0 =C2=A0=C2=A0include/hw/i386/pc.h | 2 --<br>
=C2=A0 =C2=A0 =C2=A0=C2=A02 files changed, 1 insertion(+), 3 deletions(-)<b=
r>
<br>
=C2=A0 =C2=A0 diff --git a/hw/i386/pc.c b/hw/i386/pc.c<br>
=C2=A0 =C2=A0 index a7597c6c44..59de0c8a1f 100644<br>
=C2=A0 =C2=A0 --- a/hw/i386/pc.c<br>
=C2=A0 =C2=A0 +++ b/hw/i386/pc.c<br>
=C2=A0 =C2=A0 @@ -346,7 +346,7 @@ GlobalProperty pc_compat_1_4[] =3D {<br>
=C2=A0 =C2=A0 =C2=A0=C2=A0};<br>
=C2=A0 =C2=A0 =C2=A0=C2=A0const size_t pc_compat_1_4_len =3D G_N_ELEMENTS(p=
c_compat_1_4);<br>
<br>
=C2=A0 =C2=A0 -void gsi_handler(void *opaque, int n, int level)<br>
=C2=A0 =C2=A0 +static void gsi_handler(void *opaque, int n, int level)<br>
=C2=A0 =C2=A0 =C2=A0=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0GSIState *s =3D opaque;<br>
<br>
=C2=A0 =C2=A0 diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h<br>
=C2=A0 =C2=A0 index d0c6b9d469..75b44e156c 100644<br>
=C2=A0 =C2=A0 --- a/include/hw/i386/pc.h<br>
=C2=A0 =C2=A0 +++ b/include/hw/i386/pc.h<br>
=C2=A0 =C2=A0 @@ -172,8 +172,6 @@ typedef struct GSIState {<br>
=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0qemu_irq ioapic_irq[IOAPIC_NUM_PINS=
];<br>
=C2=A0 =C2=A0 =C2=A0=C2=A0} GSIState;<br>
<br>
=C2=A0 =C2=A0 -void gsi_handler(void *opaque, int n, int level);<br>
=C2=A0 =C2=A0 -<br>
=C2=A0 =C2=A0 =C2=A0=C2=A0GSIState *pc_gsi_create(qemu_irq **irqs, bool pci=
_enabled);<br>
<br>
<br>
Philippe, this 2-line deletion seems not to belong to this patch. If true, =
please place it in another or a separate patch.<br>
</blockquote>
<br>
It does, this is the point of the change, make it static and remove its dec=
laration :)<br>
</blockquote><div><br></div><div><br></div><div>OK, I see.</div><div><div i=
d=3D"cvcmsg_16dbfeb33c93ed97" class=3D"yh  " style=3D"border-top-left-radiu=
s:0px;border-top-right-radius:0px;margin-bottom:11px;overflow:visible"><div=
 class=3D"Vh" id=3D"cvcfullmsg_16dbfeb33c93ed97"><div id=3D"cvcmsgbod_16dbf=
eb33c93ed97" class=3D"aj"><div class=3D"Ni"><div class=3D"ni pi " dir=3D"lt=
r"><p dir=3D"ltr">Reviewed-by: Aleksandar Markovic &lt;<a href=3D"mailto:am=
arkovic@wavecomp.com" target=3D"_blank">amarkovic@wavecomp.com</a>&gt;</p><=
div style=3D"clear:both"></div></div><div style=3D"clear:both"></div><div><=
div class=3D"M j T b hc Aj S" tabindex=3D"0"><div class=3D"V j hf"></div></=
div></div><div style=3D"clear:both"></div></div></div></div></div><div id=
=3D"cvcmsg_16dbfecd588da1f7" class=3D"yh" style=3D"margin-bottom:11px"><div=
 class=3D"Vh" id=3D"cvcfullmsg_16dbfecd588da1f7"><div class=3D"M j Zi Mi  "=
 tabindex=3D"0"><div id=3D"cvcreply_16dbfecd588da1f7" class=3D"M j T b hc x=
h S  " tabindex=3D"0"><div class=3D"V j td"></div></div></div></div></div><=
/div><div>=C2=A0</div>

--0000000000008a8c0005951d9bf8--

