Return-Path: <SRS0=2fDQ=3E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73F48C32771
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2020 18:55:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 448A52084D
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2020 18:55:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LT/KcZ8X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 448A52084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58944 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irnos-00040q-CG
	for qemu-devel@archiver.kernel.org; Wed, 15 Jan 2020 13:55:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58931)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1irnoD-0002xk-EP
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 13:54:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1irno9-0000pX-V9
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 13:54:27 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:54353
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1irno9-0000op-HA
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 13:54:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579114464;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vXmjnJTn1zUB2fY68K6xyRliaxaK2UKU8jj0T+N5QPg=;
 b=LT/KcZ8XYmxu6kEAntJRqlwQ4J8+OZdyvICWzWlBLz824tImKVH3jkaEtWhRaDmcvBbuuI
 t7IMRmotRNGKKDjDZNT40AQyN5aGxbJRhNhxWgWpaau1I/jTfRBjYEq4WWYsFDGJsmYAtO
 Vqbn57IcjfNcyj7Y8/V66hAZ50aWvr4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-395-iIgEeoEAMaKJXgSK-mlUbg-1; Wed, 15 Jan 2020 13:54:20 -0500
Received: by mail-wm1-f72.google.com with SMTP id w205so268269wmb.5
 for <qemu-devel@nongnu.org>; Wed, 15 Jan 2020 10:54:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=vXmjnJTn1zUB2fY68K6xyRliaxaK2UKU8jj0T+N5QPg=;
 b=UiqlF/2HcLEL/WETr1o20iW8wOGHZt1N6SPWbb/SaNjZE6O0eG8CG8Scma1LhGhx+r
 t2ipkU9u7iauaQA0i/h5tXO0WNASsFtpgCadzQ2H+7WIhYSOsWRGYyZwxp8zVs7LxQ8v
 VSYpWd5LViDm1INd9Xwz4zQFyVVMvApkEjVnCM4uxOpP7j45hXOMaVnSWnGqISwL5VNS
 N/wB1grwNWUxLu2dNcKSCJJ9p59xqgxdHC1RyrBbt+V8EEt1zH+12UDa34PPXjUGy3HQ
 2QmzaCGwFV61dg0El66SbW9uCMuo07pqLHrqhwFJ0sUlT1i9+KhLvZVMQp29J7StyF/e
 ebmg==
X-Gm-Message-State: APjAAAUzLec/BC0dQNbdv6LGsRVCRK5sELfRx2XvJbr7hbnFMSqwrhNM
 eNYhELRfyJEkuT28pmwAy5qSKDJY7/NqfZS6lvrycF7yf7T0errNOERl6zK8MIayXT3U3W14g9k
 S+P60ibgqwEJYKo8=
X-Received: by 2002:a1c:7d92:: with SMTP id y140mr1300271wmc.145.1579114459877; 
 Wed, 15 Jan 2020 10:54:19 -0800 (PST)
X-Google-Smtp-Source: APXvYqyNRP9TzAhLt+DnVSIhybmEXfZ60TLMUlKkVXL5/FUMCNj8XN0c+F64Mkayij3NOdw1LaJ89w==
X-Received: by 2002:a1c:7d92:: with SMTP id y140mr1300253wmc.145.1579114459663; 
 Wed, 15 Jan 2020 10:54:19 -0800 (PST)
Received: from ?IPv6:2a01:cb1d:8a0a:f500:48c1:8eab:256a:caf9?
 ([2a01:cb1d:8a0a:f500:48c1:8eab:256a:caf9])
 by smtp.gmail.com with ESMTPSA id t25sm967390wmj.19.2020.01.15.10.54.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Jan 2020 10:54:19 -0800 (PST)
Subject: Re: [PATCH v2 03/86] machine: alias -mem-path and -mem-prealloc into
 memory-foo backend
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
References: <1579100861-73692-1-git-send-email-imammedo@redhat.com>
 <1579100861-73692-4-git-send-email-imammedo@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <f2e2e568-d114-8b89-9605-020b5f18f597@redhat.com>
Date: Wed, 15 Jan 2020 19:54:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <1579100861-73692-4-git-send-email-imammedo@redhat.com>
Content-Language: en-US
X-MC-Unique: iIgEeoEAMaKJXgSK-mlUbg-1
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
Cc: pbonzini@redhat.com, ehabkost@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/15/20 4:06 PM, Igor Mammedov wrote:
> Allow a machine to opt in for hostmem backend based initial
> RAM even if user used old -mem-path/prealloc options by providing
>    MachineClass::default_ram_id
> Follow up patches will incrementally convert machines to new API,
> by dropping memory_region_allocate_system_memory() and setting
> default_ram_id that board used to use before conversion to keep
> migration stream the same.
> 
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> ---
> CC: ehabkost@redhat.com
> CC: pbonzini@redhat.com
> ---
>   include/hw/boards.h      |  5 +++++
>   include/sysemu/hostmem.h | 16 ++++++++++++++++
>   backends/hostmem-file.c  |  7 -------
>   backends/hostmem-ram.c   |  2 --
>   vl.c                     | 25 +++++++++++++++++++++++++
>   5 files changed, 46 insertions(+), 9 deletions(-)
> 
> diff --git a/include/hw/boards.h b/include/hw/boards.h
> index 6aa01b8..e3ea8b0 100644
> --- a/include/hw/boards.h
> +++ b/include/hw/boards.h
> @@ -170,6 +170,10 @@ typedef struct {
>    *    false is returned, an error must be set to show the reason of
>    *    the rejection.  If the hook is not provided, all hotplug will be
>    *    allowed.
> + * @default_ram_id:
> + *    Specifies inital RAM MemoryRegion name to be used for default backend
> + *    creation if user explicitly hasn't specified backend with "ram-memdev"
> + *    property.
>    */
>   struct MachineClass {
>       /*< private >*/
> @@ -226,6 +230,7 @@ struct MachineClass {
>       bool nvdimm_supported;
>       bool numa_mem_supported;
>       bool auto_enable_numa;
> +    const char *default_ram_id;
>   
>       HotplugHandler *(*get_hotplug_handler)(MachineState *machine,
>                                              DeviceState *dev);
> diff --git a/include/sysemu/hostmem.h b/include/sysemu/hostmem.h
> index 4dbdadd..5db0d66 100644
> --- a/include/sysemu/hostmem.h
> +++ b/include/sysemu/hostmem.h
> @@ -27,6 +27,22 @@
>   #define MEMORY_BACKEND_CLASS(klass) \
>       OBJECT_CLASS_CHECK(HostMemoryBackendClass, (klass), TYPE_MEMORY_BACKEND)
>   
> +/* hostmem-ram.c */
> +/**
> + * @TYPE_MEMORY_BACKEND_RAM:
> + * name of backend that uses mmap on the anonymous RAM
> + */
> +
> +#define TYPE_MEMORY_BACKEND_RAM "memory-backend-ram"
> +
> +/* hostmem-file.c */
> +/**
> + * @TYPE_MEMORY_BACKEND_FILE:
> + * name of backend that uses mmap on a file descriptor
> + */
> +#define TYPE_MEMORY_BACKEND_FILE "memory-backend-file"
> +
> +typedef struct HostMemoryBackend HostMemoryBackend;
>   typedef struct HostMemoryBackendClass HostMemoryBackendClass;
>   
>   /**
> diff --git a/backends/hostmem-file.c b/backends/hostmem-file.c
> index be64020..cb319a9 100644
> --- a/backends/hostmem-file.c
> +++ b/backends/hostmem-file.c
> @@ -18,13 +18,6 @@
>   #include "sysemu/sysemu.h"
>   #include "qom/object_interfaces.h"
>   
> -/* hostmem-file.c */
> -/**
> - * @TYPE_MEMORY_BACKEND_FILE:
> - * name of backend that uses mmap on a file descriptor
> - */
> -#define TYPE_MEMORY_BACKEND_FILE "memory-backend-file"
> -
>   #define MEMORY_BACKEND_FILE(obj) \
>       OBJECT_CHECK(HostMemoryBackendFile, (obj), TYPE_MEMORY_BACKEND_FILE)
>   
> diff --git a/backends/hostmem-ram.c b/backends/hostmem-ram.c
> index 6aab8d3..5cc53e7 100644
> --- a/backends/hostmem-ram.c
> +++ b/backends/hostmem-ram.c
> @@ -16,8 +16,6 @@
>   #include "qemu/module.h"
>   #include "qom/object_interfaces.h"
>   
> -#define TYPE_MEMORY_BACKEND_RAM "memory-backend-ram"
> -
>   static void
>   ram_backend_memory_alloc(HostMemoryBackend *backend, Error **errp)
>   {
> diff --git a/vl.c b/vl.c
> index 7514012..d36a857 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -75,6 +75,7 @@ int main(int argc, char **argv)
>   #include "ui/input.h"
>   #include "sysemu/sysemu.h"
>   #include "sysemu/numa.h"
> +#include "sysemu/hostmem.h"
>   #include "exec/gdbstub.h"
>   #include "qemu/timer.h"
>   #include "chardev/char.h"
> @@ -2820,6 +2821,25 @@ static void configure_accelerators(const char *progname)
>       }
>   }
>   
> +static void create_default_memdev(MachineState *ms, const char *path,
> +                                  bool prealloc)
> +{
> +    Object *obj;
> +    MachineClass *mc = MACHINE_GET_CLASS(ms);
> +
> +    obj = object_new(path ? TYPE_MEMORY_BACKEND_FILE : TYPE_MEMORY_BACKEND_RAM);
> +    if (path) {
> +        object_property_set_str(obj, path, "mem-path", &error_fatal);
> +    }
> +    object_property_set_bool(obj, prealloc, "prealloc", &error_fatal);
> +    object_property_set_int(obj, ms->ram_size, "size", &error_fatal);
> +    object_property_add_child(object_get_objects_root(), mc->default_ram_id,
> +                              obj, &error_fatal);
> +    user_creatable_complete(USER_CREATABLE(obj), &error_fatal);
> +    object_unref(obj);
> +    object_property_set_link(OBJECT(ms), obj, "ram-memdev", &error_fatal);
> +}
> +
>   int main(int argc, char **argv, char **envp)
>   {
>       int i;
> @@ -4283,6 +4303,11 @@ int main(int argc, char **argv, char **envp)
>       }
>       parse_numa_opts(current_machine);
>   
> +    if (!current_machine->ram_memdev &&
> +         machine_class->default_ram_size &&
> +         machine_class->default_ram_id) {

Do we really need for its presence?

Can we instead set it to "ram" if NULL?

> +        create_default_memdev(current_machine, mem_path, mem_prealloc);
> +    }
>       /* do monitor/qmp handling at preconfig state if requested */
>       main_loop();
>   
> 


