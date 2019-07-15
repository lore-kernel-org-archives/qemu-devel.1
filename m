Return-Path: <SRS0=IjNW=VM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC7F0C7618F
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2019 14:18:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7AE4C2081C
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2019 14:18:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hJaSbIIH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7AE4C2081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39220 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hn1oE-00015o-8J
	for qemu-devel@archiver.kernel.org; Mon, 15 Jul 2019 10:18:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59718)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hn1o1-0000fG-VS
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 10:18:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hn1nx-0007Q7-01
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 10:18:17 -0400
Received: from mail-ot1-x335.google.com ([2607:f8b0:4864:20::335]:42417)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hn1nv-0007Nk-Tm
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 10:18:12 -0400
Received: by mail-ot1-x335.google.com with SMTP id l15so17123634otn.9
 for <qemu-devel@nongnu.org>; Mon, 15 Jul 2019 07:18:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=tLWQ9uN1hSLQn5cwzga0bawG7w0phykdKc+H8Eq7ClQ=;
 b=hJaSbIIHncdTxuDlGqZvrwmS3KOZO4+dO8qeCmVkCQJVmTXd1hJyOLZ4AkiiBxOreS
 eruUJTzcAz+CtDZllF8I2JZG+gsy4eYHMJ5hQO7c+rsBGmTW+QuP9f0gYiJWMfXGtdwx
 JiTfRVZR/YurlGSmYKGy9G23UiSXy4oVzRoJimM5p5H+hqTxoOSKHCJYTodri1ffj2jQ
 DcQxfjJxDWDjDs1SpNPThEYiFcm5apyJMTu0PQVDrdcfiBqcWG8dZJKgD1/j++wESxaz
 dJopXlyzRyYXcZKtpJPSZZcEIErvzvPlKjYEqwSrxZkNI59gfhxa9bg0107knaFWnTEx
 MFTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=tLWQ9uN1hSLQn5cwzga0bawG7w0phykdKc+H8Eq7ClQ=;
 b=iN1VKzchLg0q/kX1AQ9Xrbn2HOZJ8YvQog10nTZ/cJD15uE2fUzUsM9vIkfBZbixRh
 iEf+TqKFHD09DrwrlnC4kfzL2gzgTepoGyt3R2jId181j0vaK1TH9O3QaS3gzG94sZS7
 h71Gc8OT2VjQzoQgvfKDEmEYX/u/vwmQYlsDPpfY8Kn5xSBM/j04G1UF52QIJ7SMgqA2
 kIRE7SAu+YjdH+sjiFrrcP3mtw0iMmc7i9p+Nn4wugenWU+yQk1SJRQ+WsYjbYVUrRWm
 IfqpBHwUrrgYJ/rp1BFpgIGZMWnzqj4hSVoY67IF7Ge9HZObCz+8CVZwuCPv//E7e2vj
 hISw==
X-Gm-Message-State: APjAAAVRAx1aROdPU3KlTaRczRztsCxY8XvyI2jkuIN0SW/NbmgqTFbW
 3Jx4mQWE6ie5ofi+ET6ckDZWDJ+eKLxNPgqbBe6N2Q==
X-Google-Smtp-Source: APXvYqzWTHQAEim1DQq3KGPCl3sARZsaOEU15mjTM3NwYxhYPfWqCFD1g1Dm9FgbnWQXqvGTVOdY1D4YnwwSCCecvj4=
X-Received: by 2002:a05:6830:1653:: with SMTP id
 h19mr13034551otr.232.1563200288309; 
 Mon, 15 Jul 2019 07:18:08 -0700 (PDT)
MIME-Version: 1.0
References: <20190712143207.4214-1-quintela@redhat.com>
 <CAFEAcA-ydNS072OH7CyGNq2+sESgonW-8QSJdNYJq6zW-rYjUQ@mail.gmail.com>
 <CAFEAcA9ncjtGdc8CZOJBDBRtzEU8oL7YicVg5PtyiiO2O4z51w@mail.gmail.com>
 <20190715140441.GJ30298@redhat.com>
In-Reply-To: <20190715140441.GJ30298@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 15 Jul 2019 15:17:57 +0100
Message-ID: <CAFEAcA9kreC_VRddsC0WRuuCw2R3ohER0_+vaf_PeG43XPzYWw@mail.gmail.com>
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::335
Subject: Re: [Qemu-devel] [PULL 00/19] Migration patches
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 kvm-devel <kvm@vger.kernel.org>, Juan Quintela <quintela@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 15 Jul 2019 at 15:04, Daniel P. Berrang=C3=A9 <berrange@redhat.com>=
 wrote:
>     MultiFDInit_t msg =3D {0};
>
> should fix it.

A minor nit, but "=3D {}" is our standard struct-zero-initializer
so we should prefer that, I think. (I know it is not the C-spec
recommended version but some C compilers incorrectly warn about
"=3D {0}" whereas no compiler we care about warns about the
gnu-extension "=3D {}".)

thanks
-- PMM

