Received: from eggs.gnu.org ([2001:4830:134:3::10]:40661)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fskhq-0008UJ-Pg
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 04:11:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fskhn-0007k0-Mi
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 04:11:02 -0400
Date: Thu, 23 Aug 2018 10:10:52 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180823101052.0ad09d79.cohuck@redhat.com>
In-Reply-To: <20180822130139.60db0cc1@t450s.home>
References: <153452552631.13804.12031418293966530953.stgit@gimli.home>
	<153452570408.13804.6971118770752634964.stgit@gimli.home>
	<482037fb-60d0-eb3b-a798-4ce5f478bd69@de.ibm.com>
	<20180822114709.1710d6c5@t450s.home>
	<20180822130139.60db0cc1@t450s.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL 1/4] balloon: Allow multiple inhibit users
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Peter Maydell <peter.maydell@linaro.org>, qemu-s390x <qemu-s390x@nongnu.org>, qemu-devel@nongnu.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

On Wed, 22 Aug 2018 13:01:39 -0600
Alex Williamson <alex.williamson@redhat.com> wrote:

> So apparently I assumed too much about the existing balloon inhibitor
> use case, it's clearly not as general as the interface would lead one
> to believe.  The immediate solution is probably to make a postcopy
> specific wrapper around qemu_balloon_inhibit() that keeps a static
> internal state to avoid over incrementing or decrementing.  That should
> resolve this and then we can move on to whether we want to change the
> overall internal interface or fixup some of the other cases noted
> above.  Thanks,
> 
> Alex
> 

My gut feeling is that an interface that allows code to add
yet-another-inhibitor and to remove it again (IOW, what this patch
implemented) is the way to go and that we should push out any checking
whether a inhibitor actually can be removed to the callers.

So, I think it actually makes a lot of sense for the postcopy code to
keep track whether it actually submitted 'its' inhibit and only call
into the generic inhibitor code to release it if that's the case.
