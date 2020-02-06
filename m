Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62DD9C33CAC
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 18:45:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 30EF5214AF
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 18:45:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c6dDXb0I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30EF5214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44640 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izm9l-0008V0-CX
	for qemu-devel@archiver.kernel.org; Thu, 06 Feb 2020 13:45:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37346)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1izm5N-0002gZ-Np
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 13:41:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1izm5E-0004Cj-Gu
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 13:41:09 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:40294
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1izm5E-0004BS-Ba
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 13:41:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581014459;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EE6o3BquUxWWkGeCDvXLrYAKcIZym3ch/wklbJT+cys=;
 b=c6dDXb0IkzvzN9HeMpJfGh7MUM73uQKdg6WV1Efpg31Myqger+fP8PkClT9QOSmsokTX0I
 DA1r4qp3drj243QY9RuVFxoDBF62FekcVyfmsWiKsoOdIWmYN1n798SW23btiM105Gifpe
 PFFEptqUcYGuDc0Ghn/VzmgEBFdcBqU=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-222-4eMO3KC7NIagmQbvSUSe7Q-1; Thu, 06 Feb 2020 13:40:57 -0500
Received: by mail-wr1-f71.google.com with SMTP id c6so3909456wrm.18
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2020 10:40:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=29SaaEYJKqTsGzW7F6/QGtbfystFaC96SXY6WtBNDFo=;
 b=XjY4cgXKy+gvGU1Y0E+RXX0awyRNpJ7332dn/LyvtiKkP5++KN56hNOswhFE+BI562
 Iu0Bel4KEky7GuIde00fkeVC0jA3h752I1sxtl+pSq4dWIS2J3Mvx4OAKnD2aMy9gs62
 0xJ4i/gM9KeOK7y/8s/WjIi1IWDQjdky8Lh2KG3L5JcXxg50ZBn0RvhptqZe0D/ngOFB
 Zi04pzEnj7Lc8SqdcO4r2EpLIAUMBNwfexFemjGXmYhyMUJheJ37qDppiOLYcslHh3Ik
 KRS+Pq2+sJFjChIlaEwFYJF8WemDhHag7jUUDPZS6StQHw+dF5bAgtfbXJPEc1jxyVM+
 zIfg==
X-Gm-Message-State: APjAAAWb18jklvyVB85sl9CEpmBdCsPRb1mSwNVuuara43ZbhN+vGD1h
 TRmluqQCNDil2laquyt7opvrdutCPQpueYD2o45+MtFXVzGFNxZd+xzenJDrryqbrEROhtTnVuF
 l1RR1W69NO9mleHQ=
X-Received: by 2002:a1c:a4c3:: with SMTP id n186mr6074356wme.25.1581014455125; 
 Thu, 06 Feb 2020 10:40:55 -0800 (PST)
X-Google-Smtp-Source: APXvYqy931M0JBlWsBuLpmTwEcrfF571mmMfpg4VcL2xHJMRNn/SOOF0hCk3Tn1PPzSa4fQXgY23/g==
X-Received: by 2002:a1c:a4c3:: with SMTP id n186mr6074320wme.25.1581014454748; 
 Thu, 06 Feb 2020 10:40:54 -0800 (PST)
Received: from [192.168.1.35] (78.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.78])
 by smtp.gmail.com with ESMTPSA id u8sm440257wmm.15.2020.02.06.10.40.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Feb 2020 10:40:54 -0800 (PST)
Subject: Re: [PATCH v2 1/4] m25p80: Convert to support tracing
To: Guenter Roeck <linux@roeck-us.net>,
 Alistair Francis <alistair@alistair23.me>, Kevin Wolf <kwolf@redhat.com>
References: <20200206183219.3756-1-linux@roeck-us.net>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <c8b82faf-ffe7-d6ff-0eb1-2fcea8e94855@redhat.com>
Date: Thu, 6 Feb 2020 19:40:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200206183219.3756-1-linux@roeck-us.net>
Content-Language: en-US
X-MC-Unique: 4eMO3KC7NIagmQbvSUSe7Q-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-block@nongnu.org,
 Andrew Jeffery <andrew@aj.id.au>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>, qemu-arm@nongnu.org,
 Joel Stanley <joel@jms.id.au>,
 =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/6/20 7:32 PM, Guenter Roeck wrote:
> While at it, add some trace messages to help debug problems
> seen when running the latest Linux kernel.
>=20
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
> v2: Print pointer to Flash data structure as flash ID with each trace
>      message to support systems with more than one instantiated flash.
>=20
>   hw/block/m25p80.c     | 48 ++++++++++++++++++++-----------------------
>   hw/block/trace-events | 16 +++++++++++++++
>   2 files changed, 38 insertions(+), 26 deletions(-)
>=20
> diff --git a/hw/block/m25p80.c b/hw/block/m25p80.c
> index 61f2fb8f8f..5ff8d270c4 100644
> --- a/hw/block/m25p80.c
> +++ b/hw/block/m25p80.c
> @@ -32,17 +32,7 @@
>   #include "qemu/module.h"
>   #include "qemu/error-report.h"
>   #include "qapi/error.h"
> -
> -#ifndef M25P80_ERR_DEBUG
> -#define M25P80_ERR_DEBUG 0
> -#endif
> -
> -#define DB_PRINT_L(level, ...) do { \
> -    if (M25P80_ERR_DEBUG > (level)) { \
> -        fprintf(stderr,  ": %s: ", __func__); \
> -        fprintf(stderr, ## __VA_ARGS__); \
> -    } \
> -} while (0)
> +#include "trace.h"
>  =20
>   /* Fields for FlashPartInfo->flags */
>  =20
> @@ -574,7 +564,8 @@ static void flash_erase(Flash *s, int offset, FlashCM=
D cmd)
>           abort();
>       }
>  =20
> -    DB_PRINT_L(0, "offset =3D %#x, len =3D %d\n", offset, len);
> +    trace_m25p80_flash_erase(s, offset, len);
> +
>       if ((s->pi->flags & capa_to_assert) !=3D capa_to_assert) {
>           qemu_log_mask(LOG_GUEST_ERROR, "M25P80: %d erase size not suppo=
rted by"
>                         " device\n", len);
> @@ -607,8 +598,7 @@ void flash_write8(Flash *s, uint32_t addr, uint8_t da=
ta)
>       }
>  =20
>       if ((prev ^ data) & data) {
> -        DB_PRINT_L(1, "programming zero to one! addr=3D%" PRIx32 "  %" P=
RIx8
> -                   " -> %" PRIx8 "\n", addr, prev, data);
> +        trace_m25p80_programming_zero_to_one(s, addr, prev, data);
>       }
>  =20
>       if (s->pi->flags & EEPROM) {
> @@ -662,6 +652,9 @@ static void complete_collecting_data(Flash *s)
>  =20
>       s->state =3D STATE_IDLE;
>  =20
> +    trace_m25p80_complete_collecting(s, s->cmd_in_progress, n, s->ear,
> +                                     s->cur_addr);
> +
>       switch (s->cmd_in_progress) {
>       case DPP:
>       case QPP:
> @@ -825,7 +818,7 @@ static void reset_memory(Flash *s)
>           break;
>       }
>  =20
> -    DB_PRINT_L(0, "Reset done.\n");
> +    trace_m25p80_reset_done(s);
>   }
>  =20
>   static void decode_fast_read_cmd(Flash *s)
> @@ -941,9 +934,10 @@ static void decode_qio_read_cmd(Flash *s)
>  =20
>   static void decode_new_cmd(Flash *s, uint32_t value)
>   {
> -    s->cmd_in_progress =3D value;
>       int i;
> -    DB_PRINT_L(0, "decoded new command:%x\n", value);
> +
> +    s->cmd_in_progress =3D value;
> +    trace_m25p80_command_decoded(s, value);
>  =20
>       if (value !=3D RESET_MEMORY) {
>           s->reset_enable =3D false;
> @@ -1042,7 +1036,7 @@ static void decode_new_cmd(Flash *s, uint32_t value=
)
>           break;
>  =20
>       case JEDEC_READ:
> -        DB_PRINT_L(0, "populated jedec code\n");
> +        trace_m25p80_populated_jedec(s);
>           for (i =3D 0; i < s->pi->id_len; i++) {
>               s->data[i] =3D s->pi->id[i];
>           }
> @@ -1063,7 +1057,7 @@ static void decode_new_cmd(Flash *s, uint32_t value=
)
>       case BULK_ERASE_60:
>       case BULK_ERASE:
>           if (s->write_enable) {
> -            DB_PRINT_L(0, "chip erase\n");
> +            trace_m25p80_chip_erase(s);
>               flash_erase(s, 0, BULK_ERASE);
>           } else {
>               qemu_log_mask(LOG_GUEST_ERROR, "M25P80: chip erase with wri=
te "
> @@ -1184,7 +1178,7 @@ static int m25p80_cs(SSISlave *ss, bool select)
>           s->data_read_loop =3D false;
>       }
>  =20
> -    DB_PRINT_L(0, "%sselect\n", select ? "de" : "");
> +    trace_m25p80_select(s, select ? "de" : "");

This one is acceptable.

Reviewed-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>

>  =20
>       return 0;
>   }
> @@ -1194,19 +1188,20 @@ static uint32_t m25p80_transfer8(SSISlave *ss, ui=
nt32_t tx)
>       Flash *s =3D M25P80(ss);
>       uint32_t r =3D 0;
>  =20
> +    trace_m25p80_transfer(s, s->state, s->len, s->needed_bytes, s->pos,
> +                          s->cur_addr, (uint8_t)tx);
> +
>       switch (s->state) {
>  =20
>       case STATE_PAGE_PROGRAM:
> -        DB_PRINT_L(1, "page program cur_addr=3D%#" PRIx32 " data=3D%" PR=
Ix8 "\n",
> -                   s->cur_addr, (uint8_t)tx);
> +        trace_m25p80_page_program(s, s->cur_addr, (uint8_t)tx);
>           flash_write8(s, s->cur_addr, (uint8_t)tx);
>           s->cur_addr =3D (s->cur_addr + 1) & (s->size - 1);
>           break;
>  =20
>       case STATE_READ:
>           r =3D s->storage[s->cur_addr];
> -        DB_PRINT_L(1, "READ 0x%" PRIx32 "=3D%" PRIx8 "\n", s->cur_addr,
> -                   (uint8_t)r);
> +        trace_m25p80_read_byte(s, s->cur_addr, (uint8_t)r);
>           s->cur_addr =3D (s->cur_addr + 1) & (s->size - 1);
>           break;
>  =20
> @@ -1244,6 +1239,7 @@ static uint32_t m25p80_transfer8(SSISlave *ss, uint=
32_t tx)
>           }
>  =20
>           r =3D s->data[s->pos];
> +        trace_m25p80_read_data(s, s->pos, (uint8_t)r);
>           s->pos++;
>           if (s->pos =3D=3D s->len) {
>               s->pos =3D 0;
> @@ -1281,7 +1277,7 @@ static void m25p80_realize(SSISlave *ss, Error **er=
rp)
>               return;
>           }
>  =20
> -        DB_PRINT_L(0, "Binding to IF_MTD drive\n");
> +        trace_m25p80_binding(s);
>           s->storage =3D blk_blockalign(s->blk, s->size);
>  =20
>           if (blk_pread(s->blk, 0, s->storage, s->size) !=3D s->size) {
> @@ -1289,7 +1285,7 @@ static void m25p80_realize(SSISlave *ss, Error **er=
rp)
>               return;
>           }
>       } else {
> -        DB_PRINT_L(0, "No BDRV - binding to RAM\n");
> +        trace_m25p80_binding_no_bdrv(s);
>           s->storage =3D blk_blockalign(NULL, s->size);
>           memset(s->storage, 0xFF, s->size);
>       }
> diff --git a/hw/block/trace-events b/hw/block/trace-events
> index c03e80c2c9..f78939fa9d 100644
> --- a/hw/block/trace-events
> +++ b/hw/block/trace-events
> @@ -134,3 +134,19 @@ xen_block_blockdev_add(char *str) "%s"
>   xen_block_blockdev_del(const char *node_name) "%s"
>   xen_block_device_create(unsigned int number) "%u"
>   xen_block_device_destroy(unsigned int number) "%u"
> +
> +# m25p80.c
> +m25p80_flash_erase(void *s, int offset, uint32_t len) "[%p] offset =3D 0=
x%"PRIx32", len =3D %u"
> +m25p80_programming_zero_to_one(void *s, uint32_t addr, uint8_t prev, uin=
t8_t data) "[%p] programming zero to one! addr=3D0x%"PRIx32"  0x%"PRIx8" ->=
 0x%"PRIx8
> +m25p80_reset_done(void *s) "[%p] Reset done."
> +m25p80_command_decoded(void *s, uint32_t cmd) "[%p] new command:0x%"PRIx=
32
> +m25p80_complete_collecting(void *s, uint32_t cmd, int n, uint8_t ear, ui=
nt32_t cur_addr) "[%p] decode cmd: 0x%"PRIx32" len %d ear 0x%"PRIx8" addr 0=
x%"PRIx32
> +m25p80_populated_jedec(void *s) "[%p] populated jedec code"
> +m25p80_chip_erase(void *s) "[%p] chip erase"
> +m25p80_select(void *s, const char *what) "[%p] %sselect"
> +m25p80_page_program(void *s, uint32_t addr, uint8_t tx) "[%p] page progr=
am cur_addr=3D0x%"PRIx32" data=3D0x%"PRIx8
> +m25p80_transfer(void *s, uint8_t state, uint32_t len, uint8_t needed, ui=
nt32_t pos, uint32_t cur_addr, uint8_t t) "[%p] Transfer state 0x%"PRIx8" l=
en 0x%"PRIx32" needed 0x%"PRIx8" pos 0x%"PRIx32" addr 0x%"PRIx32" tx 0x%"PR=
Ix8
> +m25p80_read_byte(void *s, uint32_t addr, uint8_t v) "[%p] Read byte 0x%"=
PRIx32"=3D0x%"PRIx8
> +m25p80_read_data(void *s, uint32_t pos, uint8_t v) "[%p] Read data 0x%"P=
RIx32"=3D0x%"PRIx8
> +m25p80_binding(void *s) "[%p] Binding to IF_MTD drive"
> +m25p80_binding_no_bdrv(void *s) "[%p] No BDRV - binding to RAM"
>=20


