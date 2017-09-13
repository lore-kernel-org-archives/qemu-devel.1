Received: from eggs.gnu.org ([2001:4830:134:3::10]:33932)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1dsBI8-0001VZ-9h
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 13:17:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1dsBI4-0006eD-50
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 13:17:36 -0400
References: <1505054255-2990-1-git-send-email-mark.cave-ayland@ilande.co.uk>
	<1505054255-2990-4-git-send-email-mark.cave-ayland@ilande.co.uk>
	<20170911105729.GC2784@umbus.fritz.box>
	<1d0c4384-fc32-05bb-7e42-44480f51610f@ilande.co.uk>
	<20170913071955.GJ7550@umbus.fritz.box>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <03166ac2-6209-9301-16b5-244744d3ebd5@ilande.co.uk>
Date: Wed, 13 Sep 2017 18:17:21 +0100
MIME-Version: 1.0
In-Reply-To: <20170913071955.GJ7550@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 3/4] ppc: add CPU access_type into the
 migration stream
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: aik@ozlabs.ru, lvivier@redhat.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org

On 13/09/17 08:19, David Gibson wrote:

>> When pausing a VM, does execution stop at the end of the current TB
>> rather than immediately? If so, perhaps someone could confirm that
>> guarantee is good enough for access_type?
> 
> I'm pretty sure it has to; we'd have to come up out of an individual
> TB in order to get to the main loop where we check the "please pause"
> flag.  I'm not sure if that helps us here though - I *think* access
> type is about carrying information from the point where we trigger an
> exception to the point where we actually start processing the
> exception.
> 
> This code is really ugly and I've never understood it well :(. It's
> always seemed bogus to me that we have an essentially global variable
> to carry information over that small gap, though.  Unfortunately it's
> unlikely that I'd be able to dive into this and work out if it's
> really needed any time soon.

>From my testing yesterday it does appear to be required for TCG (or
unless this is exposing another bug in the Mac migration) so I can check
it works here and then maybe someone else confirm it works on KVM?

A couple of things I've noticed: the heathrow VMStateDescription looks
good, however I can see that the OpenPIC timers won't likely migrate
correctly without adding a few more fields - that's easy to fix.

Another thing is that if we're changing the migration stream for Mac
models Ben has some OpenPIC and other related changes in his wip queue
that it might make sense to put those in first before properly fixing
the Mac machine migration.


ATB,

Mark.
