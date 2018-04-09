Received: from eggs.gnu.org ([2001:4830:134:3::10]:37041)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1f5UUh-000803-O5
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 06:57:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1f5UUc-00070K-Tj
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 06:57:51 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57262 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1f5UUc-0006zP-O6
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 06:57:46 -0400
References: <1523034681-33787-1-git-send-email-pbonzini@redhat.com>
	<CAFEAcA87K832wY7t_17CBEYb2p7rso_4XES08yo_C=rSt37VBQ@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <cd5b88f3-2b62-c2b9-c6fb-cfd42a50d95c@redhat.com>
Date: Mon, 9 Apr 2018 12:57:35 +0200
MIME-Version: 1.0
In-Reply-To: <CAFEAcA87K832wY7t_17CBEYb2p7rso_4XES08yo_C=rSt37VBQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL 00/20] Miscellaneous patches for QEMU 2.12-rc
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 09/04/2018 11:20, Peter Maydell wrote:
> This fails to compile on OSX and the BSDs:
> /Users/pm215/src/qemu-for-merges/util/memfd.c:208:19: error: implicit
> declaration of function 'memfd_create' is invalid in C99
> [-Werror,-Wimplicit-function-declaration]
>         int mfd = memfd_create("test", 0);
>                   ^

Will fix like this in v2:

diff --git a/util/memfd.c b/util/memfd.c
index 277f721..b3ecbac 100644
--- a/util/memfd.c
+++ b/util/memfd.c
@@ -202,6 +202,7 @@ bool qemu_memfd_alloc_check(void)
  */
 bool qemu_memfd_check(void)
 {
+#ifdef CONFIG_LINUX
     static int memfd_check = MEMFD_TODO;

     if (memfd_check == MEMFD_TODO) {
Stage this hunk [y,n,q,a,d,/,j,J,g,e,?]? y
@@ -215,4 +216,7 @@ bool qemu_memfd_check(void)
     }

     return memfd_check == MEMFD_OK;
+#else
+    return false;
+#endif
 }

> 
> I also got
> TEST: tests/boot-serial-test... (pid=15159)
>   /sparc64/boot-serial/sun4u:                                          **
> ERROR:/home/petmay01/linaro/qemu-for-merges/tests/boot-serial-test.c:139:check_guest_output:
> assertion failed: (output_ok)
> FAIL
> 
> on an x86-64/linux host, but I have a feeling that's one of
> our intermittents rather than anything in this patch.
