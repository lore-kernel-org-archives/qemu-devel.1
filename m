Return-Path: <SRS0=t76e=5M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72B67C43331
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2020 10:22:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E52A20705
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2020 10:22:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N1FRqdSo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E52A20705
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39774 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHm7m-0001HM-9r
	for qemu-devel@archiver.kernel.org; Fri, 27 Mar 2020 06:22:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43046)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <david@redhat.com>) id 1jHm79-0000d8-OP
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 06:21:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <david@redhat.com>) id 1jHm78-0000vg-1Q
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 06:21:23 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:33896)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <david@redhat.com>) id 1jHm77-0000sA-Oo
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 06:21:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585304480;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=xdI486iCYfN/mvsWm/Sr0Y8bnmd/677OppucsEAkWw4=;
 b=N1FRqdSoVQtBghUHuiIzCdOfjnojbmMCa7DI1XzvaRQXFuzSkpR16eI5BJB9PKQ10yAMLj
 AGZdae6a5/8J+9fWBxx2hnGwiSW2E/ZB6u7iM3L0/Jisa25nRj3YCBGDqT7x0YZYEsLrQJ
 3ekMJExyHJWtTZq3n2Joy1c7pceHxYs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-40-I2TdvZjsNjy50tihIUglCg-1; Fri, 27 Mar 2020 06:21:19 -0400
X-MC-Unique: I2TdvZjsNjy50tihIUglCg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 96217107B7DF;
 Fri, 27 Mar 2020 10:21:15 +0000 (UTC)
Received: from [10.36.112.108] (ovpn-112-108.ams2.redhat.com [10.36.112.108])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6263A19C69;
 Fri, 27 Mar 2020 10:21:14 +0000 (UTC)
Subject: Re: [PATCH 1/8] pc-bios: s390x: Consolidate timing functions into
 time.h
To: Janosch Frank <frankja@linux.ibm.com>, qemu-devel@nongnu.org
References: <20200324150847.10476-1-frankja@linux.ibm.com>
 <20200324150847.10476-2-frankja@linux.ibm.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; prefer-encrypt=mutual; keydata=
 mQINBFXLn5EBEAC+zYvAFJxCBY9Tr1xZgcESmxVNI/0ffzE/ZQOiHJl6mGkmA1R7/uUpiCjJ
 dBrn+lhhOYjjNefFQou6478faXE6o2AhmebqT4KiQoUQFV4R7y1KMEKoSyy8hQaK1umALTdL
 QZLQMzNE74ap+GDK0wnacPQFpcG1AE9RMq3aeErY5tujekBS32jfC/7AnH7I0v1v1TbbK3Gp
 XNeiN4QroO+5qaSr0ID2sz5jtBLRb15RMre27E1ImpaIv2Jw8NJgW0k/D1RyKCwaTsgRdwuK
 Kx/Y91XuSBdz0uOyU/S8kM1+ag0wvsGlpBVxRR/xw/E8M7TEwuCZQArqqTCmkG6HGcXFT0V9
 PXFNNgV5jXMQRwU0O/ztJIQqsE5LsUomE//bLwzj9IVsaQpKDqW6TAPjcdBDPLHvriq7kGjt
 WhVhdl0qEYB8lkBEU7V2Yb+SYhmhpDrti9Fq1EsmhiHSkxJcGREoMK/63r9WLZYI3+4W2rAc
 UucZa4OT27U5ZISjNg3Ev0rxU5UH2/pT4wJCfxwocmqaRr6UYmrtZmND89X0KigoFD/XSeVv
 jwBRNjPAubK9/k5NoRrYqztM9W6sJqrH8+UWZ1Idd/DdmogJh0gNC0+N42Za9yBRURfIdKSb
 B3JfpUqcWwE7vUaYrHG1nw54pLUoPG6sAA7Mehl3nd4pZUALHwARAQABtCREYXZpZCBIaWxk
 ZW5icmFuZCA8ZGF2aWRAcmVkaGF0LmNvbT6JAlgEEwEIAEICGwMFCQlmAYAGCwkIBwMCBhUI
 AgkKCwQWAgMBAh4BAheAFiEEG9nKrXNcTDpGDfzKTd4Q9wD/g1oFAl3pImkCGQEACgkQTd4Q
 9wD/g1o+VA//SFvIHUAvul05u6wKv/pIR6aICPdpF9EIgEU448g+7FfDgQwcEny1pbEzAmiw
 zAXIQ9H0NZh96lcq+yDLtONnXk/bEYWHHUA014A1wqcYNRY8RvY1+eVHb0uu0KYQoXkzvu+s
 Dncuguk470XPnscL27hs8PgOP6QjG4jt75K2LfZ0eAqTOUCZTJxA8A7E9+XTYuU0hs7QVrWJ
 jQdFxQbRMrYz7uP8KmTK9/Cnvqehgl4EzyRaZppshruKMeyheBgvgJd5On1wWq4ZUV5PFM4x
 II3QbD3EJfWbaJMR55jI9dMFa+vK7MFz3rhWOkEx/QR959lfdRSTXdxs8V3zDvChcmRVGN8U
 Vo93d1YNtWnA9w6oCW1dnDZ4kgQZZSBIjp6iHcA08apzh7DPi08jL7M9UQByeYGr8KuR4i6e
 RZI6xhlZerUScVzn35ONwOC91VdYiQgjemiVLq1WDDZ3B7DIzUZ4RQTOaIWdtXBWb8zWakt/
 ztGhsx0e39Gvt3391O1PgcA7ilhvqrBPemJrlb9xSPPRbaNAW39P8ws/UJnzSJqnHMVxbRZC
 Am4add/SM+OCP0w3xYss1jy9T+XdZa0lhUvJfLy7tNcjVG/sxkBXOaSC24MFPuwnoC9WvCVQ
 ZBxouph3kqc4Dt5X1EeXVLeba+466P1fe1rC8MbcwDkoUo65Ag0EVcufkQEQAOfX3n0g0fZz
 Bgm/S2zF/kxQKCEKP8ID+Vz8sy2GpDvveBq4H2Y34XWsT1zLJdvqPI4af4ZSMxuerWjXbVWb
 T6d4odQIG0fKx4F8NccDqbgHeZRNajXeeJ3R7gAzvWvQNLz4piHrO/B4tf8svmRBL0ZB5P5A
 2uhdwLU3NZuK22zpNn4is87BPWF8HhY0L5fafgDMOqnf4guJVJPYNPhUFzXUbPqOKOkL8ojk
 CXxkOFHAbjstSK5Ca3fKquY3rdX3DNo+EL7FvAiw1mUtS+5GeYE+RMnDCsVFm/C7kY8c2d0G
 NWkB9pJM5+mnIoFNxy7YBcldYATVeOHoY4LyaUWNnAvFYWp08dHWfZo9WCiJMuTfgtH9tc75
 7QanMVdPt6fDK8UUXIBLQ2TWr/sQKE9xtFuEmoQGlE1l6bGaDnnMLcYu+Asp3kDT0w4zYGsx
 5r6XQVRH4+5N6eHZiaeYtFOujp5n+pjBaQK7wUUjDilPQ5QMzIuCL4YjVoylWiBNknvQWBXS
 lQCWmavOT9sttGQXdPCC5ynI+1ymZC1ORZKANLnRAb0NH/UCzcsstw2TAkFnMEbo9Zu9w7Kv
 AxBQXWeXhJI9XQssfrf4Gusdqx8nPEpfOqCtbbwJMATbHyqLt7/oz/5deGuwxgb65pWIzufa
 N7eop7uh+6bezi+rugUI+w6DABEBAAGJAiUEGAECAA8FAlXLn5ECGwwFCQlmAYAACgkQTd4Q
 9wD/g1qA6w/+M+ggFv+JdVsz5+ZIc6MSyGUozASX+bmIuPeIecc9UsFRatc91LuJCKMkD9Uv
 GOcWSeFpLrSGRQ1Z7EMzFVU//qVs6uzhsNk0RYMyS0B6oloW3FpyQ+zOVylFWQCzoyyf227y
 GW8HnXunJSC+4PtlL2AY4yZjAVAPLK2l6mhgClVXTQ/S7cBoTQKP+jvVJOoYkpnFxWE9pn4t
 H5QIFk7Ip8TKr5k3fXVWk4lnUi9MTF/5L/mWqdyIO1s7cjharQCstfWCzWrVeVctpVoDfJWp
 4LwTuQ5yEM2KcPeElLg5fR7WB2zH97oI6/Ko2DlovmfQqXh9xWozQt0iGy5tWzh6I0JrlcxJ
 ileZWLccC4XKD1037Hy2FLAjzfoWgwBLA6ULu0exOOdIa58H4PsXtkFPrUF980EEibUp0zFz
 GotRVekFAceUaRvAj7dh76cToeZkfsjAvBVb4COXuhgX6N4pofgNkW2AtgYu1nUsPAo+NftU
 CxrhjHtLn4QEBpkbErnXQyMjHpIatlYGutVMS91XTQXYydCh5crMPs7hYVsvnmGHIaB9ZMfB
 njnuI31KBiLUks+paRkHQlFcgS2N3gkRBzH7xSZ+t7Re3jvXdXEzKBbQ+dC3lpJB0wPnyMcX
 FOTT3aZT7IgePkt5iC/BKBk3hqKteTnJFeVIT7EC+a6YUFg=
Organization: Red Hat GmbH
Message-ID: <f50723cb-0cb3-cd2a-bf6f-32afbf1bb975@redhat.com>
Date: Fri, 27 Mar 2020 11:21:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200324150847.10476-2-frankja@linux.ibm.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
Cc: borntraeger@de.ibm.com, qemu-s390x@nongnu.org, cohuck@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 24.03.20 16:08, Janosch Frank wrote:
> Let's consolidate timing related functions into one header.
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> ---
>  pc-bios/s390-ccw/menu.c        |  1 +
>  pc-bios/s390-ccw/netmain.c     | 15 +++----------
>  pc-bios/s390-ccw/s390-ccw.h    | 18 ----------------
>  pc-bios/s390-ccw/time.h        | 39 ++++++++++++++++++++++++++++++++++
>  pc-bios/s390-ccw/virtio-net.c  |  1 +
>  pc-bios/s390-ccw/virtio-scsi.c |  1 +
>  pc-bios/s390-ccw/virtio.c      | 18 +++-------------
>  7 files changed, 48 insertions(+), 45 deletions(-)
>  create mode 100644 pc-bios/s390-ccw/time.h
> 
> diff --git a/pc-bios/s390-ccw/menu.c b/pc-bios/s390-ccw/menu.c
> index ce3815b2010d20cb..7925c33248836913 100644
> --- a/pc-bios/s390-ccw/menu.c
> +++ b/pc-bios/s390-ccw/menu.c
> @@ -12,6 +12,7 @@
>  #include "libc.h"
>  #include "s390-ccw.h"
>  #include "sclp.h"
> +#include "time.h"
>  
>  #define KEYCODE_NO_INP '\0'
>  #define KEYCODE_ESCAPE '\033'
> diff --git a/pc-bios/s390-ccw/netmain.c b/pc-bios/s390-ccw/netmain.c
> index 309ffa30d9922077..a8e2b1b6233735d8 100644
> --- a/pc-bios/s390-ccw/netmain.c
> +++ b/pc-bios/s390-ccw/netmain.c
> @@ -35,6 +35,7 @@
>  #include "s390-ccw.h"
>  #include "cio.h"
>  #include "virtio.h"
> +#include "time.h"
>  
>  #define DEFAULT_BOOT_RETRIES 10
>  #define DEFAULT_TFTP_RETRIES 20
> @@ -57,24 +58,14 @@ static SubChannelId net_schid = { .one = 1 };
>  static uint8_t mac[6];
>  static uint64_t dest_timer;
>  
> -static uint64_t get_timer_ms(void)
> -{
> -    uint64_t clk;
> -
> -    asm volatile(" stck %0 " : : "Q"(clk) : "memory");
> -
> -    /* Bit 51 is incremented each microsecond */
> -    return (clk >> (63 - 51)) / 1000;
> -}
> -
>  void set_timer(int val)
>  {
> -    dest_timer = get_timer_ms() + val;
> +    dest_timer = get_time_milli() + val;
>  }
>  
>  int get_timer(void)
>  {
> -    return dest_timer - get_timer_ms();
> +    return dest_timer - get_time_milli();
>  }
>  
>  int get_sec_ticks(void)
> diff --git a/pc-bios/s390-ccw/s390-ccw.h b/pc-bios/s390-ccw/s390-ccw.h
> index 21f27e79906ea297..c5820e43aed143d0 100644
> --- a/pc-bios/s390-ccw/s390-ccw.h
> +++ b/pc-bios/s390-ccw/s390-ccw.h
> @@ -74,8 +74,6 @@ unsigned long virtio_load_direct(ulong rec_list1, ulong rec_list2,
>  bool virtio_is_supported(SubChannelId schid);
>  void virtio_blk_setup_device(SubChannelId schid);
>  int virtio_read(ulong sector, void *load_addr);
> -u64 get_clock(void);
> -ulong get_second(void);
>  
>  /* bootmap.c */
>  void zipl_load(void);
> @@ -144,24 +142,8 @@ static inline void debug_print_addr(const char *desc, void *p)
>  #define KVM_S390_VIRTIO_SET_STATUS      2
>  #define KVM_S390_VIRTIO_CCW_NOTIFY      3
>  
> -static inline void yield(void)
> -{
> -    asm volatile ("diag 0,0,0x44"
> -                  : :
> -                  : "memory", "cc");
> -}
> -
>  #define MAX_SECTOR_SIZE 4096
>  
> -static inline void sleep(unsigned int seconds)
> -{
> -    ulong target = get_second() + seconds;
> -
> -    while (get_second() < target) {
> -        yield();
> -    }
> -}
> -
>  static inline void IPL_assert(bool term, const char *message)
>  {
>      if (!term) {
> diff --git a/pc-bios/s390-ccw/time.h b/pc-bios/s390-ccw/time.h
> new file mode 100644
> index 0000000000000000..98f5acaa33b500bd
> --- /dev/null
> +++ b/pc-bios/s390-ccw/time.h
> @@ -0,0 +1,39 @@
> +#ifndef TIME_H
> +#define TIME_H
> +
> +static inline u64 get_clock(void)
> +{
> +    u64 r;
> +
> +    asm volatile("stck %0" : "=Q" (r) : : "cc");
> +    return r;
> +}
> +
> +static inline u64 get_time_milli(void)

Milli Vanilli?

Please, just use common abbreviations. "ms" is certainly good enough.


-- 
Thanks,

David / dhildenb


