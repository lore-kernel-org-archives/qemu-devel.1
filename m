Received: from eggs.gnu.org ([2001:4830:134:3::10]:33717)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Julian_Brown@mentor.com>) id 1cEHQe-0008Lk-Eb
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 10:13:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Julian_Brown@mentor.com>) id 1cEHQV-0000eL-0q
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 10:13:12 -0500
Received: from relay1.mentorg.com ([192.94.38.131]:35056)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Julian_Brown@mentor.com>)
	id 1cEHQU-0000cl-QT
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 10:13:02 -0500
Date: Tue, 6 Dec 2016 15:11:54 +0000
From: Julian Brown <julian@codesourcery.com>
Message-ID: <20161206151154.71c69b41@squid.athome>
In-Reply-To: <55f516cd-7050-1e4a-139c-84012418c683@redhat.com>
References: <1478194258-75276-1-git-send-email-julian@codesourcery.com>
	<1478194258-75276-4-git-send-email-julian@codesourcery.com>
	<55f516cd-7050-1e4a-139c-84012418c683@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="MP_/i9a7VH6mCFsyJG=S5eOqUnt"
Subject: Re: [Qemu-devel] [PATCH 3/5] Fix arm_semi_flen_cb for BE32 system
 mode.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org

--MP_/i9a7VH6mCFsyJG=S5eOqUnt
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Fri, 4 Nov 2016 10:00:19 +0100
Paolo Bonzini <pbonzini@redhat.com> wrote:

> On 03/11/2016 18:30, Julian Brown wrote:
> > +#ifdef CONFIG_USER_ONLY
> >      size = be32_to_cpu(size);
> > +#else
> > +    /* If we're running in BE32 system mode, we don't need to do
> > an explicit
> > +     * byte swap, because (I think) target memory is already
> > stored in
> > +     * byte-swapped format.  
> 
> Isn't this true also of user-mode (both BE8 and BE32)?

I'm not sure, I don't think the "load-time" byteswapping affects user
mode in the same way. Anyway, this can be refactored as attached, which
looks a bit more plausible perhaps.

Thanks,

Julian
--MP_/i9a7VH6mCFsyJG=S5eOqUnt
Content-Type: text/x-patch
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="0004-Fix-arm_semi_flen_cb-for-BE32-system-mode.patch"

>From 0e5d7e43404250900bfea3f8dc21fefa59069190 Mon Sep 17 00:00:00 2001
From: Julian Brown <julian@codesourcery.com>
Date: Thu, 6 Oct 2016 04:02:08 -0700
Subject: [PATCH 4/4] Fix arm_semi_flen_cb for BE32 system mode.

This patch fixes the arm_semi_flen_cb callback so that it doesn't return
a byte-swapped size in BE32 system mode.
---
 target-arm/arm-semi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target-arm/arm-semi.c b/target-arm/arm-semi.c
index a9cf5f2..1ad1e63 100644
--- a/target-arm/arm-semi.c
+++ b/target-arm/arm-semi.c
@@ -187,7 +187,7 @@ static void arm_semi_flen_cb(CPUState *cs, target_ulong ret, target_ulong err)
     /* The size is always stored in big-endian order, extract
        the value. We assume the size always fit in 32 bits.  */
     uint32_t size;
-    cpu_memory_rw_debug(cs, arm_flen_buf(cpu) + 32, (uint8_t *)&size, 4, 0);
+    armsemi_memory_rw_debug(cs, arm_flen_buf(cpu) + 32, (uint8_t *)&size, 4, 0);
     size = be32_to_cpu(size);
     if (is_a64(env)) {
         env->xregs[0] = size;
-- 
1.9.1


--MP_/i9a7VH6mCFsyJG=S5eOqUnt--
