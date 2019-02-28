Received: from eggs.gnu.org ([209.51.188.92]:52153)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gzQcJ-0000XW-Hc
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 13:41:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gzQcI-0006Om-DL
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 13:41:11 -0500
References: <20190226045304.25618-1-david@gibson.dropbear.id.au>
	<20190226045304.25618-41-david@gibson.dropbear.id.au>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <ec8e11d1-c966-b814-98da-a6ab56572834@redhat.com>
Date: Thu, 28 Feb 2019 19:40:52 +0100
MIME-Version: 1.0
In-Reply-To: <20190226045304.25618-41-david@gibson.dropbear.id.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL 40/50] spapr_events: add support for phb
 hotplug events
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: lvivier@redhat.com, gkurz@kaod.org, Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-devel@nongnu.org, Greg Kurz <groug@kaod.org>, qemu-ppc@nongnu.org, clg@kaod.org

On 26/02/2019 05.52, David Gibson wrote:
> From: Michael Roth <mdroth@linux.vnet.ibm.com>
> 
> Extend the existing EPOW event format we use for PCI
> devices to emit PHB plug/unplug events.
> 
> Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
> Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
> Signed-off-by: Greg Kurz <groug@kaod.org>
> Message-Id: <155059671405.1466090.535964535260503283.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> ---
>  hw/ppc/spapr_events.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/hw/ppc/spapr_events.c b/hw/ppc/spapr_events.c
> index b9c7ecb9e9..ab9a1f0063 100644
> --- a/hw/ppc/spapr_events.c
> +++ b/hw/ppc/spapr_events.c
> @@ -526,6 +526,9 @@ static void spapr_hotplug_req_event(uint8_t hp_id, uint8_t hp_action,
>      case SPAPR_DR_CONNECTOR_TYPE_CPU:
>          hp->hotplug_type = RTAS_LOG_V6_HP_TYPE_CPU;
>          break;
> +    case SPAPR_DR_CONNECTOR_TYPE_PHB:
> +        hp->hotplug_type = RTAS_LOG_V6_HP_TYPE_PHB;
> +        break;
>      default:
>          /* we shouldn't be signaling hotplug events for resources
>           * that don't support them

I think this patch (or something else in this PULL request) broke CPU
hot-plugging with older machine types:

$ QTEST_QEMU_BINARY=ppc64-softmmu/qemu-system-ppc64 ./tests/cpu-plug-test -m=slow
/ppc64/cpu-plug/pseries-3.1/device-add/2x3x1&maxcpus=6: OK
/ppc64/cpu-plug/pseries-2.12-sxxm/device-add/2x3x1&maxcpus=6: OK
/ppc64/cpu-plug/pseries-3.0/device-add/2x3x1&maxcpus=6: OK
/ppc64/cpu-plug/pseries-2.10/device-add/2x3x1&maxcpus=6: OK
/ppc64/cpu-plug/pseries-2.11/device-add/2x3x1&maxcpus=6: OK
/ppc64/cpu-plug/pseries-2.12/device-add/2x3x1&maxcpus=6: OK
/ppc64/cpu-plug/pseries-2.9/device-add/2x3x1&maxcpus=6: OK
/ppc64/cpu-plug/pseries-2.7/device-add/2x3x1&maxcpus=6: **
ERROR:/home/thuth/devel/qemu/hw/ppc/spapr_events.c:313:rtas_event_log_to_source: assertion failed: (source->enabled)
Broken pipe
/home/thuth/devel/qemu/tests/libqtest.c:143: kill_qemu() detected QEMU death from signal 6 (Aborted) (core dumped)
Aborted (core dumped)

Could you please have a look?

 Thomas
