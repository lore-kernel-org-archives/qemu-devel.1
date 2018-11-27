Received: from eggs.gnu.org ([2001:4830:134:3::10]:35420)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gReU9-00040k-7G
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 09:37:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gReU6-0001wx-BM
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 09:37:08 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d]:46026)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1gReU6-0001wA-3h
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 09:37:06 -0500
Received: by mail-wr1-x42d.google.com with SMTP id v6so22923831wrr.12
	for <qemu-devel@nongnu.org>; Tue, 27 Nov 2018 06:37:06 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 27 Nov 2018 15:36:36 +0100
Message-Id: <1543329397-48407-15-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1543329397-48407-1-git-send-email-pbonzini@redhat.com>
References: <1543329397-48407-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 14/15] hostmem-memfd: honour share=on/off
 property
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

From: Marc-André Lureau <marcandre.lureau@redhat.com>

The share=on/off property is used to modified mmap() MAP_SHARED
setting. Make it on by default for convenience and compatibility
reasons.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 backends/hostmem-memfd.c | 4 +++-
 qemu-options.hx          | 4 +++-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/backends/hostmem-memfd.c b/backends/hostmem-memfd.c
index b6836b2..1c3579e 100644
--- a/backends/hostmem-memfd.c
+++ b/backends/hostmem-memfd.c
@@ -59,7 +59,8 @@ memfd_backend_memory_alloc(HostMemoryBackend *backend, Error **errp)
 
     name = object_get_canonical_path(OBJECT(backend));
     memory_region_init_ram_from_fd(&backend->mr, OBJECT(backend),
-                                   name, backend->size, true, fd, errp);
+                                   name, backend->size,
+                                   backend->share, fd, errp);
     g_free(name);
 }
 
@@ -131,6 +132,7 @@ memfd_backend_instance_init(Object *obj)
 
     /* default to sealed file */
     m->seal = true;
+    MEMORY_BACKEND(m)->share = true;
 }
 
 static void
diff --git a/qemu-options.hx b/qemu-options.hx
index f7df472..269eda7 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -4025,7 +4025,7 @@ Memory backend objects offer more control than the @option{-m} option that is
 traditionally used to define guest RAM. Please refer to
 @option{memory-backend-file} for a description of the options.
 
-@item -object memory-backend-memfd,id=@var{id},merge=@var{on|off},dump=@var{on|off},prealloc=@var{on|off},size=@var{size},host-nodes=@var{host-nodes},policy=@var{default|preferred|bind|interleave},seal=@var{on|off},hugetlb=@var{on|off},hugetlbsize=@var{size}
+@item -object memory-backend-memfd,id=@var{id},merge=@var{on|off},dump=@var{on|off},share=@var{on|off},prealloc=@var{on|off},size=@var{size},host-nodes=@var{host-nodes},policy=@var{default|preferred|bind|interleave},seal=@var{on|off},hugetlb=@var{on|off},hugetlbsize=@var{size}
 
 Creates an anonymous memory file backend object, which allows QEMU to
 share the memory with an external process (e.g. when using
@@ -4047,6 +4047,8 @@ with the @option{seal} option (requires at least Linux 4.16).
 Please refer to @option{memory-backend-file} for a description of the
 other options.
 
+The @option{share} boolean option is @var{on} by default with memfd.
+
 @item -object rng-random,id=@var{id},filename=@var{/dev/random}
 
 Creates a random number generator backend which obtains entropy from
-- 
1.8.3.1
