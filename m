Return-Path: <SRS0=UjLb=7L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D40E6C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2020 15:11:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E555206A4
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2020 15:11:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O89Tbt1S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E555206A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44222 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jegf6-0002ng-Ho
	for qemu-devel@archiver.kernel.org; Fri, 29 May 2020 11:11:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43434)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1jege0-00020w-J3
 for qemu-devel@nongnu.org; Fri, 29 May 2020 11:10:00 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:24247
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1jegdz-0007TK-6G
 for qemu-devel@nongnu.org; Fri, 29 May 2020 11:09:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590764997;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=I5ZvaZjx9gMdWPAPMSCDC+4tSIPrRG96EpKIP/hLAlw=;
 b=O89Tbt1SXuHJCZz4RaYLps3xyXxDzlSEBJK0knOzWPD8nXBCy9kE8J0pjDKOq6+UXny2Rr
 86pFN7HcY5R4QK0e1UbEXAUku4aMFLV4oRapgPbKVjZKmJJLjU/6r79yYzLTYx2NOo6JeZ
 PL5KK4jizKimzurU6CBndDThs22NX0E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-395-vXV7SVCpPnq_gAU1WdneRQ-1; Fri, 29 May 2020 11:09:55 -0400
X-MC-Unique: vXV7SVCpPnq_gAU1WdneRQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A5D3D107ACCA;
 Fri, 29 May 2020 15:09:54 +0000 (UTC)
Received: from localhost (unknown [10.40.208.55])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8AE255EE0E;
 Fri, 29 May 2020 15:09:52 +0000 (UTC)
Date: Fri, 29 May 2020 17:09:48 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Michal Privoznik <mprivozn@redhat.com>
Subject: Re: [PATCH 3/3] numa: Initialize node initiator with respect to
 .has_cpu
Message-ID: <20200529170948.5bdb3316@redhat.com>
In-Reply-To: <d3039c47e4ce1118bc7c4d4f51da6412c6669339.1590753455.git.mprivozn@redhat.com>
References: <cover.1590753455.git.mprivozn@redhat.com>
 <d3039c47e4ce1118bc7c4d4f51da6412c6669339.1590753455.git.mprivozn@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/29 01:27:49
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: jingqi.liu@intel.com, tao3.xu@intel.com, qemu-devel@nongnu.org,
 ehabkost@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 29 May 2020 15:33:48 +0200
Michal Privoznik <mprivozn@redhat.com> wrote:

> The initiator attribute of a NUMA node is documented as the 'NUMA
> node that has best performance to given NUMA node'. If a NUMA
> node has at least one CPU there can hardly be a different node
> with better performace and thus all NUMA nodes which have a CPU
> are initiators to themselves. Reflect this fact when initializing
> the attribute.

It is not true in case of the node is memory-less

> Signed-off-by: Michal Privoznik <mprivozn@redhat.com>
> ---
>  hw/core/numa.c | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)
> 
> diff --git a/hw/core/numa.c b/hw/core/numa.c
> index 338453461c..1c9bc761cc 100644
> --- a/hw/core/numa.c
> +++ b/hw/core/numa.c
> @@ -136,11 +136,15 @@ static void parse_numa_node(MachineState *ms, NumaNodeOptions *node,
>          numa_info[nodenr].node_memdev = MEMORY_BACKEND(o);
>      }
>  
> -    /*
> -     * If not set the initiator, set it to MAX_NODES. And if
> -     * HMAT is enabled and this node has no cpus, QEMU will raise error.
> -     */
> -    numa_info[nodenr].initiator = MAX_NODES;
> +    /* Initialize initiator to either the current NUMA node (if
> +     * it has at least one CPU), or to MAX_NODES. If HMAT is
> +     * enabled an error will be raised later in
> +     * numa_validate_initiator(). */
> +    if (numa_info[nodenr].has_cpu)
> +        numa_info[nodenr].initiator = nodenr;
> +    else
> +        numa_info[nodenr].initiator = MAX_NODES;
> +
>      if (node->has_initiator) {
>          if (!ms->numa_state->hmat_enabled) {
>              error_setg(errp, "ACPI Heterogeneous Memory Attribute Table "


