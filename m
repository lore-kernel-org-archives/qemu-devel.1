Received: from eggs.gnu.org ([2001:4830:134:3::10]:43156)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1f1xQ1-0002i2-7q
	for qemu-devel@nongnu.org; Fri, 30 Mar 2018 13:02:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1f1xPw-0006vQ-Cg
	for qemu-devel@nongnu.org; Fri, 30 Mar 2018 13:02:25 -0400
Received: from mail-he1eur01on0711.outbound.protection.outlook.com
	([2a01:111:f400:fe1e::711]:39856
	helo=EUR01-HE1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <rkagan@virtuozzo.com>)
	id 1f1xPw-0006si-0x
	for qemu-devel@nongnu.org; Fri, 30 Mar 2018 13:02:20 -0400
From: Roman Kagan <rkagan@virtuozzo.com>
Date: Fri, 30 Mar 2018 20:02:07 +0300
Message-Id: <20180330170209.20627-1-rkagan@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH for-2.12 v3 0/2] i386/hyperv: fully control
 Hyper-V features in CPUID
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>

In order to guarantee compatibility on migration, QEMU should have
complete control over the features it announces to the guest via CPUID.

However, a number of Hyper-V-related features happen to depend on the
support in the underlying KVM, with no regard to QEMU configuration.

Make QEMU regain control over what Hyper-V features it announces to the
guest.

Note #1: the patches are also being proposed[*] for stable-2.11, even
though one of them introduces a new cpu property.  This is done to
minimize the number of published QEMU releases where the behavior of the
features is unpredictable, with potentially fatal consequences for the
guest.

Note #2: there are other problems in the surrounding code, like ugly
error reporting or inconsistent population of MSRs.  I think this can be
put off to post-2.12.

[*] for the stable branch the second patch will have error returns
replaced with warnings; I'll post a separate series.

v2 -> v3:
 - include the fix for 'hv-time' missed previously

v1 -> v2:
 - indicate what flag requested the feature that can't be enabled in the
   error message
 - fix a typo in the error message for VP_RUNTIME

Roman Kagan (2):
  i386/hyperv: add hv-frequencies cpu property
  i386/hyperv: error out if features requested but unsupported

 target/i386/cpu.h |  1 +
 target/i386/cpu.c |  1 +
 target/i386/kvm.c | 56 ++++++++++++++++++++++++++++++++++++++++++-------------
 3 files changed, 45 insertions(+), 13 deletions(-)

-- 
2.14.3
