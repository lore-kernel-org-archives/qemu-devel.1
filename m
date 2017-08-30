Received: from eggs.gnu.org ([2001:4830:134:3::10]:58791)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dn6Jz-0006ac-2v
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 12:58:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dn6Ju-0007GW-V4
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 12:58:31 -0400
Date: Wed, 30 Aug 2017 17:58:23 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170830165823.GZ24565@stefanha-x1.localdomain>
References: <20170822131832.20191-1-pbonzini@redhat.com>
	<20170822131832.20191-11-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170822131832.20191-11-pbonzini@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 10/10] scsi: add persistent
 reservation manager using qemu-pr-helper
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, famz@redhat.com, qemu-block@nongnu.org

On Tue, Aug 22, 2017 at 03:18:32PM +0200, Paolo Bonzini wrote:
> +/* Called with lock held.  */
> +static int pr_manager_helper_read(PRManagerHelper *pr_mgr,
> +                                  void *buf, int sz, Error **errp)
> +{
> +    ssize_t r = qio_channel_read_all(pr_mgr->ioc, buf, sz, errp);
> +
> +    if (r < 0) {
> +        object_unref(OBJECT(pr_mgr->ioc));
> +        pr_mgr->ioc = NULL;
> +        return r;
> +    }
> +
> +    return r < 0 ? r : 0;

At this point we know r >= 0:

  return r;

> +    if (pr_manager_helper_read(pr_mgr, &resp, sizeof(resp), NULL) < 0) {
> +        ret = -EINVAL;
> +        goto out;
> +    }

resp.result is big-endian and accessed without byteswaps below.  We
need:

  resp.result = be32_to_host(resp.result);

> +    if (expected_dir == SG_DXFER_FROM_DEV && resp.result == 0) {
> +        if (pr_manager_helper_read(pr_mgr, io_hdr->dxferp, len, NULL) < 0) {
> +            ret = -EINVAL;
> +            goto out;
> +        }
> +    }
> +
> +    io_hdr->status = resp.result;
> +    if (resp.result == CHECK_CONDITION) {
> +        io_hdr->driver_status = SG_ERR_DRIVER_SENSE;
> +        io_hdr->sb_len_wr = MIN(io_hdr->mx_sb_len, PR_HELPER_SENSE_SIZE);
> +        memcpy(io_hdr->sbp, resp.sense, io_hdr->sb_len_wr);
> +    }
> +
> +out:
> +    if (ret < 0) {
> +        int sense_len = scsi_build_sense(io_hdr->sbp,
> +                                         SENSE_CODE(LUN_COMM_FAILURE));
> +        io_hdr->driver_status = SG_ERR_DRIVER_SENSE;
> +        io_hdr->sb_len_wr = MIN(io_hdr->mx_sb_len, sense_len);
> +        io_hdr->status = CHECK_CONDITION;
> +    }
> +    qemu_mutex_unlock(&pr_mgr->lock);
> +    return ret;
> +}
> +static void pr_manager_helper_instance_finalize(Object *obj)
> +{
> +    PRManagerHelper *pr_mgr = PR_MANAGER_HELPER(obj);
> +
> +    g_free(pr_mgr->path);

Double free, the "path" property already has a release function that
frees the string.
