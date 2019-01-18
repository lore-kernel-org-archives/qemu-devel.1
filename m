Received: from eggs.gnu.org ([209.51.188.92]:50482)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.mielke@gmail.com>) id 1gkMlq-0003Gv-Jb
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 00:32:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.mielke@gmail.com>) id 1gkMlp-0002mk-FM
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 00:32:46 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330]:53264)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mark.mielke@gmail.com>)
	id 1gkMlp-0002kh-8u
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 00:32:45 -0500
Received: by mail-wm1-x330.google.com with SMTP id d15so3296949wmb.3
	for <qemu-devel@nongnu.org>; Thu, 17 Jan 2019 21:32:44 -0800 (PST)
MIME-Version: 1.0
From: Mark Mielke <mark.mielke@gmail.com>
Date: Fri, 18 Jan 2019 00:32:31 -0500
Message-ID: <CALm7yL1oob_T+--=iW-iOQfEzJjP7reX9KrozEL2c4mYyX51jA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Qemu-devel] Live migration from Qemu 2.12 hosts to Qemu 3.2 hosts,
 with VMX flag enabled in the guest?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Thank you for the work on nested virtualization. Having had live migrations
fail in the past when nested virtualization has been active, it is great to
see that clever people have been working on this problem!

My question is about whether a migration path has been considered to allow
live migration from Qemu 2.12 hosts to Qemu 3.2 hosts, with VMX flag
enabled in the guest?

Qemu 2.12 doesn't know about the new nested state available from newer
Linux kernels, and it might be used on a machine with an older kernel that
doesn't make the nested state available. If Qemu 3.2 is on an up-to-date
host with an up-to-date kernel that does support the nested state, I'd like
to ensure we have the ability to try the migrations.

In the past, I've found that:

1) If the guest had used nested virtualization before, the migration often
fails. However, if we reboot the guest and do not use nested
virtualization, this simplifies to...
2) If the guest has never used nested virtualization before, the migration
succeeds.

I would like to leverage 2) as much as possible to migrate forwards to Qemu
3.2 hosts (once it is available). I can normally enter the guest to see if
1) is likely or not, and handle these ones specially. If only 20% of the
guests have ever used nested virtualization, then I would like the option
to safely migrate 80% of the guests using live migration, and handle the
20% as exceptions.

This is the 3.1 change log that got my attention:


   - x86 machines cannot be live-migrated if nested Intel virtualization is
   enabled. The next version of QEMU will be able to do live migration when
   nested virtualization is enabled, if supported by the kernel.


I believe this is the change it refers to:

commit d98f26073bebddcd3da0ba1b86c3a34e840c0fb8
Author: Paolo Bonzini <pbonzini@redhat.com>
Date:   Wed Nov 14 10:38:13 2018 +0100

    target/i386: kvm: add VMX migration blocker

    Nested VMX does not support live migration yet.  Add a blocker
    until that is worked out.

    Nested SVM only does not support it, but unfortunately it is
    enabled by default for -cpu host so we cannot really disable it.

    Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>


This particular check seems very simplistic:

+    if ((env->features[FEAT_1_ECX] & CPUID_EXT_VMX) && !vmx_mig_blocker) {
+        error_setg(&vmx_mig_blocker,
+                   "Nested VMX virtualization does not support live
migration yet");
+        r = migrate_add_blocker(vmx_mig_blocker, &local_err);
+        if (local_err) {
+            error_report_err(local_err);
+            error_free(vmx_mig_blocker);
+            return r;
+        }
+    }
+

It fails if the flag is set, rather than if any nested virtualization has
been used before.

I'm concerned I will end up with a requirement for *all* guests to be
restarted in order to migrate them to the new hosts, rather than just the
ones that would have a problem.

Thoughts?

Thanks!

-- 
Mark Mielke <mark.mielke@gmail.com>
