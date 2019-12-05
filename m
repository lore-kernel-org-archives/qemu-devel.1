Return-Path: <SRS0=YrRb=Z3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10795C2BD09
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2019 10:45:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC5F62464D
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2019 10:44:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a/rD3Dvi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC5F62464D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52824 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1icod0-00073A-PF
	for qemu-devel@archiver.kernel.org; Thu, 05 Dec 2019 05:44:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53402)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lersek@redhat.com>) id 1icocA-0006Ub-6t
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 05:44:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <lersek@redhat.com>) id 1icoc7-00046A-3j
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 05:44:06 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:35453
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <lersek@redhat.com>) id 1icoc6-00041I-Rj
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 05:44:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575542641;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QnZRknmfvNLHK4FGTTxnnirw9fc6t86X65qlanAoH70=;
 b=a/rD3DviNs9KyWa1iarBUrI0QrNS5hHlmz9tnaCM/weVQUuNK7VfOlvKeLhazUukws3EyG
 AwQVMMuQrkSwpo8gCbZ0uMmzkcyamohI91D9fpVLMC75OBwfP6tJ/0Y7JdQVaSHpoj52Rl
 4i8va5cRoZjnZIFaPgJgZ+/nUSizIvQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-139-zwG5bGjWMBajMo8J58DZ5Q-1; Thu, 05 Dec 2019 05:44:00 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 90B1764A7E
 for <qemu-devel@nongnu.org>; Thu,  5 Dec 2019 10:43:59 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-116-62.ams2.redhat.com
 [10.36.116.62])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 826385C1C3;
 Thu,  5 Dec 2019 10:43:52 +0000 (UTC)
Subject: Re: [PATCH for-5.0 1/8] q35: implement 128K SMRAM at default SMBASE
 address
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
References: <1575479147-6641-1-git-send-email-imammedo@redhat.com>
 <1575479147-6641-2-git-send-email-imammedo@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <e31fc667-0288-eaa5-f3a6-0b0acab59ea2@redhat.com>
Date: Thu, 5 Dec 2019 11:43:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1575479147-6641-2-git-send-email-imammedo@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: zwG5bGjWMBajMo8J58DZ5Q-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
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
Cc: pbonzini@redhat.com, philmd@redhat.com, mst@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Igor,

On 12/04/19 18:05, Igor Mammedov wrote:
> Use commit (2f295167e0 q35/mch: implement extended TSEG sizes) for
> inspiration and (ab)use reserved register in config space at 0x9c
> offset [*] to extend q35 pci-host with ability to use 128K at
> 0x30000 as SMRAM and hide it (like TSEG) from non-SMM context.
>
> Usage:
>   1: write 0xff in the register
>   2: if the feature is supported, follow up read from the register
>      should return 0x01. At this point RAM at 0x30000 is still
>      available for SMI handler configuration from non-SMM context
>   3: writing 0x02 in the register, locks SMBASE area, making its contents
>      available only from SMM context. In non-SMM context, reads return
>      0xff and writes are ignored. Further writes into the register are
>      ignored until the system reset.
>
> *) https://www.mail-archive.com/qemu-devel@nongnu.org/msg455991.html
>
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> ---
>  include/hw/pci-host/q35.h | 10 ++++++
>  hw/i386/pc.c              |  4 ++-
>  hw/pci-host/q35.c         | 80 ++++++++++++++++++++++++++++++++++++++++++-----
>  3 files changed, 86 insertions(+), 8 deletions(-)

I have now applied this series of yours on a local topic branch, on top
of v4.2.0-rc4.

Earlier, I applied your

  [Qemu-devel] [PATCH 0/2]
  q35: mch: allow to lock down 128K RAM at default SMBASE address

on top of commit f8c3db33a5e8 ("target/sparc: Switch to
do_transaction_failed() hook", 2019-09-17), on another local topic
branch. Those patches can be found at:

  http://mid.mail-archive.com/20190917130708.10281-2-imammedo@redhat.com
  http://mid.mail-archive.com/20190917130708.10281-3-imammedo@redhat.com

I have now run "git range-diff" to compare the first two patches
between both series. They are identical, except for:
- a small (harmless) context difference in patch #1,
- a slight commit message update in patch #2.

See below:

> 1:  09b22eeda732 ! 1:  5aafb1228e86 q35: implement 128K SMRAM at default SMBASE address
>     @@ -20,7 +20,7 @@
>          *) https://www.mail-archive.com/qemu-devel@nongnu.org/msg455991.html
>
>          Signed-off-by: Igor Mammedov <imammedo@redhat.com>
>     -    Message-Id: <20190917130708.10281-2-imammedo@redhat.com>
>     +    Message-Id: <1575479147-6641-2-git-send-email-imammedo@redhat.com>
>
>      diff --git a/include/hw/pci-host/q35.h b/include/hw/pci-host/q35.h
>      --- a/include/hw/pci-host/q35.h
>     @@ -61,8 +61,8 @@
>      --- a/hw/i386/pc.c
>      +++ b/hw/i386/pc.c
>      @@
>     - /* Physical Address of PVH entry point read from kernel ELF NOTE */
>     - static size_t pvh_start_addr;
>     +
>     + struct hpet_fw_config hpet_cfg = {.count = UINT8_MAX};
>
>      -GlobalProperty pc_compat_4_1[] = {};
>      +GlobalProperty pc_compat_4_1[] = {
> 2:  feeb6a5262d4 ! 2:  f1a896f4dbc6 tests: q35: MCH: add default SMBASE SMRAM lock test
>     @@ -2,11 +2,11 @@
>
>          tests: q35: MCH: add default SMBASE SMRAM lock test
>
>     -    test lockable SMRAM at default SMBASE feature introduced by
>     -    commit "q35: implement 128K SMRAM at default SMBASE address"
>     +    test lockable SMRAM at default SMBASE feature, introduced by
>     +    patch "q35: implement 128K SMRAM at default SMBASE address"
>
>          Signed-off-by: Igor Mammedov <imammedo@redhat.com>
>     -    Message-Id: <20190917130708.10281-3-imammedo@redhat.com>
>     +    Message-Id: <1575479147-6641-3-git-send-email-imammedo@redhat.com>
>
>      diff --git a/tests/q35-test.c b/tests/q35-test.c
>      --- a/tests/q35-test.c

Therefore, my Tested-by that I gave in the earlier thread, applies
still:

  http://mid.mail-archive.com/c18f1ada-3eca-d5f1-da4f-e74181c5a862@redhat.com

(I gave that T-b after writing and posting the interfacing OVMF patches,
which have been reviewed since, and waiting for the QEMU patches to go
in first.)

However, at this time, I'd like to propose two (easy) updates:

(1) In message

  http://mid.mail-archive.com/6799e19d-1aa8-ee09-9ef4-2533a7241360@redhat.com

Paolo said he was OK with this approach, but he asked for comments
stating that "this is not what real hardware does".

Can you please add such comments to the code?

Then, please see below for another comment:

On 12/04/19 18:05, Igor Mammedov wrote:
>
> diff --git a/include/hw/pci-host/q35.h b/include/hw/pci-host/q35.h
> index b3bcf2e..976fbae 100644
> --- a/include/hw/pci-host/q35.h
> +++ b/include/hw/pci-host/q35.h
> @@ -32,6 +32,7 @@
>  #include "hw/acpi/ich9.h"
>  #include "hw/pci-host/pam.h"
>  #include "hw/i386/intel_iommu.h"
> +#include "qemu/units.h"
>
>  #define TYPE_Q35_HOST_DEVICE "q35-pcihost"
>  #define Q35_HOST_DEVICE(obj) \
> @@ -54,6 +55,8 @@ typedef struct MCHPCIState {
>      MemoryRegion smram_region, open_high_smram;
>      MemoryRegion smram, low_smram, high_smram;
>      MemoryRegion tseg_blackhole, tseg_window;
> +    MemoryRegion smbase_blackhole, smbase_window;
> +    bool has_smram_at_smbase;
>      Range pci_hole;
>      uint64_t below_4g_mem_size;
>      uint64_t above_4g_mem_size;
> @@ -97,6 +100,13 @@ typedef struct Q35PCIHost {
>  #define MCH_HOST_BRIDGE_EXT_TSEG_MBYTES_QUERY  0xffff
>  #define MCH_HOST_BRIDGE_EXT_TSEG_MBYTES_MAX    0xfff
>
> +#define MCH_HOST_BRIDGE_SMBASE_SIZE            (128 * KiB)
> +#define MCH_HOST_BRIDGE_SMBASE_ADDR            0x30000
> +#define MCH_HOST_BRIDGE_F_SMBASE               0x9c
> +#define MCH_HOST_BRIDGE_F_SMBASE_QUERY         0xff
> +#define MCH_HOST_BRIDGE_F_SMBASE_IN_RAM        0x01
> +#define MCH_HOST_BRIDGE_F_SMBASE_LCK           0x02
> +
>  #define MCH_HOST_BRIDGE_PCIEXBAR               0x60    /* 64bit register */
>  #define MCH_HOST_BRIDGE_PCIEXBAR_SIZE          8       /* 64bit register */
>  #define MCH_HOST_BRIDGE_PCIEXBAR_DEFAULT       0xb0000000
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index ac08e63..9c4b4ac 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -103,7 +103,9 @@
>
>  struct hpet_fw_config hpet_cfg = {.count = UINT8_MAX};
>
> -GlobalProperty pc_compat_4_1[] = {};
> +GlobalProperty pc_compat_4_1[] = {
> +    { "mch", "smbase-smram", "off" },
> +};
>  const size_t pc_compat_4_1_len = G_N_ELEMENTS(pc_compat_4_1);
>
>  GlobalProperty pc_compat_4_0[] = {};

(2) Because this series is now being proposed for QEMU 5.0, I think this
compat property should be introduced for machine types up to and
including 4.2, not 4.1.

... Technically, this change will invalidate my Tested-by (I will not
have tested your *exact* (upcoming) v2 patch, i.e. the one including the
4.2 bump, so we can't carry the T-b forward). Thus, I will re-test your
v2 (with the extra comments and the 4.2 bump).

I have no other comments for the first two patches in this series.

Thanks!
Laszlo


> diff --git a/hw/pci-host/q35.c b/hw/pci-host/q35.c
> index 158d270..c1bd9f7 100644
> --- a/hw/pci-host/q35.c
> +++ b/hw/pci-host/q35.c
> @@ -275,20 +275,20 @@ static const TypeInfo q35_host_info = {
>   * MCH D0:F0
>   */
>
> -static uint64_t tseg_blackhole_read(void *ptr, hwaddr reg, unsigned size)
> +static uint64_t blackhole_read(void *ptr, hwaddr reg, unsigned size)
>  {
>      return 0xffffffff;
>  }
>
> -static void tseg_blackhole_write(void *opaque, hwaddr addr, uint64_t val,
> -                                 unsigned width)
> +static void blackhole_write(void *opaque, hwaddr addr, uint64_t val,
> +                            unsigned width)
>  {
>      /* nothing */
>  }
>
> -static const MemoryRegionOps tseg_blackhole_ops = {
> -    .read = tseg_blackhole_read,
> -    .write = tseg_blackhole_write,
> +static const MemoryRegionOps blackhole_ops = {
> +    .read = blackhole_read,
> +    .write = blackhole_write,
>      .endianness = DEVICE_NATIVE_ENDIAN,
>      .valid.min_access_size = 1,
>      .valid.max_access_size = 4,
> @@ -430,6 +430,46 @@ static void mch_update_ext_tseg_mbytes(MCHPCIState *mch)
>      }
>  }
>
> +static void mch_update_smbase_smram(MCHPCIState *mch)
> +{
> +    PCIDevice *pd = PCI_DEVICE(mch);
> +    uint8_t *reg = pd->config + MCH_HOST_BRIDGE_F_SMBASE;
> +    bool lck;
> +
> +    if (!mch->has_smram_at_smbase) {
> +        return;
> +    }
> +
> +    if (*reg == MCH_HOST_BRIDGE_F_SMBASE_QUERY) {
> +        pd->wmask[MCH_HOST_BRIDGE_F_SMBASE] =
> +            MCH_HOST_BRIDGE_F_SMBASE_LCK;
> +        *reg = MCH_HOST_BRIDGE_F_SMBASE_IN_RAM;
> +        return;
> +    }
> +
> +    /*
> +     * default/reset state, discard written value
> +     * which will disable SMRAM balackhole at SMBASE
> +     */
> +    if (pd->wmask[MCH_HOST_BRIDGE_F_SMBASE] == 0xff) {
> +        *reg = 0x00;
> +    }
> +
> +    memory_region_transaction_begin();
> +    if (*reg & MCH_HOST_BRIDGE_F_SMBASE_LCK) {
> +        /* disable all writes */
> +        pd->wmask[MCH_HOST_BRIDGE_F_SMBASE] &=
> +            ~MCH_HOST_BRIDGE_F_SMBASE_LCK;
> +        *reg = MCH_HOST_BRIDGE_F_SMBASE_LCK;
> +        lck = true;
> +    } else {
> +        lck = false;
> +    }
> +    memory_region_set_enabled(&mch->smbase_blackhole, lck);
> +    memory_region_set_enabled(&mch->smbase_window, lck);
> +    memory_region_transaction_commit();
> +}
> +
>  static void mch_write_config(PCIDevice *d,
>                                uint32_t address, uint32_t val, int len)
>  {
> @@ -456,6 +496,10 @@ static void mch_write_config(PCIDevice *d,
>                         MCH_HOST_BRIDGE_EXT_TSEG_MBYTES_SIZE)) {
>          mch_update_ext_tseg_mbytes(mch);
>      }
> +
> +    if (ranges_overlap(address, len, MCH_HOST_BRIDGE_F_SMBASE, 1)) {
> +        mch_update_smbase_smram(mch);
> +    }
>  }
>
>  static void mch_update(MCHPCIState *mch)
> @@ -464,6 +508,7 @@ static void mch_update(MCHPCIState *mch)
>      mch_update_pam(mch);
>      mch_update_smram(mch);
>      mch_update_ext_tseg_mbytes(mch);
> +    mch_update_smbase_smram(mch);
>
>      /*
>       * pci hole goes from end-of-low-ram to io-apic.
> @@ -514,6 +559,9 @@ static void mch_reset(DeviceState *qdev)
>                       MCH_HOST_BRIDGE_EXT_TSEG_MBYTES_QUERY);
>      }
>
> +    d->config[MCH_HOST_BRIDGE_F_SMBASE] = 0;
> +    d->wmask[MCH_HOST_BRIDGE_F_SMBASE] = 0xff;
> +
>      mch_update(mch);
>  }
>
> @@ -563,7 +611,7 @@ static void mch_realize(PCIDevice *d, Error **errp)
>      memory_region_add_subregion(&mch->smram, 0xfeda0000, &mch->high_smram);
>
>      memory_region_init_io(&mch->tseg_blackhole, OBJECT(mch),
> -                          &tseg_blackhole_ops, NULL,
> +                          &blackhole_ops, NULL,
>                            "tseg-blackhole", 0);
>      memory_region_set_enabled(&mch->tseg_blackhole, false);
>      memory_region_add_subregion_overlap(mch->system_memory,
> @@ -575,6 +623,23 @@ static void mch_realize(PCIDevice *d, Error **errp)
>      memory_region_set_enabled(&mch->tseg_window, false);
>      memory_region_add_subregion(&mch->smram, mch->below_4g_mem_size,
>                                  &mch->tseg_window);
> +
> +    memory_region_init_io(&mch->smbase_blackhole, OBJECT(mch), &blackhole_ops,
> +                          NULL, "smbase-blackhole",
> +                          MCH_HOST_BRIDGE_SMBASE_SIZE);
> +    memory_region_set_enabled(&mch->smbase_blackhole, false);
> +    memory_region_add_subregion_overlap(mch->system_memory,
> +                                        MCH_HOST_BRIDGE_SMBASE_ADDR,
> +                                        &mch->smbase_blackhole, 1);
> +
> +    memory_region_init_alias(&mch->smbase_window, OBJECT(mch),
> +                             "smbase-window", mch->ram_memory,
> +                             MCH_HOST_BRIDGE_SMBASE_ADDR,
> +                             MCH_HOST_BRIDGE_SMBASE_SIZE);
> +    memory_region_set_enabled(&mch->smbase_window, false);
> +    memory_region_add_subregion(&mch->smram, MCH_HOST_BRIDGE_SMBASE_ADDR,
> +                                &mch->smbase_window);
> +
>      object_property_add_const_link(qdev_get_machine(), "smram",
>                                     OBJECT(&mch->smram), &error_abort);
>
> @@ -601,6 +666,7 @@ uint64_t mch_mcfg_base(void)
>  static Property mch_props[] = {
>      DEFINE_PROP_UINT16("extended-tseg-mbytes", MCHPCIState, ext_tseg_mbytes,
>                         16),
> +    DEFINE_PROP_BOOL("smbase-smram", MCHPCIState, has_smram_at_smbase, true),
>      DEFINE_PROP_END_OF_LIST(),
>  };
>
>


