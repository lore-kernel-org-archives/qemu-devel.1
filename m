Received: from eggs.gnu.org ([2001:4830:134:3::10]:50939)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fGQCY-00067L-Cb
	for qemu-devel@nongnu.org; Wed, 09 May 2018 10:36:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fGQCU-0005e8-FL
	for qemu-devel@nongnu.org; Wed, 09 May 2018 10:36:18 -0400
Date: Wed, 9 May 2018 16:36:07 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180509163607.499e13af.cohuck@redhat.com>
In-Reply-To: <7c418965-f96f-fbbc-0010-8dd853280f6b@redhat.com>
References: <20180424101859.10239-1-david@redhat.com>
	<7c418965-f96f-fbbc-0010-8dd853280f6b@redhat.com>
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

On Wed, 9 May 2018 16:15:38 +0200
David Hildenbrand <david@redhat.com> wrote:

> On 24.04.2018 12:18, David Hildenbrand wrote:
> > Calling pause_all_vcpus()/resume_all_vcpus() from a VCPU thread might
> > not be the best idea. As pause_all_vcpus() temporarily drops the qemu
> > mutex, two parallel calls to pause_all_vcpus() can be active at a time,
> > resulting in a deadlock. (either by two VCPUs or by the main thread and a
> > VCPU)
> > 
> > Let's handle it via the main loop instead, as suggested by Paolo. If we
> > would have two parallel reset requests by two different VCPUs at the
> > same time, the last one would win.
> > 
> > We use the existing ipl device to handle it. The nice side effect is
> > that we can get rid of reipl_requested.
> > 
> > This change implies that all reset handling now goes via the common
> > path, so "no-reboot" handling is now active for all kinds of reboots.
> > 
> > Let's execute any CPU initialization code on the target CPU using
> > run_on_cpu.
> > 
> > Signed-off-by: David Hildenbrand <david@redhat.com>
> > ---
> > 
> > RFC -> v1:
> > - initital -> initial
> > - get rid of goto
> > - store CPU index instead of CPU. Fallback to any CPU in case not found
> > - handle default case in switch-case  
> 
> Very friendly ping :)

I'm currently inclined to just go ahead and merge it -- so if anyone
still wants to provide review, now's the time :)
