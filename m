Received: from eggs.gnu.org ([2001:4830:134:3::10]:40140)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1fpjmB-0002u5-MA
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 20:35:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1fpjm8-0002HH-Dw
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 20:35:03 -0400
Date: Tue, 14 Aug 2018 20:34:53 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20180815003453.GA17669@flamenco>
References: <20180813163859.17964-1-cota@braap.org>
	<20180813163859.17964-4-cota@braap.org>
	<19faab37-6728-b649-488e-c6dc2e5be052@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <19faab37-6728-b649-488e-c6dc2e5be052@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 3/3] qom: implement CPU list with an RCU
 QLIST
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>, David Gibson <david@gibson.dropbear.id.au>, Alexander Graf <agraf@suse.de>, Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>, qemu-ppc@nongnu.org

On Tue, Aug 14, 2018 at 08:26:54 +0200, Paolo Bonzini wrote:
> On 13/08/2018 18:38, Emilio G. Cota wrote:
> > Fix it by implementing the CPU list as an RCU QLIST. This requires
> > a little bit of extra work to insert CPUs at the tail of
> > the list and to iterate over the list in reverse order (see previous patch).
> > 
> > One might be tempted to just insert new CPUs at the head of the list.
> > However, I think this might lead to hard-to-debug issues, since it is
> > possible that callers are assuming that CPUs are inserted at the tail
> > (just like spapr code did in the previous patch). So instead of auditing
> > all callers, this patch simply keeps the old behaviour.
> 
> Why not add an RCU_QSIMPLEQ

Because we can't atomically update both head.last and item.next.

> , or even use an array since the quadratic
> behavior should not be an issue?  The advantage of the array is that
> reverse iteration becomes trivial.

I just gave this a shot. IMO implementing CPU_NEXT based on the
array is too ugly to live.

I think the poor man's tail insert + the CPU_FOREACH_REVERSE
are a better compromise.

Thanks,

		Emilio
