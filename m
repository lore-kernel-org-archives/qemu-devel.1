Received: from eggs.gnu.org ([2001:4830:134:3::10]:60427)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1cr5Wj-0000GG-Au
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 12:23:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1cr5Wg-00080p-6m
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 12:23:53 -0400
Date: Thu, 23 Mar 2017 16:23:47 +0000
From: "Richard W.M. Jones" <rjones@redhat.com>
Message-ID: <20170323162347.GG13825@redhat.com>
References: <20170323160315.19696-1-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170323160315.19696-1-eblake@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.9] qom: Fix regression with 'qom-type'
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-stable@nongnu.org, Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>, armbru@redhat.com

On Thu, Mar 23, 2017 at 11:03:15AM -0500, Eric Blake wrote:
> Commit 9a6d1ac assumed that 'qom-type' could be removed from QemuOpts
> with no ill effects.  However, this command line proves otherwise:
> 
> $ ./x86_64-softmmu/qemu-system-x86_64 -nodefaults -nographic -qmp stdio \
>   -object rng-random,filename=/dev/urandom,id=rng0 \
>   -device virtio-rng-pci,rng=rng0
> qemu-system-x86_64: -object rng-random,filename=/dev/urandom,id=rng0: Parameter 'qom-type' is missing
> 
> Fix the regression by restoring qom-type in opts after its temporary
> removal that was needed for the duration of user_creatable_add_opts().
> 
> Reported-by: Richard W. M. Jones <rjones@redhat.com>
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>  qom/object_interfaces.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/qom/object_interfaces.c b/qom/object_interfaces.c
> index 9c271ad..d4253a8 100644
> --- a/qom/object_interfaces.c
> +++ b/qom/object_interfaces.c
> @@ -122,6 +122,7 @@ Object *user_creatable_add_opts(QemuOpts *opts, Error **errp)
>      }
>      if (!id) {
>          error_setg(errp, QERR_MISSING_PARAMETER, "id");
> +        qemu_opt_set(opts, "qom-type", type, &error_abort);
>          g_free(type);
>          return NULL;
>      }
> @@ -134,6 +135,7 @@ Object *user_creatable_add_opts(QemuOpts *opts, Error **errp)
>      visit_free(v);
> 
>      qemu_opts_set_id(opts, (char *) id);
> +    qemu_opt_set(opts, "qom-type", type, &error_abort);
>      g_free(type);
>      QDECREF(pdict);
>      return obj;

Thanks Eric.  Yes, this fixes the problem I observed before
with libguestfs.

Tested-by: Richard W.M. Jones <rjones@redhat.com>

Rich.

-- 
Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rjones
Read my programming and virtualization blog: http://rwmj.wordpress.com
virt-df lists disk usage of guests without needing to install any
software inside the virtual machine.  Supports Linux and Windows.
http://people.redhat.com/~rjones/virt-df/
