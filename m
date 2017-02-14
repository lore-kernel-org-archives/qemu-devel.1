Received: from eggs.gnu.org ([2001:4830:134:3::10]:33613)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cdb5W-0006Vq-4G
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 06:16:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cdb5S-0004m0-83
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 06:16:02 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56062)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1cdb5R-0004kq-VA
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 06:15:58 -0500
Received: from smtp.corp.redhat.com (int-mx16.intmail.prod.int.phx2.redhat.com
	[10.5.11.28])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7F73C7FB64
	for <qemu-devel@nongnu.org>; Tue, 14 Feb 2017 11:15:57 +0000 (UTC)
Date: Tue, 14 Feb 2017 11:15:51 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170214111551.GB467@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <1485207141-1941-1-git-send-email-quintela@redhat.com>
	<1485207141-1941-16-git-send-email-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1485207141-1941-16-git-send-email-quintela@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 15/17] migration: Test new fd infrastructure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>
Cc: qemu-devel@nongnu.org, amit.shah@redhat.com, dgilbert@redhat.com

On Mon, Jan 23, 2017 at 10:32:19PM +0100, Juan Quintela wrote:
> We just send the address through the alternate channels and test that it
> is ok.
> 
> Signed-off-by: Juan Quintela <quintela@redhat.com>
> ---
>  migration/ram.c | 36 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 36 insertions(+)
> 
> diff --git a/migration/ram.c b/migration/ram.c
> index 4e530ea..95af694 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -432,8 +432,22 @@ static void *multifd_send_thread(void *opaque)
>      qemu_mutex_lock(&params->mutex);
>      while (!params->quit){
>          if (params->pages.num) {
> +            int i;
> +            int num;
> +
> +            num = params->pages.num;

Is this likely to be a small or a large value ? .....

>              params->pages.num = 0;
>              qemu_mutex_unlock(&params->mutex);
> +
> +            for(i=0; i < num; i++) {
> +                if (qio_channel_write(params->c,
> +                                      (const char *)&params->pages.address[i],
> +                                      sizeof(uint8_t *), &error_abort)
> +                    != sizeof(uint8_t*)) {
> +                    /* Shuoudn't ever happen */
> +                    exit(-1);
> +                }
> +            }

If 'num' is large,then you would be better populating an iovec
and using qio_channel_writev() rather than sending one uint8_t *
at a time.


> @@ -605,8 +620,29 @@ static void *multifd_recv_thread(void *opaque)
>      qemu_mutex_lock(&params->mutex);
>      while (!params->quit){
>          if (params->pages.num) {
> +            int i;
> +            int num;
> +
> +            num = params->pages.num;
>              params->pages.num = 0;
>              qemu_mutex_unlock(&params->mutex);
> +
> +            for(i = 0; i < num; i++) {
> +                if (qio_channel_read(params->c,
> +                                     (char *)&recv_address,
> +                                     sizeof(uint8_t*), &error_abort)
> +                    != sizeof(uint8_t *)) {
> +                    /* shouldn't ever happen */
> +                    exit(-1);
> +                }
> +                if (recv_address != params->pages.address[i]) {
> +                    printf("We received %p what we were expecting %p (%d)\n",
> +                           recv_address,
> +                           params->pages.address[i], i);
> +                    exit(-1);
> +                }
> +            }

Same comment as above.

Regards,
Daniel
-- 
|: http://berrange.com      -o-    http://www.flickr.com/photos/dberrange/ :|
|: http://libvirt.org              -o-             http://virt-manager.org :|
|: http://entangle-photo.org       -o-    http://search.cpan.org/~danberr/ :|
