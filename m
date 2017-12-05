Received: from eggs.gnu.org ([2001:4830:134:3::10]:43111)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eMD81-0004e2-OG
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 08:19:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eMD7y-0001cQ-J6
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 08:19:17 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57950)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1eMD7y-0001bt-Cg
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 08:19:14 -0500
References: <CAFEAcA_ffAw2jz9Sp-hxi_ZvdVjCYynk_0Lk2zFOSCMqCpHgxA@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <ed43c37b-712a-ea16-85d8-3baee67c560c@redhat.com>
Date: Tue, 5 Dec 2017 14:19:10 +0100
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_ffAw2jz9Sp-hxi_ZvdVjCYynk_0Lk2zFOSCMqCpHgxA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] deadlock in rcu_init_lock() in usermode emulation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>

On 04/12/2017 18:13, Peter Maydell wrote:
> Hi; in https://bugs.linaro.org/show_bug.cgi?id=3D3259 comment 27
> Stuart provides backtraces of a deadlock in user-mode in the RCU
> code.
>=20
> How should this deadlock be broken ?

Summing up:

- fork thread: has mmap_lock, waits for rcu_sync_lock

- RCU thread: has rcu_sync_lock, waits for rcu_read_(un)lock

- another CPU thread: in RCU critical section, waits for mmap_lock

Probably the best solution is to add start_exclusive/end_exclusive
respectively at the beginning and the end of fork_start and fork_end.
This is safer in general, as it ensures that the disappeared child
threads were quiescent.

In fact, I wonder if fork_start/fork_end still need to "take all
mutexes" (in pthread_atfork style) if we do
start_exclusive/end_exclusive in fork_start and fork_end(0).  You don't
even need to reinitialize the mutexes, meaning that mmap_fork_start and
mmap_fork_end should go as well.

The list of locks that are "assured not taken" within
start_exclusive/end_exclusive (currently: rcu_read_lock, tb_lock,
mmap_lock) should probably be documented in fork_start/fork_end.

Thanks,

Paolo
