Received: from eggs.gnu.org ([2001:4830:134:3::10]:55377)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dUago-0005R6-SZ
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 11:33:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dUago-0003V6-2y
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 11:33:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53184)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dUagn-0003UW-T5
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 11:33:34 -0400
Date: Mon, 10 Jul 2017 12:33:31 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170710153331.GC5167@localhost.localdomain>
References: <20170707213052.13087-1-ehabkost@redhat.com>
	<20170707213052.13087-2-ehabkost@redhat.com>
	<20170710101041.553a792a@nial.brq.redhat.com>
	<20170710144557.GH12152@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170710144557.GH12152@localhost.localdomain>
Subject: [Qemu-devel] [PATCH] fixup! qom: Fix ambiguous path detection when
 ambiguous=NULL
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org, Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>

On Mon, Jul 10, 2017 at 11:45:57AM -0300, Eduardo Habkost wrote:
> On Mon, Jul 10, 2017 at 10:10:41AM +0200, Igor Mammedov wrote:
> > On Fri,  7 Jul 2017 18:30:51 -0300
> > Eduardo Habkost <ehabkost@redhat.com> wrote:
[...]
> > > +
> > > +    object_unparent(obj1);
> > > +    object_unparent(obj2a);
> > > +    object_unparent(obj2b);
> > Are above unparenting is necessary?
> > 
> > > +    object_unparent(cont1);
> > Wouldn't parent destruction sufficient to trigger
> > implicit destruction of children?
> 
> Probably it is.  I will test it.

The obj1 and obj2a object_unparent() calls are really
unnecessary.  object_unparent(obj2b) is still necessary because
it is attached direcly to root.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 tests/check-qom-proplist.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/tests/check-qom-proplist.c b/tests/check-qom-proplist.c
index 381532c..432b665 100644
--- a/tests/check-qom-proplist.c
+++ b/tests/check-qom-proplist.c
@@ -605,8 +605,6 @@ static void test_qom_partial_path(void)
     g_assert(!ambiguous);
     g_assert(object_resolve_path("obj1", NULL) == obj1);
 
-    object_unparent(obj1);
-    object_unparent(obj2a);
     object_unparent(obj2b);
     object_unparent(cont1);
 }
-- 
2.9.4

-- 
Eduardo
