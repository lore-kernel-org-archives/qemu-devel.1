Received: from eggs.gnu.org ([2001:4830:134:3::10]:50150)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cr9nN-0000yx-23
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 16:57:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cr9nI-00056F-2m
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 16:57:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49916)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1cr9nH-00055v-Td
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 16:57:16 -0400
Date: Thu, 23 Mar 2017 17:57:08 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170323205708.GA32071@thinpad.lan.raisama.net>
References: <20161122061059.26058-1-jgross@suse.com>
	<20161122061059.26058-4-jgross@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20161122061059.26058-4-jgross@suse.com>
Subject: Re: [Qemu-devel] [PATCH v3 3/4] xen: create qdev for each backend
 device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juergen Gross <jgross@suse.com>
Cc: qemu-devel@nongnu.org, xen-devel@lists.xensource.com, anthony.perard@citrix.com, sstabellini@kernel.org, kraxel@redhat.com, armbru@redhat.com, Marcel Apfelbaum <marcel@redhat.com>

Hi,

I am reviewing the existing code that sets has_dynamic_sysbus,
and this patch confused me. I have a question below:

On Tue, Nov 22, 2016 at 07:10:58AM +0100, Juergen Gross wrote:
> Create a qdev plugged to the xen-sysbus for each new backend device.
> This device can be used as a parent for all needed devices of that
> backend. The id of the new device will be "xen-<type>-<dev>" with
> <type> being the xen backend type (e.g. "qdisk") and <dev> the xen
> backend number of the type under which it is to be found in xenstore.
> 
> Signed-off-by: Juergen Gross <jgross@suse.com>
> Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>
> ---
>  hw/xen/xen_backend.c         | 47 ++++++++++++++++++++++++++++++++++++++++++++
>  hw/xen/xen_pvdev.c           |  4 +++-
>  include/hw/xen/xen_backend.h |  4 ++++
>  include/hw/xen/xen_pvdev.h   |  1 +
>  4 files changed, 55 insertions(+), 1 deletion(-)
> 
[...]
> +static void xen_set_dynamic_sysbus(void)
> +{
> +    Object *machine = qdev_get_machine();
> +    ObjectClass *oc = object_get_class(machine);
> +    MachineClass *mc = MACHINE_CLASS(oc);
> +
> +    mc->has_dynamic_sysbus = true;
> +}
> +

Why exactly is this code necessary? I assume there's no current
use case for "-device xen-sysdev" and "-device xen-backend",
correct? The devices created by C code like xen_be_get_xendev()
aren't supposed to be returned by
foreach_dynamic_sysbus_device().


>  int xen_be_register(const char *type, struct XenDevOps *ops)
>  {
>      char path[50];
> @@ -562,6 +579,8 @@ int xen_be_register(const char *type, struct XenDevOps *ops)
>  
>  void xen_be_register_common(void)
>  {
> +    xen_set_dynamic_sysbus();
> +
>      xen_be_register("console", &xen_console_ops);
>      xen_be_register("vkbd", &xen_kbdmouse_ops);
>      xen_be_register("qdisk", &xen_blkdev_ops);
[...]

-- 
Eduardo
