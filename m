Return-Path: <SRS0=8V6M=V6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FC45C433FF
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2019 11:41:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 40E7F206A3
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2019 11:41:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40E7F206A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33772 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1htVwc-00066K-Cr
	for qemu-devel@archiver.kernel.org; Fri, 02 Aug 2019 07:41:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55388)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <imammedo@redhat.com>) id 1htVvs-0005UA-IA
 for qemu-devel@nongnu.org; Fri, 02 Aug 2019 07:41:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1htVvn-0007tT-82
 for qemu-devel@nongnu.org; Fri, 02 Aug 2019 07:41:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51962)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>)
 id 1htVvi-0007rr-Ra; Fri, 02 Aug 2019 07:41:04 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id D36DA3083362;
 Fri,  2 Aug 2019 11:41:01 +0000 (UTC)
Received: from localhost (unknown [10.43.2.182])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DBFDE5D9D3;
 Fri,  2 Aug 2019 11:40:57 +0000 (UTC)
Date: Fri, 2 Aug 2019 13:40:56 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Message-ID: <20190802134056.789f0b4c@redhat.com>
In-Reply-To: <f48d6578-7477-40ed-750d-055e13b4db41@de.ibm.com>
References: <20190802093854.5343-1-imammedo@redhat.com>
 <20190802093854.5343-5-imammedo@redhat.com>
 <d96d27c6-0bef-f319-bb92-98f654d7ba99@redhat.com>
 <f48d6578-7477-40ed-750d-055e13b4db41@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.44]); Fri, 02 Aug 2019 11:41:01 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH RFC v2 4/4] s390: do not call
 memory_region_allocate_system_memory() multiple times
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
Cc: thuth@redhat.com, David Hildenbrand <david@redhat.com>, cohuck@redhat.com,
 qemu-devel@nongnu.org, qemu-s390x@nongnu.org, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 2 Aug 2019 12:27:50 +0200
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> On 02.08.19 12:25, David Hildenbrand wrote:
> > On 02.08.19 11:38, Igor Mammedov wrote:  
> >> s390 was trying to solve limited KVM memslot size issue by abusing
> >> memory_region_allocate_system_memory(), which breaks API contract
> >> where the function might be called only once.
> >>
> >> s390 should have used memory aliases to fragment inital memory into
> >> smaller chunks to satisfy KVM's memslot limitation. But its a bit
> >> late now, since allocated pieces are transfered in migration stream
> >> separately, so it's not possible to just replace broken layout with
> >> correct one. To workaround issue, MemoryRegion alases are made
> >> migratable and this patch switches to use them to split big initial
> >> RAM chunk into smaller pieces (KVM_SLOT_MAX_BYTES max) and registers
> >> aliases for migration. That should keep migration compatible with
> >> previous QEMU versions.
> >>
> >> New machine types (since 4.2) will use single memory region, which
> >> will get transimitted in migration stream as a whole RAMBlock.
> >>
> >> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> >> ---
> >> I don't have access to a suitable system to test it, so I've simulated
> >> it with smaller chunks on x84 host. Ping-pong migration between old
> >> and new QEMU worked fine. KVM part should be fine as memslots
> >> using mapped MemoryRegions (in this case it would be aliases) as
> >> far as I know but is someone could test it on big enough host it
> >> would be nice.
> >> ---
> >>  include/hw/s390x/s390-virtio-ccw.h |  4 +++
> >>  hw/s390x/s390-virtio-ccw.c         | 56 +++++++++++++++++++++---------
> >>  2 files changed, 43 insertions(+), 17 deletions(-)
> >>
> >> diff --git a/include/hw/s390x/s390-virtio-ccw.h b/include/hw/s390x/s390-virtio-ccw.h
> >> index 00632f94b4..f9ed3737f8 100644
> >> --- a/include/hw/s390x/s390-virtio-ccw.h
> >> +++ b/include/hw/s390x/s390-virtio-ccw.h
> >> @@ -21,6 +21,9 @@
> >>  #define S390_MACHINE_CLASS(klass) \
> >>      OBJECT_CLASS_CHECK(S390CcwMachineClass, (klass), TYPE_S390_CCW_MACHINE)
> >>  
> >> +#define S390_MACHINE_GET_CLASS(obj) \
> >> +    OBJECT_GET_CLASS(S390CcwMachineClass, (obj), TYPE_S390_CCW_MACHINE)
> >> +
> >>  /*
> >>   * KVM does only support memory slots up to KVM_MEM_MAX_NR_PAGES pages
> >>   * as the dirty bitmap must be managed by bitops that take an int as
> >> @@ -50,6 +53,7 @@ typedef struct S390CcwMachineClass {
> >>      bool cpu_model_allowed;
> >>      bool css_migration_enabled;
> >>      bool hpage_1m_allowed;
> >> +    bool split_ram_layout;
> >>  } S390CcwMachineClass;
> >>  
> >>  /* runtime-instrumentation allowed by the machine */
> >> diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
> >> index 073672f9cb..9160c1ed0a 100644
> >> --- a/hw/s390x/s390-virtio-ccw.c
> >> +++ b/hw/s390x/s390-virtio-ccw.c
> >> @@ -151,28 +151,47 @@ static void virtio_ccw_register_hcalls(void)
> >>                                     virtio_ccw_hcall_early_printk);
> >>  }
> >>  
> >> -static void s390_memory_init(ram_addr_t mem_size)
> >> +static void s390_memory_init(MachineState *ms)
> >>  {
> >> +    S390CcwMachineClass *s390mc = S390_MACHINE_GET_CLASS(ms);
> >>      MemoryRegion *sysmem = get_system_memory();
> >> -    ram_addr_t chunk, offset = 0;
> >> +    MemoryRegion *ram = g_new(MemoryRegion, 1);
> >>      unsigned int number = 0;
> >>      Error *local_err = NULL;
> >> -    gchar *name;
> >> +    ram_addr_t mem_size = ms->ram_size;
> >> +    gchar *name = g_strdup_printf(s390mc->split_ram_layout ?
> >> +                                  "s390.whole.ram" : "s390.ram");
> >>  
> >>      /* allocate RAM for core */
> >> -    name = g_strdup_printf("s390.ram");
> >> -    while (mem_size) {
> >> -        MemoryRegion *ram = g_new(MemoryRegion, 1);
> >> -        uint64_t size = mem_size;
> >> -
> >> -        /* KVM does not allow memslots >= 8 TB */
> >> -        chunk = MIN(size, KVM_SLOT_MAX_BYTES);
> >> -        memory_region_allocate_system_memory(ram, NULL, name, chunk);
> >> -        memory_region_add_subregion(sysmem, offset, ram);
> >> -        mem_size -= chunk;
> >> -        offset += chunk;
> >> -        g_free(name);
> >> -        name = g_strdup_printf("s390.ram.%u", ++number);
> >> +    memory_region_allocate_system_memory(ram, NULL, name, mem_size);
> >> +
> >> +    /* migration compatible RAM handling for 4.1 and older machines */
> >> +    if (s390mc->split_ram_layout) {
> >> +       ram_addr_t chunk, offset = 0;
> >> +       /*
> >> +        * memory_region_allocate_system_memory() registers allocated RAM for
> >> +        * migration, however for compat reasons the RAM should be passed over
> >> +        * as RAMBlocks of the size upto KVM_SLOT_MAX_BYTES. So unregister just
> >> +        * allocated RAM so it won't be migrated directly. Aliases will take care
> >> +        * of segmenting RAM into legacy chunks that migration compatible.
> >> +        */
> >> +       vmstate_unregister_ram(ram, NULL);
> >> +       name = g_strdup_printf("s390.ram");
> >> +       while (mem_size) {
> >> +           MemoryRegion *alias = g_new(MemoryRegion, 1);
> >> +
> >> +           /* KVM does not allow memslots >= 8 TB */
> >> +           chunk = MIN(mem_size, KVM_SLOT_MAX_BYTES);
> >> +           memory_region_init_alias(alias, NULL, name, ram, offset, chunk);
> >> +           vmstate_register_ram_global(alias);
> >> +           memory_region_add_subregion(sysmem, offset, alias);
> >> +           mem_size -= chunk;
> >> +           offset += chunk;
> >> +           g_free(name);
> >> +           name = g_strdup_printf("s390.ram.%u", ++number);
> >> +       }
> >> +    } else {
> >> +       memory_region_add_subregion(sysmem, 0, ram);
> >>      }
> >>      g_free(name);
> >>  
> >> @@ -257,7 +276,7 @@ static void ccw_init(MachineState *machine)
> >>  
> >>      s390_sclp_init();
> >>      /* init memory + setup max page size. Required for the CPU model */
> >> -    s390_memory_init(machine->ram_size);
> >> +    s390_memory_init(machine);
> >>  
> >>      /* init CPUs (incl. CPU model) early so s390_has_feature() works */
> >>      s390_init_cpus(machine);
> >> @@ -667,8 +686,11 @@ static void ccw_machine_4_1_instance_options(MachineState *machine)
> >>  
> >>  static void ccw_machine_4_1_class_options(MachineClass *mc)
> >>  {
> >> +    S390CcwMachineClass *s390mc = S390_MACHINE_CLASS(mc);
> >> +
> >>      ccw_machine_4_2_class_options(mc);
> >>      compat_props_add(mc->compat_props, hw_compat_4_1, hw_compat_4_1_len);
> >> +    s390mc->split_ram_layout = true;
> >>  }
> >>  DEFINE_CCW_MACHINE(4_1, "4.1", false);
> >>  
> >>  
> > 
> > As discussed, I am not sure if adding that compat code really is worth
> > it. :)  
> 
> Agreed. As long as forward migration (e.g. 4.2->4.3 will work) and we document
> that migration will fails for 2.12->.....4.1 for guests >=8TB we  can simplify
> things.

I'll drop 3/4 and compat code in this patch.

Christian,

could you test this series on big enough host to ensure that KVM memslot splitting
part works as expected (i.e. it's possible to start >8TB guest)?


