Return-Path: <SRS0=yZS3=YK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5218CECE58E
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 15:58:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F8C021848
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 15:58:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DgOCllxV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F8C021848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51750 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iL8Au-0007P3-OV
	for qemu-devel@archiver.kernel.org; Thu, 17 Oct 2019 11:58:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52703)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iL7G7-000154-5E
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 11:00:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iL7G5-0004cX-K6
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 11:00:11 -0400
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:38637)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1iL7G5-0004c1-Dw
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 11:00:09 -0400
Received: by mail-oi1-x242.google.com with SMTP id k10so115079oij.5
 for <qemu-devel@nongnu.org>; Thu, 17 Oct 2019 08:00:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=M5Y5S4bU2xkOzKBGjT0DmAhs+QC4phjwSWTyUm/ZWo4=;
 b=DgOCllxVk+7vJLGmedLbu/nQL2Z9+Hb+ND/4SVae1h8tWWQueFNLYOMaAARFkLYL55
 jhsKA54/5Wdbg3bP/sDljVyiyxKJTN9R2TVC5S9WmL9eSYVpZR9AYgqUrlYDTVa6puKF
 g+b/FI5ZCfdy/f5eGnbfhqN/HR4c4ts9lGeG/IAOUSfzqxQTAJApkZ/e5jTpbJcA8RTH
 8bia4TLBp+W1pUYNuSKxv049R1VnDmGhw/SQMX7tpyuQqLO1RACt5nKxWyk2MqB4Wut6
 QnUAT2zueO5vXvcnBQDc+RoGJ3L9+p76BI4Xprpx82/R9AYLtT+QvT6MwB05EaYmooIn
 tsDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=M5Y5S4bU2xkOzKBGjT0DmAhs+QC4phjwSWTyUm/ZWo4=;
 b=UNWCHfkao6tOYozZf31V3KteScQBRUdQs/LvG1i5Jjv3PxpaybP41PMip8wl/R1uKS
 6LnmnpD2t6fwEInVkP8qG9zKCyq/fK1BK4ITCyyIwZaXmRI9Ffn0Bvo2NwOhmHGobGYR
 VuAGqWf/7rnyrpD3Hum4tf/wIIeIQpEsAfq8t7NAP5ESqyvqC0LWLE6jlfpI638HSVSf
 eo1p8OH5Ju1wySTiZRvoi/JFbTcwrvU9phl2FmleCezHzva8EhutSs8YY8OCxqE+B3jn
 GZMyFs5AOagpbsynZK5Wlf4jWHsA1jeiLqF/nvfKPpXLPqmh2GvDejtJLAZD+hU5K2t/
 LtrA==
X-Gm-Message-State: APjAAAV8ha41Bw+Mt9lWOtOYNy8vZ6NVJ7dvosWjZA9tQpDYEN4AHOz0
 kL3rpUAKl0Cb7aayanej8N6rjFh34OSAqxDFYFA=
X-Google-Smtp-Source: APXvYqwlhAh0sKvyLqI7nCmavqIbjFOtTsBOMv/I2tNto28moIFL1Cj0mLBEV4gsN+xS/ZGyiMAIMkRmYIn2cXd5uzY=
X-Received: by 2002:aca:4e56:: with SMTP id c83mr3618429oib.53.1571324408479; 
 Thu, 17 Oct 2019 08:00:08 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:340a:0:0:0:0:0 with HTTP; Thu, 17 Oct 2019 08:00:07
 -0700 (PDT)
In-Reply-To: <20191015162705.28087-4-philmd@redhat.com>
References: <20191015162705.28087-1-philmd@redhat.com>
 <20191015162705.28087-4-philmd@redhat.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Thu, 17 Oct 2019 17:00:07 +0200
Message-ID: <CAL1e-=isxvTctgthzP2Z-4ETKYSZ2P8KOee7-a6K6_LPppn6iw@mail.gmail.com>
Subject: Re: [PATCH 03/32] mc146818rtc: move structure to header file
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: multipart/alternative; boundary="00000000000031c31505951c791d"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::242
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
 Stefano Stabellini <sstabellini@kernel.org>,
 Eduardo Habkost <ehabkost@redhat.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>, Paul Durrant <paul@xen.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
 Anthony Perard <anthony.perard@citrix.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--00000000000031c31505951c791d
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tuesday, October 15, 2019, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.co=
m>
wrote:

> From: Herv=C3=A9 Poussineau <hpoussin@reactos.org>
>
> We are now able to embed a timer in another object.
>
> Acked-by: Michael S. Tsirkin <mst@redhat.com>
> Acked-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Herv=C3=A9 Poussineau <hpoussin@reactos.org>
> Message-Id: <20171216090228.28505-4-hpoussin@reactos.org>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  hw/timer/mc146818rtc.c         | 30 ------------------------------
>  include/hw/timer/mc146818rtc.h | 33 +++++++++++++++++++++++++++++++++
>  2 files changed, 33 insertions(+), 30 deletions(-)
>
>
Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>



> diff --git a/hw/timer/mc146818rtc.c b/hw/timer/mc146818rtc.c
> index 6cb378751b..e40b54e743 100644
> --- a/hw/timer/mc146818rtc.c
> +++ b/hw/timer/mc146818rtc.c
> @@ -71,36 +71,6 @@
>  #define RTC_CLOCK_RATE            32768
>  #define UIP_HOLD_LENGTH           (8 * NANOSECONDS_PER_SECOND / 32768)
>
> -#define MC146818_RTC(obj) OBJECT_CHECK(RTCState, (obj), TYPE_MC146818_RT=
C)
> -
> -typedef struct RTCState {
> -    ISADevice parent_obj;
> -
> -    MemoryRegion io;
> -    MemoryRegion coalesced_io;
> -    uint8_t cmos_data[128];
> -    uint8_t cmos_index;
> -    int32_t base_year;
> -    uint64_t base_rtc;
> -    uint64_t last_update;
> -    int64_t offset;
> -    qemu_irq irq;
> -    int it_shift;
> -    /* periodic timer */
> -    QEMUTimer *periodic_timer;
> -    int64_t next_periodic_time;
> -    /* update-ended timer */
> -    QEMUTimer *update_timer;
> -    uint64_t next_alarm_time;
> -    uint16_t irq_reinject_on_ack_count;
> -    uint32_t irq_coalesced;
> -    uint32_t period;
> -    QEMUTimer *coalesced_timer;
> -    LostTickPolicy lost_tick_policy;
> -    Notifier suspend_notifier;
> -    QLIST_ENTRY(RTCState) link;
> -} RTCState;
> -
>  static void rtc_set_time(RTCState *s);
>  static void rtc_update_time(RTCState *s);
>  static void rtc_set_cmos(RTCState *s, const struct tm *tm);
> diff --git a/include/hw/timer/mc146818rtc.h b/include/hw/timer/
> mc146818rtc.h
> index fe6ed63f71..0f1c886e5b 100644
> --- a/include/hw/timer/mc146818rtc.h
> +++ b/include/hw/timer/mc146818rtc.h
> @@ -1,10 +1,43 @@
>  #ifndef MC146818RTC_H
>  #define MC146818RTC_H
>
> +#include "qapi/qapi-types-misc.h"
> +#include "qemu/queue.h"
> +#include "qemu/timer.h"
>  #include "hw/isa/isa.h"
>  #include "hw/timer/mc146818rtc_regs.h"
>
>  #define TYPE_MC146818_RTC "mc146818rtc"
> +#define MC146818_RTC(obj) OBJECT_CHECK(RTCState, (obj), TYPE_MC146818_RT=
C)
> +
> +typedef struct RTCState {
> +    ISADevice parent_obj;
> +
> +    MemoryRegion io;
> +    MemoryRegion coalesced_io;
> +    uint8_t cmos_data[128];
> +    uint8_t cmos_index;
> +    int32_t base_year;
> +    uint64_t base_rtc;
> +    uint64_t last_update;
> +    int64_t offset;
> +    qemu_irq irq;
> +    int it_shift;
> +    /* periodic timer */
> +    QEMUTimer *periodic_timer;
> +    int64_t next_periodic_time;
> +    /* update-ended timer */
> +    QEMUTimer *update_timer;
> +    uint64_t next_alarm_time;
> +    uint16_t irq_reinject_on_ack_count;
> +    uint32_t irq_coalesced;
> +    uint32_t period;
> +    QEMUTimer *coalesced_timer;
> +    Notifier clock_reset_notifier;
> +    LostTickPolicy lost_tick_policy;
> +    Notifier suspend_notifier;
> +    QLIST_ENTRY(RTCState) link;
> +} RTCState;
>
>  ISADevice *mc146818_rtc_init(ISABus *bus, int base_year,
>                               qemu_irq intercept_irq);
> --
> 2.21.0
>
>
>

--00000000000031c31505951c791d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<br><br>On Tuesday, October 15, 2019, Philippe Mathieu-Daud=C3=A9 &lt;<a hr=
ef=3D"mailto:philmd@redhat.com">philmd@redhat.com</a>&gt; wrote:<br><blockq=
uote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc =
solid;padding-left:1ex">From: Herv=C3=A9 Poussineau &lt;<a href=3D"mailto:h=
poussin@reactos.org">hpoussin@reactos.org</a>&gt;<br>
<br>
We are now able to embed a timer in another object.<br>
<br>
Acked-by: Michael S. Tsirkin &lt;<a href=3D"mailto:mst@redhat.com">mst@redh=
at.com</a>&gt;<br>
Acked-by: Paolo Bonzini &lt;<a href=3D"mailto:pbonzini@redhat.com">pbonzini=
@redhat.com</a>&gt;<br>
Signed-off-by: Herv=C3=A9 Poussineau &lt;<a href=3D"mailto:hpoussin@reactos=
.org">hpoussin@reactos.org</a>&gt;<br>
Message-Id: &lt;<a href=3D"mailto:20171216090228.28505-4-hpoussin@reactos.o=
rg">20171216090228.28505-4-hpoussin@reactos.org</a>&gt;<br>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@red=
hat.com">philmd@redhat.com</a>&gt;<br>
---<br>
=C2=A0hw/timer/mc146818rtc.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 30 --------=
----------------------<br>
=C2=A0include/hw/timer/mc146818rtc.h | 33 ++++++++++++++++++++++++++++++<wb=
r>+++<br>
=C2=A02 files changed, 33 insertions(+), 30 deletions(-)<br>
<br></blockquote><div><br></div><div><div id=3D"cvcmsg_16dbfeb33c93ed97" cl=
ass=3D"yh  " style=3D"border-top-left-radius:0px;border-top-right-radius:0p=
x;margin-bottom:11px;overflow:visible"><div class=3D"Vh" id=3D"cvcfullmsg_1=
6dbfeb33c93ed97"><div id=3D"cvcmsgbod_16dbfeb33c93ed97" class=3D"aj"><div c=
lass=3D"Ni"><div class=3D"ni pi " dir=3D"ltr"><p dir=3D"ltr">Reviewed-by: A=
leksandar Markovic &lt;<a href=3D"mailto:amarkovic@wavecomp.com" target=3D"=
_blank">amarkovic@wavecomp.com</a>&gt;</p><div style=3D"clear:both"></div><=
/div><div style=3D"clear:both"></div><div><div class=3D"M j T b hc Aj S" ta=
bindex=3D"0"><div class=3D"V j hf"></div></div></div><div style=3D"clear:bo=
th"></div></div></div></div></div><div id=3D"cvcmsg_16dbfecd588da1f7" class=
=3D"yh" style=3D"margin-bottom:11px"><div class=3D"Vh" id=3D"cvcfullmsg_16d=
bfecd588da1f7"><div class=3D"M j Zi Mi  " tabindex=3D"0"><div id=3D"cvcrepl=
y_16dbfecd588da1f7" class=3D"M j T b hc xh S  " tabindex=3D"0"><div class=
=3D"V j td"></div></div></div></div></div></div><div><br></div><div>=C2=A0<=
/div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-le=
ft:1px #ccc solid;padding-left:1ex">
diff --git a/hw/timer/mc146818rtc.c b/hw/timer/mc146818rtc.c<br>
index 6cb378751b..e40b54e743 100644<br>
--- a/hw/timer/mc146818rtc.c<br>
+++ b/hw/timer/mc146818rtc.c<br>
@@ -71,36 +71,6 @@<br>
=C2=A0#define RTC_CLOCK_RATE=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 32768=
<br>
=C2=A0#define UIP_HOLD_LENGTH=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(8 * =
NANOSECONDS_PER_SECOND / 32768)<br>
<br>
-#define MC146818_RTC(obj) OBJECT_CHECK(RTCState, (obj), TYPE_MC146818_RTC)=
<br>
-<br>
-typedef struct RTCState {<br>
-=C2=A0 =C2=A0 ISADevice parent_obj;<br>
-<br>
-=C2=A0 =C2=A0 MemoryRegion io;<br>
-=C2=A0 =C2=A0 MemoryRegion coalesced_io;<br>
-=C2=A0 =C2=A0 uint8_t cmos_data[128];<br>
-=C2=A0 =C2=A0 uint8_t cmos_index;<br>
-=C2=A0 =C2=A0 int32_t base_year;<br>
-=C2=A0 =C2=A0 uint64_t base_rtc;<br>
-=C2=A0 =C2=A0 uint64_t last_update;<br>
-=C2=A0 =C2=A0 int64_t offset;<br>
-=C2=A0 =C2=A0 qemu_irq irq;<br>
-=C2=A0 =C2=A0 int it_shift;<br>
-=C2=A0 =C2=A0 /* periodic timer */<br>
-=C2=A0 =C2=A0 QEMUTimer *periodic_timer;<br>
-=C2=A0 =C2=A0 int64_t next_periodic_time;<br>
-=C2=A0 =C2=A0 /* update-ended timer */<br>
-=C2=A0 =C2=A0 QEMUTimer *update_timer;<br>
-=C2=A0 =C2=A0 uint64_t next_alarm_time;<br>
-=C2=A0 =C2=A0 uint16_t irq_reinject_on_ack_count;<br>
-=C2=A0 =C2=A0 uint32_t irq_coalesced;<br>
-=C2=A0 =C2=A0 uint32_t period;<br>
-=C2=A0 =C2=A0 QEMUTimer *coalesced_timer;<br>
-=C2=A0 =C2=A0 LostTickPolicy lost_tick_policy;<br>
-=C2=A0 =C2=A0 Notifier suspend_notifier;<br>
-=C2=A0 =C2=A0 QLIST_ENTRY(RTCState) link;<br>
-} RTCState;<br>
-<br>
=C2=A0static void rtc_set_time(RTCState *s);<br>
=C2=A0static void rtc_update_time(RTCState *s);<br>
=C2=A0static void rtc_set_cmos(RTCState *s, const struct tm *tm);<br>
diff --git a/include/hw/timer/<wbr>mc146818rtc.h b/include/hw/timer/<wbr>mc=
146818rtc.h<br>
index fe6ed63f71..0f1c886e5b 100644<br>
--- a/include/hw/timer/<wbr>mc146818rtc.h<br>
+++ b/include/hw/timer/<wbr>mc146818rtc.h<br>
@@ -1,10 +1,43 @@<br>
=C2=A0#ifndef MC146818RTC_H<br>
=C2=A0#define MC146818RTC_H<br>
<br>
+#include &quot;qapi/qapi-types-misc.h&quot;<br>
+#include &quot;qemu/queue.h&quot;<br>
+#include &quot;qemu/timer.h&quot;<br>
=C2=A0#include &quot;hw/isa/isa.h&quot;<br>
=C2=A0#include &quot;hw/timer/mc146818rtc_regs.h&quot;<br>
<br>
=C2=A0#define TYPE_MC146818_RTC &quot;mc146818rtc&quot;<br>
+#define MC146818_RTC(obj) OBJECT_CHECK(RTCState, (obj), TYPE_MC146818_RTC)=
<br>
+<br>
+typedef struct RTCState {<br>
+=C2=A0 =C2=A0 ISADevice parent_obj;<br>
+<br>
+=C2=A0 =C2=A0 MemoryRegion io;<br>
+=C2=A0 =C2=A0 MemoryRegion coalesced_io;<br>
+=C2=A0 =C2=A0 uint8_t cmos_data[128];<br>
+=C2=A0 =C2=A0 uint8_t cmos_index;<br>
+=C2=A0 =C2=A0 int32_t base_year;<br>
+=C2=A0 =C2=A0 uint64_t base_rtc;<br>
+=C2=A0 =C2=A0 uint64_t last_update;<br>
+=C2=A0 =C2=A0 int64_t offset;<br>
+=C2=A0 =C2=A0 qemu_irq irq;<br>
+=C2=A0 =C2=A0 int it_shift;<br>
+=C2=A0 =C2=A0 /* periodic timer */<br>
+=C2=A0 =C2=A0 QEMUTimer *periodic_timer;<br>
+=C2=A0 =C2=A0 int64_t next_periodic_time;<br>
+=C2=A0 =C2=A0 /* update-ended timer */<br>
+=C2=A0 =C2=A0 QEMUTimer *update_timer;<br>
+=C2=A0 =C2=A0 uint64_t next_alarm_time;<br>
+=C2=A0 =C2=A0 uint16_t irq_reinject_on_ack_count;<br>
+=C2=A0 =C2=A0 uint32_t irq_coalesced;<br>
+=C2=A0 =C2=A0 uint32_t period;<br>
+=C2=A0 =C2=A0 QEMUTimer *coalesced_timer;<br>
+=C2=A0 =C2=A0 Notifier clock_reset_notifier;<br>
+=C2=A0 =C2=A0 LostTickPolicy lost_tick_policy;<br>
+=C2=A0 =C2=A0 Notifier suspend_notifier;<br>
+=C2=A0 =C2=A0 QLIST_ENTRY(RTCState) link;<br>
+} RTCState;<br>
<br>
=C2=A0ISADevice *mc146818_rtc_init(ISABus *bus, int base_year,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_irq intercept_irq);<br>
-- <br>
2.21.0<br>
<br>
<br>
</blockquote>

--00000000000031c31505951c791d--

