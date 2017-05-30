Received: from eggs.gnu.org ([2001:4830:134:3::10]:39219)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dFlbP-0004oB-05
	for qemu-devel@nongnu.org; Tue, 30 May 2017 14:10:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dFlbK-0002Bj-1G
	for qemu-devel@nongnu.org; Tue, 30 May 2017 14:10:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35056)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dFlbJ-0002BW-Rn
	for qemu-devel@nongnu.org; Tue, 30 May 2017 14:10:37 -0400
Date: Tue, 30 May 2017 15:10:34 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170530181034.GN32274@thinpad.lan.raisama.net>
References: <20170511191843.13784-1-ehabkost@redhat.com>
	<20170511191843.13784-3-ehabkost@redhat.com>
	<CAFEAcA-jdbDL1uuhM5W=b4qisPsvpJz7aciR8WQebVy43QuBKQ@mail.gmail.com>
	<20170530140103.GI32274@thinpad.lan.raisama.net>
	<5f082e0c-6b89-188f-19d5-dfe476c140fc@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5f082e0c-6b89-188f-19d5-dfe476c140fc@redhat.com>
Subject: Re: [Qemu-devel] [PULL 02/29] numa: Allow setting NUMA distance for
 different NUMA nodes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Igor Mammedov <imammedo@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, He Chen <he.chen@linux.intel.com>

On Tue, May 30, 2017 at 10:28:21AM -0500, Eric Blake wrote:
> On 05/30/2017 09:01 AM, Eduardo Habkost wrote:
> 
> >> The OSX compiler is pickier about format strings than gcc,
> >> and neither "MAX_NODES" nor "MAX(anything)" are uint16_t type.
> > 
> > src and dst are both uint16_t, so MAX(src, dst) is also uint16_t,
> > isn't it?  It looks like MAX_NODES is the problem.
> 
> No. MAX() invokes arithmetic (both ?: and > operators), and arithmetic
> involves default promotion (anything shorter than int becomes 'int').

Oh, I didn't know that.

> 
> > +++ b/numa.c
> > @@ -232,7 +232,7 @@ static void parse_numa_distance(NumaDistOptions *dist, Error **errp)
> >      if (src >= MAX_NODES || dst >= MAX_NODES) {
> >          error_setg(errp,
> >                     "Invalid node %" PRIu16
> > -                   ", max possible could be %" PRIu16,
> > +                   ", max possible could be %d",
> 
> Don't you want %u to match PRIu16, rather than %d?

Can't this (using %u with an int argument) make more pedantic
compilers complain?

-- 
Eduardo
