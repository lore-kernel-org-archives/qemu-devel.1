Received: from eggs.gnu.org ([2001:4830:134:3::10]:52744)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gMbcW-0008CL-TW
	for qemu-devel@nongnu.org; Tue, 13 Nov 2018 11:32:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gMbcT-0007iA-94
	for qemu-devel@nongnu.org; Tue, 13 Nov 2018 11:32:56 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58940)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1gMbcS-0007c5-W5
	for qemu-devel@nongnu.org; Tue, 13 Nov 2018 11:32:53 -0500
References: <20181113160908.12706-1-danielhb413@gmail.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <7274afaf-06ad-c93f-370a-151f1605cabb@redhat.com>
Date: Tue, 13 Nov 2018 10:32:39 -0600
MIME-Version: 1.0
In-Reply-To: <20181113160908.12706-1-danielhb413@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/1] qga: update docs with systemd suspend
 support info
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-devel@nongnu.org
Cc: mdroth@linux.vnet.ibm.com

On 11/13/18 10:09 AM, Daniel Henrique Barboza wrote:
> Commit 067927d62e ("qga: systemd hibernate/suspend/hybrid-sleep
> support") failed to update qapi-schema.json after adding systemd
> hibernate/suspend/hybrid-sleep capabilities to guest-suspend-* QGA
> commands.
> 
> Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
> ---
>   qga/qapi-schema.json | 37 ++++++++++++++++++++++++++-----------
>   1 file changed, 26 insertions(+), 11 deletions(-)

> +++ b/qga/qapi-schema.json
> @@ -532,12 +532,16 @@
>   #
>   # Suspend guest to disk.
>   #
> -# This command tries to execute the scripts provided by the pm-utils package.
> -# If it's not available, the suspend operation will be performed by manually
> -# writing to a sysfs file.
> +# This command attempts to suspend the guest using three strategies, in this
> +# order:
>   #
> -# For the best results it's strongly recommended to have the pm-utils
> -# package installed in the guest.
> +# - systemd hibernate
> +# - pm-utils (via pm-hibernate)
> +# - manual write into sysfs
> +#
> +# If the guest does not have systemd hibernate support, the scripts in pm-utils
> +# package are executed, in case pm-utils is available. Manual write in sysfs
> +# is a last resort.

Does this paragraph add any information compared to the earlier list?

>   #
>   # This command does NOT return a response on success. There is a high chance
>   # the command succeeded if the VM exits with a zero exit status or, when
> @@ -560,12 +564,16 @@
>   #
>   # Suspend guest to ram.
>   #
> -# This command tries to execute the scripts provided by the pm-utils package.
> -# If it's not available, the suspend operation will be performed by manually
> -# writing to a sysfs file.
> +# This command attempts to suspend the guest using three strategies, in this
> +# order:
> +#
> +# - systemd suspend
> +# - pm-utils (via pm-suspend)
> +# - manual write into sysfs
>   #
> -# For the best results it's strongly recommended to have the pm-utils
> -# package installed in the guest.
> +# If the guest does not have systemd suspend support, the scripts in pm-utils
> +# package are executed, in case pm-utils is available. Manual write in sysfs
> +# is a last resort.

Likewise.

>   #
>   # IMPORTANT: guest-suspend-ram requires QEMU to support the 'system_wakeup'
>   # command.  Thus, it's *required* to query QEMU for the presence of the
> @@ -592,7 +600,14 @@
>   #
>   # Save guest state to disk and suspend to ram.
>   #
> -# This command requires the pm-utils package to be installed in the guest.
> +# This command attempts to suspend the guest using three strategies, in this
> +# order:
> +#
> +# - systemd hybrid-sleep
> +# - pm-utils (via pm-suspend-hybrid)
> +#
> +# If the guest does not have systemd hybrid-sleep support, the scripts in
> +# pm-utils package are executed, in case pm-utils is available.

"using three strategies" but a list of only 2 seems odd.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
