Received: from eggs.gnu.org ([2001:4830:134:3::10]:48765)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cEYG9-0007gI-QL
	for qemu-devel@nongnu.org; Wed, 07 Dec 2016 04:11:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cEYG6-0003KH-0N
	for qemu-devel@nongnu.org; Wed, 07 Dec 2016 04:11:29 -0500
Date: Wed, 7 Dec 2016 09:11:18 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20161207091118.GB21167@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <1481055300-14239-1-git-send-email-mdroth@linux.vnet.ibm.com>
	<1481055300-14239-2-git-send-email-mdroth@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1481055300-14239-2-git-send-email-mdroth@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH for-2.8 1/2] monitor: fix object_del for
 command-line-created objects
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Roth <mdroth@linux.vnet.ibm.com>
Cc: qemu-devel@nongnu.org, david@gibson.dropbear.id.au, bharata.rao@gmail.com, dgilbert@redhat.com, armbru@redhat.com, Eric Blake <eblake@redhat.com>, qemu-stable@nongnu.org

On Tue, Dec 06, 2016 at 02:14:59PM -0600, Michael Roth wrote:
> Currently objects specified on the command-line are only partially
> cleaned up when 'object_del' is issued in either HMP or QMP: the
> object itself is fully finalized, but the QemuOpts are not removed.
> This results in the following behavior:
> 
>   x86_64-softmmu/qemu-system-x86_64 -monitor stdio \
>     -object memory-backend-ram,id=ram1,size=256M
> 
>   QEMU 2.7.91 monitor - type 'help' for more information
>   (qemu) object_del ram1
>   (qemu) object_del ram1
>   object 'ram1' not found
>   (qemu) object_add memory-backend-ram,id=ram1,size=256M
>   Duplicate ID 'ram1' for object
>   Try "help object_add" for more information
> 
> which can be an issue for use-cases like memory hotplug.
> 
> This happens on the HMP side because hmp_object_add() attempts to
> create a temporary QemuOpts entry with ID 'ram1', which ends up
> conflicting with the command-line-created entry, since it was never
> cleaned up during the previous hmp_object_del() call.
> 
> We address this by adding a check in user_creatable_del(), which
> is called by both qmp_object_del() and hmp_object_del() to handle
> the actual object cleanup, to determine whether an option group entry
> matching the object's ID is present and removing it if it is.
> 
> Note that qmp_object_add() never attempts to create a temporary
> QemuOpts entry, so it does not encounter the duplicate ID error,
> which is why this isn't generally visible in libvirt.
> 
> Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> Cc: Markus Armbruster <armbru@redhat.com>
> Cc: Eric Blake <eblake@redhat.com>
> Cc: Daniel Berrange <berrange@redhat.com>
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
> ---
>  qom/object_interfaces.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/qom/object_interfaces.c b/qom/object_interfaces.c
> index ded4d84..23849f9 100644
> --- a/qom/object_interfaces.c
> +++ b/qom/object_interfaces.c
> @@ -5,6 +5,7 @@
>  #include "qapi-visit.h"
>  #include "qapi/qobject-output-visitor.h"
>  #include "qapi/opts-visitor.h"
> +#include "qemu/config-file.h"
>  
>  void user_creatable_complete(Object *obj, Error **errp)
>  {
> @@ -197,6 +198,7 @@ void user_creatable_del(const char *id, Error **errp)
>  {
>      Object *container;
>      Object *obj;
> +    QemuOptsList *opt_group;
>  
>      container = object_get_objects_root();
>      obj = object_resolve_path_component(container, id);
> @@ -209,6 +211,15 @@ void user_creatable_del(const char *id, Error **errp)
>          error_setg(errp, "object '%s' is in use, can not be deleted", id);
>          return;
>      }
> +
> +    /* if object was defined on the command-line, remove its corresponding
> +     * option group entry
> +     */
> +    opt_group = qemu_find_opts_err("object", NULL);
> +    if (opt_group) {
> +        qemu_opts_del(qemu_opts_find(opt_group, id));
> +    }
> +
>      object_unparent(obj);
>  }

Reviewed-by: Daniel P. Berrange <berrange@redhat.com>

Regards,
Daniel
-- 
|: http://berrange.com      -o-    http://www.flickr.com/photos/dberrange/ :|
|: http://libvirt.org              -o-             http://virt-manager.org :|
|: http://entangle-photo.org       -o-    http://search.cpan.org/~danberr/ :|
