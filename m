Received: from eggs.gnu.org ([2001:4830:134:3::10]:48144)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1duIfD-0006z4-1B
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 09:34:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1duIf7-0003PC-4T
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 09:34:11 -0400
Date: Tue, 19 Sep 2017 14:33:51 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170919133351.GO9536@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170919102434.21147-1-pbonzini@redhat.com>
	<20170919102434.21147-3-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170919102434.21147-3-pbonzini@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 2/4] scsi: build qemu-pr-helper
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

On Tue, Sep 19, 2017 at 12:24:32PM +0200, Paolo Bonzini wrote:
> Introduce a privileged helper to run persistent reservation commands.
> This lets virtual machines send persistent reservations without using
> CAP_SYS_RAWIO or out-of-tree patches.  The helper uses Unix permissions
> and SCM_RIGHTS to restrict access to processes that can access its socket
> and prove that they have an open file descriptor for a raw SCSI device.
> 
> The next patch will also correct the usage of persistent reservations
> with multipath devices.
> 
> It would also be possible to support for Linux's IOC_PR_* ioctls in
> the future, to support NVMe devices.  For now, however, only SCSI is
> supported.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---


> +
> +#define PR_HELPER_CDB_SIZE     16
> +#define PR_HELPER_SENSE_SIZE   96
> +#define PR_HELPER_DATA_SIZE    8192
> +
> +typedef struct PRHelperResponse {
> +    int32_t result;
> +    int32_t sz;
> +    uint8_t sense[PR_HELPER_SENSE_SIZE];
> +} PRHelperResponse;

Should we annotate this with 'packed' to ensure its immune to compiler
padding ?


> +typedef struct PRHelperRequest {
> +    int fd;
> +    size_t sz;
> +    uint8_t cdb[PR_HELPER_CDB_SIZE];
> +} PRHelperRequest;

Same q here ?


> +static int coroutine_fn prh_write_response(PRHelperClient *client,
> +                                           PRHelperRequest *req,
> +                                           PRHelperResponse *resp, Error **errp)
> +{
> +    ssize_t r;

Can just be int

> +    size_t sz;
> +
> +    if (req->cdb[0] == PERSISTENT_RESERVE_IN && resp->result == GOOD) {
> +        assert(resp->sz <= req->sz && resp->sz <= sizeof(client->data));
> +    } else {
> +        assert(resp->sz == 0);
> +    }
> +
> +    sz = resp->sz;
> +
> +    resp->result = cpu_to_be32(resp->result);
> +    resp->sz = cpu_to_be32(resp->sz);
> +    r = qio_channel_write_all(QIO_CHANNEL(client->ioc),
> +                              (char *) resp, sizeof(*resp), errp);
> +    if (r < 0) {
> +        return r;
> +    }
> +
> +    r = qio_channel_write_all(QIO_CHANNEL(client->ioc),
> +                              (char *) client->data,
> +                              sz, errp);
> +    return r < 0 ? r : 0;

Just return 'r' directly, its only ever -1 or 0



Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
