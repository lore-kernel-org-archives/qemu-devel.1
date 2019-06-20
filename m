Return-Path: <SRS0=JMAk=UT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 941A9C43613
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2019 14:39:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 60C902084A
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2019 14:39:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EdkmQuwX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60C902084A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48386 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdyE1-0007s9-RJ
	for qemu-devel@archiver.kernel.org; Thu, 20 Jun 2019 10:39:41 -0400
Received: from eggs.gnu.org ([209.51.188.92]:37988)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.weiyang@gmail.com>) id 1hdy8H-00022u-5c
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 10:33:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.weiyang@gmail.com>) id 1hdxtm-0002YP-Gh
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 10:20:35 -0400
Received: from mail-ed1-x542.google.com ([2a00:1450:4864:20::542]:35917)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.weiyang@gmail.com>)
 id 1hdxtm-0002Xv-Av
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 10:18:46 -0400
Received: by mail-ed1-x542.google.com with SMTP id k21so4996720edq.3
 for <qemu-devel@nongnu.org>; Thu, 20 Jun 2019 07:18:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=qdVDpTURAiB1SW/IAbXTaS4d4qTb3suKU1xREmXg18U=;
 b=EdkmQuwXaVALYatY5/mocNlBXGRgL+PARVVZZVy4CWNm7zABXKY18rmqVuSQeQxLVt
 R4oZ4wxGfJCdZcu8+wcljjtSpPtQUhQvmTA10eFmNCKX99ukBGH6bfdqmX7jAdd6DaWj
 HsZGi1IdNlwg7svJ+VUXy24JtlguxC7H6fP4YhGMRkop/LJMdLCOTQfkax+vsQvESn3C
 Ruz6Y+wochoahp1eaXssuz2Wv3+k66yiZiyLPg43Ra9dgxX67DpAqJ5LjSZ44f3a7etI
 XE/XdrDiG1aPd187qeEP+eoaliEGkAra2A3jyea65vSQFIgPrjnbI3cehsU4bHKDSk1u
 2s1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
 :references:mime-version:content-disposition:in-reply-to:user-agent;
 bh=qdVDpTURAiB1SW/IAbXTaS4d4qTb3suKU1xREmXg18U=;
 b=op5AfpgEogNZuwkR3fvELuyWKcN/Zj4Rpr+tRPitqFABX6rCdD9FpoW54Uk9ahXpH7
 xjzwXcUvJ4mQfxpxAdk8lP8wK5wFswexM+GVtNvMEbD0Vkb5n6wBirgyZCzjx7vGYZ85
 mxeRxIQVDrrUJP8evk5qiO3TbNBJmfzZJT55FhUGOEgUvD8S2r8s50aTxOIsMNqcYAIz
 VfGzkkS5ZZQzEfKwGy2oaiwwt60ydZBg+CfTRkHL4fd+g1zBGzG0Mlg8ywaBUhEu7/HL
 zW0Tcup1MMh5o9Ys5h8aZE9veIdCEcieIxBlqY93kTzrlNfVRPkLL4+PKzMCpFPl2bp1
 UTEA==
X-Gm-Message-State: APjAAAVm9fi5yq1Gg+S/frFTQ8vo/g7M6O8Azfya9MakR3tBUQv41BqQ
 AsaRgkxovNX0hCqD0uFEBTM=
X-Google-Smtp-Source: APXvYqzxCAohb/V1gPxW1e1x3KXn/fLgrKSsdZpCdzIgNjMruArul8JUNNmzeZOvcvtIXd60AtZysg==
X-Received: by 2002:a50:94a2:: with SMTP id
 s31mr100273775eda.290.1561040324419; 
 Thu, 20 Jun 2019 07:18:44 -0700 (PDT)
Received: from localhost ([185.92.221.13])
 by smtp.gmail.com with ESMTPSA id g2sm2744135edg.81.2019.06.20.07.18.42
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 20 Jun 2019 07:18:43 -0700 (PDT)
Date: Thu, 20 Jun 2019 14:18:42 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20190620141842.ijqwozpjrkccy7qx@master>
References: <20190513061913.9284-1-richardw.yang@linux.intel.com>
 <20190618175956.4373ac7e@redhat.com>
 <20190619062050.GA15665@richard>
 <20190619110440.13a54848@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190619110440.13a54848@redhat.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::542
Subject: Re: [Qemu-devel] [RFC PATCH 0/9] hw/acpi: make build_madt arch
 agnostic
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
Reply-To: Wei Yang <richard.weiyang@gmail.com>
Cc: yang.zhong@intel.com, ehabkost@redhat.com, mst@redhat.com,
 qemu-devel@nongnu.org, Wei Yang <richardw.yang@linux.intel.com>,
 pbonzini@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jun 19, 2019 at 11:04:40AM +0200, Igor Mammedov wrote:
>On Wed, 19 Jun 2019 14:20:50 +0800
>Wei Yang <richardw.yang@linux.intel.com> wrote:
>
>> On Tue, Jun 18, 2019 at 05:59:56PM +0200, Igor Mammedov wrote:
>> >
>> >On Mon, 13 May 2019 14:19:04 +0800
>> >Wei Yang <richardw.yang@linux.intel.com> wrote:
>> >  
>> >> Now MADT is highly depend in architecture and machine type and leaves
>> >> duplicated code in different architecture. The series here tries to generalize
>> >> it.
>> >> 
>> >> MADT contains one main table and several sub tables. These sub tables are
>> >> highly related to architecture. Here we introduce one method to make it
>> >> architecture agnostic.
>> >> 
>> >>   * each architecture define its sub-table implementation function in madt_sub
>> >>   * introduces struct madt_input to collect sub table information and pass to
>> >>     build_madt
>> >> 
>> >> By doing so, each architecture could prepare its own sub-table implementation
>> >> and madt_input. And keep build_madt architecture agnostic.  
>> >
>> >I've skimmed over patches, and to me it looks mostly as code movement
>> >without apparent benefits and probably a bit more complex than what we have now
>> >(it might be ok cost if it simplifies MADT support for other boards).
>> >
>> >Before I do line by line review could you demonstrate what effect new way
>> >to build MADT would have on arm/virt and i386/virt (from NEMU). So it would be
>> >possible to estimate net benefits from new approach?
>> >(PS: it doesn't have to be patches ready for merging, just a dirty hack
>> >that would demonstrate adding MADT for new board using mad_sub[])
>> >  
>> 
>> Per APIC spec 5.2.12, MADT contains a *main* table and several *sub* tables
>> (Interrupt Controllere), so the idea is give a callback hook in
>> AcpiDeviceIfClass for each table, including *main* and *sub* table.
>> 
>> Current AcpiDeviceIfClass has one callback pc_madt_cpu_entry for some *sub*
>> tables, after replacing the AcpiDeviceIfClass will look like this:
>> 
>> typedef struct AcpiDeviceIfClass {
>>     /* <private> */
>>     InterfaceClass parent_class;
>> 
>>     /* <public> */
>>     void (*ospm_status)(AcpiDeviceIf *adev, ACPIOSTInfoList ***list);
>>     void (*send_event)(AcpiDeviceIf *adev, AcpiEventStatusBits ev);
>> -   void (*madt_cpu)(AcpiDeviceIf *adev, int uid,
>> -                    const CPUArchIdList *apic_ids, GArray *entry);
>> +   madt_operation madt_main;
>> +   madt_operation *madt_sub;
>> } AcpiDeviceIfClass;
>> 
>> By doing so, each arch could have its own implementation for MADT.
>> 
>> After this refactoring, build_madt could be simplified to:
>> 
>> build_madt(GArray *table_data, BIOSLinker *linker, PCMachineState *pcms,
>>            struct madt_input *input)
>> {
>>     ...
>> 
>>     if (adevc->madt_main) {
>>         adevc->madt_main(table_data, madt);
>>     }
>> 
>>     for (i = 0; ; i++) {
>>         sub_id = input[i].sub_id;
>>         if (sub_id == ACPI_APIC_RESERVED) {
>>             break;
>>         }
>>         opaque = input[i].opaque;
>>         adevc->madt_sub[sub_id](table_data, opaque);
>>     }
>> 
>>     ...
>> }
>> 
>> input is a list of data necessary to build *sub* table. Its details is also
>> arch dependent.
>I've got general idea reading patches in this series.
>As I've mentioned before it's hard to generalize MADT since it
>mostly contains entries unique for target/board.
>Goal here isn't generalizing at any cost, but rather find out
>if there is enough common code to justify generalization
>and if it allows us to reduce code duplication and simplify.
>
>> For following new arch, what it need to do is prepare the input array and
>> implement necessary *main*/*sub* table callbacks.
>What I'd like to see is the actual patch that does this,
>to see if it has any merit and to compare to the current
>approach.

I didn't get some idea about your approach. Would you mind sharing more light?

-- 
Wei Yang
Help you, Help me

