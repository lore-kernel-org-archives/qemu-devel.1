Return-Path: <SRS0=QduX=3Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6D4FC3524D
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 13:42:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A6AA620730
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 13:42:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JS488xAw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6AA620730
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58718 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iyyTL-0001G2-Rh
	for qemu-devel@archiver.kernel.org; Tue, 04 Feb 2020 08:42:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40807)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@gmail.com>) id 1iyySi-0000nn-94
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 08:41:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@gmail.com>) id 1iyySg-0001m8-Sc
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 08:41:56 -0500
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:55976)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
 id 1iyySg-0001gk-MA
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 08:41:54 -0500
Received: by mail-wm1-x344.google.com with SMTP id q9so3336014wmj.5
 for <qemu-devel@nongnu.org>; Tue, 04 Feb 2020 05:41:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=KZ1yjvCkqv8EnscBB8sv9Blg0R/jIrNsPMibRGIXBrk=;
 b=JS488xAwj7FDHJoLCXC8Krj8SYCE+pNrSavOVaX33gS1UtMd9fv5o4TwGENiDWl1y+
 Kkhgv330H1WJ6ksQQXhPY6cxQd6jmkHx6Z/5YCcqScDnZfNlWqCUCJerPwI/Vw/2izna
 wLizZoi/IwsFGDXLEDXoHk/4xSRtazAWoZxC5JRnzDJA+I00tVcVaOBmC179wA0kXIUN
 /dvBtRX9m4N2d+Hgdj/8ZHgJqgzoVAlFLGN/C8vLaUropbBEch1E3bWnQAXJe+HH+nNY
 LFcdqHBXyQmf/IghwOYOYJvk/JGhCM2P0aFS38nhcpJRvdi90lyZCaC3m/aSDeXHVhHa
 tAzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=KZ1yjvCkqv8EnscBB8sv9Blg0R/jIrNsPMibRGIXBrk=;
 b=fIsOieK7LBTpRjL0UZdA0vbyTIRl1wvFAEDFJEJGcY+FlPIGVaUWLi1pABh6dWOUP+
 Zlt4iW1xLadeV49JgUjymhpVHnOxOAQ26xCdwNT/ixUBwV9WaW85uxeK8oCrF6GR0dOs
 PFCSB1+Zkwmf9YlAKB7sLXZEAPzw9ogwEqcF+GKfDdJHtUqr2Irp2qVzmy7bleRSGDfU
 8ZtRdU+CPNpfh7hM9xwTI+MdMiDR4ir+Yb63BSlPusnjZJSCOVamZQZkC3cZbMLxtExQ
 9jObkl8Dwnu3tNdPjjhSXKi9pxkvUjoCK/QogvlkUYJSVKFlcPF7C+coAE9BwSL3cNgH
 cWLw==
X-Gm-Message-State: APjAAAUIrTFExs7gSjL6iRrfLbh+5xdKJsHC6umsOkT9s/y5b5txS7Gr
 hz0wq76xCNM8/w7uyXsaE4uxnfChSELCHIsxiiI=
X-Google-Smtp-Source: APXvYqwbm5SnOhUE4FpxjmhuPbLEJk1GtWQpJNa9tOWB+uZ/E8znpQvt4lAhXUp+79U3m7YzTv4VjQcCwKvlQMJL57Y=
X-Received: by 2002:a7b:ce94:: with SMTP id q20mr6132560wmj.4.1580823713689;
 Tue, 04 Feb 2020 05:41:53 -0800 (PST)
MIME-Version: 1.0
References: <20200204131601.125677-1-felipe@nutanix.com>
In-Reply-To: <20200204131601.125677-1-felipe@nutanix.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 4 Feb 2020 14:41:41 +0100
Message-ID: <CAJ+F1CJLvKtSnFFurBUy4LcP+DqNTtqHd4oevJADfW8JEVuXXA@mail.gmail.com>
Subject: Re: [PATCH v6 0/4] Improve default object property_add uint helpers
To: Felipe Franciosi <felipe@nutanix.com>, Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
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
 QEMU <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Phillipe Mathieu-Daude <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi

On Tue, Feb 4, 2020 at 2:16 PM Felipe Franciosi <felipe@nutanix.com> wrote:
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
> Patch 4 cleans up a lot of existing code by moving various objects to the
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
>  include/qom/object.h |  48 ++++++++--
>  memory.c             |  15 +--
>  qom/object.c         | 212 ++++++++++++++++++++++++++++++++++++++-----
>  target/arm/cpu.c     |  22 +----
>  target/i386/sev.c    | 106 ++--------------------
>  ui/console.c         |   4 +-
>  14 files changed, 282 insertions(+), 318 deletions(-)

Series:
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Paolo, would you queue it?

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
> v4->v5:
> - Rebase on latest master
> - Available here: https://github.com/franciozzy/qemu/tree/autosetters
> v5->v6:
> - Fix build error introduced in rebase



--=20
Marc-Andr=C3=A9 Lureau

