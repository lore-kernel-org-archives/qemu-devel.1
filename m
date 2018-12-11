Received: from eggs.gnu.org ([2001:4830:134:3::10]:58539)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gWjsP-0006AV-60
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 10:23:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gWjsK-00038U-54
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 10:23:13 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55388)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1gWjsJ-000385-UC
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 10:23:08 -0500
Date: Tue, 11 Dec 2018 16:23:03 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20181211162303.2e581899@redhat.com>
In-Reply-To: <1544469254-11629-1-git-send-email-akrowiak@linux.ibm.com>
References: <1544469254-11629-1-git-send-email-akrowiak@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] qdev/core: Can not replug device on bus
 that allows one device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Tony Krowiak <akrowiak@linux.ibm.com>
Cc: qemu-devel@nongnu.org, thuth@redhat.com, armbru@redhat.com, f4bug@amsat.org, pasic@linux.ibm.com, borntraeger@de.ibm.com, pbonzini@redhat.com

On Mon, 10 Dec 2018 14:14:14 -0500
Tony Krowiak <akrowiak@linux.ibm.com> wrote:

> If the maximum number of devices allowed on a bus is 1 and a device
> which is plugged into the bus is subsequently unplugged, attempting to replug
> the device fails with error "Bus 'xxx' does not support hotplugging".
> The "error" is detected in the qbus_is_full(BusState *bus) function
> (qdev_monitor.c) because bus->max_index >= bus_class->max_dev. The
> root of the problem is that the bus->max_index is not decremented when a device
> is unplugged from the bus. This patch fixes that problem.
> 
> Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
> ---
>  hw/core/qdev.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/hw/core/qdev.c b/hw/core/qdev.c
> index 6b3cc55b27c2..b35b0bf27925 100644
> --- a/hw/core/qdev.c
> +++ b/hw/core/qdev.c
> @@ -59,6 +59,8 @@ static void bus_remove_child(BusState *bus, DeviceState *child)
>              snprintf(name, sizeof(name), "child[%d]", kid->index);
>              QTAILQ_REMOVE(&bus->children, kid, sibling);
>  
> +            bus->max_index--;
that might cause problem when bus is allowed to has more than 1 device
and unplugged device is not the last one.
In that case bus_add_child() might create a child with duplicate name.

> +
>              /* This gives back ownership of kid->child back to us.  */
>              object_property_del(OBJECT(bus), name, NULL);
>              object_unref(OBJECT(kid->child));
