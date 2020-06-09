Return-Path: <SRS0=hUBF=7W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66F44C433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 16:42:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 283EE20737
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 16:42:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rLD8Dozh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 283EE20737
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45040 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jihKt-0007KQ-B4
	for qemu-devel@archiver.kernel.org; Tue, 09 Jun 2020 12:42:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47716)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hskinnemoen@google.com>)
 id 1jih8v-0000EP-CI
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 12:30:29 -0400
Received: from mail-ua1-x943.google.com ([2607:f8b0:4864:20::943]:37413)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hskinnemoen@google.com>)
 id 1jih8u-0001Mc-9M
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 12:30:28 -0400
Received: by mail-ua1-x943.google.com with SMTP id v25so7396938uau.4
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2020 09:30:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=eEJNUFMdF6jpcDaL363IMPBony6nAHc9SzbCxKUDoKw=;
 b=rLD8DozhN0P0qPeq4LQV7eikoPaBt2kNOv4nut5ga4j9hcqU8oCVFS9NaKldSnz4RD
 4rEqEhjK9Go4rpyTDzyavnn8yGqf7GTr6gdgeIVCyh0P3w+pqMEVqgNu/HkAiOmA6ABo
 7G8uxNFnh4t/5WVA8es9QeQxzAF03KjHeD+l5wAAzHkUH3z2k3p5JhacKNuYmlmCkZIL
 kJB2zHQTzK9OG+crInJl/cTy7TSI6JBF6J2uXdJuy+XawC3lAUoedOpRA4vDNp7CgExD
 V59+0BfJ9oZiIWStZGPEDXfaL46c/CEiDD8GNsGK54QZnz6nUOvLL8WZz7mCwCf9eFQh
 OoPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=eEJNUFMdF6jpcDaL363IMPBony6nAHc9SzbCxKUDoKw=;
 b=dNPccRfTJrfwfP1skMyQU4109jYYSudTHRvDLVvjU+y/m2jNaJOv4UK1o+FgzfJuip
 h+sORMlos7Ib0hvBk+IWBlpkK5N4uVTblxQ8Y/hwZH/1ANOoodQDFwO1vUsrwrI0hHH7
 lPsdLq6Xd/DOV5TQYO+iKiw/0g907gm3NuaxbbAtV9tcXiLGZU9z4svhtI+MntpPntgw
 uTkJY/zc5oDTzJV8Xms1OBw8Yaht818adWuekIzppgddhp0jGcZSKVKzHzAV/l6nZ/X7
 mZQKVdwW+1I9AZkshqeTJZAI4HMx3ouF37P3NncrbPQcqvkrH0w0ktelZvWUKkobWx1j
 c10w==
X-Gm-Message-State: AOAM533CaUhRxdWV0Cl1oj3sM2F2pJ63t7Me+nBCyvEJ+6hsu98rohnM
 HjgkEE5ilLPMQH73SVhT+UJ8T5sQmaT6LXGouv/wFg==
X-Google-Smtp-Source: ABdhPJxIRbW0hHqenZv0Ygm65EIKOTQt3K0m6T2+M8VnPtiKXZwVVtE4pzdwkBcMGuk0eTKad0RwM2IA+XI31O3b6Ro=
X-Received: by 2002:ab0:70c9:: with SMTP id r9mr4018578ual.15.1591720226540;
 Tue, 09 Jun 2020 09:30:26 -0700 (PDT)
MIME-Version: 1.0
References: <20200521192133.127559-1-hskinnemoen@google.com>
 <CAFQmdRYYhoWu7q350n0vNOE+pesp-UG975v1f1Yjwf9Ao0mjcg@mail.gmail.com>
 <60521645-6e85-cc59-7048-94db9634ad0a@kaod.org>
 <CAFEAcA9ph6R1wmPps9BZ1aBvaiJ67AEVWN_URuYTKVCfCg1f5A@mail.gmail.com>
In-Reply-To: <CAFEAcA9ph6R1wmPps9BZ1aBvaiJ67AEVWN_URuYTKVCfCg1f5A@mail.gmail.com>
From: Havard Skinnemoen <hskinnemoen@google.com>
Date: Tue, 9 Jun 2020 09:30:15 -0700
Message-ID: <CAFQmdRYu6qPYv_eS_VCn9qercrEjPYBHmqKr4yoBhxQcSxZKvA@mail.gmail.com>
Subject: Re: [PATCH 0/6] Add Nuvoton NPCM730/NPCM750 SoCs and two BMC machines
To: Peter Maydell <peter.maydell@linaro.org>
Cc: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, 
 IS20 Avi Fishman <Avi.Fishman@nuvoton.com>, CS20 KFTing <kfting@nuvoton.com>
Content-Type: multipart/alternative; boundary="000000000000afdba605a7a93e73"
Received-SPF: pass client-ip=2607:f8b0:4864:20::943;
 envelope-from=hskinnemoen@google.com; helo=mail-ua1-x943.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -158
X-Spam_score: -15.9
X-Spam_bar: ---------------
X-Spam_report: (-15.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 ENV_AND_HDR_SPF_MATCH=-0.5, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001, URIBL_SBL=1.623, URIBL_SBL_A=0.1,
 USER_IN_DEF_DKIM_WL=-7.5, USER_IN_DEF_SPF_WL=-7.5 autolearn=_AUTOLEARN
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

--000000000000afdba605a7a93e73
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 9, 2020 at 2:38 AM Peter Maydell <peter.maydell@linaro.org>
wrote:

> On Tue, 9 Jun 2020 at 08:31, C=C3=A9dric Le Goater <clg@kaod.org> wrote:
> > The first series was nicely presented I think, but you can extend it in
> v2.
> > Documentation needs an update in :
> >
> >   docs/system/target-arm.rst
>
> To expand on that: the new boards should have at least some basic
> documentation in a new docs/system/arm/something.rst (we have
> one .rst file usually for each "family" of boards which are
> similar enough to make sense to document as a group), which is
> added to the toctree in target-arm.rst (note that it is supposed
> to be kept in alpha-order-of-document-title-text). aspeed.rst should
> give an idea of what ought to be documented: a basic summary of
> what the machine is, what is supported, what is not implemented,
> any machine options that the board has, that sort of thing.
>

Thanks for the feedback. I will include documentation in v2 of this
patchset, and also address your other comments.

Havard

--000000000000afdba605a7a93e73
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">On Tue, Jun 9, 2020 at 2:38 AM Peter Mayd=
ell &lt;<a href=3D"mailto:peter.maydell@linaro.org">peter.maydell@linaro.or=
g</a>&gt; wrote:<br></div><div class=3D"gmail_quote"><blockquote class=3D"g=
mail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204=
,204,204);padding-left:1ex">On Tue, 9 Jun 2020 at 08:31, C=C3=A9dric Le Goa=
ter &lt;<a href=3D"mailto:clg@kaod.org" target=3D"_blank" class=3D"cremed">=
clg@kaod.org</a>&gt; wrote:<br>
&gt; The first series was nicely presented I think, but you can extend it i=
n v2.<br>
&gt; Documentation needs an update in :<br>
&gt;<br>
&gt;=C2=A0 =C2=A0docs/system/target-arm.rst<br>
<br>
To expand on that: the new boards should have at least some basic<br>
documentation in a new docs/system/arm/something.rst (we have<br>
one .rst file usually for each &quot;family&quot; of boards which are<br>
similar enough to make sense to document as a group), which is<br>
added to the toctree in target-arm.rst (note that it is supposed<br>
to be kept in alpha-order-of-document-title-text). aspeed.rst should<br>
give an idea of what ought to be documented: a basic summary of<br>
what the machine is, what is supported, what is not implemented,<br>
any machine options that the board has, that sort of thing.<br></blockquote=
><div><br></div><div>Thanks for the feedback. I will include documentation =
in v2 of this patchset, and also address your other comments.</div><div><br=
></div><div>Havard</div></div></div>

--000000000000afdba605a7a93e73--

