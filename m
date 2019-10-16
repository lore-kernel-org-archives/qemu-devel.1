Return-Path: <SRS0=/TIv=YJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 861B8FA3728
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Oct 2019 15:04:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 504AC20640
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Oct 2019 15:04:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q86ffiLN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 504AC20640
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43728 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iKkqp-0007kJ-Me
	for qemu-devel@archiver.kernel.org; Wed, 16 Oct 2019 11:04:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45785)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@gmail.com>) id 1iKkoh-0005kX-RK
 for qemu-devel@nongnu.org; Wed, 16 Oct 2019 11:02:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@gmail.com>) id 1iKkog-0004nz-FH
 for qemu-devel@nongnu.org; Wed, 16 Oct 2019 11:02:23 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:41239)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
 id 1iKkog-0004nW-8R
 for qemu-devel@nongnu.org; Wed, 16 Oct 2019 11:02:22 -0400
Received: by mail-wr1-x441.google.com with SMTP id p4so12591304wrm.8
 for <qemu-devel@nongnu.org>; Wed, 16 Oct 2019 08:02:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=k6obupE33Q3VwI/0XfHlUz1p2bBzYh+/q2Z619QmKLs=;
 b=Q86ffiLNJg7Wzn5g2ci5WTEfCjyrMOqLne2lREWg2hPYWWZVEdgUlQCMAC1vPHhkr+
 oZ9mEGOZZRdxi6puyleYzrcAcvGuzeYTVZWbvFOe7BM3V0zoQ8b8A8NXEzZKZH/9LTlF
 rxoSyXhB30hRv8MfdvA6rDFOmg3W2i8Ah6Ek4gFmlqCEhJ2I/vVuB+Fqvdx7GpMZaqTy
 qWqJJchRrjg2MRGBdNJpn9t31sSff82gcTPFomUWnOWlk3AhUiYi1uJ5pHpndx2f0UbR
 zY9v1xsfFH+ArkKA9O7/wSSmfr3ch9hrw6/Dt6FIggY3b/JBgDg3kw8XmjKxmnj6kqL3
 eyIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=k6obupE33Q3VwI/0XfHlUz1p2bBzYh+/q2Z619QmKLs=;
 b=UxrU1KBsLYnroCODTY5N2jm1QrHC/WdHlhk1+CK7ZNGshgAEaruNM9jCmL5rW5AzdX
 u9nSNTpWcylC7l/nPzobFiL0kdwRziM4AVezod2TM26lS2FUJefWpSUAKtTOgUqnGpGt
 mAN1eE0/9hDdAQMLGEmx4ScsZA86BqH02wq3KDHx2xOpoEkNqrQqBmaJqWLCI+pK+aeu
 qfdgRUoSqHP3qv+Ictvu8BF+3H5D6biTiWUVaeeFEYjoudGjdcNUo0p89TBimw9t5q2r
 bs5BFS+1F57tSUKfGi8S/UTxRwoR9rVbIMnNZTnf12/nta3DNNna+3q58LM3GJf4UNve
 da5g==
X-Gm-Message-State: APjAAAU9TI3pl/IqukqE2jsEn3Tf44xKnVVj95hLyW0Kw0SlLHKGrMmA
 j9duSOacjKCOot+k3G0gYX450dH1JzP1sZ0EHLyNLuJA
X-Google-Smtp-Source: APXvYqyOPdIqQrJbhZMBZkY5d+N8v26mYmuWpa5b+tZ/BJC65o+j3xUdiP4S1og+2ve1N+GX81bMtMPF1C58AES3u6c=
X-Received: by 2002:a05:6000:18d:: with SMTP id
 p13mr3079922wrx.396.1571238141180; 
 Wed, 16 Oct 2019 08:02:21 -0700 (PDT)
MIME-Version: 1.0
References: <20191016101241.24405-1-slp@redhat.com>
 <20191016101241.24405-11-slp@redhat.com>
In-Reply-To: <20191016101241.24405-11-slp@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 16 Oct 2019 17:02:09 +0200
Message-ID: <CAJ+F1CKMvD-mVX-wwJ_kv8whyCF9UnPv3bcpVMiMbCSHEJcJVA@mail.gmail.com>
Subject: Re: [PATCH v10 10/15] fw_cfg: add "modify" functions for all types
To: Sergio Lopez <slp@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>, groug@kaod.org,
 QEMU <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>, Laszlo Ersek <lersek@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Oct 16, 2019 at 12:22 PM Sergio Lopez <slp@redhat.com> wrote:
>
> This allows to alter the contents of an already added item.
>
> Signed-off-by: Sergio Lopez <slp@redhat.com>
> Reviewed-by: Michael S. Tsirkin <mst@redhat.com>

Used to fix kernel command line in following patch "hw/i386: Introduce
the microvm machine type", except fw_cfg_modify_i64().


Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


> ---
>  include/hw/nvram/fw_cfg.h | 42 +++++++++++++++++++++++++++++++++++++++
>  hw/nvram/fw_cfg.c         | 29 +++++++++++++++++++++++++++
>  2 files changed, 71 insertions(+)
>
> diff --git a/include/hw/nvram/fw_cfg.h b/include/hw/nvram/fw_cfg.h
> index 80e435d303..b5291eefad 100644
> --- a/include/hw/nvram/fw_cfg.h
> +++ b/include/hw/nvram/fw_cfg.h
> @@ -98,6 +98,20 @@ void fw_cfg_add_bytes(FWCfgState *s, uint16_t key, voi=
d *data, size_t len);
>   */
>  void fw_cfg_add_string(FWCfgState *s, uint16_t key, const char *value);
>
> +/**
> + * fw_cfg_modify_string:
> + * @s: fw_cfg device being modified
> + * @key: selector key value for new fw_cfg item
> + * @value: NUL-terminated ascii string
> + *
> + * Replace the fw_cfg item available by selecting the given key. The new
> + * data will consist of a dynamically allocated copy of the provided str=
ing,
> + * including its NUL terminator. The data being replaced, assumed to hav=
e
> + * been dynamically allocated during an earlier call to either
> + * fw_cfg_add_string() or fw_cfg_modify_string(), is freed before return=
ing.
> + */
> +void fw_cfg_modify_string(FWCfgState *s, uint16_t key, const char *value=
);
> +
>  /**
>   * fw_cfg_add_i16:
>   * @s: fw_cfg device being modified
> @@ -136,6 +150,20 @@ void fw_cfg_modify_i16(FWCfgState *s, uint16_t key, =
uint16_t value);
>   */
>  void fw_cfg_add_i32(FWCfgState *s, uint16_t key, uint32_t value);
>
> +/**
> + * fw_cfg_modify_i32:
> + * @s: fw_cfg device being modified
> + * @key: selector key value for new fw_cfg item
> + * @value: 32-bit integer
> + *
> + * Replace the fw_cfg item available by selecting the given key. The new
> + * data will consist of a dynamically allocated copy of the given 32-bit
> + * value, converted to little-endian representation. The data being repl=
aced,
> + * assumed to have been dynamically allocated during an earlier call to
> + * either fw_cfg_add_i32() or fw_cfg_modify_i32(), is freed before retur=
ning.
> + */
> +void fw_cfg_modify_i32(FWCfgState *s, uint16_t key, uint32_t value);
> +
>  /**
>   * fw_cfg_add_i64:
>   * @s: fw_cfg device being modified
> @@ -148,6 +176,20 @@ void fw_cfg_add_i32(FWCfgState *s, uint16_t key, uin=
t32_t value);
>   */
>  void fw_cfg_add_i64(FWCfgState *s, uint16_t key, uint64_t value);
>
> +/**
> + * fw_cfg_modify_i64:
> + * @s: fw_cfg device being modified
> + * @key: selector key value for new fw_cfg item
> + * @value: 64-bit integer
> + *
> + * Replace the fw_cfg item available by selecting the given key. The new
> + * data will consist of a dynamically allocated copy of the given 64-bit
> + * value, converted to little-endian representation. The data being repl=
aced,
> + * assumed to have been dynamically allocated during an earlier call to
> + * either fw_cfg_add_i64() or fw_cfg_modify_i64(), is freed before retur=
ning.
> + */
> +void fw_cfg_modify_i64(FWCfgState *s, uint16_t key, uint64_t value);
> +
>  /**
>   * fw_cfg_add_file:
>   * @s: fw_cfg device being modified
> diff --git a/hw/nvram/fw_cfg.c b/hw/nvram/fw_cfg.c
> index 7dc3ac378e..aef1727250 100644
> --- a/hw/nvram/fw_cfg.c
> +++ b/hw/nvram/fw_cfg.c
> @@ -690,6 +690,15 @@ void fw_cfg_add_string(FWCfgState *s, uint16_t key, =
const char *value)
>      fw_cfg_add_bytes(s, key, g_memdup(value, sz), sz);
>  }
>
> +void fw_cfg_modify_string(FWCfgState *s, uint16_t key, const char *value=
)
> +{
> +    size_t sz =3D strlen(value) + 1;
> +    char *old;
> +
> +    old =3D fw_cfg_modify_bytes_read(s, key, g_memdup(value, sz), sz);
> +    g_free(old);
> +}
> +
>  void fw_cfg_add_i16(FWCfgState *s, uint16_t key, uint16_t value)
>  {
>      uint16_t *copy;
> @@ -720,6 +729,16 @@ void fw_cfg_add_i32(FWCfgState *s, uint16_t key, uin=
t32_t value)
>      fw_cfg_add_bytes(s, key, copy, sizeof(value));
>  }
>
> +void fw_cfg_modify_i32(FWCfgState *s, uint16_t key, uint32_t value)
> +{
> +    uint32_t *copy, *old;
> +
> +    copy =3D g_malloc(sizeof(value));
> +    *copy =3D cpu_to_le32(value);
> +    old =3D fw_cfg_modify_bytes_read(s, key, copy, sizeof(value));
> +    g_free(old);
> +}
> +
>  void fw_cfg_add_i64(FWCfgState *s, uint16_t key, uint64_t value)
>  {
>      uint64_t *copy;
> @@ -730,6 +749,16 @@ void fw_cfg_add_i64(FWCfgState *s, uint16_t key, uin=
t64_t value)
>      fw_cfg_add_bytes(s, key, copy, sizeof(value));
>  }
>
> +void fw_cfg_modify_i64(FWCfgState *s, uint16_t key, uint64_t value)
> +{
> +    uint64_t *copy, *old;
> +
> +    copy =3D g_malloc(sizeof(value));
> +    *copy =3D cpu_to_le64(value);
> +    old =3D fw_cfg_modify_bytes_read(s, key, copy, sizeof(value));
> +    g_free(old);
> +}
> +
>  void fw_cfg_set_order_override(FWCfgState *s, int order)
>  {
>      assert(s->fw_cfg_order_override =3D=3D 0);
> --
> 2.21.0
>
>


--
Marc-Andr=C3=A9 Lureau

