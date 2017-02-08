Received: from eggs.gnu.org ([2001:4830:134:3::10]:55023)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1cbWid-0005xJ-JM
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 13:11:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1cbWia-0008B7-EO
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 13:11:51 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54344)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1cbWia-0008Ap-5x
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 13:11:48 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4276D51451
	for <qemu-devel@nongnu.org>; Wed,  8 Feb 2017 18:11:48 +0000 (UTC)
References: <1486575331-14455-1-git-send-email-abologna@redhat.com>
	<1486575331-14455-3-git-send-email-abologna@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <3fa3d4b8-3e3a-d6c4-a2c1-affef7361576@redhat.com>
Date: Wed, 8 Feb 2017 19:11:42 +0100
MIME-Version: 1.0
In-Reply-To: <1486575331-14455-3-git-send-email-abologna@redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v5 2/2] mach-virt: Provide sample
 configuration files
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrea Bolognani <abologna@redhat.com>, qemu-devel@nongnu.org
Cc: marcel@redhat.com, drjones@redhat.com, kraxel@redhat.com

Thanks for the CC!

On 02/08/17 18:35, Andrea Bolognani wrote:

> +# Firmware configuration
> +# =========================================================
> +#
> +# There are two parts to the firmware: a read-only image
> +# containing the executable code, which is shared between
> +# guests, and a read/write variable store that is used by

Apparently omitted:

  one specific virtual machine, exclusively,

Also, I would recommend replacing "used" with "owned".

> +# to record information such as the boot device. An empty

s/boot device/UEFI boot order/

> +# variable store can be created by simply copying a
> +# template provided as part of AAVMF.

How about:

  For any new guest, its permanent, private variable store should
  initially be copied from the template file provided as part of the
  ArmVirtQemu firmware platform (which is occasionally distributed
  under the AAVMF package).

> +#
> +# Depending on the distribution you're using on the host,

I recommend "OS distribution", "Linux distribution", or "GNU/Linux
distribution", as you prefer.

> +# paths to the firmware itself and variable store template

s/firmware/firmware binary/

> +# will be different. Some examples:
> +#
> +# Fedora:
> +#   /usr/share/edk2/aarch64/QEMU_EFI.fd
> +#   /usr/share/edk2/aarch64/QEMU_VARS.fd

Please annotate each as firmware binary & variable store template.

Also, I can't verify the exact pathnames for Fedora.

> +# RHEL:
> +#   /usr/share/AAVMF/AAVMF_CODE.fd
> +#   /usr/share/AAVMF/AAVMF_VARS.fd

Looks legit. (Might want to call "RHEL" "RHELSA" though, in this context
-- no clue. Ask Drew :))

> +
> +[drive "aavmf-code"]

Heh, I never specify "id" for these "-drive"s, but I definitely
appreciate the attention to detail. Let's call it "uefi-binary" though.

> +  file = "/usr/share/edk2/aarch64/QEMU_EFI.fd"  # CHANGE ME

Please replace the comment with

  CHANGE ME ACCORDING TO HOST LINUX DISTRO

or some such

> +  format = "raw"
> +  if = "pflash"
> +  unit = "0"
> +  readonly = "on"
> +
> +[drive "aavmf-vars"]

Let's call this "uefi-varstore".

> +  file = "guest_VARS.fd"                        # CHANGE ME

Many bonus points for providing a file name example that is *different*
from (QEMU|AAVMF)_VARS.fd. It should (and thankfully, does) reflect that
it's already a copy.

Please expand the comment:

  CHANGE ME TO THE NAME OF THE FILE THAT YOU CREATED AS A COPY of THE
  VARSTORE TEMPLATE

> +  format = "raw"
> +  if = "pflash"
> +  unit = "1"

Yes!

I apologize for being too detailed / pedantic about this.

Thanks!
Laszlo
