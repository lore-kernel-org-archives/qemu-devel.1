Received: from eggs.gnu.org ([2001:4830:134:3::10]:41050)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fbPt2-0003jy-Gs
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 08:30:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fbPt1-0004Ja-DT
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 08:30:56 -0400
Date: Fri, 6 Jul 2018 13:11:03 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180706131103.4e713911.cohuck@redhat.com>
In-Reply-To: <CAFEAcA-RVBXBj=+nr_D=bexLP4Rwgs+xyjJQ8VoOM9aOOVUJ3A@mail.gmail.com>
References: <20180622142513.GH4366@localhost.localdomain>
	<20180622143146.GQ23296@redhat.com>
	<20180625095322.GC18580@redhat.com>
	<20180625114106.GJ5024@localhost.localdomain>
	<20180625114528.GL16514@angien.pipo.sk>
	<20180702080411.GA4299@localhost.localdomain>
	<60f6bf3c-6cad-c86f-01d7-8c376a6ccfe0@de.ibm.com>
	<20180703111949.GB24516@redhat.com>
	<20180703113229.GD3812@localhost.localdomain>
	<20180704150256.408d4a07.cohuck@redhat.com>
	<20180704133440.GE4334@localhost.localdomain>
	<CAFEAcA-RVBXBj=+nr_D=bexLP4Rwgs+xyjJQ8VoOM9aOOVUJ3A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [libvirt] [PULL 25/26] block: Remove deprecated
 -drive option serial
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Kevin Wolf <kwolf@redhat.com>, "Daniel P. =?UTF-8?B?QmVycmFuZ8Op?=" <berrange@redhat.com>, Boris Fiuczynski <fiuczy@linux.ibm.com>, Qemu-block <qemu-block@nongnu.org>, Libvirt <libvir-list@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Peter Krempa <pkrempa@redhat.com>

On Wed, 4 Jul 2018 17:14:02 +0100
Peter Maydell <peter.maydell@linaro.org> wrote:

> On 4 July 2018 at 14:34, Kevin Wolf <kwolf@redhat.com> wrote:
> > Essentially, what is important to me isn't getting these options dropped
> > exactly in 3.0, but not setting a bad precedence that deprecation isn't
> > actually worth anything. We may easily end up with this deprecation
> > process:
> >
> > depreate a feature
> > release QEMU version n + 1
> > release QEMU version n + 2
> > remove the feature
> > while libvirt hasn't removed use of the feature:
> >     # ...and why should it when everything is still working?
> >     reinstate the feature
> >     release QEMU version n + x
> >     remove the feature  
> 
> My take on the deprecation policy essentially is that it gives
> us a *minimum* bar for how soon we can drop something. We
> shouldn't be using it as an "always target this speed for
> dropping something" -- we ought to be pragmatic. We can
> drop stuff that's unused quickly, but should be slower
> for things that still have major users (or reconsider
> the deprecation entirely, potentially). There should be
> a balance between making our work as developers easier and
> inconveniencing our users.

What about the following?

- put a feature on the "normal" deprecation list to remove after two
  releases
Case (a): nobody complains, either within the deprecation period or
when it is finally removed
  -> all is good
Case (b): the feature turns out to be widely used, and/or it turns out
that it offers value that currently can't be offered easily in another
way
  -> remove from deprecation list; this obviously needs more thinking
Case (c): the feature is used, the users are willing to move away from
it, but they need a bit more time
  -> put it on a "deprecation watchlist", listing the users we are
  waiting for, and then remove after all are done (no +2)

That way, we can still easily remove old cruft (case (a)), but still
accommodate cases like this (case (c)). The obvious drawback is that
we'd need someone to curate the deprecation watchlist, to poke the
users we're waiting for, and probably remove anyway after some time if
they don't get their act together.

> 
> In this particular case, reverting this deletion seems like
> a fairly easy call to me.
> 
> We should also definitely work on improving how we can
> let management-layer developers easily test that they're
> not accidentally relying on deprecated features, certainly
> (and also on better documentation for command line users
> of how to switch away from deprecated features -- for
> instance I am still using -redir in some of my scripts
> because the warning about it being deprecated is not
> precise about what exact command line option can be used
> instead, especially for the case where the ethernet device
> is builtin rather than created with -device...)

Yes, this as well.
