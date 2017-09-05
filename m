Received: from eggs.gnu.org ([2001:4830:134:3::10]:37631)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1dp9we-0005lE-7W
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 05:15:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1dp9wZ-0004Qu-IX
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 05:14:56 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:40259)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1dp9wZ-0004PP-9d
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 05:14:51 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v859E2tE025500
	for <qemu-devel@nongnu.org>; Tue, 5 Sep 2017 05:14:50 -0400
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2csqt5mx8c-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 05 Sep 2017 05:14:49 -0400
Received: from localhost
	by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Tue, 5 Sep 2017 10:14:47 +0100
References: <20170904154316.4148-1-david@redhat.com>
	<20170904154316.4148-18-david@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Tue, 5 Sep 2017 11:14:43 +0200
MIME-Version: 1.0
In-Reply-To: <20170904154316.4148-18-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <f162eece-8dd0-a8e9-f339-356465ab6587@de.ibm.com>
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
Cc: Richard Henderson <richard.henderson@linaro.org>, thuth@redhat.com, cohuck@redhat.com, Alexander Graf <agraf@suse.de>, Eduardo Habkost <ehabkost@redhat.com>

On 09/04/2017 05:43 PM, David Hildenbrand wrote:
> device_del on a CPU will currently do nothing. Let's emmit an error
> telling that this is will never work (there is no architecture support
> on s390x). Error message copied from ppc.
> 
> (qemu) device_del cpu1
> device_del cpu1
> CPU hot unplug not supported on this machine

Given the fact that I get the question about unplug _every_ time when I give a presentation
about KVM on z, I will try to get some architecture folks look at this. Maybe we can define
something very simple like "if the CPU is in the stopped state we can remove this and just
piggy back on the existing sclp EVENT_QUAL_CPU_CHANGE notification".

So maybe add  "currently"


> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
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
