Received: from eggs.gnu.org ([2001:4830:134:3::10]:36095)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mihajlov@linux.vnet.ibm.com>) id 1eqfI2-0001ab-Jk
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 08:27:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mihajlov@linux.vnet.ibm.com>) id 1eqfHz-0002by-Nu
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 08:27:30 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:53280
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mihajlov@linux.vnet.ibm.com>)
	id 1eqfHz-0002bY-IA
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 08:27:27 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w1RDOUWe105753
	for <qemu-devel@nongnu.org>; Tue, 27 Feb 2018 08:27:27 -0500
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2gd4hu9j7w-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 27 Feb 2018 08:27:26 -0500
Received: from localhost
	by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mihajlov@linux.vnet.ibm.com>;
	Tue, 27 Feb 2018 13:27:24 -0000
References: <1519731154-3127-1-git-send-email-thuth@redhat.com>
From: Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>
Date: Tue, 27 Feb 2018 14:27:19 +0100
MIME-Version: 1.0
In-Reply-To: <1519731154-3127-1-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Message-Id: <a4f94596-0ea9-a7bc-9603-bb8690d39e25@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH] hw/s390x: Add the possibility to specify
 the netboot image on the command line
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, Cornelia Huck <cohuck@redhat.com>, qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, David Hildenbrand <david@redhat.com>

On 27.02.2018 12:32, Thomas Huth wrote:
> The file name of the netboot binary is currently hard-coded to
> "s390-netboot.img", without a possibility for the user to select
> an alternative firmware image here. That's unfortunate, especially
> since the basics are already there: The filename is a property of
> the s390-ipl device. So we just have to add a check whether the user
> already provided the property and only set the default if the string
> is still empty. Now it is possible to select a different firmware
> image with "-global s390-ipl.netboot_fw=/path/to/s390-netboot.img".
> While I sympathize with the concept, it will be a bit hard to consume
since most of the QEMU instances will be started by libvirt and that has
no provisions for this kind of firmware replacement. We could craft some
s390-specific variety of the <loader> element.
Another thing to consider is that, while the current netboot firmware
doesn't rely on any special QEMU <-> loader interfaces, it might happen
that QEMU and the network firmware must match similar to QEMU and the
s390-ccw firmware image and I have no idea on how to ensure that.
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  hw/s390x/s390-virtio-ccw.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
> index 4abbe89..7b3fb5f 100644
> --- a/hw/s390x/s390-virtio-ccw.c
> +++ b/hw/s390x/s390-virtio-ccw.c
> @@ -254,8 +254,10 @@ static void s390_init_ipl_dev(const char *kernel_filename,
>      }
>      qdev_prop_set_string(dev, "cmdline", kernel_cmdline);
>      qdev_prop_set_string(dev, "firmware", firmware);
Wouldn't it be consequent to allow firmware replacement? But then, see
above.
> -    qdev_prop_set_string(dev, "netboot_fw", netboot_fw);
>      qdev_prop_set_bit(dev, "enforce_bios", enforce_bios);
> +    if (!strlen(object_property_get_str(new, "netboot_fw", &error_abort))) {
> +        qdev_prop_set_string(dev, "netboot_fw", netboot_fw);
> +    }
>      object_property_add_child(qdev_get_machine(), TYPE_S390_IPL,
>                                new, NULL);
>      object_unref(new);
> 


-- 
Regards,
 Viktor Mihajlovski
