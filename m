Return-Path: <SRS0=brme=YQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29F76CA9EB9
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 19:10:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E9A572086D
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 19:10:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pVX0d3de"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9A572086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44512 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNM1b-0000DA-Nm
	for qemu-devel@archiver.kernel.org; Wed, 23 Oct 2019 15:10:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48086)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <estebanbosse@gmail.com>) id 1iNLnx-0006UY-6q
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 14:56:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <estebanbosse@gmail.com>) id 1iNLnw-0003OM-86
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 14:56:21 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:43429)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <estebanbosse@gmail.com>)
 id 1iNLnv-0003Ny-WB
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 14:56:20 -0400
Received: by mail-wr1-x442.google.com with SMTP id c2so18020347wrr.10
 for <qemu-devel@nongnu.org>; Wed, 23 Oct 2019 11:56:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=message-id:subject:from:to:cc:date:in-reply-to:references
 :user-agent:mime-version:content-transfer-encoding;
 bh=WEPGtQ7gGK6XQ5/vOjRhCH5V74QEjKYZ9fIob6AHkvw=;
 b=pVX0d3desBcFd+MshlNCdENKlANRYrAhLZjz8edGPl6MGICWEej5OiNU0c/o9iCRYV
 C3XZEGpGnpUNivgGhzSvlKtNP3T5nppDhq9XuMouDSOkS2n0iwmX55oqkHi4pYqpKk5l
 cpwoFobZJDVzN55RnbB0i7q6nL/4b7SztcOCaUqV+zXZEa6wcUQntTBmHAhkHxInicqA
 NG3oKejiJ4Y0Yd5CiLbL5i0YTVr+HnUyyXWiObxkvuTVbLlpekGaJ2kAKsx9tbECZQbr
 dZJci6tL+R/sHKA7ARDG01229IfuJbGn0+jt86pQuEvDGQ2oFZgz/oJXdHIUwuKuOhcN
 0x0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
 :references:user-agent:mime-version:content-transfer-encoding;
 bh=WEPGtQ7gGK6XQ5/vOjRhCH5V74QEjKYZ9fIob6AHkvw=;
 b=pNv6Xc4aloWC/pKBGFmx5VF8UIkqYsqQGjI4hlWcDsPPa34o5fJmJ527vNMxMxy2tK
 4loZ++/xsSdjw9DVhOm5jpSXSZoieMiy8KtFQTgBDgMJiSuCy1FJE9Ly7RXn98XApny3
 t74v+ZOchfPxjT7CuNjmmRQe/WJR97Ytvo6Cf4cl5pe2ApKn+gs/gYISYh2g8WZtsAoW
 7X5L/3aX89LM7uXM/TGzCoi2Fh9o6txB/1A81Fkcpftdy2UWncSpMDHMf8UDGMU8yslw
 v7FQYXdiFozqRULlpZowwyrm8yNwO/XjAH9TVeb6Jb6XBsM6Xq2rjtmSmTE6lKMkxfbT
 WNeg==
X-Gm-Message-State: APjAAAUp27ZkXuPrWhwmvpNDrOLHutco/zzCOte4YezAZDhIV/n1RF1H
 rJml+3uo2+TkHvCTEEBvGpU=
X-Google-Smtp-Source: APXvYqwQgrx/ATVbGWn8BNneqNMlEXZy7+s3aXLwF/SI7HHAqvlgzrmxjbV51PBunpJS11xYsZw8NA==
X-Received: by 2002:a05:6000:142:: with SMTP id r2mr225991wrx.30.1571856977834; 
 Wed, 23 Oct 2019 11:56:17 -0700 (PDT)
Received: from ?IPv6:2a01:c23:6030:5100:7e6a:c70f:e991:63a?
 ([2a01:c23:6030:5100:7e6a:c70f:e991:63a])
 by smtp.gmail.com with ESMTPSA id u21sm64034wmu.27.2019.10.23.11.56.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Oct 2019 11:56:17 -0700 (PDT)
Message-ID: <a30454177a5146c4e11fc5463aabbe7a075e0e15.camel@gmail.com>
Subject: Re: [PATCH v2 03/20] piix4: Add a i8259 Interrupt Controller as
 specified in datasheet
From: Esteban Bosse <estebanbosse@gmail.com>
To: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 23 Oct 2019 20:52:07 +0200
In-Reply-To: <CAFEAcA-FesfcimTutrYwZFdB93mEE42ha7X93jDqAW7CFUd+0w@mail.gmail.com>
References: <20191018134754.16362-1-philmd@redhat.com>
 <20191018134754.16362-4-philmd@redhat.com>
 <b1255a22fe4409244f7a68887137fbe43b71a08d.camel@gmail.com>
 <CAFEAcA-FesfcimTutrYwZFdB93mEE42ha7X93jDqAW7CFUd+0w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5-1.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
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
Cc: Stefano Stabellini <sstabellini@kernel.org>,
 Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Paul Durrant <paul@xen.org>, QEMU Developers <qemu-devel@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?ISO-8859-1?Q?Herv=E9?= Poussineau <hpoussin@reactos.org>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Anthony Perard <anthony.perard@citrix.com>,
 "open list:X86" <xen-devel@lists.xenproject.org>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

El mar, 22-10-2019 a las 10:42 +0100, Peter Maydell escribió:
> On Tue, 22 Oct 2019 at 09:52, Esteban Bosse <estebanbosse@gmail.com>
> wrote:
> > El vie, 18-10-2019 a las 15:47 +0200, Philippe Mathieu-Daudé
> > escribió:
> > > +static void piix4_request_i8259_irq(void *opaque, int irq, int
> > > level)
> > > +{
> > > +    PIIX4State *s = opaque;
> > > +    qemu_set_irq(s->cpu_intr, level);
> > > +}
> > I would like to understand why in `PIIX4State *s = opaque;` its not
> > necessary a cast or a object macro magic.
> > Something like:
> > PIIX4State *s = (PIIX4State*)opaque;
> > PIIX4State *s = PIIX4STATE(opaque);
> 
> The simple answer to "why don't we need a cast" is
> "because the type of 'opaque' is 'void *', and in C there is
> no need to explicitly cast a 'void *' as it will be implicitly
> converted to the pointer type of the destination". (This is
> different from C++, which does require an explicit cast for void*.)
> 
> For QOM types, QEMU conventionally uses the QOM casting
> macro to convert a pointer-to-instance to
> pointer-to-instance-of-parent-class and vice versa.
> In some places, like this one, what we have is just a
> void* representing opaque data having been passed around.
> You could use the QOM cast macro here, which would add
> a bit of extra type-safety, but the project doesn't have
> a strong convention here on whether to do so or not, so
> you'll often see the just-assignment code.
> 
> thanks
> -- PMM

Thank you very much for your detailed explanation :).


