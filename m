Return-Path: <SRS0=TEh4=AD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30464C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 11:24:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE2F420708
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 11:24:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LHJP/31m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE2F420708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35198 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnKYz-0005ZK-7T
	for qemu-devel@archiver.kernel.org; Mon, 22 Jun 2020 07:24:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43436)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jnKXe-0004b4-IZ
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 07:23:10 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:33693
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jnKXW-0007FK-6n
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 07:23:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592824979;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TjN9niWCYIS4eow/uuCs74h2CERnYyO6Wpq+y+Da3P0=;
 b=LHJP/31mUvn+omAGjZUMSQg/rENo7T18J9aySLio1Rslvgw0arl/JKcrjzWVa4No6Imvsj
 8iqpsYO4NUCQYiDZmJVUdCvHoEQPD377IuSjCkhgKI8tuVW6LSNBM/zqKKeuNig27umr+J
 UKEQEFuccWS8BdNFZ0bkrLIO2Ut/RXU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-136-wSm1QWw6MGaKtkYbtY1_xQ-1; Mon, 22 Jun 2020 07:22:55 -0400
X-MC-Unique: wSm1QWw6MGaKtkYbtY1_xQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7998C8005AD;
 Mon, 22 Jun 2020 11:22:54 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-121.ams2.redhat.com
 [10.36.112.121])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CA0D31A8F5;
 Mon, 22 Jun 2020 11:22:47 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 4F733113846D; Mon, 22 Jun 2020 13:22:46 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Eric Auger <eric.auger@redhat.com>
Subject: Re: [PATCH v3 1/5] qdev: Introduce DEFINE_PROP_RESERVED_REGION
References: <20200611151209.22547-1-eric.auger@redhat.com>
 <20200611151209.22547-2-eric.auger@redhat.com>
Date: Mon, 22 Jun 2020 13:22:46 +0200
In-Reply-To: <20200611151209.22547-2-eric.auger@redhat.com> (Eric Auger's
 message of "Thu, 11 Jun 2020 17:12:05 +0200")
Message-ID: <87k0zzz6nt.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Received-SPF: pass client-ip=205.139.110.120; envelope-from=armbru@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/22 01:27:42
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
> <low address>, <high address>, <type>.
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
> The reserved region will be: 0xfee00000, 0xfeefffff, 1.
>
> On ARM, we can declare the ITS MSI doorbell as an MSI
> region to prevent MSIs from being mapped on guest side.
>
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>
> ---
>
> v11 -> v12:
> - rename into DEFINE_PROP_RESERVED_REGION
> - do not use g_strsplit anymore, use endptr instead
> - remove 0x references
> ---
>  include/exec/memory.h        |  6 +++
>  include/hw/qdev-properties.h |  3 ++
>  include/qemu/typedefs.h      |  1 +
>  hw/core/qdev-properties.c    | 89 ++++++++++++++++++++++++++++++++++++
>  4 files changed, 99 insertions(+)
>
> diff --git a/include/exec/memory.h b/include/exec/memory.h
> index 3e00cdbbfa..3ee8224fa7 100644
> --- a/include/exec/memory.h
> +++ b/include/exec/memory.h
> @@ -57,6 +57,12 @@ struct MemoryRegionMmio {
>      CPUWriteMemoryFunc *write[3];
>  };
>  
> +struct ReservedRegion {
> +    hwaddr low;
> +    hwaddr high;
> +    unsigned int type;
> +};
> +
>  typedef struct IOMMUTLBEntry IOMMUTLBEntry;
>  
>  /* See address_space_translate: bit 0 is read, bit 1 is write.  */
> diff --git a/include/hw/qdev-properties.h b/include/hw/qdev-properties.h
> index f161604fb6..03bf850a7e 100644
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
> @@ -183,6 +184,8 @@ extern const PropertyInfo qdev_prop_pcie_link_width;
>      DEFINE_PROP(_n, _s, _f, qdev_prop_drive_iothread, BlockBackend *)
>  #define DEFINE_PROP_MACADDR(_n, _s, _f)         \
>      DEFINE_PROP(_n, _s, _f, qdev_prop_macaddr, MACAddr)
> +#define DEFINE_PROP_RESERVED_REGION(_n, _s, _f)         \
> +    DEFINE_PROP(_n, _s, _f, qdev_prop_reserved_region, ReservedRegion)
>  #define DEFINE_PROP_ON_OFF_AUTO(_n, _s, _f, _d) \
>      DEFINE_PROP_SIGNED(_n, _s, _f, _d, qdev_prop_on_off_auto, OnOffAuto)
>  #define DEFINE_PROP_MULTIFD_COMPRESSION(_n, _s, _f, _d) \
> diff --git a/include/qemu/typedefs.h b/include/qemu/typedefs.h
> index ecf3cde26c..85c4f891f4 100644
> --- a/include/qemu/typedefs.h
> +++ b/include/qemu/typedefs.h
> @@ -59,6 +59,7 @@ typedef struct ISABus ISABus;
>  typedef struct ISADevice ISADevice;
>  typedef struct IsaDma IsaDma;
>  typedef struct MACAddr MACAddr;
> +typedef struct ReservedRegion ReservedRegion;
>  typedef struct MachineClass MachineClass;
>  typedef struct MachineState MachineState;
>  typedef struct MemoryListener MemoryListener;
> diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
> index cc924815da..15b84adbee 100644
> --- a/hw/core/qdev-properties.c
> +++ b/hw/core/qdev-properties.c
> @@ -14,6 +14,7 @@
>  #include "qapi/visitor.h"
>  #include "chardev/char.h"
>  #include "qemu/uuid.h"
> +#include "qemu/cutils.h"
>  
>  void qdev_prop_set_after_realize(DeviceState *dev, const char *name,
>                                    Error **errp)
> @@ -577,6 +578,94 @@ const PropertyInfo qdev_prop_macaddr = {
>      .set   = set_mac,
>  };
>  
> +/* --- Reserved Region --- */
> +
> +/*
> + * accepted syntax version:
> + *   <low address>,<high address>,<type>
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
> +
> +    snprintf(buffer, sizeof(buffer), "0x%"PRIx64",0x%"PRIx64",%u",
> +             rr->low, rr->high, rr->type);

Matches existing practice in other getters.  Nevertheless, I'd suggest
something like

       n = snprintf(buffer, sizeof(buffer), ...);
       assert(n < sizeof(buffer);

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
> +        error_setg(errp, "Failed to decode reserved region low addr");
> +        error_append_hint(errp,
> +                          "should be an address in hexadecimal\n");

Comes out like this:

    qemu-system-x86_64: -device ...: Failed to decode reserved region low addr
    should be an address in hexadecimal

I'd capitalize the other way, to get

    qemu-system-x86_64: -device ...: failed to decode reserved region low addr
    Should be an address in hexadecimal

Note: output is made up; I failed at figuring out how to use the new
property.  An example in PATCH 4's commit message might help.

Since the error message fails to mention @name, the user is left
guessing unless "-device ..." contains just one reserved region
parameter.

What about something like this:

           error_setg(errp, "start address of reserved region '%s'"
                      " must be a hexadecimal integer",
                      name);

No need to mess around with error_append_hint() then.

Same for the other error messages.

> +        goto out;
> +    }
> +    if (*endptr != ',') {
> +        goto separator_error;
> +    }
> +
> +    ret = qemu_strtou64(endptr + 1, &endptr, 16, &rr->high);
> +    if (ret) {
> +        error_setg(errp, "Failed to decode reserved region high addr");
> +        error_append_hint(errp,
> +                          "should be an address in hexadecimal\n");
> +        goto out;
> +    }
> +    if (*endptr != ',') {
> +        goto separator_error;
> +    }
> +
> +    ret = qemu_strtoui(endptr + 1, &endptr, 10, &rr->type);
> +    if (ret) {
> +        error_setg(errp, "Failed to decode reserved region type");
> +        error_append_hint(errp, "should be an unsigned integer in decimal\n");
> +    }

I dimly remember discussing the wisdom of numeric type here, dig, dig,
..., aha:

    Subject: Re: [PATCH for-5.0 v11 12/20] qapi: Introduce DEFINE_PROP_INTERVAL
    Date: Fri, 13 Dec 2019 11:03:02 +0100
    Message-ID: <87y2vg4k6h.fsf@dusky.pond.sub.org>

    >> So the "label" part of "<low address>,<high address>,label" is a number?
    > yes it is.
    >> 
    >> Is a number appropriate for your use case, or would an enum be better?
    > I think a number is OK. There might be other types of reserved regions
    > in the future. Also if we want to allow somebody else to reuse that
    > property in another context, I would rather leave it open?

    I'd prioritize the user interface over possible reuse (which might never
    happen).  Mind, I'm not telling you using numbers is a bad user
    interface.  In general, enums are nicer, but I don't know enough about
    this particular case.

> +    goto out;
> +
> +separator_error:
> +    error_setg(errp, "reserved region fields must be separated with commas");

I'm not sure de-duplicating this error message is worth the extra goto.

> +out:
> +    g_free(str);
> +    return;
> +}
> +
> +const PropertyInfo qdev_prop_reserved_region = {
> +    .name  = "reserved_region",
> +    .description = "Reserved Region, example: 0xFEE00000,0xFEEFFFFF,0",
> +    .get   = get_reserved_region,
> +    .set   = set_reserved_region,
> +};
> +
>  /* --- on/off/auto --- */
>  
>  const PropertyInfo qdev_prop_on_off_auto = {

Can't find anything that's actually wrong, so

Reviewed-by: Markus Armbruster <armbru@redhat.com>


