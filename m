Received: from eggs.gnu.org ([2001:4830:134:3::10]:56442)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fangb-0000Tp-OJ
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 15:43:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fangY-0001G8-Lr
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 15:43:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54414)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1fangY-0001Fh-F5
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 15:43:30 -0400
Date: Wed, 4 Jul 2018 16:43:27 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180704194327.GJ914@localhost.localdomain>
References: <1530710466-88309-1-git-send-email-jingqi.liu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1530710466-88309-1-git-send-email-jingqi.liu@intel.com>
Subject: Re: [Qemu-devel] [PATCH] i386: Add support to get/set/migrate MSR
 (33H)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jingqi Liu <jingqi.liu@intel.com>
Cc: pbonzini@redhat.com, mtosatti@redhat.com, qemu-devel@nongnu.org, wei.w.wang@intel.com, rth@twiddle.net

On Wed, Jul 04, 2018 at 09:21:06PM +0800, Jingqi Liu wrote:
> The MSR (33H) controls support for #AC exception
> for split locked accesses. When bit 29 of the MSR (33H)
> is set, the processor causes an #AC exception to
> be issued instead of suppressing LOCK on bus
> (during split lock access).
> 
> Signed-off-by: Jingqi Liu <jingqi.liu@intel.com>
[...]
> diff --git a/target/i386/machine.c b/target/i386/machine.c
> index 4d98d36..c82dc0d 100644
> --- a/target/i386/machine.c
> +++ b/target/i386/machine.c
> @@ -935,6 +935,25 @@ static const VMStateDescription vmstate_msr_virt_ssbd = {
>      }
>  };
>  
> +static bool split_lock_ctrl_needed(void *opaque)
> +{
> +    X86CPU *cpu = opaque;
> +    CPUX86State *env = &cpu->env;
> +
> +    return env->split_lock_ctrl != 0;
> +}

Based on the Linux patch at [1], guests may try to detect the
feature by writing to the MSR unconditionally.

If this happens, KVM needs to provide a mechanism to
enable/disable the MSR emulation.  Otherwise users will end up
with VMs that can't be migrated to older hosts even if they are
using older machine-types.

[1] https://lkml.org/lkml/2018/6/29/408

-- 
Eduardo
