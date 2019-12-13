Return-Path: <SRS0=VaDC=2D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DB07C00454
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2019 21:28:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E302521655
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2019 21:28:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Eo4vaZvZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E302521655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51452 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifoDF-0007HT-Cy
	for qemu-devel@archiver.kernel.org; Fri, 13 Dec 2019 11:54:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33553)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1ifo6S-0000hS-1p
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 11:47:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1ifo6N-0006cj-IU
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 11:47:40 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:29208
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1ifo6M-0006at-OK
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 11:47:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576255658;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=u59+uMKkDaHRCWZubKtqahmfKg0NMvg9oSlaElre/Ac=;
 b=Eo4vaZvZ2Mm8XPJ4nyONDQoiYWtSqPV0znvuqr9uYNh8XnSyIXzsU9rEIR5tsr3Pmi7xSz
 366ARR06n7UiHE51iaMlT/8EsL8F8Rb3/7qShMc2t784DR+1+T+xSHyp1aX+yu8o8gw1s5
 PaI/b/3QDIag1cDIXSBsyZ36zy16nC0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-91-glErBQeUNqK6-R6hUyroCg-1; Fri, 13 Dec 2019 11:47:32 -0500
Received: by mail-wm1-f69.google.com with SMTP id i17so66711wmd.1
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2019 08:47:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=xx4QpyhPJ7ddFApM5tN1aOYUoAAOoJoWqAv5YuUSmrQ=;
 b=Y2WK6LlIlgrgvdl1ntCVLgF3vfoRf730Fp6vYuP0iDN6DFj0LxObMi0suLs7jnO5tK
 J8HDLeQsf/+XkoThDLPnvwdnFmmHVasXtJ58TFJdGtGyswjKxS8Z5/NqEH5N6w8rr48V
 aC5Q5P+Tyh1Xm99MLJNneWSsQvu+67PWubFI2AT47R2s3WOwzkmf0KQ2scj2zqn4KmhD
 xC3iYXIdsfDb7YV5XDdDFdilYZeU6Qb3DHZyVKKfndxgTPpA06uGWXIJt7XfvbRDpvkx
 Fcy0pGirZ9h1O66ru4I7BBQp9Y+v6QInz99lbLoC5TRX1b2QkER4fi6fvfyUUlD/5urG
 dkAA==
X-Gm-Message-State: APjAAAU2Xmf+LQ6EkEqZC3gh2mDLl9F0JsdYIw6CQIXTD6xLTMpSRAc4
 HnnGq+e8vf4el9DdVVOudV8HdYwuUPN6/y3OuDxWJhtmjncwVv/jHvX+S7t5KyjH9QxR/w0YIme
 W5NIiLPaeF6/4TCg=
X-Received: by 2002:a05:600c:224d:: with SMTP id
 a13mr14931582wmm.57.1576255651299; 
 Fri, 13 Dec 2019 08:47:31 -0800 (PST)
X-Google-Smtp-Source: APXvYqzyANQJHgFGh+Kl0t/Tp4kzuWcPKmbHesl5SsB4LGdPrxk9Inysuhlbrs/E4yJYrUC92LmqzA==
X-Received: by 2002:a05:600c:224d:: with SMTP id
 a13mr14931547wmm.57.1576255651048; 
 Fri, 13 Dec 2019 08:47:31 -0800 (PST)
Received: from [192.168.1.35] (34.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.34])
 by smtp.gmail.com with ESMTPSA id p17sm10589868wrx.20.2019.12.13.08.47.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Dec 2019 08:47:30 -0800 (PST)
Subject: Re: [PATCH 12/12] hw/i386/pc: Move PC-machine specific declarations
 to 'pc_internal.h'
To: qemu-devel@nongnu.org
References: <20191213161753.8051-1-philmd@redhat.com>
 <20191213161753.8051-13-philmd@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <d9792ff4-bada-fbb9-301d-aeb19826235c@redhat.com>
Date: Fri, 13 Dec 2019 17:47:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191213161753.8051-13-philmd@redhat.com>
Content-Language: en-US
X-MC-Unique: glErBQeUNqK6-R6hUyroCg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Stefano Stabellini <sstabellini@kernel.org>, Sergio Lopez <slp@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, kvm@vger.kernel.org,
 Paul Durrant <paul@xen.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, xen-devel@lists.xenproject.org,
 Anthony Perard <anthony.perard@citrix.com>,
 Igor Mammedov <imammedo@redhat.com>, qemu-block@nongnu.org,
 John Snow <jsnow@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/13/19 5:17 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> Historically, QEMU started with only one X86 machine: the PC.
> The 'hw/i386/pc.h' header was used to store all X86 and PC
> declarations. Since we have now multiple machines based on the
> X86 architecture, move the PC-specific declarations in a new
> header.
> We use 'internal' in the name to explicit this header is restricted
> to the X86 architecture. Other architecture can not access it.
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
> Maybe name it 'pc_machine.h'?

I forgot to describe here (and in the cover), what's follow after this=20
patch.

Patch #13 moves PCMachineClass to

If you ignore PCMachineState, "hw/i386/pc.h" now only contains 76 lines,=20
and it is easier to see what is PC machine specific, what is X86=20
specific, and what is device generic (not X86 related at all):

- GSI is common to X86 (Paolo sent [3], [6])
- IOAPIC is common to X86
- i8259 is multiarch (Paolo [2])
- PCI_HOST definitions and pc_pci_hole64_start() are X86
- pc_machine_is_smm_enabled() is X86 (Paolo sent [5])
- hpet
- tsc (Paolo sent [3])
- 3 more functions

So we can move half of this file to "pc_internal.h" and the other to

One problem is the Q35 MCH north bridge which directly sets the PCI=20
PCMachineState->bus in q35_host_realize(). This seems a QOM violation=20
and is probably easily fixable.

Maybe I can apply Paolo's patches instead of this #12, move X86-generic=20
declarations to "hw/i386/x86.h", and directly git-move what's left of=20
"hw/i386/pc.h" to "pc_internal.h".

[3] https://www.mail-archive.com/qemu-devel@nongnu.org/msg664627.html
[2] https://www.mail-archive.com/qemu-devel@nongnu.org/msg664765.html
[5] https://www.mail-archive.com/qemu-devel@nongnu.org/msg664754.html
[6] https://www.mail-archive.com/qemu-devel@nongnu.org/msg664766.html

> ---
>   hw/i386/pc_internal.h | 144 ++++++++++++++++++++++++++++++++++++++++++
>   include/hw/i386/pc.h  | 128 -------------------------------------
>   hw/i386/acpi-build.c  |   1 +
>   hw/i386/pc.c          |   1 +
>   hw/i386/pc_piix.c     |   1 +
>   hw/i386/pc_q35.c      |   1 +
>   hw/i386/pc_sysfw.c    |   1 +
>   hw/i386/xen/xen-hvm.c |   1 +
>   8 files changed, 150 insertions(+), 128 deletions(-)
>   create mode 100644 hw/i386/pc_internal.h


