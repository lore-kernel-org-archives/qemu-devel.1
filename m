Received: from eggs.gnu.org ([2001:4830:134:3::10]:39429)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1fr5Fy-00082l-UL
	for qemu-devel@nongnu.org; Sat, 18 Aug 2018 13:43:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1fr5Fv-0001RW-Nv
	for qemu-devel@nongnu.org; Sat, 18 Aug 2018 13:43:22 -0400
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:34591)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1fr5Fv-0001Nn-B2
	for qemu-devel@nongnu.org; Sat, 18 Aug 2018 13:43:19 -0400
Date: Sat, 18 Aug 2018 13:43:16 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20180818174316.GA9458@flamenco>
References: <20180817051853.23792-1-cota@braap.org>
	<153455848651.26347.421862919623233041@502c9da6d61e>
	<20180818064554.GA2277@lemon.usersys.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180818064554.GA2277@lemon.usersys.redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 0/9] synchronization profiler
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org

On Sat, Aug 18, 2018 at 14:45:54 +0800, Fam Zheng wrote:
> On Fri, 08/17 19:14, no-reply@patchew.org wrote:
(snip)
> > /tmp/qemu-test/src/include/qemu/thread.h:101:1: error: all paths through this function will call itself [-Werror,-Winfinite-recursion]
(snip)
> > subprocess.CalledProcessError: Command '['sudo', '-n', 'docker', 'run', '--label', 'com.qemu.instance.uuid=3dee4156a28c11e8b93c52540069c830', '-u', '1000', '--security-opt', 'seccomp=unconfined', '--rm', '--net=none', '-e', 'TARGET_LIST=', '-e', 'EXTRA_CONFIGURE_OPTS=', '-e', 'V=', '-e', 'J=8', '-e', 'DEBUG=', '-e', 'SHOW_ENV=1', '-e', 'CCACHE_DIR=/var/tmp/ccache', '-v', '/home/patchew/.cache/qemu-docker-ccache:/var/tmp/ccache:z', '-v', '/var/tmp/patchew-tester-tmp-pdpmalc5/src/docker-src.2018-08-17-22.12.51.31192:/var/tmp/qemu:z,ro', 'qemu:ubuntu', '/var/tmp/qemu/run', 'test-clang']' returned non-zero exit status 2
> > make[1]: *** [tests/docker/Makefile.include:216: docker-run] Error 1
> > make[1]: Leaving directory '/var/tmp/patchew-tester-tmp-pdpmalc5/src'
> > make: *** [tests/docker/Makefile.include:250: docker-run-test-clang@ubuntu] Error 2
> > 
> > real	1m55.855s
> > user	0m4.734s
> > sys	0m3.377s
> > === OUTPUT END ===
> > 
> > Test command exited with code: 2
> 
> Could you check if this one is relevant?

It is! Somehow gcc didn't catch this.

I've pushed a v4 with the appended fix in it:

  https://github.com/cota/qemu/tree/sync-profiler-v4

Thanks,

		Emilio

---
diff --git a/include/qemu/thread.h b/include/qemu/thread.h
index b41c0ae16a..dacebcfff0 100644
--- a/include/qemu/thread.h
+++ b/include/qemu/thread.h
@@ -63,7 +63,7 @@ extern QemuCondWaitFunc qemu_cond_wait_func;
             _f(m, __FILE__, __LINE__);                                  \
         })

-#define qemu_rec_trymutex_lock(m) ({                            \
+#define qemu_rec_mutex_trylock(m) ({                            \
             QemuRecMutexTrylockFunc _f;                         \
             _f = atomic_read(&qemu_rec_mutex_trylock_func);     \
             _f(m, __FILE__, __LINE__);                          \
