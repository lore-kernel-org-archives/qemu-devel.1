Return-Path: <SRS0=Q6KP=2B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFB97C43603
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2019 19:01:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B84B020836
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2019 19:01:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="chXxu/km"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B84B020836
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48020 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1if7EY-0004ud-Id
	for qemu-devel@archiver.kernel.org; Wed, 11 Dec 2019 14:01:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41754)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1if7Cb-0003G1-9w
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 13:59:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1if7Ca-00022S-5I
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 13:59:13 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:20459
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1if7C8-0001uo-40
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 13:59:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576090723;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=l3ltQxB1nZ5TUtcXPnUx1OAoc/lTuv9KR/2gZ+b69MI=;
 b=chXxu/kmVygqsl8+BqIhnvOd8i6r3LGnhQIQjz9Q3eAH5k8n8h6hbhToteeuZ2pk+1bSal
 Jf9WZ/i8wtE/g2KTN6ydIjHLT85WrMYu8jXCXdCA11tz6PF/fA5m0LP/Eyl44QU2OyYkOY
 Scgj4+iHvXv+7sxazf2QvsKM7LImMg8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-201-6YD1xRlBO5SA-n8c-EBy-g-1; Wed, 11 Dec 2019 13:58:42 -0500
Received: by mail-wr1-f69.google.com with SMTP id c6so10727229wrm.18
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2019 10:58:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=l3ltQxB1nZ5TUtcXPnUx1OAoc/lTuv9KR/2gZ+b69MI=;
 b=fhYstJMZQ8gAZqrRPdmE73QdGlewH+4338/cU0LlZdLuePIKwWlUF5Ib+BGZyCKeX+
 2VdyVv0DVt8twHDWBRavrQFeyToYvznyB2zXoCyC0Gak5VvXdyhSUhsTvDAG5opx6wUJ
 2oQ3lMnWWUqtF5yZ1H4L7aUrkjiT3ym4s60RycNGpWZNkwD5IY+yc1bYqG7oTTngDMM7
 rdkjbdLJa4pJW8GBX+gsN6F2ZXzzsNA3WO6F1eoYVlSqTBmDFeHTK8c0obC0mQox8QwS
 ktrZvZOM7251C6PWzWlkN1SJi5FaiWAgtaNeC6+wMrFnIb1CBREkQS/BRQCR/3UZUBA8
 2NCw==
X-Gm-Message-State: APjAAAUarEVHebEXP7LGwiSEdM8C/Lj+ZsJEMu9k10cGAFnZkHCWeODQ
 h+gQ3Pk8h8CQDQI2Yd4kC7TH68iKl7ofo8l1cMOjgKZhezxhNuK16yiuGXJb2ugmeLP79R6JCTo
 s1oh0hxRh5KZlTkE=
X-Received: by 2002:a1c:ded6:: with SMTP id v205mr1248939wmg.86.1576090721213; 
 Wed, 11 Dec 2019 10:58:41 -0800 (PST)
X-Google-Smtp-Source: APXvYqxU/wDixVREsQvMC1lpMLrgCyrURBAUptVuwLlvh0L/Rc/2xNjDrHCSLLbJ2doDpREpUZsziw==
X-Received: by 2002:a1c:ded6:: with SMTP id v205mr1248927wmg.86.1576090720987; 
 Wed, 11 Dec 2019 10:58:40 -0800 (PST)
Received: from [192.168.1.35] (182.red-88-21-103.staticip.rima-tde.net.
 [88.21.103.182])
 by smtp.gmail.com with ESMTPSA id l2sm3269770wmi.5.2019.12.11.10.58.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Dec 2019 10:58:40 -0800 (PST)
Subject: Re: [PATCH v2 2/2] gdbstub: do not split gdb_monitor_write payload
To: Damien Hedde <damien.hedde@greensocs.com>, qemu-devel@nongnu.org
References: <20191211160514.58373-1-damien.hedde@greensocs.com>
 <20191211160514.58373-3-damien.hedde@greensocs.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <e1b2e3a7-a40a-3e0f-ce83-bfacd28aedeb@redhat.com>
Date: Wed, 11 Dec 2019 19:58:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191211160514.58373-3-damien.hedde@greensocs.com>
Content-Language: en-US
X-MC-Unique: 6YD1xRlBO5SA-n8c-EBy-g-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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

On 12/11/19 5:05 PM, Damien Hedde wrote:
> Since we can now send packets of arbitrary length:
> simplify gdb_monitor_write() and send the whole payload
> in one packet.

While we can send arbitrary length on the wire, we advertise 
PacketSize=MAX_PACKET_LENGTH in handle_query_supported().

We can raise this limit however.

> Suggested-by: Luc Michel <luc.michel@greensocs.com>
> Signed-off-by: Damien Hedde <damien.hedde@greensocs.com>
> ---
>   gdbstub.c | 23 +++--------------------
>   1 file changed, 3 insertions(+), 20 deletions(-)
> 
> diff --git a/gdbstub.c b/gdbstub.c
> index 93b26f1b86..ef999abee2 100644
> --- a/gdbstub.c
> +++ b/gdbstub.c
> @@ -3200,28 +3200,11 @@ static void gdb_chr_event(void *opaque, int event)
>       }
>   }
>   
> -static void gdb_monitor_output(GDBState *s, const char *msg, int len)
> -{
> -    g_autoptr(GString) buf = g_string_new("O");
> -    memtohex(buf, (uint8_t *)msg, len);
> -    put_packet(buf->str);
> -}
> -
>   static int gdb_monitor_write(Chardev *chr, const uint8_t *buf, int len)
>   {
> -    const char *p = (const char *)buf;
> -    int max_sz;
> -
> -    max_sz = (MAX_PACKET_LENGTH / 2) + 1;
> -    for (;;) {
> -        if (len <= max_sz) {
> -            gdb_monitor_output(&gdbserver_state, p, len);
> -            break;
> -        }
> -        gdb_monitor_output(&gdbserver_state, p, max_sz);
> -        p += max_sz;
> -        len -= max_sz;
> -    }
> +    g_autoptr(GString) hex_buf = g_string_new("O");
> +    memtohex(hex_buf, buf, len);
> +    put_packet(hex_buf->str);
>       return len;
>   }
>   
> 


