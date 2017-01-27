Received: from eggs.gnu.org ([2001:4830:134:3::10]:37436)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1cX35s-00085y-82
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 04:45:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1cX35p-0001Bu-6b
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 04:45:20 -0500
References: <20170126204547.9418-1-lvivier@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <1039c044-37dd-df1d-4f83-ccb10acfc1cd@redhat.com>
Date: Fri, 27 Jan 2017 10:45:12 +0100
MIME-Version: 1.0
In-Reply-To: <20170126204547.9418-1-lvivier@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] spapr: clock should count only if vm is
 running
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <lvivier@redhat.com>, qemu-devel@nongnu.org
Cc: David Gibson <david@gibson.dropbear.id.au>, Paolo Bonzini <pbonzini@redhat.com>, Alexander Graf <agraf@suse.de>, Marcelo Tosatti <mtosatti@redhat.com>, qemu-ppc@nongnu.org, Alexey Kardashevskiy <aik@ozlabs.ru>

On 26.01.2017 21:45, Laurent Vivier wrote:
> This is a port to ppc of the i386 commit:
>     00f4d64 kvmclock: clock should count only if vm is running
> 
> We remove timebase_/pre_save/post_load/ functions,
> and use the VM state change handler to save and restore
> the guest_timebase (on stop and continue).
> 
> Time base offset has originally been introduced by commit
>     98a8b52 spapr: Add support for time base offset migration
> 
> So while VM is paused, the time is stopped. This allows to have
> the same result with date (based on Time Base Register) and
> hwclock (based on "get-time-of-day" RTAS call).
> 
> Moreover in TCG mode, the Time Base is always paused, so this
> patch also adjust the behavior between TCG and KVM.
> 
> VM state field "time_of_the_day_ns" is now useless but we keep
> it to be able to migrate to older version of the machine.

Not sure, but the cpu_ppc_clock_vm_state_change() handler is only used
with KVM, isn't it? So what happens if you migrate in TCG mode from a
new QEMU to an older one? Don't you have to update time_of_the_day_ns
here somewhere, too (e.g. in a pre_save handler)?

 Thomas
