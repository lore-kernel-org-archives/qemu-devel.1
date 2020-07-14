Return-Path: <SRS0=DUFB=AZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99637C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 16:44:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 592E72222E
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 16:44:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MGkXtAEP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 592E72222E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50982 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvO2I-0002mp-Ee
	for qemu-devel@archiver.kernel.org; Tue, 14 Jul 2020 12:44:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43920)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1jvO0m-00009L-Jr
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 12:42:32 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:41590
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1jvO0j-0006k4-5Q
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 12:42:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594744947;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sO+8WdmToa8t2I8v+GC/Sl28zxW9u2qcKf7jAenN19Y=;
 b=MGkXtAEPQRn4eR4JpSvKejoK+ja5FAMxKPwTrxACsWMXgnN1zMZL/zJcRlmT44wNiK2n7Z
 REv6QKD9nzQFgD16cOM2TxRIcsyKOHMOGa2EmyC9KGg71WYziUZARgNh7MIVvmrQot6QEz
 DJaBRvzEEdXgsf+n0E/wz4BbW3y68UI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-408-qTil2E3fMAu6tFOKDoyGhg-1; Tue, 14 Jul 2020 12:41:59 -0400
X-MC-Unique: qTil2E3fMAu6tFOKDoyGhg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 662CB800685;
 Tue, 14 Jul 2020 16:41:58 +0000 (UTC)
Received: from localhost (unknown [10.40.208.62])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 932976FDD1;
 Tue, 14 Jul 2020 16:41:56 +0000 (UTC)
Date: Tue, 14 Jul 2020 18:41:54 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Babu Moger <babu.moger@amd.com>
Subject: Re: [PATCH v2 1/3] hw/i386: Initialize topo_ids from
 CpuInstanceProperties
Message-ID: <20200714184154.12c686bf@redhat.com>
In-Reply-To: <4003b476-afdb-74a1-4f9f-1387aae6c4e8@amd.com>
References: <159362436285.36204.986406297373871949.stgit@naples-babu.amd.com>
 <159362466108.36204.3751851750959980962.stgit@naples-babu.amd.com>
 <20200713110822.5495e1c6@redhat.com>
 <78809d9f-a491-8c99-3f35-7f012c7d75bf@amd.com>
 <20200713181740.16a357a6@redhat.com>
 <47dc6238-bb71-d679-f58a-f574eb36d572@amd.com>
 <20200713193221.27674630@redhat.com>
 <4003b476-afdb-74a1-4f9f-1387aae6c4e8@amd.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=imammedo@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/14 01:42:04
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
Cc: "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "rth@twiddle.net" <rth@twiddle.net>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "ehabkost@redhat.com" <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 13 Jul 2020 14:30:29 -0500
Babu Moger <babu.moger@amd.com> wrote:

> > -----Original Message-----
> > From: Igor Mammedov <imammedo@redhat.com>
> > Sent: Monday, July 13, 2020 12:32 PM
> > To: Moger, Babu <Babu.Moger@amd.com>
> > Cc: pbonzini@redhat.com; rth@twiddle.net; ehabkost@redhat.com; qemu-
> > devel@nongnu.org
> > Subject: Re: [PATCH v2 1/3] hw/i386: Initialize topo_ids from
> > CpuInstanceProperties
> > 
> > On Mon, 13 Jul 2020 11:43:33 -0500
> > Babu Moger <babu.moger@amd.com> wrote:
> >   
> > > On 7/13/20 11:17 AM, Igor Mammedov wrote:  
> > > > On Mon, 13 Jul 2020 10:02:22 -0500
> > > > Babu Moger <babu.moger@amd.com> wrote:
> > > >  
> > > >>> -----Original Message-----
> > > >>> From: Igor Mammedov <imammedo@redhat.com>
> > > >>> Sent: Monday, July 13, 2020 4:08 AM
> > > >>> To: Moger, Babu <Babu.Moger@amd.com>
> > > >>> Cc: pbonzini@redhat.com; rth@twiddle.net; ehabkost@redhat.com;
> > > >>> qemu- devel@nongnu.org
> > > >>> Subject: Re: [PATCH v2 1/3] hw/i386: Initialize topo_ids from
> > > >>> CpuInstanceProperties  
> > > > [...]  
> > > >>>> +
> > > >>>> +/*
> > > >>>> + * Initialize topo_ids from CpuInstanceProperties
> > > >>>> + * node_id in CpuInstanceProperties(or in CPU device) is a sequential
> > > >>>> + * number, but while building the topology  
> > > >>>  
> > > >>>> we need to separate it for
> > > >>>> + * each socket(mod nodes_per_pkg).  
> > > >>> could you clarify a bit more on why this is necessary?  
> > > >>
> > > >> If you have two sockets and 4 numa nodes, node_id in
> > > >> CpuInstanceProperties will be number sequentially as 0, 1, 2, 3.
> > > >> But in EPYC topology, it will be  0, 1, 0, 1( Basically mod % number of nodes  
> > per socket).  
> > > >
> > > > I'm confused, let's suppose we have 2 EPYC sockets with 2 nodes per
> > > > socket so APIC id woulbe be composed like:
> > > >
> > > >  1st socket
> > > >    pkg_id(0) | node_id(0)
> > > >    pkg_id(0) | node_id(1)
> > > >
> > > >  2nd socket
> > > >    pkg_id(1) | node_id(0)
> > > >    pkg_id(1) | node_id(1)
> > > >
> > > > if that's the case, then EPYC's node_id here doesn't look like a
> > > > NUMA node in the sense it's usually used (above config would have 4
> > > > different memory controllers => 4 conventional NUMA nodes).  
> > >
> > > EPIC model uses combination of socket id and node id to identify the
> > > numa nodes. So, it internally uses all the information.  
> > 
> > well with above values, EPYC's node_id doesn't look like it's specifying a
> > machine numa node, but rather a node index within single socket. In which case,
> > it doesn't make much sense calling it NUMA node_id, it's rather some index
> > within a socket. (it starts looking like terminology is all mixed up)
> > 
> > If you have access to a milti-socket EPYC machine, can you dump and post here
> > its apic ids, pls?  
> 
> Here is the output from my EPYC machine with 2 sockets and totally 8
> nodes(SMT disabled). The cpus 0-31 are in socket 0 and  cpus 32-63 in
> socket 1.
> 
> # lscpu
> Architecture:        x86_64
> CPU op-mode(s):      32-bit, 64-bit
> Byte Order:          Little Endian
> CPU(s):              64
> On-line CPU(s) list: 0-63
> Thread(s) per core:  1
> Core(s) per socket:  32
> Socket(s):           2
> NUMA node(s):        8
> Vendor ID:           AuthenticAMD
> CPU family:          23
> Model:               1
> Model name:          AMD Eng Sample: 1S1901A4VIHF5_30/19_N
> Stepping:            2
> CPU MHz:             2379.233
> CPU max MHz:         1900.0000
> CPU min MHz:         1200.0000
> BogoMIPS:            3792.81
> Virtualization:      AMD-V
> L1d cache:           32K
> L1i cache:           64K
> L2 cache:            512K
> L3 cache:            8192K
> NUMA node0 CPU(s):   0-7
> NUMA node1 CPU(s):   8-15
> NUMA node2 CPU(s):   16-23
> NUMA node3 CPU(s):   24-31
> NUMA node4 CPU(s):   32-39
> NUMA node5 CPU(s):   40-47
> NUMA node6 CPU(s):   48-55
> NUMA node7 CPU(s):   56-63
> 
> Here is the output of #cpuid  -l 0x8000001e  -r
> 
> You may want to refer
> https://www.amd.com/system/files/TechDocs/54945_3.03_ppr_ZP_B2_pub.zip
> (section 2.1.12.2.1.3 ApicId Enumeration Requirements).
> Note that this is a general guideline. We tried to generalize in qemu as
> much as possible. It is bit complex.
Thanks, I'll look into it.
Can you also dump SRAT table from that machine, please?
I'd like to see CPUs relation to NUMA nodes described in SRAT.

> 
> CPU 0:
>    0x8000001e 0x00: eax=0x00000000 ebx=0x00000100 ecx=0x00000300
> edx=0x00000000
> CPU 1:
>    0x8000001e 0x00: eax=0x00000002 ebx=0x00000101 ecx=0x00000300
> edx=0x00000000
> CPU 2:
>    0x8000001e 0x00: eax=0x00000004 ebx=0x00000102 ecx=0x00000300
> edx=0x00000000
> CPU 3:
>    0x8000001e 0x00: eax=0x00000006 ebx=0x00000103 ecx=0x00000300
> edx=0x00000000
> CPU 4:
>    0x8000001e 0x00: eax=0x00000008 ebx=0x00000104 ecx=0x00000300
> edx=0x00000000
> CPU 5:
>    0x8000001e 0x00: eax=0x0000000a ebx=0x00000105 ecx=0x00000300
> edx=0x00000000
> CPU 6:
>    0x8000001e 0x00: eax=0x0000000c ebx=0x00000106 ecx=0x00000300
> edx=0x00000000
> CPU 7:
>    0x8000001e 0x00: eax=0x0000000e ebx=0x00000107 ecx=0x00000300
> edx=0x00000000
> CPU 8:
>    0x8000001e 0x00: eax=0x00000010 ebx=0x00000108 ecx=0x00000301
> edx=0x00000000
> CPU 9:
>    0x8000001e 0x00: eax=0x00000012 ebx=0x00000109 ecx=0x00000301
> edx=0x00000000
> CPU 10:
>    0x8000001e 0x00: eax=0x00000014 ebx=0x0000010a ecx=0x00000301
> edx=0x00000000
> CPU 11:
>    0x8000001e 0x00: eax=0x00000016 ebx=0x0000010b ecx=0x00000301
> edx=0x00000000
> CPU 12:
>    0x8000001e 0x00: eax=0x00000018 ebx=0x0000010c ecx=0x00000301
> edx=0x00000000
> CPU 13:
>    0x8000001e 0x00: eax=0x0000001a ebx=0x0000010d ecx=0x00000301
> edx=0x00000000
> CPU 14:
>    0x8000001e 0x00: eax=0x0000001c ebx=0x0000010e ecx=0x00000301
> edx=0x00000000
> CPU 15:
>    0x8000001e 0x00: eax=0x0000001e ebx=0x0000010f ecx=0x00000301
> edx=0x00000000
> CPU 16:
>    0x8000001e 0x00: eax=0x00000020 ebx=0x00000110 ecx=0x00000302
> edx=0x00000000
> CPU 17:
>    0x8000001e 0x00: eax=0x00000022 ebx=0x00000111 ecx=0x00000302
> edx=0x00000000
> CPU 18:
>    0x8000001e 0x00: eax=0x00000024 ebx=0x00000112 ecx=0x00000302
> edx=0x00000000
> CPU 19:
>    0x8000001e 0x00: eax=0x00000026 ebx=0x00000113 ecx=0x00000302
> edx=0x00000000
> CPU 20:
>    0x8000001e 0x00: eax=0x00000028 ebx=0x00000114 ecx=0x00000302
> edx=0x00000000
> CPU 21:
>    0x8000001e 0x00: eax=0x0000002a ebx=0x00000115 ecx=0x00000302
> edx=0x00000000
> CPU 22:
>    0x8000001e 0x00: eax=0x0000002c ebx=0x00000116 ecx=0x00000302
> edx=0x00000000
> CPU 23:
>    0x8000001e 0x00: eax=0x0000002e ebx=0x00000117 ecx=0x00000302
> edx=0x00000000
> CPU 24:
>    0x8000001e 0x00: eax=0x00000030 ebx=0x00000118 ecx=0x00000303
> edx=0x00000000
> CPU 25:
>    0x8000001e 0x00: eax=0x00000032 ebx=0x00000119 ecx=0x00000303
> edx=0x00000000
> CPU 26:
>    0x8000001e 0x00: eax=0x00000034 ebx=0x0000011a ecx=0x00000303
> edx=0x00000000
> CPU 27:
>    0x8000001e 0x00: eax=0x00000036 ebx=0x0000011b ecx=0x00000303
> edx=0x00000000
> CPU 28:
>    0x8000001e 0x00: eax=0x00000038 ebx=0x0000011c ecx=0x00000303
> edx=0x00000000
> CPU 29:
>    0x8000001e 0x00: eax=0x0000003a ebx=0x0000011d ecx=0x00000303
> edx=0x00000000
> CPU 30:
>    0x8000001e 0x00: eax=0x0000003c ebx=0x0000011e ecx=0x00000303
> edx=0x00000000
> CPU 31:
>    0x8000001e 0x00: eax=0x0000003e ebx=0x0000011f ecx=0x00000303
> edx=0x00000000
> CPU 32:
>    0x8000001e 0x00: eax=0x00000040 ebx=0x00000100 ecx=0x00000304
> edx=0x00000000
> CPU 33:
>    0x8000001e 0x00: eax=0x00000042 ebx=0x00000101 ecx=0x00000304
> edx=0x00000000
> CPU 34:
>    0x8000001e 0x00: eax=0x00000044 ebx=0x00000102 ecx=0x00000304
> edx=0x00000000
> CPU 35:
>    0x8000001e 0x00: eax=0x00000046 ebx=0x00000103 ecx=0x00000304
> edx=0x00000000
> CPU 36:
>    0x8000001e 0x00: eax=0x00000048 ebx=0x00000104 ecx=0x00000304
> edx=0x00000000
> CPU 37:
>    0x8000001e 0x00: eax=0x0000004a ebx=0x00000105 ecx=0x00000304
> edx=0x00000000
> CPU 38:
>    0x8000001e 0x00: eax=0x0000004c ebx=0x00000106 ecx=0x00000304
> edx=0x00000000
> CPU 39:
>    0x8000001e 0x00: eax=0x0000004e ebx=0x00000107 ecx=0x00000304
> edx=0x00000000
> CPU 40:
>    0x8000001e 0x00: eax=0x00000050 ebx=0x00000108 ecx=0x00000305
> edx=0x00000000
> CPU 41:
>    0x8000001e 0x00: eax=0x00000052 ebx=0x00000109 ecx=0x00000305
> edx=0x00000000
> CPU 42:
>    0x8000001e 0x00: eax=0x00000054 ebx=0x0000010a ecx=0x00000305
> edx=0x00000000
> CPU 43:
>    0x8000001e 0x00: eax=0x00000056 ebx=0x0000010b ecx=0x00000305
> edx=0x00000000
> CPU 44:
>    0x8000001e 0x00: eax=0x00000058 ebx=0x0000010c ecx=0x00000305
> edx=0x00000000
> CPU 45:
>    0x8000001e 0x00: eax=0x0000005a ebx=0x0000010d ecx=0x00000305
> edx=0x00000000
> CPU 46:
>    0x8000001e 0x00: eax=0x0000005c ebx=0x0000010e ecx=0x00000305
> edx=0x00000000
> CPU 47:
>    0x8000001e 0x00: eax=0x0000005e ebx=0x0000010f ecx=0x00000305
> edx=0x00000000
> CPU 48:
>    0x8000001e 0x00: eax=0x00000060 ebx=0x00000110 ecx=0x00000306
> edx=0x00000000
> 
> CPU 49:
>    0x8000001e 0x00: eax=0x00000062 ebx=0x00000111 ecx=0x00000306
> edx=0x00000000
> CPU 50:
>    0x8000001e 0x00: eax=0x00000064 ebx=0x00000112 ecx=0x00000306
> edx=0x00000000
> CPU 51:
>    0x8000001e 0x00: eax=0x00000066 ebx=0x00000113 ecx=0x00000306
> edx=0x00000000
> CPU 52:
>    0x8000001e 0x00: eax=0x00000068 ebx=0x00000114 ecx=0x00000306
> edx=0x00000000
> CPU 53:
>    0x8000001e 0x00: eax=0x0000006a ebx=0x00000115 ecx=0x00000306
> edx=0x00000000
> CPU 54:
>    0x8000001e 0x00: eax=0x0000006c ebx=0x00000116 ecx=0x00000306
> edx=0x00000000
> CPU 55:
>    0x8000001e 0x00: eax=0x0000006e ebx=0x00000117 ecx=0x00000306
> edx=0x00000000
> CPU 56:
>    0x8000001e 0x00: eax=0x00000070 ebx=0x00000118 ecx=0x00000307
> edx=0x00000000
> CPU 57:
>    0x8000001e 0x00: eax=0x00000072 ebx=0x00000119 ecx=0x00000307
> edx=0x00000000
> CPU 58:
>    0x8000001e 0x00: eax=0x00000074 ebx=0x0000011a ecx=0x00000307
> edx=0x00000000
> CPU 59:
>    0x8000001e 0x00: eax=0x00000076 ebx=0x0000011b ecx=0x00000307
> edx=0x00000000
> CPU 60:
>    0x8000001e 0x00: eax=0x00000078 ebx=0x0000011c ecx=0x00000307
> edx=0x00000000
> CPU 61:
>    0x8000001e 0x00: eax=0x0000007a ebx=0x0000011d ecx=0x00000307
> edx=0x00000000
> CPU 62:
>    0x8000001e 0x00: eax=0x0000007c ebx=0x0000011e ecx=0x00000307
> edx=0x00000000
> CPU 63:
>    0x8000001e 0x00: eax=0x0000007e ebx=0x0000011f ecx=0x00000307
> edx=0x00000000
> 
> >   
> > >  
> > > >
> > > > I wonder if linux guest actually uses node_id encoded in apic id for
> > > > configuring/checking numa structures, or it just uses whatever ACPI
> > > > SRAT table provided.
> > > >  
> > > >>>> + */
> > > >>>> +static inline void x86_init_topo_ids(X86CPUTopoInfo *topo_info,
> > > >>>> +                                     CpuInstanceProperties props,
> > > >>>> +                                     X86CPUTopoIDs *topo_ids) {
> > > >>>> +    topo_ids->smt_id = props.has_thread_id ? props.thread_id : 0;
> > > >>>> +    topo_ids->core_id = props.has_core_id ? props.core_id : 0;
> > > >>>> +    topo_ids->die_id = props.has_die_id ? props.die_id : 0;
> > > >>>> +    topo_ids->node_id = props.has_node_id ?
> > > >>>> +                        props.node_id % MAX(topo_info->nodes_per_pkg, 1) : 0;
> > > >>>> +    topo_ids->pkg_id = props.has_socket_id ? props.socket_id :
> > > >>>> +0; }
> > > >>>>  /*
> > > >>>>   * Make APIC ID for the CPU 'cpu_index'
> > > >>>>   *
> > > >>>>  
> > > >>  
> > > >  
> > >  
> 
> 


