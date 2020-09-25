Return-Path: <SRS0=+pSw=DC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56FEDC4363D
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 18:00:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A68EA2075F
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 18:00:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YvkZQ1hR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A68EA2075F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42366 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLs1Q-0007bx-4M
	for qemu-devel@archiver.kernel.org; Fri, 25 Sep 2020 14:00:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43022)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1kLs0P-0007Ah-3g
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 13:59:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:57015)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1kLs0L-0002rR-NX
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 13:59:36 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601056771;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TpHCTwFFT60Xn+gtUzfXYMvZDf0n2bC9YzsvdlyIjS0=;
 b=YvkZQ1hRIlNujI44EKcM36aP3s6nsqpvLH6qmlsEyzdJtPn7IcUkvf3gSJ7EIc9vRDul1m
 UXzd+GoLR7ubdcOyqDkK29BuXzYki465XFylZa7DutWglFCG1xuBYKvUSlvLmQVYjPSSdc
 WQ1cu45R47XrrfM1shULmvGNGTgqH6Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-464-XeN5oQW2OaixnmE-NvRaEA-1; Fri, 25 Sep 2020 13:59:22 -0400
X-MC-Unique: XeN5oQW2OaixnmE-NvRaEA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AD7A789BBB6;
 Fri, 25 Sep 2020 17:59:06 +0000 (UTC)
Received: from work-vm (ovpn-114-177.ams2.redhat.com [10.36.114.177])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C945681F60;
 Fri, 25 Sep 2020 17:59:04 +0000 (UTC)
Date: Fri, 25 Sep 2020 18:59:02 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: "McMillan, Erich" <erich.mcmillan@hp.com>
Subject: Re: [PATCH v5] hw/i386/pc: add max combined fw size as machine
 configuration option
Message-ID: <20200925175902.GR2873@work-vm>
References: <20200925033623.3968-1-erich.mcmillan@hp.com>
 <8818a3ae-cab6-5de4-adbd-19198d26b6e7@redhat.com>
 <CS1PR8401MB0327982D7F9414360E440656F3360@CS1PR8401MB0327.NAMPRD84.PROD.OUTLOOK.COM>
 <CS1PR8401MB0327484EBEB2FAC967846886F3360@CS1PR8401MB0327.NAMPRD84.PROD.OUTLOOK.COM>
MIME-Version: 1.0
In-Reply-To: <CS1PR8401MB0327484EBEB2FAC967846886F3360@CS1PR8401MB0327.NAMPRD84.PROD.OUTLOOK.COM>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=dgilbert@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/25 01:07:33
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.199,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: "mst@redhat.com" <mst@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "kraxel@redhat.com" <kraxel@redhat.com>,
 "imammedo@redhat.com" <imammedo@redhat.com>, Laszlo Ersek <lersek@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* McMillan, Erich (erich.mcmillan@hp.com) wrote:
> Additionally HPi is not a mistake, corporate requires that we refer to ourselves as Hewlett Packard Inc since the split in 2015. I will perhaps update this to be the full name for clarity.

Please note that no one outside of HP knows what HPi is; so you might
want to spell it out a bit.

Dave

> 
> From: McMillan, Erich
> Sent: Friday, September 25, 2020 12:15 PM
> To: Laszlo Ersek <lersek@redhat.com>; qemu-devel@nongnu.org
> Cc: dgilbert@redhat.com; mst@redhat.com; marcel.apfelbaum@gmail.com; imammedo@redhat.com; kraxel@redhat.com
> Subject: RE: [PATCH v5] hw/i386/pc: add max combined fw size as machine configuration option
> 
> Hi Laszlo,
> 
> Thank you for the feedback, apologies that I missed the exact line references I was moving too fast.
> I appreciate you taking the time to explain the nuances.
> 
> On an unrelated note, it seems that my patches are no longer appearing in https://lists.nongnu.org/archive/html/qemu-devel/2020-09/index.html is this because I need to cc qemu-devel@nongnu.org<mailto:qemu-devel@nongnu.org> rather than –to?
> 
> -Erich
> 
> From: Laszlo Ersek [mailto:lersek@redhat.com]
> Sent: Friday, September 25, 2020 2:00 AM
> To: McMillan, Erich <erich.mcmillan@hp.com<mailto:erich.mcmillan@hp.com>>; qemu-devel@nongnu.org<mailto:qemu-devel@nongnu.org>
> Cc: dgilbert@redhat.com<mailto:dgilbert@redhat.com>; mst@redhat.com<mailto:mst@redhat.com>; marcel.apfelbaum@gmail.com<mailto:marcel.apfelbaum@gmail.com>; imammedo@redhat.com<mailto:imammedo@redhat.com>; kraxel@redhat.com<mailto:kraxel@redhat.com>
> Subject: Re: [PATCH v5] hw/i386/pc: add max combined fw size as machine configuration option
> 
> Hi Erich,
> 
> when processing review feedback, please pay attention to *where* the
> review comments are inserted, in response to your patch email.
> 
> I'm pointing this out not because I want to annoy you with my
> obsessions, but because I consider this discussion a kind of "git +
> mailing lists" training for you. (In accordance with your first message
> on the topic.)
> 
> Please see specifics below:
> 
> On 09/25/20 05:36, Erich Mcmillan wrote:
> > From: Erich McMillan <erich.mcmillan@hp.com<mailto:erich.mcmillan@hp.com>>
> >
> > At HPi we have a need for increased fw size to enable testing of our custom fw.
> >
> > Signed-off-by: Erich McMillan <erich.mcmillan@hp.com<mailto:erich.mcmillan@hp.com>>
> >
> > Change since v4:
> > Add explicit return to pc_machine_set_max_fw_size.
> > Remove /* default */ from max_fw_size initialization.
> > ---
> >
> > hw/i386/pc.c | 52 ++++++++++++++++++++++++++++++++++++++++++++
> > hw/i386/pc_sysfw.c | 13 ++---------
> > include/hw/i386/pc.h | 2 ++
> > 3 files changed, 56 insertions(+), 11 deletions(-)
> 
> Please refer to my earlier feedback, archived at the following location:
> 
> http://mid.mail-archive.com/8fdbf9f1-5125-1c39-4ec7-f99f017d4345@redhat.com<http://mid.mail-archive.com/8fdbf9f1-5125-1c39-4ec7-f99f017d4345@redhat.com>
> 
> As I say in that message, the v(n)->v(n+1) changelog belongs 'between
> the "---" separator and the diffstat'. In that message, I marked the
> specific location with [*].
> 
> Basically the "---" separator terminates the commit message, and the
> first "diff --git" line starts the code changes. What's between them is
> thrown away, when the patch is applied. So in that throwaway area,
> git-format-patch places the diffstat automatically (because it gives
> reviewers a helpful overview of the patch, but is not useful for patch
> application). And that's also the area where the v(n)->v(n+1) changelog
> should be included. Traditionally, we place that log above the diffstat.
> 
> >
> > diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> > index d11daacc23..6e66cbbc41 100644
> > --- a/hw/i386/pc.c
> > +++ b/hw/i386/pc.c
> > @@ -1869,6 +1869,51 @@ static void pc_machine_set_max_ram_below_4g(Object *obj, Visitor *v,
> > pcms->max_ram_below_4g = value;
> > }
> >
> > +static void pc_machine_get_max_fw_size(Object *obj, Visitor *v,
> > + const char *name, void *opaque,
> > + Error **errp)
> > +{
> > + PCMachineState *pcms = PC_MACHINE(obj);
> > + uint64_t value = pcms->max_fw_size;
> > +
> > + visit_type_size(v, name, &value, errp);
> > +}
> > +
> > +static void pc_machine_set_max_fw_size(Object *obj, Visitor *v,
> > + const char *name, void *opaque,
> > + Error **errp)
> > +{
> > + PCMachineState *pcms = PC_MACHINE(obj);
> > + Error *error = NULL;
> > + uint64_t value;
> > +
> > + visit_type_size(v, name, &value, &error);
> > + if (error) {
> > + error_propagate(errp, error);
> > + return;
> > + }
> > +
> > + /*
> > + * We don't have a theoretically justifiable exact lower bound on the base
> > + * address of any flash mapping. In practice, the IO-APIC MMIO range is
> > + * [0xFEE00000..0xFEE01000] -- see IO_APIC_DEFAULT_ADDRESS --, leaving free
> > + * only 18MB-4KB below 4G. For now, restrict the cumulative mapping to 8MB in
> > + * size.
> > + */
> > + if (value > 16 * MiB) {
> > + error_setg(errp,
> > + "User specified max allowed firmware size %" PRIu64 " is "
> > + "greater than 16MiB. If combined firwmare size exceeds "
> > + "16MiB the system may not boot, or experience intermittent"
> > + "stability issues.",
> > + value);
> > + }
> > +
> > + pcms->max_fw_size = value;
> > +
> > + return;
> > +}
> 
> This return statement is useless. Please see my review at:
> 
> http://mid.mail-archive.com/de343c71-f446-c68b-d0bc-5f9db97b5a00@redhat.com<http://mid.mail-archive.com/de343c71-f446-c68b-d0bc-5f9db97b5a00@redhat.com>
> 
> There I wrote, 'Please put a "return" statement here'. And, my request
> was placed *exactly between* the error_setg() call and the closing brace.
> 
> The idea being that, if we take the (value > 16 * MiB) branch, then yes
> we need to set the error, but we also need to abandon the rest of the
> function. If "value" is invalid (out of bounds), then "pcms->max_fw_size
> = value" is exactly the assignment that we do *not* want to reach.
> 
> > +
> > static void pc_machine_initfn(Object *obj)
> > {
> > PCMachineState *pcms = PC_MACHINE(obj);
> > @@ -1884,6 +1929,7 @@ static void pc_machine_initfn(Object *obj)
> > pcms->smbus_enabled = true;
> > pcms->sata_enabled = true;
> > pcms->pit_enabled = true;
> > + pcms->max_fw_size = 8 * MiB;
> 
> Thank you for dropping the comment.
> 
> Summary:
> 
> - the changelog is helpful (thanks!), it's placement is not perfect yet
> - the return statement should be moved so that it terminate the (value >
> 16 * MiB) branch.
> 
> Also, I think "HPi" (rather than "HP") in the commit message *could* be
> a typo (I'm not sure).
> 
> Thanks,
> Laszlo
> 
> 
> >
> > pc_system_flash_create(pcms);
> > pcms->pcspk = isa_new(TYPE_PC_SPEAKER);
> > @@ -2004,6 +2050,12 @@ static void pc_machine_class_init(ObjectClass *oc, void *data)
> >
> > object_class_property_add_bool(oc, PC_MACHINE_PIT,
> > pc_machine_get_pit, pc_machine_set_pit);
> > +
> > + object_class_property_add(oc, PC_MACHINE_MAX_FW_SIZE, "size",
> > + pc_machine_get_max_fw_size, pc_machine_set_max_fw_size,
> > + NULL, NULL);
> > + object_class_property_set_description(oc, PC_MACHINE_MAX_FW_SIZE,
> > + "Maximum combined firmware size");
> > }
> >
> > static const TypeInfo pc_machine_info = {
> > diff --git a/hw/i386/pc_sysfw.c b/hw/i386/pc_sysfw.c
> > index b6c0822fe3..22450ba0ef 100644
> > --- a/hw/i386/pc_sysfw.c
> > +++ b/hw/i386/pc_sysfw.c
> > @@ -39,15 +39,6 @@
> > #include "hw/block/flash.h"
> > #include "sysemu/kvm.h"
> >
> > -/*
> > - * We don't have a theoretically justifiable exact lower bound on the base
> > - * address of any flash mapping. In practice, the IO-APIC MMIO range is
> > - * [0xFEE00000..0xFEE01000] -- see IO_APIC_DEFAULT_ADDRESS --, leaving free
> > - * only 18MB-4KB below 4G. For now, restrict the cumulative mapping to 8MB in
> > - * size.
> > - */
> > -#define FLASH_SIZE_LIMIT (8 * MiB)
> > -
> > #define FLASH_SECTOR_SIZE 4096
> >
> > static void pc_isa_bios_init(MemoryRegion *rom_memory,
> > @@ -182,10 +173,10 @@ static void pc_system_flash_map(PCMachineState *pcms,
> > }
> > if ((hwaddr)size != size
> > || total_size > HWADDR_MAX - size
> > - || total_size + size > FLASH_SIZE_LIMIT) {
> > + || total_size + size > pcms->max_fw_size) {
> > error_report("combined size of system firmware exceeds "
> > "%" PRIu64 " bytes",
> > - FLASH_SIZE_LIMIT);
> > + pcms->max_fw_size);
> > exit(1);
> > }
> >
> > diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
> > index fe52e165b2..f7c8e7cbfe 100644
> > --- a/include/hw/i386/pc.h
> > +++ b/include/hw/i386/pc.h
> > @@ -43,6 +43,7 @@ struct PCMachineState {
> > bool smbus_enabled;
> > bool sata_enabled;
> > bool pit_enabled;
> > + uint64_t max_fw_size;
> >
> > /* NUMA information: */
> > uint64_t numa_nodes;
> > @@ -59,6 +60,7 @@ struct PCMachineState {
> > #define PC_MACHINE_SMBUS "smbus"
> > #define PC_MACHINE_SATA "sata"
> > #define PC_MACHINE_PIT "pit"
> > +#define PC_MACHINE_MAX_FW_SIZE "max-fw-size"
> >
> > /**
> > * PCMachineClass:
> >
-- 
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


