Received: from eggs.gnu.org ([2001:4830:134:3::10]:58622)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eqklw-0004pi-6Q
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 14:18:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eqkls-0004LM-9Q
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 14:18:44 -0500
Date: Tue, 27 Feb 2018 20:18:19 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180227201819.7818a548.cohuck@redhat.com>
In-Reply-To: <1519744760-12337-1-git-send-email-walling@linux.vnet.ibm.com>
References: <1519744760-12337-1-git-send-email-walling@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] s390-ccw: only print boot menu error if
 -boot menu=on was specified
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Collin L. Walling" <walling@linux.vnet.ibm.com>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, borntraeger@de.ibm.com, thuth@redhat.com, mihajlov@linux.vnet.ibm.com

On Tue, 27 Feb 2018 10:19:20 -0500
"Collin L. Walling" <walling@linux.vnet.ibm.com> wrote:

Nit: make the prefix s390x/ipl:, as this is not directly in the bios.

> It is possible that certain QEMU configurations may not
> create an IPLB (such as when -kernel is provided). In
> this case, a misleading error message will be printed
> stating that the "boot menu is not supported for this
> device type".
> 
> To amend this, only print this message iff boot menu=on
> was provided on the commandline. Otherwise, return silently.
> 
> Signed-off-by: Collin L. Walling <walling@linux.vnet.ibm.com>
> ---
>  hw/s390x/ipl.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c
> index 798e99a..c4addb5 100644
> --- a/hw/s390x/ipl.c
> +++ b/hw/s390x/ipl.c
> @@ -250,7 +250,9 @@ static void s390_ipl_set_boot_menu(S390IPLState *ipl)
>      case S390_IPL_TYPE_QEMU_SCSI:
>          break;
>      default:
> -        error_report("boot menu is not supported for this device type.");
> +        if (boot_menu) {
> +            error_report("boot menu is not supported for this device type.");
> +        }
>          return;
>      }
>  

This change makes sense and works as I'd expect (although the message
is still slightly odd in the -kernel case, but I can't think of
anything better.)

Will you also do a followup removing the trailing punctuation? :)
