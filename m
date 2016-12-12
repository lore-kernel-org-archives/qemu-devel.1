Received: from eggs.gnu.org ([2001:4830:134:3::10]:50620)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cGThN-0006kZ-Ks
	for qemu-devel@nongnu.org; Mon, 12 Dec 2016 11:43:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cGThK-0007tP-SZ
	for qemu-devel@nongnu.org; Mon, 12 Dec 2016 11:43:33 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <1481306681-5760-1-git-send-email-mdroth@linux.vnet.ibm.com>
	<1481306681-5760-3-git-send-email-mdroth@linux.vnet.ibm.com>
Date: Mon, 12 Dec 2016 16:53:20 +0100
In-Reply-To: <1481306681-5760-3-git-send-email-mdroth@linux.vnet.ibm.com>
	(Michael Roth's message of "Fri, 9 Dec 2016 12:04:41 -0600")
Message-ID: <87oa0h2lfz.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v3 2/2] monitor: fix object_del for
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
Cc: qemu-devel@nongnu.org, qemu-stable@nongnu.org, dgilbert@redhat.com, bharata.rao@gmail.com, david@gibson.dropbear.id.au

Michael Roth <mdroth@linux.vnet.ibm.com> writes:

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
> Reviewed-by: Daniel P. Berrange <berrange@redhat.com>
> ---
>  qom/object_interfaces.c    | 7 +++++++
>  tests/check-qom-proplist.c | 4 ++--
>  2 files changed, 9 insertions(+), 2 deletions(-)
>
> diff --git a/qom/object_interfaces.c b/qom/object_interfaces.c
> index ded4d84..b462a74 100644
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
> @@ -209,6 +210,12 @@ void user_creatable_del(const char *id, Error **errp)
>          error_setg(errp, "object '%s' is in use, can not be deleted", id);
>          return;
>      }
> +
> +    /* if object was defined on the command-line, remove its corresponding
> +     * option group entry
> +     */

Consider adding wings to both ends of multi-line comments.

> +    qemu_opts_del(qemu_opts_find(qemu_find_opts_err("object", NULL), id));

qemu_find_opts_err() can't fail.  If it did, qemu_opts_find() would
crash.  Okay.

Elsewhere, we use qemu_opts_find(qemu_find_opts(NAME)), which would
report an error to stderr / monitor before crashing.  Also okay.

Perhaps the cleanest (but not the tersest) way to skin this cat:
qemu_opts_find(qemu_find_opts_err(&error_abort)).

Your choice.

> +
>      object_unparent(obj);
>  }
>  
> diff --git a/tests/check-qom-proplist.c b/tests/check-qom-proplist.c
> index e3f56ca..c5d4b60 100644
> --- a/tests/check-qom-proplist.c
> +++ b/tests/check-qom-proplist.c
> @@ -437,9 +437,9 @@ static void test_dummy_createcmdl(void)
>       * check for this in user_creatable_del() and remove the QemuOpts if
>       * it is present.
>       *
> -     * FIXME: add an assert to verify that the QemuOpts is cleaned up
> -     * once the corresponding cleanup code is added.
> +     * The below check ensures this works as expected.
>       */
> +    g_assert(qemu_opts_find(&qemu_object_opts, "dev0") == NULL);

There's also g_assert_null(), which could result in a more helpful
message when the assertion fails.  Your choice.

>  }
>  
>  static void test_dummy_badenum(void)
