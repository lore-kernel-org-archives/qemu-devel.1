Received: from eggs.gnu.org ([2001:4830:134:3::10]:35960)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cte8I-00060n-MB
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 13:45:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cte8H-0004ro-Nd
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 13:45:14 -0400
Received: from mail-wr0-x22a.google.com ([2a00:1450:400c:c0c::22a]:34884)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cte8H-0004rG-Ge
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 13:45:13 -0400
Received: by mail-wr0-x22a.google.com with SMTP id k6so65317155wre.2
	for <qemu-devel@nongnu.org>; Thu, 30 Mar 2017 10:45:13 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1490892852-6771-1-git-send-email-mdroth@linux.vnet.ibm.com>
References: <1490892852-6771-1-git-send-email-mdroth@linux.vnet.ibm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 30 Mar 2017 18:44:51 +0100
Message-ID: <CAFEAcA_1EzABFdJmK-UbyRXicvQM2uOirdsy8QrfZ2eOK22YyQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH for-2.9] qga: don't fail if mount doesn't
 have slave devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Roth <mdroth@linux.vnet.ibm.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 30 March 2017 at 17:54, Michael Roth <mdroth@linux.vnet.ibm.com> wrote:
> In some cases the slave devices of a virtual block device are tracked
> by the parent in the corresponding sysfs node. For instance, if we
> have a loop-back mount of the form:
>
>   /dev/loop3p1 on /home/mdroth/mnt type ext4 (rw,relatime,data=ordered)
>
> this will be reflected in sysfs as:
>
>   /sys/devices/virtual/block/loop3/
>   ...
>   /sys/devices/virtual/block/loop3/slaves
>   /sys/devices/virtual/block/loop3/loop3p1
>
> The current code however assumes the mounted virtual block device,
> loop3p1 in this case, contains the slaves directory, and reports an
> error otherwise. This breaks 'make check' in certain environments.
>
> Fix this by simply skipping attempts to generate disk topology
> information in these cases. Since this information is documented
> in QAPI as optionally-reported, this should be ok from an API
> perspective.
>
> In the future, this can possibly be improved upon by collecting
> topology information from the parent in these cases.
>
> Reported-by: Peter Maydell <peter.maydell@linaro.org>
> Cc: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
> ---
>  qga/commands-posix.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/qga/commands-posix.c b/qga/commands-posix.c
> index 73d93eb..915df9e 100644
> --- a/qga/commands-posix.c
> +++ b/qga/commands-posix.c
> @@ -999,7 +999,9 @@ static void build_guest_fsinfo_for_virtual_device(char const *syspath,
>      dirpath = g_strdup_printf("%s/slaves", syspath);
>      dir = opendir(dirpath);
>      if (!dir) {
> -        error_setg_errno(errp, errno, "opendir(\"%s\")", dirpath);
> +        if (errno != ENOENT) {
> +            error_setg_errno(errp, errno, "opendir(\"%s\")", dirpath);
> +        }
>          g_free(dirpath);
>          return;
>      }
> --
> 2.7.4

Tested-by: Peter Maydell <peter.maydell@linaro.org>

though only confirming that the test now passes on this sparc box.

thanks
-- PMM
