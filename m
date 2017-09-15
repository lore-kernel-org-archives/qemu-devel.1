Received: from eggs.gnu.org ([2001:4830:134:3::10]:38469)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dsndX-0006HC-A2
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 06:14:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dsndW-0008L7-82
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 06:14:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42018)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1dsndW-0008JR-30
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 06:14:14 -0400
From: Cornelia Huck <cohuck@redhat.com>
Date: Fri, 15 Sep 2017 12:14:05 +0200
Message-Id: <20170915101406.27823-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PATCH RFC 0/1] s390x: pci compat handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: borntraeger@de.ibm.com, agraf@suse.de, thuth@redhat.com, david@redhat.com, pmorel@linux.vnet.ibm.com, zyimin@linux.vnet.ibm.com, pasic@linux.vnet.ibm.com, Cornelia Huck <cohuck@redhat.com>

While playing around with compat machines a bit, I noticed that my
zpci detanglement patches broke migration from 2.7 to current master
(2.8 or newer are fine, which is why I did not notice that before.)

qemu 2.7 seems to create a savevm that a s390-next (or master) build
without the s390 phb chokes on:

qemu-system-s390x: Unknown savevm section or instance 'PCIBUS' 0

Creating the s390 phb for compat machines seems to cure this; still
RFC for the following reasons:

- I'm not sure what we're supposed to do on builds without pci. Fail
  creating the compat machines? Do we need a new set of _NOPCI compat
  machines for that?
- I don't understand why 2.7 fails, but 2.8 and later are fine. At
  least, I was not able to spot which commit changed the behaviour
  here... and I really want to understand this. Pointers welcome.
- I have not tested it extensively yet.

Patch is against s390-next.

Cornelia Huck (1):
  s390x/ccw: create s390 phb for compat reasons as well

 hw/s390x/s390-virtio-ccw.c         | 6 +++++-
 include/hw/s390x/s390-virtio-ccw.h | 1 +
 2 files changed, 6 insertions(+), 1 deletion(-)

-- 
2.13.5
