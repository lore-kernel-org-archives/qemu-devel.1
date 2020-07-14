Return-Path: <SRS0=DUFB=AZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8123CC433E3
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 18:27:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E90B227BF
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 18:27:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EiEpJSj1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E90B227BF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40152 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvPeF-0003jM-F1
	for qemu-devel@archiver.kernel.org; Tue, 14 Jul 2020 14:27:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56610)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1jvPdP-0003Gm-Sj
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 14:26:31 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:25567
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1jvPdK-0006b3-1w
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 14:26:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594751184;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=10xMJSS7p8b4GsDXUjYqGIch84xHtrXP/90RBtKSuDI=;
 b=EiEpJSj1vVo4ImMHUWwfT5YGxwvnvyFOC2G/G6sV03k8UHea0ohF4rPPFYlPCl5xaC5MrL
 uobdEeYWSg8L/2P/hCVvI95wcb/8Psh/80eszIub0oBJlwzTK8N/JGy9aIohbSmFV5S4q0
 sOtUeTOD/HbibVtUVty04WGfiivL6cY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-65-Dsb8hNV9MRaVgv_cnPH2Gw-1; Tue, 14 Jul 2020 14:26:19 -0400
X-MC-Unique: Dsb8hNV9MRaVgv_cnPH2Gw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 083DE1005260;
 Tue, 14 Jul 2020 18:26:18 +0000 (UTC)
Received: from localhost (unknown [10.40.208.62])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 260E71D9;
 Tue, 14 Jul 2020 18:26:14 +0000 (UTC)
Date: Tue, 14 Jul 2020 20:26:12 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Babu Moger <babu.moger@amd.com>
Subject: Re: [PATCH v2 1/3] hw/i386: Initialize topo_ids from
 CpuInstanceProperties
Message-ID: <20200714202612.0be2688c@redhat.com>
In-Reply-To: <ac92599f-5e14-5c07-6641-22ac13ed9d4f@amd.com>
References: <159362436285.36204.986406297373871949.stgit@naples-babu.amd.com>
 <159362466108.36204.3751851750959980962.stgit@naples-babu.amd.com>
 <20200713110822.5495e1c6@redhat.com>
 <78809d9f-a491-8c99-3f35-7f012c7d75bf@amd.com>
 <20200713181740.16a357a6@redhat.com>
 <47dc6238-bb71-d679-f58a-f574eb36d572@amd.com>
 <20200713193221.27674630@redhat.com>
 <4003b476-afdb-74a1-4f9f-1387aae6c4e8@amd.com>
 <20200714184154.12c686bf@redhat.com>
 <ac92599f-5e14-5c07-6641-22ac13ed9d4f@amd.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=imammedo@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=imammedo@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/13 21:44:01
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "rth@twiddle.net" <rth@twiddle.net>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "ehabkost@redhat.com" <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 14 Jul 2020 12:26:56 -0500
Babu Moger <babu.moger@amd.com> wrote:

> > -----Original Message-----
> > From: Igor Mammedov <imammedo@redhat.com>
> > Sent: Tuesday, July 14, 2020 11:42 AM
> > To: Moger, Babu <Babu.Moger@amd.com>
> > Cc: qemu-devel@nongnu.org; pbonzini@redhat.com; ehabkost@redhat.com;
> > rth@twiddle.net
> > Subject: Re: [PATCH v2 1/3] hw/i386: Initialize topo_ids from
> > CpuInstanceProperties
> > 
> > On Mon, 13 Jul 2020 14:30:29 -0500
> > Babu Moger <babu.moger@amd.com> wrote:
> >   
> > > > -----Original Message-----
> > > > From: Igor Mammedov <imammedo@redhat.com>
> > > > Sent: Monday, July 13, 2020 12:32 PM
> > > > To: Moger, Babu <Babu.Moger@amd.com>
> > > > Cc: pbonzini@redhat.com; rth@twiddle.net; ehabkost@redhat.com; qemu-
> > > > devel@nongnu.org
> > > > Subject: Re: [PATCH v2 1/3] hw/i386: Initialize topo_ids from
> > > > CpuInstanceProperties
> > > >
> > > > On Mon, 13 Jul 2020 11:43:33 -0500
> > > > Babu Moger <babu.moger@amd.com> wrote:
> > > >  
> > > > > On 7/13/20 11:17 AM, Igor Mammedov wrote:  
> > > > > > On Mon, 13 Jul 2020 10:02:22 -0500 Babu Moger
> > > > > > <babu.moger@amd.com> wrote:
> > > > > >  
> > > > > >>> -----Original Message-----
> > > > > >>> From: Igor Mammedov <imammedo@redhat.com>
> > > > > >>> Sent: Monday, July 13, 2020 4:08 AM
> > > > > >>> To: Moger, Babu <Babu.Moger@amd.com>
> > > > > >>> Cc: pbonzini@redhat.com; rth@twiddle.net; ehabkost@redhat.com;
> > > > > >>> qemu- devel@nongnu.org
> > > > > >>> Subject: Re: [PATCH v2 1/3] hw/i386: Initialize topo_ids from
> > > > > >>> CpuInstanceProperties  
> > > > > > [...]  
> > > > > >>>> +
> > > > > >>>> +/*
> > > > > >>>> + * Initialize topo_ids from CpuInstanceProperties
> > > > > >>>> + * node_id in CpuInstanceProperties(or in CPU device) is a
> > > > > >>>> +sequential
> > > > > >>>> + * number, but while building the topology  
> > > > > >>>  
> > > > > >>>> we need to separate it for
> > > > > >>>> + * each socket(mod nodes_per_pkg).  
> > > > > >>> could you clarify a bit more on why this is necessary?  
> > > > > >>
> > > > > >> If you have two sockets and 4 numa nodes, node_id in
> > > > > >> CpuInstanceProperties will be number sequentially as 0, 1, 2, 3.
> > > > > >> But in EPYC topology, it will be  0, 1, 0, 1( Basically mod %
> > > > > >> number of nodes  
> > > > per socket).  
> > > > > >
> > > > > > I'm confused, let's suppose we have 2 EPYC sockets with 2 nodes
> > > > > > per socket so APIC id woulbe be composed like:
> > > > > >
> > > > > >  1st socket
> > > > > >    pkg_id(0) | node_id(0)
> > > > > >    pkg_id(0) | node_id(1)
> > > > > >
> > > > > >  2nd socket
> > > > > >    pkg_id(1) | node_id(0)
> > > > > >    pkg_id(1) | node_id(1)
> > > > > >
> > > > > > if that's the case, then EPYC's node_id here doesn't look like a
> > > > > > NUMA node in the sense it's usually used (above config would
> > > > > > have 4 different memory controllers => 4 conventional NUMA nodes).  
> > > > >
> > > > > EPIC model uses combination of socket id and node id to identify
> > > > > the numa nodes. So, it internally uses all the information.  
> > > >
> > > > well with above values, EPYC's node_id doesn't look like it's
> > > > specifying a machine numa node, but rather a node index within
> > > > single socket. In which case, it doesn't make much sense calling it
> > > > NUMA node_id, it's rather some index within a socket. (it starts
> > > > looking like terminology is all mixed up)
> > > >
> > > > If you have access to a milti-socket EPYC machine, can you dump and
> > > > post here its apic ids, pls?  
> > >
> > > Here is the output from my EPYC machine with 2 sockets and totally 8
> > > nodes(SMT disabled). The cpus 0-31 are in socket 0 and  cpus 32-63 in
> > > socket 1.
> > >
> > > # lscpu
> > > Architecture:        x86_64
> > > CPU op-mode(s):      32-bit, 64-bit
> > > Byte Order:          Little Endian
> > > CPU(s):              64
> > > On-line CPU(s) list: 0-63
> > > Thread(s) per core:  1
> > > Core(s) per socket:  32
> > > Socket(s):           2
> > > NUMA node(s):        8
> > > Vendor ID:           AuthenticAMD
> > > CPU family:          23
> > > Model:               1
> > > Model name:          AMD Eng Sample: 1S1901A4VIHF5_30/19_N
> > > Stepping:            2
> > > CPU MHz:             2379.233
> > > CPU max MHz:         1900.0000
> > > CPU min MHz:         1200.0000
> > > BogoMIPS:            3792.81
> > > Virtualization:      AMD-V
> > > L1d cache:           32K
> > > L1i cache:           64K
> > > L2 cache:            512K
> > > L3 cache:            8192K
> > > NUMA node0 CPU(s):   0-7
> > > NUMA node1 CPU(s):   8-15
> > > NUMA node2 CPU(s):   16-23
> > > NUMA node3 CPU(s):   24-31
> > > NUMA node4 CPU(s):   32-39
> > > NUMA node5 CPU(s):   40-47
> > > NUMA node6 CPU(s):   48-55
> > > NUMA node7 CPU(s):   56-63
> > >
> > > Here is the output of #cpuid  -l 0x8000001e  -r
> > >
> > > You may want to refer
> > > https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fwww.
> > >  
> > amd.com%2Fsystem%2Ffiles%2FTechDocs%2F54945_3.03_ppr_ZP_B2_pub.zip&
> > amp  
> > >  
> > ;data=02%7C01%7Cbabu.moger%40amd.com%7C8027127197c440bc097008d8
> > 2814e52  
> > >  
> > 5%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C6373034174951581
> > 22&amp;  
> > >  
> > sdata=ViF%2FGTPxDFV6KcjicGedyACbjQ6Ikkq0oWUWw18pGbU%3D&amp;reser
> > ved=0  
> > > (section 2.1.12.2.1.3 ApicId Enumeration Requirements).
> > > Note that this is a general guideline. We tried to generalize in qemu
> > > as much as possible. It is bit complex.  
> > Thanks, I'll look into it.
> > Can you also dump SRAT table from that machine, please?
> > I'd like to see CPUs relation to NUMA nodes described in SRAT.  
> 
> Hope this helps.  Got this from acpidump tool.
> Let me if you have any other tool.

# acpidump -b
and then
# iasl -d dumped_table_blob
that will produce human readble table

> 
> SRAT @ 0x0000000000000000
>     0000: 53 52 41 54 C0 09 00 00 03 64 41 4D 44 00 00 00 SRAT.....dAMD...
>     0010: 44 49 45 53 45 4C 20 20 01 00 00 00 41 4D 44 20  DIESEL  ....AMD
>     0020: 01 00 00 00 01 00 00 00 00 00 00 00 00 00 00 00  ................
>     0030: 00 10 00 00 01 00 00 00 00 00 00 00 00 00 00 00  ................
>     0040: 00 10 00 01 01 00 00 00 00 00 00 00 00 00 00 00  ................
>     0050: 00 10 00 02 01 00 00 00 00 00 00 00 00 00 00 00  ................
>     0060: 00 10 00 03 01 00 00 00 00 00 00 00 00 00 00 00  ................
>     0070: 00 10 00 04 01 00 00 00 00 00 00 00 00 00 00 00  ................
>     0080: 00 10 00 05 01 00 00 00 00 00 00 00 00 00 00 00  ................
>     0090: 00 10 00 06 01 00 00 00 00 00 00 00 00 00 00 00  ................
>     00A0: 00 10 00 07 01 00 00 00 00 00 00 00 00 00 00 00  ................
>     00B0: 00 10 00 08 01 00 00 00 00 00 00 00 00 00 00 00  ................
>     00C0: 00 10 00 09 01 00 00 00 00 00 00 00 00 00 00 00  ................
>     00D0: 00 10 00 0A 01 00 00 00 00 00 00 00 00 00 00 00  ................
>     00E0: 00 10 00 0B 01 00 00 00 00 00 00 00 00 00 00 00  ................
>     00F0: 00 10 00 0C 01 00 00 00 00 00 00 00 00 00 00 00  ................
>     0100: 00 10 00 0D 01 00 00 00 00 00 00 00 00 00 00 00  ................
>     0110: 00 10 00 0E 01 00 00 00 00 00 00 00 00 00 00 00  ................
>     0120: 00 10 00 0F 01 00 00 00 00 00 00 00 00 00 00 00  ................
>     0130: 00 10 01 10 01 00 00 00 00 00 00 00 00 00 00 00  ................
>     0140: 00 10 01 11 01 00 00 00 00 00 00 00 00 00 00 00  ................
>     0150: 00 10 01 12 01 00 00 00 00 00 00 00 00 00 00 00  ................
>     0160: 00 10 01 13 01 00 00 00 00 00 00 00 00 00 00 00  ................
>     0170: 00 10 01 14 01 00 00 00 00 00 00 00 00 00 00 00  ................
>     0180: 00 10 01 15 01 00 00 00 00 00 00 00 00 00 00 00  ................
>     0190: 00 10 01 16 01 00 00 00 00 00 00 00 00 00 00 00  ................
>     01A0: 00 10 01 17 01 00 00 00 00 00 00 00 00 00 00 00  ................
>     01B0: 00 10 01 18 01 00 00 00 00 00 00 00 00 00 00 00  ................
>     01C0: 00 10 01 19 01 00 00 00 00 00 00 00 00 00 00 00  ................
>     01D0: 00 10 01 1A 01 00 00 00 00 00 00 00 00 00 00 00  ................
>     01E0: 00 10 01 1B 01 00 00 00 00 00 00 00 00 00 00 00  ................
>     01F0: 00 10 01 1C 01 00 00 00 00 00 00 00 00 00 00 00  ................
>     0200: 00 10 01 1D 01 00 00 00 00 00 00 00 00 00 00 00  ................
>     0210: 00 10 01 1E 01 00 00 00 00 00 00 00 00 00 00 00  ................
>     0220: 00 10 01 1F 01 00 00 00 00 00 00 00 00 00 00 00  ................
>     0230: 00 10 02 20 01 00 00 00 00 00 00 00 00 00 00 00  ... ............
>     0240: 00 10 02 21 01 00 00 00 00 00 00 00 00 00 00 00  ...!............
>     0250: 00 10 02 22 01 00 00 00 00 00 00 00 00 00 00 00  ..."............
>     0260: 00 10 02 23 01 00 00 00 00 00 00 00 00 00 00 00  ...#............
>     0270: 00 10 02 24 01 00 00 00 00 00 00 00 00 00 00 00  ...$............
>     0280: 00 10 02 25 01 00 00 00 00 00 00 00 00 00 00 00  ...%............
>     0290: 00 10 02 26 01 00 00 00 00 00 00 00 00 00 00 00  ...&............
>     02A0: 00 10 02 27 01 00 00 00 00 00 00 00 00 00 00 00  ...'............
>     02B0: 00 10 02 28 01 00 00 00 00 00 00 00 00 00 00 00  ...(............
>     02C0: 00 10 02 29 01 00 00 00 00 00 00 00 00 00 00 00  ...)............
>     02D0: 00 10 02 2A 01 00 00 00 00 00 00 00 00 00 00 00  ...*............
>     02E0: 00 10 02 2B 01 00 00 00 00 00 00 00 00 00 00 00  ...+............
>     02F0: 00 10 02 2C 01 00 00 00 00 00 00 00 00 00 00 00  ...,............
>     0300: 00 10 02 2D 01 00 00 00 00 00 00 00 00 00 00 00  ...-............
>     0310: 00 10 02 2E 01 00 00 00 00 00 00 00 00 00 00 00  ................
>     0320: 00 10 02 2F 01 00 00 00 00 00 00 00 00 00 00 00  .../............
>     0330: 00 10 03 30 01 00 00 00 00 00 00 00 00 00 00 00  ...0............
>     0340: 00 10 03 31 01 00 00 00 00 00 00 00 00 00 00 00  ...1............
>     0350: 00 10 03 32 01 00 00 00 00 00 00 00 00 00 00 00  ...2............
>     0360: 00 10 03 33 01 00 00 00 00 00 00 00 00 00 00 00  ...3............
>     0370: 00 10 03 34 01 00 00 00 00 00 00 00 00 00 00 00  ...4............
>     0380: 00 10 03 35 01 00 00 00 00 00 00 00 00 00 00 00  ...5............
>     0390: 00 10 03 36 01 00 00 00 00 00 00 00 00 00 00 00  ...6............
>     03A0: 00 10 03 37 01 00 00 00 00 00 00 00 00 00 00 00  ...7............
>     03B0: 00 10 03 38 01 00 00 00 00 00 00 00 00 00 00 00  ...8............
>     03C0: 00 10 03 39 01 00 00 00 00 00 00 00 00 00 00 00  ...9............
>     03D0: 00 10 03 3A 01 00 00 00 00 00 00 00 00 00 00 00  ...:............
>     03E0: 00 10 03 3B 01 00 00 00 00 00 00 00 00 00 00 00  ...;............
>     03F0: 00 10 03 3C 01 00 00 00 00 00 00 00 00 00 00 00  ...<............
>     0400: 00 10 03 3D 01 00 00 00 00 00 00 00 00 00 00 00  ...=............
>     0410: 00 10 03 3E 01 00 00 00 00 00 00 00 00 00 00 00  ...>............
>     0420: 00 10 03 3F 01 00 00 00 00 00 00 00 00 00 00 00  ...?............
>     0430: 00 10 04 40 01 00 00 00 00 00 00 00 00 00 00 00  ...@............
>     0440: 00 10 04 41 01 00 00 00 00 00 00 00 00 00 00 00  ...A............
>     0450: 00 10 04 42 01 00 00 00 00 00 00 00 00 00 00 00  ...B............
>     0460: 00 10 04 43 01 00 00 00 00 00 00 00 00 00 00 00  ...C............
>     0470: 00 10 04 44 01 00 00 00 00 00 00 00 00 00 00 00  ...D............
>     0480: 00 10 04 45 01 00 00 00 00 00 00 00 00 00 00 00  ...E............
>     0490: 00 10 04 46 01 00 00 00 00 00 00 00 00 00 00 00  ...F............
>     04A0: 00 10 04 47 01 00 00 00 00 00 00 00 00 00 00 00  ...G............
>     04B0: 00 10 04 48 01 00 00 00 00 00 00 00 00 00 00 00  ...H............
>     04C0: 00 10 04 49 01 00 00 00 00 00 00 00 00 00 00 00  ...I............
>     04D0: 00 10 04 4A 01 00 00 00 00 00 00 00 00 00 00 00  ...J............
>     04E0: 00 10 04 4B 01 00 00 00 00 00 00 00 00 00 00 00  ...K............
>     04F0: 00 10 04 4C 01 00 00 00 00 00 00 00 00 00 00 00  ...L............
>     0500: 00 10 04 4D 01 00 00 00 00 00 00 00 00 00 00 00  ...M............
>     0510: 00 10 04 4E 01 00 00 00 00 00 00 00 00 00 00 00  ...N............
>     0520: 00 10 04 4F 01 00 00 00 00 00 00 00 00 00 00 00  ...O............
>     0530: 00 10 05 50 01 00 00 00 00 00 00 00 00 00 00 00  ...P............
>     0540: 00 10 05 51 01 00 00 00 00 00 00 00 00 00 00 00  ...Q............
>     0550: 00 10 05 52 01 00 00 00 00 00 00 00 00 00 00 00  ...R............
>     0560: 00 10 05 53 01 00 00 00 00 00 00 00 00 00 00 00  ...S............
>     0570: 00 10 05 54 01 00 00 00 00 00 00 00 00 00 00 00  ...T............
>     0580: 00 10 05 55 01 00 00 00 00 00 00 00 00 00 00 00  ...U............
>     0590: 00 10 05 56 01 00 00 00 00 00 00 00 00 00 00 00  ...V............
>     05A0: 00 10 05 57 01 00 00 00 00 00 00 00 00 00 00 00  ...W............
>     05B0: 00 10 05 58 01 00 00 00 00 00 00 00 00 00 00 00  ...X............
>     05C0: 00 10 05 59 01 00 00 00 00 00 00 00 00 00 00 00  ...Y............
>     05D0: 00 10 05 5A 01 00 00 00 00 00 00 00 00 00 00 00  ...Z............
>     05E0: 00 10 05 5B 01 00 00 00 00 00 00 00 00 00 00 00  ...[............
>     05F0: 00 10 05 5C 01 00 00 00 00 00 00 00 00 00 00 00  ...\............
>     0600: 00 10 05 5D 01 00 00 00 00 00 00 00 00 00 00 00
>   ...]............
>     0610: 00 10 05 5E 01 00 00 00 00 00 00 00 00 00 00 00  ...^............
>     0620: 00 10 05 5F 01 00 00 00 00 00 00 00 00 00 00 00  ..._............
>     0630: 00 10 06 60 01 00 00 00 00 00 00 00 00 00 00 00  ...`............
>     0640: 00 10 06 61 01 00 00 00 00 00 00 00 00 00 00 00  ...a............
>     0650: 00 10 06 62 01 00 00 00 00 00 00 00 00 00 00 00  ...b............
>     0660: 00 10 06 63 01 00 00 00 00 00 00 00 00 00 00 00  ...c............
>     0670: 00 10 06 64 01 00 00 00 00 00 00 00 00 00 00 00  ...d............
>     0680: 00 10 06 65 01 00 00 00 00 00 00 00 00 00 00 00  ...e............
>     0690: 00 10 06 66 01 00 00 00 00 00 00 00 00 00 00 00  ...f............
>     06A0: 00 10 06 67 01 00 00 00 00 00 00 00 00 00 00 00  ...g............
>     06B0: 00 10 06 68 01 00 00 00 00 00 00 00 00 00 00 00  ...h............
>     06C0: 00 10 06 69 01 00 00 00 00 00 00 00 00 00 00 00  ...i............
>     06D0: 00 10 06 6A 01 00 00 00 00 00 00 00 00 00 00 00  ...j............
>     06E0: 00 10 06 6B 01 00 00 00 00 00 00 00 00 00 00 00  ...k............
>     06F0: 00 10 06 6C 01 00 00 00 00 00 00 00 00 00 00 00  ...l............
>     0700: 00 10 06 6D 01 00 00 00 00 00 00 00 00 00 00 00  ...m............
>     0710: 00 10 06 6E 01 00 00 00 00 00 00 00 00 00 00 00  ...n............
>     0720: 00 10 06 6F 01 00 00 00 00 00 00 00 00 00 00 00  ...o............
>     0730: 00 10 07 70 01 00 00 00 00 00 00 00 00 00 00 00  ...p............
>     0740: 00 10 07 71 01 00 00 00 00 00 00 00 00 00 00 00  ...q............
>     0750: 00 10 07 72 01 00 00 00 00 00 00 00 00 00 00 00  ...r............
>     0760: 00 10 07 73 01 00 00 00 00 00 00 00 00 00 00 00  ...s............
>     0770: 00 10 07 74 01 00 00 00 00 00 00 00 00 00 00 00  ...t............
>     0780: 00 10 07 75 01 00 00 00 00 00 00 00 00 00 00 00  ...u............
>     0790: 00 10 07 76 01 00 00 00 00 00 00 00 00 00 00 00  ...v............
>     07A0: 00 10 07 77 01 00 00 00 00 00 00 00 00 00 00 00  ...w............
>     07B0: 00 10 07 78 01 00 00 00 00 00 00 00 00 00 00 00  ...x............
>     07C0: 00 10 07 79 01 00 00 00 00 00 00 00 00 00 00 00  ...y............
>     07D0: 00 10 07 7A 01 00 00 00 00 00 00 00 00 00 00 00  ...z............
>     07E0: 00 10 07 7B 01 00 00 00 00 00 00 00 00 00 00 00  ...{............
>     07F0: 00 10 07 7C 01 00 00 00 00 00 00 00 00 00 00 00  ...|............
>     0800: 00 10 07 7D 01 00 00 00 00 00 00 00 00 00 00 00  ...}............
>     0810: 00 10 07 7E 01 00 00 00 00 00 00 00 00 00 00 00  ...~............
>     0820: 00 10 07 7F 01 00 00 00 00 00 00 00 00 00 00 00  ................
>     0830: 01 28 00 00 00 00 00 00 00 00 00 00 00 00 00 00  .(..............
>     0840: 00 00 0A 00 00 00 00 00 00 00 00 00 01 00 00 00  ................
>     0850: 00 00 00 00 00 00 00 00 01 28 00 00 00 00 00 00  .........(......
>     0860: 00 00 10 00 00 00 00 00 00 00 F0 7F 00 00 00 00  ................
>     0870: 00 00 00 00 01 00 00 00 00 00 00 00 00 00 00 00  ................
>     0880: 01 28 00 00 00 00 00 00 00 00 00 00 01 00 00 00  .(..............
>     0890: 00 00 00 80 03 00 00 00 00 00 00 00 01 00 00 00  ................
>     08A0: 00 00 00 00 00 00 00 00 01 28 01 00 00 00 00 00  .........(......
>     08B0: 00 00 00 80 04 00 00 00 00 00 00 00 04 00 00 00  ................
>     08C0: 00 00 00 00 01 00 00 00 00 00 00 00 00 00 00 00  ................
>     08D0: 01 28 02 00 00 00 00 00 00 00 00 80 08 00 00 00  .(..............
>     08E0: 00 00 00 00 04 00 00 00 00 00 00 00 01 00 00 00  ................
>     08F0: 00 00 00 00 00 00 00 00 01 28 03 00 00 00 00 00  .........(......
>     0900: 00 00 00 80 0C 00 00 00 00 00 00 00 04 00 00 00  ................
>     0910: 00 00 00 00 01 00 00 00 00 00 00 00 00 00 00 00  ................
>     0920: 01 28 04 00 00 00 00 00 00 00 00 80 10 00 00 00  .(..............
>     0930: 00 00 00 00 04 00 00 00 00 00 00 00 01 00 00 00  ................
>     0940: 00 00 00 00 00 00 00 00 01 28 05 00 00 00 00 00  .........(......
>     0950: 00 00 00 80 14 00 00 00 00 00 00 00 04 00 00 00  ................
>     0960: 00 00 00 00 01 00 00 00 00 00 00 00 00 00 00 00  ................
>     0970: 01 28 06 00 00 00 00 00 00 00 00 80 18 00 00 00  .(..............
>     0980: 00 00 00 00 04 00 00 00 00 00 00 00 01 00 00 00  ................
>     0990: 00 00 00 00 00 00 00 00 01 28 07 00 00 00 00 00  .........(......
>     09A0: 00 00 00 80 1C 00 00 00 00 00 00 00 04 00 00 00  ................
>     09B0: 00 00 00 00 01 00 00 00 00 00 00 00 00 00 00 00
> ................
> >   
> > >
> > > CPU 0:
> > >    0x8000001e 0x00: eax=0x00000000 ebx=0x00000100 ecx=0x00000300
> > > edx=0x00000000
> > > CPU 1:
> > >    0x8000001e 0x00: eax=0x00000002 ebx=0x00000101 ecx=0x00000300
> > > edx=0x00000000
> > > CPU 2:
> > >    0x8000001e 0x00: eax=0x00000004 ebx=0x00000102 ecx=0x00000300
> > > edx=0x00000000
> > > CPU 3:
> > >    0x8000001e 0x00: eax=0x00000006 ebx=0x00000103 ecx=0x00000300
> > > edx=0x00000000
> > > CPU 4:
> > >    0x8000001e 0x00: eax=0x00000008 ebx=0x00000104 ecx=0x00000300
> > > edx=0x00000000
> > > CPU 5:
> > >    0x8000001e 0x00: eax=0x0000000a ebx=0x00000105 ecx=0x00000300
> > > edx=0x00000000
> > > CPU 6:
> > >    0x8000001e 0x00: eax=0x0000000c ebx=0x00000106 ecx=0x00000300
> > > edx=0x00000000
> > > CPU 7:
> > >    0x8000001e 0x00: eax=0x0000000e ebx=0x00000107 ecx=0x00000300
> > > edx=0x00000000
> > > CPU 8:
> > >    0x8000001e 0x00: eax=0x00000010 ebx=0x00000108 ecx=0x00000301
> > > edx=0x00000000
> > > CPU 9:
> > >    0x8000001e 0x00: eax=0x00000012 ebx=0x00000109 ecx=0x00000301
> > > edx=0x00000000
> > > CPU 10:
> > >    0x8000001e 0x00: eax=0x00000014 ebx=0x0000010a ecx=0x00000301
> > > edx=0x00000000
> > > CPU 11:
> > >    0x8000001e 0x00: eax=0x00000016 ebx=0x0000010b ecx=0x00000301
> > > edx=0x00000000
> > > CPU 12:
> > >    0x8000001e 0x00: eax=0x00000018 ebx=0x0000010c ecx=0x00000301
> > > edx=0x00000000
> > > CPU 13:
> > >    0x8000001e 0x00: eax=0x0000001a ebx=0x0000010d ecx=0x00000301
> > > edx=0x00000000
> > > CPU 14:
> > >    0x8000001e 0x00: eax=0x0000001c ebx=0x0000010e ecx=0x00000301
> > > edx=0x00000000
> > > CPU 15:
> > >    0x8000001e 0x00: eax=0x0000001e ebx=0x0000010f ecx=0x00000301
> > > edx=0x00000000
> > > CPU 16:
> > >    0x8000001e 0x00: eax=0x00000020 ebx=0x00000110 ecx=0x00000302
> > > edx=0x00000000
> > > CPU 17:
> > >    0x8000001e 0x00: eax=0x00000022 ebx=0x00000111 ecx=0x00000302
> > > edx=0x00000000
> > > CPU 18:
> > >    0x8000001e 0x00: eax=0x00000024 ebx=0x00000112 ecx=0x00000302
> > > edx=0x00000000
> > > CPU 19:
> > >    0x8000001e 0x00: eax=0x00000026 ebx=0x00000113 ecx=0x00000302
> > > edx=0x00000000
> > > CPU 20:
> > >    0x8000001e 0x00: eax=0x00000028 ebx=0x00000114 ecx=0x00000302
> > > edx=0x00000000
> > > CPU 21:
> > >    0x8000001e 0x00: eax=0x0000002a ebx=0x00000115 ecx=0x00000302
> > > edx=0x00000000
> > > CPU 22:
> > >    0x8000001e 0x00: eax=0x0000002c ebx=0x00000116 ecx=0x00000302
> > > edx=0x00000000
> > > CPU 23:
> > >    0x8000001e 0x00: eax=0x0000002e ebx=0x00000117 ecx=0x00000302
> > > edx=0x00000000
> > > CPU 24:
> > >    0x8000001e 0x00: eax=0x00000030 ebx=0x00000118 ecx=0x00000303
> > > edx=0x00000000
> > > CPU 25:
> > >    0x8000001e 0x00: eax=0x00000032 ebx=0x00000119 ecx=0x00000303
> > > edx=0x00000000
> > > CPU 26:
> > >    0x8000001e 0x00: eax=0x00000034 ebx=0x0000011a ecx=0x00000303
> > > edx=0x00000000
> > > CPU 27:
> > >    0x8000001e 0x00: eax=0x00000036 ebx=0x0000011b ecx=0x00000303
> > > edx=0x00000000
> > > CPU 28:
> > >    0x8000001e 0x00: eax=0x00000038 ebx=0x0000011c ecx=0x00000303
> > > edx=0x00000000
> > > CPU 29:
> > >    0x8000001e 0x00: eax=0x0000003a ebx=0x0000011d ecx=0x00000303
> > > edx=0x00000000
> > > CPU 30:
> > >    0x8000001e 0x00: eax=0x0000003c ebx=0x0000011e ecx=0x00000303
> > > edx=0x00000000
> > > CPU 31:
> > >    0x8000001e 0x00: eax=0x0000003e ebx=0x0000011f ecx=0x00000303
> > > edx=0x00000000
> > > CPU 32:
> > >    0x8000001e 0x00: eax=0x00000040 ebx=0x00000100 ecx=0x00000304
> > > edx=0x00000000
> > > CPU 33:
> > >    0x8000001e 0x00: eax=0x00000042 ebx=0x00000101 ecx=0x00000304
> > > edx=0x00000000
> > > CPU 34:
> > >    0x8000001e 0x00: eax=0x00000044 ebx=0x00000102 ecx=0x00000304
> > > edx=0x00000000
> > > CPU 35:
> > >    0x8000001e 0x00: eax=0x00000046 ebx=0x00000103 ecx=0x00000304
> > > edx=0x00000000
> > > CPU 36:
> > >    0x8000001e 0x00: eax=0x00000048 ebx=0x00000104 ecx=0x00000304
> > > edx=0x00000000
> > > CPU 37:
> > >    0x8000001e 0x00: eax=0x0000004a ebx=0x00000105 ecx=0x00000304
> > > edx=0x00000000
> > > CPU 38:
> > >    0x8000001e 0x00: eax=0x0000004c ebx=0x00000106 ecx=0x00000304
> > > edx=0x00000000
> > > CPU 39:
> > >    0x8000001e 0x00: eax=0x0000004e ebx=0x00000107 ecx=0x00000304
> > > edx=0x00000000
> > > CPU 40:
> > >    0x8000001e 0x00: eax=0x00000050 ebx=0x00000108 ecx=0x00000305
> > > edx=0x00000000
> > > CPU 41:
> > >    0x8000001e 0x00: eax=0x00000052 ebx=0x00000109 ecx=0x00000305
> > > edx=0x00000000
> > > CPU 42:
> > >    0x8000001e 0x00: eax=0x00000054 ebx=0x0000010a ecx=0x00000305
> > > edx=0x00000000
> > > CPU 43:
> > >    0x8000001e 0x00: eax=0x00000056 ebx=0x0000010b ecx=0x00000305
> > > edx=0x00000000
> > > CPU 44:
> > >    0x8000001e 0x00: eax=0x00000058 ebx=0x0000010c ecx=0x00000305
> > > edx=0x00000000
> > > CPU 45:
> > >    0x8000001e 0x00: eax=0x0000005a ebx=0x0000010d ecx=0x00000305
> > > edx=0x00000000
> > > CPU 46:
> > >    0x8000001e 0x00: eax=0x0000005c ebx=0x0000010e ecx=0x00000305
> > > edx=0x00000000
> > > CPU 47:
> > >    0x8000001e 0x00: eax=0x0000005e ebx=0x0000010f ecx=0x00000305
> > > edx=0x00000000
> > > CPU 48:
> > >    0x8000001e 0x00: eax=0x00000060 ebx=0x00000110 ecx=0x00000306
> > > edx=0x00000000
> > >
> > > CPU 49:
> > >    0x8000001e 0x00: eax=0x00000062 ebx=0x00000111 ecx=0x00000306
> > > edx=0x00000000
> > > CPU 50:
> > >    0x8000001e 0x00: eax=0x00000064 ebx=0x00000112 ecx=0x00000306
> > > edx=0x00000000
> > > CPU 51:
> > >    0x8000001e 0x00: eax=0x00000066 ebx=0x00000113 ecx=0x00000306
> > > edx=0x00000000
> > > CPU 52:
> > >    0x8000001e 0x00: eax=0x00000068 ebx=0x00000114 ecx=0x00000306
> > > edx=0x00000000
> > > CPU 53:
> > >    0x8000001e 0x00: eax=0x0000006a ebx=0x00000115 ecx=0x00000306
> > > edx=0x00000000
> > > CPU 54:
> > >    0x8000001e 0x00: eax=0x0000006c ebx=0x00000116 ecx=0x00000306
> > > edx=0x00000000
> > > CPU 55:
> > >    0x8000001e 0x00: eax=0x0000006e ebx=0x00000117 ecx=0x00000306
> > > edx=0x00000000
> > > CPU 56:
> > >    0x8000001e 0x00: eax=0x00000070 ebx=0x00000118 ecx=0x00000307
> > > edx=0x00000000
> > > CPU 57:
> > >    0x8000001e 0x00: eax=0x00000072 ebx=0x00000119 ecx=0x00000307
> > > edx=0x00000000
> > > CPU 58:
> > >    0x8000001e 0x00: eax=0x00000074 ebx=0x0000011a ecx=0x00000307
> > > edx=0x00000000
> > > CPU 59:
> > >    0x8000001e 0x00: eax=0x00000076 ebx=0x0000011b ecx=0x00000307
> > > edx=0x00000000
> > > CPU 60:
> > >    0x8000001e 0x00: eax=0x00000078 ebx=0x0000011c ecx=0x00000307
> > > edx=0x00000000
> > > CPU 61:
> > >    0x8000001e 0x00: eax=0x0000007a ebx=0x0000011d ecx=0x00000307
> > > edx=0x00000000
> > > CPU 62:
> > >    0x8000001e 0x00: eax=0x0000007c ebx=0x0000011e ecx=0x00000307
> > > edx=0x00000000
> > > CPU 63:
> > >    0x8000001e 0x00: eax=0x0000007e ebx=0x0000011f ecx=0x00000307
> > > edx=0x00000000
> > >  
> > > >  
> > > > >  
> > > > > >
> > > > > > I wonder if linux guest actually uses node_id encoded in apic id
> > > > > > for configuring/checking numa structures, or it just uses
> > > > > > whatever ACPI SRAT table provided.
> > > > > >  
> > > > > >>>> + */
> > > > > >>>> +static inline void x86_init_topo_ids(X86CPUTopoInfo *topo_info,
> > > > > >>>> +                                     CpuInstanceProperties props,
> > > > > >>>> +                                     X86CPUTopoIDs *topo_ids) {
> > > > > >>>> +    topo_ids->smt_id = props.has_thread_id ? props.thread_id : 0;
> > > > > >>>> +    topo_ids->core_id = props.has_core_id ? props.core_id : 0;
> > > > > >>>> +    topo_ids->die_id = props.has_die_id ? props.die_id : 0;
> > > > > >>>> +    topo_ids->node_id = props.has_node_id ?
> > > > > >>>> +                        props.node_id % MAX(topo_info->nodes_per_pkg, 1) :  
> > 0;  
> > > > > >>>> +    topo_ids->pkg_id = props.has_socket_id ? props.socket_id :
> > > > > >>>> +0; }
> > > > > >>>>  /*
> > > > > >>>>   * Make APIC ID for the CPU 'cpu_index'
> > > > > >>>>   *
> > > > > >>>>  
> > > > > >>  
> > > > > >  
> > > > >  
> > >
> > >  
> 


