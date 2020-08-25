Return-Path: <SRS0=2GMi=CD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00B3BC433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 12:38:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE6A520738
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 12:38:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IX+6cabU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE6A520738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41226 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAYE5-0000UL-Sr
	for qemu-devel@archiver.kernel.org; Tue, 25 Aug 2020 08:38:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35608)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1kAYDR-00083p-Hi
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 08:38:17 -0400
Received: from mail-yb1-xb44.google.com ([2607:f8b0:4864:20::b44]:41024)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1kAYDP-00075e-QT
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 08:38:17 -0400
Received: by mail-yb1-xb44.google.com with SMTP id s195so7052035ybc.8
 for <qemu-devel@nongnu.org>; Tue, 25 Aug 2020 05:38:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=pR+YjLn46ve32NBEoUU27TmvE7yfWLcgDR5U99il76I=;
 b=IX+6cabUJD65wDlJDo6Z55BIC514UMKYi/PjWvWixO+TujYCF0qBVxnEduUbl8GRqj
 pW3I+zycZLgbJw98b+/s8tIKdvWrf6PeIYaW73yFY+3tnFn1tcdJE6e1kailbxBeyoUM
 hYqVabbN4udQisttwG7TdS+XcKmL3M+GEdNZIEZ1uoLajChuXJgTSEk3ydS9LgS9Lx5J
 szMu6MmaQuVw7aO7jY9E5Wh8977EzJVtraYTsOI5nLSj1eB2bPFp+zmq9SWnmoBiAOXB
 NwB0YBWXXVBXpmk6vc4Qd2ZBjChGziDMEcuSiDDWXVfr6f16s4QX8NctNWr4d4hhsZrO
 w7Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=pR+YjLn46ve32NBEoUU27TmvE7yfWLcgDR5U99il76I=;
 b=qiNyaLyKhFmKRv5g9u8rIr9PoW4TnU+e61PbN70HEyuqVf8W4e4Ig7NcvhHli+pSli
 no07y8/D1jIXPC7OxEOd1vfVs4duSP0+G188XXkoMqUVLRdDpI3X7Gm/EagjMtlqNnFA
 pCaVF9TGiDNSMyiJtJMHv47WSZpelETWjZvCL7TrPiU+9e1vJPFze1Bnvi1dbaKPktdS
 D3aWNvpNSJss/j44tlIRFB6G+10uIJfIjHoa4ov6DylCrl+3kM+0r3d7i5z2XbzB4SWJ
 Z0TPjh+mZf8zVzYj76nUQAW7qIImMou6va9wygkV+GiJYjjUTA4lUjpLTHlez8d4XIPe
 31wg==
X-Gm-Message-State: AOAM532B1l7Ewpnvb6oIIeqOrKsux5hRGSMAxaax3MktEOzNaO0qAigl
 Tjq3u3UlIuFtc3dIGOyzE1K1/KXUparO/EM1fII=
X-Google-Smtp-Source: ABdhPJy3SSQIkxncCpGvwgQ6t/7PtC5o8K9UTQSXb7o6kfE/T6j6g1kx01G3H0uwzE5Z/KuJK6jM3/3ThU87OfFUu4s=
X-Received: by 2002:a25:f20d:: with SMTP id i13mr13648354ybe.152.1598359094813; 
 Tue, 25 Aug 2020 05:38:14 -0700 (PDT)
MIME-Version: 1.0
References: <20200813222625.243136-1-ehabkost@redhat.com>
 <20200813222625.243136-9-ehabkost@redhat.com>
 <5a14f92e-139d-38e5-5ffe-c77636c090be@amsat.org>
 <CAEUhbmX=7+ke100stoVFq7A++Lhy-7zoggB=Of3KrWPTf6C0gA@mail.gmail.com>
 <CAKmqyKOLqv7EdkON2foA+VT7CjAH9Z8Ko2y4pnr+TsxisZqKpw@mail.gmail.com>
In-Reply-To: <CAKmqyKOLqv7EdkON2foA+VT7CjAH9Z8Ko2y4pnr+TsxisZqKpw@mail.gmail.com>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Tue, 25 Aug 2020 20:38:03 +0800
Message-ID: <CAEUhbmVNfxmCcoSVnQkuFUkcwN2Aj2vkMY32JaxhUfXD5Z=Qyg@mail.gmail.com>
Subject: Re: [PATCH 08/41] opentitan: Rename memmap enum constants
To: Alistair Francis <alistair23@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b44;
 envelope-from=bmeng.cn@gmail.com; helo=mail-yb1-xb44.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Alistair,

On Sat, Aug 22, 2020 at 3:04 AM Alistair Francis <alistair23@gmail.com> wro=
te:
>
> On Mon, Aug 17, 2020 at 2:53 AM Bin Meng <bmeng.cn@gmail.com> wrote:
> >
> > On Sat, Aug 15, 2020 at 1:56 AM Philippe Mathieu-Daud=C3=A9 <f4bug@amsa=
t.org> wrote:
> > >
> > > On 8/14/20 12:25 AM, Eduardo Habkost wrote:
> > > > Some of the enum constant names conflict with the QOM type check
> > > > macros.  This needs to be addressed to allow us to transform the
> > > > QOM type check macros into functions generated by
> > > > OBJECT_DECLARE_TYPE().
> > > >
> > > > Rename all the constants to IBEX_DEV_*, to avoid conflicts.
> > > >
> > > > Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> > > > ---
> > > >  include/hw/riscv/opentitan.h | 38 ++++++++--------
> > > >  hw/riscv/opentitan.c         | 84 ++++++++++++++++++--------------=
----
> > > >  2 files changed, 61 insertions(+), 61 deletions(-)
> > > >
> > > > diff --git a/include/hw/riscv/opentitan.h b/include/hw/riscv/openti=
tan.h
> > > > index 8f29b9cbbf..835a80f896 100644
> > > > --- a/include/hw/riscv/opentitan.h
> > > > +++ b/include/hw/riscv/opentitan.h
> > > > @@ -49,25 +49,25 @@ typedef struct OpenTitanState {
> > > >  } OpenTitanState;
> > > >
> > > >  enum {
> > > > -    IBEX_ROM,
> > > > -    IBEX_RAM,
> > > > -    IBEX_FLASH,
> > > > -    IBEX_UART,
> > > > -    IBEX_GPIO,
> > > > -    IBEX_SPI,
> > > > -    IBEX_FLASH_CTRL,
> > > > -    IBEX_RV_TIMER,
> > > > -    IBEX_AES,
> > > > -    IBEX_HMAC,
> > > > -    IBEX_PLIC,
> > > > -    IBEX_PWRMGR,
> > > > -    IBEX_RSTMGR,
> > > > -    IBEX_CLKMGR,
> > > > -    IBEX_PINMUX,
> > > > -    IBEX_ALERT_HANDLER,
> > > > -    IBEX_NMI_GEN,
> > > > -    IBEX_USBDEV,
> > > > -    IBEX_PADCTRL,
> > > > +    IBEX_DEV_ROM,
> > > > +    IBEX_DEV_RAM,
> > > > +    IBEX_DEV_FLASH,
> > > > +    IBEX_DEV_UART,
> > > > +    IBEX_DEV_GPIO,
> > > > +    IBEX_DEV_SPI,
> > > > +    IBEX_DEV_FLASH_CTRL,
> > > > +    IBEX_DEV_RV_TIMER,
> > > > +    IBEX_DEV_AES,
> > > > +    IBEX_DEV_HMAC,
> > > > +    IBEX_DEV_PLIC,
> > > > +    IBEX_DEV_PWRMGR,
> > > > +    IBEX_DEV_RSTMGR,
> > > > +    IBEX_DEV_CLKMGR,
> > > > +    IBEX_DEV_PINMUX,
> > > > +    IBEX_DEV_ALERT_HANDLER,
> > > > +    IBEX_DEV_NMI_GEN,
> > > > +    IBEX_DEV_USBDEV,
> > > > +    IBEX_DEV_PADCTRL,
> > >
> > > Similarly, why is this enum in a public header and not local
> > > to opentitan.c, only place where it is used?
> > >
> >
> > I believe the reason is that opentitan.c implements both SoC and board
> > stuff. These enums are helpful to define SoC peripherals hence
> > technically another board that uses the same SoC may utilize these
> > macros.
> >
> > Unfortunately this is the case for all RISC-V boards so far. Should we
> > clean this up, for example, splitting SoC and board codes into 2
> > files?
>
> Yeah the hw/riscv directory is a bit of a mess. We need to look at
> moving non machine parts out (like sifive_uart for example) and then
> it's probably worth splitting SoC and machine. It does result in some
> extra files (some of which are very simple) but the current setup is
> pretty confusing.
>
> Are you volunteering Bin? Otherwise I can look at it.
>

Yes, I will be working on a series to clean hw/riscv directory.

Regards,
Bin

