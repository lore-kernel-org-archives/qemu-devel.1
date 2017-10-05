Received: from eggs.gnu.org ([2001:4830:134:3::10]:47229)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imbrenda@linux.vnet.ibm.com>) id 1e03MY-0005is-Fc
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 06:26:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imbrenda@linux.vnet.ibm.com>) id 1e03MV-0005Ui-7q
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 06:26:42 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:51970
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imbrenda@linux.vnet.ibm.com>)
	id 1e03MV-0005Ty-2t
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 06:26:39 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v95APgPp114632
	for <qemu-devel@nongnu.org>; Thu, 5 Oct 2017 06:26:35 -0400
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2ddeebngbu-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 05 Oct 2017 06:26:35 -0400
Received: from localhost
	by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <imbrenda@linux.vnet.ibm.com>;
	Thu, 5 Oct 2017 11:26:33 +0100
Date: Thu, 5 Oct 2017 12:26:29 +0200
From: Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>
In-Reply-To: <1507193105-15627-1-git-send-email-thuth@redhat.com>
References: <1507193105-15627-1-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20171005122629.4b76e6de@p-imbrenda.boeblingen.de.ibm.com>
Subject: Re: [Qemu-devel] [PATCH] hw/s390x: Mark the "sclpquiesce" device
 with user_creatable = false
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, David Hildenbrand <david@redhat.com>, Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, Eric Farman <farman@linux.vnet.ibm.com>, Farhan Ali <alifm@linux.vnet.ibm.com>, Fei Li <sherrylf@linux.vnet.ibm.com>, Halil Pasic <pasic@linux.vnet.ibm.com>, Janosch Frank <frankja@linux.vnet.ibm.com>, Jason J Herne <jjherne@linux.vnet.ibm.com>, Jing Liu <liujbjl@linux.vnet.ibm.com>, Pierre Morel <pmorel@linux.vnet.ibm.com>, QingFeng Hao <haoqf@linux.vnet.ibm.com>, Xiao Feng Ren <renxiaof@linux.vnet.ibm.com>, Yang Chen <bjcyang@linux.vnet.ibm.com>, Yi Min Zhao <zyimin@linux.vnet.ibm.com>

On Thu,  5 Oct 2017 10:45:05 +0200
Thomas Huth <thuth@redhat.com> wrote:

> The "sclpquiesce" device is just an internal device that should not be
> created by the user directly. Though it currently does not seem to
> cause any obvious trouble when the user instantiates an additional
> device, let's better mark it with user_creatable = false to avoid
> unexpected behavior, e.g. because the quiesce notifier gets
> registered multiple times.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>


Reviewed-by: Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>

> ---
>  hw/s390x/sclpquiesce.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/s390x/sclpquiesce.c b/hw/s390x/sclpquiesce.c
> index 762cb18..0241643 100644
> --- a/hw/s390x/sclpquiesce.c
> +++ b/hw/s390x/sclpquiesce.c
> @@ -118,8 +118,13 @@ static void quiesce_class_init(ObjectClass
> *klass, void *data) dc->reset = quiesce_reset;
>      dc->vmsd = &vmstate_sclpquiesce;
>      set_bit(DEVICE_CATEGORY_MISC, dc->categories);
> -    k->init = quiesce_init;
> +    /*
> +     * Reason: This is just an internal device - the notifier should
> +     * not be registered multiple times in quiesce_init()
> +     */
> +    dc->user_creatable = false;
> 
> +    k->init = quiesce_init;
>      k->get_send_mask = send_mask;
>      k->get_receive_mask = receive_mask;
>      k->can_handle_event = can_handle_event;
