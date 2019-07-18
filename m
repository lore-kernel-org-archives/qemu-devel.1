Return-Path: <SRS0=9jkQ=VP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32B5DC76191
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2019 07:21:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0169220880
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2019 07:21:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ozlabs-ru.20150623.gappssmtp.com header.i=@ozlabs-ru.20150623.gappssmtp.com header.b="aF7kMqvH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0169220880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ozlabs.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35058 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ho0jL-0001mr-9U
	for qemu-devel@archiver.kernel.org; Thu, 18 Jul 2019 03:21:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33533)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <aik@ozlabs.ru>) id 1ho0j9-0001No-Bt
 for qemu-devel@nongnu.org; Thu, 18 Jul 2019 03:21:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aik@ozlabs.ru>) id 1ho0j5-0000Gi-Vz
 for qemu-devel@nongnu.org; Thu, 18 Jul 2019 03:21:19 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:43303)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aik@ozlabs.ru>) id 1ho0j5-0000G1-Gw
 for qemu-devel@nongnu.org; Thu, 18 Jul 2019 03:21:15 -0400
Received: by mail-pl1-x642.google.com with SMTP id 4so6425773pld.10
 for <qemu-devel@nongnu.org>; Thu, 18 Jul 2019 00:21:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ozlabs-ru.20150623.gappssmtp.com; s=20150623;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=VmWzKX7H7NK33hGuIanE8aFJw7hN728kkBVcEImI/iA=;
 b=aF7kMqvHZNhUrUsIigx2dT4TFX8l0Zagt8jxr+B/mtF4walfMt0juoTwFOK+TUarDr
 mf0FPYd3awpmJbntKSZx6L/mYAKzsOix0posnxq2CIriDe5+IhV2L0rAxN+ZMW+HwB8c
 nMgxGg0DjiWD3ekTJQtpyPD1lIyAbcFJKmmEAwi3frG0pFwMMfZsqzmMl3/koefkz+1C
 cCNbTTd9TqsQb3cocRFGLtNTxRZtDjzgljEb9CLfFJWg2l7mL3P+j3oh30RNf84gevvX
 7m02+vpJ/3afxS9Xt1n/V/U+4DO8fid3HoimScEdvkZewWsq4sHe/fJTXALEeI/Me191
 g90Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=VmWzKX7H7NK33hGuIanE8aFJw7hN728kkBVcEImI/iA=;
 b=hGmChkGKpQ43hBV2nuc/lg+pe+GYKwW/ByAi5fb+wLEEfyYY+ICViSx3TaPf9vQIzY
 j5vDFL1/iMT0jT9JdaayR48x9Vqpm/2BmQYRC75bKfo6Saa/pJEVnCBioQpYUJd4dHhJ
 oh92OZMZfAfR1RaAM7UP0CtPATPt7n5mJFgvqKgo3pThPSS6zxEJW1nJ5HgkGAMGCLGR
 m3NfYTSqpsFVFMdrXSdU6f9bE9NwWcJq2SSRmWxHmIIXlujDOZWmM6QKaGuWL0M/emW5
 DkTtDfmsrFywzH95C/BihGOjksE/lGFXPQgcTbue0ZpYpiSpbv/SA5PBGvm9AAshDvWE
 Oaqg==
X-Gm-Message-State: APjAAAV1j8mcT4KPOjLKTVlGLgh4zlWG0qTl2z82KxS+DEO4i0dwtak/
 QC5v661lqj3yEOY7Qe0aFgLsd0HduFk=
X-Google-Smtp-Source: APXvYqyeVkdjoGRo2IhYb0Th8EwKaW5RnYhK7sQOm9l5FR5DNi74o2L0g/jM7N9wnomzI8GGsQ9L8A==
X-Received: by 2002:a17:902:be0a:: with SMTP id
 r10mr45757041pls.51.1563434473441; 
 Thu, 18 Jul 2019 00:21:13 -0700 (PDT)
Received: from [10.61.2.175] ([122.99.82.10])
 by smtp.gmail.com with ESMTPSA id f14sm25339232pfn.53.2019.07.18.00.21.11
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 18 Jul 2019 00:21:12 -0700 (PDT)
To: Paolo Bonzini <pbonzini@redhat.com>
References: <20190614015237.82463-1-aik@ozlabs.ru>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <7f1c2b5a-b7d6-94fa-e0c2-7250d6ead8e4@ozlabs.ru>
Date: Thu, 18 Jul 2019 17:21:10 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190614015237.82463-1-aik@ozlabs.ru>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::642
Subject: Re: [Qemu-devel] [PATCH qemu v3] hmp: Print if memory section is
 registered with an accelerator
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Paolo, ping? :)


On 14/06/2019 11:52, Alexey Kardashevskiy wrote:
> This adds an accelerator name to the "into mtree -f" to tell the user if
> a particular memory section is registered with the accelerator;
> the primary user for this is KVM and such information is useful
> for debugging purposes.
> 
> This adds a has_memory() callback to the accelerator class allowing any
> accelerator to have a label in that memory tree dump.
> 
> Since memory sections are passed to memory listeners and get registered
> in accelerators (rather than memory regions), this only prints new labels
> for flatviews attached to the system address space.
> 
> An example:
>   Root memory region: system
>    0000000000000000-0000002fffffffff (prio 0, ram): /objects/mem0 kvm
>    0000003000000000-0000005fffffffff (prio 0, ram): /objects/mem1 kvm
>    0000200000000020-000020000000003f (prio 1, i/o): virtio-pci
>    0000200080000000-000020008000003f (prio 0, i/o): capabilities
> 
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> ---
> Changes:
> v3:
> * added support for multiple ASes per accelerator (KVM can do 2 at least)
> as Paolo suggested
> 
> v2:
> * added an accelerator callback instead of hardcoding it to kvm only
> ---
>   include/sysemu/accel.h |  3 +++
>   accel/kvm/kvm-all.c    | 38 ++++++++++++++++++++++++++++++++++++++
>   memory.c               | 22 ++++++++++++++++++++++
>   3 files changed, 63 insertions(+)
> 
> diff --git a/include/sysemu/accel.h b/include/sysemu/accel.h
> index 81293cdb08f9..89ce57e404ca 100644
> --- a/include/sysemu/accel.h
> +++ b/include/sysemu/accel.h
> @@ -25,6 +25,7 @@
>   
>   #include "qom/object.h"
>   #include "hw/qdev-properties.h"
> +#include "exec/hwaddr.h"
>   
>   typedef struct AccelState {
>       /*< private >*/
> @@ -39,6 +40,8 @@ typedef struct AccelClass {
>       const char *name;
>       int (*init_machine)(MachineState *ms);
>       void (*setup_post)(MachineState *ms, AccelState *accel);
> +    bool (*has_memory)(MachineState *ms, AddressSpace *as,
> +                       hwaddr start_addr, hwaddr size);
>       bool *allowed;
>       /*
>        * Array of global properties that would be applied when specific
> diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
> index b0c4bed6e367..948b7e53df47 100644
> --- a/accel/kvm/kvm-all.c
> +++ b/accel/kvm/kvm-all.c
> @@ -109,6 +109,13 @@ struct KVMState
>       /* memory encryption */
>       void *memcrypt_handle;
>       int (*memcrypt_encrypt_data)(void *handle, uint8_t *ptr, uint64_t len);
> +
> +    /* For "info mtree -f" to tell if an MR is registered in KVM */
> +    int nr_as;
> +    struct KVMAs {
> +        KVMMemoryListener *ml;
> +        AddressSpace *as;
> +    } *as;
>   };
>   
>   KVMState *kvm_state;
> @@ -940,6 +947,14 @@ void kvm_memory_listener_register(KVMState *s, KVMMemoryListener *kml,
>       kml->listener.priority = 10;
>   
>       memory_listener_register(&kml->listener, as);
> +
> +    for (i = 0; i < s->nr_as; ++i) {
> +        if (!s->as[i].as) {
> +            s->as[i].as = as;
> +            s->as[i].ml = kml;
> +            break;
> +        }
> +    }
>   }
>   
>   static MemoryListener kvm_io_listener = {
> @@ -1590,6 +1605,12 @@ static int kvm_init(MachineState *ms)
>           s->nr_slots = 32;
>       }
>   
> +    s->nr_as = kvm_check_extension(s, KVM_CAP_MULTI_ADDRESS_SPACE);
> +    if (s->nr_as <= 1) {
> +        s->nr_as = 1;
> +    }
> +    s->as = g_new0(struct KVMAs, s->nr_as);
> +
>       kvm_type = qemu_opt_get(qemu_get_machine_opts(), "kvm-type");
>       if (mc->kvm_type) {
>           type = mc->kvm_type(ms, kvm_type);
> @@ -2591,11 +2612,28 @@ int kvm_get_one_reg(CPUState *cs, uint64_t id, void *target)
>       return r;
>   }
>   
> +static bool kvm_accel_has_memory(MachineState *ms, AddressSpace *as,
> +                                 hwaddr start_addr, hwaddr size)
> +{
> +    KVMState *kvm = KVM_STATE(ms->accelerator);
> +    int i;
> +
> +    for (i = 0; i < kvm->nr_as; ++i) {
> +        if (kvm->as[i].as == as && kvm->as[i].ml) {
> +            return NULL != kvm_lookup_matching_slot(kvm->as[i].ml,
> +                                                    start_addr, size);
> +        }
> +    }
> +
> +    return false;
> +}
> +
>   static void kvm_accel_class_init(ObjectClass *oc, void *data)
>   {
>       AccelClass *ac = ACCEL_CLASS(oc);
>       ac->name = "KVM";
>       ac->init_machine = kvm_init;
> +    ac->has_memory = kvm_accel_has_memory;
>       ac->allowed = &kvm_allowed;
>   }
>   
> diff --git a/memory.c b/memory.c
> index 0a089a73ae1a..61524156a1ce 100644
> --- a/memory.c
> +++ b/memory.c
> @@ -30,7 +30,9 @@
>   #include "sysemu/kvm.h"
>   #include "sysemu/sysemu.h"
>   #include "sysemu/tcg.h"
> +#include "sysemu/accel.h"
>   #include "hw/qdev-properties.h"
> +#include "hw/boards.h"
>   #include "migration/vmstate.h"
>   
>   //#define DEBUG_UNASSIGNED
> @@ -2939,6 +2941,8 @@ struct FlatViewInfo {
>       int counter;
>       bool dispatch_tree;
>       bool owner;
> +    AccelClass *ac;
> +    const char *ac_name;
>   };
>   
>   static void mtree_print_flatview(gpointer key, gpointer value,
> @@ -3001,6 +3005,17 @@ static void mtree_print_flatview(gpointer key, gpointer value,
>           if (fvi->owner) {
>               mtree_print_mr_owner(mr);
>           }
> +
> +        if (fvi->ac) {
> +            for (i = 0; i < fv_address_spaces->len; ++i) {
> +                as = g_array_index(fv_address_spaces, AddressSpace*, i);
> +                if (fvi->ac->has_memory(current_machine, as,
> +                                        int128_get64(range->addr.start),
> +                                        MR_SIZE(range->addr.size) + 1)) {
> +                    qemu_printf(" %s", fvi->ac_name);
> +                }
> +            }
> +        }
>           qemu_printf("\n");
>           range++;
>       }
> @@ -3041,6 +3056,13 @@ void mtree_info(bool flatview, bool dispatch_tree, bool owner)
>           };
>           GArray *fv_address_spaces;
>           GHashTable *views = g_hash_table_new(g_direct_hash, g_direct_equal);
> +        AccelClass *ac = ACCEL_GET_CLASS(current_machine->accelerator);
> +
> +        if (ac->has_memory) {
> +            fvi.ac = ac;
> +            fvi.ac_name = current_machine->accel ? current_machine->accel :
> +                object_class_get_name(OBJECT_CLASS(ac));
> +        }
>   
>           /* Gather all FVs in one table */
>           QTAILQ_FOREACH(as, &address_spaces, address_spaces_link) {
> 

-- 
Alexey

