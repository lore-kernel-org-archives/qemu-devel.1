Return-Path: <SRS0=ht5U=YL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2D45CA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 18:21:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7205820820
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 18:21:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MrIbPaDz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7205820820
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44884 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iLWsZ-0004SD-Fe
	for qemu-devel@archiver.kernel.org; Fri, 18 Oct 2019 14:21:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35004)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <scw@google.com>) id 1iLWpc-0000Bi-Iy
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 14:18:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <scw@google.com>) id 1iLWpb-00027o-0p
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 14:18:32 -0400
Received: from mail-il1-x142.google.com ([2607:f8b0:4864:20::142]:46697)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <scw@google.com>) id 1iLWpa-000278-Ns
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 14:18:30 -0400
Received: by mail-il1-x142.google.com with SMTP id c4so6343106ilq.13
 for <qemu-devel@nongnu.org>; Fri, 18 Oct 2019 11:18:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=FFV0qKILGS0j7VnpDDRVnKl6Se2W9ztNu9K1JZXXVME=;
 b=MrIbPaDzgRGu99YuTZhxl7Vsxn8p3g9pGQVz3bnGls0VtMXOfCYCS+N2b6gFl71gSz
 GX4wJCgVHIesOks3o4yHvgmQf3NBb2iTCODUJ9axyefAsSnSvgoALNatg8V6Py2QiOSV
 hLyB9AgPPpI0mlNpMo9SUOQRdzI+5pctBPxs9JZ4Xle6oQIfBj3t6AY3bgsxa+ZJR/dW
 TEZxP2PJMmcK2XpaS3XpvxmPBByPQwPvkdQ1kVybT0RYOMDgL/WP+dLie/X23VYV0kFh
 Q05mCdSGIvYkmTGRfovMscOnFcNRYpxzpBsug421NJmCXtjayo5M0OFXDfy3bB2VKwzq
 8+Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=FFV0qKILGS0j7VnpDDRVnKl6Se2W9ztNu9K1JZXXVME=;
 b=fS42RinA1p6gppl1e7qmsHbNOnq7o4DsAAgPtJYj+VYcwtM5gHnSEJP8dqwkCKBVI7
 zBZTC7QDUoFLQvJNdwDA6F+8mjKDgf+w5vUAHyarCX+/3Ixnlybof5BrCRFGrVW1Z5x5
 jMFzcYdGOLWwYYr7wNGcQGSMYe4dNfvczMoFbKp4NACXfVCkolRwCyWP3vTdi5yEU6ab
 4oHQTR/Ho+8+No/PxXPIbenblb9jUANyVjFw80zDElaHu+S+T7FMphpraZ5zWFjsHftV
 iraNlWYwl1+vHPcSpw1USnxJncb8VSBj0Tw1lsmHOOQPSCrSi7IQGxPMfoJw9Vom5PmG
 79fg==
X-Gm-Message-State: APjAAAUCv+qzwDjegWYr7miGRxmFttJqcG3VC4bC+QtDnc7PuusjhaAP
 w3/q8E3OmeotJof8Z7oU9tYI4/7h7fgyBR1g++5v7w==
X-Google-Smtp-Source: APXvYqzCHleDdVZCFzzAslmmUdFCEmiSssHVxY6NAVs0EIp6142lehGDHbawQsYfA7bWSRDbQxAKhFZCi6+us9mDF30=
X-Received: by 2002:a92:5b98:: with SMTP id c24mr11277313ilg.158.1571422709062; 
 Fri, 18 Oct 2019 11:18:29 -0700 (PDT)
MIME-Version: 1.0
References: <20191018001920.178283-1-scw@google.com>
 <4b34aa24-8669-7713-84f3-07e9e8400734@vivier.eu>
In-Reply-To: <4b34aa24-8669-7713-84f3-07e9e8400734@vivier.eu>
From: Shu-Chun Weng <scw@google.com>
Date: Fri, 18 Oct 2019 11:18:16 -0700
Message-ID: <CAF3nBxgzHkpkG9rBwHygw_RTT91-ai5At+my31dNpay1nbKbww@mail.gmail.com>
Subject: Re: [PATCH] Fix unsigned integer underflow in fd-trans.c
To: Laurent Vivier <laurent@vivier.eu>
Cc: Riku Voipio <riku.voipio@iki.fi>, qemu-devel@nongnu.org
Content-Type: multipart/signed; protocol="application/pkcs7-signature";
 micalg=sha-256; boundary="00000000000068f8520595335c5c"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::142
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

--00000000000068f8520595335c5c
Content-Type: multipart/alternative; boundary="0000000000005e202d0595335c39"

--0000000000005e202d0595335c39
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

That does prevent the integer underflow, but it also changes the behavior
and I don't think the new behavior is desirable.

If the extra payload has a smaller alignment than the header, it makes
sense for the user program to generate a nlmsg_len that is not a multiple
of the alignment. When it's the last entry, the new condition will it
because NLMSG_ALIGN pushes the aligned length over `len`, yet the single
entry processing function won't actually read beyond the buffer as long as
it's bounded by nlmsg_len.

Shu-Chun

On Fri, Oct 18, 2019 at 12:26 AM Laurent Vivier <laurent@vivier.eu> wrote:

> Le 18/10/2019 =C3=A0 02:19, Shu-Chun Weng a =C3=A9crit :
> > In any of these `*_for_each_*` functions, the last entry in the buffer
> (so the
> > "remaining length in the buffer" `len` is equal to the length of the
> > entry `nlmsg_len`/`nla_len`/etc) has size that is not a multiple of the
> > alignment, the aligned lengths `*_ALIGN(*_len)` will be greater than
> `len`.
> > Since `len` is unsigned (`size_t`), it underflows and the loop will rea=
d
> > pass the buffer.
> >
> > This may manifest as random EINVAL or EOPNOTSUPP error on IO or network
> > system calls.
> >
> > Signed-off-by: Shu-Chun Weng <scw@google.com>
> > ---
> >  linux-user/fd-trans.c | 51 +++++++++++++++++++++++++++++++++----------
> >  1 file changed, 40 insertions(+), 11 deletions(-)
> >
> > diff --git a/linux-user/fd-trans.c b/linux-user/fd-trans.c
> > index 60077ce531..9b92386abf 100644
> > --- a/linux-user/fd-trans.c
> > +++ b/linux-user/fd-trans.c
> > @@ -279,6 +279,7 @@ static abi_long host_to_target_for_each_nlmsg(struc=
t
> nlmsghdr *nlh,
> >                                                         (struct nlmsghd=
r
> *))
> >  {
> >      uint32_t nlmsg_len;
> > +    uint32_t aligned_nlmsg_len;
> >      abi_long ret;
> >
> >      while (len > sizeof(struct nlmsghdr)) {
> > @@ -312,8 +313,13 @@ static abi_long
> host_to_target_for_each_nlmsg(struct nlmsghdr *nlh,
> >              break;
> >          }
> >          tswap_nlmsghdr(nlh);
> > -        len -=3D NLMSG_ALIGN(nlmsg_len);
> > -        nlh =3D (struct nlmsghdr *)(((char*)nlh) +
> NLMSG_ALIGN(nlmsg_len));
> > +
> > +        aligned_nlmsg_len =3D NLMSG_ALIGN(nlmsg_len);
> > +        if (aligned_nlmsg_len >=3D len) {
> > +            break;
> > +        }
> > +        len -=3D aligned_nlmsg_len;
> > +        nlh =3D (struct nlmsghdr *)(((char*)nlh) + aligned_nlmsg_len);
> >      }
> >      return 0;
> >  }
>
> Nice catch.
>
> But the first "if" in the loop is already here for that, we only need to
> fix it with something like that in all the for_each functions:
>
> @@ -285,7 +285,7 @@ static abi_long host_to_target_for_each_nlmsg(struct
> nlmsghdr *nlh,
>
>          nlmsg_len =3D nlh->nlmsg_len;
>          if (nlmsg_len < sizeof(struct nlmsghdr) ||
> -            nlmsg_len > len) {
> +            NLMSG_ALIGN(nlmsg_len) > len) {
>              break;
>          }
>
> Thanks,
> Laurent
>
>

--0000000000005e202d0595335c39
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">That does prevent the integer underflow, but it also chang=
es the behavior and I don&#39;t think the new behavior is desirable.<div><b=
r></div><div>If the extra payload has a smaller alignment than the header, =
it makes sense for the user program to generate a nlmsg_len that is not a m=
ultiple of the alignment. When it&#39;s the last entry, the new condition w=
ill it because NLMSG_ALIGN pushes the aligned length over `len`, yet the si=
ngle entry processing function won&#39;t actually read beyond the buffer as=
 long as it&#39;s bounded by nlmsg_len.</div><div><br></div><div>Shu-Chun</=
div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_at=
tr">On Fri, Oct 18, 2019 at 12:26 AM Laurent Vivier &lt;<a href=3D"mailto:l=
aurent@vivier.eu">laurent@vivier.eu</a>&gt; wrote:<br></div><blockquote cla=
ss=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid =
rgb(204,204,204);padding-left:1ex">Le 18/10/2019 =C3=A0 02:19, Shu-Chun Wen=
g a =C3=A9crit=C2=A0:<br>
&gt; In any of these `*_for_each_*` functions, the last entry in the buffer=
 (so the<br>
&gt; &quot;remaining length in the buffer&quot; `len` is equal to the lengt=
h of the<br>
&gt; entry `nlmsg_len`/`nla_len`/etc) has size that is not a multiple of th=
e<br>
&gt; alignment, the aligned lengths `*_ALIGN(*_len)` will be greater than `=
len`.<br>
&gt; Since `len` is unsigned (`size_t`), it underflows and the loop will re=
ad<br>
&gt; pass the buffer.<br>
&gt; <br>
&gt; This may manifest as random EINVAL or EOPNOTSUPP error on IO or networ=
k<br>
&gt; system calls.<br>
&gt; <br>
&gt; Signed-off-by: Shu-Chun Weng &lt;<a href=3D"mailto:scw@google.com" tar=
get=3D"_blank">scw@google.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 linux-user/fd-trans.c | 51 +++++++++++++++++++++++++++++++++----=
------<br>
&gt;=C2=A0 1 file changed, 40 insertions(+), 11 deletions(-)<br>
&gt; <br>
&gt; diff --git a/linux-user/fd-trans.c b/linux-user/fd-trans.c<br>
&gt; index 60077ce531..9b92386abf 100644<br>
&gt; --- a/linux-user/fd-trans.c<br>
&gt; +++ b/linux-user/fd-trans.c<br>
&gt; @@ -279,6 +279,7 @@ static abi_long host_to_target_for_each_nlmsg(stru=
ct nlmsghdr *nlh,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(struct nlmsghdr=
 *))<br>
&gt;=C2=A0 {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 uint32_t nlmsg_len;<br>
&gt; +=C2=A0 =C2=A0 uint32_t aligned_nlmsg_len;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 abi_long ret;<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 while (len &gt; sizeof(struct nlmsghdr)) {<br>
&gt; @@ -312,8 +313,13 @@ static abi_long host_to_target_for_each_nlmsg(str=
uct nlmsghdr *nlh,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tswap_nlmsghdr(nlh);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 len -=3D NLMSG_ALIGN(nlmsg_len);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 nlh =3D (struct nlmsghdr *)(((char*)nlh) =
+ NLMSG_ALIGN(nlmsg_len));<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 aligned_nlmsg_len =3D NLMSG_ALIGN(nlmsg_l=
en);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (aligned_nlmsg_len &gt;=3D len) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 len -=3D aligned_nlmsg_len;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 nlh =3D (struct nlmsghdr *)(((char*)nlh) =
+ aligned_nlmsg_len);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0 return 0;<br>
&gt;=C2=A0 }<br>
<br>
Nice catch.<br>
<br>
But the first &quot;if&quot; in the loop is already here for that, we only =
need to<br>
fix it with something like that in all the for_each functions:<br>
<br>
@@ -285,7 +285,7 @@ static abi_long host_to_target_for_each_nlmsg(struct<br=
>
nlmsghdr *nlh,<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0nlmsg_len =3D nlh-&gt;nlmsg_len;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (nlmsg_len &lt; sizeof(struct nlmsghdr=
) ||<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 nlmsg_len &gt; len) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 NLMSG_ALIGN(nlmsg_len) &gt; len)=
 {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
<br>
Thanks,<br>
Laurent<br>
<br>
</blockquote></div>

--0000000000005e202d0595335c39--

--00000000000068f8520595335c5c
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIS4QYJKoZIhvcNAQcCoIIS0jCCEs4CAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
ghBHMIIEXDCCA0SgAwIBAgIOSBtqDm4P/739RPqw/wcwDQYJKoZIhvcNAQELBQAwZDELMAkGA1UE
BhMCQkUxGTAXBgNVBAoTEEdsb2JhbFNpZ24gbnYtc2ExOjA4BgNVBAMTMUdsb2JhbFNpZ24gUGVy
c29uYWxTaWduIFBhcnRuZXJzIENBIC0gU0hBMjU2IC0gRzIwHhcNMTYwNjE1MDAwMDAwWhcNMjEw
NjE1MDAwMDAwWjBMMQswCQYDVQQGEwJCRTEZMBcGA1UEChMQR2xvYmFsU2lnbiBudi1zYTEiMCAG
A1UEAxMZR2xvYmFsU2lnbiBIViBTL01JTUUgQ0EgMTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCC
AQoCggEBALR23lKtjlZW/17kthzYcMHHKFgywfc4vLIjfq42NmMWbXkNUabIgS8KX4PnIFsTlD6F
GO2fqnsTygvYPFBSMX4OCFtJXoikP2CQlEvO7WooyE94tqmqD+w0YtyP2IB5j4KvOIeNv1Gbnnes
BIUWLFxs1ERvYDhmk+OrvW7Vd8ZfpRJj71Rb+QQsUpkyTySaqALXnyztTDp1L5d1bABJN/bJbEU3
Hf5FLrANmognIu+Npty6GrA6p3yKELzTsilOFmYNWg7L838NS2JbFOndl+ce89gM36CW7vyhszi6
6LqqzJL8MsmkP53GGhf11YMP9EkmawYouMDP/PwQYhIiUO0CAwEAAaOCASIwggEeMA4GA1UdDwEB
/wQEAwIBBjAdBgNVHSUEFjAUBggrBgEFBQcDAgYIKwYBBQUHAwQwEgYDVR0TAQH/BAgwBgEB/wIB
ADAdBgNVHQ4EFgQUyzgSsMeZwHiSjLMhleb0JmLA4D8wHwYDVR0jBBgwFoAUJiSSix/TRK+xsBtt
r+500ox4AAMwSwYDVR0fBEQwQjBAoD6gPIY6aHR0cDovL2NybC5nbG9iYWxzaWduLmNvbS9ncy9n
c3BlcnNvbmFsc2lnbnB0bnJzc2hhMmcyLmNybDBMBgNVHSAERTBDMEEGCSsGAQQBoDIBKDA0MDIG
CCsGAQUFBwIBFiZodHRwczovL3d3dy5nbG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5LzANBgkqhkiG
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
--00000000000068f8520595335c5c--

