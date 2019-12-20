Return-Path: <SRS0=uEni=2K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9142DC43603
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 15:16:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5DB9B2146E
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 15:16:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OJkC4TKD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DB9B2146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57880 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iiK0u-0004d2-K5
	for qemu-devel@archiver.kernel.org; Fri, 20 Dec 2019 10:16:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42040)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@gmail.com>) id 1iiK04-0003yP-Gk
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 10:15:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@gmail.com>) id 1iiK03-00037A-A0
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 10:15:32 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:51426)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
 id 1iiK03-00035l-2w
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 10:15:31 -0500
Received: by mail-wm1-x341.google.com with SMTP id d73so9303224wmd.1
 for <qemu-devel@nongnu.org>; Fri, 20 Dec 2019 07:15:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=ket7bWKPS1W1G4FyozJZdlTL1x2xkQFZpPKjbQvXn5Q=;
 b=OJkC4TKDv/vzBhp5yS7rwRlgFzexLm0sYgbKLHLaw9jsvjvAJbn4e9wQQdKuYpqNqp
 1sLetK9OKSmh77ZKfqYpBWa1fk7vSFGl92MnXc0aedG5fKhLd3D8l5gY24zTpttVXKK3
 ejmH4LCmy4zf0Rl9RGWyqqJt7ttLCQQd91H7r1Rs2cBvRK03gzeZw/aG6MsERr3TnRdu
 xy7Pv28hmRoXAi1ffLvUQNx1r7pSHcBzeGU/wqyI+XG7mH2gJFfHeZ8LlDr/ccgcmexW
 UkJ5+nTGfiXueFuTS3kQSBtrCUOli4sZCfaKy4a1xMqRzcgnBKQC/mmTNeeDiVnBcpGk
 IHHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=ket7bWKPS1W1G4FyozJZdlTL1x2xkQFZpPKjbQvXn5Q=;
 b=M1ul5ugfCWGnVayjGq6qKup20cdD222UZnmxqk0gyWwRSkW+XKH8DGF99OiiJZ4IIk
 digV4ag0IomqU3ff5AmPIVdsQMAbcqam4YWWTVGNcWdvAL0VwOapSK5QWRFxZcMUWyry
 nI3lOItKBBkIQTNQMxC/xt/E573VhuBTZFyTpKQD4Ggj5vmuwgSh/pIk51VQA/emUboQ
 5gfj5gJuO6p1/a52HmUVe1hoqgxMaJwSFHYmqSYDokxQdOL5F3HUnD/tqe2uree+22j4
 O3RRkDw4S7NRLW4XaBByhVzb15nXtvrFIpLeG849NI6flFVt1//la7zdoP/MPLbYRp/3
 nFOQ==
X-Gm-Message-State: APjAAAVyNLNcO89SRxk+NTlZbl3BjiexEAu0P5xtLZhRpYtFsG2DrzQq
 MugV/IZ5w4GcC8eKl+W5zOkiImvRpvCeubx1Gl0=
X-Google-Smtp-Source: APXvYqyLEDlqZq+3TwdlTz0TnuIXyongcBV/H5n2yhjuU1df51C/NMDkTV1zYR1u8SBpOTftyn/pi9866hE4jdvxk7U=
X-Received: by 2002:a7b:c7d4:: with SMTP id z20mr18305017wmk.42.1576854929912; 
 Fri, 20 Dec 2019 07:15:29 -0800 (PST)
MIME-Version: 1.0
References: <20191219180205.25191-1-felipe@nutanix.com>
In-Reply-To: <20191219180205.25191-1-felipe@nutanix.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Fri, 20 Dec 2019 19:15:17 +0400
Message-ID: <CAJ+F1C+YmQFnMmWrJOZpKrqp9pEzUqLF7yP-yB2hwsz6h3L3cA@mail.gmail.com>
Subject: Re: [PATCH v4 0/4] Improve default object property_add uint helpers
To: Felipe Franciosi <felipe@nutanix.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, Alexey Kardashevskiy <aik@ozlabs.ru>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Markus Armbruster <armbru@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Phillipe Mathieu-Daude <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi

On Thu, Dec 19, 2019 at 10:02 PM Felipe Franciosi <felipe@nutanix.com> wrot=
e:
>
> This improves the family of object_property_add_uintXX_ptr helpers by ena=
bling
> a default getter/setter only when desired. To prevent an API behavioural =
change
> (from clients that already used these helpers and did not want a setter),=
 we
> add a OBJ_PROP_FLAG_READ flag that allow clients to only have a getter. P=
atch 1
> enhances the API and modify current users.
>
> While modifying the clients of the API, a couple of improvement opportuni=
ties
> were observed in ich9. These were added in separate patches (2 and 3).
>
> Patch 3 cleans up a lot of existing code by moving various objects to the
> enhanced API. Previously, those objects had their own getters/setters tha=
t only
> updated the values without further checks. Some of them actually lacked a=
 check
> for setting overflows, which could have resulted in undesired values bein=
g set.
> The new default setters include a check for that, not updating the values=
 in
> case of errors (and propagating them). If they did not provide an error
> pointer, then that behaviour was maintained.
>
> Felipe Franciosi (4):
>   qom/object: enable setter for uint types
>   ich9: fix getter type for sci_int property
>   ich9: Simplify ich9_lpc_initfn
>   qom/object: Use common get/set uint helpers
>
>  hw/acpi/ich9.c       |  99 ++------------------
>  hw/acpi/pcihp.c      |   7 +-
>  hw/acpi/piix4.c      |  12 +--
>  hw/isa/lpc_ich9.c    |  27 ++----
>  hw/misc/edu.c        |  13 +--
>  hw/pci-host/q35.c    |  14 +--
>  hw/ppc/spapr.c       |  18 +---
>  hw/ppc/spapr_drc.c   |   3 +-
>  include/qom/object.h |  44 +++++++--
>  memory.c             |  15 +--
>  qom/object.c         | 216 ++++++++++++++++++++++++++++++++++++++-----
>  target/arm/cpu.c     |  22 +----
>  target/i386/sev.c    | 106 ++-------------------
>  ui/console.c         |   4 +-
>  14 files changed, 282 insertions(+), 318 deletions(-)

It conflicts with some recent changes, so you'll need to send a new
version, but that one looks good to me:
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Paolo, is it going through your queue?

>
> --
> 2.20.1
>
> Changelog:
> v1->v2:
> - Update sci_int directly instead of using stack variable
> - Defining an enhanced ObjectPropertyFlags instead of just 'readonly'
> - Erroring out directly (instead of using gotos) on default setters
> - Retaining lack of errp passing when it wasn't there
> v2->v3:
> - Rename flags _RD to _READ and _WR to _WRITE
> - Add a convenience _READWRITE flag
> - Drop the usage of UL in the bit flag definitions
> v3->v4:
> - Drop changes to hw/vfio/pci-quirks.c



--=20
Marc-Andr=C3=A9 Lureau

