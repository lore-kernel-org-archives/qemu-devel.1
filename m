Received: from eggs.gnu.org ([2001:4830:134:3::10]:36286)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cHHUz-0003Gi-7L
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 16:54:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cHHUu-0003GT-Vi
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 16:54:05 -0500
Received: from mx6-phx2.redhat.com ([209.132.183.39]:55186)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cHHUu-0003Fl-Nn
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 16:54:00 -0500
Date: Wed, 14 Dec 2016 16:51:54 -0500 (EST)
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <391977981.4066351.1481752314886.JavaMail.zimbra@redhat.com>
In-Reply-To: <CAH47eN3AVo-4CWN8XHhVz5F811Dc-iS8pVmW+4EW_1mvbpVgpA@mail.gmail.com>
References: <CAH47eN3AVo-4CWN8XHhVz5F811Dc-iS8pVmW+4EW_1mvbpVgpA@mail.gmail.com>
MIME-Version: 1.0
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
To: Alvise Rigo <a.rigo@virtualopensystems.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, chao p peng <chao.p.peng@linux.intel.com>, Claudio Fontana <Claudio.Fontana@huawei.com>, VirtualOpenSystems Technical Team <tech@virtualopensystems.com>


> I am looking at the possibility to add a new QEMU configuration option
> to make TCG optional (in qemu-system-*). What I am exploring is a way
> to exclude any of the TCG code not needed by KVM from the QEMU binary.
> There has been a previous attempt in the past from Paolo Bonzini,
> namely https://github.com/bonzini/qemu/tree/disable-tcg, that
> eventually was not upstreamed. I was looking into this work mainly,
> mostly to understand if the same approach can be respinned and used to
> support all the QEMU's targets. Any input on this is welcome.

Yes, it sure can!  However I suggest doing it one target at a time,
because there can be tricky dependencies between helper files and
KVM support code.  It's fine as long as the configure script only
allows --disable-tcg for specific targets where it works.

IIRC my branch only covered x86 (or maybe PPC too?!?  I don't remember).

The hardest part is making sure that it doesn't bitrot, and it's hard
because we don't have CI for architectures other than x86.  But at least
Peter builds on ARM, and target submaintainers do build on PPC and s390
so it's not that bad perhaps.

> I was also wondering if an approach could be based on the recent patch
> series that allows to use the TCG frontend as a library --
> https://www.mail-archive.com/qemu-devel@nongnu.org/msg415514.html.
> Making qemu-user and qemu-system users of such a library might help in
> having TCG optional. Obviously this solution introduces many other
> challenges and I'm not even sure if it's actually viable.

I think making qemu-system use such a library would be very hard, because
of the different implementation of qemu_ld/qemu_st in user and system
emulation.  I don't think it's important for your purpose.

Paolo
