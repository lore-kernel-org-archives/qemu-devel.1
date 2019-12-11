Return-Path: <SRS0=Q6KP=2B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19D3AC43603
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2019 14:14:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D96E9214AF
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2019 14:14:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=greensocs.com header.i=@greensocs.com header.b="CZ1F+oAk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D96E9214AF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=greensocs.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43080 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1if2ky-0001eP-2d
	for qemu-devel@archiver.kernel.org; Wed, 11 Dec 2019 09:14:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43129)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <damien.hedde@greensocs.com>) id 1if2i4-0000js-J5
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 09:11:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <damien.hedde@greensocs.com>) id 1if2i2-0007Mc-OC
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 09:11:24 -0500
Received: from beetle.greensocs.com ([5.135.226.135]:45260)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <damien.hedde@greensocs.com>)
 id 1if2i2-0007Kw-4K
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 09:11:22 -0500
Received: from [172.16.11.102] (crumble.bar.greensocs.com [172.16.11.102])
 by beetle.greensocs.com (Postfix) with ESMTPSA id 1054196EF0;
 Wed, 11 Dec 2019 14:11:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com;
 s=mail; t=1576073479;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zxBwkv3zg1HY6xig9PokwgpvT5ZZ839Y2wL/0gQQMLE=;
 b=CZ1F+oAkuu2sRi8ZJdOFBOfWsAqiauBGgy7LKvTd9TQ+KKm9fe0EuR5wvVKP0YTD32ZzFt
 oAca0TCCBBbf25Oc0XMwxHgmqrwfxRzk8B7AWcFUFrSxyunNITPkBe/Fy88m6a9/nFr82c
 qxDr58pSidQ6AivuXTMU/ZZNBAdXITY=
Subject: Re: [PATCH] gdbstub: change GDBState.last_packet to GByteArray
To: Luc Michel <luc.michel@greensocs.com>, qemu-devel@nongnu.org
References: <20191206134203.77385-1-damien.hedde@greensocs.com>
 <4b7e67f1-e3c4-44d3-db36-b371eeabe2b5@greensocs.com>
From: Damien Hedde <damien.hedde@greensocs.com>
Message-ID: <b2c5113c-d76e-8634-65d3-242d8375e7b4@greensocs.com>
Date: Wed, 11 Dec 2019 15:11:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <4b7e67f1-e3c4-44d3-db36-b371eeabe2b5@greensocs.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US-large
Content-Transfer-Encoding: 7bit
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com; 
 s=mail; t=1576073479;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zxBwkv3zg1HY6xig9PokwgpvT5ZZ839Y2wL/0gQQMLE=;
 b=MA03w+qEd+ZDeTo+QzeMWS3Hzmz56eta3EyXn64jdRwiMMqPJa/mhABYGUv6mhaCd5Udx7
 N2efjsYenpUKewH3EV9f8l0VfPnnvjCcUJV2xiWBsxfqslqyYqTK9LkChj2uIx9brp5ZYQ
 Q2VxU5kCLhn50Y+o1FvCzFGg0hACq8c=
ARC-Seal: i=1; s=mail; d=greensocs.com; t=1576073479; a=rsa-sha256; cv=none;
 b=MEIftNtQ20WWZVxCHyPHz4DSbldRV7z7/fapDliLXA9l1thYJ4gzguZu/bothsjwrLt2lk
 1+kPHkt4e9CqmsdBZBKN1coJTOmmMDJ3SosopHb6s5QIq6bZYk7qJg1P+X+bIrepIdJjdQ
 HG4l3dvTQNCElJiZH9KdxuLFcqWHEX4=
ARC-Authentication-Results: i=1; ORIGINATING;
 auth=pass smtp.auth=damien smtp.mailfrom=damien.hedde@greensocs.com
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


On 12/9/19 11:15 AM, Luc Michel wrote:
> 
> 
> On 12/6/19 2:42 PM, Damien Hedde wrote:
>> Remove the packet size upper limit by using a GByteArray
>> instead of a statically allocated array for last_packet.
>> Thus we can now send big packets.
>>
>> Also remove the last_packet_len field and use last_packet->len
>> instead.
>>
>> Signed-off-by: Damien Hedde <damien.hedde@greensocs.com>
>> ---
>>
>> This patch is a follow-up of Alex's series about sve registers
>> which introduces some GbyteArray/Gstring in the gdbstub.
>> It removes the remaining barrier to send big packets.
>>
>> Based-on <20191130084602.10818-1-alex.bennee@linaro.org>
>> ---
>>  gdbstub.c | 39 +++++++++++++++++++++------------------
>>  1 file changed, 21 insertions(+), 18 deletions(-)
>>
>> diff --git a/gdbstub.c b/gdbstub.c
>> index 7b695bdebe..022edd6bdb 100644
>> --- a/gdbstub.c
>> +++ b/gdbstub.c
>> @@ -351,8 +351,7 @@ typedef struct GDBState {
>>      int line_buf_index;
>>      int line_sum; /* running checksum */
>>      int line_csum; /* checksum at the end of the packet */
>> -    uint8_t last_packet[MAX_PACKET_LENGTH + 4];
>> -    int last_packet_len;
>> +    GByteArray *last_packet;
>>      int signal;
>>  #ifdef CONFIG_USER_ONLY
>>      int fd;
>> @@ -384,6 +383,7 @@ static void init_gdbserver_state(void)
>>      gdbserver_state.init = true;
>>      gdbserver_state.str_buf = g_string_new(NULL);
>>      gdbserver_state.mem_buf = g_byte_array_sized_new(MAX_PACKET_LENGTH);
>> +    gdbserver_state.last_packet = g_byte_array_sized_new(MAX_PACKET_LENGTH + 4);
>>  }
>>  
>>  #ifndef CONFIG_USER_ONLY
>> @@ -626,28 +626,29 @@ static void hexdump(const char *buf, int len,
>>  static int put_packet_binary(const char *buf, int len, bool dump)
>>  {
>>      int csum, i;
>> -    uint8_t *p;
>> -    uint8_t *ps = &gdbserver_state.last_packet[0];
>> +    uint8_t footer[3];
>>  
>>      if (dump && trace_event_get_state_backends(TRACE_GDBSTUB_IO_BINARYREPLY)) {
>>          hexdump(buf, len, trace_gdbstub_io_binaryreply);
>>      }
>>  
>>      for(;;) {
>> -        p = ps;
>> -        *(p++) = '$';
>> -        memcpy(p, buf, len);
>> -        p += len;
>> +        g_byte_array_set_size(gdbserver_state.last_packet, 0);
>> +        g_byte_array_append(gdbserver_state.last_packet,
>> +                            (const uint8_t *) "$", 1);
>> +        g_byte_array_append(gdbserver_state.last_packet,
>> +                            (const uint8_t *) buf, len);
>>          csum = 0;
>>          for(i = 0; i < len; i++) {
>>              csum += buf[i];
>>          }
>> -        *(p++) = '#';
>> -        *(p++) = tohex((csum >> 4) & 0xf);
>> -        *(p++) = tohex((csum) & 0xf);
>> +        footer[0] = '#';
>> +        footer[1] = tohex((csum >> 4) & 0xf);
>> +        footer[2] = tohex((csum) & 0xf);
>> +        g_byte_array_append(gdbserver_state.last_packet, footer, 3);
>>  
>> -        gdbserver_state.last_packet_len = p - ps;
>> -        put_buffer(ps, gdbserver_state.last_packet_len);
>> +        put_buffer(gdbserver_state.last_packet->data,
>> +                   gdbserver_state.last_packet->len);
>>  
>>  #ifdef CONFIG_USER_ONLY
>>          i = get_char();
>> @@ -2812,20 +2813,22 @@ static void gdb_read_byte(GDBState *s, uint8_t ch)
>>      uint8_t reply;
>>  
>>  #ifndef CONFIG_USER_ONLY
>> -    if (gdbserver_state.last_packet_len) {
>> +    if (gdbserver_state.last_packet->len) {
>>          /* Waiting for a response to the last packet.  If we see the start
>>             of a new command then abandon the previous response.  */
>>          if (ch == '-') {
>>              trace_gdbstub_err_got_nack();
>> -            put_buffer((uint8_t *)gdbserver_state.last_packet, gdbserver_state.last_packet_len);
>> +            put_buffer(gdbserver_state.last_packet->data,
>> +                       gdbserver_state.last_packet->len);
>>          } else if (ch == '+') {
>>              trace_gdbstub_io_got_ack();
>>          } else {
>>              trace_gdbstub_io_got_unexpected(ch);
>>          }
>>  
>> -        if (ch == '+' || ch == '$')
>> -            gdbserver_state.last_packet_len = 0;
>> +        if (ch == '+' || ch == '$') {
>> +            g_byte_array_set_size(gdbserver_state.last_packet, 0);
>> +        }
>>          if (ch != '$')
>>              return;
>>      }
>> @@ -3209,7 +3212,7 @@ static int gdb_monitor_write(Chardev *chr, const uint8_t *buf, int len)
>>      const char *p = (const char *)buf;
>>      int max_sz;
>>  
>> -    max_sz = (sizeof(gdbserver_state.last_packet) - 2) / 2;
>> +    max_sz = MAX_PACKET_LENGTH / 2;
> I think max_sz is not the same as before here.
> 
> Before we had (sizeof(gdbserver_state.last_packet) - 2) / 2
>            -> ((MAX_PACKET_LENGTH + 4) - 2) / 2
>            -> (MAX_PACKET_LENGTH / 2) + 1
> 
> Now we have MAX_PACKET_LENGTH / 2

Oups... I'll fix that.

> 
> But looking at the gdb_monitor_output() function, it performs the
> following check:
>     if (len > (MAX_PACKET_LENGTH/2) - 1)
>         len = (MAX_PACKET_LENGTH/2) - 1;
> 
> So both versions seem actually wrong and can lead to characters being
> dropped.
> 
> However gdb_monitor_output() is still using a MAX_PACKET_LENGTH sized
> local buffer. With this patch it can probably be removed entirely so
> that last_packet is written directly (with a g_byte_array aware version
> of memtohex?).
> 
Actually, Alex's patches (on which this patch is based) already do the
memtohex aware version. But yes we can simplify this, I'll prepare a v2
with this.

Thanks,
--
Damien

