Received: from eggs.gnu.org ([2001:4830:134:3::10]:60014)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fGSO7-00047W-5W
	for qemu-devel@nongnu.org; Wed, 09 May 2018 12:56:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fGSO6-0007Zz-8g
	for qemu-devel@nongnu.org; Wed, 09 May 2018 12:56:23 -0400
References: <20180424101859.10239-1-david@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <b8fc8628-8006-4485-f1eb-2c2ae69f6825@redhat.com>
Date: Wed, 9 May 2018 18:56:17 +0200
MIME-Version: 1.0
In-Reply-To: <20180424101859.10239-1-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH v1] s390x: refactor
 reset/reipl handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, qemu-s390x@nongnu.org
Cc: Cornelia Huck <cohuck@redhat.com>, Alexander Graf <agraf@suse.de>, qemu-devel@nongnu.org, Christian Borntraeger <borntraeger@de.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>

On 24.04.2018 12:18, David Hildenbrand wrote:
> Calling pause_all_vcpus()/resume_all_vcpus() from a VCPU thread might
> not be the best idea. As pause_all_vcpus() temporarily drops the qemu
> mutex, two parallel calls to pause_all_vcpus() can be active at a time,
> resulting in a deadlock. (either by two VCPUs or by the main thread and a
> VCPU)
> 
> Let's handle it via the main loop instead, as suggested by Paolo. If we
> would have two parallel reset requests by two different VCPUs at the
> same time, the last one would win.
> 
> We use the existing ipl device to handle it. The nice side effect is
> that we can get rid of reipl_requested.
> 
> This change implies that all reset handling now goes via the common
> path, so "no-reboot" handling is now active for all kinds of reboots.
> 
> Let's execute any CPU initialization code on the target CPU using
> run_on_cpu.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
> 
> RFC -> v1:
> - initital -> initial
> - get rid of goto
> - store CPU index instead of CPU. Fallback to any CPU in case not found
> - handle default case in switch-case
> 
>  hw/s390x/ipl.c                     | 43 +++++++++++++++++++++++----
>  hw/s390x/ipl.h                     | 16 ++++++++--
>  hw/s390x/s390-virtio-ccw.c         | 51 ++++++++++++++++++++++++++-----
>  include/hw/s390x/s390-virtio-ccw.h |  2 --
>  target/s390x/cpu.h                 | 26 ++++++++++++++++
>  target/s390x/diag.c                | 61 +++-----------------------------------
>  target/s390x/internal.h            |  6 ----
>  target/s390x/kvm.c                 |  2 +-
>  8 files changed, 127 insertions(+), 80 deletions(-)

I'm not an expert in all this s390x reset stuff, but as far as I can
see, this looks sane.

Acked-by: Thomas Huth <thuth@redhat.com>
