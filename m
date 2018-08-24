Received: from eggs.gnu.org ([2001:4830:134:3::10]:38940)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1ftAPo-000886-9H
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 07:38:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1ftAPl-0005uQ-2E
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 07:38:08 -0400
Date: Fri, 24 Aug 2018 13:37:57 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180824133757.1cbdba75.cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [RFD] [s390x] Tweaking the s390x maintainership setup
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Thomas Huth <thuth@redhat.com>, Alexander Graf <agraf@suse.de>, David Hildenbrand <david@redhat.com>, Richard Henderson <rth@twiddle.net>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org

Hi all,

while I think the current s390x maintainership setup is working quite
well, there's probably still room for improvement. In particular, I'd
like to spread out the work a bit more and make it easy to test things
pre-integration in an automated way.

As a recap, how it works today:

- We have designated maintainers for some major areas:
  * tcg
  * KVM
  * s390 virtio-ccw machine
  * s390 bios
  * vfio-ccw
  * virtio-ccw

- I'm acting as overall s390x maintainer, queuing patches onto my
  s390-next branch (s390-fixes for fixes during freeze) and sometimes
  pulling s390 bios updates (if I don't apply them myself). I'm
  generally the only person that sends pull requests for master.

Some problems I've noted:

* The bus factor -- or, put in a less dramatic way, what happens when
  I'm sick or on vacation? For fixes during freeze, there's no problem
  if the other maintainers submit them directly, but I really don't want
  to be the single point of failure (plus, I'm the only person listed
  as vfio-ccw maintainer).
* The IBM folks can't do tcg.
* Conversely, the non-IBM folks cannot review things that don't have
  public documentation (yet), other than in a very general way.
* I don't want to pick everything myself :) Especially when I basically
  rely on other people noticing problems in the first place (like with
  the non-public things or code areas I'm not so familiar with).
* Testing seems to be a bit ad hoc. It would be nice to have a branch
  that (semi) automated tests can be run on before things hit upstream,
  and that is also created on top of current master. (I usually only
  rebase the pushed-out s390-next branch when I apply new patches, and
  sometimes not even then.) Oh, and other people testing things,
  especially on different hardware.

So, here are some ideas I had on how to improve things:

* Split up maintainership a bit more. For example, split out areas like
  pci for which no public documentation is available; these need to
  have at least one IBM maintainer. Another candidate would maybe be
  the cpu model.
* On a related note, more maintainers from IBM would be nice :) For
  example, for vfio-ccw, where I'm the only maintainer... Some R:
  entries would not hurt, either.
* More trees to pull from. Of course, not every area needs a dedicated
  tree (that would become silly pretty quickly), but for example a tcg
  tree would be nice. I can still pick individual patches if a pull
  request would be overkill.
* I'd also like to have a designated backup for the overall
  maintainership, especially for when I'm on vacation (like the first
  two weeks of September, just to let you know :) or otherwise
  unavailable, but also for sanity. Likely needs to be a non-IBMer due
  to the tcg problem.
* A more predictable s390-next would be nice. Maybe have it
  (semi-)automatically created out of the different trees, on top of
  current master? I would start to apply patches on a new branch that
  feeds into s390-next rather than on s390-next directly, then.
* Do something about (semi-)consolidated, (semi-)automatic testing.
  Like hooking into Travis (or something similar), sharing test setups,
  and enabling tests to be run on a range of platforms (including very
  recent ones). Testing is probably a large topic on its own, though.

Thoughts?
