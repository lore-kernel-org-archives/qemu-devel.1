Received: from eggs.gnu.org ([2001:4830:134:3::10]:53940)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fQwX3-0000nu-Gh
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 11:08:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fQwWy-000146-I1
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 11:08:57 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43694 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1fQwWy-00013q-DF
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 11:08:52 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D704C401EF1C
	for <qemu-devel@nongnu.org>; Thu,  7 Jun 2018 15:08:51 +0000 (UTC)
Date: Thu, 7 Jun 2018 17:08:47 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20180607170847.5982cda8@redhat.com>
In-Reply-To: <87muw6wzud.fsf@dusky.pond.sub.org>
References: <20180605122636.33654-1-dgilbert@redhat.com>
	<20180605122636.33654-5-dgilbert@redhat.com>
	<20180607084933.GH750@xz-mi> <87muw6wzud.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 4/6] hmp: Add info commands for preconfig
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: Peter Xu <peterx@redhat.com>, "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>, qemu-devel@nongnu.org

On Thu, 07 Jun 2018 14:22:34 +0200
Markus Armbruster <armbru@redhat.com> wrote:

> Peter Xu <peterx@redhat.com> writes:
> 
> > On Tue, Jun 05, 2018 at 01:26:34PM +0100, Dr. David Alan Gilbert (git) wrote:  
> >> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> >> 
> >> Allow a bunch of the info commands to be used in preconfig.
> >> Could probably add most of them.  
> >
> > I guess some of them may not work yet during preconfig.  E.g.:
> >
> > $ ./x86_64-softmmu/qemu-system-x86_64 -preconfig -monitor stdio
> > QEMU 2.12.50 monitor - type 'help' for more information
> > (qemu) info mtree
> > address-space: memory
> >   0000000000000000-ffffffffffffffff (prio 0, i/o): system
> >
> > address-space: I/O
> >   0000000000000000-000000000000ffff (prio 0, i/o): io
> >
> > But it's fine to enable that I guess.
> >
> > (Which "info" command would you want to use during preconfig?)
> >  
> >> 
> >> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>  
> >
> > Reviewed-by: Peter Xu <peterx@redhat.com>  
> 
> The reason for having -preconfig is us despairing of making -S do the
> right thing.  We'd have to *understand* the tangled mess that is our
> startup, and rearrange it so QMP becomes available early enough for
> configuring NUMA (and other things), yet late enough for everything to
> work.
We solve concrete NUMA problem at -S time as was demonstrated by thread:
"RFC v2 0/4] enable numa configuration before machine  is running from HMP/QMP"
were pros and cons are were summarized. But that won't scale to other things.
 
> -preconfig is a cheap hack to avoid this headache, by bypassing almost
> all of "everything".
hack should allow to move configuration steps to early stage one by one
until the point we could obsolete -S (from configuration point)
without breaking current -S users and clean up start up mess in process.

> Now you bring back some of "everything".  Dangerous.  You better show it
> actually works.  Until you do:
Tested v2, works as expected so far.

> 
> NAK
> 
