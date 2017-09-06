Received: from eggs.gnu.org ([2001:4830:134:3::10]:48373)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjrosato@linux.vnet.ibm.com>) id 1dpepb-0001Tw-UU
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 14:13:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjrosato@linux.vnet.ibm.com>) id 1dpepX-0003er-UE
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 14:13:43 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:54225
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mjrosato@linux.vnet.ibm.com>)
	id 1dpepX-0003ed-O8
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 14:13:39 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v86I8m2U062807
	for <qemu-devel@nongnu.org>; Wed, 6 Sep 2017 14:13:39 -0400
Received: from e19.ny.us.ibm.com (e19.ny.us.ibm.com [129.33.205.209])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2cth6xpbw3-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 06 Sep 2017 14:13:38 -0400
Received: from localhost
	by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mjrosato@linux.vnet.ibm.com>;
	Wed, 6 Sep 2017 14:13:38 -0400
References: <20170904154316.4148-1-david@redhat.com>
	<20170904154316.4148-18-david@redhat.com>
From: Matthew Rosato <mjrosato@linux.vnet.ibm.com>
Date: Wed, 6 Sep 2017 14:13:34 -0400
MIME-Version: 1.0
In-Reply-To: <20170904154316.4148-18-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <40d23c4e-2761-24ae-5f5a-3db9b478ffd2@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v2 17/19] s390x: CPU hot unplug via
 device_del cannot work
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
Cc: thuth@redhat.com, Eduardo Habkost <ehabkost@redhat.com>, cohuck@redhat.com, Richard Henderson <richard.henderson@linaro.org>, Alexander Graf <agraf@suse.de>, borntraeger@de.ibm.com

On 09/04/2017 11:43 AM, David Hildenbrand wrote:
> device_del on a CPU will currently do nothing. Let's emmit an error
> telling that this is will never work (there is no architecture support
> on s390x). Error message copied from ppc.
> 
> (qemu) device_del cpu1
> device_del cpu1
> CPU hot unplug not supported on this machine
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>

Architecture discussions aside, this code will work as-is to prevent CPU
unplug.  Add "currently" as Christian suggests and:

Reviewed-by: Matthew Rosato <mjrosato@linux.vnet.ibm.com>

> ---
>  hw/s390x/s390-virtio-ccw.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
> index 22a8a1b45d..dd149567bb 100644
> --- a/hw/s390x/s390-virtio-ccw.c
> +++ b/hw/s390x/s390-virtio-ccw.c
> @@ -338,6 +338,15 @@ static void s390_machine_device_plug(HotplugHandler *hotplug_dev,
>      }
>  }
> 
> +static void s390_machine_device_unplug_request(HotplugHandler *hotplug_dev,
> +                                               DeviceState *dev, Error **errp)
> +{
> +    if (object_dynamic_cast(OBJECT(dev), TYPE_CPU)) {
> +        error_setg(errp, "CPU hot unplug not supported on this machine");
> +        return;
> +    }
> +}
> +
>  static HotplugHandler *s390_get_hotplug_handler(MachineState *machine,
>                                                  DeviceState *dev)
>  {
> @@ -387,6 +396,7 @@ static void ccw_machine_class_init(ObjectClass *oc, void *data)
>      mc->max_cpus = 248;
>      mc->get_hotplug_handler = s390_get_hotplug_handler;
>      hc->plug = s390_machine_device_plug;
> +    hc->unplug_request = s390_machine_device_unplug_request;
>      nc->nmi_monitor_handler = s390_nmi;
>  }
> 
