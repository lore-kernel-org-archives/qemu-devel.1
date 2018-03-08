Received: from eggs.gnu.org ([2001:4830:134:3::10]:48051)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1etyrZ-0002q7-O0
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 11:57:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1etyrW-0000ww-1L
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 11:57:53 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45236 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1etyrV-0000wg-RK
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 11:57:49 -0500
Date: Thu, 8 Mar 2018 16:57:40 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180308165740.GI4718@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180308124901.83533-1-brijesh.singh@amd.com>
	<20180308124901.83533-12-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180308124901.83533-12-brijesh.singh@amd.com>
Subject: Re: [Qemu-devel] [PATCH v12 11/28] sev/i386: add command to
 initialize the memory encryption context
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Brijesh Singh <brijesh.singh@amd.com>
Cc: qemu-devel@nongnu.org, Alistair Francis <alistair.francis@xilinx.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>, Eduardo Habkost <ehabkost@redhat.com>, Eric Blake <eblake@redhat.com>, kvm@vger.kernel.org, Marcel Apfelbaum <marcel@redhat.com>, Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Peter Maydell <peter.maydell@linaro.org>, Richard Henderson <richard.henderson@linaro.org>, Stefan Hajnoczi <stefanha@gmail.com>, Thomas Lendacky <Thomas.Lendacky@amd.com>, Borislav Petkov <bp@suse.de>, Alexander Graf <agraf@suse.de>, Bruce Rogers <brogers@suse.com>, Richard Henderson <rth@twiddle.net>

On Thu, Mar 08, 2018 at 06:48:44AM -0600, Brijesh Singh wrote:
> When memory encryption is enabled, KVM_SEV_INIT command is used to
> initialize the platform. The command loads the SEV related persistent
> data from non-volatile storage and initializes the platform context.
> This command should be first issued before invoking any other guest
> commands provided by the SEV firmware.
> 
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Richard Henderson <rth@twiddle.net>
> Cc: Eduardo Habkost <ehabkost@redhat.com>
> Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
> ---
>  accel/kvm/kvm-all.c       |  16 ++++
>  include/sysemu/sev.h      |  22 +++++
>  stubs/Makefile.objs       |   1 +
>  stubs/sev.c               |  21 +++++
>  target/i386/Makefile.objs |   2 +-
>  target/i386/monitor.c     |  11 ++-
>  target/i386/sev-stub.c    |  41 +++++++++
>  target/i386/sev.c         | 224 ++++++++++++++++++++++++++++++++++++++++++++++
>  target/i386/sev_i386.h    |  24 +++++
>  target/i386/trace-events  |   3 +
>  10 files changed, 362 insertions(+), 3 deletions(-)
>  create mode 100644 include/sysemu/sev.h
>  create mode 100644 stubs/sev.c
>  create mode 100644 target/i386/sev-stub.c
> 

> +static const char *const sev_fw_errlist[] = {
> +    "",
> +    "Platform state is invalid",
> +    "Guest state is invalid",
> +    "Platform configuration is invalid",
> +    "Buffer too small",
> +    "Platform is already owned",
> +    "Certificate is invalid",
> +    "Policy is not allowed",
> +    "Guest is not active",
> +    "Invalid address",
> +    "Bad signature",
> +    "Bad measurement",
> +    "Asid is already owned",
> +    "Invalid ASID",
> +    "WBINVD is required",
> +    "DF_FLUSH is required",
> +    "Guest handle is invalid",
> +    "Invalid command",
> +    "Guest is active",
> +    "Hardware error",
> +    "Hardware unsafe",
> +    "Feature not supported",
> +    "Invalid parameter"
> +};
> +
> +#define SEV_FW_MAX_ERROR      ARRAY_SIZE(sev_fw_errlist)
> +

> +static const char *
> +fw_error_to_str(int code)
> +{
> +    if (code >= SEV_FW_MAX_ERROR) {
> +        return "unknown error";

Seems '0' is not an error, and negative numbers are invalid
too, so augment this with   '|| code <= 0' to avoid bad array
access on negative numbers

> +    }
> +
> +    return sev_fw_errlist[code];
> +}

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
