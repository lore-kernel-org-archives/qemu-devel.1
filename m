Return-Path: <SRS0=C20x=A7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A727C433E3
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2020 19:13:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A3672176B
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2020 19:13:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YoFN2neV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A3672176B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57702 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jxbEc-0005oT-5f
	for qemu-devel@archiver.kernel.org; Mon, 20 Jul 2020 15:13:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45394)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1jxbDr-0004uJ-4K
 for qemu-devel@nongnu.org; Mon, 20 Jul 2020 15:13:11 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:51873
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1jxbDo-0002FG-4Q
 for qemu-devel@nongnu.org; Mon, 20 Jul 2020 15:13:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595272386;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bSbQqiS0Vsmq0Re04Uq/Tqm2kyVko5fcWCB5Pqi71U0=;
 b=YoFN2neVC671CniPNbewHzeOzcT9X71gMyikzEi+sc57w0djsojqngbiSnKF1lFWE6CY50
 SgY/tmoDIVhOlXK1qIHR4pVCCV0m3XqAa9FUOnMmz/oBipBJLrHzZsppqZP4LjWkjLNB1e
 4hhS4cbVSBR+Dpd9lKLjqrGHifpF9Z4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-378-D0uezm-2Mgyv6EAdhRmEMQ-1; Mon, 20 Jul 2020 15:13:00 -0400
X-MC-Unique: D0uezm-2Mgyv6EAdhRmEMQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2559E8005B0;
 Mon, 20 Jul 2020 19:12:59 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-115-27.ams2.redhat.com
 [10.36.115.27])
 by smtp.corp.redhat.com (Postfix) with ESMTP id EA2E65D9DD;
 Mon, 20 Jul 2020 19:12:57 +0000 (UTC)
Subject: Re: [RFC 3/3] x68: acpi: trigger SMI before scanning for hotplugged
 CPUs
To: Igor Mammedov <imammedo@redhat.com>
References: <20200710161704.309824-1-imammedo@redhat.com>
 <20200710161704.309824-4-imammedo@redhat.com>
 <515cc231-858a-a626-31a9-d74e1f6b4e38@redhat.com>
 <20200717151321.27e2d849@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <cf887d74-f65d-602a-9629-3d25cef93a69@redhat.com>
Date: Mon, 20 Jul 2020 21:12:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Firefox/52.0 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200717151321.27e2d849@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=lersek@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/20 02:11:17
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: boris.ostrovsky@oracle.com, liran.alon@oracle.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 07/17/20 15:13, Igor Mammedov wrote:
> On Tue, 14 Jul 2020 14:28:29 +0200
> Laszlo Ersek <lersek@redhat.com> wrote:
> 
>> (CC'ing Peter Krempa due to virsh setvcpu (singular) / setvcpus (plural)
>> references)
>>
>> On 07/10/20 18:17, Igor Mammedov wrote:
> [...]
> 
>> (3) Just a thought: I wonder if we should reserve both ports (0xB2 and
>> 0xB3 too). For now we don't have any use for the "data" port, but
>> arguably it's part of the same register block.
> 
> we probably should, might be used for unplug part.
> 
> BTW any ideas how we'd like to procceed with unplug?
> 
> current flow looks like:
> 
> QEMU                       OSPM
> unplug_req()
> 1)   =>SCI     --->
>   -------------------------
> 2)                   handle_sci()
>                          scan for events and send
>                              Notify per removed CPU
>                              clear rm_evt
>   -------------------------
> 3)                   offline cpu
>   -------------------------
> 4)                    call _EJ0 to unplug CPU
>                          write into ej_evt
>               <-------------
>   -------------------------
> 5)  unplug cb
>  
> 
> We probably should modify _EJ0 to send SMI instead of direct access
> to cpuhp block, the question is how OSPM would tell FW which CPU it
> ejects.

The optimal solution would be DataTableRegion, but of course Windows
doesn't support that. So the usual replacement is something like below
(we used a variant of it in "docs/specs/vmgenid.txt"):

- Create a new ACPI data table. See "Appendix O - UEFI ACPI Data Table",
table 94, in the UEFI 2.8 spec <https://uefi.org/specifications>. In
this table, set

  Identifier = B055E4C3-B5B5-4948-9D02-A46FCA3B0A3B

(I just generated this with "uuidgen"). Set DataOffset to 54 decimal.
Place 4 zeroes at offset 54, for Data.

- Create a SystemMemory Operation Region, 58 bytes in size (for covering
the entire table), with a single 4-byte Field at offset 54. Use the
add_pointer command for pointing the OperationRegion opcode to offset 0
(that is, the very beginning) of the above-created ACPI table.

(Normally I would suggest creating an Integer object, using add_pointer
on the Integer object, and then dynamically creating an OperationRegion
at that Integer address -- but I don't know if Windows can deal with
dynamically determined OperationRegion addresses.)

- In the CPU hot-unplug ACPI code, write the APIC ID (or the selector I
guess?) of the CPU being un-plugged to the field at offset 54, before
raising the SMI

- Raise the SMI with a new command (value 5, I guess)

- in OVMF, the CpuHotplugSmm driver can register an EndOfDxe callback,
and use EFI_ACPI_SDT_PROTOCOL.GetAcpiTable(), in a loop, for locating
the data table. Save a pointer (in SMRAM) to offset 54 of that table. At
runtime, when handling the SMI (command 5) read the APIC ID (or
selector) from the data field at offset 54.

(The AddTableToList() function in edk2's
"MdeModulePkg/Universal/Acpi/AcpiTableDxe/AcpiTableProtocol.c" file
makes sure that "UEFI ACPI Data Tables" are allocated in AcpiNVS memory,
which is permitted for use as an "SMM communication buffer".)

(The difference with VMGENID is that QEMU need not learn of the
guest-side address of the data table, hence no "write_pointer" command.
Instead, CpuHotplugSmm needs to learn of the address. That can be done
with in an EndOfDxe callback, using EFI_ACPI_SDT_PROTOCOL.GetAcpiTable()
in a loop, but that does require QEMU to produce a real ACPI data table,
not just a header-less blob placed in AcpiNVS memory.)

Thanks,
Laszlo


