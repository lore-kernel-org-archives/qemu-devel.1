Received: from eggs.gnu.org ([2001:4830:134:3::10]:46281)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1duHzX-0004tV-HX
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 08:51:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1duHzR-0003f1-MW
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 08:51:07 -0400
Date: Tue, 19 Sep 2017 13:50:51 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170919125051.GK9536@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170919102434.21147-1-pbonzini@redhat.com>
	<20170919102434.21147-5-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170919102434.21147-5-pbonzini@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 4/4] scsi: add persistent reservation
 manager using qemu-pr-helper
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org

On Tue, Sep 19, 2017 at 12:24:34PM +0200, Paolo Bonzini wrote:
> This adds a concrete subclass of pr-manager that talks to qemu-pr-helper.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
> v1->v2: fixed string property double-free
>         fixed/cleaned up error handling
>         handle buffer underrun
> 
>  scsi/Makefile.objs       |   2 +-
>  scsi/pr-manager-helper.c | 302 +++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 303 insertions(+), 1 deletion(-)
>  create mode 100644 scsi/pr-manager-helper.c
> 
> diff --git a/scsi/Makefile.objs b/scsi/Makefile.objs
> index 5496d2ae6a..4d25e476cf 100644
> --- a/scsi/Makefile.objs
> +++ b/scsi/Makefile.objs
> @@ -1,3 +1,3 @@
>  block-obj-y += utils.o
>  
> -block-obj-$(CONFIG_LINUX) += pr-manager.o
> +block-obj-$(CONFIG_LINUX) += pr-manager.o pr-manager-helper.o
> diff --git a/scsi/pr-manager-helper.c b/scsi/pr-manager-helper.c
> new file mode 100644
> index 0000000000..063fd35dee
> --- /dev/null
> +++ b/scsi/pr-manager-helper.c

> +/* Called with lock held.  */
> +static int pr_manager_helper_read(PRManagerHelper *pr_mgr,
> +                                  void *buf, int sz, Error **errp)
> +{
> +    ssize_t r = qio_channel_read_all(pr_mgr->ioc, buf, sz, errp);

The return value isn't ssize_t - it just returns 0 on success, -1 on
error, never a bytes count since it always reads all requested bytes
and treats EOF as an error condition.

> +
> +    if (r < 0) {
> +        object_unref(OBJECT(pr_mgr->ioc));
> +        pr_mgr->ioc = NULL;
> +        return -EINVAL;
> +    }
> +
> +    return 0;
> +}
> +

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
