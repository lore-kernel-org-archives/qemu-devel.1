Received: from eggs.gnu.org ([2001:4830:134:3::10]:35525)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cE2ww-0004nH-Li
	for qemu-devel@nongnu.org; Mon, 05 Dec 2016 18:45:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cE2wt-00043g-8v
	for qemu-devel@nongnu.org; Mon, 05 Dec 2016 18:45:34 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44678)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1cE2wt-00043L-0I
	for qemu-devel@nongnu.org; Mon, 05 Dec 2016 18:45:31 -0500
Date: Mon, 5 Dec 2016 21:45:27 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20161205234527.GI13060@thinpad.lan.raisama.net>
References: <1480713496-11213-1-git-send-email-ehabkost@redhat.com>
	<d611cf93-06e4-edc1-8012-1501f3b883ad@redhat.com>
	<20161205171135.GG13060@thinpad.lan.raisama.net>
	<2443f74f-ded5-a0e8-38e7-cff9fbab7688@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2443f74f-ded5-a0e8-38e7-cff9fbab7688@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.9 00/17] target-i386: Implement
 query-cpu-model-expansion
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, libvir-list@redhat.com, Markus Armbruster <armbru@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, "Jason J. Herne" <jjherne@linux.vnet.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Igor Mammedov <imammedo@redhat.com>, Jiri Denemark <jdenemar@redhat.com>, Richard Henderson <rth@twiddle.net>

On Mon, Dec 05, 2016 at 07:13:36PM +0100, David Hildenbrand wrote:
> 
> > > Is static really needed? I can understand why migration-safe might be
> > > of interest, but can't see how "static" could help (I mean we have
> > > static expansion for this purpose). Do you have anything special in
> > > mind regarding exposing "static"?
> > 
> > I didn't have any specific use case in mind. My main worry is to
> > avoid letting management software make any assumptions about the
> > returned data. If we don't add an explicit "static" field, a
> > client might make some wrong assumptions just because some
> > conditions are known to be always true on existing
> > implementations. e.g.: a client could incorrectly assume that
> > "query-cpu-model-expansion type=full" of a migration-safe model
> > would always be static.
> 
> I think "migration-safe" makes sense, as the doc currently states for
> "@full": "The produced model is not guaranteed to be migration-safe".
> 
> For static expansion, this information is somewhat superfluous, as
> "static CPU models are migration-safe", but it doesn't hurt. (and this
> is also what you properly documented :) )
> 
> But I don't think that "static" will be of any use. If you want a
> static model, go for "static" expansion. (I don't really see any use
> case here, but if you do, keep it)

Your point is valid, and the field is probably not strictly
necessary. But considering that the interface is not trivial, I
think it is a good thing to have extra metadata that can help
clients validate their assumptions. Even if it's useful in
practice only for debugging, it would be a good reason to add it,
IMO.

I first considered only updating the documentation to make the
guarantees explicit (so people won't assume that type=full
expansion is always a superset of static, or that type=static
expansion is always precise/ABI-compatible and will never lose
any features). But then I thought that returning extra metadata
would help people using the interface (and help us validate the
implementation on the test script).

Anyway, the next version of this series will have the new fields
added by a separate patch. This way we can evaluate and discuss
the interface changes separately.

-- 
Eduardo
