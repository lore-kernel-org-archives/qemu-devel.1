Received: from eggs.gnu.org ([2001:4830:134:3::10]:47645)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1e002q-00066v-El
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 02:54:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1e002k-0000MO-KJ
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 02:54:08 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:37990)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1e002k-0000Ji-Bu
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 02:54:02 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v956roOq019861
	for <qemu-devel@nongnu.org>; Thu, 5 Oct 2017 02:53:58 -0400
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2dded3vmff-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 05 Oct 2017 02:53:57 -0400
Received: from localhost
	by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Thu, 5 Oct 2017 07:53:55 +0100
References: <20171004154647.7572-1-cohuck@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Thu, 5 Oct 2017 08:53:52 +0200
MIME-Version: 1.0
In-Reply-To: <20171004154647.7572-1-cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <89443191-54ac-1627-4559-1bf82963b491@de.ibm.com>
Subject: Re: [Qemu-devel] [PATCH] s390x/sclp: mark sclp-cpu-hotplug as
 non-usercreatable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org
Cc: agraf@suse.de, rth@twiddle.net, thuth@redhat.com

On 10/04/2017 05:46 PM, Cornelia Huck wrote:
> A TYPE_SCLP_CPU_HOTPLUG device for handling cpu hotplug events
> is already created by the sclp event facility. Adding a second
> TYPE_SCLP_CPU_HOTPLUG device via -device sclp-cpu-hotplug creates
> an ambiguity in raise_irq_cpu_hotplug(), leading to a crash once
> a cpu is hotplugged.
> 
> To fix this, disallow creating a sclp-cpu-hotplug device manually.
> 
> Signed-off-by: Cornelia Huck <cohuck@redhat.com>

Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>

Most of these missing user_create things stem from a time of qdev.no_user
which was then later deprecated and replaced with cannot_instantiate_with_device_add_yet
It was supposed to be a temporary measure but now we all know that there ARE devices
which are not user_creatable.
    
So its good to get this all fixed.

> ---
>  hw/s390x/sclpcpu.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/hw/s390x/sclpcpu.c b/hw/s390x/sclpcpu.c
> index 023d059a46..3ee890b392 100644
> --- a/hw/s390x/sclpcpu.c
> +++ b/hw/s390x/sclpcpu.c
> @@ -82,6 +82,12 @@ static void cpu_class_init(ObjectClass *oc, void *data)
>      k->get_receive_mask = receive_mask;
>      k->read_event_data = read_event_data;
>      set_bit(DEVICE_CATEGORY_MISC, dc->categories);
> +    /*
> +     * Reason: raise_irq_cpu_hotplug() depends on an unique
> +     * TYPE_SCLP_CPU_HOTPLUG device, which is already created
> +     * by the sclp event facility
> +     */
> +    dc->user_creatable = false;
>  }
> 
>  static const TypeInfo sclp_cpu_info = {
> 
