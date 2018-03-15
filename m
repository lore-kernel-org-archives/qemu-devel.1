Received: from eggs.gnu.org ([2001:4830:134:3::10]:60628)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1ewMwW-0005Mc-6z
	for qemu-devel@nongnu.org; Thu, 15 Mar 2018 03:04:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1ewMwR-0006KZ-2K
	for qemu-devel@nongnu.org; Thu, 15 Mar 2018 03:04:52 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42038 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1ewMwQ-0006Jn-Tb
	for qemu-devel@nongnu.org; Thu, 15 Mar 2018 03:04:47 -0400
Date: Thu, 15 Mar 2018 15:04:34 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20180315070434.GE2733@lemon.usersys.redhat.com>
References: <20180314153820.18426-1-drjones@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180314153820.18426-1-drjones@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2] dump-guest-memory: more descriptive
 lookup_type failure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrew Jones <drjones@redhat.com>
Cc: qemu-devel@nongnu.org, frankja@linux.vnet.ibm.com, lersek@redhat.com, marcandre.lureau@redhat.com

On Wed, 03/14 16:38, Andrew Jones wrote:
> We've seen a few reports of
> 
>  (gdb) source /usr/share/qemu-kvm/dump-guest-memory.py
>  Traceback (most recent call last):
>    File "/usr/share/qemu-kvm/dump-guest-memory.py", line 19, in <module>
>      UINTPTR_T = gdb.lookup_type("uintptr_t")
>  gdb.error: No type named uintptr_t.
> 
> This occurs when symbols haven't been loaded first, i.e. neither a
> QEMU binary was loaded nor a QEMU process was attached first. Let's
> better inform the user of how to fix the issue themselves in order
> to avoid more reports.
> 
> Acked-by: Janosch Frank <frankja@linux.vnet.ibm.com>
> Signed-off-by: Andrew Jones <drjones@redhat.com>
> ---
> v2: Not quite so long a long line (< 90 only generates warnings)
>     Pick up Janosch's ack
> 
>  scripts/dump-guest-memory.py | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/scripts/dump-guest-memory.py b/scripts/dump-guest-memory.py
> index 51acfcd0c053..276eebf0c27e 100644
> --- a/scripts/dump-guest-memory.py
> +++ b/scripts/dump-guest-memory.py
> @@ -16,7 +16,12 @@ the COPYING file in the top-level directory.
>  import ctypes
>  import struct
>  
> -UINTPTR_T = gdb.lookup_type("uintptr_t")
> +try:
> +    UINTPTR_T = gdb.lookup_type("uintptr_t")
> +except Exception as inst:
> +    raise gdb.GdbError("Symbols must be loaded prior to sourcing dump-guest-memory.\n"
> +                       "Symbols may be loaded by 'attach'ing a QEMU process id or by "
> +                       "'load'ing a QEMU binary.")
>  
>  TARGET_PAGE_SIZE = 0x1000
>  TARGET_PAGE_MASK = 0xFFFFFFFFFFFFF000
> -- 
> 2.13.6
> 
> 

Reviewed-by: Fam Zheng <famz@redhat.com>
Tested-by: Fam Zheng <famz@redhat.com>
