Return-Path: <SRS0=ff1W=CL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA7A3C433E2
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 17:19:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5709E20684
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 17:19:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EDrNFYgp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5709E20684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35968 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDWPs-0003Sa-Gr
	for qemu-devel@archiver.kernel.org; Wed, 02 Sep 2020 13:19:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49794)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kDWO5-0001n7-Lf
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 13:17:33 -0400
Received: from mail-lj1-x243.google.com ([2a00:1450:4864:20::243]:39132)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kDWO3-0002RT-UW
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 13:17:33 -0400
Received: by mail-lj1-x243.google.com with SMTP id e11so57209ljn.6
 for <qemu-devel@nongnu.org>; Wed, 02 Sep 2020 10:17:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:reply-to:from:date:message-id
 :subject:to:cc;
 bh=aeNxco4apd/qMfeQ4+KZx0Fh3iawfF+SvgFlDPErNV8=;
 b=EDrNFYgpY9FO0UqjfXqMznDngvA5maK+zSVDPiZNcvqGYqEcV2+iFyecXUuEilZ7wo
 BckQgNphInt8ecFOcfsM1cJc7M9RWNgZmFep2ZK1boU00o3FwG9cqszMzbDr+ZpWGu3v
 hrvImlFGxyKB3jb6BLt8XNUnjTLxeoQIT6XYkklpKyGB6wvyqTY3mW26Re5UpXTtf+en
 MkSDvs4PYA/3uWr+rBZyD4/9gCHZGhlaUaQRg8VZkk6Yk+3KviowyijazL/NFaIqc5yJ
 plrw85glU6WBVcAVYCN8NKPL1PASeCCFiw9auUBCGKAABxrcVA7sPptJXGTt0hJapy6w
 w0pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
 :from:date:message-id:subject:to:cc;
 bh=aeNxco4apd/qMfeQ4+KZx0Fh3iawfF+SvgFlDPErNV8=;
 b=h/S6NZJ1/fq2AMnQSPbKcgl+rVgWnRMYbgBvWLWDlV/kAogNOJsaWjfQCZMnpknSg+
 tRq0AifaypPK7+vbXXG51BKZZbSwaz94DDntRK3mA0tmgeGmfx4gYot7p7yE8Msa+xhA
 V8ZXJTUL4WMGjCHu18PocmsU9z0Zm7DuwrwHUUeO7ph7IXRbN0n3CURzGNzifk4fAfqA
 MHuQIaowIRGymW6JmYOgXOJSeXkmQe8uESxkqNQOte8H0CnHaaNggF8sSPO3+D46lZEE
 DqEGGjTARwLBXvJwcnRr67Zgzp2REZRtU/0fsui5AkMKWBX7v4QM1NGp+Ijmd2Z9d5HX
 6Xrg==
X-Gm-Message-State: AOAM533XlmQScfiDpir25f93Dq/nC/mUDSlWHnx9ye8UcxcwhH8d29k4
 bp3tiycAGG6CBhbIvDUBdo+18LJ1tsvKBDEDNcE=
X-Google-Smtp-Source: ABdhPJwHZ+OktPUHTN7ocDUD6NzGKbV0Q5Z/gjOrltg1gUa/PUsd7tbGmEZihvR2XYF86pGHr5fn9vNvq3CfFhqphGk=
X-Received: by 2002:a2e:87d9:: with SMTP id v25mr3885829ljj.171.1599067050117; 
 Wed, 02 Sep 2020 10:17:30 -0700 (PDT)
MIME-Version: 1.0
References: <20200902170054.810-1-luoyonggang@gmail.com>
 <20200902170054.810-5-luoyonggang@gmail.com>
 <285c6d4c-6a92-53d0-37d3-e22f71b67033@linaro.org>
In-Reply-To: <285c6d4c-6a92-53d0-37d3-e22f71b67033@linaro.org>
From: =?UTF-8?B?572X5YuH5YiaKFlvbmdnYW5nIEx1byk=?= <luoyonggang@gmail.com>
Date: Thu, 3 Sep 2020 01:17:18 +0800
Message-ID: <CAE2XoE9rC9qEO--fiuwXH+AsBHU_YKwsPhBqK=YjmVWEv_LS4A@mail.gmail.com>
Subject: Re: [PATCH 4/6] tcg: Fixes dup_const link error
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: multipart/alternative; boundary="0000000000007e900005ae57cf0c"
Received-SPF: pass client-ip=2a00:1450:4864:20::243;
 envelope-from=luoyonggang@gmail.com; helo=mail-lj1-x243.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Reply-To: luoyonggang@gmail.com
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-level <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000007e900005ae57cf0c
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Win32 gcc 10 mingw

On Thu, Sep 3, 2020 at 1:16 AM Richard Henderson <
richard.henderson@linaro.org> wrote:

> On 9/2/20 10:00 AM, Yonggang Luo wrote:
> > Rename function dup_const to dup_const_eval for avoid confliction with
> macro dup_const
> >
> > The link error on msys2
> >
> > Linking target qemu-system-alpha.exe
> >
> C:/CI-Tools/msys64/mingw64/bin/../lib/gcc/x86_64-w64-mingw32/10.2.0/../..=
/../../x86_64-w64-mingw32/bin/ld.exe:
> libqemu-alpha-softmmu.fa.p/tcg_optimize.c.obj: in function `tcg_optimize'=
:
> > E:\CI-Cor-Ready\xemu\qemu-build/../qemu.org/tcg/optimize.c:1106:
> undefined reference to `dup_const'
> >
> C:/CI-Tools/msys64/mingw64/bin/../lib/gcc/x86_64-w64-mingw32/10.2.0/../..=
/../../x86_64-w64-mingw32/bin/ld.exe:
> libqemu-alpha-softmmu.fa.p/tcg_tcg-op-vec.c.obj: in function
> `tcg_gen_dupi_vec':
> > E:\CI-Cor-Ready\xemu\qemu-build/../qemu.org/tcg/tcg-op-vec.c:283:
> undefined reference to `dup_const'
> > collect2.exe: error: ld returned 1 exit status
> >
> > Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
> > ---
>
> This should not be required.  What compiler is this?
>
>
> r~
>


--=20
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

--0000000000007e900005ae57cf0c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Win32 gcc 10 mingw</div><br><div class=3D"gmail_quote"><di=
v dir=3D"ltr" class=3D"gmail_attr">On Thu, Sep 3, 2020 at 1:16 AM Richard H=
enderson &lt;<a href=3D"mailto:richard.henderson@linaro.org">richard.hender=
son@linaro.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" st=
yle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padd=
ing-left:1ex">On 9/2/20 10:00 AM, Yonggang Luo wrote:<br>
&gt; Rename function dup_const to dup_const_eval for avoid confliction with=
 macro dup_const<br>
&gt; <br>
&gt; The link error on msys2<br>
&gt; <br>
&gt; Linking target qemu-system-alpha.exe<br>
&gt; C:/CI-Tools/msys64/mingw64/bin/../lib/gcc/x86_64-w64-mingw32/10.2.0/..=
/../../../x86_64-w64-mingw32/bin/ld.exe: libqemu-alpha-softmmu.fa.p/tcg_opt=
imize.c.obj: in function `tcg_optimize&#39;:<br>
&gt; E:\CI-Cor-Ready\xemu\qemu-build/../<a href=3D"http://qemu.org/tcg/opti=
mize.c:1106" rel=3D"noreferrer" target=3D"_blank">qemu.org/tcg/optimize.c:1=
106</a>: undefined reference to `dup_const&#39;<br>
&gt; C:/CI-Tools/msys64/mingw64/bin/../lib/gcc/x86_64-w64-mingw32/10.2.0/..=
/../../../x86_64-w64-mingw32/bin/ld.exe: libqemu-alpha-softmmu.fa.p/tcg_tcg=
-op-vec.c.obj: in function `tcg_gen_dupi_vec&#39;:<br>
&gt; E:\CI-Cor-Ready\xemu\qemu-build/../<a href=3D"http://qemu.org/tcg/tcg-=
op-vec.c:283" rel=3D"noreferrer" target=3D"_blank">qemu.org/tcg/tcg-op-vec.=
c:283</a>: undefined reference to `dup_const&#39;<br>
&gt; collect2.exe: error: ld returned 1 exit status<br>
&gt; <br>
&gt; Signed-off-by: Yonggang Luo &lt;<a href=3D"mailto:luoyonggang@gmail.co=
m" target=3D"_blank">luoyonggang@gmail.com</a>&gt;<br>
&gt; ---<br>
<br>
This should not be required.=C2=A0 What compiler is this?<br>
<br>
<br>
r~<br>
</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr"=
 class=3D"gmail_signature">=C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =E6=AD=A4=E8=
=87=B4<br>=E7=A4=BC<br>=E7=BD=97=E5=8B=87=E5=88=9A<br>Yours<br>=C2=A0 =C2=
=A0 sincerely,<br>Yonggang Luo<br></div>

--0000000000007e900005ae57cf0c--

