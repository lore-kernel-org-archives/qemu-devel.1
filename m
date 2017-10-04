Received: from eggs.gnu.org ([2001:4830:134:3::10]:50548)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dzmEn-0000bk-1C
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 12:09:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dzmEi-0006QK-WF
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 12:09:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40124)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dzmEi-0006Pb-PE
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 12:09:28 -0400
References: <20171004154647.7572-1-cohuck@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <12b2d415-6c40-d617-d883-a43680636b9a@redhat.com>
Date: Wed, 4 Oct 2017 18:09:23 +0200
MIME-Version: 1.0
In-Reply-To: <20171004154647.7572-1-cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
Cc: borntraeger@de.ibm.com, agraf@suse.de, rth@twiddle.net

On 04.10.2017 17:46, Cornelia Huck wrote:
> A TYPE_SCLP_CPU_HOTPLUG device for handling cpu hotplug events
> is already created by the sclp event facility. Adding a second
> TYPE_SCLP_CPU_HOTPLUG device via -device sclp-cpu-hotplug creates
> an ambiguity in raise_irq_cpu_hotplug(), leading to a crash once
> a cpu is hotplugged.
> 
> To fix this, disallow creating a sclp-cpu-hotplug device manually.
> 
> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
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

Reviewed-by: Thomas Huth <thuth@redhat.com>
