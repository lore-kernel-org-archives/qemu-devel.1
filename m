Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EA16C433E2
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 12:09:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C4D02072A
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 12:09:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ahr93iLt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C4D02072A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49796 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDo3t-0004LP-6q
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 08:09:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48550)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kDo3I-0003uD-GA
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 08:09:16 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:55237
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kDo3F-0005Gi-PE
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 08:09:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599134952;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yT011ZX6bjC6g1idWdoOBd+Ayh75uPZMSNHkgnh3fqI=;
 b=ahr93iLtzko0K0VRlXSu5GJoGNgRMvAR8VdV/IWCw0VSWgU1vy3N3IzEGB4RCI4P06KNFw
 UUvYiR0TsSVAJxAhg5nOJ6bLf1BXLZcnIJs42ufn0yT5m9gA3+22pZLXJrcS15FBzkZp+o
 ii8SJxua1Oel2qDVt0ZLutOfv4JBZ80=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-507-Xrhp8LrNNHqcrHDNw7Bakg-1; Thu, 03 Sep 2020 08:09:08 -0400
X-MC-Unique: Xrhp8LrNNHqcrHDNw7Bakg-1
Received: by mail-ed1-f71.google.com with SMTP id y15so1200119ede.14
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2020 05:09:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=yT011ZX6bjC6g1idWdoOBd+Ayh75uPZMSNHkgnh3fqI=;
 b=gLQ7ZJHfnq3pKp3dZVem5nU6dGID0qqpHnIjzk20p1soS8h5OO5GHEFPkLf6/rb1sG
 e7xwmE3hFARcL1UnlS1CUpj9kdw43PuGKvyTPWl3CMyf3fYV60CTXn58KjgHm1Cb3oVy
 /oEbytcRH5tH8LWFejAIBcdlo3MgP+Jx9C5J3wAS1vH8H36o/dC9e3bkzdFX11/02+z6
 H53uaMSrCZSITGXdeN6wmnXYfK1mAOmYLG0AfbD2g3ySeDucVBH/5jfK9ZNV/0wAVQzS
 sB8twndmxJ7w2H9BxrPTEwChv8z7Rl750Hq9B5QMrX100wdNk6araBAw7eZwdMItX4XL
 Z/NQ==
X-Gm-Message-State: AOAM5309aQArfs+kZzEqMSY00CV7eriCR2qFUrOgPOuHzk7g+RcetvRA
 tvFEzwT5zGDBGANxViKsf8IUZFr+276+y0FjKqDBcEJftYF7dgUQrxqezSCLVaY65EiY4+asjZH
 KBXpw8RcLkkuZS/ReL6s32pFGWGrWhno=
X-Received: by 2002:a17:906:328d:: with SMTP id
 13mr1841484ejw.71.1599134947476; 
 Thu, 03 Sep 2020 05:09:07 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwaMLvddDUtz6idk0UeQ9oVKqqQUNihMEzmBGYk1U47joLLzd69/56MoCRk1z3169cvw8BOm6lAzTVDuWZHwh0=
X-Received: by 2002:a17:906:328d:: with SMTP id
 13mr1841460ejw.71.1599134947182; 
 Thu, 03 Sep 2020 05:09:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200903094935.2361-1-FelixCui-oc@zhaoxin.com>
 <20200903094935.2361-2-FelixCui-oc@zhaoxin.com>
 <612db96b-2f7b-1f98-4da8-46bccff9adca@redhat.com>
 <d91ca1499e3347278f9a33a8fc314919@zhaoxin.com>
In-Reply-To: <d91ca1499e3347278f9a33a8fc314919@zhaoxin.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 3 Sep 2020 14:08:54 +0200
Message-ID: <CABgObfYCVap9Wazw137jXJTm6XrxYd2NeNhT7G0uWnRGO4=m=g@mail.gmail.com>
Subject: Re: [PATCH 1/1] Skip flatview_simplify() for specific cpu vendor
To: FelixCui-oc <FelixCui-oc@zhaoxin.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: multipart/alternative; boundary="000000000000799dfa05ae679e9a"
Received-SPF: pass client-ip=207.211.31.81; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/03 04:23:49
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
Cc: CobeChen-oc <CobeChen-oc@zhaoxin.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Peter Xu <peterx@redhat.com>,
 Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>, RockCui-oc <RockCui-oc@zhaoxin.com>,
 Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000799dfa05ae679e9a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Il gio 3 set 2020, 13:24 FelixCui-oc <FelixCui-oc@zhaoxin.com> ha scritto:

> >I think you're seeing issues when a guest accesses an adjacent mapping
> between the delete and add phases of the KVM MemoryListener.
>
> >We're considering fixing that in the kernel, by adding a new ioctl that
> changes the whole memory map in a single step.  I am CCing Peter Xu.
>
hi paolo,
>
>               What you said is very similar to my issues. My problem is
> happened when a EHCI device accesses an adjacent mapping between the dele=
te
> and add phases of the VFIO MemoryListener.  Does adding a new ioctl also
> apply to VFIO MemoryListener?
>
It would be done separately but it's the same issue. Let's ask Alex
Williamson.

Alex, the issue here is that the delete+add passes are racing against an
assigned device's DMA. For KVM we were thinking of changing the whole
memory map with a single ioctl, but that's much easier because KVM builds
its page tables lazily. It would be possible for the IOMMU too but it would
require a relatively complicated comparison of the old and new memory maps
in the kernel.

Is this something that you think would be acceptable for Linux? Would it
require changes at the IOMMU level or would it be confined to VFIO?

Thanks,

Paolo

> Best regards
>
> Felixcui-oc
>
>
> ------------------------------
> *=E5=8F=91=E4=BB=B6=E4=BA=BA:* Paolo Bonzini <pbonzini@redhat.com>
> *=E5=8F=91=E9=80=81=E6=97=B6=E9=97=B4:* 2020=E5=B9=B49=E6=9C=883=E6=97=A5=
 18:37:47
> *=E6=94=B6=E4=BB=B6=E4=BA=BA:* FelixCui-oc; Richard Henderson; Eduardo Ha=
bkost
> *=E6=8A=84=E9=80=81:* qemu-devel@nongnu.org; RockCui-oc; Tony W Wang-oc; =
CobeChen-oc;
> Peter Xu
> *=E4=B8=BB=E9=A2=98:* Re: [PATCH 1/1] Skip flatview_simplify() for specif=
ic cpu vendor
>
> On 03/09/20 11:49, FelixCuioc wrote:
> > Flatview_simplify() will merge many address ranges
> > into one range.When a part of the big range needs
> > to be changed,this will cause some innocent mappings
> > to be unmapped.So we want to skip flatview_simplify().
> >
> > Signed-off-by: FelixCuioc <FelixCui-oc@zhaoxin.com>
>
> This has several issues.  In no particular order:
>
> 1) you're adding host_get_vendor to target/i386/cpu.c so this does not
> even build for the default "../configure && make".
>
> 2) you're adding a check for the host, but the bug applies to all hosts.
>  If there is a bug on x86 hardware emulation, it should be fixed even
> when emulating x86 from ARM.
>
> 3) you're not explaining what is the big range and how the bug is
> manifesting.
>
> I think you're seeing issues when a guest accesses an adjacent mapping
> between the delete and add phases of the KVM MemoryListener.  We're
> considering fixing that in the kernel, by adding a new ioctl that
> changes the whole memory map in a single step.  I am CCing Peter Xu.
>
> Paolo
>
>
> > ---
> >  softmmu/memory.c  | 16 +++++++++++++++-
> >  target/i386/cpu.c |  8 ++++++++
> >  target/i386/cpu.h |  3 +++
> >  3 files changed, 26 insertions(+), 1 deletion(-)
> >
> > diff --git a/softmmu/memory.c b/softmmu/memory.c
> > index 70b93104e8..348e9db622 100644
> > --- a/softmmu/memory.c
> > +++ b/softmmu/memory.c
> > @@ -699,6 +699,18 @@ static MemoryRegion
> *memory_region_get_flatview_root(MemoryRegion *mr)
> >      return NULL;
> >  }
> >
> > +static bool skip_simplify(void)
> > +{
> > +    char vendor[CPUID_VENDOR_SZ + 1] =3D { 0 };
> > +    host_get_vendor(vendor);
> > +    if (!strncmp(vendor, CPUID_VENDOR_VIA, strlen(CPUID_VENDOR_VIA))
> > +        || !strncmp(vendor, CPUID_VENDOR_ZHAOXIN,
> > +                    strlen(CPUID_VENDOR_ZHAOXIN))) {
> > +        return true;
> > +    }
> > +    return false;
> > +}
> > +
> >  /* Render a memory topology into a list of disjoint absolute ranges. *=
/
> >  static FlatView *generate_memory_topology(MemoryRegion *mr)
> >  {
> > @@ -712,7 +724,9 @@ static FlatView
> *generate_memory_topology(MemoryRegion *mr)
> >                               addrrange_make(int128_zero(),
> int128_2_64()),
> >                               false, false);
> >      }
> > -    flatview_simplify(view);
> > +    if (!skip_simplify()) {
> > +        flatview_simplify(view);
> > +    }
> >
> >      view->dispatch =3D address_space_dispatch_new(view);
> >      for (i =3D 0; i < view->nr; i++) {
> > diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> > index 49d8958528..08508c8580 100644
> > --- a/target/i386/cpu.c
> > +++ b/target/i386/cpu.c
> > @@ -1664,6 +1664,14 @@ void host_cpuid(uint32_t function, uint32_t coun=
t,
> >          *edx =3D vec[3];
> >  }
> >
> > +void host_get_vendor(char *vendor)
> > +{
> > +    uint32_t eax, ebx, ecx, edx;
> > +
> > +    host_cpuid(0x0, 0, &eax, &ebx, &ecx, &edx);
> > +    x86_cpu_vendor_words2str(vendor, ebx, edx, ecx);
> > +}
> > +
> >  void host_vendor_fms(char *vendor, int *family, int *model, int
> *stepping)
> >  {
> >      uint32_t eax, ebx, ecx, edx;
> > diff --git a/target/i386/cpu.h b/target/i386/cpu.h
> > index d3097be6a5..14c8b4c09f 100644
> > --- a/target/i386/cpu.h
> > +++ b/target/i386/cpu.h
> > @@ -832,6 +832,8 @@ typedef uint64_t FeatureWordArray[FEATURE_WORDS];
> >
> >  #define CPUID_VENDOR_VIA   "CentaurHauls"
> >
> > +#define CPUID_VENDOR_ZHAOXIN   "  Shanghai  "
> > +
> >  #define CPUID_VENDOR_HYGON    "HygonGenuine"
> >
> >  #define IS_INTEL_CPU(env) ((env)->cpuid_vendor1 =3D=3D CPUID_VENDOR_IN=
TEL_1
> && \
> > @@ -1917,6 +1919,7 @@ void cpu_clear_apic_feature(CPUX86State *env);
> >  void host_cpuid(uint32_t function, uint32_t count,
> >                  uint32_t *eax, uint32_t *ebx, uint32_t *ecx, uint32_t
> *edx);
> >  void host_vendor_fms(char *vendor, int *family, int *model, int
> *stepping);
> > +void host_get_vendor(char *vendor);
> >
> >  /* helper.c */
> >  bool x86_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
> >
>
>

--000000000000799dfa05ae679e9a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">Il gio 3 set 2020, 13:24 FelixCui-oc &lt;<a href=3D"ma=
ilto:FelixCui-oc@zhaoxin.com">FelixCui-oc@zhaoxin.com</a>&gt; ha scritto:</=
div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-lef=
t:1px #ccc solid;padding-left:1ex"><div dir=3D"ltr"><div id=3D"m_4531644718=
691983322divtagdefaultwrapper" style=3D"" dir=3D"ltr"><div dir=3D"ltr" styl=
e=3D""><div id=3D"m_4531644718691983322x_divtagdefaultwrapper" dir=3D"ltr" =
style=3D""><p style=3D""><font face=3D"Calibri, Helvetica, sans-serif, Emoj=
iFont, Apple Color Emoji, Segoe UI Emoji, NotoColorEmoji, Segoe UI Symbol, =
Android Emoji, EmojiSymbols"><span style=3D"font-size:16px">&gt;I think you=
&#39;re seeing issues when a guest accesses an adjacent mapping between the=
 delete and add phases of the KVM MemoryListener.=C2=A0=C2=A0</span></font>=
</p><p style=3D""><span style=3D"font-family:Calibri,Helvetica,sans-serif,E=
mojiFont,&quot;Apple Color Emoji&quot;,&quot;Segoe UI Emoji&quot;,NotoColor=
Emoji,&quot;Segoe UI Symbol&quot;,&quot;Android Emoji&quot;,EmojiSymbols;fo=
nt-size:16px">&gt;We&#39;re considering fixing that in the kernel, by addin=
g a new ioctl that changes the whole memory map in a single step.=C2=A0 I a=
m CCing Peter Xu.</span><font face=3D"Calibri, Helvetica, sans-serif, Emoji=
Font, Apple Color Emoji, Segoe UI Emoji, NotoColorEmoji, Segoe UI Symbol, A=
ndroid Emoji, EmojiSymbols"><span style=3D"font-size:16px"><br></span></fon=
t></p></div></div></div></div></blockquote></div></div><div dir=3D"auto"><d=
iv class=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"margin:=
0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><div dir=3D"ltr"><d=
iv id=3D"m_4531644718691983322divtagdefaultwrapper" style=3D"font-size:12pt=
;color:#000000;font-family:Calibri,Helvetica,sans-serif" dir=3D"ltr"><div d=
ir=3D"ltr"><div id=3D"m_4531644718691983322x_divtagdefaultwrapper" dir=3D"l=
tr" style=3D"font-size:12pt;color:rgb(0,0,0);font-family:Calibri,Helvetica,=
sans-serif,EmojiFont,&quot;Apple Color Emoji&quot;,&quot;Segoe UI Emoji&quo=
t;,NotoColorEmoji,&quot;Segoe UI Symbol&quot;,&quot;Android Emoji&quot;,Emo=
jiSymbols"><p><span style=3D"color:rgb(33,33,33);font-family:&quot;Microsof=
t YaHei UI&quot;,&quot;Microsoft YaHei&quot;,=E5=BE=AE=E8=BD=AF=E9=9B=85=E9=
=BB=91,SimSun,=E5=AE=8B=E4=BD=93,sans-serif,serif,EmojiFont;font-size:13.33=
33px">hi paolo,</span></p>
<p><span style=3D"color:rgb(33,33,33);font-family:&quot;Microsoft YaHei UI&=
quot;,&quot;Microsoft YaHei&quot;,=E5=BE=AE=E8=BD=AF=E9=9B=85=E9=BB=91,SimS=
un,=E5=AE=8B=E4=BD=93,sans-serif,serif,EmojiFont;font-size:13.3333px">=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 What you said is very similar=
 to my issues. My problem is happened=C2=A0when a EHCI device accesses
 an adjacent mapping between the delete and add phases of the VFIO MemoryLi=
stener.</span><span style=3D"color:rgb(33,33,33);font-family:&quot;Microsof=
t YaHei UI&quot;,&quot;Microsoft YaHei&quot;,=E5=BE=AE=E8=BD=AF=E9=9B=85=E9=
=BB=91,SimSun,=E5=AE=8B=E4=BD=93,sans-serif,serif,EmojiFont;font-size:13.33=
33px">=C2=A0 Does adding a new ioctl also apply to VFIO MemoryListener?</sp=
an></p></div></div></div></div></blockquote></div></div><div dir=3D"auto"><=
span style=3D"font-family:sans-serif">It would be done separately but it&#3=
9;s the same issue. Let&#39;s ask Alex Williamson.</span></div><div dir=3D"=
auto"><span style=3D"font-family:sans-serif"><br></span></div><div dir=3D"a=
uto"><span style=3D"font-family:sans-serif">Alex, the issue here is that th=
e delete+add passes are racing against an assigned device&#39;s DMA. For KV=
M we were thinking of changing the whole memory map with a single ioctl, bu=
t that&#39;s much easier because KVM builds its page tables lazily. It woul=
d be possible for the IOMMU too but it would require a relatively complicat=
ed comparison of the old and new memory maps in the kernel.</span></div><di=
v dir=3D"auto"><span style=3D"font-family:sans-serif"><br></span></div><div=
 dir=3D"auto"><span style=3D"font-family:sans-serif">Is this something that=
 you think would be acceptable for Linux? Would it require changes at the I=
OMMU level or would it be confined to VFIO?</span></div><div dir=3D"auto"><=
span style=3D"font-family:sans-serif"><br></span></div><div dir=3D"auto"><s=
pan style=3D"font-family:sans-serif">Thanks,</span></div><div dir=3D"auto">=
<span style=3D"font-family:sans-serif"><br></span></div><div dir=3D"auto"><=
span style=3D"font-family:sans-serif">Paolo</span></div><div dir=3D"auto"><=
div class=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"margin=
:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><div dir=3D"ltr"><=
div id=3D"m_4531644718691983322divtagdefaultwrapper" style=3D"font-size:12p=
t;color:#000000;font-family:Calibri,Helvetica,sans-serif" dir=3D"ltr"><div =
dir=3D"ltr"><div id=3D"m_4531644718691983322x_divtagdefaultwrapper" dir=3D"=
ltr" style=3D"font-size:12pt;color:rgb(0,0,0);font-family:Calibri,Helvetica=
,sans-serif,EmojiFont,&quot;Apple Color Emoji&quot;,&quot;Segoe UI Emoji&qu=
ot;,NotoColorEmoji,&quot;Segoe UI Symbol&quot;,&quot;Android Emoji&quot;,Em=
ojiSymbols">
<p><span style=3D"color:rgb(33,33,33);font-family:&quot;Microsoft YaHei UI&=
quot;,&quot;Microsoft YaHei&quot;,=E5=BE=AE=E8=BD=AF=E9=9B=85=E9=BB=91,SimS=
un,=E5=AE=8B=E4=BD=93,sans-serif,serif,EmojiFont;font-size:13.3333px"><span=
 style=3D"color:rgb(33,33,33);font-family:&quot;Microsoft YaHei UI&quot;,&q=
uot;Microsoft YaHei&quot;,=E5=BE=AE=E8=BD=AF=E9=9B=85=E9=BB=91,SimSun,=E5=
=AE=8B=E4=BD=93,sans-serif,serif,EmojiFont;font-size:13.3333px">Best
 regards</span></span></p>
<p><span style=3D"color:rgb(33,33,33);font-family:&quot;Microsoft YaHei UI&=
quot;,&quot;Microsoft YaHei&quot;,=E5=BE=AE=E8=BD=AF=E9=9B=85=E9=BB=91,SimS=
un,=E5=AE=8B=E4=BD=93,sans-serif,serif,EmojiFont;font-size:13.3333px"><span=
 style=3D"color:rgb(33,33,33);font-family:&quot;Microsoft YaHei UI&quot;,&q=
uot;Microsoft YaHei&quot;,=E5=BE=AE=E8=BD=AF=E9=9B=85=E9=BB=91,SimSun,=E5=
=AE=8B=E4=BD=93,sans-serif,serif,EmojiFont;font-size:13.3333px">Felixcui-oc=
</span></span></p>
<p><span style=3D"color:rgb(33,33,33);font-family:&quot;Microsoft YaHei UI&=
quot;,&quot;Microsoft YaHei&quot;,=E5=BE=AE=E8=BD=AF=E9=9B=85=E9=BB=91,SimS=
un,=E5=AE=8B=E4=BD=93,sans-serif,serif,EmojiFont;font-size:13.3333px"><br>
</span></p>
</div>
<hr style=3D"display:inline-block;width:98%">
<div id=3D"m_4531644718691983322x_divRplyFwdMsg" dir=3D"ltr"><font face=3D"=
Calibri, sans-serif" color=3D"#000000" style=3D"font-size:11pt"><b>=E5=8F=
=91=E4=BB=B6=E4=BA=BA:</b> Paolo Bonzini &lt;<a href=3D"mailto:pbonzini@red=
hat.com" target=3D"_blank" rel=3D"noreferrer">pbonzini@redhat.com</a>&gt;<b=
r>
<b>=E5=8F=91=E9=80=81=E6=97=B6=E9=97=B4:</b> 2020=E5=B9=B49=E6=9C=883=E6=97=
=A5 18:37:47<br>
<b>=E6=94=B6=E4=BB=B6=E4=BA=BA:</b> FelixCui-oc; Richard Henderson; Eduardo=
 Habkost<br>
<b>=E6=8A=84=E9=80=81:</b> <a href=3D"mailto:qemu-devel@nongnu.org" target=
=3D"_blank" rel=3D"noreferrer">qemu-devel@nongnu.org</a>; RockCui-oc; Tony =
W Wang-oc; CobeChen-oc; Peter Xu<br>
<b>=E4=B8=BB=E9=A2=98:</b> Re: [PATCH 1/1] Skip flatview_simplify() for spe=
cific cpu vendor</font>
<div>=C2=A0</div>
</div>
</div>
<font size=3D"2"><span style=3D"font-size:10pt">
<div>On 03/09/20 11:49, FelixCuioc wrote:<br>
&gt; Flatview_simplify() will merge many address ranges<br>
&gt; into one range.When a part of the big range needs<br>
&gt; to be changed,this will cause some innocent mappings<br>
&gt; to be unmapped.So we want to skip flatview_simplify().<br>
&gt; <br>
&gt; Signed-off-by: FelixCuioc &lt;<a href=3D"mailto:FelixCui-oc@zhaoxin.co=
m" target=3D"_blank" rel=3D"noreferrer">FelixCui-oc@zhaoxin.com</a>&gt;<br>
<br>
This has several issues.=C2=A0 In no particular order:<br>
<br>
1) you&#39;re adding host_get_vendor to target/i386/cpu.c so this does not<=
br>
even build for the default &quot;../configure &amp;&amp; make&quot;.<br>
<br>
2) you&#39;re adding a check for the host, but the bug applies to all hosts=
.<br>
=C2=A0If there is a bug on x86 hardware emulation, it should be fixed even<=
br>
when emulating x86 from ARM.<br>
<br>
3) you&#39;re not explaining what is the big range and how the bug is<br>
manifesting.<br>
<br>
I think you&#39;re seeing issues when a guest accesses an adjacent mapping<=
br>
between the delete and add phases of the KVM MemoryListener.=C2=A0 We&#39;r=
e<br>
considering fixing that in the kernel, by adding a new ioctl that<br>
changes the whole memory map in a single step.=C2=A0 I am CCing Peter Xu.<b=
r>
<br>
Paolo<br>
<br>
<br>
&gt; ---<br>
&gt;=C2=A0 softmmu/memory.c=C2=A0 | 16 +++++++++++++++-<br>
&gt;=C2=A0 target/i386/cpu.c |=C2=A0 8 ++++++++<br>
&gt;=C2=A0 target/i386/cpu.h |=C2=A0 3 +++<br>
&gt;=C2=A0 3 files changed, 26 insertions(+), 1 deletion(-)<br>
&gt; <br>
&gt; diff --git a/softmmu/memory.c b/softmmu/memory.c<br>
&gt; index 70b93104e8..348e9db622 100644<br>
&gt; --- a/softmmu/memory.c<br>
&gt; +++ b/softmmu/memory.c<br>
&gt; @@ -699,6 +699,18 @@ static MemoryRegion *memory_region_get_flatview_r=
oot(MemoryRegion *mr)<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return NULL;<br>
&gt;=C2=A0 }<br>
&gt;=C2=A0 <br>
&gt; +static bool skip_simplify(void)<br>
&gt; +{<br>
&gt; +=C2=A0=C2=A0=C2=A0 char vendor[CPUID_VENDOR_SZ + 1] =3D { 0 };<br>
&gt; +=C2=A0=C2=A0=C2=A0 host_get_vendor(vendor);<br>
&gt; +=C2=A0=C2=A0=C2=A0 if (!strncmp(vendor, CPUID_VENDOR_VIA, strlen(CPUI=
D_VENDOR_VIA))<br>
&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 || !strncmp(vendor, CPUID_=
VENDOR_ZHAOXIN,<br>
&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 strlen(CPUID_VENDOR_ZHAOXIN))=
) {<br>
&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return true;<br>
&gt; +=C2=A0=C2=A0=C2=A0 }<br>
&gt; +=C2=A0=C2=A0=C2=A0 return false;<br>
&gt; +}<br>
&gt; +<br>
&gt;=C2=A0 /* Render a memory topology into a list of disjoint absolute ran=
ges. */<br>
&gt;=C2=A0 static FlatView *generate_memory_topology(MemoryRegion *mr)<br>
&gt;=C2=A0 {<br>
&gt; @@ -712,7 +724,9 @@ static FlatView *generate_memory_topology(MemoryRe=
gion *mr)<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 addrrange_make(int128_zero(), int128_2=
_64()),<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 false, false);<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }<br>
&gt; -=C2=A0=C2=A0=C2=A0 flatview_simplify(view);<br>
&gt; +=C2=A0=C2=A0=C2=A0 if (!skip_simplify()) {<br>
&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 flatview_simplify(view);<b=
r>
&gt; +=C2=A0=C2=A0=C2=A0 }<br>
&gt;=C2=A0 <br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 view-&gt;dispatch =3D address_space_disp=
atch_new(view);<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 for (i =3D 0; i &lt; view-&gt;nr; i++) {=
<br>
&gt; diff --git a/target/i386/cpu.c b/target/i386/cpu.c<br>
&gt; index 49d8958528..08508c8580 100644<br>
&gt; --- a/target/i386/cpu.c<br>
&gt; +++ b/target/i386/cpu.c<br>
&gt; @@ -1664,6 +1664,14 @@ void host_cpuid(uint32_t function, uint32_t cou=
nt,<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *edx =3D vec[3];=
<br>
&gt;=C2=A0 }<br>
&gt;=C2=A0 <br>
&gt; +void host_get_vendor(char *vendor)<br>
&gt; +{<br>
&gt; +=C2=A0=C2=A0=C2=A0 uint32_t eax, ebx, ecx, edx;<br>
&gt; +<br>
&gt; +=C2=A0=C2=A0=C2=A0 host_cpuid(0x0, 0, &amp;eax, &amp;ebx, &amp;ecx, &=
amp;edx);<br>
&gt; +=C2=A0=C2=A0=C2=A0 x86_cpu_vendor_words2str(vendor, ebx, edx, ecx);<b=
r>
&gt; +}<br>
&gt; +<br>
&gt;=C2=A0 void host_vendor_fms(char *vendor, int *family, int *model, int =
*stepping)<br>
&gt;=C2=A0 {<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint32_t eax, ebx, ecx, edx;<br>
&gt; diff --git a/target/i386/cpu.h b/target/i386/cpu.h<br>
&gt; index d3097be6a5..14c8b4c09f 100644<br>
&gt; --- a/target/i386/cpu.h<br>
&gt; +++ b/target/i386/cpu.h<br>
&gt; @@ -832,6 +832,8 @@ typedef uint64_t FeatureWordArray[FEATURE_WORDS];<=
br>
&gt;=C2=A0 <br>
&gt;=C2=A0 #define CPUID_VENDOR_VIA=C2=A0=C2=A0 &quot;CentaurHauls&quot;<br=
>
&gt;=C2=A0 <br>
&gt; +#define CPUID_VENDOR_ZHAOXIN=C2=A0=C2=A0 &quot;=C2=A0 Shanghai=C2=A0 =
&quot;<br>
&gt; +<br>
&gt;=C2=A0 #define CPUID_VENDOR_HYGON=C2=A0=C2=A0=C2=A0 &quot;HygonGenuine&=
quot;<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 #define IS_INTEL_CPU(env) ((env)-&gt;cpuid_vendor1 =3D=3D CPUID_=
VENDOR_INTEL_1 &amp;&amp; \<br>
&gt; @@ -1917,6 +1919,7 @@ void cpu_clear_apic_feature(CPUX86State *env);<b=
r>
&gt;=C2=A0 void host_cpuid(uint32_t function, uint32_t count,<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint32_t *eax, uint32_t *ebx, uint32_t *e=
cx, uint32_t *edx);<br>
&gt;=C2=A0 void host_vendor_fms(char *vendor, int *family, int *model, int =
*stepping);<br>
&gt; +void host_get_vendor(char *vendor);<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 /* helper.c */<br>
&gt;=C2=A0 bool x86_cpu_tlb_fill(CPUState *cs, vaddr address, int size,<br>
&gt; <br>
<br>
</div>
</span></font></div>
</div>

</blockquote></div></div></div>

--000000000000799dfa05ae679e9a--


