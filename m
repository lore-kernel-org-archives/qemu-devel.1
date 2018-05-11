Received: from eggs.gnu.org ([2001:4830:134:3::10]:37990)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fHDc4-0007dh-Io
	for qemu-devel@nongnu.org; Fri, 11 May 2018 15:21:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fHDc0-0000hv-2c
	for qemu-devel@nongnu.org; Fri, 11 May 2018 15:21:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51274)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1fHDbz-0000hS-SU
	for qemu-devel@nongnu.org; Fri, 11 May 2018 15:21:52 -0400
Date: Fri, 11 May 2018 16:21:45 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180511192145.GV25013@localhost.localdomain>
References: <20180510204148.11687-1-babu.moger@amd.com>
	<20180510204148.11687-4-babu.moger@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180510204148.11687-4-babu.moger@amd.com>
Subject: Re: [Qemu-devel] [PATCH v8 3/8] i386: Add new property to control
 cache info
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Babu Moger <babu.moger@amd.com>
Cc: mst@redhat.com, marcel.apfelbaum@gmail.com, pbonzini@redhat.com, rth@twiddle.net, mtosatti@redhat.com, qemu-devel@nongnu.org, kvm@vger.kernel.org, geoff@hostfission.com, kash@tripleback.net

On Thu, May 10, 2018 at 03:41:43PM -0500, Babu Moger wrote:
> The property legacy-cache will be used to control the cache information.
> If user passes "-cpu legacy-cache" then older information will
> be displayed even if the hardware supports new information. Otherwise
> use the statically loaded cache definitions if available.
> 
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> Tested-by: Geoffrey McRae <geoff@hostfission.com>
> ---
>  include/hw/i386/pc.h |  8 ++++
>  target/i386/cpu.c    | 97 ++++++++++++++++++++++++++++++++------------
>  target/i386/cpu.h    |  5 +++
>  3 files changed, 84 insertions(+), 26 deletions(-)
> 
> diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
> index 2e834e6ded..df15deefca 100644
> --- a/include/hw/i386/pc.h
> +++ b/include/hw/i386/pc.h
> @@ -304,6 +304,14 @@ int e820_add_entry(uint64_t, uint64_t, uint32_t);
>  int e820_get_num_entries(void);
>  bool e820_get_entry(int, uint32_t, uint64_t *, uint64_t *);
>  
> +#define PC_COMPAT_2_12 \
> +    HW_COMPAT_2_12 \
> +    {\
> +        .driver   = TYPE_X86_CPU,\
> +        .property = "legacy-cache",\
> +        .value    = "on",\
> +    },

This isn't enough if the pc-*-2.12 machine-type isn't using the
macro.

Before we do this, we need a commit similar to commit
df47ce8af4a5, but adding pc-*-2.13 machine-types.

The rest of the patch looks good to me, but I will suggest a
clean up (that can be submitted a separate patch later, or
included in v9) in a separate reply.

-- 
Eduardo
