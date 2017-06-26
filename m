Received: from eggs.gnu.org ([2001:4830:134:3::10]:43963)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jbeulich@suse.com>) id 1dPNSr-0003i8-2h
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 02:25:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jbeulich@suse.com>) id 1dPNSn-0000zq-45
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 02:25:37 -0400
Received: from prv-mh.provo.novell.com ([137.65.248.74]:53242)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jbeulich@suse.com>) id 1dPNSm-0000yr-S5
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 02:25:33 -0400
Message-Id: <5950A8D802000078001012A1@prv-mh.provo.novell.com>
Date: Mon, 26 Jun 2017 00:25:28 -0600
From: "Jan Beulich" <jbeulich@suse.com>
References: <59492D1C0200007800164AA3@prv-mh.provo.novell.com>
	<59492D1C0200007800164AA3@prv-mh.provo.novell.com>
	<alpine.DEB.2.10.1706201421210.12819@sstabellini-ThinkPad-X260>
	<594A2A1C0200007800164F2A@prv-mh.provo.novell.com>
	<alpine.DEB.2.10.1706211108530.12819@sstabellini-ThinkPad-X260>
	<594B8493020000780016595C@prv-mh.provo.novell.com>
	<alpine.DEB.2.10.1706221146320.12819@sstabellini-ThinkPad-X260>
	<594CEBEF0200007800166189@prv-mh.provo.novell.com>
	<alpine.DEB.2.10.1706231131570.12819@sstabellini-ThinkPad-X260>
In-Reply-To: <alpine.DEB.2.10.1706231131570.12819@sstabellini-ThinkPad-X260>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Subject: Re: [Qemu-devel] [PATCH] xen/disk: don't leak stack data via
 response ring
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: sstabellini@kernel.org
Cc: julien.grall@arm.com, xen-devel@lists.xenproject.org, qemu-devel@nongnu.org

>>> Stefano Stabellini <sstabellini@kernel.org> 06/23/17 8:43 PM >>>
>On Fri, 23 Jun 2017, Jan Beulich wrote:
>> >>> On 22.06.17 at 20:52, <sstabellini@kernel.org> wrote:
>> > I am happy to write the code and/or the commit message. Would a =
simple
>> > cast like below work to fix the security issue?
>>=20
>> I suppose so, but you do realize that this is _exactly_ what
>> my patch does, except you use dangerous casts while I play
>> type-safe?
>
>Why is the cast dangerous?

Casts, and especially pointer ones) are always dangerous, as they have
the potential of type changes elsewhere going unnoticed. You may have
noticed that in reviews I'm often picking at casts, because in a majority
of cases people use them they're not needed and hence their use is a
(latent) risk.

> Both your patch and my version of it rely on
>inner knowledge of the way the rings are laid out in memory, but at
>least my patch doesn't introduce the risk of instantiating broken
>structs. Besides, type safety checks don't add much value, given that we
>rely on the way the ring.h macros have been written, which weren't even
>imported in the QEMU project until March this year.

That's said, as it seems to imply backporting of the change to older
qemu may then be problematic. Otoh I don't recall having had problems
with using the patch with only minor adjustments on older trees of ours.

>These are the reasons why I prefer my version, but I would consider your
>version with clear in-code comments that warn users to avoid
>instantiating the structs because they are not ABI compliant.
>
>How do you want to proceed?

I can provide a version with comments added, but only next week. If you
feel like you want to go with your variant, I won't stand in the way, but =
I
also wouldn't give it my ack or alike (which you don't depend on anyway).

Jan
