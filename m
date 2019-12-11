Return-Path: <SRS0=Q6KP=2B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B03C9C2D0C6
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2019 18:51:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C657222C4
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2019 18:51:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oF7HHgfg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C657222C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47888 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1if759-0006iM-K9
	for qemu-devel@archiver.kernel.org; Wed, 11 Dec 2019 13:51:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55168)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1if74F-0006D2-2z
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 13:50:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1if74D-0007Y7-KU
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 13:50:34 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:37144)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1if74D-0007US-BP
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 13:50:33 -0500
Received: by mail-wm1-x341.google.com with SMTP id f129so8174618wmf.2
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2019 10:50:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=wpq2Cmx/bwvDjOwvsQuS4oO9KiqyhuwuzOVkT4sDQrs=;
 b=oF7HHgfgafFUoJREm1Xmicb0vxL/XjOn9At3qpEVxtTFV0faDRNmhg2xwAX7s9MdtA
 EwrIXWZfKjKMzB30nXvfSa2Ixu7N6ri0P1Hv8Ero/9X2p8E1zLgZKTI3kymtXyK60tV7
 kJOuYgBDvV+FL8T2Qgwi+5EPbfVBcanEbtNvx87EyzS3+Ic5LdC8d4GbOvmB156tx0vt
 MGZNAz5+jzGxowruryMxJYD1GXH5uboFAOQRD1Ddarz2+OEKFSXrojR670N+lkVpPYvN
 scPZtY/hz1w6zJyUAESpRKfq+m5epU3jjH4tEAeKzBUbToxLnc3WQ4Cx5onjaawb2UQG
 3jqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=wpq2Cmx/bwvDjOwvsQuS4oO9KiqyhuwuzOVkT4sDQrs=;
 b=I32QM+cbAFYmPv/h6kBr35xttsXPmuIoAfIMtEBE94NjGy75nR0KLOZSjARz52ftOW
 v1FEi0ZeTfjWPbZsuCWSJWfJYE1BsBuCssmecG5D8VX61zXEZZe1nQ1jpVoek8nsCyV7
 vIWvUoZAbVztEBVdS3wXZAmtU5csx8b7cJ4okeJoRrJnrr+fdgjkzI6MwK96Jxzbjure
 TJnp/42uynqMilXhgiLczk2k677cke1lqm2qhQEveqv9Hg636G1fy+sUbjorpcXw2Sgv
 mLx1eQh+H9khxPaM6nwRY6OURTHQdXFztrGmZCftmaQ2f/M7xBZPVhtjMbH2HYuBTqw5
 0K9Q==
X-Gm-Message-State: APjAAAUWwIMzTHbVvv0OjVMWB+6+KJZxkNnNxtt8uqw+bl5kXpCFihTv
 uCjdLIfF3ZBZAXkkGfWiSs4oYg==
X-Google-Smtp-Source: APXvYqwQ/hrdlfZ1ACMwn3Y9CqhigFUEpFnBrc2KTd/j9BkBKzc3MDM2oF2QfTqN289nQTQyFETTnA==
X-Received: by 2002:a1c:1f56:: with SMTP id f83mr1453061wmf.93.1576090230915; 
 Wed, 11 Dec 2019 10:50:30 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id u14sm3231854wrm.51.2019.12.11.10.50.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Dec 2019 10:50:28 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 9FE411FF87;
 Wed, 11 Dec 2019 18:50:27 +0000 (GMT)
References: <20191211160514.58373-1-damien.hedde@greensocs.com>
 <20191211160514.58373-2-damien.hedde@greensocs.com>
User-agent: mu4e 1.3.5; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Damien Hedde <damien.hedde@greensocs.com>
Subject: Re: [PATCH v2 1/2] gdbstub: change GDBState.last_packet to GByteArray
In-reply-to: <20191211160514.58373-2-damien.hedde@greensocs.com>
Date: Wed, 11 Dec 2019 18:50:27 +0000
Message-ID: <874ky63de4.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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
Cc: philmd@redhat.com, qemu-devel@nongnu.org, luc.michel@greensocs.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Damien Hedde <damien.hedde@greensocs.com> writes:

> Remove the packet size upper limit by using a GByteArray
> instead of a statically allocated array for last_packet.
> Thus we can now send big packets.
>
> Also remove the last_packet_len field and use last_packet->len
> instead.
>
> Signed-off-by: Damien Hedde <damien.hedde@greensocs.com>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  gdbstub.c | 39 +++++++++++++++++++++------------------
>  1 file changed, 21 insertions(+), 18 deletions(-)
>
> diff --git a/gdbstub.c b/gdbstub.c
> index 7b695bdebe..93b26f1b86 100644
> --- a/gdbstub.c
> +++ b/gdbstub.c
> @@ -351,8 +351,7 @@ typedef struct GDBState {
>      int line_buf_index;
>      int line_sum; /* running checksum */
>      int line_csum; /* checksum at the end of the packet */
> -    uint8_t last_packet[MAX_PACKET_LENGTH + 4];
> -    int last_packet_len;
> +    GByteArray *last_packet;
>      int signal;
>  #ifdef CONFIG_USER_ONLY
>      int fd;
> @@ -384,6 +383,7 @@ static void init_gdbserver_state(void)
>      gdbserver_state.init =3D true;
>      gdbserver_state.str_buf =3D g_string_new(NULL);
>      gdbserver_state.mem_buf =3D g_byte_array_sized_new(MAX_PACKET_LENGTH=
);
> +    gdbserver_state.last_packet =3D g_byte_array_sized_new(MAX_PACKET_LE=
NGTH + 4);
>  }
>=20=20
>  #ifndef CONFIG_USER_ONLY
> @@ -626,28 +626,29 @@ static void hexdump(const char *buf, int len,
>  static int put_packet_binary(const char *buf, int len, bool dump)
>  {
>      int csum, i;
> -    uint8_t *p;
> -    uint8_t *ps =3D &gdbserver_state.last_packet[0];
> +    uint8_t footer[3];
>=20=20
>      if (dump && trace_event_get_state_backends(TRACE_GDBSTUB_IO_BINARYRE=
PLY)) {
>          hexdump(buf, len, trace_gdbstub_io_binaryreply);
>      }
>=20=20
>      for(;;) {
> -        p =3D ps;
> -        *(p++) =3D '$';
> -        memcpy(p, buf, len);
> -        p +=3D len;
> +        g_byte_array_set_size(gdbserver_state.last_packet, 0);
> +        g_byte_array_append(gdbserver_state.last_packet,
> +                            (const uint8_t *) "$", 1);
> +        g_byte_array_append(gdbserver_state.last_packet,
> +                            (const uint8_t *) buf, len);
>          csum =3D 0;
>          for(i =3D 0; i < len; i++) {
>              csum +=3D buf[i];
>          }
> -        *(p++) =3D '#';
> -        *(p++) =3D tohex((csum >> 4) & 0xf);
> -        *(p++) =3D tohex((csum) & 0xf);
> +        footer[0] =3D '#';
> +        footer[1] =3D tohex((csum >> 4) & 0xf);
> +        footer[2] =3D tohex((csum) & 0xf);
> +        g_byte_array_append(gdbserver_state.last_packet, footer, 3);
>=20=20
> -        gdbserver_state.last_packet_len =3D p - ps;
> -        put_buffer(ps, gdbserver_state.last_packet_len);
> +        put_buffer(gdbserver_state.last_packet->data,
> +                   gdbserver_state.last_packet->len);
>=20=20
>  #ifdef CONFIG_USER_ONLY
>          i =3D get_char();
> @@ -2812,20 +2813,22 @@ static void gdb_read_byte(GDBState *s, uint8_t ch)
>      uint8_t reply;
>=20=20
>  #ifndef CONFIG_USER_ONLY
> -    if (gdbserver_state.last_packet_len) {
> +    if (gdbserver_state.last_packet->len) {
>          /* Waiting for a response to the last packet.  If we see the sta=
rt
>             of a new command then abandon the previous response.  */
>          if (ch =3D=3D '-') {
>              trace_gdbstub_err_got_nack();
> -            put_buffer((uint8_t *)gdbserver_state.last_packet, gdbserver=
_state.last_packet_len);
> +            put_buffer(gdbserver_state.last_packet->data,
> +                       gdbserver_state.last_packet->len);
>          } else if (ch =3D=3D '+') {
>              trace_gdbstub_io_got_ack();
>          } else {
>              trace_gdbstub_io_got_unexpected(ch);
>          }
>=20=20
> -        if (ch =3D=3D '+' || ch =3D=3D '$')
> -            gdbserver_state.last_packet_len =3D 0;
> +        if (ch =3D=3D '+' || ch =3D=3D '$') {
> +            g_byte_array_set_size(gdbserver_state.last_packet, 0);
> +        }
>          if (ch !=3D '$')
>              return;
>      }
> @@ -3209,7 +3212,7 @@ static int gdb_monitor_write(Chardev *chr, const ui=
nt8_t *buf, int len)
>      const char *p =3D (const char *)buf;
>      int max_sz;
>=20=20
> -    max_sz =3D (sizeof(gdbserver_state.last_packet) - 2) / 2;
> +    max_sz =3D (MAX_PACKET_LENGTH / 2) + 1;
>      for (;;) {
>          if (len <=3D max_sz) {
>              gdb_monitor_output(&gdbserver_state, p, len);


--=20
Alex Benn=C3=A9e

