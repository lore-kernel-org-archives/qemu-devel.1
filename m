Received: from eggs.gnu.org ([2001:4830:134:3::10]:47810)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1duI1a-0006gt-Qe
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 08:53:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1duI1Z-0004xj-Ng
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 08:53:14 -0400
Date: Tue, 19 Sep 2017 13:53:00 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170919125300.GL9536@redhat.com>
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


> +static int pr_manager_helper_run(PRManager *p,
> +                                 int fd, struct sg_io_hdr *io_hdr)
> +{
> +    PRManagerHelper *pr_mgr = PR_MANAGER_HELPER(p);
> +
> +    uint32_t len;
> +    PRHelperResponse resp;
> +    int ret;
> +    int expected_dir;
> +    int attempts;
> +    uint8_t cdb[PR_HELPER_CDB_SIZE] = { 0 };
> +
> +    if (!io_hdr->cmd_len || io_hdr->cmd_len > PR_HELPER_CDB_SIZE) {
> +        return -EINVAL;
> +    }
> +
> +    memcpy(cdb, io_hdr->cmdp, io_hdr->cmd_len);
> +    assert(cdb[0] == PERSISTENT_RESERVE_OUT || cdb[0] == PERSISTENT_RESERVE_IN);
> +    expected_dir =
> +        (cdb[0] == PERSISTENT_RESERVE_OUT ? SG_DXFER_TO_DEV : SG_DXFER_FROM_DEV);
> +    if (io_hdr->dxfer_direction != expected_dir) {
> +        return -EINVAL;
> +    }
> +
> +    len = scsi_cdb_xfer(cdb);
> +    if (io_hdr->dxfer_len < len || len > PR_HELPER_DATA_SIZE) {
> +        return -EINVAL;
> +    }
> +
> +    qemu_mutex_lock(&pr_mgr->lock);
> +
> +    /* Try to reconnect while sending the CDB.  */
> +    for (attempts = 0; attempts < PR_MAX_RECONNECT_ATTEMPTS; attempts++) {

I'm curious why you need to loop here. The helper daemon should be running
already, as you're not spawning it on demand IIUC. So it shoudl either
succeed first time, or fail every time.

> +        if (!pr_mgr->ioc) {
> +            ret = pr_manager_helper_initialize(pr_mgr, NULL);
> +            if (ret < 0) {
> +                qemu_mutex_unlock(&pr_mgr->lock);
> +                g_usleep(G_USEC_PER_SEC);
> +                qemu_mutex_lock(&pr_mgr->lock);
> +                continue;
> +            }
> +        }
> +
> +        ret = pr_manager_helper_write(pr_mgr, fd, cdb, ARRAY_SIZE(cdb), NULL);
> +        if (ret >= 0) {
> +            break;
> +        }
> +    }
> +    if (ret < 0) {
> +        goto out;
> +    }

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
