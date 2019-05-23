Return-Path: <SRS0=bvyN=TX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76839C282DD
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 09:34:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 48F0021019
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 09:34:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48F0021019
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:60554 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTk7I-0001UZ-II
	for qemu-devel@archiver.kernel.org; Thu, 23 May 2019 05:34:28 -0400
Received: from eggs.gnu.org ([209.51.188.92]:36811)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1hTk3k-0007ti-59
	for qemu-devel@nongnu.org; Thu, 23 May 2019 05:30:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1hTk3j-0007Po-0G
	for qemu-devel@nongnu.org; Thu, 23 May 2019 05:30:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57186)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>)
	id 1hTk3g-0007Cb-0p; Thu, 23 May 2019 05:30:44 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 122997E423;
	Thu, 23 May 2019 09:30:37 +0000 (UTC)
Received: from localhost (unknown [10.43.2.182])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 21D68672DD;
	Thu, 23 May 2019 09:30:33 +0000 (UTC)
Date: Thu, 23 May 2019 11:30:30 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Laurent Vivier <lvivier@redhat.com>
Message-ID: <20190523113030.1c52944e@redhat.com>
In-Reply-To: <20190521073348.29657-1-lvivier@redhat.com>
References: <20190521073348.29657-1-lvivier@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.27]);
	Thu, 23 May 2019 09:30:42 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2] numa: improve cpu hotplug error message
 with a wrong node-id
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Peter Maydell <peter.maydell@linaro.org>,
	Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org,
	qemu-arm@nongnu.org, qemu-ppc@nongnu.org,
	David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 21 May 2019 09:33:48 +0200
Laurent Vivier <lvivier@redhat.com> wrote:

> On pseries, core-ids are strongly binded to a node-id by the command
> line option. If an user tries to add a CPU to the wrong node, he has
> an error but it is not really helpful:
> 
>   qemu-system-ppc64 ... -smp 1,maxcpus=64,cores=1,threads=1,sockets=1 \
>                         -numa node,nodeid=0 -numa node,nodeid=1 ...
> 
>   (qemu) device_add power9_v2.0-spapr-cpu-core,core-id=30,node-id=1
>   Error: node-id=1 must match numa node specified with -numa option
> 
> This patch improves this error message by giving to the user the good
> topology information (node-id, socket-id and thread-id if they are
> available) to use with the core-id he's providing:
> 
>   Error: core-id 30 can only be plugged into node-id 0
> 
> Signed-off-by: Laurent Vivier <lvivier@redhat.com>
> ---
> 
> Notes:
>     v2: display full topology in the error message
> 
>  numa.c | 28 ++++++++++++++++++++++++++--
>  1 file changed, 26 insertions(+), 2 deletions(-)
> 
> diff --git a/numa.c b/numa.c
> index 3875e1efda3a..7413f821e2bb 100644
> --- a/numa.c
> +++ b/numa.c
> @@ -458,6 +458,27 @@ void qmp_set_numa_node(NumaOptions *cmd, Error **errp)
>      set_numa_options(MACHINE(qdev_get_machine()), cmd, errp);
>  }
>  
> +static char *cpu_topology_to_string(const CPUArchId *cpu)
> +{
> +    GString *s = g_string_new(NULL);
> +    if (cpu->props.has_socket_id) {
> +        g_string_append_printf(s, "socket-id %"PRId64, cpu->props.socket_id);
> +    }
> +    if (cpu->props.has_node_id) {
> +        if (s->len) {
> +            g_string_append_printf(s, ", ");
> +        }
> +        g_string_append_printf(s, "node-id %"PRId64, cpu->props.node_id);
> +    }
> +    if (cpu->props.has_thread_id) {
> +        if (s->len) {
> +            g_string_append_printf(s, ", ");
> +        }
> +        g_string_append_printf(s, "thread-id %"PRId64, cpu->props.thread_id);
> +    }
> +    return g_string_free(s, false);
> +}
> +
>  void numa_cpu_pre_plug(const CPUArchId *slot, DeviceState *dev, Error **errp)
>  {
>      int node_id = object_property_get_int(OBJECT(dev), "node-id", &error_abort);
> @@ -470,8 +491,11 @@ void numa_cpu_pre_plug(const CPUArchId *slot, DeviceState *dev, Error **errp)
>                                      "node-id", errp);
>          }
>      } else if (node_id != slot->props.node_id) {
> -        error_setg(errp, "node-id=%d must match numa node specified "
> -                   "with -numa option", node_id);
> +        char *topology = cpu_topology_to_string(slot);
> +        error_setg(errp,
> +                   "core-id %"PRId64" can only be plugged into %s",
> +                   slot->props.core_id, topology);
I'm not sure it's improvement over an existing error message, it looks
like a spapr specific thing in general code and even then I'm not sure
it's the correct one.

state before patch reports invalid device::'node-id' value,
while after patch it reports machine::slot[x]::core-id (-numa ...) which in
spapr case coincidentally happens to match device::core-id.
But wait machine::slot[x]::core-id is an optional in generic case so it might
be not set.

So we end up with error message that doesn't report invalid property directly
for the affected CPU but rather reports optional core id from board with full
slot description from the same board.

So I'd leave message as is or add topology info pointing valid slot description:

  error_setg(errp, "node-id=%d must match numa node specified "
                   "with -numa option '%s'", node_id, topology);


> +        g_free(topology);
>      }
>  }
>  


