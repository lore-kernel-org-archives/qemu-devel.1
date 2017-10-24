Received: from eggs.gnu.org ([2001:4830:134:3::10]:39846)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1e6tsA-0007Lf-In
	for qemu-devel@nongnu.org; Tue, 24 Oct 2017 03:43:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1e6ts9-00024y-MK
	for qemu-devel@nongnu.org; Tue, 24 Oct 2017 03:43:38 -0400
Date: Tue, 24 Oct 2017 08:43:24 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20171024074324.GB24198@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20171020091403.1479-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171020091403.1479-1-berrange@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] ide: avoid referencing NULL dev in
 rotational rate setting
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, John Snow <jsnow@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>

CC John

On Fri, Oct 20, 2017 at 10:14:03AM +0100, Daniel P. Berrange wrote:
> The 'dev' variable can be NULL when the guest OS calls identify on an IDE
> unit that does not have a drive attached to it.
> 
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> ---
>  hw/ide/core.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/ide/core.c b/hw/ide/core.c
> index a04766aee7..471d0c928b 100644
> --- a/hw/ide/core.c
> +++ b/hw/ide/core.c
> @@ -208,7 +208,9 @@ static void ide_identify(IDEState *s)
>      if (dev && dev->conf.discard_granularity) {
>          put_le16(p + 169, 1); /* TRIM support */
>      }
> -    put_le16(p + 217, dev->rotation_rate); /* Nominal media rotation rate */
> +    if (dev) {
> +        put_le16(p + 217, dev->rotation_rate); /* Nominal media rotation rate */
> +    }
>  
>      ide_identify_size(s);
>      s->identify_set = 1;
> -- 
> 2.13.6
> 

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
