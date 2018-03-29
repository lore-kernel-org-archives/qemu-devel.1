Received: from eggs.gnu.org ([2001:4830:134:3::10]:37674)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1f1TqF-0003yh-BG
	for qemu-devel@nongnu.org; Thu, 29 Mar 2018 05:27:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1f1TqC-00054j-5N
	for qemu-devel@nongnu.org; Thu, 29 Mar 2018 05:27:31 -0400
Date: Thu, 29 Mar 2018 11:27:21 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20180329112721.6c7ee3f3@redhat.com>
In-Reply-To: <152231460685.69730.14860451936216690693.stgit@bahia.lan>
References: <152231456507.69730.15601462044394150786.stgit@bahia.lan>
	<152231460685.69730.14860451936216690693.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/3] hw/s390x: fix memory leak in
 s390_init_ipl_dev()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: qemu-devel@nongnu.org, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Eduardo Habkost <ehabkost@redhat.com>, David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Alexander Graf <agraf@suse.de>, qemu-stable@nongnu.org, qemu-s390x@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>

On Thu, 29 Mar 2018 11:10:06 +0200
Greg Kurz <groug@kaod.org> wrote:

> The string returned by object_property_get_str() is dynamically allocated.
> 
> Fixes: 3c4e9baacf4d9
> Signed-off-by: Greg Kurz <groug@kaod.org>
> ---
>  hw/s390x/s390-virtio-ccw.c |    5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
> index 864145a7c6f3..435f7c99e77c 100644
> --- a/hw/s390x/s390-virtio-ccw.c
> +++ b/hw/s390x/s390-virtio-ccw.c
> @@ -246,6 +246,7 @@ static void s390_init_ipl_dev(const char *kernel_filename,
>  {
>      Object *new = object_new(TYPE_S390_IPL);
>      DeviceState *dev = DEVICE(new);
> +    char *netboot_fw_prop;
>  
>      if (kernel_filename) {
>          qdev_prop_set_string(dev, "kernel", kernel_filename);
> @@ -256,9 +257,11 @@ static void s390_init_ipl_dev(const char *kernel_filename,
>      qdev_prop_set_string(dev, "cmdline", kernel_cmdline);
>      qdev_prop_set_string(dev, "firmware", firmware);
>      qdev_prop_set_bit(dev, "enforce_bios", enforce_bios);
> -    if (!strlen(object_property_get_str(new, "netboot_fw", &error_abort))) {
> +    netboot_fw_prop = object_property_get_str(new, "netboot_fw", &error_abort);
> +    if (!strlen(netboot_fw_prop)) {
probably not really issue here but,
is strlen really safe in case netboot_fw_prop == NULL?

>          qdev_prop_set_string(dev, "netboot_fw", netboot_fw);
>      }
> +    g_free(netboot_fw_prop);
>      object_property_add_child(qdev_get_machine(), TYPE_S390_IPL,
>                                new, NULL);
>      object_unref(new);
> 
> 
