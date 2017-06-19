Received: from eggs.gnu.org ([2001:4830:134:3::10]:58593)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dMrPj-0008Gm-4x
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 03:48:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dMrPg-0005go-0N
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 03:47:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46696)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1dMrPf-0005g1-Ns
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 03:47:55 -0400
References: <20170613125515.30416-1-vadim.galitsyn@profitbricks.com>
	<20170613125515.30416-2-vadim.galitsyn@profitbricks.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <5c8dbd37-073c-28a8-0062-272c6df02373@redhat.com>
Date: Mon, 19 Jun 2017 09:47:51 +0200
MIME-Version: 1.0
In-Reply-To: <20170613125515.30416-2-vadim.galitsyn@profitbricks.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] hmp,
 qmp: introduce "info memory" and "query-memory" commands
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vadim Galitsyn <vadim.galitsyn@profitbricks.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: Vasilis Liaskovitis <vasilis.liaskovitis@profitbricks.com>, Mohammed Gamal <mohammed.gamal@profitbricks.com>, Eduardo Otubo <eduardo.otubo@profitbricks.com>

On 13.06.2017 14:55, Vadim Galitsyn wrote:
> Commands above provide the following memory information in bytes:

Is the idea to have something like hmp_info_numa() ("info NUMA"), just
for qmp? And so it also works without NUMA?

I think, for this command to be helpful, you should include a per-NUMA
node information.

So what you could do:

- total_base memory
- total hotplugged memory
- base_memory per NUMA node
- hotplugged memory per NUMA node

> 
>   * hot-plug-memory - amount of memory that was hot-plugged.
> 

We also have query-memory-devices for that already.

>   * ballooned-actual-memory - size of the memory that remains
>     available to the guest after ballooning, as reported by the
>     guest. If the guest has not reported its memory, this value
>     equals to @base-memory + @hot-plug-memory. If ballooning
>     is not enabled, zero value is reported.

I don't think ballooning belongs into this at all.

> 
> NOTE:
> 
>     Parameter @ballooned-actual-memory reports the same as
>     "info balloon" command when ballooning is enabled. The idea
>     to have it in scope of this command(s) comes from
>     https://lists.gnu.org/archive/html/qemu-devel/2012-07/msg01472.html.

Can't you simply change query-balloon to show 0 in case no balloon is
around? Or why can't your caller simply deal with the fact that querying
the balloon might fail? Making a qmp interface directly copy the data
from another qmp interface looks strange.

> 
> Signed-off-by: Vasilis Liaskovitis <vasilis.liaskovitis@profitbricks.com>
> Signed-off-by: Mohammed Gamal <mohammed.gamal@profitbricks.com>
> Signed-off-by: Eduardo Otubo <eduardo.otubo@profitbricks.com>
> Signed-off-by: Vadim Galitsyn <vadim.galitsyn@profitbricks.com>
> Reviewed-by: Eugene Crosser <evgenii.cherkashin@profitbricks.com>
> Cc: Dr. David Alan Gilbert <dgilbert@redhat.com>
> Cc: Markus Armbruster <armbru@redhat.com>
> Cc: qemu-devel@nongnu.org
> ---
[...]
> +
> +MemoryInfo *qmp_query_memory(Error **errp)
> +{
> +    MemoryInfo *mem_info = g_malloc0(sizeof(MemoryInfo));
> +    BalloonInfo *balloon_info;
> +    Error *local_err = NULL;
> +
> +    mem_info->base_memory = ram_size;
> +    mem_info->hot_plug_memory = pc_existing_dimms_capacity(&local_err);

This seems to be x86 specific.
Some machines (e.g. s390x) will not be properly accounted here.
(e.g. they round ram_size up/down) or don't use DIMMs. I think we should
query the machines instead.

> +    if (local_err) {
> +        error_setg(errp, "could not get hot-plug memory info: %s",
> +                   error_get_pretty(local_err));
> +        g_free(mem_info);
> +        return NULL;
> +    }
> +
> +    /* In case if it is not possible to get balloon info, just ignore it. */
> +    balloon_info = qmp_query_balloon(&local_err);
> +    if (local_err) {
> +        mem_info->ballooned_actual_memory = 0;
> +        error_free(local_err);
> +    } else {
> +        mem_info->ballooned_actual_memory = balloon_info->actual;
> +    }

-- 

Thanks,

David
