Received: from eggs.gnu.org ([2001:4830:134:3::10]:41381)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1cDvPF-0001Pg-JS
	for qemu-devel@nongnu.org; Mon, 05 Dec 2016 10:42:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1cDvPA-0001k1-6e
	for qemu-devel@nongnu.org; Mon, 05 Dec 2016 10:42:17 -0500
Received: from 001b2d01.pphosted.com ([148.163.156.1]:53873
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cornelia.huck@de.ibm.com>)
	id 1cDvP9-0001hi-Sv
	for qemu-devel@nongnu.org; Mon, 05 Dec 2016 10:42:12 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
	uB5Fefvu072397
	for <qemu-devel@nongnu.org>; Mon, 5 Dec 2016 10:42:09 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2758u5s7at-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 05 Dec 2016 10:42:09 -0500
Received: from localhost
	by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <cornelia.huck@de.ibm.com>;
	Mon, 5 Dec 2016 15:42:06 -0000
Date: Mon, 5 Dec 2016 16:42:00 +0100
From: Cornelia Huck <cornelia.huck@de.ibm.com>
In-Reply-To: <148095126363.31351.4484514300033863622.stgit@bahia>
References: <148095126363.31351.4484514300033863622.stgit@bahia>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20161205164200.49bec0f6.cornelia.huck@de.ibm.com>
Subject: Re: [Qemu-devel] [PATCH for-2.8] qdev: apply global properties in
 reverse order
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>, qemu-stable@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On Mon, 05 Dec 2016 16:21:22 +0100
Greg Kurz <groug@kaod.org> wrote:

> The current code recursively applies global properties from child up to
> parent. So, if you have:
> 
> -global virtio-pci.disable-modern=on
> -global virtio-blk-pci.disable-modern=off
> 
> Then the default value of disable-modern for a virtio-blk-pci device is on,
> which looks wrong from an OOP perspective.
> 
> This patch reverses the logic, so that a child property always prevail.

This sounds reasonable...

> 
> This fixes a subtle bug that got introduced in 2.7 with commit "9a4c0e220d8a
> hw/virtio-pci: fix virtio behaviour" for older (< 2.7) machine types: the
> HW_COMPAT_2_6 macro contains global virtio-pci.disable-* properties which
> would silently override global properties passed on the command line for
> virtio subtypes.
> 
> Signed-off-by: Greg Kurz <groug@kaod.org>
> ---
> 
> AFAIK, libvirt's XML doesn't know about modern/legacy modes for virtio
> devices. Early adopters of virtio 1.0 had to rely on the <qemu:commandline>
> tag to pass global properties to QEMU. This patch ensures that XML files
> used with older machine types remain valid with newer versions of QEMU.
> 
> FWIW I guess it could help to have this fix in 2.8, and also probably in
> 2.7.1.

...but I'm a bit worried about doing that change this late in the
cycle, as we may introduce subtle changes for other configurations. At
the very least, we should look over the existing backwards compat
properties (I'll look at those I'm familiar with).

> 
> Please advise.
> 
>  hw/core/qdev-properties.c |   11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
> index 2a8276806721..1345f489d6b1 100644
> --- a/hw/core/qdev-properties.c
> +++ b/hw/core/qdev-properties.c
> @@ -1119,11 +1119,20 @@ static void qdev_prop_set_globals_for_type(DeviceState *dev,
>  void qdev_prop_set_globals(DeviceState *dev)
>  {
>      ObjectClass *class = object_get_class(OBJECT(dev));
> +    GSList *class_list = NULL;
> 
>      do {
> -        qdev_prop_set_globals_for_type(dev, object_class_get_name(class));
> +        class_list = g_slist_prepend(class_list, class);
>          class = object_class_get_parent(class);
>      } while (class);
> +
> +    do {
> +        GSList *head = class_list;
> +
> +        qdev_prop_set_globals_for_type(dev, object_class_get_name(head->data));
> +        class_list = g_slist_next(head);
> +        g_slist_free_1(head);
> +    } while (class_list);
>  }
> 
>  /* --- 64bit unsigned int 'size' type --- */
> 

It is a bit unfortunate that we need a double loop here, but I don't
see any good alternative.
