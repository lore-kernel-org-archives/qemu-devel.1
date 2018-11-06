Received: from eggs.gnu.org ([2001:4830:134:3::10]:55178)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gK2TM-0003CE-0L
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 09:36:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gK2TH-0005Be-PV
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 09:36:51 -0500
Date: Tue, 6 Nov 2018 09:36:44 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20181106093502-mutt-send-email-mst@kernel.org>
References: <20181106102335.20027-1-kraxel@redhat.com>
	<20181106102335.20027-5-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181106102335.20027-5-kraxel@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 4/6] Warn on obsolete and deprecated
 devices.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Alexander Graf <agraf@suse.de>, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, David Gibson <david@gibson.dropbear.id.au>, Eric Blake <eblake@redhat.com>, qemu-ppc@nongnu.org, Richard Henderson <rth@twiddle.net>, Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>, Markus Armbruster <armbru@redhat.com>, =?iso-8859-1?Q?Herv=E9?= Poussineau <hpoussin@reactos.org>

On Tue, Nov 06, 2018 at 11:23:33AM +0100, Gerd Hoffmann wrote:
> Print a warning for deprecated and obsolete devices.
> Also add support state to device listing.
> 
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>

Should we also add a runtime flag to block these?
E.g. I can see libvirt doing that and passing
the responsibility for what is reasonably
supported to qemu.

> ---
>  hw/core/qdev.c | 8 +++++++-
>  qdev-monitor.c | 9 +++++++++
>  2 files changed, 16 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/core/qdev.c b/hw/core/qdev.c
> index 6b3cc55b27..6205522c3e 100644
> --- a/hw/core/qdev.c
> +++ b/hw/core/qdev.c
> @@ -133,11 +133,17 @@ DeviceState *qdev_create(BusState *bus, const char *name)
>  
>  DeviceState *qdev_try_create(BusState *bus, const char *type)
>  {
> +    ObjectClass *oc;
>      DeviceState *dev;
>  
> -    if (object_class_by_name(type) == NULL) {
> +    oc = object_class_by_name(type);
> +    if (oc == NULL) {
>          return NULL;
>      }
> +    if (qemu_is_deprecated(oc) ||
> +        qemu_is_obsolete(oc)) {
> +        qemu_warn_support_state("device", type, oc);
> +    }
>      dev = DEVICE(object_new(type));
>      if (!dev) {
>          return NULL;
> diff --git a/qdev-monitor.c b/qdev-monitor.c
> index 802c18a74e..80370372f9 100644
> --- a/qdev-monitor.c
> +++ b/qdev-monitor.c
> @@ -115,6 +115,8 @@ static void out_printf(const char *fmt, ...)
>  
>  static void qdev_print_devinfo(DeviceClass *dc)
>  {
> +    ObjectClass *oc = OBJECT_CLASS(dc);
> +
>      out_printf("name \"%s\"", object_class_get_name(OBJECT_CLASS(dc)));
>      if (dc->bus_type) {
>          out_printf(", bus %s", dc->bus_type);
> @@ -128,6 +130,9 @@ static void qdev_print_devinfo(DeviceClass *dc)
>      if (!dc->user_creatable) {
>          out_printf(", no-user");
>      }
> +    if (oc->supported.state != SUPPORT_STATE_UNSPECIFIED) {
> +        out_printf(", %s", SupportState_str(oc->supported.state));
> +    }
>      out_printf("\n");
>  }
>  
> @@ -579,6 +584,10 @@ DeviceState *qdev_device_add(QemuOpts *opts, Error **errp)
>      if (!dc) {
>          return NULL;
>      }
> +    if (qemu_is_deprecated(OBJECT_CLASS(dc)) ||
> +        qemu_is_obsolete(OBJECT_CLASS(dc))) {
> +        qemu_warn_support_state("device", driver, OBJECT_CLASS(dc));
> +    }
>  
>      /* find bus */
>      path = qemu_opt_get(opts, "bus");
> -- 
> 2.9.3
