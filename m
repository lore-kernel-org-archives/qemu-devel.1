Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EDC6C1975A
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 18:34:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CDBF220714
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 18:34:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Hfk7OTz0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDBF220714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39406 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEH2b-0002AH-Ud
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 14:34:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59088)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jEH1J-0000Fm-SH
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 14:32:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jEH1I-0005SK-JS
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 14:32:53 -0400
Received: from mail-oi1-x234.google.com ([2607:f8b0:4864:20::234]:44250)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jEH1I-0005JF-C1
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 14:32:52 -0400
Received: by mail-oi1-x234.google.com with SMTP id d62so22800451oia.11
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2020 11:32:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=1PyIH9thGegmvicIOLSC4N8XbTNEEwGb6a0NIj0n11Y=;
 b=Hfk7OTz0ERmbjI4YMC3QVlDqzyA19pN4n0t9C8ndCYNTJ5vEFblJK4NMWa4jkWc+in
 Hnx0ZJ5WQUlkvxGshdDGAwgEIbCrKFy428AlCaRsAutIoO4Ve0DgLz+PT/ePggPuz6kU
 xl6ejHB7YjySQeazffV0vhZawVcn9OODxtcm4QM23umFaDUkyG78v/0LODCqQb5gRrGq
 +cCNCBB8ikl+jhTMDetXpbTPkq41K9DfWwtghOcj0LXBOhFZDnSa7iXErE4XjWxxTuB2
 vK0P6RV1FUZCI2nJ9jMuycNu8pBedEdCY9XTqF7HK5zR1FIabO11tWyBTv6aEp9QWZU3
 4Yqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=1PyIH9thGegmvicIOLSC4N8XbTNEEwGb6a0NIj0n11Y=;
 b=ZVTigldZuEP9L0WeGFkk3FEvO05PK3Qgs3tlTRvpvAoQpZFLKQokrNeDyAs7xbTt+h
 GQb5MSLpQF4fqWFpdjOyLNHCIIq1bZHBhJ0SbSdJdBT4PqstUDPpaX56bP/mSp7+lo/i
 uyjqWEDZfCBgSuVRroj96cEHmMMo5AXZeEGNvaySJHF+HhipPT1Suv9mWsQGCNK86cHy
 l2WOMhvGNrquwPb6XRyhGl9nNRIJb51AzjZQ4+JsAIQQkBAM2gOmzUoEoG9+Fq5uhB5e
 dyNKmTJkwtLjleP/XlAaSw6TDBtKSqdEsNTcgWC1SPS23gm7KVXcTCzKrTOI3p856yDa
 LPAg==
X-Gm-Message-State: ANhLgQ2HH3Tq/XnXUwrcv71d0e8H70H6SvOY+x8itfoPRUQA+bWAD+qC
 4DMjlg0JtSzlSPks2b7OsKP7KyNggNrqyrsvUfzW+Q==
X-Google-Smtp-Source: ADFU+vukdPscRy+z8zAXdb1gEHoTMPKIfrmdga+nbGgGuO/nZCjsmuI6IVvEpMv2mfWVrjqqwB074njQkWJGwU8Afmw=
X-Received: by 2002:aca:c608:: with SMTP id w8mr162442oif.163.1584469971225;
 Tue, 17 Mar 2020 11:32:51 -0700 (PDT)
MIME-Version: 1.0
References: <20200317151831.531965-1-stefanha@redhat.com>
In-Reply-To: <20200317151831.531965-1-stefanha@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 17 Mar 2020 18:32:39 +0000
Message-ID: <CAFEAcA9iyVYU5pYgaRWdw8ieHWPrBAWZk2xVuFjLAyVToBTagA@mail.gmail.com>
Subject: Re: [PULL 0/1] Block patches
To: Stefan Hajnoczi <stefanha@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::234
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 QEMU Developers <qemu-devel@nongnu.org>, Qemu-block <qemu-block@nongnu.org>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 17 Mar 2020 at 15:18, Stefan Hajnoczi <stefanha@redhat.com> wrote:
>
> The following changes since commit 61c265f0660ee476985808c8aa7915617c44fd53:
>
>   Merge remote-tracking branch 'remotes/dgilbert/tags/pull-migration-20200313a' into staging (2020-03-13 10:33:04 +0000)
>
> are available in the Git repository at:
>
>   https://github.com/stefanha/qemu.git tags/block-pull-request
>
> for you to fetch changes up to 4ab78b19189a81038e744728ed949d09aa477550:
>
>   block/io: fix bdrv_co_do_copy_on_readv (2020-03-16 11:46:11 +0000)
>
> ----------------------------------------------------------------
> Pull request
>
> ----------------------------------------------------------------


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.0
for any user-visible changes.

-- PMM

