Return-Path: <SRS0=D+kF=7K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E1D2C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 10:42:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 06BAC208A7
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 10:42:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xq09ABfp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06BAC208A7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44500 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jeFzS-0003RE-6j
	for qemu-devel@archiver.kernel.org; Thu, 28 May 2020 06:42:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47316)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1jeFyu-000311-1U
 for qemu-devel@nongnu.org; Thu, 28 May 2020 06:41:48 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:27673
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1jeFys-0002VH-Li
 for qemu-devel@nongnu.org; Thu, 28 May 2020 06:41:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590662504;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Tft+oI7QOcQuIDxGEk8FC/MKeXg2ttk+epya2rb4E/E=;
 b=Xq09ABfp5lKhSP241SAkIG00d8hjLtMqMgGGdHyynucdJtpfZ3KtLrKz/e6+ViFcZot49R
 38btjn9FrhWI0JuXr3aL1+XXUc2kb+XpE3BiyC8Dmb7WijU7ZLcM2Joi4gRD7NEuV6S3mR
 7Vcd+IaLM91dzHWhS4drPG9MBrOV+5k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-33-P0P6XHfCM-iTk2cCeuLMZA-1; Thu, 28 May 2020 06:41:41 -0400
X-MC-Unique: P0P6XHfCM-iTk2cCeuLMZA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DDE4E8014D7;
 Thu, 28 May 2020 10:41:39 +0000 (UTC)
Received: from localhost (unknown [10.40.208.37])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D6D5E768B5;
 Thu, 28 May 2020 10:41:33 +0000 (UTC)
Date: Thu, 28 May 2020 12:41:31 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: "Verma, Vishal L" <vishal.l.verma@intel.com>
Subject: Re: [PATCH 2/3] hw/acpi-build: account for NVDIMM numa nodes in SRAT
Message-ID: <20200528124131.19cc986e@redhat.com>
In-Reply-To: <b91f0709d2a425e39d8ecaff5824c022dc893ee6.camel@intel.com>
References: <20200428012810.10877-1-vishal.l.verma@intel.com>
 <20200428012810.10877-3-vishal.l.verma@intel.com>
 <20200521171657.778f20a4@redhat.com>
 <b91f0709d2a425e39d8ecaff5824c022dc893ee6.camel@intel.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/28 02:50:32
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: "Liu,
 Jingqi" <jingqi.liu@intel.com>, "Williams, Dan J" <dan.j.williams@intel.com>,
 "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "mst@redhat.com" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 28 May 2020 01:24:42 +0000
"Verma, Vishal L" <vishal.l.verma@intel.com> wrote:

> On Thu, 2020-05-21 at 17:16 +0200, Igor Mammedov wrote:
> 
> Hi Igor, Thanks for the review.
> 
> [..]
> > >  
> > > @@ -2429,6 +2430,25 @@ build_srat(GArray *table_data, BIOSLinker *linker, MachineState *machine)
> > >                                MEM_AFFINITY_ENABLED);
> > >          }
> > >      }
> > > +
> > > +    if (machine->nvdimms_state->is_enabled) {
> > > +        GSList *device_list = nvdimm_get_device_list();
> > > +
> > > +        for (; device_list; device_list = device_list->next) {
> > > +            DeviceState *dev = device_list->data;
> > > +            int node = object_property_get_int(OBJECT(dev), PC_DIMM_NODE_PROP,
> > > +                                               NULL);
> > > +            uint64_t addr = object_property_get_uint(OBJECT(dev),
> > > +                                                     PC_DIMM_ADDR_PROP, NULL);
> > > +            uint64_t size = object_property_get_uint(OBJECT(dev),
> > > +                                                     PC_DIMM_SIZE_PROP, NULL);
> > > +  
> > suggest to use error_abort in getters  
> 
> Yep, fixed in v2.
> 
> >   
> > > +            numamem = acpi_data_push(table_data, sizeof *numamem);
> > > +            build_srat_memory(numamem, addr, size, node,
> > > +                              MEM_AFFINITY_ENABLED | MEM_AFFINITY_NON_VOLATILE);
> > > +        }  
> > who is in charge of freeing device_list ?  
> 
> Thanks, also fixed in v2.
> 
> >   
> > > +    }  
> > 
> > There is ARM version of build_srat(),
> > I suggest to put this NVDIMM specific part in helper function within hw/acpi/nvdimm.c
> > and use it from both build_srat() functions.  
> 
> Splitting the work out into a helper function in nvdimm.c does make
> sense, and I've done that. However, looking at the arm version of
> build_srat and generally in virt-acpi-build.c, I don't see any NVDIMM
> support, so unless I'm mistaken, it wouldn't make sense to actually call
> this from the arm version of build_srat.

perhaps you are lookin into old version on QEMU
current HEAD has followin snippet:

virt-acpi-build.c:
    if (ms->nvdimms_state->is_enabled) {
        nvdimm_build_acpi(table_offsets, tables_blob, tables->linker,
                          ms->nvdimms_state, ms->ram_slots);
    }
 
> 
> I'll send a v2 with the above fixes.
> 
> >   
> > > +
> > >      slots = (table_data->len - numa_start) / sizeof *numamem;
> > >      for (; slots < pcms->numa_nodes + 2; slots++) {
> > >          numamem = acpi_data_push(table_data, sizeof *numamem);  


