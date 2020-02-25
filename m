Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF66FC35E04
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 18:29:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A34320CC7
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 18:29:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L+Kqzb+D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A34320CC7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33632 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6exE-0005d5-QB
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 13:29:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49631)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1j6ewZ-0005BL-Qr
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 13:28:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1j6ewX-0000vU-Bm
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 13:28:31 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:21153
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1j6ewV-0000sq-Kg
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 13:28:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582655305;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=u+5AHqqBl+M8OO8l9XcfYdv+ZwZVBtSspmqfDklGP9c=;
 b=L+Kqzb+DXEMDXhMhv81ZPHnjFDWBQMJtWKXEjWyrVt/n+tQNG27TG4tGOBlsBASi2v8A1Q
 HyBZ9kimm8zzvSgWJC1PR4tdavrHCVQ1blSnUMzBV8imAFKSlKpNyxo/qONgPxMPeqNmID
 MlATjWhByKMV/U/NtAl50jpcvx51mj4=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-429-1X9I1iM-OLOQG9WSkXejbw-1; Tue, 25 Feb 2020 13:28:23 -0500
X-MC-Unique: 1X9I1iM-OLOQG9WSkXejbw-1
Received: by mail-wr1-f72.google.com with SMTP id d9so170007wrv.21
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2020 10:28:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=u+5AHqqBl+M8OO8l9XcfYdv+ZwZVBtSspmqfDklGP9c=;
 b=qxpSjUF1gvrBaDCi9KWbMLl8+NAQcSfFSAOF1KelCjRtFg9wDx6U14DPHutj6JxlJX
 4QdUtZO28vz6BH2Y1VlfnwXFcMpwA+bTrabCDD15iA55y13TuOgWjPekqQ12P4GUynN7
 l67R4HFYUN+yB5fHEldyfpP/GuISb8ao9Ul2swaf9qargcIki3QG7bhb5571/4WzdS73
 gxiFYKIY9BSoa2LMZcmf6Q23ukS4K7+bCBx11sgBWmpJb3mWIaXRFkQ3oF2fO4E+M3BD
 ml2zplxfCdCcU1ARTd54/j/XRXGuWslEysKVC0+vNTlIOLP46938yJ13RxcuU4bDOjlV
 BSPw==
X-Gm-Message-State: APjAAAWhw0Ha1eNBFTSVNgKovpT/Jx3D9RehQ9jAM+ee3VZs54bWPuFp
 QI6ZQiiolcF9Av4MpuNGlazZABCqVkY6EcwdtNaZzxGS61xA6isi3Uz96EYUPOboXBbQd4nTMUR
 BMfblB1wrDI3rc68=
X-Received: by 2002:adf:ed84:: with SMTP id c4mr475821wro.24.1582655299601;
 Tue, 25 Feb 2020 10:28:19 -0800 (PST)
X-Google-Smtp-Source: APXvYqzHR6zrE2lCrGZPp1DomBpAXknDT+a+xyJH9xPULgvCrDuzZry8ujQjzXpN7iZKkTOUfHR0YQ==
X-Received: by 2002:adf:ed84:: with SMTP id c4mr475801wro.24.1582655299303;
 Tue, 25 Feb 2020 10:28:19 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:3577:1cfe:d98a:5fb6?
 ([2001:b07:6468:f312:3577:1cfe:d98a:5fb6])
 by smtp.gmail.com with ESMTPSA id q6sm18561577wrf.67.2020.02.25.10.28.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 25 Feb 2020 10:28:18 -0800 (PST)
Subject: Re: [PATCH 0/4] docs: Miscellaneous rST conversions
To: Peter Maydell <peter.maydell@linaro.org>
References: <20200225154121.21116-1-peter.maydell@linaro.org>
 <5a6757cb-fda2-ba3f-6c24-f09829faf4ab@redhat.com>
 <CAFEAcA-C0o_u8VABdRky7GUCvyiWhkn74cT1UYAtEAAFjGBLAA@mail.gmail.com>
 <6ed08bea-4fcb-08dc-417c-a0f534173a31@redhat.com>
 <CAFEAcA9KmsHS4fnYWvpMMa5SLLUBjiPcOsfmGOHcWopd11M3+g@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <9f64719b-184c-cd61-1260-f13428ea7369@redhat.com>
Date: Tue, 25 Feb 2020 19:28:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9KmsHS4fnYWvpMMa5SLLUBjiPcOsfmGOHcWopd11M3+g@mail.gmail.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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

On 25/02/20 18:59, Peter Maydell wrote:
> My assumption was that we would attack this by:
>  * converting chunks of the documentation which are in qemu-doc.texi
>    but which aren't in the qemu.1 manpage (basically in the way this
>    series is doing)
>  * get the qapidoc generation conversion reviewed and into
>    master (since at the moment it outputs into files included
>    from qemu-doc)

The QAPI docs are in other manuals in docs/interop/, aren't they?

>  * convert the manpage parts; we have the machinery for dealing
>    with the hxtool files, it just needs a little more work
>
>> (See also the patches I posted today, which take the opposite direction
>> of making qemu-doc.texi's structure more like what we'll have in the end
>> in docs/system).
> 
> This ought to make it easier to do the conversion of the
> various subparts, right?

Right, and easier to review as well; I called it "the opposite
direction" because the editing is done in Texinfo format and the rST
conversion becomes relatively trivial.  This would make it possible to
do the conversion in a branch and pull it all at once (apart from
qapidoc and possibly other small changes like removing obsolete parts).

> Incidentally:
>> makeinfo -o - --docbook security.texi  | pandoc -f docbook -t rst
> security texi was the really easy one here. I had to do more
> manual formatting fixups on qemu-deprecated.texi which I'm
> sceptical would have worked out as nicely done automatically.

The automated conversion of qemu-deprecated.texi is indeed bad because
the titles in the source are missing @code{...} to activate monospaced
characters.

> The automatic conversion rune also doesn't seem to get quotes
> and apostrophes right: it has turned "guest B's disk image" into
> something with a smartquote character in it, for instance.

We probably don't want smartquotes at all, so you'd use "-t rst+smart"
as the destination.  Also pandoc does not use the "::" at the end of the
previous paragraph.  That can be fixed with for example

  perl -e '$/=undef; $_ = <>; s/:\n\n::/::/g; print'

In general the result is more than acceptable, and I'd rather get a
quick-and-slightly-dirty conversion done quickly than do everything
manually but risk missing 5.0.

Paolo


