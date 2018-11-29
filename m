Received: from eggs.gnu.org ([2001:4830:134:3::10]:60756)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gSQYZ-0007dm-9F
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 12:56:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gSQYV-0003Ia-TD
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 12:56:55 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20181106102335.20027-1-kraxel@redhat.com>
	<20181106102335.20027-5-kraxel@redhat.com>
Date: Thu, 29 Nov 2018 18:56:43 +0100
In-Reply-To: <20181106102335.20027-5-kraxel@redhat.com> (Gerd Hoffmann's
	message of "Tue, 6 Nov 2018 11:23:33 +0100")
Message-ID: <87a7lr6a3o.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
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
Cc: qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, "Michael
	S. Tsirkin" <mst@redhat.com>, Alexander Graf <agraf@suse.de>, Markus Armbruster <armbru@redhat.com>, =?utf-8?Q?Herv=C3=A9?= Poussineau <hpoussin@reactos.org>, qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Andreas =?utf-8?Q?F=C3=A4rber?= <afaerber@suse.de>, David Gibson <david@gibson.dropbear.id.au>

Gerd Hoffmann <kraxel@redhat.com> writes:

> Print a warning for deprecated and obsolete devices.
> Also add support state to device listing.
>
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
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

Looks like this:

    $ qemu-system-x86_64 -nodefaults -S -display none -device cirrus-vga
    qemu-system-x86_64: -device cirrus-vga: warning: device cirrus-vga is obsolete (use "-vga std" instead, see https://www.kraxel.org/blog/2014/10/qemu-using-cirrus-considered-harmful/)

I'd prefer:

    $ qemu-system-x86_64 -nodefaults -S -display none -device cirrus-vga
    qemu-system-x86_64: -device cirrus-vga: warning: device cirrus-vga is obsolete
    Use "-vga std" instead, see
    https://www.kraxel.org/blog/2014/10/qemu-using-cirrus-considered-harmful/

The obvious way to get it:

   void warn_support_state(const char *type, const char *name,
                           ObjectClass *oc)
   {
       const char *help = oc->supported.help;

       warn_report("%s %s is %s", type, name,
                   SupportState_str(oc->supported.state));
       if (help) {
           error_printf("%s\n", help);
       }
   }

with the ->help suitably capitalized and formatted.

That should make qemu_warn_support_state() usable for the previous
patch, too.

Note I scratched the qemu_ prefix.  Matter of taste, I guess.


> +    }
>      dev = DEVICE(object_new(type));
>      if (!dev) {
>          return NULL;
[...]
