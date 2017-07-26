Received: from eggs.gnu.org ([2001:4830:134:3::10]:60543)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1daUfI-0004P8-1H
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 18:20:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1daUfG-00074j-QX
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 18:20:24 -0400
Date: Wed, 26 Jul 2017 18:20:15 -0400
From: Jeff Cody <jcody@redhat.com>
Message-ID: <20170726222015.GB22129@localhost.localdomain>
References: <20170725155644.20214-1-mreitz@redhat.com>
	<20170725155644.20214-3-mreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170725155644.20214-3-mreitz@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 2/2] iotests: Redirect stderr to stdout in
 186
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org

On Tue, Jul 25, 2017 at 05:56:44PM +0200, Max Reitz wrote:
> Without redirecting qemu's stderr to stdout, _filter_qemu will not apply
> to warnings.  This results in $QEMU_PROG not being replaced by QEMU_PROG
> which is not great if your qemu executable is not called
> qemu-system-x86_64 (e.g. qemu-system-i386).
> 
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>  tests/qemu-iotests/186     |  2 +-
>  tests/qemu-iotests/186.out | 12 ++++++------
>  2 files changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/tests/qemu-iotests/186 b/tests/qemu-iotests/186
> index ab83ee4..2b9f618 100755
> --- a/tests/qemu-iotests/186
> +++ b/tests/qemu-iotests/186
> @@ -56,7 +56,7 @@ function do_run_qemu()
>              done
>          fi
>          echo quit
> -    ) | $QEMU -S -nodefaults -display none -device virtio-scsi-pci -monitor stdio "$@"
> +    ) | $QEMU -S -nodefaults -display none -device virtio-scsi-pci -monitor stdio "$@" 2>&1
>      echo
>  }
>  
> diff --git a/tests/qemu-iotests/186.out b/tests/qemu-iotests/186.out
> index b8bf9a2..c8377fe 100644
> --- a/tests/qemu-iotests/186.out
> +++ b/tests/qemu-iotests/186.out
> @@ -442,28 +442,28 @@ ide0-cd0 (NODE_NAME): null-co:// (null-co, read-only)
>      Cache mode:       writeback
>  (qemu) quit
>  
> -qemu-system-x86_64: -drive if=scsi,driver=null-co: warning: bus=0,unit=0 is deprecated with this machine type
>  Testing: -drive if=scsi,driver=null-co
>  QEMU X.Y.Z monitor - type 'help' for more information
> -(qemu) info block
> +(qemu) QEMU_PROG: -drive if=scsi,driver=null-co: warning: bus=0,unit=0 is deprecated with this machine type
> +info block
>  scsi0-hd0 (NODE_NAME): null-co:// (null-co)
>      Attached to:      /machine/unattached/device[27]/scsi.0/legacy[0]
>      Cache mode:       writeback
>  (qemu) quit
>  
> -qemu-system-x86_64: -drive if=scsi,media=cdrom: warning: bus=0,unit=0 is deprecated with this machine type
>  Testing: -drive if=scsi,media=cdrom
>  QEMU X.Y.Z monitor - type 'help' for more information
> -(qemu) info block
> +(qemu) QEMU_PROG: -drive if=scsi,media=cdrom: warning: bus=0,unit=0 is deprecated with this machine type
> +info block
>  scsi0-cd0: [not inserted]
>      Attached to:      /machine/unattached/device[27]/scsi.0/legacy[0]
>      Removable device: not locked, tray closed
>  (qemu) quit
>  
> -qemu-system-x86_64: -drive if=scsi,driver=null-co,media=cdrom: warning: bus=0,unit=0 is deprecated with this machine type
>  Testing: -drive if=scsi,driver=null-co,media=cdrom
>  QEMU X.Y.Z monitor - type 'help' for more information
> -(qemu) info block
> +(qemu) QEMU_PROG: -drive if=scsi,driver=null-co,media=cdrom: warning: bus=0,unit=0 is deprecated with this machine type
> +info block
>  scsi0-cd0 (NODE_NAME): null-co:// (null-co, read-only)
>      Attached to:      /machine/unattached/device[27]/scsi.0/legacy[0]
>      Removable device: not locked, tray closed
> -- 
> 2.9.4
> 
> 

Reviewed-by: Jeff Cody <jcody@redhat.com>
