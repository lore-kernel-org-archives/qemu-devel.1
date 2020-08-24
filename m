Return-Path: <SRS0=JPH5=CC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4BBDC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 18:42:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9350C207CD
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 18:42:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X5GP59Fa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9350C207CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34638 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAHQK-00083b-MW
	for qemu-devel@archiver.kernel.org; Mon, 24 Aug 2020 14:42:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34548)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1kAHPL-0007aI-B8
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 14:41:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:45994)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1kAHPI-0001Gu-FA
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 14:41:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598294482;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JO/q24IC5dyk8nasGexFrg23CAN/CkqoMjClV5fv/DE=;
 b=X5GP59FaOol5tM0NaA2nC9enGCPWdCX2Hau+T4TazTMvLOIM637H3nLS+nqD0VqPdiYKKc
 FrtbEbg4lRtrDHboOMehka07YV4iSHMn187XzJVyLoeRKKAjuOe4VWzDNVc0X2Ow2b9x5C
 wt+26mereelYYVtJoWoWoQvw1NU2tOw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-176-_9AFH1quPtm9P9XqegBiAg-1; Mon, 24 Aug 2020 14:41:20 -0400
X-MC-Unique: _9AFH1quPtm9P9XqegBiAg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 79B7D1015C99;
 Mon, 24 Aug 2020 18:41:19 +0000 (UTC)
Received: from work-vm (ovpn-114-59.ams2.redhat.com [10.36.114.59])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 32DA25BAC3;
 Mon, 24 Aug 2020 18:41:14 +0000 (UTC)
Date: Mon, 24 Aug 2020 19:41:12 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Babu Moger <babu.moger@amd.com>
Subject: Re: [PATCH v5 0/8] Remove EPYC mode apicid decode and use generic
 decode
Message-ID: <20200824184112.GB2688@work-vm>
References: <159804762216.39954.15502128500494116468.stgit@naples-babu.amd.com>
MIME-Version: 1.0
In-Reply-To: <159804762216.39954.15502128500494116468.stgit@naples-babu.amd.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=dgilbert@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/24 06:48:00
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.956,
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
Cc: ehabkost@redhat.com, mst@redhat.com, qemu-devel@nongnu.org,
 imammedo@redhat.com, pbonzini@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Babu Moger (babu.moger@amd.com) wrote:
> To support some of the complex topology, we introduced EPYC mode apicid decode.
> But, EPYC mode decode is running into problems. Also it can become quite a
> maintenance problem in the future. So, it was decided to remove that code and
> use the generic decode which works for majority of the topology. Most of the
> SPECed configuration would work just fine. With some non-SPECed user inputs,
> it will create some sub-optimal configuration.
> Here is the discussion thread.
> https://lore.kernel.org/qemu-devel/c0bcc1a6-1d84-a6e7-e468-d5b437c1b254@amd.com/
> 
> This series removes all the EPYC mode specific apicid changes and use the generic
> apicid decode.

Hi Babu,
  This does simplify things a lot!
One worry, what happens about a live migration of a VM from an old qemu
that was using the node-id to a qemu with this new scheme?

Dave

> ---
> v5:
>  Revert EPYC specific decode.
>  Simplify CPUID_8000_001E
> 
> v4:
>   https://lore.kernel.org/qemu-devel/159744083536.39197.13827776633866601278.stgit@naples-babu.amd.com/
>   Not much of a change. Just added few text changes.
>   Error out configuration instead of warning if dies are not configured in EPYC.
>   Few other text changes to clarify the removal of node_id, nr_nodes and nodes_per_pkg.
> 
> v3:
>   https://lore.kernel.org/qemu-devel/159681772267.9679.1334429994189974662.stgit@naples-babu.amd.com/#r
>   Added a new check to pass the dies for EPYC numa configuration.
>   Added Simplify CPUID_8000_001E patch with some changes suggested by Igor.
>   Dropped the patch to build the topology from CpuInstanceProperties.
>   TODO: Not sure if we still need the Autonuma changes Igor mentioned.
>   Needs more clarity on that.
> 
> v2:
>   https://lore.kernel.org/qemu-devel/159362436285.36204.986406297373871949.stgit@naples-babu.amd.com/
>   Used the numa information from CpuInstanceProperties for building
>   the apic_id suggested by Igor.
>   Also did some minor code re-aarangement to take care of changes.
>   Dropped the patch "Simplify CPUID_8000_001E" from v1. Will send
>   it later.
> 
> v1:
>  https://lore.kernel.org/qemu-devel/159164739269.20543.3074052993891532749.stgit@naples-babu.amd.com
> 
> Babu Moger (8):
>       hw/i386: Remove node_id, nr_nodes and nodes_per_pkg from topology
>       Revert "i386: Fix pkg_id offset for EPYC cpu models"
>       Revert "target/i386: Enable new apic id encoding for EPYC based cpus models"
>       Revert "hw/i386: Move arch_id decode inside x86_cpus_init"
>       Revert "i386: Introduce use_epyc_apic_id_encoding in X86CPUDefinition"
>       Revert "hw/i386: Introduce apicid functions inside X86MachineState"
>       Revert "hw/386: Add EPYC mode topology decoding functions"
>       i386: Simplify CPUID_8000_001E for AMD
> 
> 
>  hw/i386/pc.c               |    8 +--
>  hw/i386/x86.c              |   43 +++-------------
>  include/hw/i386/topology.h |  101 ---------------------------------------
>  include/hw/i386/x86.h      |    9 ---
>  target/i386/cpu.c          |  115 ++++++++++++++++----------------------------
>  target/i386/cpu.h          |    3 -
>  tests/test-x86-cpuid.c     |   40 ++++++++-------
>  7 files changed, 73 insertions(+), 246 deletions(-)
> 
> --
> Signature
> 
-- 
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


