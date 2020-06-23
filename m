Return-Path: <SRS0=Q9tF=AE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66E8BC433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 15:15:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D92C2073E
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 15:15:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZRBn+k7J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D92C2073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35344 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnkdd-00064v-E1
	for qemu-devel@archiver.kernel.org; Tue, 23 Jun 2020 11:15:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42330)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jnkcT-0004a8-5w
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 11:13:53 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:37948
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jnkcR-0007EI-DZ
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 11:13:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592925230;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=w5oZKLTmCvxqIMpxhOvGtFmoTKRxQkvHsX0eItrgDUw=;
 b=ZRBn+k7JjJCL+X4ZaBPrIaVGnpP7jKf9TmonvfMMIcLwxDdtkRuJWU5wPTWHO+LcsB9o/6
 hJQjV+7BUkNi68s6glomzt3+0nQwQo/SlORTxILjpEAu6auNql/KY2XGQTjXrrUBaqxJxd
 0GF9pl2YBWOrlpt4V60VyPTw0Cnawzw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-248-k9Ixkg4lPuKVy5cSvkMtoA-1; Tue, 23 Jun 2020 11:13:44 -0400
X-MC-Unique: k9Ixkg4lPuKVy5cSvkMtoA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1D64A107ACF3;
 Tue, 23 Jun 2020 15:13:43 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-121.ams2.redhat.com
 [10.36.112.121])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C3D0E7CCE7;
 Tue, 23 Jun 2020 15:13:34 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 47B54113846D; Tue, 23 Jun 2020 17:13:33 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Eric Auger <eric.auger@redhat.com>
Subject: Re: [PATCH v4 1/5] qdev: Introduce DEFINE_PROP_RESERVED_REGION
References: <20200623093244.24931-1-eric.auger@redhat.com>
 <20200623093244.24931-2-eric.auger@redhat.com>
Date: Tue, 23 Jun 2020 17:13:33 +0200
In-Reply-To: <20200623093244.24931-2-eric.auger@redhat.com> (Eric Auger's
 message of "Tue, 23 Jun 2020 11:32:40 +0200")
Message-ID: <87mu4thl2a.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Received-SPF: pass client-ip=205.139.110.120; envelope-from=armbru@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/23 01:53:54
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: peter.maydell@linaro.org, mst@redhat.com, qemu-devel@nongnu.org,
 peterx@redhat.com, jean-philippe@linaro.org, qemu-arm@nongnu.org,
 pbonzini@redhat.com, bbhushan2@marvell.com, eric.auger.pro@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Eric Auger <eric.auger@redhat.com> writes:

> Introduce a new property defining a reserved region:
> <low address>:<high address>:<type>.
>
> This will be used to encode reserved IOVA regions.
>
> For instance, in virtio-iommu use case, reserved IOVA regions
> will be passed by the machine code to the virtio-iommu-pci
> device (an array of those). The type of the reserved region
> will match the virtio_iommu_probe_resv_mem subtype value:
> - VIRTIO_IOMMU_RESV_MEM_T_RESERVED (0)
> - VIRTIO_IOMMU_RESV_MEM_T_MSI (1)
>
> on PC/Q35 machine, this will be used to inform the
> virtio-iommu-pci device it should bypass the MSI region.
> The reserved region will be: 0xfee00000:0xfeefffff:1.
>
> On ARM, we can declare the ITS MSI doorbell as an MSI
> region to prevent MSIs from being mapped on guest side.
>
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> Reviewed-by: Markus Armbruster <armbru@redhat.com>
>
> ---
>
> v3 -> v4:
> - use ':' instead of commas as separators.
> - rearrange error messages
> - check snprintf returned value
> - dared to keep Markus' R-b despite those changes
> ---
>  include/exec/memory.h        |  6 +++
>  include/hw/qdev-properties.h |  3 ++
>  include/qemu/typedefs.h      |  1 +
>  hw/core/qdev-properties.c    | 89 ++++++++++++++++++++++++++++++++++++
>  4 files changed, 99 insertions(+)
>
> diff --git a/include/exec/memory.h b/include/exec/memory.h
> index 7207025bd4..d7a53b96cc 100644
> --- a/include/exec/memory.h
> +++ b/include/exec/memory.h
> @@ -51,6 +51,12 @@ extern bool global_dirty_log;
>  
>  typedef struct MemoryRegionOps MemoryRegionOps;
>  
> +struct ReservedRegion {
> +    hwaddr low;
> +    hwaddr high;
> +    unsigned int type;

Suggest to s/unsigned int/unsigned/.

> +};
> +
>  typedef struct IOMMUTLBEntry IOMMUTLBEntry;
>  
>  /* See address_space_translate: bit 0 is read, bit 1 is write.  */
> diff --git a/include/hw/qdev-properties.h b/include/hw/qdev-properties.h
> index 5252bb6b1a..95d0e7201d 100644
> --- a/include/hw/qdev-properties.h
> +++ b/include/hw/qdev-properties.h
> @@ -19,6 +19,7 @@ extern const PropertyInfo qdev_prop_string;
>  extern const PropertyInfo qdev_prop_chr;
>  extern const PropertyInfo qdev_prop_tpm;
>  extern const PropertyInfo qdev_prop_macaddr;
> +extern const PropertyInfo qdev_prop_reserved_region;
>  extern const PropertyInfo qdev_prop_on_off_auto;
>  extern const PropertyInfo qdev_prop_multifd_compression;
>  extern const PropertyInfo qdev_prop_losttickpolicy;
> @@ -184,6 +185,8 @@ extern const PropertyInfo qdev_prop_pcie_link_width;
>      DEFINE_PROP(_n, _s, _f, qdev_prop_drive_iothread, BlockBackend *)
>  #define DEFINE_PROP_MACADDR(_n, _s, _f)         \
>      DEFINE_PROP(_n, _s, _f, qdev_prop_macaddr, MACAddr)
> +#define DEFINE_PROP_RESERVED_REGION(_n, _s, _f)         \
> +    DEFINE_PROP(_n, _s, _f, qdev_prop_reserved_region, ReservedRegion)
>  #define DEFINE_PROP_ON_OFF_AUTO(_n, _s, _f, _d) \
>      DEFINE_PROP_SIGNED(_n, _s, _f, _d, qdev_prop_on_off_auto, OnOffAuto)
>  #define DEFINE_PROP_MULTIFD_COMPRESSION(_n, _s, _f, _d) \
> diff --git a/include/qemu/typedefs.h b/include/qemu/typedefs.h
> index ce4a78b687..15f5047bf1 100644
> --- a/include/qemu/typedefs.h
> +++ b/include/qemu/typedefs.h
> @@ -58,6 +58,7 @@ typedef struct ISABus ISABus;
>  typedef struct ISADevice ISADevice;
>  typedef struct IsaDma IsaDma;
>  typedef struct MACAddr MACAddr;
> +typedef struct ReservedRegion ReservedRegion;
>  typedef struct MachineClass MachineClass;
>  typedef struct MachineState MachineState;
>  typedef struct MemoryListener MemoryListener;
> diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
> index ead35d7ffd..193d0d95f9 100644
> --- a/hw/core/qdev-properties.c
> +++ b/hw/core/qdev-properties.c
> @@ -15,6 +15,7 @@
>  #include "chardev/char.h"
>  #include "qemu/uuid.h"
>  #include "qemu/units.h"
> +#include "qemu/cutils.h"
>  
>  void qdev_prop_set_after_realize(DeviceState *dev, const char *name,
>                                    Error **errp)
> @@ -578,6 +579,94 @@ const PropertyInfo qdev_prop_macaddr = {
>      .set   = set_mac,
>  };
>  
> +/* --- Reserved Region --- */
> +
> +/*
> + * accepted syntax version:

"version" feels redundant.  Suggest to capitalize "Accepted".

> + *   <low address>:<high address>:<type>
> + *   where low/high addresses are uint64_t in hexadecimal
> + *   and type is an unsigned integer in decimal
> + */
> +static void get_reserved_region(Object *obj, Visitor *v, const char *name,
> +                                void *opaque, Error **errp)
> +{
> +    DeviceState *dev = DEVICE(obj);
> +    Property *prop = opaque;
> +    ReservedRegion *rr = qdev_get_prop_ptr(dev, prop);
> +    char buffer[64];
> +    char *p = buffer;
> +    int rc;
> +
> +    rc = snprintf(buffer, sizeof(buffer), "0x%"PRIx64":0x%"PRIx64":%u",
> +                  rr->low, rr->high, rr->type);
> +    assert(rc < sizeof(buffer));
> +
> +    visit_type_str(v, name, &p, errp);
> +}
> +
> +static void set_reserved_region(Object *obj, Visitor *v, const char *name,
> +                                void *opaque, Error **errp)
> +{
> +    DeviceState *dev = DEVICE(obj);
> +    Property *prop = opaque;
> +    ReservedRegion *rr = qdev_get_prop_ptr(dev, prop);
> +    Error *local_err = NULL;
> +    const char *endptr;
> +    char *str;
> +    int ret;
> +
> +    if (dev->realized) {
> +        qdev_prop_set_after_realize(dev, name, errp);
> +        return;
> +    }
> +
> +    visit_type_str(v, name, &str, &local_err);
> +    if (local_err) {
> +        error_propagate(errp, local_err);
> +        return;
> +    }
> +
> +    ret = qemu_strtou64(str, &endptr, 16, &rr->low);
> +    if (ret) {
> +        error_setg(errp, "start address of '%s'"
> +                   " must be a hexadecimal integer", name);
> +        goto out;
> +    }
> +    if (*endptr != ':') {
> +        goto separator_error;
> +    }
> +
> +    ret = qemu_strtou64(endptr + 1, &endptr, 16, &rr->high);
> +    if (ret) {
> +        error_setg(errp, "end address of '%s'"
> +                   " must be a hexadecimal integer", name);
> +        goto out;
> +    }
> +    if (*endptr != ':') {
> +        goto separator_error;
> +    }
> +
> +    ret = qemu_strtoui(endptr + 1, &endptr, 10, &rr->type);
> +    if (ret) {
> +        error_setg(errp, "type of '%s'"
> +                   " must be an unsigned integer in decimal", name);

Suggest "must be a non-negative decimal integer".

Whatever uses the property needs a range check.  I can't see that the
patches that follow.  What am I missing?

> +    }
> +    goto out;
> +
> +separator_error:
> +    error_setg(errp, "reserved region fields must be separated with ':'");
> +out:
> +    g_free(str);
> +    return;
> +}
> +
> +const PropertyInfo qdev_prop_reserved_region = {
> +    .name  = "reserved_region",
> +    .description = "Reserved Region, example: 0xFEE00000:0xFEEFFFFF:0",
> +    .get   = get_reserved_region,
> +    .set   = set_reserved_region,
> +};
> +
>  /* --- on/off/auto --- */
>  
>  const PropertyInfo qdev_prop_on_off_auto = {

R-by for this patch stands.


