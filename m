Received: from eggs.gnu.org ([2001:4830:134:3::10]:35026)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1eMtyJ-0003AS-7w
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 06:04:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1eMtyB-00061G-73
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 06:04:07 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42744)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1eMtyB-00060Y-0B
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 06:03:59 -0500
Date: Thu, 7 Dec 2017 11:03:43 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20171207110342.GB2439@work-vm>
References: <20171206200346.116537-1-brijesh.singh@amd.com>
	<20171206200346.116537-24-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171206200346.116537-24-brijesh.singh@amd.com>
Subject: Re: [Qemu-devel] [PATCH v5 23/23] sev: add migration blocker
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Brijesh Singh <brijesh.singh@amd.com>
Cc: qemu-devel@nongnu.org, Alistair Francis <alistair.francis@xilinx.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, "Daniel P . Berrange" <berrange@redhat.com>, "Edgar E . Iglesias " <edgar.iglesias@xilinx.com>, Eduardo Habkost <ehabkost@redhat.com>, Eric Blake <eblake@redhat.com>, kvm@vger.kernel.org, Marcel Apfelbaum <marcel@redhat.com>, Markus Armbruster <armbru@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Peter Maydell <peter.maydell@linaro.org>, Richard Henderson <richard.henderson@linaro.org>, Richard Henderson <rth@twiddle.net>, Stefan Hajnoczi <stefanha@gmail.com>, Thomas Lendacky <Thomas.Lendacky@amd.com>, Borislav Petkov <bp@suse.de>

* Brijesh Singh (brijesh.singh@amd.com) wrote:
> SEV guest migration is not yet implemented yet.
> 
> Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
> ---
>  accel/kvm/sev.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/accel/kvm/sev.c b/accel/kvm/sev.c
> index 3edfb5b08416..10647645eacd 100644
> --- a/accel/kvm/sev.c
> +++ b/accel/kvm/sev.c
> @@ -19,6 +19,7 @@
>  #include "sysemu/sev.h"
>  #include "sysemu/sysemu.h"
>  #include "qapi-event.h"
> +#include "migration/blocker.h"
>  
>  #define DEFAULT_GUEST_POLICY    0x1 /* disable debug */
>  #define DEFAULT_SEV_DEVICE      "/dev/sev"
> @@ -36,6 +37,7 @@
>  static int sev_fd;
>  static SEVState *sev_state;
>  static MemoryRegionRAMReadWriteOps  sev_ops;
> +static Error *sev_mig_blocker;
>  
>  #define SEV_FW_MAX_ERROR      0x17
>  
> @@ -460,6 +462,7 @@ static void
>  sev_launch_finish(SEVState *s)
>  {
>      int ret, error;
> +    Error *local_err = NULL;
>  
>      ret = sev_ioctl(KVM_SEV_LAUNCH_FINISH, 0, &error);
>      if (ret) {
> @@ -470,6 +473,16 @@ sev_launch_finish(SEVState *s)
>  
>      s->cur_state = SEV_STATE_RUNNING;
>      DPRINTF("SEV: LAUNCH_FINISH\n");

(from a previous patch)
Please use the tracing facility rather than new DPRINTF's
if possible - if you've not used it before, then
--enable-trace-backends=log   is the easy way to get going
and you can turn on and off the stuff you're interested in
tracing at run time without having to rebuild.

> +
> +    /* add migration blocker */
> +    error_setg(&sev_mig_blocker,
> +               "SEV: Migration is not implemented");
> +    ret = migrate_add_blocker(sev_mig_blocker, &local_err);
> +    if (local_err) {
> +        error_report_err(local_err);
> +        error_free(sev_mig_blocker);
> +        exit(1);
> +    }

Yep, reasonable:


Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

>  }
>  
>  static void
> -- 
> 2.9.5
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
