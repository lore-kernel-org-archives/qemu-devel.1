Received: from eggs.gnu.org ([2001:4830:134:3::10]:51200)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1dzl6Z-0000xH-LO
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 10:57:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1dzl6V-0007dN-L7
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 10:56:59 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:40514
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.vnet.ibm.com>)
	id 1dzl6V-0007cT-Ev
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 10:56:55 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v94Esjju049653
	for <qemu-devel@nongnu.org>; Wed, 4 Oct 2017 10:56:52 -0400
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2dcx5mptak-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 04 Oct 2017 10:56:51 -0400
Received: from localhost
	by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.vnet.ibm.com>;
	Wed, 4 Oct 2017 15:56:49 +0100
References: <1507125199-22562-1-git-send-email-thuth@redhat.com>
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Wed, 4 Oct 2017 16:56:46 +0200
MIME-Version: 1.0
In-Reply-To: <1507125199-22562-1-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <65835b70-98da-f8aa-15f6-e893947b5eb0@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH] hw/s390x/sclp: Mark the sclp device with
 user_creatable = false
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Eric Farman <farman@linux.vnet.ibm.com>, Janosch Frank <frankja@linux.vnet.ibm.com>, Yi Min Zhao <zyimin@linux.vnet.ibm.com>, Jason J Herne <jjherne@linux.vnet.ibm.com>, Pierre Morel <pmorel@linux.vnet.ibm.com>, Farhan Ali <alifm@linux.vnet.ibm.com>, Jing Liu <liujbjl@linux.vnet.ibm.com>, Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>, QingFeng Hao <haoqf@linux.vnet.ibm.com>, Xiao Feng Ren <renxiaof@linux.vnet.ibm.com>, Fei Li <sherrylf@linux.vnet.ibm.com>, Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, Yang Chen <bjcyang@linux.vnet.ibm.com>



On 10/04/2017 03:53 PM, Thomas Huth wrote:
> The "sclp" device is just an internal device that can not be instantiated
> by the users. If they try to use it, they only get a simple error message:
> 
> $ qemu-system-s390x -nographic -device sclp
> qemu-system-s390x: Option '-device s390-sclp-event-facility' cannot be
> handled by this machine
> 
> Since sclp_init() tries to create a TYPE_SCLP_EVENT_FACILITY which is
> a non-pluggable sysbus device, there is really no way that the "sclp"
> device can be used by the user, so let's set the user_creatable = false
> accordingly.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> 

While I'm not really familiar with the sclp code, I do understand the
measure (user_creatable = false), but I'm not sure I understand the
explanation. So it's:

Acked-by: Halil Pasic <pasic@linux.vnet.ibm.com>

---
>  hw/s390x/sclp.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/hw/s390x/sclp.c b/hw/s390x/sclp.c
> index 30aefbf..9be0cb8 100644
> --- a/hw/s390x/sclp.c
> +++ b/hw/s390x/sclp.c
> @@ -606,6 +606,11 @@ static void sclp_class_init(ObjectClass *oc, void *data)
>      dc->realize = sclp_realize;
>      dc->hotpluggable = false;
>      set_bit(DEVICE_CATEGORY_MISC, dc->categories);
> +    /*
> +     * Reason: Creates TYPE_SCLP_EVENT_FACILITY in sclp_init
> +     * which is a non-pluggable sysbus device
> +     */
> +    dc->user_creatable = false;
> 
>      sc->read_SCP_info = read_SCP_info;
>      sc->read_storage_element0_info = read_storage_element0_info;
> 
