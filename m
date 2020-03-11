Return-Path: <SRS0=QLzr=44=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C848FC0044D
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 17:49:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C61A20735
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 17:49:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LI1LdSBC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C61A20735
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56620 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jC5UM-0001WW-QK
	for qemu-devel@archiver.kernel.org; Wed, 11 Mar 2020 13:49:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36175)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <david@redhat.com>) id 1jC5TS-0000uw-9u
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 13:48:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <david@redhat.com>) id 1jC5TQ-00077r-KE
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 13:48:54 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:29303
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <david@redhat.com>) id 1jC5TQ-00076o-Es
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 13:48:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583948932;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=MBByYtQJAfTSROEA2f4UueE+25jI7JmZxAZh60pMaiY=;
 b=LI1LdSBCM4m54425K8K48BcaesqDXw/8bkleVIo6AU549m1qsPJvxWk02KDjp264QemXOz
 dQMYLXFy/VMCf+qc0YEID2+2E0252jagHSCMPZElZoLgBBmJsKMJHFulZOU7y1PS8K7njV
 zpedZeojjDuV1KtI8W961EMKDR/bsxE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-205-we-ipVu-MT-XWxsWmwv3Xw-1; Wed, 11 Mar 2020 13:48:44 -0400
X-MC-Unique: we-ipVu-MT-XWxsWmwv3Xw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E8DF2107ACC4;
 Wed, 11 Mar 2020 17:48:42 +0000 (UTC)
Received: from [10.36.116.132] (ovpn-116-132.ams2.redhat.com [10.36.116.132])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8DB518F37B;
 Wed, 11 Mar 2020 17:48:35 +0000 (UTC)
Subject: Re: [PATCH v3 02/10] fw_cfg: Migrate ACPI table mr sizes separately
To: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, eric.auger@redhat.com,
 imammedo@redhat.com
References: <20200311172014.33052-1-shameerali.kolothum.thodi@huawei.com>
 <20200311172014.33052-3-shameerali.kolothum.thodi@huawei.com>
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
Message-ID: <4ff72f9b-76e3-3eed-dbe9-7309f2e3eda8@redhat.com>
Date: Wed, 11 Mar 2020 18:48:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200311172014.33052-3-shameerali.kolothum.thodi@huawei.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=windows-1252
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
Cc: peter.maydell@linaro.org, xiaoguangrong.eric@gmail.com, mst@redhat.com,
 linuxarm@huawei.com, xuwei5@hisilicon.com, shannon.zhaosl@gmail.com,
 lersek@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11.03.20 18:20, Shameer Kolothum wrote:
> Any sub-page size update to ACPI table MRs will be lost during
> migration, as we use aligned size in ram_load_precopy() ->
> qemu_ram_resize() path. This will result in inconsistency in sizes
> between source and destination. In order to avoid this, save and
> restore them separately during migration.
> 
> Suggested-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> ---
> Please find the discussion here,
> https://patchwork.kernel.org/patch/11339591/
> ---
>  hw/core/machine.c         |  1 +
>  hw/nvram/fw_cfg.c         | 86 ++++++++++++++++++++++++++++++++++++++-
>  include/hw/nvram/fw_cfg.h |  6 +++
>  3 files changed, 92 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/core/machine.c b/hw/core/machine.c
> index 9e8c06036f..6d960bd47f 100644
> --- a/hw/core/machine.c
> +++ b/hw/core/machine.c
> @@ -39,6 +39,7 @@ GlobalProperty hw_compat_4_2[] = {
>      { "usb-redir", "suppress-remote-wake", "off" },
>      { "qxl", "revision", "4" },
>      { "qxl-vga", "revision", "4" },
> +    { "fw_cfg", "acpi-mr-restore", "false" },
>  };
>  const size_t hw_compat_4_2_len = G_N_ELEMENTS(hw_compat_4_2);
>  
> diff --git a/hw/nvram/fw_cfg.c b/hw/nvram/fw_cfg.c
> index 179b302f01..36d1e32f83 100644
> --- a/hw/nvram/fw_cfg.c
> +++ b/hw/nvram/fw_cfg.c
> @@ -39,6 +39,7 @@
>  #include "qemu/config-file.h"
>  #include "qemu/cutils.h"
>  #include "qapi/error.h"
> +#include "hw/acpi/aml-build.h"
>  
>  #define FW_CFG_FILE_SLOTS_DFLT 0x20
>  
> @@ -610,6 +611,50 @@ bool fw_cfg_dma_enabled(void *opaque)
>      return s->dma_enabled;
>  }
>  
> +static bool fw_cfg_acpi_mr_restore(void *opaque)
> +{
> +    FWCfgState *s = opaque;
> +    return s->acpi_mr_restore;
> +}
> +
> +static void fw_cfg_update_mr(FWCfgState *s, uint16_t key, size_t size)
> +{
> +    MemoryRegion *mr;
> +    ram_addr_t offset;
> +    int arch = !!(key & FW_CFG_ARCH_LOCAL);
> +    void *ptr;
> +
> +    key &= FW_CFG_ENTRY_MASK;
> +    assert(key < fw_cfg_max_entry(s));
> +
> +    ptr = s->entries[arch][key].data;
> +    mr = memory_region_from_host(ptr, &offset);
> +
> +    memory_region_ram_resize(mr, size, &error_abort);
> +}
> +
> +static int fw_cfg_acpi_mr_restore_post_load(void *opaque, int version_id)
> +{
> +    FWCfgState *s = opaque;
> +    int i, index;
> +
> +    assert(s->files);
> +
> +    index = be32_to_cpu(s->files->count);
> +
> +    for (i = 0; i < index; i++) {
> +        if (!strcmp(s->files->f[i].name, ACPI_BUILD_TABLE_FILE)) {
> +            fw_cfg_update_mr(s, FW_CFG_FILE_FIRST + i, s->table_mr_size);
> +        } else if (!strcmp(s->files->f[i].name, ACPI_BUILD_LOADER_FILE)) {
> +            fw_cfg_update_mr(s, FW_CFG_FILE_FIRST + i, s->linker_mr_size);
> +        } else if (!strcmp(s->files->f[i].name, ACPI_BUILD_RSDP_FILE)) {
> +            fw_cfg_update_mr(s, FW_CFG_FILE_FIRST + i, s->rsdp_mr_size);
> +        }
> +    }
> +
> +    return 0;
> +}
> +
>  static const VMStateDescription vmstate_fw_cfg_dma = {
>      .name = "fw_cfg/dma",
>      .needed = fw_cfg_dma_enabled,
> @@ -619,6 +664,20 @@ static const VMStateDescription vmstate_fw_cfg_dma = {
>      },
>  };
>  
> +static const VMStateDescription vmstate_fw_cfg_acpi_mr = {
> +    .name = "fw_cfg/acpi_mr",
> +    .version_id = 1,
> +    .minimum_version_id = 1,
> +    .needed = fw_cfg_acpi_mr_restore,
> +    .post_load = fw_cfg_acpi_mr_restore_post_load,
> +    .fields = (VMStateField[]) {
> +        VMSTATE_UINT64(table_mr_size, FWCfgState),
> +        VMSTATE_UINT64(linker_mr_size, FWCfgState),
> +        VMSTATE_UINT64(rsdp_mr_size, FWCfgState),
> +        VMSTATE_END_OF_LIST()
> +    },
> +};
> +
>  static const VMStateDescription vmstate_fw_cfg = {
>      .name = "fw_cfg",
>      .version_id = 2,
> @@ -631,6 +690,7 @@ static const VMStateDescription vmstate_fw_cfg = {
>      },
>      .subsections = (const VMStateDescription*[]) {
>          &vmstate_fw_cfg_dma,
> +        &vmstate_fw_cfg_acpi_mr,
>          NULL,
>      }
>  };
> @@ -815,6 +875,23 @@ static struct {
>  #define FW_CFG_ORDER_OVERRIDE_LAST 200
>  };
>  
> +/*
> + * Any sub-page size update to these table MRs will be lost during migration,
> + * as we use aligned size in ram_load_precopy() -> qemu_ram_resize() path.
> + * In order to avoid the inconsistency in sizes save them seperately and
> + * migrate over in vmstate post_load().
> + */
> +static void fw_cfg_acpi_mr_save(FWCfgState *s, const char *filename, size_t len)
> +{
> +    if (!strcmp(filename, ACPI_BUILD_TABLE_FILE)) {
> +        s->table_mr_size = len;
> +    } else if (!strcmp(filename, ACPI_BUILD_LOADER_FILE)) {
> +        s->linker_mr_size = len;
> +    } else if (!strcmp(filename, ACPI_BUILD_RSDP_FILE)) {
> +        s->rsdp_mr_size = len;
> +    }
> +}
> +
>  static int get_fw_cfg_order(FWCfgState *s, const char *name)
>  {
>      int i;
> @@ -914,6 +991,7 @@ void fw_cfg_add_file_callback(FWCfgState *s,  const char *filename,
>      trace_fw_cfg_add_file(s, index, s->files->f[index].name, len);
>  
>      s->files->count = cpu_to_be32(count+1);
> +    fw_cfg_acpi_mr_save(s, filename, len);
>  }
>  
>  void fw_cfg_add_file(FWCfgState *s,  const char *filename,
> @@ -937,6 +1015,7 @@ void *fw_cfg_modify_file(FWCfgState *s, const char *filename,
>              ptr = fw_cfg_modify_bytes_read(s, FW_CFG_FILE_FIRST + i,
>                                             data, len);
>              s->files->f[i].size   = cpu_to_be32(len);
> +            fw_cfg_acpi_mr_save(s, filename, len);
>              return ptr;
>          }
>      }
> @@ -973,7 +1052,10 @@ static void fw_cfg_machine_ready(struct Notifier *n, void *data)
>      qemu_register_reset(fw_cfg_machine_reset, s);
>  }
>  
> -
> +static Property fw_cfg_properties[] = {
> +    DEFINE_PROP_BOOL("acpi-mr-restore", FWCfgState, acpi_mr_restore, true),
> +    DEFINE_PROP_END_OF_LIST(),
> +};
>  
>  static void fw_cfg_common_realize(DeviceState *dev, Error **errp)
>  {
> @@ -1097,6 +1179,8 @@ static void fw_cfg_class_init(ObjectClass *klass, void *data)
>  
>      dc->reset = fw_cfg_reset;
>      dc->vmsd = &vmstate_fw_cfg;
> +
> +    device_class_set_props(dc, fw_cfg_properties);
>  }
>  
>  static const TypeInfo fw_cfg_info = {
> diff --git a/include/hw/nvram/fw_cfg.h b/include/hw/nvram/fw_cfg.h
> index b5291eefad..457fee7425 100644
> --- a/include/hw/nvram/fw_cfg.h
> +++ b/include/hw/nvram/fw_cfg.h
> @@ -53,6 +53,12 @@ struct FWCfgState {
>      dma_addr_t dma_addr;
>      AddressSpace *dma_as;
>      MemoryRegion dma_iomem;
> +
> +    /* restore during migration */
> +    bool acpi_mr_restore;
> +    size_t table_mr_size;
> +    size_t linker_mr_size;
> +    size_t rsdp_mr_size;
>  };
>  
>  struct FWCfgIoState {
> 

Makes sense to me, the RAM block migration code will migrate full pages.
Only the sub-page size has to be migrated and reset.

Not an expert of the FW code etc, but the general idea sounds correct to me

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb


