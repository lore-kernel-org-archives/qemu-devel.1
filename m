Received: from eggs.gnu.org ([2001:4830:134:3::10]:56163)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1frJf3-0000T9-JS
	for qemu-devel@nongnu.org; Sun, 19 Aug 2018 05:06:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1frJf0-0006UV-Fa
	for qemu-devel@nongnu.org; Sun, 19 Aug 2018 05:06:13 -0400
Date: Sun, 19 Aug 2018 05:06:00 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20180819090600.GA22009@flamenco>
References: <20180813163859.17964-1-cota@braap.org>
	<20180813163859.17964-4-cota@braap.org>
	<19faab37-6728-b649-488e-c6dc2e5be052@redhat.com>
	<20180815003453.GA17669@flamenco>
	<b911148a-a4b2-b1e9-8e88-b6785def533d@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b911148a-a4b2-b1e9-8e88-b6785def533d@redhat.com>
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

On Fri, Aug 17, 2018 at 19:53:40 +0200, Paolo Bonzini wrote:
> On 15/08/2018 02:34, Emilio G. Cota wrote:
> > On Tue, Aug 14, 2018 at 08:26:54 +0200, Paolo Bonzini wrote:
> >> On 13/08/2018 18:38, Emilio G. Cota wrote:
> >>> Fix it by implementing the CPU list as an RCU QLIST. This requires
> >>> a little bit of extra work to insert CPUs at the tail of
> >>> the list and to iterate over the list in reverse order (see previous patch).
> >>>
> >>> One might be tempted to just insert new CPUs at the head of the list.
> >>> However, I think this might lead to hard-to-debug issues, since it is
> >>> possible that callers are assuming that CPUs are inserted at the tail
> >>> (just like spapr code did in the previous patch). So instead of auditing
> >>> all callers, this patch simply keeps the old behaviour.
> >>
> >> Why not add an RCU_QSIMPLEQ
> > 
> > Because we can't atomically update both head.last and item.next.
> 
> Why do you need that?  Updates are protected by a mutex in RCU-protected
> lists, it is not necessary to make them atomic.  Also, feel free to
> implement a subset of the write-side macros, for example only
> INSERT_{HEAD,TAIL,AFTER} and REMOVE_HEAD.

Yes I got confused, was thinking you wanted to support the
reverse traversal (simpleq doesn't even have the reverse pointers,
so I don't know how I reached that conclusion).

v2 incoming.

Thanks,

		E.
