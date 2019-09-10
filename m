Return-Path: <SRS0=PbUj=XF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F0AAC3A5A2
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 09:40:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 69F9A2081B
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 09:40:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="T1WG8R/R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69F9A2081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36876 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7cdk-0002Yq-Lj
	for qemu-devel@archiver.kernel.org; Tue, 10 Sep 2019 05:40:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48147)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1i7cd2-0001ni-Gj
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 05:40:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1i7cd1-0002kL-Gl
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 05:40:04 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:44627)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1i7cd1-0002jz-C4
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 05:40:03 -0400
Received: by mail-ot1-x341.google.com with SMTP id 21so17469696otj.11
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2019 02:40:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=enQKB4GqL9YIVEVeQ9X2NaqchWzgWAJS+1qQ0+Vxhiw=;
 b=T1WG8R/RTqH25btaY3SEZ0ePCz2Z5zxBAKuD4KWz1vapwbZh1QbZUxNJBzx2jZQkPg
 N904ez+0WOYX+j8vSAHw8DR9RndM2zcnpIWIIjtpiQUxxZUDXHDEexbwl1NBWpAgm0mz
 8l3GRVHcI5zzORnuOwGMcI9KHmm0lXc+ZfZN2m+MCJ81UKNqBOl57mNLCY5YbpidLWb5
 XdGUvKSX6orPMAgMbYWC4sllvPm6zxcwdtrHjMXUpWGKqjMQbRHXGMgtujnS3b00IOHc
 5nDNZ3Pu7CCppaiR+ohqtBwwrn+v2nbiP+p47KbUcDWzdfzw/RGNMS/zEYCNId1224IU
 6V1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=enQKB4GqL9YIVEVeQ9X2NaqchWzgWAJS+1qQ0+Vxhiw=;
 b=EjxMZEgqY8zycdrjrqE/E2ucqDFpx0I36TKvANByZVMSg8g+lggNkqAt9L/OSsEGRo
 HaB+/Kze05VYSqiiRjJWl1uzXyWZPbHl11NDRHPLt/2Sz+/RTvpqsPlWX6+BQ3JVIRKe
 rCSxwoVgKcCG+zEwBrG9zG2OLVJsrMr3HzCDdqxSnkfpOLEBmWORFLl7OLVVw3nNJ1Oe
 VsqktWzcdbxxCXSV/MvutPj4+kbqwi0encIcXQXJnGMcypGb9ADt+9wAkXTZz1kpyjLC
 WRS/tG2zOiftAPX9+eyvy/UUVyFVSJtv1x/In0IWOgDklXFiSqSLFphJsw/ZftXvUrSh
 whjw==
X-Gm-Message-State: APjAAAXDc0l4xWwed+TNcSz2nZPt9EhmrjV8r3HxcmPpBu4sY+XvQk1M
 PyUhJWeGGIO3fDs++QZ2BMJNT8UpE/Z5Xuzl0OfkKw==
X-Google-Smtp-Source: APXvYqw4RWXH7h/Tahvl5Pzt4ZhsX7v4MYSGvsLx0sTUGL5Sh92dMQ8cgnD2jC9ckFRzymijBISZ59UqBHINm7YkNE8=
X-Received: by 2002:a9d:6a8a:: with SMTP id l10mr21024724otq.97.1568108402610; 
 Tue, 10 Sep 2019 02:40:02 -0700 (PDT)
MIME-Version: 1.0
References: <20190910084349.28817-1-alex.bennee@linaro.org>
 <20190910084349.28817-45-alex.bennee@linaro.org>
 <20190910090743.GC8583@redhat.com>
In-Reply-To: <20190910090743.GC8583@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 10 Sep 2019 10:39:51 +0100
Message-ID: <CAFEAcA_h2xdq=kk3-CScBj=V0j8FYZpLzDGE5eoH=Zkex=Reew@mail.gmail.com>
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::341
Subject: Re: [Qemu-devel] [PULL 44/45] Fedora images: use URLs from stable
 "archives.fedoraproject.org"
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
Cc: Yash Mankad <ymankad@redhat.com>, Fam Zheng <fam@euphon.net>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 10 Sep 2019 at 10:07, Daniel P. Berrang=C3=A9 <berrange@redhat.com>=
 wrote:
>
> On Tue, Sep 10, 2019 at 09:43:48AM +0100, Alex Benn=C3=A9e wrote:
> > From: Cleber Rosa <crosa@redhat.com>
> >
> > The LinuxInitrd.test_with_2gib_file_should_work_with_linux_v4_16 test,
> > from tests/acceptance/linux_initrd.py, is currently failing to fetch
> > the "vmlinuz" file.  The reason for the failure is that the Fedora
> > project retires older versions from the "dl.fedoraproject.org" URL,
> > and keeps them in "archives.fedoraproject.org".  As an added note,
> > that test uses a Fedora 28 image, because of the specific Linux kernel
> > version requirements of the test.
> >
> > For the sake of stability, let's use URLs from the archived and
> > supposedely ever stable URLs.  The good news is that the currently
> > supported versions are also hosted on the later.  This change limits
> > itself to change the URLs, while keeping the fetched files the same
> > (as can be evidenced by the unchanged hashes).
>
> FWIW, I commented on the oiriginal patch before seeing this PR.
> I don't think we should be using the archive URL for anything
> which still exists on download.fedoraproject.org as that's placing
> undesirable load on the Fedora master servers, instead of using its
> primary CDN via the mirror services.

Mmm; I think we should take this patch for the moment to fix
the Travis CI failures, though -- we can look at a more
careful choice of examples/URLs as a followup.

thanks
-- PMM

