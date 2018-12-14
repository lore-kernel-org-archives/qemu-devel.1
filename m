Received: from eggs.gnu.org ([2001:4830:134:3::10]:35951)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gXkxZ-0004f6-HR
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 05:44:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gXkxU-0002B0-IR
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 05:44:45 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:34345)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gXkxU-00029e-Bd
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 05:44:40 -0500
Received: by mail-wm1-f66.google.com with SMTP id y185so15932908wmd.1
	for <qemu-devel@nongnu.org>; Fri, 14 Dec 2018 02:44:40 -0800 (PST)
References: <20181213173113.11211-1-armbru@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <8d75d922-5ee8-c313-53ba-308abe971e88@redhat.com>
Date: Fri, 14 Dec 2018 11:44:37 +0100
MIME-Version: 1.0
In-Reply-To: <20181213173113.11211-1-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] error: Remove NULL checks on
 error_propagate() calls
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org

On 12/13/18 6:31 PM, Markus Armbruster wrote:
> Patch created mechanically by rerunning:
> 
>   $  spatch --sp-file scripts/coccinelle/error_propagate_null.cocci \
>             --macro-file scripts/cocci-macro-file.h \
>             --dir . --in-place
> 
> Whitespace tidied up manually.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  blockdev.c              | 4 +---
>  hw/s390x/s390-pci-bus.c | 4 +---
>  qga/commands-posix.c    | 7 ++-----
>  3 files changed, 4 insertions(+), 11 deletions(-)
> 
> diff --git a/blockdev.c b/blockdev.c
> index 81f95d920b..5f2cbe352d 100644
> --- a/blockdev.c
> +++ b/blockdev.c
> @@ -992,9 +992,7 @@ DriveInfo *drive_new(QemuOpts *all_opts, BlockInterfaceType block_default_type,
>      blk = blockdev_init(filename, bs_opts, &local_err);
>      bs_opts = NULL;
>      if (!blk) {
> -        if (local_err) {
> -            error_propagate(errp, local_err);
> -        }
> +        error_propagate(errp, local_err);
>          goto fail;
>      } else {
>          assert(!local_err);
> diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
> index 060ff062bc..98c9d6206a 100644
> --- a/hw/s390x/s390-pci-bus.c
> +++ b/hw/s390x/s390-pci-bus.c
> @@ -731,9 +731,7 @@ static void s390_pcihost_realize(DeviceState *dev, Error **errp)
>  
>      css_register_io_adapters(CSS_IO_ADAPTER_PCI, true, false,
>                               S390_ADAPTER_SUPPRESSIBLE, &local_err);
> -    if (local_err) {
> -        error_propagate(errp, local_err);
> -    }
> +    error_propagate(errp, local_err);
>  }
>  
>  static int s390_pci_msix_init(S390PCIBusDevice *pbdev)
> diff --git a/qga/commands-posix.c b/qga/commands-posix.c
> index 1877976522..2e719d9b6b 100644
> --- a/qga/commands-posix.c
> +++ b/qga/commands-posix.c
> @@ -1573,10 +1573,7 @@ static bool systemd_supports_mode(SuspendMode mode, Error **errp)
>          return true;
>      }
>  
> -    if (local_err) {
> -        error_propagate(errp, local_err);
> -    }
> -
> +    error_propagate(errp, local_err);
>      return false;
>  }
>  
> @@ -1782,7 +1779,7 @@ static void guest_suspend(SuspendMode mode, Error **errp)
>      if (!mode_supported) {
>          error_setg(errp,
>                     "the requested suspend mode is not supported by the guest");
> -    } else if (local_err) {
> +    } else {
>          error_propagate(errp, local_err);
>      }
>  }
> 
