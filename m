Received: from eggs.gnu.org ([2001:4830:134:3::10]:37225)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1e2Cdw-0003XU-23
	for qemu-devel@nongnu.org; Wed, 11 Oct 2017 04:45:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1e2Cdv-0006Ch-8V
	for qemu-devel@nongnu.org; Wed, 11 Oct 2017 04:45:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51786)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1e2Cdu-0006BE-Px
	for qemu-devel@nongnu.org; Wed, 11 Oct 2017 04:45:31 -0400
Date: Wed, 11 Oct 2017 10:45:23 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20171011104523.7757f70f.cohuck@redhat.com>
In-Reply-To: <20170928203708.9376-25-david@redhat.com>
References: <20170928203708.9376-1-david@redhat.com>
	<20170928203708.9376-25-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 24/30] s390x/tcg: implement STOP and
 RESET interrupts for TCG
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, thuth@redhat.com, Christian Borntraeger <borntraeger@de.ibm.com>, Alexander Graf <agraf@suse.de>, Richard Henderson <richard.henderson@linaro.org>

On Thu, 28 Sep 2017 22:37:02 +0200
David Hildenbrand <david@redhat.com> wrote:

> Implement them like KVM implements/handles them. Both can only be
> triggered via SIGP instructions. RESET has (almos)the lowest priority if

s/(almos)/(almost) /

> the CPU is running, and the highest if the CPU is STOPPED. This is handled
> in SIGP code already. On delivery, we only have to care about the
> "CPU running" scenario.
> 
> STOP is defined to be delivered after all other interrupts have been
> delivered. Therefore it has the actual lowest priority.

How good are we with interrupt priorities in tcg generally? We might
want to care about machine check priority, but that's currently only
partially implemented anyway.

Just making sure we do not run out of things to do in the tcg interrupt
code :)

> 
> As both can wake up a CPU if sleeping, indicate them correctly to
> external code (e.g. cpu_has_work()).
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/cpu.h         |  4 ++++
>  target/s390x/excp_helper.c | 16 +++++++++++++++-
>  target/s390x/helper.c      |  1 +
>  target/s390x/internal.h    |  2 ++
>  target/s390x/interrupt.c   | 32 +++++++++++++++++++++++++++-----
>  target/s390x/sigp.c        |  2 ++
>  6 files changed, 51 insertions(+), 6 deletions(-)
