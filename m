Received: from eggs.gnu.org ([2001:4830:134:3::10]:49167)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fW336-0000pE-TF
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 13:07:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fW331-00064I-Vi
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 13:07:08 -0400
References: <20180621162506.94416-1-borntraeger@de.ibm.com>
	<57057de1-b1dd-bc22-eb98-1325c499f591@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <159d794c-58b3-ceba-e286-2e585d9a661a@redhat.com>
Date: Thu, 21 Jun 2018 19:06:59 +0200
MIME-Version: 1.0
In-Reply-To: <57057de1-b1dd-bc22-eb98-1325c499f591@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/1] s390/ipl: fix ipl with -no-reboot
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu-s390x <qemu-s390x@nongnu.org>, Thomas Huth <thuth@redhat.com>, Halil Pasic <pasic@linux.vnet.ibm.com>, Janosch Frank <frankja@linux.vnet.ibm.com>, Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>

On 21/06/2018 18:31, David Hildenbrand wrote:
> +    SHUTDOWN_CAUSE_GUEST_RESET_FORCE,/* Guest reset that should ignore
> +                                        --no-reboot. This is useful for reset
> +                                        like actions as s390 kexec/kdump */
>      SHUTDOWN_CAUSE__MAX,
>  } ShutdownCause;
>  
> diff --git a/vl.c b/vl.c
> index b3426e03d0..722c3b9963 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -1674,7 +1674,7 @@ void qemu_system_guest_panicked(GuestPanicInformation *info)
>  
>  void qemu_system_reset_request(ShutdownCause reason)
>  {
> -    if (no_reboot) {
> +    if (no_reboot && reason != SHUTDOWN_CAUSE_GUEST_RESET_FORCE) {
>          shutdown_requested = reason;
>      } else {
>          reset_requested = reason;

The only comment is that I'd drop the event too.  It's not possible to
use SHUTDOWN_CAUSE_NONE directly of course, but you can special case it
in qemu_system_reset.

Also I wouldn't be worried of picking an s390-specific name like
SHUTDOWN_CAUSE_GUEST_(RE)?IPL.  At least it explains exactly what it is
for and it makes sense that it doesn't obey -no-reboot and generate the
event.

Paolo
