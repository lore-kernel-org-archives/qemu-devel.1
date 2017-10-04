Received: from eggs.gnu.org ([2001:4830:134:3::10]:34549)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dzhZe-0007QQ-4Z
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 07:10:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dzhZZ-0007Px-5e
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 07:10:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58010)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1dzhZY-0007NS-Ua
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 07:10:41 -0400
Date: Wed, 4 Oct 2017 13:10:35 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20171004131035.42ccafe3.cohuck@redhat.com>
In-Reply-To: <20171004110109.16525-1-pasic@linux.vnet.ibm.com>
References: <20171004110109.16525-1-pasic@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/1] s390x/css: fix css migration compat
 handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Halil Pasic <pasic@linux.vnet.ibm.com>
Cc: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, Christian Borntraeger <borntraeger@de.ibm.com>

On Wed,  4 Oct 2017 13:01:09 +0200
Halil Pasic <pasic@linux.vnet.ibm.com> wrote:

> Commit e996583eb3 ("s390x/css: activate ChannelSubSys migration",
> 2017-07-11) was supposed to enable css migration for virtio-ccw
> machines starting 2.10, but it ended up effectively enabling it
> only for 2.10 as the registration of the appropriate VMStateDescription
> happens in ccw_machine_2_10_instance_options which does not get
> called for machines more recent than 2_10.
> 
> Let us move the corresponding chunk of code (which conditionally enables
> the migration based on the value of the corresponding class property) to
> a ccw_init, which is called for each virtio-ccw machine instance.

s/a//

> 
> Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
> Reported-by: Thomas Huth <thuth@redhat.com>
> ---
>  hw/s390x/s390-virtio-ccw.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
> index fafbc6d4fe..3b5dfdb48d 100644
> --- a/hw/s390x/s390-virtio-ccw.c
> +++ b/hw/s390x/s390-virtio-ccw.c
> @@ -313,6 +313,9 @@ static void ccw_init(MachineState *machine)
>          ret = css_create_css_image(VIRTUAL_CSSID, true);
>      }
>      assert(ret == 0);
> +    if (css_migration_enabled()) {
> +        css_register_vmstate();
> +    }
>  
>      /* Create VirtIO network adapters */
>      s390_create_virtio_net(BUS(css_bus), "virtio-net-ccw");
> @@ -731,9 +734,6 @@ DEFINE_CCW_MACHINE(2_11, "2.11", true);
>  static void ccw_machine_2_10_instance_options(MachineState *machine)
>  {
>      ccw_machine_2_11_instance_options(machine);
> -    if (css_migration_enabled()) {
> -        css_register_vmstate();
> -    }
>  }
>  
>  static void ccw_machine_2_10_class_options(MachineClass *mc)

Looks sane.

Out of curiosity: Which machine types did you test migration for?
