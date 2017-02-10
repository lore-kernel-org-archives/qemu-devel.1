Received: from eggs.gnu.org ([2001:4830:134:3::10]:37609)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ccAKK-0005Wj-BG
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 07:29:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ccAKH-0001FH-7F
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 07:29:24 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47668)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ccAKH-0001Es-1K
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 07:29:21 -0500
References: <20170210014519.12413-1-bobby.prani@gmail.com>
	<52c93dcc-2577-e81f-867c-6159c1f61e91@redhat.com>
	<87zihuw86q.fsf@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <239d2e0e-2087-9135-8946-797d006968f9@redhat.com>
Date: Fri, 10 Feb 2017 13:29:18 +0100
MIME-Version: 1.0
In-Reply-To: <87zihuw86q.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] tcg: handle EXCP_ATOMIC exception properly
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: Pranith Kumar <bobby.prani@gmail.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>, "open list:Overall" <qemu-devel@nongnu.org>



On 10/02/2017 13:18, Alex Benn=C3=A9e wrote:
>> I think you can unlock/lock the iothread here, and also call
>
> The iothread is already unlocked by this point (see tcg_cpu_exec).

Is this patch on top of the MTTCG branch?  If not, cpu_handle_exception
runs with the iothread lock taken doesn't it?

>> cpu_exec_end/start to work around the limitation in start_exclusive.
>
> While that seems right it also seems very messy as it inverts the calls
> so far. I fear we may end up very confused in special casing. Is there =
a
> cleaner way we can unwind this?

I'm not sure what is messy...  cpu_exec_start/end and
start/end_exclusive are fundamentally a rwlock.

Doing

	cpu_exec_end
	start_exclusive
	...
	end_exclusive
	cpu_exec_start

simply means temporarily upgrading the lock from read to write.

Paolo
