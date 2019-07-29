Return-Path: <SRS0=7VQp=V2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22BF9C433FF
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2019 19:44:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE5E521849
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2019 19:44:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE5E521849
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55996 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hsBZg-00033u-6X
	for qemu-devel@archiver.kernel.org; Mon, 29 Jul 2019 15:44:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38466)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <ehabkost@redhat.com>) id 1hsBZH-0002cs-Vs
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 15:44:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1hsBZG-0000Of-Nc
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 15:44:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54296)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1hsBZG-0000ML-EU
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 15:44:22 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 783893082A8D;
 Mon, 29 Jul 2019 19:44:21 +0000 (UTC)
Received: from localhost (ovpn-116-75.gru2.redhat.com [10.97.116.75])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C297D5E7C4;
 Mon, 29 Jul 2019 19:44:16 +0000 (UTC)
Date: Mon, 29 Jul 2019 16:44:14 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Message-ID: <20190729194414.GG4313@habkost.net>
References: <20190726120542.9894-1-armbru@redhat.com>
 <20190726120542.9894-24-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190726120542.9894-24-armbru@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.45]); Mon, 29 Jul 2019 19:44:21 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 23/28] numa: Don't include hw/boards.h into
 sysemu/numa.h
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Jul 26, 2019 at 02:05:37PM +0200, Markus Armbruster wrote:
> sysemu/numa.h includes hw/boards.h just for the CPUArchId typedef, at
> the cost of pulling in more than two dozen extra headers indirectly.
> 
> I could move the typedef from hw/boards.h to qemu/typedefs.h.  But
> it's used in just two headers: boards.h and numa.h.
> 
> I could move it to another header both its users include.
> exec/cpu-common.h seems to be the least bad fit.
> 
> But I'm keeping this simple & stupid: declare the struct tag in
> numa.h.
> 
> Cc: Eduardo Habkost <ehabkost@redhat.com>
> Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  exec.c                     | 1 +
>  hw/core/machine-qmp-cmds.c | 1 +
>  hw/core/machine.c          | 1 +
>  hw/mem/pc-dimm.c           | 1 +
>  include/hw/boards.h        | 2 +-
>  include/sysemu/numa.h      | 9 +++++++--
>  6 files changed, 12 insertions(+), 3 deletions(-)
> 
> diff --git a/exec.c b/exec.c
> index 6d60fdfb1f..4d9e146c79 100644
> --- a/exec.c
> +++ b/exec.c
> @@ -41,6 +41,7 @@
>  #if defined(CONFIG_USER_ONLY)
>  #include "qemu.h"
>  #else /* !CONFIG_USER_ONLY */
> +#include "hw/boards.h"
>  #include "exec/memory.h"
>  #include "exec/ioport.h"
>  #include "sysemu/dma.h"
> diff --git a/hw/core/machine-qmp-cmds.c b/hw/core/machine-qmp-cmds.c
> index c83e8954e1..d8284671f0 100644
> --- a/hw/core/machine-qmp-cmds.c
> +++ b/hw/core/machine-qmp-cmds.c
> @@ -9,6 +9,7 @@
>  
>  #include "qemu/osdep.h"
>  #include "cpu.h"
> +#include "hw/boards.h"
>  #include "qapi/error.h"
>  #include "qapi/qapi-commands-machine.h"
>  #include "qapi/qmp/qerror.h"
> diff --git a/hw/core/machine.c b/hw/core/machine.c
> index 2c9c93983a..901f3fa905 100644
> --- a/hw/core/machine.c
> +++ b/hw/core/machine.c
> @@ -23,6 +23,7 @@
>  #include "sysemu/numa.h"
>  #include "qemu/error-report.h"
>  #include "sysemu/qtest.h"
> +#include "hw/boards.h"
>  #include "hw/pci/pci.h"
>  #include "hw/mem/nvdimm.h"
>  
> diff --git a/hw/mem/pc-dimm.c b/hw/mem/pc-dimm.c
> index 0c83dcd61e..fa90d4fc6c 100644
> --- a/hw/mem/pc-dimm.c
> +++ b/hw/mem/pc-dimm.c
> @@ -19,6 +19,7 @@
>   */
>  
>  #include "qemu/osdep.h"
> +#include "hw/boards.h"
>  #include "hw/mem/pc-dimm.h"
>  #include "hw/qdev-properties.h"
>  #include "migration/vmstate.h"
> diff --git a/include/hw/boards.h b/include/hw/boards.h
> index 67e551636a..739d109fe1 100644
> --- a/include/hw/boards.h
> +++ b/include/hw/boards.h
> @@ -86,7 +86,7 @@ void machine_class_allow_dynamic_sysbus_dev(MachineClass *mc, const char *type);
>   * @props - CPU object properties, initialized by board
>   * #vcpus_count - number of threads provided by @cpu object
>   */
> -typedef struct {
> +typedef struct CPUArchId {
>      uint64_t arch_id;
>      int64_t vcpus_count;
>      CpuInstanceProperties props;
> diff --git a/include/sysemu/numa.h b/include/sysemu/numa.h
> index 01a263eba2..4c4c1dee9b 100644
> --- a/include/sysemu/numa.h
> +++ b/include/sysemu/numa.h
> @@ -4,7 +4,10 @@
>  #include "qemu/bitmap.h"
>  #include "sysemu/sysemu.h"
>  #include "sysemu/hostmem.h"
> -#include "hw/boards.h"
> +#include "qapi/qapi-types-machine.h"

This seems to be needed because of NodeInfo.

> +#include "exec/cpu-common.h"

This seems to be needed because of ram_addr_t.

Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>


> +
> +struct CPUArchId;
>  

I wonder if we should do the same for other struct types like
NodeInfo.

Why is it bad to require the inclusion of hw/boards.h just
because of CPUArchId, but acceptable to require the inclusion of
qapi-types-machine.h just to be able to write "NodeInfo *nodes"
instead of "struct NodeInfo *nodes" below?

>  extern int nb_numa_nodes;   /* Number of NUMA nodes */
>  extern bool have_numa_distance;
> @@ -32,5 +35,7 @@ void numa_legacy_auto_assign_ram(MachineClass *mc, NodeInfo *nodes,
>                                   int nb_nodes, ram_addr_t size);
>  void numa_default_auto_assign_ram(MachineClass *mc, NodeInfo *nodes,
>                                    int nb_nodes, ram_addr_t size);
> -void numa_cpu_pre_plug(const CPUArchId *slot, DeviceState *dev, Error **errp);
> +void numa_cpu_pre_plug(const struct CPUArchId *slot, DeviceState *dev,
> +                       Error **errp);
> +
>  #endif
> -- 
> 2.21.0
> 

-- 
Eduardo

