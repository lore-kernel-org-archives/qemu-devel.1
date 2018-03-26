Received: from eggs.gnu.org ([2001:4830:134:3::10]:53850)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1f0OYi-0004TM-9P
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 05:36:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1f0OYd-0007rx-Cb
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 05:36:56 -0400
References: <20180326092036.12780-1-david@redhat.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <abd0dd45-f42f-7071-986c-24de5f845bc3@redhat.com>
Date: Mon, 26 Mar 2018 11:36:41 +0200
MIME-Version: 1.0
In-Reply-To: <20180326092036.12780-1-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH RFC] s390x/kvm: call
 cpu_synchronize_state() on every kvm_arch_handle_exit()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-s390x@nongnu.org
Cc: qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>, Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Thomas Huth <thuth@redhat.com>

On 26.03.2018 11:20, David Hildenbrand wrote:
> Manually having to use cpu_synchronize_state() is error prone. I don't
> think that the performance impact is that huge if we simply synchronize
> the state on every kvm_arch_handle_exit() call. This makes the code
> easier to maintain.
> 
> We now also call it (although not neded) for
> - KVM_EXIT_S390_RESET -> s390_reipl_request()
> - KVM_EXIT_DEBUG -> kvm_arch_handle_debug_exit()
> - unmanagable/unimplemented intercepts
> - ICPT_WAITPSW -> s390_handle_wait() -> cpu gets halted

Just noticed that this one is actually also already called :)

> - ICPT_CPU_STOP -> do_stop_interrupt() -> cpu gets halted
> - Scenarios where we inject an operation exception
> - handle_sigp() on the source CPU

And this one, too.

> - handle_stsi()

-- 

Thanks,

David / dhildenb
