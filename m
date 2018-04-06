Received: from eggs.gnu.org ([2001:4830:134:3::10]:42624)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1f4Ny3-0002ac-GX
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 05:47:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1f4Ny0-0003u1-DK
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 05:47:35 -0400
Date: Fri, 6 Apr 2018 11:47:26 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180406114726.771d703c.cohuck@redhat.com>
In-Reply-To: <1522940844-12336-1-git-send-email-mihajlov@linux.vnet.ibm.com>
References: <1522940844-12336-1-git-send-email-mihajlov@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 0/3] s390: Fix virtio-scsi IPL quirks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>
Cc: borntraeger@de.ibm.com, agraf@suse.de, rth@twiddle.net, david@redhat.com, thuth@redhat.com, qemu-devel@nongnu.org, qemu-s390x@nongnu.org

On Thu,  5 Apr 2018 17:07:21 +0200
Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com> wrote:

> IPL from virtio-scsi currently uses a non-standard parameter
> type definition to pass boot parameters from QEMU to the
> BIOS.
> 
> There are two potential issues with this approach:
> o If the guest operating systems requests a re-ipl of type CCW
>   where the boot device is a virtio-scsi HBA, this goes unnoticed
>   by QEMU. The BIOS will detect that it's IPLing from a SCSI
>   device, but it will boot the first LUN found, which might not
>   be the one used for the initial boot.
> o The guest operating system can be confused by an unknown
>   IPL parameter block type. If the OS hasn't previously used 
>   diag308 to store the IPL info but is changed to do so, a
>   user-observable change in behavior will happen.
> 
> The following patches address the issues above. 
> 
> Viktor Mihajlovski (3):
>   s390: Refactor IPL parameter block generation
>   s390: Ensure IPL from SCSI works as expected
>   s390: Do not pass inofficial IPL type to the guest
> 
>  hw/s390x/ipl.c             | 112 ++++++++++++++++++++++++++++++++-------------
>  pc-bios/s390-ccw/bootmap.c |   7 +++
>  pc-bios/s390-ccw/iplb.h    |  15 +++++-
>  3 files changed, 100 insertions(+), 34 deletions(-)
> 

This looks reasonable enough to queue for 2.12 (with a bios rebuild),
especially as I also plan to queue the cpu_synchronize_state() patch.
Just waiting for a R-b on the bios part.
