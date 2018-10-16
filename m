Received: from eggs.gnu.org ([2001:4830:134:3::10]:51148)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gCOyj-000535-Jv
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 09:01:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gCOyf-0007aS-J5
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 09:01:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56228)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gCOyd-0007TK-Hr
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 09:01:35 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7F7423001922
	for <qemu-devel@nongnu.org>; Tue, 16 Oct 2018 13:01:31 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-50.ams2.redhat.com
	[10.36.116.50])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 4A2AA6956A
	for <qemu-devel@nongnu.org>; Tue, 16 Oct 2018 13:01:31 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Tue, 16 Oct 2018 15:01:29 +0200
Message-ID: <87efcqniza.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] When it's okay to treat OOM as fatal?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

We sometimes use g_new() & friends, which abort() on OOM, and sometimes
g_try_new() & friends, which can fail, and therefore require error
handling.

HACKING points out the difference, but is mum on when to use what:

    3. Low level memory management

    Use of the malloc/free/realloc/calloc/valloc/memalign/posix_memalign
    APIs is not allowed in the QEMU codebase. Instead of these routines,
    use the GLib memory allocation routines g_malloc/g_malloc0/g_new/
    g_new0/g_realloc/g_free or QEMU's qemu_memalign/qemu_blockalign/qemu_vfree
    APIs.

    Please note that g_malloc will exit on allocation failure, so there
    is no need to test for failure (as you would have to with malloc).
    Calling g_malloc with a zero size is valid and will return NULL.

    Prefer g_new(T, n) instead of g_malloc(sizeof(T) * n) for the following
    reasons:

      a. It catches multiplication overflowing size_t;
      b. It returns T * instead of void *, letting compiler catch more type
         errors.

    Declarations like T *v = g_malloc(sizeof(*v)) are acceptable, though.

    Memory allocated by qemu_memalign or qemu_blockalign must be freed with
    qemu_vfree, since breaking this will cause problems on Win32.

Now, in my personal opinion, handling OOM gracefully is worth the
(commonly considerable) trouble when you're coding for an Apple II or
similar.  Anything that pages commonly becomes unusable long before
allocations fail.  Anything that overcommits will send you a (commonly
lethal) signal instead.  Anything that tries handling OOM gracefully,
and manages to dodge both these bullets somehow, will commonly get it
wrong and crash.

But others are entitled to their opinions as much as I am.  I just want
to know what our rules are, preferably in the form of a patch to
HACKING.
