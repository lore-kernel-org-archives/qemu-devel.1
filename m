Received: from eggs.gnu.org ([2001:4830:134:3::10]:57071)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dmebF-000630-A6
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 07:22:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dmebB-0001Nv-9c
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 07:22:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50138)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dmebB-0001Nh-0Q
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 07:22:25 -0400
Date: Tue, 29 Aug 2017 12:22:19 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170829112219.GJ3783@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170828015654.2530-1-Sergio.G.DelReal@gmail.com>
	<20170828015654.2530-3-Sergio.G.DelReal@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170828015654.2530-3-Sergio.G.DelReal@gmail.com>
Subject: Re: [Qemu-devel] [PATCH 02/14] hvf: add code base from Google's
 QEMU repository
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Sergio Andres Gomez Del Real <sergio.g.delreal@gmail.com>
Cc: qemu-devel@nongnu.org

On Sun, Aug 27, 2017 at 08:56:42PM -0500, Sergio Andres Gomez Del Real wrote:
> This file begins tracking the files that will be the code base for HVF
> support in QEMU.
> 
> Signed-off-by: Sergio Andres Gomez Del Real <Sergio.G.DelReal@gmail.com>
> ---

> diff --git a/target/i386/hvf-all.c b/target/i386/hvf-all.c
> new file mode 100644
> index 0000000000..06cd8429eb
> --- /dev/null
> +++ b/target/i386/hvf-all.c
> @@ -0,0 +1,982 @@

There's no copyright header on this file.

A few others a missing copyright headers too, but they're all simple
.h files, so not critical. This, though, is a major .c file so I think
it really should have a copyright header present. IIUC, this is not
your code, but rather copied from the google repo, so ought to get the
original author to update this.

> +#include "qemu/osdep.h"
> +#include "qemu-common.h"
> +
> +#include "sysemu/hvf.h"
> +#include "hvf-i386.h"
> +#include "hvf-utils/vmcs.h"
> +#include "hvf-utils/vmx.h"
> +#include "hvf-utils/x86.h"
> +#include "hvf-utils/x86_descr.h"
> +#include "hvf-utils/x86_mmu.h"
> +#include "hvf-utils/x86_decode.h"
> +#include "hvf-utils/x86_emu.h"
> +#include "hvf-utils/x86_cpuid.h"
> +#include "hvf-utils/x86hvf.h"
> +
> +#include <Hypervisor/hv.h>
> +#include <Hypervisor/hv_vmx.h>
> +
> +#include "exec/address-spaces.h"
> +#include "exec/exec-all.h"
> +#include "exec/ioport.h"
> +#include "hw/i386/apic_internal.h"
> +#include "hw/boards.h"
> +#include "qemu/main-loop.h"
> +#include "strings.h"
> +#include "trace.h"
> +#include "sysemu/accel.h"
> +#include "sysemu/sysemu.h"
> +#include "target/i386/cpu.h"
> +
> +pthread_rwlock_t mem_lock = PTHREAD_RWLOCK_INITIALIZER;
> +HVFState *hvf_state;
> +static int hvf_disabled = 1;
> +
> +static void assert_hvf_ok(hv_return_t ret)
> +{
> +    if (ret == HV_SUCCESS)
> +        return;
> +
> +    switch (ret) {
> +        case HV_ERROR:
> +            fprintf(stderr, "Error: HV_ERROR\n");
> +            break;
> +        case HV_BUSY:
> +            fprintf(stderr, "Error: HV_BUSY\n");
> +            break;
> +        case HV_BAD_ARGUMENT:
> +            fprintf(stderr, "Error: HV_BAD_ARGUMENT\n");
> +            break;
> +        case HV_NO_RESOURCES:
> +            fprintf(stderr, "Error: HV_NO_RESOURCES\n");
> +            break;
> +        case HV_NO_DEVICE:
> +            fprintf(stderr, "Error: HV_NO_DEVICE\n");
> +            break;
> +        case HV_UNSUPPORTED:
> +            fprintf(stderr, "Error: HV_UNSUPPORTED\n");
> +            break;
> +        default:
> +            fprintf(stderr, "Unknown Error\n");
> +    }
> +
> +    abort();
> +}

There's loads of fprintfs() throughout this file - it really needs to
be fixed to use error_report() 


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
