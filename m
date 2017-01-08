Received: from eggs.gnu.org ([2001:4830:134:3::10]:35848)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cQHKl-0005A0-Go
	for qemu-devel@nongnu.org; Sun, 08 Jan 2017 12:32:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cQHKi-0005ND-Cv
	for qemu-devel@nongnu.org; Sun, 08 Jan 2017 12:32:43 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56004)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1cQHKi-0005MF-6t
	for qemu-devel@nongnu.org; Sun, 08 Jan 2017 12:32:40 -0500
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Sun,  8 Jan 2017 15:32:32 -0200
Message-Id: <20170108173234.25721-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PATCH v3 0/2] Allow migration with invtsc if TSC
 frequency is explicitly set
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Marcelo Tosatti <mtosatti@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, Haozhong Zhang <haozhong.zhang@intel.com>, "Daniel P. Berrange" <berrange@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, libvir-list@redhat.com, Jiri Denemark <jdenemar@redhat.com>

This series makes QEMU accept migration if tsc-frequency is
explicitly set on configuration. As management software is
required to keep device configuration the same on migration
source or destination, explicit tsc-frequency will ensure that
either:

* The destination host has a matching TSC frequency; or
* The destination host has TSC scaling available.

Changelog
=========

v2 -> v3:
* Fix build failure ((missing closing braces)

v1 -> v2:
* v1 series subject was:
  * [PATCH 0/4] Allow migration with invtsc if there's no
    frequency mismatch
* Removed patches 3/4 and 4/4, that allowed migration
  if no explicit tsc-frequency was set. Implementing the check on
  post_load or post_init is not enough to make migration abort,
  so we will need a more complex solution to implement that
  feature.

Plans for future work
=====================

1) Querying host TSC frequency/scaling capability
-------------------------------------------------

I plan to include TSC frequency/scaling information on
query-cpu-model-expansion model="host" in a future series. Then
management software will be able to automatically configure TSC
frequency when invtsc is enabled, instead of requiring the user
to configure it explicitly. While we don't implement that, invtsc
migration will be possible only if the user configures TSC
frequency manually.

2) invtsc migration with no explicit TSC frequency
--------------------------------------------------

A future series can implement migration when TSC frequency is not
specified explicitly. It will be a bit more complex because it
requires either letting the destination abort the migration, or
sending TSC frequency/scaling information from destination to
source.

---
Cc: Marcelo Tosatti <mtosatti@redhat.com>
Cc: "Daniel P. Berrange" <berrange@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org
Cc: Haozhong Zhang <haozhong.zhang@intel.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>
Cc: libvir-list@redhat.com
Cc: Jiri Denemark <jdenemar@redhat.com>

Eduardo Habkost (2):
  kvm: Simplify invtsc check
  kvm: Allow invtsc migration if tsc-khz is set explicitly

 target/i386/kvm.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

-- 
2.11.0.259.g40922b1
