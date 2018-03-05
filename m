Received: from eggs.gnu.org ([2001:4830:134:3::10]:56928)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1esl2a-0007gN-1F
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 03:00:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1esl2V-0000gd-NE
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 03:00:12 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37898 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1esl2V-0000gU-Ho
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 03:00:07 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id AB3744085010
	for <qemu-devel@nongnu.org>; Mon,  5 Mar 2018 08:00:02 +0000 (UTC)
Date: Mon, 5 Mar 2018 15:59:54 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180305075954.GB7584@xz-mi>
References: <20180305065040.10353-1-peterx@redhat.com>
	<152023581793.1371.12770150376954730773@bdbb90650ae5>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <152023581793.1371.12770150376954730773@bdbb90650ae5>
Subject: Re: [Qemu-devel] [PATCH 0/9] chardev: qio related non-default
 context support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: famz@redhat.com, pbonzini@redhat.com, stefanha@redhat.com, marcandre.lureau@redhat.com

On Sun, Mar 04, 2018 at 11:43:39PM -0800, no-reply@patchew.org wrote:

[...]

>   TEST    decodetree.py
>   LINK    tests/check-qdict
>   LINK    tests/test-char
>   LINK    tests/check-qnum
>   LINK    tests/check-qstring
>   LINK    tests/check-qlist
>   LINK    tests/check-qnull
> tests/test-char.o: In function `char_mux_test':
> /tmp/qemu-test/src/tests/test-char.c:169: undefined reference to `muxes_realized'

This is a valid report.

I need to squash this into patch 5 to fix it:

diff --git a/include/chardev/char-mux.h b/include/chardev/char-mux.h
index 8928977897..1e13187767 100644
--- a/include/chardev/char-mux.h
+++ b/include/chardev/char-mux.h
@@ -27,8 +27,6 @@
 #include "chardev/char.h"
 #include "chardev/char-fe.h"
 
-extern bool muxes_realized;
-
 #define MAX_MUX 4
 #define MUX_BUFFER_SIZE 32 /* Must be a power of 2.  */
 #define MUX_BUFFER_MASK (MUX_BUFFER_SIZE - 1)
diff --git a/tests/test-char.c b/tests/test-char.c
index b358620911..e49af9e398 100644
--- a/tests/test-char.c
+++ b/tests/test-char.c
@@ -166,7 +166,6 @@ static void char_mux_test(void)
     FeHandler h1 = { 0, }, h2 = { 0, };
     CharBackend chr_be1, chr_be2;
 
-    muxes_realized = true; /* done after machine init */
     opts = qemu_opts_create(qemu_find_opts("chardev"), "mux-label",
                             1, &error_abort);
     qemu_opt_set(opts, "backend", "ringbuf", &error_abort);

I'll repost until I got some other feedbacks.

-- 
Peter Xu
