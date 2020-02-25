Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C316AC35E01
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 18:00:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9333320CC7
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 18:00:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OUevvk09"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9333320CC7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33192 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6eVW-0000k9-Ij
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 13:00:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43463)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j6eUo-00008l-7n
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 12:59:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j6eUl-0005Bl-Hk
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 12:59:49 -0500
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:41277)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j6eUk-00059H-Bs
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 12:59:46 -0500
Received: by mail-ot1-x341.google.com with SMTP id r27so346154otc.8
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2020 09:59:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=W28rY17XTRepgbKD/r8mQU1v8DRt0hELpfG0EAlGrVQ=;
 b=OUevvk097+P0ZKnW7Vh+sOutPCMzBirrN6uvrcZYUBz36tRDoh+6Gn943eHqcmP2AA
 3+tWDrNPW6t1RboZskVgHYjIQRWDNUvy8277+Tm8cHZ2m9ylpX3yRYol5hRDI1BSkIjn
 KbXvwPFMlLbUyFkuP5rU+8p7QRCVtuD4qEMSt4ATyE/54njLk7F9RWKmhTi/7Qg681ra
 x7PUQvWC/cL3g6Z21NNP8M1T/0i103KVs3Mive7tfCIEEeW8z6tlm5lWns3DRUl6oFKi
 qsgxuhF15wLB5TlDYQCN51ZoWwq8MQZkfeNHxcpLnkFv4qsRh1Xre0jvV0jmavKpb4MQ
 GyLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=W28rY17XTRepgbKD/r8mQU1v8DRt0hELpfG0EAlGrVQ=;
 b=GrhmF/BncidHx4OLsYFw4yWPijqj6MG4frP6BSvLQSVmwbAjdu+dXDNgB3aO9scHMl
 ON5ss2XWJAp5Z0pVQga3wujw+vUJ+X8+KgsyUMrOTeRhSvdYFCz/xCsR9A8NuPvf05yp
 udfBScAV2mbDoH9eiexlixoeM120UdS/knfogcZw+dMFo3KESa7ieDHve51nVOP0fHf1
 H82R+KdRUKg2IOfi5I0UVCAhG8uGWcAYKd44I5M9hmf4pOCWHgaBJwEoY36elg6Wk6Yo
 GkIJPtyoK/P7k4F1/+WMBRMde5SnMcU0qyTa2xD67QWZ+YkvcRshLAN01/Z111R5oUA9
 uBjQ==
X-Gm-Message-State: APjAAAV22N2KHgurwCYpOlTncN0Sy2eUbAL/Xh/9hzJ2m1q3N6zIPrxs
 aijeAVRzmQTr/6uQurz7LJWFLE7Fh+lb4OS2DGKONg==
X-Google-Smtp-Source: APXvYqxxB/GFyP9mhyDTpI0ukqbiAGzcnrZCNo2djqpY71chuKJXPH0nhTVSMrDAhjhGK9vczz/VWV0B4jNolBLEjjQ=
X-Received: by 2002:a05:6830:13da:: with SMTP id
 e26mr42679049otq.97.1582653585121; 
 Tue, 25 Feb 2020 09:59:45 -0800 (PST)
MIME-Version: 1.0
References: <20200225154121.21116-1-peter.maydell@linaro.org>
 <5a6757cb-fda2-ba3f-6c24-f09829faf4ab@redhat.com>
 <CAFEAcA-C0o_u8VABdRky7GUCvyiWhkn74cT1UYAtEAAFjGBLAA@mail.gmail.com>
 <6ed08bea-4fcb-08dc-417c-a0f534173a31@redhat.com>
In-Reply-To: <6ed08bea-4fcb-08dc-417c-a0f534173a31@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 25 Feb 2020 17:59:33 +0000
Message-ID: <CAFEAcA9KmsHS4fnYWvpMMa5SLLUBjiPcOsfmGOHcWopd11M3+g@mail.gmail.com>
Subject: Re: [PATCH 0/4] docs: Miscellaneous rST conversions
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::341
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
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 25 Feb 2020 at 17:48, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> On 25/02/20 18:11, Peter Maydell wrote:
> >> I assume these are not meant to be applied now, except patch 2?
> > No, I intended them to be reviewable and applied now. Why
> > do you think we should wait?
>
> Because they remove information from qemu-doc.texi.  I think it's
> feasible to do a mass conversion quite soon, within a single pull
> request, the only important part that is missing is the hxtool conversion.

My assumption was that we would attack this by:
 * converting chunks of the documentation which are in qemu-doc.texi
   but which aren't in the qemu.1 manpage (basically in the way this
   series is doing)
 * get the qapidoc generation conversion reviewed and into
   master (since at the moment it outputs into files included
   from qemu-doc)
 * convert the manpage parts; we have the machinery for dealing
   with the hxtool files, it just needs a little more work

> (See also the patches I posted today, which take the opposite direction
> of making qemu-doc.texi's structure more like what we'll have in the end
> in docs/system).

This ought to make it easier to do the conversion of the
various subparts, right?

Incidentally:
> makeinfo -o - --docbook security.texi  | pandoc -f docbook -t rst

security texi was the really easy one here. I had to do more
manual formatting fixups on qemu-deprecated.texi which I'm
sceptical would have worked out as nicely done automatically.

The automatic conversion rune also doesn't seem to get quotes
and apostrophes right: it has turned "guest B's disk image" into
something with a smartquote character in it, for instance.

thanks
-- PMM

