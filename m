Return-Path: <SRS0=68uo=YX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBF5BCA9EC5
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Oct 2019 14:11:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 96DD320856
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Oct 2019 14:11:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cWKed2W4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96DD320856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40806 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iPogn-0002hi-QF
	for qemu-devel@archiver.kernel.org; Wed, 30 Oct 2019 10:11:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55700)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iPog1-0002Bw-Gq
 for qemu-devel@nongnu.org; Wed, 30 Oct 2019 10:10:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iPog0-0006lj-3d
 for qemu-devel@nongnu.org; Wed, 30 Oct 2019 10:10:21 -0400
Received: from mail-oi1-x22f.google.com ([2607:f8b0:4864:20::22f]:43765)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iPofz-0006i6-Tq
 for qemu-devel@nongnu.org; Wed, 30 Oct 2019 10:10:20 -0400
Received: by mail-oi1-x22f.google.com with SMTP id s5so2050192oie.10
 for <qemu-devel@nongnu.org>; Wed, 30 Oct 2019 07:10:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=P+ac2kaGpFtES23Xbgh3ARjVQM5MjL5K5fPWMpE0rX4=;
 b=cWKed2W46h+BJNlHNGhnITGPrQbZ23rM+AVwtbReFL0NhfelzMMD/rJdv4s1QsMALj
 q4taMcCZGy06OvOOwwzfUwvYSiHaxXlbc0u8MN6olOMSdXeCpUUeFdik6dHKmYxTnqBT
 B0JrSYW9URmwU+JFgKqCLt1dnz2S6yQesGuuthY1VJpSx+vP6hGpWunV4Sp/iUKSinf4
 3dkQI5I0cdNUcZTEiYMXy0dlENpMw5PTTZFLFLjB98Dny+aZY40vbdvA7+1pN9BliCn9
 x2ratrhjaf0/FaTsfvEyiXUrzVcuqxVho9DWZ9L1pNV3FDhv2JcgfCfqD6E6N3fD9rPH
 A68w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=P+ac2kaGpFtES23Xbgh3ARjVQM5MjL5K5fPWMpE0rX4=;
 b=dc/r1DGnseV35BreVMIn5mGSUhqIFKelDcWCLv17hcnlyLGb+NwgEB8Xsa8m/qe059
 9rNJaYIiE/ybQwRLTx3w2Sqg+1F6CnQmjHLQr6ptTqrdoeeQSMXgNJlsJH+lZh/NgiWF
 sUIwljSeflejdPFoRL6NDI4MYi1m1Xje/08lzUsJZO+/YXTI5OzBF3b8CgHGuzBfu0B+
 aDHbUm2vG4A2h9Pr5nsoXmHmXZHxnTOT7ACMr/nkHwqC0xG8GPsbkRqpQcbMsqnjsomF
 Dak+hcsnvdLyugqAMyDArwwxGznchJMuWQCJhirDlChqhvBoUveUnpGjEJZySrlFSu4r
 J6Og==
X-Gm-Message-State: APjAAAWu2PtlCmVkGvSuSUdT/5A/gbkUzL4ml7nH/ZQoBOqqLb1fQ+nV
 ttoMooZausJYX+c7JtO0lvBBLbz3ksafiELZFcvJ8g==
X-Google-Smtp-Source: APXvYqxNXmLVPwsRjCuQAihDPCpWrysSLN+If33z+dP+tXo1577zeEaatusMX42fUFwqH94fupnSYYidhnAwMAX8n8Y=
X-Received: by 2002:aca:2312:: with SMTP id e18mr9133881oie.98.1572444618697; 
 Wed, 30 Oct 2019 07:10:18 -0700 (PDT)
MIME-Version: 1.0
References: <20191028235002.17691-1-crosa@redhat.com>
 <CAFEAcA9_ycm2nyJeAR-Y43VT6o6zkrUykNXJPQKYv8os107_wg@mail.gmail.com>
 <20191029215118.GA10535@localhost.localdomain>
 <20191029215804.GA10923@localhost.localdomain>
 <20191029234019.GA16280@localhost.localdomain>
In-Reply-To: <20191029234019.GA16280@localhost.localdomain>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 30 Oct 2019 14:10:07 +0000
Message-ID: <CAFEAcA-YEkBXcsRJPF6yAcOAFUN9-_NpaA8UkY_VN0ufrcGTtg@mail.gmail.com>
Subject: Re: [PULL 0/16] Python (acceptance tests) queue, 2019-10-28
To: Cleber Rosa <crosa@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::22f
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
Cc: Fam Zheng <fam@euphon.net>, Eduardo Habkost <ehabkost@redhat.com>,
 Aleksandar Rikalo <arikalo@wavecomp.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Fabien Chouteau <chouteau@adacore.com>,
 KONRAD Frederic <frederic.konrad@adacore.com>,
 =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Willian Rampazzo <wrampazz@redhat.com>, qemu-ppc <qemu-ppc@nongnu.org>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 29 Oct 2019 at 23:40, Cleber Rosa <crosa@redhat.com> wrote:
>
> I'm now getting the updated key on every single server I've tried.
>
> Any further feedback/request is highly appreciated.

Yep, I was able to pull the updated key.


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.2
for any user-visible changes.

-- PMM

