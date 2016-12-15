Received: from eggs.gnu.org ([2001:4830:134:3::10]:60107)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1cHSCK-0007d2-R4
	for qemu-devel@nongnu.org; Thu, 15 Dec 2016 04:19:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1cHSCJ-0003bN-8T
	for qemu-devel@nongnu.org; Thu, 15 Dec 2016 04:19:32 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50172)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lvivier@redhat.com>) id 1cHSCJ-0003ad-3R
	for qemu-devel@nongnu.org; Thu, 15 Dec 2016 04:19:31 -0500
References: <CAH47eN3AVo-4CWN8XHhVz5F811Dc-iS8pVmW+4EW_1mvbpVgpA@mail.gmail.com>
From: Laurent Vivier <lvivier@redhat.com>
Message-ID: <6970101a-5eff-9f77-86ec-c142937c1000@redhat.com>
Date: Thu, 15 Dec 2016 10:19:27 +0100
MIME-Version: 1.0
In-Reply-To: <CAH47eN3AVo-4CWN8XHhVz5F811Dc-iS8pVmW+4EW_1mvbpVgpA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] Making TCG configurable in system mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alvise Rigo <a.rigo@virtualopensystems.com>, QEMU Developers <qemu-devel@nongnu.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, VirtualOpenSystems Technical Team <tech@virtualopensystems.com>, Claudio Fontana <Claudio.Fontana@huawei.com>, chao.p.peng@linux.intel.com



On 14/12/2016 20:30, Alvise Rigo wrote:
> Hi all,
> 
> I am looking at the possibility to add a new QEMU configuration option
> to make TCG optional (in qemu-system-*). What I am exploring is a way
> to exclude any of the TCG code not needed by KVM from the QEMU binary.
> There has been a previous attempt in the past from Paolo Bonzini,
> namely https://github.com/bonzini/qemu/tree/disable-tcg, that
> eventually was not upstreamed. I was looking into this work mainly,
> mostly to understand if the same approach can be respinned and used to
> support all the QEMU's targets. Any input on this is welcome.
> 
> I was also wondering if an approach could be based on the recent patch
> series that allows to use the TCG frontend as a library --
> https://www.mail-archive.com/qemu-devel@nongnu.org/msg415514.html.
> Making qemu-user and qemu-system users of such a library might help in
> having TCG optional. Obviously this solution introduces many other
> challenges and I'm not even sure if it's actually viable.

To have a library has also another interest: testing.

For the moment RISU is doing a great job but it needs to be able to
start a client (the apprentice) in a chroot. So it requires a "viable"
TCG implementation.

If we would have a library we could directly link the "apprentice" with
the library and it will inject the code to test directly (without
chroot) in the TCG engine. Moreover, I think we could use single-step
instead of trap to synchronize master and apprentice.

We had something like that to test 680x0 [1], but the main program was
written in C++ compiling some parts of QEMU inside, and I failed to
recompile it last time I tried (I use RISU now).

Thanks,
Laurent
[1] https://github.com/vivier/m68k-tester
