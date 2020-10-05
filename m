Return-Path: <SRS0=FSHi=DM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC14AC4363A
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 05:24:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 40B1C2078A
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 05:24:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=anisinha-ca.20150623.gappssmtp.com header.i=@anisinha-ca.20150623.gappssmtp.com header.b="TaDJa8rq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40B1C2078A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=anisinha.ca
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36458 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPIz0-000459-0f
	for qemu-devel@archiver.kernel.org; Mon, 05 Oct 2020 01:24:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58452)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1kPIxd-0003eO-8G
 for qemu-devel@nongnu.org; Mon, 05 Oct 2020 01:22:57 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:39973)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1kPIxa-0002O9-Lb
 for qemu-devel@nongnu.org; Mon, 05 Oct 2020 01:22:56 -0400
Received: by mail-wr1-x441.google.com with SMTP id j2so7996063wrx.7
 for <qemu-devel@nongnu.org>; Sun, 04 Oct 2020 22:22:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=anisinha-ca.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=4O64FcBWSMSsZDk52fKX/lWx9PVUMXre3QzhuCzBSdc=;
 b=TaDJa8rqlWlf3m9eU5FpXvZ4HHZRsL7glgNoLpcXFDj+yJTr4zIRmXqpZcwznISjJg
 Eyt4OWWTxWZCBVNQ/9mtQlM3nakZLjDkhLzOUTYO71/fs5aMpzzB26707n+jd5miAv2W
 O5nPYmyjA8kHtlcPtKZZm2jwMXEcBygpAwnpn8zc8NHhKTpZqbBlCKWYLt8IfflQUJf2
 UHkAwYXJHaZmS5jtwqP9UIVTStcZYDEWQ7wc9Aa/814Q32G1s3WwhhXK1ACNxujv+nIL
 gc1U2huA0yQSFF2i78Lh70wdnewgA02fGABIMa3GNun0W2YZUuKKMm6z0BZfQEr2NArl
 hofA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=4O64FcBWSMSsZDk52fKX/lWx9PVUMXre3QzhuCzBSdc=;
 b=M3NAMenQrpMz3TEV/1vBTfkAlLs7TUquzB1Gn9iM86Vht39TbdOOjgGOkCRrNLqwMO
 aaUXVWHxaFAr55Th6/4o6dDV+k5s2GiShZpvptX6rNN3XOpCsYNOrrVlGNK8GrnC6mkB
 lDCsWSoljW3jeUP2XPrUElUNvVZ0C1O9G4zR3WLeYUoMBxvDErfBPfWWz5SutoQnKt+F
 LqAe1g0kU+Bd3ABjLKWbIUsAP7iwp+8wI9tRJGDLgm3jDllZsirhQEpvtGjSYJYzVsvJ
 J440gUJ7NAaVpd/AWMlAhWM60cRHO5zAqjs5WBk+JfnT13FfUeVx2w4WcXL53x/DbvHG
 +2Pw==
X-Gm-Message-State: AOAM533aTCxYhPn0VhipRkaHZdKJQqZ8l4VvtUBNMUrQlx04dV19OK8I
 7g/Splm+TBQsBOUZTSgLRGDcfJDaQCvwh0mzB6OC6A==
X-Google-Smtp-Source: ABdhPJyOWW5bcALyKhH5VrHmMvuZxKSnGZjMHOdQQLOPbCqMSGVd6wXI8aFWMU3GBlOVCVm4Tj4ndAc59Yp/37blxnQ=
X-Received: by 2002:adf:c5d0:: with SMTP id v16mr10283825wrg.76.1601875372175; 
 Sun, 04 Oct 2020 22:22:52 -0700 (PDT)
MIME-Version: 1.0
References: <20201004180443.2035359-1-f4bug@amsat.org>
 <20201004180443.2035359-10-f4bug@amsat.org>
In-Reply-To: <20201004180443.2035359-10-f4bug@amsat.org>
From: Ani Sinha <ani@anisinha.ca>
Date: Mon, 5 Oct 2020 10:52:40 +0530
Message-ID: <CAARzgwwrUAO8mW=nY3bbnwzyjHX8isf1XDDNR8XnXTO5=J4ovA@mail.gmail.com>
Subject: Re: [RFC PATCH 09/21] contrib/gitdm: Add Nutanix to the domain map
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: multipart/alternative; boundary="00000000000088984e05b0e5acc6"
Received-SPF: none client-ip=2a00:1450:4864:20::441;
 envelope-from=ani@anisinha.ca; helo=mail-wr1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Cc: Mike Cui <cui@nutanix.com>, Peter Turschmid <peter.turschm@nutanix.com>,
 Ani Sinha <ani.sinha@nutanix.com>, Swapnil Ingle <swapnil.ingle@nutanix.com>,
 Prerna Saxena <prerna.saxena@nutanix.com>,
 David Vrabel <david.vrabel@nutanix.com>,
 Malcolm Crossley <malcolm@nutanix.com>, qemu-devel@nongnu.org,
 Raphael Norwitz <raphael.norwitz@nutanix.com>,
 Felipe Franciosi <felipe@nutanix.com>,
 Jonathan Davies <jonathan.davies@nutanix.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--00000000000088984e05b0e5acc6
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 4, 2020 at 23:34 Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> =
wrote:

> There is a number of contributors from this domain,
> add its own entry to the gitdm domain map.
>
> Cc: Ani Sinha <ani.sinha@nutanix.com>
> Cc: David Vrabel <david.vrabel@nutanix.com>
> Cc: Felipe Franciosi <felipe@nutanix.com>
> Cc: Jonathan Davies <jonathan.davies@nutanix.com>
> Cc: Malcolm Crossley <malcolm@nutanix.com>
> Cc: Mike Cui <cui@nutanix.com>
> Cc: Peter Turschmid <peter.turschm@nutanix.com>
> Cc: Prerna Saxena <prerna.saxena@nutanix.com>
> Cc: Raphael Norwitz <raphael.norwitz@nutanix.com>
> Cc: Swapnil Ingle <swapnil.ingle@nutanix.com>
> Cc: Ani Sinha <ani@anisinha.ca>


I=E2=80=99ve left Nutanix and not part of the company anymore. Malcolm, Dav=
id, Mike
also has left Nutanix.



> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
> One Reviewed-by/Ack-by from someone from this domain
> should be sufficient to get this patch merged.
>
> Ani, can you confirm the ani@anisinha.ca email?
> Should it go into 'individual contributors' instead?


Yes I=E2=80=99m an individual contributor now.


> ---
>  contrib/gitdm/domain-map        | 1 +
>  contrib/gitdm/group-map-nutanix | 2 ++
>  gitdm.config                    | 1 +
>  3 files changed, 4 insertions(+)
>  create mode 100644 contrib/gitdm/group-map-nutanix
>
> diff --git a/contrib/gitdm/domain-map b/contrib/gitdm/domain-map
> index 4850eab4c4..39251fd97c 100644
> --- a/contrib/gitdm/domain-map
> +++ b/contrib/gitdm/domain-map
> @@ -24,6 +24,7 @@ linaro.org      Linaro
>  codesourcery.com Mentor Graphics
>  microsoft.com   Microsoft
>  nokia.com       Nokia
> +nutanix.com     Nutanix
>  oracle.com      Oracle
>  proxmox.com     Proxmox
>  redhat.com      Red Hat
> diff --git a/contrib/gitdm/group-map-nutanix
> b/contrib/gitdm/group-map-nutanix
> new file mode 100644
> index 0000000000..a3f11425b3
> --- /dev/null
> +++ b/contrib/gitdm/group-map-nutanix
> @@ -0,0 +1,2 @@
> +raphael.s.norwitz@gmail.com
> +ani@anisinha.ca


Same here. Not part of Nutanix.

<ani@anisinha.ca>
> diff --git a/gitdm.config b/gitdm.config
> index c01c219078..4f821ab8ba 100644
> --- a/gitdm.config
> +++ b/gitdm.config
> @@ -37,6 +37,7 @@ GroupMap contrib/gitdm/group-map-cadence Cadence Design
> Systems
>  GroupMap contrib/gitdm/group-map-codeweavers CodeWeavers
>  GroupMap contrib/gitdm/group-map-ibm IBM
>  GroupMap contrib/gitdm/group-map-janustech Janus Technologies
> +GroupMap contrib/gitdm/group-map-nutanix Nutanix
>
>  # Also group together our prolific individual contributors
>  # and those working under academic auspices
> --
> 2.26.2
>
>

--00000000000088984e05b0e5acc6
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div><br></div><div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=
=3D"gmail_attr">On Sun, Oct 4, 2020 at 23:34 Philippe Mathieu-Daud=C3=A9 &l=
t;<a href=3D"mailto:f4bug@amsat.org">f4bug@amsat.org</a>&gt; wrote:<br></di=
v><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;borde=
r-left-width:1px;border-left-style:solid;padding-left:1ex;border-left-color=
:rgb(204,204,204)">There is a number of contributors from this domain,<br>
add its own entry to the gitdm domain map.<br>
<br>
Cc: Ani Sinha &lt;<a href=3D"mailto:ani.sinha@nutanix.com" target=3D"_blank=
">ani.sinha@nutanix.com</a>&gt;<br>
Cc: David Vrabel &lt;<a href=3D"mailto:david.vrabel@nutanix.com" target=3D"=
_blank">david.vrabel@nutanix.com</a>&gt;<br>
Cc: Felipe Franciosi &lt;<a href=3D"mailto:felipe@nutanix.com" target=3D"_b=
lank">felipe@nutanix.com</a>&gt;<br>
Cc: Jonathan Davies &lt;<a href=3D"mailto:jonathan.davies@nutanix.com" targ=
et=3D"_blank">jonathan.davies@nutanix.com</a>&gt;<br>
Cc: Malcolm Crossley &lt;<a href=3D"mailto:malcolm@nutanix.com" target=3D"_=
blank">malcolm@nutanix.com</a>&gt;<br>
Cc: Mike Cui &lt;<a href=3D"mailto:cui@nutanix.com" target=3D"_blank">cui@n=
utanix.com</a>&gt;<br>
Cc: Peter Turschmid &lt;<a href=3D"mailto:peter.turschm@nutanix.com" target=
=3D"_blank">peter.turschm@nutanix.com</a>&gt;<br>
Cc: Prerna Saxena &lt;<a href=3D"mailto:prerna.saxena@nutanix.com" target=
=3D"_blank">prerna.saxena@nutanix.com</a>&gt;<br>
Cc: Raphael Norwitz &lt;<a href=3D"mailto:raphael.norwitz@nutanix.com" targ=
et=3D"_blank">raphael.norwitz@nutanix.com</a>&gt;<br>
Cc: Swapnil Ingle &lt;<a href=3D"mailto:swapnil.ingle@nutanix.com" target=
=3D"_blank">swapnil.ingle@nutanix.com</a>&gt;<br>
Cc: Ani Sinha &lt;<a href=3D"mailto:ani@anisinha.ca" target=3D"_blank">ani@=
anisinha.ca</a>&gt;</blockquote><div dir=3D"auto"><br></div><div dir=3D"aut=
o">I=E2=80=99ve left Nutanix and not part of the company anymore. Malcolm, =
David, Mike also has left Nutanix.</div><div dir=3D"auto"><br></div><div di=
r=3D"auto"><br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px =
0px 0px 0.8ex;border-left-width:1px;border-left-style:solid;padding-left:1e=
x;border-left-color:rgb(204,204,204)" dir=3D"auto"><br>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:f4bug@amsa=
t.org" target=3D"_blank">f4bug@amsat.org</a>&gt;<br>
---<br>
One Reviewed-by/Ack-by from someone from this domain<br>
should be sufficient to get this patch merged.<br>
<br>
Ani, can you confirm the <a href=3D"mailto:ani@anisinha.ca" target=3D"_blan=
k">ani@anisinha.ca</a> email?<br>
Should it go into &#39;individual contributors&#39; instead?</blockquote><d=
iv dir=3D"auto"><br></div><div dir=3D"auto">Yes I=E2=80=99m an individual c=
ontributor now.=C2=A0</div><div dir=3D"auto"><br></div><blockquote class=3D=
"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;borde=
r-left-style:solid;padding-left:1ex;border-left-color:rgb(204,204,204)" dir=
=3D"auto"><br>
---<br>
=C2=A0contrib/gitdm/domain-map=C2=A0 =C2=A0 =C2=A0 =C2=A0 | 1 +<br>
=C2=A0contrib/gitdm/group-map-nutanix | 2 ++<br>
=C2=A0gitdm.config=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 | 1 +<br>
=C2=A03 files changed, 4 insertions(+)<br>
=C2=A0create mode 100644 contrib/gitdm/group-map-nutanix<br>
<br>
diff --git a/contrib/gitdm/domain-map b/contrib/gitdm/domain-map<br>
index 4850eab4c4..39251fd97c 100644<br>
--- a/contrib/gitdm/domain-map<br>
+++ b/contrib/gitdm/domain-map<br>
@@ -24,6 +24,7 @@ <a href=3D"http://linaro.org" rel=3D"noreferrer" target=
=3D"_blank">linaro.org</a>=C2=A0 =C2=A0 =C2=A0 Linaro<br>
=C2=A0<a href=3D"http://codesourcery.com" rel=3D"noreferrer" target=3D"_bla=
nk">codesourcery.com</a> Mentor Graphics<br>
=C2=A0<a href=3D"http://microsoft.com" rel=3D"noreferrer" target=3D"_blank"=
>microsoft.com</a>=C2=A0 =C2=A0Microsoft<br>
=C2=A0<a href=3D"http://nokia.com" rel=3D"noreferrer" target=3D"_blank">nok=
ia.com</a>=C2=A0 =C2=A0 =C2=A0 =C2=A0Nokia<br>
+<a href=3D"http://nutanix.com" rel=3D"noreferrer" target=3D"_blank">nutani=
x.com</a>=C2=A0 =C2=A0 =C2=A0Nutanix<br>
=C2=A0<a href=3D"http://oracle.com" rel=3D"noreferrer" target=3D"_blank">or=
acle.com</a>=C2=A0 =C2=A0 =C2=A0 Oracle<br>
=C2=A0<a href=3D"http://proxmox.com" rel=3D"noreferrer" target=3D"_blank">p=
roxmox.com</a>=C2=A0 =C2=A0 =C2=A0Proxmox<br>
=C2=A0<a href=3D"http://redhat.com" rel=3D"noreferrer" target=3D"_blank">re=
dhat.com</a>=C2=A0 =C2=A0 =C2=A0 Red Hat<br>
diff --git a/contrib/gitdm/group-map-nutanix b/contrib/gitdm/group-map-nuta=
nix<br>
new file mode 100644<br>
index 0000000000..a3f11425b3<br>
--- /dev/null<br>
+++ b/contrib/gitdm/group-map-nutanix<br>
@@ -0,0 +1,2 @@<br>
+<a href=3D"mailto:raphael.s.norwitz@gmail.com" target=3D"_blank">raphael.s=
.norwitz@gmail.com</a><br>
+<a href=3D"mailto:ani@anisinha.ca" target=3D"_blank">ani@anisinha.ca</a></=
blockquote><div dir=3D"auto"><br></div><div dir=3D"auto">Same here. Not par=
t of Nutanix.=C2=A0</div><div dir=3D"auto"><br></div><blockquote class=3D"g=
mail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;border-=
left-style:solid;padding-left:1ex;border-left-color:rgb(204,204,204)" dir=
=3D"auto"><a href=3D"mailto:ani@anisinha.ca" target=3D"_blank"></a><br>
diff --git a/gitdm.config b/gitdm.config<br>
index c01c219078..4f821ab8ba 100644<br>
--- a/gitdm.config<br>
+++ b/gitdm.config<br>
@@ -37,6 +37,7 @@ GroupMap contrib/gitdm/group-map-cadence Cadence Design S=
ystems<br>
=C2=A0GroupMap contrib/gitdm/group-map-codeweavers CodeWeavers<br>
=C2=A0GroupMap contrib/gitdm/group-map-ibm IBM<br>
=C2=A0GroupMap contrib/gitdm/group-map-janustech Janus Technologies<br>
+GroupMap contrib/gitdm/group-map-nutanix Nutanix<br>
<br>
=C2=A0# Also group together our prolific individual contributors<br>
=C2=A0# and those working under academic auspices<br>
-- <br>
2.26.2<br>
<br>
</blockquote></div></div>

--00000000000088984e05b0e5acc6--

