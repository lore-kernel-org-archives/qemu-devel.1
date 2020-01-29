Return-Path: <SRS0=192v=3S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F86BC33CB2
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 09:15:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E50E5206F0
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 09:15:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TBmwGJo6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E50E5206F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43078 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwjRx-0006iY-3t
	for qemu-devel@archiver.kernel.org; Wed, 29 Jan 2020 04:15:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44693)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1iwjRK-0006CK-JS
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 04:15:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1iwjRJ-0000DI-5G
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 04:15:14 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:30023
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1iwjRJ-0000B6-07
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 04:15:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580289312;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LDXU6ySy+1Ai+rPuUHf9YRPYBP9laXhogKXcrBXyaVc=;
 b=TBmwGJo68uc3RGzretAbCXZjsdr66O3YLhPo/4iiByS5z5E/W5yx0kaoLBJVJ1908ARDzx
 M++qLI3C+WmOoLkuE5VYqpUgLIjC+DCFhXPy8cLodpUqnIU3lwaNEvfbNw8hcqJBNQXZ9O
 hppSsDxagP5hWPp7nxTIsuiNZU/NbZw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-147-y4aeBKJ-NiarCSoMIesB0Q-1; Wed, 29 Jan 2020 04:15:08 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B1307800D48;
 Wed, 29 Jan 2020 09:15:06 +0000 (UTC)
Received: from localhost (unknown [10.43.2.114])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CD85110013A7;
 Wed, 29 Jan 2020 09:15:00 +0000 (UTC)
Date: Wed, 29 Jan 2020 10:14:58 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Babu Moger <babu.moger@amd.com>
Subject: Re: [PATCH v3 07/18] machine: Add a new function init_apicid_fn in
 MachineClass
Message-ID: <20200129101458.6a108431@redhat.com>
In-Reply-To: <e5271e1c-55bc-e3d2-eb4c-2329eef07c9f@amd.com>
References: <157541968844.46157.17994918142533791313.stgit@naples-babu.amd.com>
 <157541986210.46157.5082551407581177819.stgit@naples-babu.amd.com>
 <20200128172919.4ecb5896@redhat.com>
 <e5271e1c-55bc-e3d2-eb4c-2329eef07c9f@amd.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: y4aeBKJ-NiarCSoMIesB0Q-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: ehabkost@redhat.com, mst@redhat.com, armbru@redhat.com,
 qemu-devel@nongnu.org, pbonzini@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 28 Jan 2020 13:45:31 -0600
Babu Moger <babu.moger@amd.com> wrote:

> On 1/28/20 10:29 AM, Igor Mammedov wrote:
> > On Tue, 03 Dec 2019 18:37:42 -0600
> > Babu Moger <babu.moger@amd.com> wrote:
> >   
> >> Add a new function init_apicid_fn in MachineClass to initialize the mode
> >> specific handlers to decode the apic ids.
> >>
> >> Signed-off-by: Babu Moger <babu.moger@amd.com>
> >> ---
> >>  include/hw/boards.h |    1 +
> >>  vl.c                |    3 +++
> >>  2 files changed, 4 insertions(+)
> >>
> >> diff --git a/include/hw/boards.h b/include/hw/boards.h
> >> index d4fab218e6..ce5aa365cb 100644
> >> --- a/include/hw/boards.h
> >> +++ b/include/hw/boards.h
> >> @@ -238,6 +238,7 @@ struct MachineClass {
> >>                                                           unsigned cpu_index);
> >>      const CPUArchIdList *(*possible_cpu_arch_ids)(MachineState *machine);
> >>      int64_t (*get_default_cpu_node_id)(const MachineState *ms, int idx);
> >> +    void (*init_apicid_fn)(MachineState *ms);  
> > it's x86 specific, so why it wasn put into PCMachineClass?  
> 
> Yes. It is x86 specific for now. I tried to make it generic function so
> other OSes can use it if required(like we have done in
> possible_cpu_arch_ids). It initializes functions required to build the
> apicid for each CPUs. We need these functions much early in the
> initialization. It should be initialized before parse_numa_opts or
> machine_run_board_init(in v1.c) which are called from generic context. We
> cannot use PCMachineClass at this time.

could you point to specific patches in this series that require
apic ids being initialized before parse_numa_opts and elaborate why?

we already have possible_cpu_arch_ids() which could be called very
early and calculates APIC IDs in x86 case, so why not reuse it?

> 
> > 
> >   
> >>  };
> >>  
> >>  /**
> >> diff --git a/vl.c b/vl.c
> >> index a42c24a77f..b6af604e11 100644
> >> --- a/vl.c
> >> +++ b/vl.c
> >> @@ -4318,6 +4318,9 @@ int main(int argc, char **argv, char **envp)
> >>      current_machine->cpu_type = machine_class->default_cpu_type;
> >>      if (cpu_option) {
> >>          current_machine->cpu_type = parse_cpu_option(cpu_option);
> >> +        if (machine_class->init_apicid_fn) {
> >> +            machine_class->init_apicid_fn(current_machine);
> >> +        }
> >>      }
> >>      parse_numa_opts(current_machine);
> >>  
> >>
> >>  
> >   
> 


