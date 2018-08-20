Received: from eggs.gnu.org ([2001:4830:134:3::10]:46773)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1frgVx-0001sa-Tc
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 05:30:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1frgVq-0008I0-C6
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 05:30:21 -0400
References: <20180819091335.22863-1-cota@braap.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <374f82bc-1680-a59d-aa71-31e88e4936a2@redhat.com>
Date: Mon, 20 Aug 2018 11:30:07 +0200
MIME-Version: 1.0
In-Reply-To: <20180819091335.22863-1-cota@braap.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 00/11] convert CPU list to RCU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>, qemu-devel@nongnu.org
Cc: Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>, David Gibson <david@gibson.dropbear.id.au>, Alexander Graf <agraf@suse.de>, Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>, qemu-ppc@nongnu.org

On 19/08/2018 11:13, Emilio G. Cota wrote:
> - Add some fixes for test-rcu-list. I wanted to be able to get no
>   races with ThreadSanitizer, but it still warns about two races.
>   I'm appending the report just in case, but I think tsan is getting
>   confused.

I cannot understand the first.  The second might be fixed by this unteste=
d
patch (the second hunk; the first is an optimization and clarification):

diff --git a/util/rcu.c b/util/rcu.c
index 5676c22bd1..314b7db1a6 100644
--- a/util/rcu.c
+++ b/util/rcu.c
@@ -192,7 +192,9 @@ static void enqueue(struct rcu_head *node)
=20
     node->next =3D NULL;
     old_tail =3D atomic_xchg(&tail, &node->next);
-    atomic_mb_set(old_tail, node);
+
+    /* Pairs with smb_mb_acquire() in try_dequeue.  */
+    atomic_store_release(old_tail, node);
 }
=20
 static struct rcu_head *try_dequeue(void)
@@ -213,7 +215,10 @@ retry:
      * wrong and we need to wait until its enqueuer finishes the update.
      */
     node =3D head;
-    next =3D atomic_mb_read(&head->next);
+    smp_mb_acquire();
+
+    /* atomic_read is enough because the pointer is never dereferenced. =
 */
+    next =3D atomic_read(&head->next);
     if (!next) {
         return NULL;
     }


The idea being that enqueue() writes so to speak node->prev->next in
the atomic_store_release when it enqueues node; try_dequeue() instead rea=
ds
node->next, so there is no synchronizes-with edge.  However, I'm not that
convinced that it's necessary...

Paolo
