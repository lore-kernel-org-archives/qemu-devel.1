Received: from eggs.gnu.org ([2001:4830:134:3::10]:54005)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1etYW7-0002h1-RR
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 07:50:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1etYW3-00073R-JA
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 07:49:59 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48172 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1etYW3-00073H-Dl
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 07:49:55 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id EC7188182D17
	for <qemu-devel@nongnu.org>; Wed,  7 Mar 2018 12:49:54 +0000 (UTC)
Date: Wed, 7 Mar 2018 13:49:52 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180307134952.06e877a2.cohuck@redhat.com>
In-Reply-To: <1520342370-123606-20-git-send-email-pbonzini@redhat.com>
References: <1520342370-123606-1-git-send-email-pbonzini@redhat.com>
	<1520342370-123606-20-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL 19/34] address_space_access_valid:
 address_space_to_flatview needs RCU lock
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org

On Tue,  6 Mar 2018 14:19:15 +0100
Paolo Bonzini <pbonzini@redhat.com> wrote:

> address_space_access_valid is calling address_space_to_flatview but it can
> be called outside the RCU lock.  To fix it, push the rcu_read_lock/unlock
> pair up from flatview_access_valid to address_space_access_valid.
> 
> Reviewed-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  exec.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)

This one kills my s390x guests when running under tcg:

qemu-system-s390x: /home/cohuck/git/qemu/include/qemu/rcu.h:89: void rcu_read_unlock(void): Assertion `p_rcu_reader->depth != 0' failed.

Easy to reproduce with the moon buggy image from the QEMU Advent
Calendar:

s390x-softmmu/qemu-system-s390x -M s390-ccw-virtio -nographic -smp 2 -kernel ~/Downloads/s390-moon-buggy/s390-bb.kernel -initrd ~/Downloads/s390-moon-buggy/s390-moon-buggy.initrd

(regardless whether using smp or not)

Backchain:

(gdb) bt
#0  0x00007ffff399d9fb in raise () from /lib64/libc.so.6
#1  0x00007ffff399f800 in abort () from /lib64/libc.so.6
#2  0x00007ffff39960da in __assert_fail_base () from /lib64/libc.so.6
#3  0x00007ffff3996152 in __assert_fail () from /lib64/libc.so.6
#4  0x00005555556a4919 in rcu_read_unlock ()
    at /home/cohuck/git/qemu/include/qemu/rcu.h:89
#5  cpu_exec (cpu=0x555556423f50)
    at /home/cohuck/git/qemu/accel/tcg/cpu-exec.c:740
#6  0x000055555566cbf5 in tcg_cpu_exec (cpu=<optimized out>)
    at /home/cohuck/git/qemu/cpus.c:1341
#7  qemu_tcg_rr_cpu_thread_fn (arg=<optimized out>)
    at /home/cohuck/git/qemu/cpus.c:1435
#8  0x00007ffff3d4336d in start_thread () from /lib64/libpthread.so.0
#9  0x00007ffff3a77b4f in clone () from /lib64/libc.so.6

F26 host, qemu built with clang.
