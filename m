Return-Path: <SRS0=cfdO=BG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2CEFC433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 16:37:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C9C320729
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 16:37:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Grg3ttvZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C9C320729
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58890 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k067g-00016z-OQ
	for qemu-devel@archiver.kernel.org; Mon, 27 Jul 2020 12:37:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34386)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1k066y-0000eA-Kv
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 12:36:24 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:48663
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1k066v-0005MC-VF
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 12:36:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595867779;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/xhto1tB5l5+bFJBKJYK4eVjHyHAxqb5LKdDUfWup1U=;
 b=Grg3ttvZYIhboVbyouZk9N0Xhh/qyq//F7BfGZMbKcklPV00YIxVW3xL+DBPlTfyy6StIa
 laJErEXIIQgwK4eDVGoqoZvMn+WlT/bbO7p5BoBYU3U77bA7Tb+vXpWPTH7P7VkSnCvw13
 +MYAYgniUQzymDCQirOxcJgN2KElcqc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-220-11C5Fy5-MAa9EARv9_LnSQ-1; Mon, 27 Jul 2020 12:36:16 -0400
X-MC-Unique: 11C5Fy5-MAa9EARv9_LnSQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DD31580BCAE;
 Mon, 27 Jul 2020 16:36:15 +0000 (UTC)
Received: from localhost (unknown [10.40.208.62])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3BAC01001B2C;
 Mon, 27 Jul 2020 16:36:14 +0000 (UTC)
Date: Mon, 27 Jul 2020 18:36:12 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Babu Moger <babu.moger@amd.com>
Subject: Re: [PATCH v2 3/3] hw/386: Fix uninitialized memory with -device
 and CPU hotplug
Message-ID: <20200727183612.684fe574@redhat.com>
In-Reply-To: <159362467562.36204.11074523095942812006.stgit@naples-babu.amd.com>
References: <159362436285.36204.986406297373871949.stgit@naples-babu.amd.com>
 <159362467562.36204.11074523095942812006.stgit@naples-babu.amd.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/27 01:46:13
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
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, ehabkost@redhat.com,
 rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 01 Jul 2020 12:31:15 -0500
Babu Moger <babu.moger@amd.com> wrote:

> Noticed the following command failure while testing CPU hotplug.
> 
> $ qemu-system-x86_64 -machine q35,accel=kvm -smp 1,maxcpus=2,
>   cores=1, threads=1,sockets=2 -cpu EPYC -device EPYC-x86_64-
>   cpu,core-id=0,socket-id=1,thread-id=0
> 
>   qemu-system-x86_64: -device EPYC-x86_64-cpu,core-id=0,socket-id=1,
>   thread-id=0: Invalid CPU [socket: 21855, die: 0, core: 0, thread: 0]
>   with APIC ID 21855, valid index range 0:1
> 
> This happens because APIC ID is calculated using uninitialized memory.
> This is happening after the addition of new field node_id in X86CPUTopoIDs
> structure. The node_id field is uninitialized while calling
> apicid_from_topo_ids. The problem is discussed in the thread below.
> https://lore.kernel.org/qemu-devel/20200602171838.GG577771@habkost.net/
> 
> Fix the problem by initializing the node_id from the device being added.
> 
> Fixes:
> Link: https://bugzilla.redhat.com/show_bug.cgi?id=1828750
> 
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---
>  hw/i386/pc.c |   10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index e613b2299f..aa9fb48834 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -1553,6 +1553,15 @@ static void pc_cpu_pre_plug(HotplugHandler *hotplug_dev,
>              cpu->die_id = 0;
>          }
>  
so this is from 
 'if (cpu->apic_id == UNASSIGNED_APIC_ID) {'
branch, meaning cpu comes from -device/device_add

> +        /*
> +         * If node_id is not set, initialize it to zero for now. If the user
> +         * does not pass the correct node in case of numa configuration, it
> +         * will be rejected eventually.
> +         */
> +        if (cpu->node_id < 0) {
which means that user hasn't provided 'node-id',
in which case we should error out asking for specifying NUMA node-id along with other options

(1)
However that's not enough since by contract query-hotpluggbale-cpus shall provide all attributes
necessary to hotplug CPU, which makes node-id is not an optional in case of EPYC cpu.
So we need to initialize ms->possible_cpus->cpus[i].props.[has_]node_id by the time
we start creating CPUs.

here are 2 variants:
(2)
  * single node:
      nodes_per_pkg 1 and ms->smp.sockets == 1

    since it's the only node and mapping of RAM/CPU is unambigiuos,
    we can deal with it by moving auto_enable_numa into MachineState
    and enabling it in case EPYC CPU is used

  * multiple nodes:
      - ms->smp.sockets > 1
      - nodes_per_pkg > 1
    we can't make up NUMA nodes automatically, and have to ask user to use -numa options
    to provide nodes along with CPU/RAM mapping. So in case NUMA wasn't configured
    explicitly, we can only error out. (that also applies to CPU created implicitly by board '-smp X')

(3) Once user supplied mapping we need to checks that it matches EPYC topology,


(4) As for CPUID, current code in CPUID_Fn8000001E_ECX
      if (nodes <= 4) { /* here nodes is nodes_per_pkg */
         / goes by stricly spec /
         *ecx = ((nodes - 1) << 8) | (topo_ids.pkg_id << 2) | topo_ids.node_id;
         /* makes up system wide NUMA node IDs which happen to match system wide
            NUMA node IDs created by -numa, when -smp + -numa produces nodes_per_pkg is in that range,
            basically user has no idea when this happens
          */
      } else {
         /* makeup new algorithm system wide NUMA node IDs generation for out of spec behaviour */
      }
     
    problem with both branches is that might lead to inconsistentcy between system wide
    NUMA node id in CPUID_Fn8000001E_ECX and the one configured with -numa which goes to
    SRAT ACPI table and should go to CPU::node-id property.

    Considering that out of spec behaviour is allowed we probably schould replace both branches
    with
       *ecx = ((nodes - 1) << 8) | cpu->node_id;
    which ensures consistency of system wide NUMA node ids and add checks for max nodes/max node id.

checks could be done early in cpu's realize() function.



> +            cpu->node_id = 0;
> +        }

>          if (cpu->socket_id < 0) {
>              error_setg(errp, "CPU socket-id is not set");
>              return;
> @@ -1587,6 +1596,7 @@ static void pc_cpu_pre_plug(HotplugHandler *hotplug_dev,
>          }
>  
>          topo_ids.pkg_id = cpu->socket_id;
> +        topo_ids.node_id = cpu->node_id;
>          topo_ids.die_id = cpu->die_id;
>          topo_ids.core_id = cpu->core_id;
>          topo_ids.smt_id = cpu->thread_id;
> 


