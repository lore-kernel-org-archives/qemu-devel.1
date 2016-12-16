Received: from eggs.gnu.org ([2001:4830:134:3::10]:56605)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <a.rigo@virtualopensystems.com>) id 1cHr1a-0005JD-C1
	for qemu-devel@nongnu.org; Fri, 16 Dec 2016 06:50:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <a.rigo@virtualopensystems.com>) id 1cHr1W-0008KN-Co
	for qemu-devel@nongnu.org; Fri, 16 Dec 2016 06:50:06 -0500
Received: from mail-it0-x243.google.com ([2607:f8b0:4001:c0b::243]:36678)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <a.rigo@virtualopensystems.com>)
	id 1cHr1W-0008Jp-8c
	for qemu-devel@nongnu.org; Fri, 16 Dec 2016 06:50:02 -0500
Received: by mail-it0-x243.google.com with SMTP id n68so2274483itn.3
	for <qemu-devel@nongnu.org>; Fri, 16 Dec 2016 03:50:00 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <391977981.4066351.1481752314886.JavaMail.zimbra@redhat.com>
References: <CAH47eN3AVo-4CWN8XHhVz5F811Dc-iS8pVmW+4EW_1mvbpVgpA@mail.gmail.com>
	<391977981.4066351.1481752314886.JavaMail.zimbra@redhat.com>
From: Alvise Rigo <a.rigo@virtualopensystems.com>
Date: Fri, 16 Dec 2016 12:49:44 +0100
Message-ID: <CAH47eN3roJHEezvR_ijdiS36kQaKLUCd-8h4uiGeFT1CUp3Qgg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] Making TCG configurable in system mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, chao p peng <chao.p.peng@linux.intel.com>, Claudio Fontana <Claudio.Fontana@huawei.com>, VirtualOpenSystems Technical Team <tech@virtualopensystems.com>

On Wed, Dec 14, 2016 at 10:51 PM, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
>> I am looking at the possibility to add a new QEMU configuration option
>> to make TCG optional (in qemu-system-*). What I am exploring is a way
>> to exclude any of the TCG code not needed by KVM from the QEMU binary.
>> There has been a previous attempt in the past from Paolo Bonzini,
>> namely https://github.com/bonzini/qemu/tree/disable-tcg, that
>> eventually was not upstreamed. I was looking into this work mainly,
>> mostly to understand if the same approach can be respinned and used to
>> support all the QEMU's targets. Any input on this is welcome.
>
> Yes, it sure can!  However I suggest doing it one target at a time,
> because there can be tricky dependencies between helper files and

Indeed, doing it gradually is the right way to tackle it. I might be
back with some more concrete work. Thank you for the time being.

> KVM support code.  It's fine as long as the configure script only
> allows --disable-tcg for specific targets where it works.
>
> IIRC my branch only covered x86 (or maybe PPC too?!?  I don't remember).
>
> The hardest part is making sure that it doesn't bitrot, and it's hard
> because we don't have CI for architectures other than x86.  But at least
> Peter builds on ARM, and target submaintainers do build on PPC and s390
> so it's not that bad perhaps.

Would a CI set up just to test this feature make sense?

Thank you,
alvise

>
>> I was also wondering if an approach could be based on the recent patch
>> series that allows to use the TCG frontend as a library --
>> https://www.mail-archive.com/qemu-devel@nongnu.org/msg415514.html.
>> Making qemu-user and qemu-system users of such a library might help in
>> having TCG optional. Obviously this solution introduces many other
>> challenges and I'm not even sure if it's actually viable.
>
> I think making qemu-system use such a library would be very hard, because
> of the different implementation of qemu_ld/qemu_st in user and system
> emulation.  I don't think it's important for your purpose.
>
> Paolo
