Received: from eggs.gnu.org ([2001:4830:134:3::10]:51101)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fI9iS-0007m9-Ui
	for qemu-devel@nongnu.org; Mon, 14 May 2018 05:24:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fI9iN-0003re-Uw
	for qemu-devel@nongnu.org; Mon, 14 May 2018 05:24:24 -0400
Date: Mon, 14 May 2018 11:24:11 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180514112411.68a399fa.cohuck@redhat.com>
In-Reply-To: <20180424101859.10239-1-david@redhat.com>
References: <20180424101859.10239-1-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1] s390x: refactor reset/reipl handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>, Christian Borntraeger <borntraeger@de.ibm.com>, Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On Tue, 24 Apr 2018 12:18:59 +0200
David Hildenbrand <david@redhat.com> wrote:

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

Thanks, applied.
