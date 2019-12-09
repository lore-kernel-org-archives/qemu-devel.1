Return-Path: <SRS0=fi8h=Z7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 985BEC43603
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 10:18:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 61703206D5
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 10:18:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=greensocs.com header.i=@greensocs.com header.b="Q8kHiW1E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61703206D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=greensocs.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38188 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ieG78-00069I-1c
	for qemu-devel@archiver.kernel.org; Mon, 09 Dec 2019 05:18:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53239)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <luc.michel@greensocs.com>) id 1ieG4N-0005TJ-Kp
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 05:15:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <luc.michel@greensocs.com>) id 1ieG4L-0006hM-UC
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 05:15:11 -0500
Received: from beetle.greensocs.com ([5.135.226.135]:50000)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <luc.michel@greensocs.com>)
 id 1ieG4L-0006cH-B7
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 05:15:09 -0500
Received: from [172.16.11.100] (tiramisu.bar.greensocs.com [172.16.11.100])
 by beetle.greensocs.com (Postfix) with ESMTPSA id E636796EF0;
 Mon,  9 Dec 2019 10:15:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com;
 s=mail; t=1575886507;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rK2gNkWUrPZLLx9SFZED8eft87o9I5WzygBZak3Yq6M=;
 b=Q8kHiW1EV3u+Km/OjP6vpcY/qDps1n194ZnhNhzNhx24DIakp+oR9ciQ8wna9h5zbwunDU
 3cRsj5WCVMGRwo5Av9SoerRiNtZ+zQoA6YS6LpYvD01wjnQ4cyFmsLBm4B9VNde65nIQms
 ee2yOugfNWZEH5JSGJxiALoPIZg/XQI=
Subject: Re: [PATCH] gdbstub: change GDBState.last_packet to GByteArray
To: Damien Hedde <damien.hedde@greensocs.com>, qemu-devel@nongnu.org
References: <20191206134203.77385-1-damien.hedde@greensocs.com>
From: Luc Michel <luc.michel@greensocs.com>
Message-ID: <4b7e67f1-e3c4-44d3-db36-b371eeabe2b5@greensocs.com>
Date: Mon, 9 Dec 2019 11:15:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191206134203.77385-1-damien.hedde@greensocs.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-PH
Content-Transfer-Encoding: 7bit
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com; 
 s=mail; t=1575886507;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rK2gNkWUrPZLLx9SFZED8eft87o9I5WzygBZak3Yq6M=;
 b=pScsoDXQx218aN67AUxPRMuqrmRRr08YE3uB+noej6qrA7oRVOOkXJTUdQ5gTazAVIXRL2
 Yf4CRGLDwXU8uXGnA5sYMkRprVZr+pK/bN9dxRlaBtlHT7MhY+avyPcdxvWYeb9Ol4oz0z
 TkxUglnsC2afsAGUZhaxtu629QtW5tg=
ARC-Seal: i=1; s=mail; d=greensocs.com; t=1575886507; a=rsa-sha256; cv=none;
 b=Ph8goEO1ND9p4LJWWNJ5NhddUh7bFRs+BkhHBjZtJvOXbGyW26aG2HfimyyJcDX1GAHgtX
 BodP4EuA8gCMYKO2VFyS1tBG+0cBmTBgb9vi3IWMgVhV488ZXePmoPixhjx5/6sxh4Xjy9
 h7T94mofVwheX1FU0Zfkdx1F68yQzc8=
ARC-Authentication-Results: i=1; ORIGINATING;
 auth=pass smtp.auth=luc smtp.mailfrom=luc.michel@greensocs.com
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



On 12/6/19 2:42 PM, Damien Hedde wrote:
> Remove the packet size upper limit by using a GByteArray
> instead of a statically allocated array for last_packet.
> Thus we can now send big packets.
> 
> Also remove the last_packet_len field and use last_packet->len
> instead.
> 
> Signed-off-by: Damien Hedde <damien.hedde@greensocs.com>
> ---
> 
> This patch is a follow-up of Alex's series about sve registers
> which introduces some GbyteArray/Gstring in the gdbstub.
> It removes the remaining barrier to send big packets.
> 
> Based-on <20191130084602.10818-1-alex.bennee@linaro.org>
> ---
>  gdbstub.c | 39 +++++++++++++++++++++------------------
>  1 file changed, 21 insertions(+), 18 deletions(-)
> 
> diff --git a/gdbstub.c b/gdbstub.c
> index 7b695bdebe..022edd6bdb 100644
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
>      gdbserver_state.init = true;
>      gdbserver_state.str_buf = g_string_new(NULL);
>      gdbserver_state.mem_buf = g_byte_array_sized_new(MAX_PACKET_LENGTH);
> +    gdbserver_state.last_packet = g_byte_array_sized_new(MAX_PACKET_LENGTH + 4);
>  }
>  
>  #ifndef CONFIG_USER_ONLY
> @@ -626,28 +626,29 @@ static void hexdump(const char *buf, int len,
>  static int put_packet_binary(const char *buf, int len, bool dump)
>  {
>      int csum, i;
> -    uint8_t *p;
> -    uint8_t *ps = &gdbserver_state.last_packet[0];
> +    uint8_t footer[3];
>  
>      if (dump && trace_event_get_state_backends(TRACE_GDBSTUB_IO_BINARYREPLY)) {
>          hexdump(buf, len, trace_gdbstub_io_binaryreply);
>      }
>  
>      for(;;) {
> -        p = ps;
> -        *(p++) = '$';
> -        memcpy(p, buf, len);
> -        p += len;
> +        g_byte_array_set_size(gdbserver_state.last_packet, 0);
> +        g_byte_array_append(gdbserver_state.last_packet,
> +                            (const uint8_t *) "$", 1);
> +        g_byte_array_append(gdbserver_state.last_packet,
> +                            (const uint8_t *) buf, len);
>          csum = 0;
>          for(i = 0; i < len; i++) {
>              csum += buf[i];
>          }
> -        *(p++) = '#';
> -        *(p++) = tohex((csum >> 4) & 0xf);
> -        *(p++) = tohex((csum) & 0xf);
> +        footer[0] = '#';
> +        footer[1] = tohex((csum >> 4) & 0xf);
> +        footer[2] = tohex((csum) & 0xf);
> +        g_byte_array_append(gdbserver_state.last_packet, footer, 3);
>  
> -        gdbserver_state.last_packet_len = p - ps;
> -        put_buffer(ps, gdbserver_state.last_packet_len);
> +        put_buffer(gdbserver_state.last_packet->data,
> +                   gdbserver_state.last_packet->len);
>  
>  #ifdef CONFIG_USER_ONLY
>          i = get_char();
> @@ -2812,20 +2813,22 @@ static void gdb_read_byte(GDBState *s, uint8_t ch)
>      uint8_t reply;
>  
>  #ifndef CONFIG_USER_ONLY
> -    if (gdbserver_state.last_packet_len) {
> +    if (gdbserver_state.last_packet->len) {
>          /* Waiting for a response to the last packet.  If we see the start
>             of a new command then abandon the previous response.  */
>          if (ch == '-') {
>              trace_gdbstub_err_got_nack();
> -            put_buffer((uint8_t *)gdbserver_state.last_packet, gdbserver_state.last_packet_len);
> +            put_buffer(gdbserver_state.last_packet->data,
> +                       gdbserver_state.last_packet->len);
>          } else if (ch == '+') {
>              trace_gdbstub_io_got_ack();
>          } else {
>              trace_gdbstub_io_got_unexpected(ch);
>          }
>  
> -        if (ch == '+' || ch == '$')
> -            gdbserver_state.last_packet_len = 0;
> +        if (ch == '+' || ch == '$') {
> +            g_byte_array_set_size(gdbserver_state.last_packet, 0);
> +        }
>          if (ch != '$')
>              return;
>      }
> @@ -3209,7 +3212,7 @@ static int gdb_monitor_write(Chardev *chr, const uint8_t *buf, int len)
>      const char *p = (const char *)buf;
>      int max_sz;
>  
> -    max_sz = (sizeof(gdbserver_state.last_packet) - 2) / 2;
> +    max_sz = MAX_PACKET_LENGTH / 2;
I think max_sz is not the same as before here.

Before we had (sizeof(gdbserver_state.last_packet) - 2) / 2
           -> ((MAX_PACKET_LENGTH + 4) - 2) / 2
           -> (MAX_PACKET_LENGTH / 2) + 1

Now we have MAX_PACKET_LENGTH / 2

But looking at the gdb_monitor_output() function, it performs the
following check:
    if (len > (MAX_PACKET_LENGTH/2) - 1)
        len = (MAX_PACKET_LENGTH/2) - 1;

So both versions seem actually wrong and can lead to characters being
dropped.

However gdb_monitor_output() is still using a MAX_PACKET_LENGTH sized
local buffer. With this patch it can probably be removed entirely so
that last_packet is written directly (with a g_byte_array aware version
of memtohex?).

-- 
Luc

>      for (;;) {
>          if (len <= max_sz) {
>              gdb_monitor_output(&gdbserver_state, p, len);
> 

