Return-Path: <SRS0=fi8h=Z7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1CEFC43603
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 20:13:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6829B2068E
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 20:13:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BtZNNnaE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6829B2068E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46708 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iePP1-0006dG-FS
	for qemu-devel@archiver.kernel.org; Mon, 09 Dec 2019 15:13:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53272)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lersek@redhat.com>) id 1iePO7-0005rA-O3
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 15:12:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <lersek@redhat.com>) id 1iePO3-00042S-IG
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 15:12:09 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:27979
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <lersek@redhat.com>) id 1iePO3-00041K-3k
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 15:12:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575922326;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=d/uTq12vnJbOpLcNV6q7wpUOqxoqnpzKtokqDWMgyp8=;
 b=BtZNNnaEJA+7xmYAHNScVO2E3n8JIet9cj5I615QlJItYGWenyCYa9F6BQ+6r/tDYgDuZE
 fH2MYwPPUsDLP5pAlplv4NKP3GIejO6XRP98etV1uIvApWFb6Jm3OCnrLY+siOa8HMDegy
 GFtKWxBhuJ1XDmoSnSexn/e7AGQWucQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-9-BuqqbbtxPgyJJIO2BP0-yg-1; Mon, 09 Dec 2019 15:12:04 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9130B800D4C
 for <qemu-devel@nongnu.org>; Mon,  9 Dec 2019 20:12:03 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (unknown [10.36.118.92])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5FAA35DA60;
 Mon,  9 Dec 2019 20:11:54 +0000 (UTC)
Subject: Re: [PATCH for-5.0 v2 2/9] q35: implement 128K SMRAM at default
 SMBASE address
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
References: <1575896942-331151-1-git-send-email-imammedo@redhat.com>
 <1575896942-331151-3-git-send-email-imammedo@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <384d6103-6a04-e1c4-498c-e6718b5cf6d8@redhat.com>
Date: Mon, 9 Dec 2019 21:11:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1575896942-331151-3-git-send-email-imammedo@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: BuqqbbtxPgyJJIO2BP0-yg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
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
Cc: pbonzini@redhat.com, philmd@redhat.com, mst@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/09/19 14:08, Igor Mammedov wrote:
> It's not what real HW does, implementing which would be overkill [**]
> and would require complex cross stack changes (QEMU+firmware) to make
> it work.
> So considering that SMRAM is owned by MCH, for simplicity (ab)use
> reserved Q35 register, which allows QEMU and firmware easily init
> and make RAM at SMBASE available only from SMM context.
>
> Patch uses commit (2f295167e0 q35/mch: implement extended TSEG sizes)
> for inspiration and uses reserved register in config space at 0x9c
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
> **) https://www.mail-archive.com/qemu-devel@nongnu.org/msg646965.html
>
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> ---
> V2:
>   - add a note in commit message/coed that used approach is QEMU hack
>     to make impl. simple instead of going after VT-d approach
>     which real HW does.
>     (Paolo Bonzini <pbonzini@redhat.com>)
>   - rebase on top of (hw: add compat machines for 5.0), and move
>     compat property smbase-smram to pc_compat_4_2[]
>     ("Laszlo Ersek" <lersek@redhat.com>)
> ---
>  include/hw/pci-host/q35.h | 10 ++++++
>  hw/i386/pc.c              |  4 ++-
>  hw/pci-host/q35.c         | 84 +++++++++++++++++++++++++++++++++++++++++++----
>  3 files changed, 90 insertions(+), 8 deletions(-)

Interdiff per git-range-diff, with the last version applied on
1bdc319ab5d2 ("Update version for v4.2.0-rc4 release", 2019-12-03; aka
"v4.2.0-rc4"), and the present version applied on 9b4efa2ede5d ("Merge
remote-tracking branch 'remotes/ericb/tags/pull-nbd-2019-12-09' into
staging", 2019-12-09):

>  1:  5aafb1228e86 !  2:  effa5c4ca588 q35: implement 128K SMRAM at default SMBASE address
>     @@ -2,8 +2,15 @@
>
>          q35: implement 128K SMRAM at default SMBASE address
>
>     -    Use commit (2f295167e0 q35/mch: implement extended TSEG sizes) for
>     -    inspiration and (ab)use reserved register in config space at 0x9c
>     +    It's not what real HW does, implementing which would be overkill [**]
>     +    and would require complex cross stack changes (QEMU+firmware) to make
>     +    it work.
>     +    So considering that SMRAM is owned by MCH, for simplicity (ab)use
>     +    reserved Q35 register, which allows QEMU and firmware easily init
>     +    and make RAM at SMBASE available only from SMM context.
>     +
>     +    Patch uses commit (2f295167e0 q35/mch: implement extended TSEG sizes)
>     +    for inspiration and uses reserved register in config space at 0x9c
>          offset [*] to extend q35 pci-host with ability to use 128K at
>          0x30000 as SMRAM and hide it (like TSEG) from non-SMM context.
>
>     @@ -18,9 +25,10 @@
>               ignored until the system reset.
>
>          *) https://www.mail-archive.com/qemu-devel@nongnu.org/msg455991.html
>     +    **) https://www.mail-archive.com/qemu-devel@nongnu.org/msg646965.html
>
>          Signed-off-by: Igor Mammedov <imammedo@redhat.com>
>     -    Message-Id: <1575479147-6641-2-git-send-email-imammedo@redhat.com>
>     +    Message-Id: <1575896942-331151-3-git-send-email-imammedo@redhat.com>
>
>      diff --git a/include/hw/pci-host/q35.h b/include/hw/pci-host/q35.h
>      --- a/include/hw/pci-host/q35.h
>     @@ -64,13 +72,13 @@
>
>       struct hpet_fw_config hpet_cfg = {.count = UINT8_MAX};
>
>     --GlobalProperty pc_compat_4_1[] = {};
>     -+GlobalProperty pc_compat_4_1[] = {
>     +-GlobalProperty pc_compat_4_2[] = {};
>     ++GlobalProperty pc_compat_4_2[] = {
>      +    { "mch", "smbase-smram", "off" },
>      +};
>     - const size_t pc_compat_4_1_len = G_N_ELEMENTS(pc_compat_4_1);
>     + const size_t pc_compat_4_2_len = G_N_ELEMENTS(pc_compat_4_2);
>
>     - GlobalProperty pc_compat_4_0[] = {};
>     + GlobalProperty pc_compat_4_1[] = {};
>
>      diff --git a/hw/pci-host/q35.c b/hw/pci-host/q35.c
>      --- a/hw/pci-host/q35.c
>     @@ -192,6 +200,10 @@
>           memory_region_add_subregion(&mch->smram, mch->below_4g_mem_size,
>                                       &mch->tseg_window);
>      +
>     ++    /*
>     ++     * This is not what hardware does, so it's QEMU specific hack.
>     ++     * See commit message for details.
>     ++     */
>      +    memory_region_init_io(&mch->smbase_blackhole, OBJECT(mch), &blackhole_ops,
>      +                          NULL, "smbase-blackhole",
>      +                          MCH_HOST_BRIDGE_SMBASE_SIZE);

Thanks for the updates.

Tested as follows. Because the differences are minimal / superficial in
comparison to the last two postings:

(a) http://mid.mail-archive.com/c18f1ada-3eca-d5f1-da4f-e74181c5a862@redhat.com
(b) http://mid.mail-archive.com/e31fc667-0288-eaa5-f3a6-0b0acab59ea2@redhat.com

I only repeated a subset of the previous tests (a). Namely:

- patched OVMF
  <http://mid.mail-archive.com/20190924113505.27272-1-lersek@redhat.com>,
  feature disabled via "pc-q35-4.2" machine type, Fedora guest, normal
  boot and S3,

- patched OVMF, feature enabled via "pc-q35-5.0" machine type, Fedora
  guest, normal boot and S3.

Compared the following artifacts between the above two machine types:

- OVMF boot log and S3 resume log,

- "info mtree" ("smbase-blackhole" & "smbase-window" disabled vs.
  enabled), after normal boot, and after S3 resume.

For this patch:

Tested-by: Laszlo Ersek <lersek@redhat.com>

Thanks!
Laszlo

On 12/09/19 14:08, Igor Mammedov wrote:
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
> index 58867f9..ff4d583 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -103,7 +103,9 @@
>
>  struct hpet_fw_config hpet_cfg = {.count = UINT8_MAX};
>
> -GlobalProperty pc_compat_4_2[] = {};
> +GlobalProperty pc_compat_4_2[] = {
> +    { "mch", "smbase-smram", "off" },
> +};
>  const size_t pc_compat_4_2_len = G_N_ELEMENTS(pc_compat_4_2);
>
>  GlobalProperty pc_compat_4_1[] = {};
> diff --git a/hw/pci-host/q35.c b/hw/pci-host/q35.c
> index 158d270..6342f73 100644
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
> @@ -575,6 +623,27 @@ static void mch_realize(PCIDevice *d, Error **errp)
>      memory_region_set_enabled(&mch->tseg_window, false);
>      memory_region_add_subregion(&mch->smram, mch->below_4g_mem_size,
>                                  &mch->tseg_window);
> +
> +    /*
> +     * This is not what hardware does, so it's QEMU specific hack.
> +     * See commit message for details.
> +     */
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
> @@ -601,6 +670,7 @@ uint64_t mch_mcfg_base(void)
>  static Property mch_props[] = {
>      DEFINE_PROP_UINT16("extended-tseg-mbytes", MCHPCIState, ext_tseg_mbytes,
>                         16),
> +    DEFINE_PROP_BOOL("smbase-smram", MCHPCIState, has_smram_at_smbase, true),
>      DEFINE_PROP_END_OF_LIST(),
>  };
>
>


