Received: from eggs.gnu.org ([2001:4830:134:3::10]:47173)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1e41PE-0003GY-Pz
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 05:09:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1e41PC-0001dX-4u
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 05:09:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38678)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1e41PB-0001d6-Ub
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 05:09:50 -0400
Date: Mon, 16 Oct 2017 11:09:46 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20171016110946.58d847ca@nial.brq.redhat.com>
In-Reply-To: <1508137406-5222-1-git-send-email-bharata@linux.vnet.ibm.com>
References: <1508137406-5222-1-git-send-email-bharata@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [FIX PATCH] monitor: Don't return CPU marked for
 unplug as monitor CPU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Bharata B Rao <bharata@linux.vnet.ibm.com>
Cc: qemu-devel@nongnu.org, sathnaga@linux.vnet.ibm.com, dgilbert@redhat.com, armbru@redhat.com, Greg Kurz <groug@kaod.org>

On Mon, 16 Oct 2017 12:33:26 +0530
Bharata B Rao <bharata@linux.vnet.ibm.com> wrote:

> The following sequence of steps kill the QEMU:
> 
> - Hotplug a CPU
> - Change the default CPU to the newly hotplugged cpu using "cpu" HMP command.
> - Hot unplug the CPU
> - Run "info cpus"
> 
> Fix this by not letting monitor_get_cpu() to return a CPU which is marked
> for unplug.
> 
> Reported-by: Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>
> Signed-off-by: Bharata B Rao <bharata@linux.vnet.ibm.com>
> ---
>  monitor.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/monitor.c b/monitor.c
> index fe0d1bd..8d60e57 100644
> --- a/monitor.c
> +++ b/monitor.c
> @@ -1053,7 +1053,7 @@ int monitor_set_cpu(int cpu_index)
>  
>  CPUState *mon_get_cpu(void)
>  {
> -    if (!cur_mon->mon_cpu) {
> +    if (!cur_mon->mon_cpu || cur_mon->mon_cpu->unplug) {
mon_cpu could be freed so it would cause use after free,
Greg was looking into the same issue see his patch:
"PATCH] monitor: fix dangling CPU pointer"



>          if (!first_cpu) {
>              return NULL;
>          }
