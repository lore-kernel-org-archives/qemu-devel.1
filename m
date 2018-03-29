Received: from eggs.gnu.org ([2001:4830:134:3::10]:33339)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1f1TZC-0001aP-2w
	for qemu-devel@nongnu.org; Thu, 29 Mar 2018 05:09:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1f1TZ8-0005o5-2w
	for qemu-devel@nongnu.org; Thu, 29 Mar 2018 05:09:54 -0400
Received: from 13.mo7.mail-out.ovh.net ([87.98.150.175]:56033)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1f1TZ7-0005iK-S5
	for qemu-devel@nongnu.org; Thu, 29 Mar 2018 05:09:50 -0400
Received: from player729.ha.ovh.net (unknown [10.109.120.13])
	by mo7.mail-out.ovh.net (Postfix) with ESMTP id 9007699B5C
	for <qemu-devel@nongnu.org>; Thu, 29 Mar 2018 11:09:41 +0200 (CEST)
From: Greg Kurz <groug@kaod.org>
Date: Thu, 29 Mar 2018 11:09:25 +0200
Message-ID: <152231456507.69730.15601462044394150786.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH 0/3] fix memory leaks when using
 object_property_get_str()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>, Cornelia Huck <cohuck@redhat.com>, Alexander Graf <agraf@suse.de>, David Hildenbrand <david@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, qemu-s390x@nongnu.org, qemu-stable@nongnu.org

According to include/qom/object.h:

/**
 * object_property_get_str:
 * @obj: the object
 * @name: the name of the property
 * @errp: returns an error if this function fails
 *
 * Returns: the value of the property, converted to a C string, or NULL if
 * an error occurs (including when the property value is not a string).
 * The caller should free the string.
 */

So I've checked all the call sites and found three places where the
string is obviously [*] leaked. Patch 2 and 3 fix very recent 2.12
commits, while patch 1 fixes a 2.4 commit (backported to 2.3.1).

Another potential candidate sits in query_memdev(), called during
the "info memdev" HMP and the "query-memdev" QMP commands, but
both take care of freeing the string eventually. Nothing to fix
there.

[*] allocated string is put in a local variable and not freed before
    returning

--
Greg

---

Greg Kurz (3):
      exec: fix memory leak in find_max_supported_pagesize()
      hw/s390x: fix memory leak in s390_init_ipl_dev()
      sev/i386: fix memory leak in sev_guest_init()


 exec.c                     |    1 +
 hw/s390x/s390-virtio-ccw.c |    5 ++++-
 target/i386/sev.c          |    4 +++-
 3 files changed, 8 insertions(+), 2 deletions(-)
