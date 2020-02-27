Return-Path: <SRS0=0TZc=4P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BE0EC11D3D
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 19:18:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EEF0D24680
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 19:18:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d8Dhk6w5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EEF0D24680
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37124 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7OgG-00018x-0p
	for qemu-devel@archiver.kernel.org; Thu, 27 Feb 2020 14:18:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43846)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j7Of9-0000Bh-Vw
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 14:17:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j7Of8-0002w6-Jl
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 14:17:35 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:59894
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j7Of8-0002vi-E7
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 14:17:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582831053;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IGC8F9/T6uMLFcotKhbU2BiOvlBSWQyd0TtkPDRVgBs=;
 b=d8Dhk6w5TGTfLCqWhG5+qFqqA/AYgrgOod4NpKmDeltcwftEY6ZjqkHAvjUQwBpWoHIj5T
 27uGN30zRI4im3C8OVHTDzIsELXymqiUoUIDr90l474GGZ9IIrAb3uWxYXj9JHryb2xOGm
 Q6qDrQjJonhGpsNv+C0m5xOri9hPrU4=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-283-YHJm7sfWOG6MbksAF6DK4Q-1; Thu, 27 Feb 2020 14:17:31 -0500
X-MC-Unique: YHJm7sfWOG6MbksAF6DK4Q-1
Received: by mail-wr1-f71.google.com with SMTP id p11so242660wrn.10
 for <qemu-devel@nongnu.org>; Thu, 27 Feb 2020 11:17:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=IGC8F9/T6uMLFcotKhbU2BiOvlBSWQyd0TtkPDRVgBs=;
 b=r6bCDAdQ05hFOapUfb+3qfVU9Mt59aDG+V3j2rIFpVZshX1654nH6JIWbLuQfLQecG
 faxOZ8zgYpQsCK12+86b99ZyECgVUkq3/yUXMEfcwNme+1nOlSjjtNP3gkQhte4dXMIq
 YAVfp85EID2+lxx/ukqM3gvqpZYSK9AaTAOiZYVjeDoynz3W92S6Bv+jNhikvmMHk7Ee
 gkvUK9Yj33VVOfuSP/nVDd0rL8gVK70otRu1HGveWwXYhfhFhRhSVdu6RTErRWXEjy5V
 XXFFxrMqKLb6cmdRjvNRnYwfxjp380ma0B99VPoLplFopmjV1Z5VwGEemeRAii0anYWg
 6rhw==
X-Gm-Message-State: APjAAAUOAFyUQWySUy9O/k25fQTK3MXOK642HxlG/Njxd1CziZ9nG6nf
 jhSRZBTWGWkUceO0oV4KS7Aa+jdeJ8kxGpjoC+MsNXFU88WlX9aoYBw5mrJpCnFskdNEN2i6mGG
 9aBzbDa4uoqYegEE=
X-Received: by 2002:adf:f20b:: with SMTP id p11mr56105wro.195.1582831050488;
 Thu, 27 Feb 2020 11:17:30 -0800 (PST)
X-Google-Smtp-Source: APXvYqzZWbOaSzCE35Wi/lQw9IDmJZYFK+bN5RwGUntroPfn8O2I5Co4V8Ob1PoKxgm+slyExYtC6Q==
X-Received: by 2002:adf:f20b:: with SMTP id p11mr56082wro.195.1582831050295;
 Thu, 27 Feb 2020 11:17:30 -0800 (PST)
Received: from [192.168.1.35] (47.red-88-21-205.staticip.rima-tde.net.
 [88.21.205.47])
 by smtp.gmail.com with ESMTPSA id t133sm9138581wmf.31.2020.02.27.11.17.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Feb 2020 11:17:29 -0800 (PST)
Subject: Re: [PATCH] migration/savevm: release gslist after dump_vmstate_json
To: pannengyuan@huawei.com, quintela@redhat.com, dgilbert@redhat.com
References: <20200219094705.8960-1-pannengyuan@huawei.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <cb9838f2-2f99-4008-4be1-8d8983ff5047@redhat.com>
Date: Thu, 27 Feb 2020 20:17:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200219094705.8960-1-pannengyuan@huawei.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
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
Cc: euler.robot@huawei.com, Zhang <zhang.zhanghailiang@huawei.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Correcting Zhang email.

On 2/19/20 10:47 AM, pannengyuan@huawei.com wrote:
> From: Pan Nengyuan <pannengyuan@huawei.com>
> 
> 'list' forgot to free at the end of dump_vmstate_json_to_file(), although it's called only once, but seems like a clean code.
> 
> Fix the leak as follow:
> Direct leak of 16 byte(s) in 1 object(s) allocated from:
>      #0 0x7fb946abd768 in __interceptor_malloc (/lib64/libasan.so.5+0xef768)
>      #1 0x7fb945eca445 in g_malloc (/lib64/libglib-2.0.so.0+0x52445)
>      #2 0x7fb945ee2066 in g_slice_alloc (/lib64/libglib-2.0.so.0+0x6a066)
>      #3 0x7fb945ee3139 in g_slist_prepend (/lib64/libglib-2.0.so.0+0x6b139)
>      #4 0x5585db591581 in object_class_get_list_tramp /mnt/sdb/qemu-new/qemu/qom/object.c:1084
>      #5 0x5585db590f66 in object_class_foreach_tramp /mnt/sdb/qemu-new/qemu/qom/object.c:1028
>      #6 0x7fb945eb35f7 in g_hash_table_foreach (/lib64/libglib-2.0.so.0+0x3b5f7)
>      #7 0x5585db59110c in object_class_foreach /mnt/sdb/qemu-new/qemu/qom/object.c:1038
>      #8 0x5585db5916b6 in object_class_get_list /mnt/sdb/qemu-new/qemu/qom/object.c:1092
>      #9 0x5585db335ca0 in dump_vmstate_json_to_file /mnt/sdb/qemu-new/qemu/migration/savevm.c:638
>      #10 0x5585daa5bcbf in main /mnt/sdb/qemu-new/qemu/vl.c:4420
>      #11 0x7fb941204812 in __libc_start_main ../csu/libc-start.c:308
>      #12 0x5585da29420d in _start (/mnt/sdb/qemu-new/qemu/build/x86_64-softmmu/qemu-system-x86_64+0x27f020d)
> 
> Indirect leak of 7472 byte(s) in 467 object(s) allocated from:
>      #0 0x7fb946abd768 in __interceptor_malloc (/lib64/libasan.so.5+0xef768)
>      #1 0x7fb945eca445 in g_malloc (/lib64/libglib-2.0.so.0+0x52445)
>      #2 0x7fb945ee2066 in g_slice_alloc (/lib64/libglib-2.0.so.0+0x6a066)
>      #3 0x7fb945ee3139 in g_slist_prepend (/lib64/libglib-2.0.so.0+0x6b139)
>      #4 0x5585db591581 in object_class_get_list_tramp /mnt/sdb/qemu-new/qemu/qom/object.c:1084
>      #5 0x5585db590f66 in object_class_foreach_tramp /mnt/sdb/qemu-new/qemu/qom/object.c:1028
>      #6 0x7fb945eb35f7 in g_hash_table_foreach (/lib64/libglib-2.0.so.0+0x3b5f7)
>      #7 0x5585db59110c in object_class_foreach /mnt/sdb/qemu-new/qemu/qom/object.c:1038
>      #8 0x5585db5916b6 in object_class_get_list /mnt/sdb/qemu-new/qemu/qom/object.c:1092
>      #9 0x5585db335ca0 in dump_vmstate_json_to_file /mnt/sdb/qemu-new/qemu/migration/savevm.c:638
>      #10 0x5585daa5bcbf in main /mnt/sdb/qemu-new/qemu/vl.c:4420
>      #11 0x7fb941204812 in __libc_start_main ../csu/libc-start.c:308
>      #12 0x5585da29420d in _start (/mnt/sdb/qemu-new/qemu/build/x86_64-softmmu/qemu-system-x86_64+0x27f020d)
> 
> Reported-by: Euler Robot <euler.robot@huawei.com>
> Signed-off-by: Pan Nengyuan <pannengyuan@huawei.com>
> ---
>   migration/savevm.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/migration/savevm.c b/migration/savevm.c
> index f19cb9ec7a..60e6ea8a8d 100644
> --- a/migration/savevm.c
> +++ b/migration/savevm.c
> @@ -665,6 +665,7 @@ void dump_vmstate_json_to_file(FILE *out_file)
>       }
>       fprintf(out_file, "\n}\n");
>       fclose(out_file);
> +    g_slist_free(list);
>   }
>   
>   static uint32_t calculate_new_instance_id(const char *idstr)
> 


