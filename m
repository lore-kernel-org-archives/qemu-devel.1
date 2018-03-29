Received: from eggs.gnu.org ([2001:4830:134:3::10]:37059)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1f1TnH-0002GJ-CJ
	for qemu-devel@nongnu.org; Thu, 29 Mar 2018 05:24:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1f1TnG-0003Di-HQ
	for qemu-devel@nongnu.org; Thu, 29 Mar 2018 05:24:27 -0400
Date: Thu, 29 Mar 2018 11:24:16 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180329112416.28b99184.cohuck@redhat.com>
In-Reply-To: <152231462116.69730.14119625999092384450.stgit@bahia.lan>
References: <152231456507.69730.15601462044394150786.stgit@bahia.lan>
	<152231462116.69730.14119625999092384450.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 3/3] sev/i386: fix memory leak in
 sev_guest_init()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>, David Hildenbrand <david@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, qemu-s390x@nongnu.org, qemu-stable@nongnu.org

On Thu, 29 Mar 2018 11:10:21 +0200
Greg Kurz <groug@kaod.org> wrote:

> The string returned by object_property_get_str() is dynamically allocated.
> 
> Fixes: d8575c6c0242b
> Signed-off-by: Greg Kurz <groug@kaod.org>
> ---
>  target/i386/sev.c |    4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/target/i386/sev.c b/target/i386/sev.c
> index 019d84cef2c7..c01167143f1c 100644
> --- a/target/i386/sev.c
> +++ b/target/i386/sev.c
> @@ -748,9 +748,11 @@ sev_guest_init(const char *id)
>      if (s->sev_fd < 0) {
>          error_report("%s: Failed to open %s '%s'", __func__,
>                       devname, strerror(errno));
> -        goto err;
>      }
>      g_free(devname);
> +    if (s->sev_fd < 0) {
> +        goto err;
> +    }
>  
>      ret = sev_platform_ioctl(s->sev_fd, SEV_PLATFORM_STATUS, &status,
>                               &fw_error);
> 

I would probably add an extra g_free(devname) right before the goto
err, but this works as well, obviously.

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
