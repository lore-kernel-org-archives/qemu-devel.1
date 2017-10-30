Received: from eggs.gnu.org ([2001:4830:134:3::10]:40408)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e91HL-0005sJ-Ej
	for qemu-devel@nongnu.org; Mon, 30 Oct 2017 00:02:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e91HF-0003Mp-JR
	for qemu-devel@nongnu.org; Mon, 30 Oct 2017 00:02:23 -0400
Received: from mail-qk0-x241.google.com ([2607:f8b0:400d:c09::241]:45700)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e91HF-0003Ma-Ek
	for qemu-devel@nongnu.org; Mon, 30 Oct 2017 00:02:17 -0400
Received: by mail-qk0-x241.google.com with SMTP id f199so14630666qke.2
	for <qemu-devel@nongnu.org>; Sun, 29 Oct 2017 21:02:17 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Mon, 30 Oct 2017 01:00:56 -0300
Message-Id: <20171030040056.11780-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RFC PATCH] vl: only display available accelerators
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Peter Xu <peterx@redhat.com>, Markus Armbruster <armbru@redhat.com>, Stefano Stabellini <sstabellini@kernel.org>, Anthony Perard <anthony.perard@citrix.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, "Emilio G . Cota" <cota@braap.org>, Eric Blake <eblake@redhat.com>, Richard Henderson <rth@twiddle.net>

examples configuring with '--enable-kvm --disable-tcg'

- before

  $ qemu-system-x86_64 -accel help
  Possible accelerators: kvm, xen, hax, tcg

  $ qemu-system-x86_64 -accel tcg
  qemu-system-x86_64: -machine accel=tcg: No accelerator found

  # qemu-system-x86_64 -accel hax
  qemu-system-x86_64: -machine accel=hax: No accelerator found

  # qemu-system-x86_64 -accel xen
  xencall: error: Could not obtain handle on privileged command interface: No such file or directory
  xen be core: xen be core: can't open xen interface
  can't open xen interface
  qemu-system-x86_64: failed to initialize Xen: Operation not permitted

- after

  $ qemu-system-x86_64 -accel help
  Possible accelerators: kvm

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
RFC because:
    - I don't think this is the nicest way, too much #ifdef'fery in main()
    - I'm not sure the correct use of CONFIG_KVM_IS_POSSIBLE
    - shouldn't CONFIG_XEN/CONFIG_HAX be as poisoned as CONFIG_KVM?

 vl.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/vl.c b/vl.c
index ec299099ff..13fce86a6e 100644
--- a/vl.c
+++ b/vl.c
@@ -3883,7 +3883,20 @@ int main(int argc, char **argv, char **envp)
                                                      optarg, true);
                 optarg = qemu_opt_get(accel_opts, "accel");
                 if (!optarg || is_help_option(optarg)) {
-                    error_printf("Possible accelerators: kvm, xen, hax, tcg\n");
+                    error_printf("Possible accelerators: ");
+#ifdef CONFIG_KVM_IS_POSSIBLE
+                    error_printf("kvm ");
+#endif
+#ifdef CONFIG_XEN
+                    error_printf("xen ");
+#endif
+#ifdef CONFIG_HAX
+                    error_printf("hax ");
+#endif
+#ifdef CONFIG_TCG
+                    error_printf("tcg ");
+#endif
+                    error_printf("\n");
                     exit(0);
                 }
                 opts = qemu_opts_create(qemu_find_opts("machine"), NULL,
-- 
2.15.0.rc2
