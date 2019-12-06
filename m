Return-Path: <SRS0=8N/K=Z4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83C3FC43603
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 15:00:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F02624670
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 15:00:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aBaOXcjI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F02624670
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39214 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1idF63-0007rN-BV
	for qemu-devel@archiver.kernel.org; Fri, 06 Dec 2019 10:00:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39115)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1idEWI-0001Gc-0j
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 09:23:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1idEWG-0005P4-KA
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 09:23:45 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:47323
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1idEWG-0005KU-Az
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 09:23:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575642219;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=z455oP7Hf+F3n/e1l/xoj2q2wqqceb/wVoPRZ0hsl/A=;
 b=aBaOXcjIAyqRf/r5FwYmSN7mZWCF/ZDtZPoCdKxNLe5pHHIMojONiByWsSblUhjmb671dj
 lpKxj8e8uetDXNm3GIwY5uSxywTxOAPft0RsDedFFKtOC0LQBKBf0hsWxaRCRESCnSICk0
 wu0VMUR5Dw7wlGT78JQbNPI5AE/oT54=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-185-woK3v9H2MpiWAbJ8sJM1PQ-1; Fri, 06 Dec 2019 09:23:36 -0500
Received: by mail-wr1-f72.google.com with SMTP id c6so3189150wrm.18
 for <qemu-devel@nongnu.org>; Fri, 06 Dec 2019 06:23:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=dPZAP3nz/ZHr7ZHj67Gb9CJGkeNhkzMLf042mf6WZMs=;
 b=KdxW3OATuih7d6MvNCHAXUh7t4lurqBuz6UlOn9iol7IJPTuKPVnBGxOpAKXLDav9Q
 pXiHYptFqr23jijO5odYDukI9Epgkb7K/7QDhu88xeMGXJ9AhS2yIxLTKZ1KyvZrxuM1
 O2+0NrKamwGYWwhj4RsuL65fGzKrky57g8hc71nYY3Bmgseu7J8czohGUX2wc1enU066
 B2hbr9zL+yEuYlgv1LsuhUIMjWcXlV5nEDbfTdvSoLHmo66oeVveXmEnUvH+dy/dYxnQ
 0WPI4jt4Exzp4O72LPHB7/DKLvBwdMut/SiwDu2PwPv+SOnQvRBw9ZriKBC0ys6se3v0
 ee5Q==
X-Gm-Message-State: APjAAAW284FRX2qxZExj8SOc0wHV3co324qys6CgcV7xeutetb3dlngj
 4G9xgbte0vERPY617YRdfz6WyA76XjcWlbjDSFIEvyTq9Yo0bRIOLeaOnzvdk/YbVeEdEGQkeJz
 7ib5GgdsUQoo70Hg=
X-Received: by 2002:adf:c446:: with SMTP id a6mr15565885wrg.218.1575642214896; 
 Fri, 06 Dec 2019 06:23:34 -0800 (PST)
X-Google-Smtp-Source: APXvYqxMuJTxkXAkLITaNsXLmgLqgNAyWESXUu6zJPrnW/gU4RAEGy9x13I5oSFYKGgI3rT2073dVw==
X-Received: by 2002:adf:c446:: with SMTP id a6mr15565874wrg.218.1575642214683; 
 Fri, 06 Dec 2019 06:23:34 -0800 (PST)
Received: from [192.168.1.35] (182.red-88-21-103.staticip.rima-tde.net.
 [88.21.103.182])
 by smtp.gmail.com with ESMTPSA id a184sm3670351wmf.29.2019.12.06.06.23.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Dec 2019 06:23:34 -0800 (PST)
Subject: Re: [PATCH] gdbstub: change GDBState.last_packet to GByteArray
To: Damien Hedde <damien.hedde@greensocs.com>, qemu-devel@nongnu.org
References: <20191206134203.77385-1-damien.hedde@greensocs.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <c94902a6-f9cd-0aed-cbca-d61aabf9b97d@redhat.com>
Date: Fri, 6 Dec 2019 15:23:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191206134203.77385-1-damien.hedde@greensocs.com>
Content-Language: en-US
X-MC-Unique: woK3v9H2MpiWAbJ8sJM1PQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: alex.bennee@linaro.org, luc.michel@greensocs.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/6/19 2:42 PM, Damien Hedde wrote:
> Remove the packet size upper limit by using a GByteArray
> instead of a statically allocated array for last_packet.
> Thus we can now send big packets.
>=20
> Also remove the last_packet_len field and use last_packet->len
> instead.
>=20
> Signed-off-by: Damien Hedde <damien.hedde@greensocs.com>
> ---
>=20
> This patch is a follow-up of Alex's series about sve registers
> which introduces some GbyteArray/Gstring in the gdbstub.
> It removes the remaining barrier to send big packets.
>=20
> Based-on <20191130084602.10818-1-alex.bennee@linaro.org>
> ---
>   gdbstub.c | 39 +++++++++++++++++++++------------------
>   1 file changed, 21 insertions(+), 18 deletions(-)
>=20
> diff --git a/gdbstub.c b/gdbstub.c
> index 7b695bdebe..022edd6bdb 100644
> --- a/gdbstub.c
> +++ b/gdbstub.c
> @@ -351,8 +351,7 @@ typedef struct GDBState {
>       int line_buf_index;
>       int line_sum; /* running checksum */
>       int line_csum; /* checksum at the end of the packet */
> -    uint8_t last_packet[MAX_PACKET_LENGTH + 4];
> -    int last_packet_len;
> +    GByteArray *last_packet;
>       int signal;
>   #ifdef CONFIG_USER_ONLY
>       int fd;
> @@ -384,6 +383,7 @@ static void init_gdbserver_state(void)
>       gdbserver_state.init =3D true;
>       gdbserver_state.str_buf =3D g_string_new(NULL);
>       gdbserver_state.mem_buf =3D g_byte_array_sized_new(MAX_PACKET_LENGT=
H);
> +    gdbserver_state.last_packet =3D g_byte_array_sized_new(MAX_PACKET_LE=
NGTH + 4);
>   }
>  =20
>   #ifndef CONFIG_USER_ONLY
> @@ -626,28 +626,29 @@ static void hexdump(const char *buf, int len,
>   static int put_packet_binary(const char *buf, int len, bool dump)
>   {
>       int csum, i;
> -    uint8_t *p;
> -    uint8_t *ps =3D &gdbserver_state.last_packet[0];
> +    uint8_t footer[3];
>  =20
>       if (dump && trace_event_get_state_backends(TRACE_GDBSTUB_IO_BINARYR=
EPLY)) {
>           hexdump(buf, len, trace_gdbstub_io_binaryreply);
>       }
>  =20
>       for(;;) {
> -        p =3D ps;
> -        *(p++) =3D '$';
> -        memcpy(p, buf, len);
> -        p +=3D len;
> +        g_byte_array_set_size(gdbserver_state.last_packet, 0);
> +        g_byte_array_append(gdbserver_state.last_packet,
> +                            (const uint8_t *) "$", 1);
> +        g_byte_array_append(gdbserver_state.last_packet,
> +                            (const uint8_t *) buf, len);
>           csum =3D 0;
>           for(i =3D 0; i < len; i++) {
>               csum +=3D buf[i];
>           }
> -        *(p++) =3D '#';
> -        *(p++) =3D tohex((csum >> 4) & 0xf);
> -        *(p++) =3D tohex((csum) & 0xf);
> +        footer[0] =3D '#';
> +        footer[1] =3D tohex((csum >> 4) & 0xf);
> +        footer[2] =3D tohex((csum) & 0xf);
> +        g_byte_array_append(gdbserver_state.last_packet, footer, 3);
>  =20
> -        gdbserver_state.last_packet_len =3D p - ps;
> -        put_buffer(ps, gdbserver_state.last_packet_len);
> +        put_buffer(gdbserver_state.last_packet->data,
> +                   gdbserver_state.last_packet->len);
>  =20
>   #ifdef CONFIG_USER_ONLY
>           i =3D get_char();
> @@ -2812,20 +2813,22 @@ static void gdb_read_byte(GDBState *s, uint8_t ch=
)
>       uint8_t reply;
>  =20
>   #ifndef CONFIG_USER_ONLY
> -    if (gdbserver_state.last_packet_len) {
> +    if (gdbserver_state.last_packet->len) {
>           /* Waiting for a response to the last packet.  If we see the st=
art
>              of a new command then abandon the previous response.  */
>           if (ch =3D=3D '-') {
>               trace_gdbstub_err_got_nack();
> -            put_buffer((uint8_t *)gdbserver_state.last_packet, gdbserver=
_state.last_packet_len);
> +            put_buffer(gdbserver_state.last_packet->data,
> +                       gdbserver_state.last_packet->len);
>           } else if (ch =3D=3D '+') {
>               trace_gdbstub_io_got_ack();
>           } else {
>               trace_gdbstub_io_got_unexpected(ch);
>           }
>  =20
> -        if (ch =3D=3D '+' || ch =3D=3D '$')
> -            gdbserver_state.last_packet_len =3D 0;
> +        if (ch =3D=3D '+' || ch =3D=3D '$') {
> +            g_byte_array_set_size(gdbserver_state.last_packet, 0);
> +        }
>           if (ch !=3D '$')
>               return;
>       }
> @@ -3209,7 +3212,7 @@ static int gdb_monitor_write(Chardev *chr, const ui=
nt8_t *buf, int len)
>       const char *p =3D (const char *)buf;
>       int max_sz;
>  =20
> -    max_sz =3D (sizeof(gdbserver_state.last_packet) - 2) / 2;
> +    max_sz =3D MAX_PACKET_LENGTH / 2;
>       for (;;) {
>           if (len <=3D max_sz) {
>               gdb_monitor_output(&gdbserver_state, p, len);
>=20

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>


