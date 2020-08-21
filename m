Return-Path: <SRS0=atk5=B7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34561C433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 12:51:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F40C32078D
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 12:51:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HmCds9Tq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F40C32078D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57520 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k96Vy-0007HQ-AP
	for qemu-devel@archiver.kernel.org; Fri, 21 Aug 2020 08:51:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37346)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k96VP-0006ql-GD
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 08:50:51 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:60293
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k96VM-0003gS-PM
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 08:50:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598014247;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=DU1Cvg4OCrJeja98fgQIL3pqTiCyMLnj63sB+ThcV1A=;
 b=HmCds9TqJqqNrGgdOW+ND7PjszbfAPtNFWiAkPedKNiIEpi8n5sPlETwtViZsrYoztu842
 lSSps1nC0xoL1m9l348JKQR3K7SFcPFoZCiWAm4JdGZl1juHF6gERe7VxWjHaLtN2d6KQ8
 Un0JVNqJbAZqsTSRQ+CjhM1nNdcEON8=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-126-O1hWUppiOGqcGFoZo9gmVg-1; Fri, 21 Aug 2020 08:50:45 -0400
X-MC-Unique: O1hWUppiOGqcGFoZo9gmVg-1
Received: by mail-wr1-f72.google.com with SMTP id r29so522278wrr.10
 for <qemu-devel@nongnu.org>; Fri, 21 Aug 2020 05:50:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=DU1Cvg4OCrJeja98fgQIL3pqTiCyMLnj63sB+ThcV1A=;
 b=bv+aRSMbHK7O0N52NypzZWsmqnL3zb2Ut3FsOSAYvKggZX7UG9rZ0P5Pv16H2Dm7zt
 iF6Y7+oTY0091GqavMBcRajZG1cZKpkrPALka6pOaXjLWXvveedJ72UFuOCv6hE1c37T
 RQ/9dIpxm5wzTGhspEYRm5RqEXEpnSW8c33SYLboXrzG5A4EN22Suxm+JThd7fqiUuEK
 VCC0mjHSo7/9TkZw/GCOxQdZOaihEckwZcD2h4dKfdmQxGl8kKjPpjMIRVX1qMi7MUWY
 ZsMYC7lz9RNo/do6zn+NhdQhtUGRabfrnW0gd+nW8EsGjNRDQ9F2QeyBcwchcjmyujh3
 r2cQ==
X-Gm-Message-State: AOAM532DgAxqkjxiazmKYZA+VaZJcDqEv+ZIupc9lzZ46S+QLA21uPpr
 sus/yxXyDGsTminVfSvXBgdSV9jQssaKD4qu3S6C/SEwtvN+bWijIj5Pg6Yk6jq1vFl9dnW0np5
 /E08eZweEZAxDrKY=
X-Received: by 2002:adf:f045:: with SMTP id t5mr2756628wro.288.1598014244359; 
 Fri, 21 Aug 2020 05:50:44 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwzDb2iUTIDiktaa2k9FrBPmuu/eC+LWXYgbdt7iEzWSmJ0bjO5J79SUvsnzh3wJOnh2Qy6Ng==
X-Received: by 2002:adf:f045:: with SMTP id t5mr2756608wro.288.1598014244081; 
 Fri, 21 Aug 2020 05:50:44 -0700 (PDT)
Received: from [192.168.1.36] (121.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.121])
 by smtp.gmail.com with ESMTPSA id w10sm5171064wmk.0.2020.08.21.05.50.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 21 Aug 2020 05:50:43 -0700 (PDT)
Subject: Re: [PATCH 2/3] hostmem-file: add readonly=on|off option
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
References: <20200804101244.1283503-1-stefanha@redhat.com>
 <20200804101244.1283503-3-stefanha@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Autocrypt: addr=philmd@redhat.com; keydata=
 mQINBDXML8YBEADXCtUkDBKQvNsQA7sDpw6YLE/1tKHwm24A1au9Hfy/OFmkpzo+MD+dYc+7
 bvnqWAeGweq2SDq8zbzFZ1gJBd6+e5v1a/UrTxvwBk51yEkadrpRbi+r2bDpTJwXc/uEtYAB
 GvsTZMtiQVA4kRID1KCdgLa3zztPLCj5H1VZhqZsiGvXa/nMIlhvacRXdbgllPPJ72cLUkXf
 z1Zu4AkEKpccZaJspmLWGSzGu6UTZ7UfVeR2Hcc2KI9oZB1qthmZ1+PZyGZ/Dy+z+zklC0xl
 XIpQPmnfy9+/1hj1LzJ+pe3HzEodtlVA+rdttSvA6nmHKIt8Ul6b/h1DFTmUT1lN1WbAGxmg
 CH1O26cz5nTrzdjoqC/b8PpZiT0kO5MKKgiu5S4PRIxW2+RA4H9nq7nztNZ1Y39bDpzwE5Sp
 bDHzd5owmLxMLZAINtCtQuRbSOcMjZlg4zohA9TQP9krGIk+qTR+H4CV22sWldSkVtsoTaA2
 qNeSJhfHQY0TyQvFbqRsSNIe2gTDzzEQ8itsmdHHE/yzhcCVvlUzXhAT6pIN0OT+cdsTTfif
 MIcDboys92auTuJ7U+4jWF1+WUaJ8gDL69ThAsu7mGDBbm80P3vvUZ4fQM14NkxOnuGRrJxO
 qjWNJ2ZUxgyHAh5TCxMLKWZoL5hpnvx3dF3Ti9HW2dsUUWICSQARAQABtDJQaGlsaXBwZSBN
 YXRoaWV1LURhdWTDqSAoUGhpbCkgPHBoaWxtZEByZWRoYXQuY29tPokCVQQTAQgAPwIbDwYL
 CQgHAwIGFQgCCQoLBBYCAwECHgECF4AWIQSJweePYB7obIZ0lcuio/1u3q3A3gUCXsfWwAUJ
 KtymWgAKCRCio/1u3q3A3ircD/9Vjh3aFNJ3uF3hddeoFg1H038wZr/xi8/rX27M1Vj2j9VH
 0B8Olp4KUQw/hyO6kUxqkoojmzRpmzvlpZ0cUiZJo2bQIWnvScyHxFCv33kHe+YEIqoJlaQc
 JfKYlbCoubz+02E2A6bFD9+BvCY0LBbEj5POwyKGiDMjHKCGuzSuDRbCn0Mz4kCa7nFMF5Jv
 piC+JemRdiBd6102ThqgIsyGEBXuf1sy0QIVyXgaqr9O2b/0VoXpQId7yY7OJuYYxs7kQoXI
 6WzSMpmuXGkmfxOgbc/L6YbzB0JOriX0iRClxu4dEUg8Bs2pNnr6huY2Ft+qb41RzCJvvMyu
 gS32LfN0bTZ6Qm2A8ayMtUQgnwZDSO23OKgQWZVglGliY3ezHZ6lVwC24Vjkmq/2yBSLakZE
 6DZUjZzCW1nvtRK05ebyK6tofRsx8xB8pL/kcBb9nCuh70aLR+5cmE41X4O+MVJbwfP5s/RW
 9BFSL3qgXuXso/3XuWTQjJJGgKhB6xXjMmb1J4q/h5IuVV4juv1Fem9sfmyrh+Wi5V1IzKI7
 RPJ3KVb937eBgSENk53P0gUorwzUcO+ASEo3Z1cBKkJSPigDbeEjVfXQMzNt0oDRzpQqH2vp
 apo2jHnidWt8BsckuWZpxcZ9+/9obQ55DyVQHGiTN39hkETy3Emdnz1JVHTU0Q==
Message-ID: <8f7b344e-87a5-3260-ae71-96758270fb27@redhat.com>
Date: Fri, 21 Aug 2020 14:50:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200804101244.1283503-3-stefanha@redhat.com>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/20 23:41:39
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: Xiao Guangrong <xiaoguangrong.eric@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Julio Montes <julio.montes@intel.com>,
 Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/4/20 12:12 PM, Stefan Hajnoczi wrote:
> Let -object memory-backend-file work on read-only files when the
> readonly=on option is given. This can be used to share the contents of a
> file between multiple guests while preventing them from consuming
> Copy-on-Write memory if guests dirty the pages, for example.
> 
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  backends/hostmem-file.c | 26 +++++++++++++++++++++++++-
>  qemu-options.hx         |  5 ++++-
>  2 files changed, 29 insertions(+), 2 deletions(-)
> 
> diff --git a/backends/hostmem-file.c b/backends/hostmem-file.c
> index 37c70acfe2..6bd5bf9b91 100644
> --- a/backends/hostmem-file.c
> +++ b/backends/hostmem-file.c
> @@ -30,6 +30,7 @@ struct HostMemoryBackendFile {
>      uint64_t align;
>      bool discard_data;
>      bool is_pmem;
> +    bool readonly;
>  };
>  
>  static void
> @@ -57,7 +58,7 @@ file_backend_memory_alloc(HostMemoryBackend *backend, Error **errp)
>                                       backend->size, fb->align,
>                                       (backend->share ? RAM_SHARED : 0) |
>                                       (fb->is_pmem ? RAM_PMEM : 0),
> -                                     fb->mem_path, false, errp);
> +                                     fb->mem_path, fb->readonly, errp);
>      g_free(name);
>  #endif
>  }
> @@ -152,6 +153,26 @@ static void file_memory_backend_set_pmem(Object *o, bool value, Error **errp)
>      fb->is_pmem = value;
>  }
>  
> +static bool file_memory_backend_get_readonly(Object *o, Error **errp)
> +{
> +    return MEMORY_BACKEND_FILE(o)->readonly;
> +}
> +
> +static void file_memory_backend_set_readonly(Object *o, bool value,
> +                                             Error **errp)
> +{
> +    HostMemoryBackend *backend = MEMORY_BACKEND(o);
> +    HostMemoryBackendFile *fb = MEMORY_BACKEND_FILE(o);
> +
> +    if (host_memory_backend_mr_inited(backend)) {
> +        error_setg(errp, "cannot change property 'readonly' of %s.",
> +                   object_get_typename(o));


The 'host_memory_backend_mr_inited()' function is not documented;
my understanding is a backend is considered initialized once it has
a MemoryRegion assigned to it.

So this error message is not very helpful, it doesn't explain the
reason. I see all other setters in this file use the same error,
so it is almost a predating issue.

Still I'd rather use a different message, something like:
"'%s' already initialized, can not set it 'readonly'".

Preferably with the error message reworded:
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> +        return;
> +    }
> +
> +    fb->readonly = value;
> +}
> +
>  static void file_backend_unparent(Object *obj)
>  {
>      HostMemoryBackend *backend = MEMORY_BACKEND(obj);
> @@ -183,6 +204,9 @@ file_backend_class_init(ObjectClass *oc, void *data)
>          NULL, NULL);
>      object_class_property_add_bool(oc, "pmem",
>          file_memory_backend_get_pmem, file_memory_backend_set_pmem);
> +    object_class_property_add_bool(oc, "readonly",
> +        file_memory_backend_get_readonly,
> +        file_memory_backend_set_readonly);
>  }
>  
>  static void file_backend_instance_finalize(Object *o)
> diff --git a/qemu-options.hx b/qemu-options.hx
> index 708583b4ce..d834e00b0d 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -4369,7 +4369,7 @@ SRST
>      they are specified. Note that the 'id' property must be set. These
>      objects are placed in the '/objects' path.
>  
> -    ``-object memory-backend-file,id=id,size=size,mem-path=dir,share=on|off,discard-data=on|off,merge=on|off,dump=on|off,prealloc=on|off,host-nodes=host-nodes,policy=default|preferred|bind|interleave,align=align``
> +    ``-object memory-backend-file,id=id,size=size,mem-path=dir,share=on|off,discard-data=on|off,merge=on|off,dump=on|off,prealloc=on|off,host-nodes=host-nodes,policy=default|preferred|bind|interleave,align=align,readonly=on|off``
>          Creates a memory file backend object, which can be used to back
>          the guest RAM with huge pages.
>  
> @@ -4452,6 +4452,9 @@ SRST
>          4.15) and the filesystem of ``mem-path`` mounted with DAX
>          option.
>  
> +        The ``readonly`` option specifies whether the backing file is opened
> +        read-only or read-write (default).
> +
>      ``-object memory-backend-ram,id=id,merge=on|off,dump=on|off,share=on|off,prealloc=on|off,size=size,host-nodes=host-nodes,policy=default|preferred|bind|interleave``
>          Creates a memory backend object, which can be used to back the
>          guest RAM. Memory backend objects offer more control than the
> 


