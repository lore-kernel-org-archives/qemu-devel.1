Received: from eggs.gnu.org ([2001:4830:134:3::10]:39612)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1cQmuR-0000Ek-HF
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 22:15:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1cQmuM-0003Ub-K9
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 22:15:39 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44802)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1cQmuM-0003U4-8k
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 22:15:34 -0500
Date: Tue, 10 Jan 2017 05:15:32 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170110051515-mutt-send-email-mst@kernel.org>
References: <1483108391-199542-1-git-send-email-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1483108391-199542-1-git-send-email-imammedo@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] pc: fix crash in rtc_set_memory() if
 initial cpu is marked as hotplugged
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, armbru@redhat.com, afaerber@suse.de, ehabkost@redhat.com

On Fri, Dec 30, 2016 at 03:33:11PM +0100, Igor Mammedov wrote:
> 'hotplugged' propperty is meant to be used on migration side when migrating
> source with hotplugged devices.
> However though it not exacly correct usage of 'hotplugged' property
> it's possible to set generic hotplugged property for CPU using
>  -cpu foo,hotplugged=on
> or
>  -global foo.hotplugged=on
> 
> in this case qemu crashes with following backtrace:
> 
> ...
> 
> because pc_cpu_plug() assumes that hotplugged CPU could appear only after
> rtc/fw_cfg are initialized.
> Fix crash by replacing assumption with explicit checks of rtc/fw_cfg
> and updating them only if they were initialized.
> 
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> Reported-by: Eduardo Habkost <ehabkost@redhat.com>

Looks like Paolo is merging this.

Reviewed-by: Michael S. Tsirkin <mst@redhat.com>

> ---
>  hw/i386/pc.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index f3d7ad4..7b7e126 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -1810,8 +1810,10 @@ static void pc_cpu_plug(HotplugHandler *hotplug_dev,
>  
>      /* increment the number of CPUs */
>      pcms->boot_cpus++;
> -    if (dev->hotplugged) {
> +    if (pcms->rtc) {
>          rtc_set_cpus_count(pcms->rtc, pcms->boot_cpus);
> +    }
> +    if (pcms->fw_cfg) {
>          fw_cfg_modify_i16(pcms->fw_cfg, FW_CFG_NB_CPUS, pcms->boot_cpus);
>      }
>  
> -- 
> 2.7.4
