Return-Path: <SRS0=wQM/=BV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A75BC433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2020 20:05:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C70B820756
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2020 20:05:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NO5w7YjY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C70B820756
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35742 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5aWu-0007yk-Vl
	for qemu-devel@archiver.kernel.org; Tue, 11 Aug 2020 16:05:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40652)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <scw@google.com>) id 1k5aWF-0007TX-IK
 for qemu-devel@nongnu.org; Tue, 11 Aug 2020 16:05:11 -0400
Received: from mail-ej1-x641.google.com ([2a00:1450:4864:20::641]:34897)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <scw@google.com>) id 1k5aWD-0003IV-EC
 for qemu-devel@nongnu.org; Tue, 11 Aug 2020 16:05:11 -0400
Received: by mail-ej1-x641.google.com with SMTP id a26so14475086ejc.2
 for <qemu-devel@nongnu.org>; Tue, 11 Aug 2020 13:05:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=UobFVh+PXGjAhR9WW3GDlrBx5JjVYLm62tr47jo0SOA=;
 b=NO5w7YjYZxZTGr9pd5P1dgvZ+o/TcBIbbHhrQz3iRJ2okBkHsKv1IVqNji9iJy/hLY
 draKHykHtyXstUd+HTh+1imtOwp5C+eKLPHQ79eIjq8kZ/YA/ZHTybvMSBOldvBNaUSC
 4QHi/JAEhIh2kvw55PGYqNDFoFtzFZs2QDYrypw2a7ZfOu+fxmyUWgz+9DsQjPEKMr15
 pDPD0/WzFzM4qR3ooFKtH4jbkb+xDCN9B6EkhlRVnskTOvIZgqecR2WvPib7qOWEAPtr
 PPRTcOrPS3p0+evG3OefX1y6GNhK74Lm4D1Ey1Zv5A85jxBSMWK7s7gxvrLFPVICSsYG
 gwRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=UobFVh+PXGjAhR9WW3GDlrBx5JjVYLm62tr47jo0SOA=;
 b=G0/Cfxkesra4brqqREF06XG6Zg/X/2IFY2Lboc6KYrov7CJxdq9h4tt1/9rM9sbrZF
 FEWQe4WRs4x+wjfJBN/FddiuKBlcDz61ZthD9MJx6Sbn3uL2J7m+1uV4Iax915tdJFfq
 Xxc5rMWGM3ZOlGB2AGpIaX5lN5auJfOiMDM7y8Onbtj4kOmKvskfsSd+lcPB+N0JBMID
 upBVtPtx7cTKPMzmL6p/BxWo3YRpeDGe+2iZ4F8SvSc4sY53onPpvgGKSrNJpYx9Ijnw
 suYZbXxh2vEKneYJwb1pOLa4VOUS1eeVW0CRStjdwNTTZ62Y/pwQTnpB/b3UP1xZVCQ4
 xXWA==
X-Gm-Message-State: AOAM530r0GSU51/R/aDjLYfjrIjZ7ksJ2Tv+DqMkTHJ0mdbJIUzJ6m2s
 AAtvwBJ2VCzIPJjo0zevTgAbvVTNPABpsegitD6GJJk4IX0=
X-Google-Smtp-Source: ABdhPJz8BHbiMXuZ19M6d2c1byFJq3pGIBSZgja177CTzYzW4o3eTGAQ9UD/jEg43oQHg5GbgsRK9PjBdpUfET4eTGg=
X-Received: by 2002:a17:906:600f:: with SMTP id
 o15mr27260438ejj.529.1597176305043; 
 Tue, 11 Aug 2020 13:05:05 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1597129029.git.scw@google.com>
 <71ad91e4ee9f41f439086d8f9de60501ad304859.1597129029.git.scw@google.com>
 <d21e0d92-3d59-a83d-4ac3-7a1e68109b2e@vivier.eu>
In-Reply-To: <d21e0d92-3d59-a83d-4ac3-7a1e68109b2e@vivier.eu>
From: Shu-Chun Weng <scw@google.com>
Date: Tue, 11 Aug 2020 13:04:53 -0700
Message-ID: <CAF3nBxhoGaXKWUdutGBBNOmCi4PJ+K3Q3CiERDi_JM54qgs8=g@mail.gmail.com>
Subject: Re: [PATCH v2 2/8] linux-user: add missing UDP get/setsockopt option
To: Laurent Vivier <laurent@vivier.eu>
Cc: qemu-devel@nongnu.org
Content-Type: multipart/signed; protocol="application/pkcs7-signature";
 micalg=sha-256; boundary="00000000000057714d05ac9f963b"
Received-SPF: pass client-ip=2a00:1450:4864:20::641;
 envelope-from=scw@google.com; helo=mail-ej1-x641.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -185
X-Spam_score: -18.6
X-Spam_bar: ------------------
X-Spam_report: (-18.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 ENV_AND_HDR_SPF_MATCH=-0.5, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--00000000000057714d05ac9f963b
Content-Type: multipart/alternative; boundary="0000000000004ed38805ac9f96d3"

--0000000000004ed38805ac9f96d3
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

It does look like something that can be improved. The lines have been there
for 14 years though:
https://github.com/qemu/qemu/commit/53a5960aadd542dd27b8705ac30df154557d5ff=
c

The potential bug is triggered when the user passes in a 2-byte integer in
getsockopt(), which seems uncommon -- do we have guest architectures that
use 16-bit int type?

Shu-Chun

On Tue, Aug 11, 2020 at 7:21 AM Laurent Vivier <laurent@vivier.eu> wrote:

> Le 11/08/2020 =C3=A0 09:09, Shu-Chun Weng a =C3=A9crit :
> > SOL_UDP manipulate options at UDP level. All six options currently
> defined
> > in linux source include/uapi/linux/udp.h take integer values.
> >
> > Signed-off-by: Shu-Chun Weng <scw@google.com>
> > Reviewed-by: Laurent Vivier <laurent@vivier.eu>
> > ---
> > v1 -> v2:
> >   Split out SOL_UDP into own patch.
> >   Updated do_print_sockopt().
> >
> >  linux-user/strace.c  | 6 ++++++
> >  linux-user/syscall.c | 7 +++++--
> >  2 files changed, 11 insertions(+), 2 deletions(-)
> >
> > diff --git a/linux-user/strace.c b/linux-user/strace.c
> > index 4fff24b880..854b54a2ad 100644
> > --- a/linux-user/strace.c
> > +++ b/linux-user/strace.c
> > @@ -7,6 +7,7 @@
> >  #include <sys/mount.h>
> >  #include <arpa/inet.h>
> >  #include <netinet/tcp.h>
> > +#include <netinet/udp.h>
> >  #include <linux/if_packet.h>
> >  #include <linux/netlink.h>
> >  #include <sched.h>
> > @@ -2190,6 +2191,11 @@ static void do_print_sockopt(const char *name,
> abi_long arg1)
> >          print_raw_param(TARGET_ABI_FMT_ld, optname, 0);
> >          print_pointer(optval, 0);
> >          break;
> > +    case SOL_UDP:
> > +        qemu_log("SOL_UDP,");
> > +        print_raw_param(TARGET_ABI_FMT_ld, optname, 0);
> > +        print_pointer(optval, 0);
> > +        break;
> >      case SOL_IP:
> >          qemu_log("SOL_IP,");
> >          print_raw_param(TARGET_ABI_FMT_ld, optname, 0);
> > diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> > index 5645862798 <(564)%20586-2798>..177eec5201 100644
> > --- a/linux-user/syscall.c
> > +++ b/linux-user/syscall.c
> > @@ -53,6 +53,7 @@
> >  //#include <sys/user.h>
> >  #include <netinet/ip.h>
> >  #include <netinet/tcp.h>
> > +#include <netinet/udp.h>
> >  #include <linux/wireless.h>
> >  #include <linux/icmp.h>
> >  #include <linux/icmpv6.h>
> > @@ -1938,7 +1939,8 @@ static abi_long do_setsockopt(int sockfd, int
> level, int optname,
> >
> >      switch(level) {
> >      case SOL_TCP:
> > -        /* TCP options all take an 'int' value.  */
> > +    case SOL_UDP:
> > +        /* TCP and UDP options all take an 'int' value.  */
> >          if (optlen < sizeof(uint32_t))
> >              return -TARGET_EINVAL;
> >
> > @@ -2586,7 +2588,8 @@ get_timeout:
> >          }
> >          break;
> >      case SOL_TCP:
> > -        /* TCP options all take an 'int' value.  */
> > +    case SOL_UDP:
> > +        /* TCP and UDP options all take an 'int' value.  */
> >      int_case:
> >          if (get_user_u32(len, optlen))
> >              return -TARGET_EFAULT;
> >
>
> Reviewed-by: Laurent Vivier <laurent@vivier.eu>
>
> I'm wondering if the int_case of getsockopt() manages correctly the
> length: length can be between 0 and sizeof(int), but the int_case only
> uses a put_user_u32() or a put_user_u8(). Do we need the put_user_u16()?
>
> Thanks,
> Laurent
>

--0000000000004ed38805ac9f96d3
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">It does look like something that can be improved. The line=
s have been there for 14 years though:=C2=A0<a href=3D"https://github.com/q=
emu/qemu/commit/53a5960aadd542dd27b8705ac30df154557d5ffc" class=3D"cremed">=
https://github.com/qemu/qemu/commit/53a5960aadd542dd27b8705ac30df154557d5ff=
c</a><div><br></div><div>The potential bug is triggered when the user passe=
s in a 2-byte integer in getsockopt(), which seems uncommon -- do we have g=
uest architectures that use 16-bit int type?</div><div><br></div><div>Shu-C=
hun</div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gma=
il_attr">On Tue, Aug 11, 2020 at 7:21 AM Laurent Vivier &lt;<a href=3D"mail=
to:laurent@vivier.eu">laurent@vivier.eu</a>&gt; wrote:<br></div><blockquote=
 class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px so=
lid rgb(204,204,204);padding-left:1ex">Le 11/08/2020 =C3=A0 09:09, Shu-Chun=
 Weng a =C3=A9crit=C2=A0:<br>
&gt; SOL_UDP manipulate options at UDP level. All six options currently def=
ined<br>
&gt; in linux source include/uapi/linux/udp.h take integer values.<br>
&gt; <br>
&gt; Signed-off-by: Shu-Chun Weng &lt;<a href=3D"mailto:scw@google.com" tar=
get=3D"_blank">scw@google.com</a>&gt;<br>
&gt; Reviewed-by: Laurent Vivier &lt;<a href=3D"mailto:laurent@vivier.eu" t=
arget=3D"_blank">laurent@vivier.eu</a>&gt;<br>
&gt; ---<br>
&gt; v1 -&gt; v2:<br>
&gt;=C2=A0 =C2=A0Split out SOL_UDP into own patch.<br>
&gt;=C2=A0 =C2=A0Updated do_print_sockopt().<br>
&gt; <br>
&gt;=C2=A0 linux-user/strace.c=C2=A0 | 6 ++++++<br>
&gt;=C2=A0 linux-user/syscall.c | 7 +++++--<br>
&gt;=C2=A0 2 files changed, 11 insertions(+), 2 deletions(-)<br>
&gt; <br>
&gt; diff --git a/linux-user/strace.c b/linux-user/strace.c<br>
&gt; index 4fff24b880..854b54a2ad 100644<br>
&gt; --- a/linux-user/strace.c<br>
&gt; +++ b/linux-user/strace.c<br>
&gt; @@ -7,6 +7,7 @@<br>
&gt;=C2=A0 #include &lt;sys/mount.h&gt;<br>
&gt;=C2=A0 #include &lt;arpa/inet.h&gt;<br>
&gt;=C2=A0 #include &lt;netinet/tcp.h&gt;<br>
&gt; +#include &lt;netinet/udp.h&gt;<br>
&gt;=C2=A0 #include &lt;linux/if_packet.h&gt;<br>
&gt;=C2=A0 #include &lt;linux/netlink.h&gt;<br>
&gt;=C2=A0 #include &lt;sched.h&gt;<br>
&gt; @@ -2190,6 +2191,11 @@ static void do_print_sockopt(const char *name, =
abi_long arg1)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print_raw_param(TARGET_ABI_FMT_ld, o=
ptname, 0);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print_pointer(optval, 0);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 case SOL_UDP:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_log(&quot;SOL_UDP,&quot;);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 print_raw_param(TARGET_ABI_FMT_ld, optnam=
e, 0);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 print_pointer(optval, 0);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 case SOL_IP:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_log(&quot;SOL_IP,&quot;);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print_raw_param(TARGET_ABI_FMT_ld, o=
ptname, 0);<br>
&gt; diff --git a/linux-user/syscall.c b/linux-user/syscall.c<br>
&gt; index <a href=3D"tel:(564)%20586-2798" value=3D"+15645862798" target=
=3D"_blank">5645862798</a>..177eec5201 100644<br>
&gt; --- a/linux-user/syscall.c<br>
&gt; +++ b/linux-user/syscall.c<br>
&gt; @@ -53,6 +53,7 @@<br>
&gt;=C2=A0 //#include &lt;sys/user.h&gt;<br>
&gt;=C2=A0 #include &lt;netinet/ip.h&gt;<br>
&gt;=C2=A0 #include &lt;netinet/tcp.h&gt;<br>
&gt; +#include &lt;netinet/udp.h&gt;<br>
&gt;=C2=A0 #include &lt;linux/wireless.h&gt;<br>
&gt;=C2=A0 #include &lt;linux/icmp.h&gt;<br>
&gt;=C2=A0 #include &lt;linux/icmpv6.h&gt;<br>
&gt; @@ -1938,7 +1939,8 @@ static abi_long do_setsockopt(int sockfd, int le=
vel, int optname,<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 switch(level) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 case SOL_TCP:<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* TCP options all take an &#39;int&#39; =
value.=C2=A0 */<br>
&gt; +=C2=A0 =C2=A0 case SOL_UDP:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* TCP and UDP options all take an &#39;i=
nt&#39; value.=C2=A0 */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (optlen &lt; sizeof(uint32_t))<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -TARGET_EINVAL;=
<br>
&gt;=C2=A0 <br>
&gt; @@ -2586,7 +2588,8 @@ get_timeout:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 case SOL_TCP:<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* TCP options all take an &#39;int&#39; =
value.=C2=A0 */<br>
&gt; +=C2=A0 =C2=A0 case SOL_UDP:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* TCP and UDP options all take an &#39;i=
nt&#39; value.=C2=A0 */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 int_case:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (get_user_u32(len, optlen))<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -TARGET_EFAULT;=
<br>
&gt; <br>
<br>
Reviewed-by: Laurent Vivier &lt;<a href=3D"mailto:laurent@vivier.eu" target=
=3D"_blank">laurent@vivier.eu</a>&gt;<br>
<br>
I&#39;m wondering if the int_case of getsockopt() manages correctly the<br>
length: length can be between 0 and sizeof(int), but the int_case only<br>
uses a put_user_u32() or a put_user_u8(). Do we need the put_user_u16()?<br=
>
<br>
Thanks,<br>
Laurent<br>
</blockquote></div>

--0000000000004ed38805ac9f96d3--

--00000000000057714d05ac9f963b
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIPAAYJKoZIhvcNAQcCoIIO8TCCDu0CAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
ggxjMIIEkjCCA3qgAwIBAgINAewckktV4F6Q7sAtGDANBgkqhkiG9w0BAQsFADBMMSAwHgYDVQQL
ExdHbG9iYWxTaWduIFJvb3QgQ0EgLSBSMzETMBEGA1UEChMKR2xvYmFsU2lnbjETMBEGA1UEAxMK
R2xvYmFsU2lnbjAeFw0xODA2MjAwMDAwMDBaFw0yODA2MjAwMDAwMDBaMEsxCzAJBgNVBAYTAkJF
MRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMSEwHwYDVQQDExhHbG9iYWxTaWduIFNNSU1FIENB
IDIwMTgwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCUeobu8FdB5oJg6Fz6SFf8YsPI
dNcq4rBSiSDAwqMNYbeTpRrINMBdWuPqVWaBX7WHYMsKQwCOvAF1b7rkD+ROo+CCTJo76EAY25Pp
jt7TYP/PxoLesLQ+Ld088+BeyZg9pQaf0VK4tn23fOCWbFWoM8hdnF86Mqn6xB6nLsxJcz4CUGJG
qAhC3iedFiCfZfsIp2RNyiUhzPAqalkrtD0bZQvCgi5aSNJseNyCysS1yA58OuxEyn2e9itZJE+O
sUeD8VFgz+nAYI5r/dmFEXu5d9npLvTTrSJjrEmw2/ynKn6r6ONueZnCfo6uLmP1SSglhI/SN7dy
L1rKUCU7R1MjAgMBAAGjggFyMIIBbjAOBgNVHQ8BAf8EBAMCAYYwJwYDVR0lBCAwHgYIKwYBBQUH
AwIGCCsGAQUFBwMEBggrBgEFBQcDCTASBgNVHRMBAf8ECDAGAQH/AgEAMB0GA1UdDgQWBBRMtwWJ
1lPNI0Ci6A94GuRtXEzs0jAfBgNVHSMEGDAWgBSP8Et/qC5FJK5NUPpjmove4t0bvDA+BggrBgEF
BQcBAQQyMDAwLgYIKwYBBQUHMAGGImh0dHA6Ly9vY3NwMi5nbG9iYWxzaWduLmNvbS9yb290cjMw
NgYDVR0fBC8wLTAroCmgJ4YlaHR0cDovL2NybC5nbG9iYWxzaWduLmNvbS9yb290LXIzLmNybDBn
BgNVHSAEYDBeMAsGCSsGAQQBoDIBKDAMBgorBgEEAaAyASgKMEEGCSsGAQQBoDIBXzA0MDIGCCsG
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
aHR0cHM6Ly93d3cuZ2xvYmFsc2lnbi5jb20vcmVwb3NpdG9yeS8wUQYIKwYBBQUHAQEERTBDMEEG
CCsGAQUFBzAChjVodHRwOi8vc2VjdXJlLmdsb2JhbHNpZ24uY29tL2NhY2VydC9nc3NtaW1lY2Ey
MDE4LmNydDAfBgNVHSMEGDAWgBRMtwWJ1lPNI0Ci6A94GuRtXEzs0jA/BgNVHR8EODA2MDSgMqAw
hi5odHRwOi8vY3JsLmdsb2JhbHNpZ24uY29tL2NhL2dzc21pbWVjYTIwMTguY3JsMA0GCSqGSIb3
DQEBCwUAA4IBAQB0zgx4rAhCKzIVBMrEn4R/8FrisDQWZwJvA4VLbgtBPI1kP/Ys+cw3oYecxHED
MAHXOYclqmcaKudfjsLKZ/jrpdjZMAHDazo86g4BREWWiAxAtnMPhKrL4Ciqs0Yx/fj4VJlJRgES
1wscHQQNh2BgbqP15O5D2CtZVsLIuc9pSY3DZNYUrMQy55hszPnhgeghImVgNLtzUkF8oLKlnrWs
blvMc7fi7e42/rSnhbE6WUWGHvXcQ3+qIptP079GF+p1ZnEVmXIrQeoP1Rh0wS2ThPBorHqMY8OB
+c1AbPa2A/qY7QkFA6Oq7I8gUPNRO1NyuEElN4LJy+SCH0kWzLawMYICYTCCAl0CAQEwXzBLMQsw
CQYDVQQGEwJCRTEZMBcGA1UEChMQR2xvYmFsU2lnbiBudi1zYTEhMB8GA1UEAxMYR2xvYmFsU2ln
biBTTUlNRSBDQSAyMDE4AhAB2NRaeBKJjaSQ9CGctwQsMA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqG
SIb3DQEJBDEiBCArqqR+NiVkt30Gci7Ycpe0cLSO4PW2PwkTg7aOnXppYTAYBgkqhkiG9w0BCQMx
CwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yMDA4MTEyMDA1MDVaMGkGCSqGSIb3DQEJDzFc
MFowCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJ
KoZIhvcNAQEKMAsGCSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAHvge
bIw1SwMiQHwho+vHeLe4Y6jrw9/hQRaPwOj/KFrnW1tLOOaCKdGwlOIdzdDfSlki0lInLn47iMtI
naiFwM4sy2UwyG0b7nOLP8ue1TYDq6oi8yfyLwJAonqjFsszYwgy1bHhm6SDSwVsrLJkx64kzEaw
9rIP3EYRNM0qj+vHDAiJ7mbtVPx2TnbFLuRIHYotSsz2JsECT+L4xOAY6KtZ0CKNRx3h9THG5EYe
gTLvRhW48J4ZP3cJt++C5T+sujcI1dO44dCYgQ+qmMIBffCvLO88VVKREL5LJ8rBT3ZVrLo9p2X1
Y+Bw+xfku93Fr24qKrigqVR/ZtolWC0O/w==
--00000000000057714d05ac9f963b--

