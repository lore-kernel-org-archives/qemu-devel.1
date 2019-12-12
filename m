Return-Path: <SRS0=2YLf=2C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFDC7C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 14:21:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ABC6C2077B
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 14:21:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=greensocs.com header.i=@greensocs.com header.b="o0JEBXkj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABC6C2077B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=greensocs.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60540 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifPLj-0001pn-GK
	for qemu-devel@archiver.kernel.org; Thu, 12 Dec 2019 09:21:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37076)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <luc.michel@greensocs.com>) id 1ifPFc-0004MR-7b
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 09:15:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <luc.michel@greensocs.com>) id 1ifPFa-000078-Br
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 09:15:31 -0500
Received: from beetle.greensocs.com ([5.135.226.135]:57758)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <luc.michel@greensocs.com>)
 id 1ifPFZ-0008U4-Bu
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 09:15:30 -0500
Received: from [172.17.10.6] (unknown [172.17.10.6])
 by beetle.greensocs.com (Postfix) with ESMTPSA id F207396EF0;
 Thu, 12 Dec 2019 14:15:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com;
 s=mail; t=1576160126;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=csgbn40Ydzt4WX0T5iS0fv0Xz/2HyDUUCnnTrpiZqO0=;
 b=o0JEBXkjREHTZrI+3WV7cwDFBL5yWim59FiuKFP4959mmhtPdljtmRNacJDwYYhDUdXb2F
 zeSi4Xa0myly647+VO7xnut+apZouPNswWaWLq8iYNo9li1y6Yr3VMf7DoLVHWcD43UPyK
 xxrYoH76/whZENVUeeeovW3BkcC7ZUM=
Subject: Re: [PATCH v2 1/2] gdbstub: change GDBState.last_packet to GByteArray
To: Damien Hedde <damien.hedde@greensocs.com>, qemu-devel@nongnu.org
References: <20191211160514.58373-1-damien.hedde@greensocs.com>
 <20191211160514.58373-2-damien.hedde@greensocs.com>
From: Luc Michel <luc.michel@greensocs.com>
Message-ID: <34c9016c-6d41-19a6-7f27-2476349920ce@greensocs.com>
Date: Thu, 12 Dec 2019 15:15:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191211160514.58373-2-damien.hedde@greensocs.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-PH
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com; 
 s=mail; t=1576160126;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=csgbn40Ydzt4WX0T5iS0fv0Xz/2HyDUUCnnTrpiZqO0=;
 b=2Uut55PtvrM2KR15t7KGzyGvVpZv9kPN37vggolipU0pHGPbqu1Nt5Ke+IGF/uhm35cwX+
 ALge1B0ZzBQXgeWqLxc4ab2+vHqGXKsk0PgA7pd1kxX7Lx/o+CbQR8o4x1YRautRSQrGjM
 pHqy4l1Xf0HWhNgMHsmDBLOEpondRow=
ARC-Seal: i=1; s=mail; d=greensocs.com; t=1576160126; a=rsa-sha256; cv=none;
 b=y7ryWe/DH8cd03S10mfVVfO58SjckpBmd8zJiUw6pnoduDpsP5SUPvKIpbEeIQjZdLnZPR
 qHT+/yqAgdfJysnaLb/x+pYO6ZQFJoaSeTeMck6h6O3ZomPBFORDJMkVi53QTBzqp2cno7
 7XjEiohWHf+ZOlEXVKsPKw/BR/8IquA=
ARC-Authentication-Results: i=1; ORIGINATING;
 auth=pass smtp.auth=luc smtp.mailfrom=luc.michel@greensocs.com
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 5.135.226.135
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
Cc: philmd@redhat.com, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 12/11/19 5:05 PM, Damien Hedde wrote:
> Remove the packet size upper limit by using a GByteArray
> instead of a statically allocated array for last_packet.
> Thus we can now send big packets.
>=20
> Also remove the last_packet_len field and use last_packet->len
> instead.
>=20
> Signed-off-by: Damien Hedde <damien.hedde@greensocs.com>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Reviewed-by: Luc Michel <luc.michel@greensocs.com>

> ---
>  gdbstub.c | 39 +++++++++++++++++++++------------------
>  1 file changed, 21 insertions(+), 18 deletions(-)
>=20
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
>      gdbserver_state.mem_buf =3D g_byte_array_sized_new(MAX_PACKET_LENG=
TH);
> +    gdbserver_state.last_packet =3D g_byte_array_sized_new(MAX_PACKET_=
LENGTH + 4);
>  }
> =20
>  #ifndef CONFIG_USER_ONLY
> @@ -626,28 +626,29 @@ static void hexdump(const char *buf, int len,
>  static int put_packet_binary(const char *buf, int len, bool dump)
>  {
>      int csum, i;
> -    uint8_t *p;
> -    uint8_t *ps =3D &gdbserver_state.last_packet[0];
> +    uint8_t footer[3];
> =20
>      if (dump && trace_event_get_state_backends(TRACE_GDBSTUB_IO_BINARY=
REPLY)) {
>          hexdump(buf, len, trace_gdbstub_io_binaryreply);
>      }
> =20
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
> =20
> -        gdbserver_state.last_packet_len =3D p - ps;
> -        put_buffer(ps, gdbserver_state.last_packet_len);
> +        put_buffer(gdbserver_state.last_packet->data,
> +                   gdbserver_state.last_packet->len);
> =20
>  #ifdef CONFIG_USER_ONLY
>          i =3D get_char();
> @@ -2812,20 +2813,22 @@ static void gdb_read_byte(GDBState *s, uint8_t =
ch)
>      uint8_t reply;
> =20
>  #ifndef CONFIG_USER_ONLY
> -    if (gdbserver_state.last_packet_len) {
> +    if (gdbserver_state.last_packet->len) {
>          /* Waiting for a response to the last packet.  If we see the s=
tart
>             of a new command then abandon the previous response.  */
>          if (ch =3D=3D '-') {
>              trace_gdbstub_err_got_nack();
> -            put_buffer((uint8_t *)gdbserver_state.last_packet, gdbserv=
er_state.last_packet_len);
> +            put_buffer(gdbserver_state.last_packet->data,
> +                       gdbserver_state.last_packet->len);
>          } else if (ch =3D=3D '+') {
>              trace_gdbstub_io_got_ack();
>          } else {
>              trace_gdbstub_io_got_unexpected(ch);
>          }
> =20
> -        if (ch =3D=3D '+' || ch =3D=3D '$')
> -            gdbserver_state.last_packet_len =3D 0;
> +        if (ch =3D=3D '+' || ch =3D=3D '$') {
> +            g_byte_array_set_size(gdbserver_state.last_packet, 0);
> +        }
>          if (ch !=3D '$')
>              return;
>      }
> @@ -3209,7 +3212,7 @@ static int gdb_monitor_write(Chardev *chr, const =
uint8_t *buf, int len)
>      const char *p =3D (const char *)buf;
>      int max_sz;
> =20
> -    max_sz =3D (sizeof(gdbserver_state.last_packet) - 2) / 2;
> +    max_sz =3D (MAX_PACKET_LENGTH / 2) + 1;
>      for (;;) {
>          if (len <=3D max_sz) {
>              gdb_monitor_output(&gdbserver_state, p, len);
>=20

