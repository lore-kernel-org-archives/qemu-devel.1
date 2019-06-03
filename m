Return-Path: <SRS0=e5mL=UC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1704CC04AB6
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 06:25:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E768027BDA
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 06:25:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E768027BDA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:58375 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hXgP6-0008Vi-3P
	for qemu-devel@archiver.kernel.org; Mon, 03 Jun 2019 02:25:08 -0400
Received: from eggs.gnu.org ([209.51.188.92]:45092)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richardw.yang@linux.intel.com>) id 1hXgNA-00078e-7z
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 02:23:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richardw.yang@linux.intel.com>) id 1hXgN7-0001C4-G5
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 02:23:07 -0400
Received: from mga02.intel.com ([134.134.136.20]:37852)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <richardw.yang@linux.intel.com>)
	id 1hXgN3-0000rJ-T4
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 02:23:03 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
	by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	02 Jun 2019 23:22:59 -0700
X-ExtLoop1: 1
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
	by orsmga005.jf.intel.com with ESMTP; 02 Jun 2019 23:22:57 -0700
Date: Mon, 3 Jun 2019 14:22:28 +0800
From: Wei Yang <richardw.yang@linux.intel.com>
To: Wei Yang <richardw.yang@linux.intel.com>
Message-ID: <20190603062228.GB17726@richard>
References: <20190513061913.9284-1-richardw.yang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190513061913.9284-1-richardw.yang@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 134.134.136.20
Subject: Re: [Qemu-devel] [RFC PATCH 0/9] hw/acpi: make build_madt arch
 agnostic
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: Wei Yang <richardw.yang@linux.intel.com>
Cc: yang.zhong@intel.com, ehabkost@redhat.com, mst@redhat.com,
	qemu-devel@nongnu.org, pbonzini@redhat.com, imammedo@redhat.com,
	rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Igor,

Do you have some spare time to take a look the general idea?

On Mon, May 13, 2019 at 02:19:04PM +0800, Wei Yang wrote:
>Now MADT is highly depend in architecture and machine type and leaves
>duplicated code in different architecture. The series here tries to generalize
>it.
>
>MADT contains one main table and several sub tables. These sub tables are
>highly related to architecture. Here we introduce one method to make it
>architecture agnostic.
>
>  * each architecture define its sub-table implementation function in madt_sub
>  * introduces struct madt_input to collect sub table information and pass to
>    build_madt
>
>By doing so, each architecture could prepare its own sub-table implementation
>and madt_input. And keep build_madt architecture agnostic.
>
>Wei Yang (9):
>  hw/acpi: expand pc_madt_cpu_entry in place
>  hw/acpi: implement madt_sub[ACPI_APIC_PROCESSOR]
>  hw/acpi: implement madt_sub[ACPI_APIC_LOCAL_X2APIC]
>  hw/acpi: implement madt_sub[ACPI_APIC_IO]
>  hw/acpi: implement madt_sub[ACPI_APIC_XRUPT_OVERRIDE]
>  hw/acpi: implement madt_sub[ACPI_APIC_LOCAL_X2APIC_NMI]
>  hw/acpi: implement madt_sub[ACPI_APIC_LOCAL_NMI]
>  hw/acpi: factor build_madt with madt_input
>  hw/acpi: implement madt_main to manipulate main madt table
>
> hw/acpi/cpu.c                        |  14 +-
> hw/acpi/piix4.c                      |   3 +-
> hw/i386/acpi-build.c                 | 265 +++++++++++++++++----------
> hw/isa/lpc_ich9.c                    |   3 +-
> include/hw/acpi/acpi_dev_interface.h |  12 +-
> include/hw/i386/pc.h                 |   2 +
> 6 files changed, 194 insertions(+), 105 deletions(-)
>
>-- 
>2.19.1

-- 
Wei Yang
Help you, Help me

