Return-Path: <SRS0=VgCP=2F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC1FCC43603
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Dec 2019 09:52:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 968E82072B
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Dec 2019 09:52:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YFPJieUh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 968E82072B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37476 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1igQZp-0004V5-Qs
	for qemu-devel@archiver.kernel.org; Sun, 15 Dec 2019 04:52:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46536)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1igQZC-0003zm-0I
 for qemu-devel@nongnu.org; Sun, 15 Dec 2019 04:51:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1igQZ8-0004bZ-17
 for qemu-devel@nongnu.org; Sun, 15 Dec 2019 04:51:55 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:28239
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1igQZ7-0004Sg-FD
 for qemu-devel@nongnu.org; Sun, 15 Dec 2019 04:51:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576403512;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Nn4LKYU68iH+rth6Y64y0uJWlIedeSk7Ug0F1c/xxt4=;
 b=YFPJieUhF1uL0afiXsGIP+NIJXJEPoAAgYHKBdcr4ZqxTm7/UNaZ/GtpY5ObitxVjBME8i
 IOJxi+D6ieqp6F0uBNHRsFGL5aD2+SsTFc7XFC3HqxV+YXfFRnefEquUHRi7DgEip0TCUY
 5gpuBngbafbpPv0OhfeDgGayxDrLF00=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-358-uJ_vaiuWOo6LVMDhNlzXiQ-1; Sun, 15 Dec 2019 04:51:50 -0500
Received: by mail-qk1-f197.google.com with SMTP id c202so2637419qkg.4
 for <qemu-devel@nongnu.org>; Sun, 15 Dec 2019 01:51:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=JexjbKDRWd+HP8U/4Z49W6xylkN1jU7Pq3Ic5X0J99U=;
 b=Fo/1HTFPERKXKS5DWaVy7LO9Y4HSeA/NQmoVYnbllEvK9hJQzSH0Jo8SZXcuChMKmw
 D3CoQGV45d50GC5kB/4Wv3sts/Xwktm94ddn6o7Sgk23OZKT6YfbxIBlDsSMRQ5/Y17+
 iP3IUhLxBRC5Bzgk7hZY8meLnYV6zZviENtJYqm77w4vOPSK6qik6zSTstD8vHK3Jikg
 tjuCf10tkc7MsnVE6j/+6lh7E8gQpAQKZ6Gx7q5U+hutTWhkZKZmz0h9h1+Wmq7xX2/K
 SfI2zqhKF5QAxR2vbSfgn87jJk/YtmlS7Z/qyudI2zFZ+JsHerEuSYxSUaANGiOnkPFL
 3QuQ==
X-Gm-Message-State: APjAAAVoahC9XEEu/XS0NhADdG+3Mi0poLSgiiJKiHvm9ys/1RwO/PHV
 lJItW+CglH+TerkI4yTyv3jZ80Z0Bqzmk7aNDNXNj4M9q+5VTBGa8vYE6sxOGv6DaooUG7fhuRP
 v7LIL84Amzg3vFIM=
X-Received: by 2002:a0c:ea81:: with SMTP id d1mr21924152qvp.138.1576403509984; 
 Sun, 15 Dec 2019 01:51:49 -0800 (PST)
X-Google-Smtp-Source: APXvYqxfSUATHjxij/OAUPj2Tdys7QBapd5UqToJFM7KqoY6kKOmCY8gDA09+RZPd27hQyxK4UThdA==
X-Received: by 2002:a0c:ea81:: with SMTP id d1mr21924140qvp.138.1576403509804; 
 Sun, 15 Dec 2019 01:51:49 -0800 (PST)
Received: from redhat.com (bzq-79-181-48-215.red.bezeqint.net. [79.181.48.215])
 by smtp.gmail.com with ESMTPSA id h34sm5557924qtc.62.2019.12.15.01.51.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Dec 2019 01:51:49 -0800 (PST)
Date: Sun, 15 Dec 2019 04:51:42 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH 0/8] Simplify memory_region_add_subregion_overlap(...,
 priority=0)
Message-ID: <20191215044759-mutt-send-email-mst@kernel.org>
References: <20191214155614.19004-1-philmd@redhat.com>
 <CAFEAcA_QZtU9X4fxZk2oWAkN-zxXdQZejrSKZbDxPKLMwdFWgw@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_QZtU9X4fxZk2oWAkN-zxXdQZejrSKZbDxPKLMwdFWgw@mail.gmail.com>
X-MC-Unique: uJ_vaiuWOo6LVMDhNlzXiQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Cc: Paul Burton <pburton@wavecomp.com>,
 Alistair Francis <alistair@alistair23.me>,
 Eduardo Habkost <ehabkost@redhat.com>, kvm-devel <kvm@vger.kernel.org>,
 Marcelo Tosatti <mtosatti@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 Alex Williamson <alex.williamson@redhat.com>, qemu-arm <qemu-arm@nongnu.org>,
 Joel Stanley <joel@jms.id.au>, Aleksandar Markovic <amarkovic@wavecomp.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, Dec 14, 2019 at 04:28:08PM +0000, Peter Maydell wrote:
> (It doesn't actually assert that it doesn't
> overlap because we have some legacy uses, notably
> in the x86 PC machines, which do overlap without using
> the right function, which we've never tried to tidy up.)

It's not exactly legacy uses.

To be more exact, the way the non overlap versions
are *used* is to mean "I don't care what happens when they overlap"
as opposed to "will never overlap".

There are lots of regions where guest can make things overlapping
but doesn't, e.g. PCI BARs can be programmed to overlap
almost anything.

What happens on real hardware if you then access one of
the BARs is undefined, but programming itself is harmless.
That's why we can't assert.

--=20
MST


