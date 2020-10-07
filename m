Return-Path: <SRS0=37Ja=DO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5365C4363C
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 18:55:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4313A2168B
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 18:55:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Slcgq3Nc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4313A2168B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42228 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQEah-00035S-2c
	for qemu-devel@archiver.kernel.org; Wed, 07 Oct 2020 14:55:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47488)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kQEZd-0002Xx-IB
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 14:54:01 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:44270)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kQEZb-00038a-AB
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 14:54:00 -0400
Received: by mail-wr1-x442.google.com with SMTP id t9so3470696wrq.11
 for <qemu-devel@nongnu.org>; Wed, 07 Oct 2020 11:53:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=S3H9CNAf/+5oVzXbSwp1bZVt6nJdDkvfclmGDmKWsHs=;
 b=Slcgq3NcZX+JrwY5pHmqp+5/blUOjsym1UeQSY1uTZubDrx8hJhLH71tmG7g8LVTTT
 4wJqO0XcLvQaMf32AujUAFzqlDezqEKT/nG8VzZqe7S8TWcOCD/pNK1yLWppoj0/4KYx
 ahxw8lB0hmUZ2y0naRed7dIfFyuvWvUaI2NzKtGOUD+j2EJXidsNrXU435+VxFkwXK8E
 MaVUKZ/4PbgvE0lGJ37gQk3hsvAXBSP6mXt/cfdkF4dyNikIgR3V1029DLNnwhKtaYi6
 INfcMGXtEpcC5vISFOHu1Bb9kFSgU1rBB9peozwyEnJfebIsUl131xIhX+Rquwv/zCKD
 sSmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=S3H9CNAf/+5oVzXbSwp1bZVt6nJdDkvfclmGDmKWsHs=;
 b=VFKm+NyZlK+t+92fSe1X3NmgaJWCPcZHyOMwyCiceBG0GBQVaKQ5sOWpX1Jo59GnMW
 4JP/aUMU0e2RfuU7Bj2dQ47QGfd8T/2euItssDFHBbD7aR/YZ+vQKzInJXidKAda0Gsw
 dEwlv/1/Ae9uWqwYX/vUtH7k3BECy+od7eubPL7hikU8UFg2hBH8V9JhbpYckxajy2HD
 1A2ZaA4hn1iHFDeisklwWypdQcxK0ppir83oBI1M6F5RMse8SYkkQtpsCImLVXsGz0ep
 spG9xa8Ks72fvESB2z+NpxSVIRyKXtbgOv4ZFTXy2KW0JPgGkC+zXtXYpJRaixmzFuY6
 byGw==
X-Gm-Message-State: AOAM532ho5i/2bsePGuaIs0bye2xKzmRA190o3HvbbgMGJCeJMYzj5o1
 MZ5My2cISrrXnjOvOUizPpw1kA==
X-Google-Smtp-Source: ABdhPJx3E+W67iKuYWR8YWgUC7KUjoYy3oMPz4xfGrgixZSTTWYfBlKG5WO/rrwCHpu1Crs3QiM4Ug==
X-Received: by 2002:adf:e70a:: with SMTP id c10mr4894934wrm.425.1602096837525; 
 Wed, 07 Oct 2020 11:53:57 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id a82sm4061058wmc.44.2020.10.07.11.53.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Oct 2020 11:53:56 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id B95CF1FF7E;
 Wed,  7 Oct 2020 19:53:55 +0100 (BST)
References: <20201007145300.1197-1-luoyonggang@gmail.com>
 <20201007145300.1197-2-luoyonggang@gmail.com>
 <11e4e784-3ce9-a385-bf81-8c7e1034f42d@redhat.com>
 <CAE2XoE89z44nA=N-U_r-C8RA5Vn+C3gqABt85PLFPcSg4ET5gw@mail.gmail.com>
User-agent: mu4e 1.5.5; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: luoyonggang@gmail.com
Subject: Re: [PATCH v5 1/2] cirrus: Fixing and speedup the msys2/mingw CI
In-reply-to: <CAE2XoE89z44nA=N-U_r-C8RA5Vn+C3gqABt85PLFPcSg4ET5gw@mail.gmail.com>
Date: Wed, 07 Oct 2020 19:53:55 +0100
Message-ID: <87d01tzx30.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x442.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 QEMU Trivial <qemu-trivial@nongnu.org>, qemu-devel@nongnu.org,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


=E7=BD=97=E5=8B=87=E5=88=9A(Yonggang Luo) <luoyonggang@gmail.com> writes:

> On Wed, Oct 7, 2020 at 11:12 PM Thomas Huth <thuth@redhat.com> wrote:
>>
>> On 07/10/2020 16.52, Yonggang Luo wrote:
>> > Use cache of cirrus caching msys2
>> > The install of msys2 are refer to https://github.com/msys2/setup-msys2
>> > The first time install msys2 would be time consuming, so increase
> timeout_in to 90m
>> > according to https://cirrus-ci.org/faq/#instance-timed-out
>> >
>> > Apply patch of
> https://lists.gnu.org/archive/html/qemu-devel/2020-10/msg00072.html
>> >
>> > Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
>> > ---
>> >  .cirrus.yml | 110 +++++++++++++++++++++++++++++++---------------------
>> >  1 file changed, 66 insertions(+), 44 deletions(-)
>> >
>> > diff --git a/.cirrus.yml b/.cirrus.yml
>> > index d58782ce67..a1145d0366 100644
>> > --- a/.cirrus.yml
>> > +++ b/.cirrus.yml
>> > @@ -46,64 +46,86 @@ macos_xcode_task:
>> >      - gmake check
>> >
>> >  windows_msys2_task:
>> > +  timeout_in: 90m
>> >    windows_container:
>> > -    image: cirrusci/windowsservercore:cmake
>> > +    image: cirrusci/windowsservercore:2019
>> >      os_version: 2019
>> >      cpu: 8
>> >      memory: 8G
>> >    env:
>> > +    CIRRUS_SHELL: powershell
>> >      MSYS: winsymlinks:nativestrict
>> >      MSYSTEM: MINGW64
>> >      CHERE_INVOKING: 1
>> >    printenv_script:
>> > -    - C:\tools\msys64\usr\bin\bash.exe -lc 'printenv'
>> > +    - choco install -y --no-progress 7zip
>>
>> Since you've now removed the 'printenv' line, I think the section should
>> maybe not be called "printenv_script" anymore, should it?
> May I name it install_7zip?
> Cause that's a deps need installed first.

I renamed it setup_script: when I merged it.

>>
>>  Thomas
>>


--=20
Alex Benn=C3=A9e

