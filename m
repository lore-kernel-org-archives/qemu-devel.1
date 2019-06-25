Return-Path: <SRS0=PhvJ=UY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64F8DC48BD5
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2019 13:53:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3DBFD213F2
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2019 13:53:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DBFD213F2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60504 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hflsk-00015h-Cz
	for qemu-devel@archiver.kernel.org; Tue, 25 Jun 2019 09:53:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57902)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <imammedo@redhat.com>) id 1hflYq-0002bz-So
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 09:32:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1hflYp-0000DE-EE
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 09:32:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37628)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>)
 id 1hflYl-000083-18; Tue, 25 Jun 2019 09:32:31 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id D821981DF3;
 Tue, 25 Jun 2019 13:32:22 +0000 (UTC)
Received: from localhost (unknown [10.43.2.182])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 86D6B5D9C5;
 Tue, 25 Jun 2019 13:32:16 +0000 (UTC)
Date: Tue, 25 Jun 2019 15:32:12 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: gengdongjiu <gengdongjiu@huawei.com>
Message-ID: <20190625153212.1fff6b40@redhat.com>
In-Reply-To: <3059ee08-c041-2006-36b5-fd0e53c08e79@huawei.com>
References: <1557832703-42620-1-git-send-email-gengdongjiu@huawei.com>
 <1557832703-42620-11-git-send-email-gengdongjiu@huawei.com>
 <20190624150810.1287160e@redhat.com>
 <3059ee08-c041-2006-36b5-fd0e53c08e79@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.25]); Tue, 25 Jun 2019 13:32:30 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v17 10/10] target-arm: kvm64: handle SIGBUS
 signal from kernel or KVM
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
Cc: peter.maydell@linaro.org, ehabkost@redhat.com, kvm@vger.kernel.org,
 mst@redhat.com, mtosatti@redhat.com, qemu-devel@nongnu.org,
 linuxarm@huawei.com, shannon.zhaosl@gmail.com, zhengxiang9@huawei.com,
 qemu-arm@nongnu.org, james.morse@arm.com, xuwei5@huawei.com,
 jonathan.cameron@huawei.com, pbonzini@redhat.com, lersek@redhat.com,
 rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 25 Jun 2019 20:24:32 +0800
gengdongjiu <gengdongjiu@huawei.com> wrote:

> On 2019/6/24 21:08, Igor Mammedov wrote:
> > On Tue, 14 May 2019 04:18:23 -0700
> > Dongjiu Geng <gengdongjiu@huawei.com> wrote:
> >   
> >> Add SIGBUS signal handler. In this handler, it checks the SIGBUS type,
> >> translates the host VA delivered by host to guest PA, then fill this PA
> >> to guest APEI GHES memory, then notify guest according to the SIGBUS type.
> >>
> >> If guest accesses the poisoned memory, it generates Synchronous External
> >> Abort(SEA). Then host kernel gets an APEI notification and call memory_failure()
> >> to unmapped the affected page for the guest's stage 2, finally return
> >> to guest.
> >>
> >> Guest continues to access PG_hwpoison page, it will trap to KVM as stage2 fault,
> >> then a SIGBUS_MCEERR_AR synchronous signal is delivered to Qemu, Qemu record this
> >> error address into guest APEI GHES memory and notify guest using
> >> Synchronous-External-Abort(SEA).
> >>
> >> Suggested-by: James Morse <james.morse@arm.com>
> >> Signed-off-by: Dongjiu Geng <gengdongjiu@huawei.com>
> >> ---
> >>  hw/acpi/acpi_ghes.c         | 177 ++++++++++++++++++++++++++++++++++++++++++++
> >>  include/hw/acpi/acpi_ghes.h |   6 +-
> >>  include/sysemu/kvm.h        |   2 +-
> >>  target/arm/kvm64.c          |  39 ++++++++++
> >>  4 files changed, 222 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/hw/acpi/acpi_ghes.c b/hw/acpi/acpi_ghes.c
> >> index d03e797..06b7374 100644
> >> --- a/hw/acpi/acpi_ghes.c
> >> +++ b/hw/acpi/acpi_ghes.c
> >> @@ -26,6 +26,101 @@
> >>  #include "sysemu/sysemu.h"
> >>  #include "qemu/error-report.h"
> >>  
> >> +/* UEFI 2.6: N.2.5 Memory Error Section */
> >> +static void build_append_mem_cper(GArray *table, uint64_t error_physical_addr)
> >> +{
> >> +    /*
> >> +     * Memory Error Record
> >> +     */
> >> +    build_append_int_noprefix(table,
> >> +                 (1UL << 14) | /* Type Valid */
> >> +                 (1UL << 1) /* Physical Address Valid */,
> >> +                 8);  
> > bad indent  
> I will update it
> 
> >   
> >> +    /* Memory error status information */
> >> +    build_append_int_noprefix(table, 0, 8);
> >> +    /* The physical address at which the memory error occurred */
> >> +    build_append_int_noprefix(table, error_physical_addr, 8);
> >> +    build_append_int_noprefix(table, 0, 48);
> >> +    build_append_int_noprefix(table, 0 /* Unknown error */, 1);
> >> +    build_append_int_noprefix(table, 0, 7);
> >> +}
> >> +
> >> +static int ghes_record_mem_error(uint64_t error_block_address,
> >> +                                    uint64_t error_physical_addr)  
> > bad indent  
> I will update it
> 
> > 
> >   
> >> +{
> >> +    GArray *block;
> >> +    uint64_t current_block_length;
> >> +    uint32_t data_length;
> >> +    /* Memory section */
> >> +    char mem_section_id_le[] = {0x14, 0x11, 0xBC, 0xA5, 0x64, 0x6F, 0xDE,
> >> +                                0x4E, 0xB8, 0x63, 0x3E, 0x83, 0xED, 0x7C,
> >> +                                0x83, 0xB1};
> >> +    uint8_t fru_id[16] = {0};
> >> +    uint8_t fru_text[20] = {0};
> >> +
> >> +    /* Generic Error Status Block
> >> +     * | +---------------------+
> >> +     * | |     block_status    |
> >> +     * | +---------------------+
> >> +     * | |    raw_data_offset  |
> >> +     * | +---------------------+
> >> +     * | |    raw_data_length  |
> >> +     * | +---------------------+
> >> +     * | |     data_length     |
> >> +     * | +---------------------+
> >> +     * | |   error_severity    |
> >> +     * | +---------------------+
> >> +     */
> >> +    block = g_array_new(false, true /* clear */, 1);
> >> +
> >> +    /* Get the length of the Generic Error Data Entries */
> >> +    cpu_physical_memory_read(error_block_address +
> >> +        offsetof(AcpiGenericErrorStatus, data_length), &data_length, 4);
> >> +    /* The current whole length of the generic error status block */
> >> +    current_block_length = sizeof(AcpiGenericErrorStatus) + le32_to_cpu(data_length);  
> > I might be missing something but why do you read length from guest?
> > Isn't it something provided by QEMU/host?  
> The length of the Generic Error Data Entries is not fixed, as the CPER number increases, the length will increase.
> there is already a member to record the length for the CPER in the table, this table is in the guest.
> so it is better directly read the length from the table instead of providing by QEMU/host.
If not careful using guest provided length for reading/writing buffers in QEMU opens road for exploits.

So if CPER is provided and managed by QEMU then it's better to calculate length
without relying on guest state. Or even rewrite whole status block without trying
to calculate delta.


