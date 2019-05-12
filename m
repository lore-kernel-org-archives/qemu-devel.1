Return-Path: <SRS0=55mG=TM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11F49C04A6B
	for <qemu-devel@archiver.kernel.org>; Sun, 12 May 2019 08:37:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C2C4E206A3
	for <qemu-devel@archiver.kernel.org>; Sun, 12 May 2019 08:37:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2C4E206A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:40450 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hPjzI-00042u-Ki
	for qemu-devel@archiver.kernel.org; Sun, 12 May 2019 04:37:40 -0400
Received: from eggs.gnu.org ([209.51.188.92]:38126)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1hPjyK-0003au-Nh
	for qemu-devel@nongnu.org; Sun, 12 May 2019 04:36:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1hPjyJ-0003G5-CH
	for qemu-devel@nongnu.org; Sun, 12 May 2019 04:36:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58264)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <drjones@redhat.com>)
	id 1hPjyG-0003EM-CF; Sun, 12 May 2019 04:36:36 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 70DE93086201;
	Sun, 12 May 2019 08:36:33 +0000 (UTC)
Received: from kamzik.brq.redhat.com (ovpn-116-87.ams2.redhat.com
	[10.36.116.87])
	by smtp.corp.redhat.com (Postfix) with ESMTP id EEBF25D706;
	Sun, 12 May 2019 08:36:28 +0000 (UTC)
From: Andrew Jones <drjones@redhat.com>
To: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org
Date: Sun, 12 May 2019 10:36:11 +0200
Message-Id: <20190512083624.8916-1-drjones@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.42]);
	Sun, 12 May 2019 08:36:33 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 00/13] target/arm/kvm: enable SVE in guests
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: peter.maydell@linaro.org, richard.henderson@linaro.org, armbru@redhat.com,
	abologna@redhat.com, alex.bennee@linaro.org, Dave.Martin@arm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

With the recent KVM guest SVE support pull request [1] KVM will be
ready for guests with SVE. This series provides the QEMU bits for
that enablement. The series starts with the bits needed for the KVM
SVE ioctls. Then it enables the arm 'max'cpu type, which with TCG
already supports SVE, to also support SVE when using KVM. Next
a new QMP query is added that allows users to ask which vector
lengths are supported by the host, allowing them to select a valid
set of vectors for the guest. In order to select those vectors a
new property 'sve-vls-map' is added to the 'max' cpu type, and then
also to the 'host' cpu type. The table below shows the resulting user
interfaces.

   CPU type | accel | sve-max-vq | sve-vls-map
   -------------------------------------------
 1)     max | tcg   |  $MAX_VQ   |  $VLS_MAP
 2)     max | kvm   |  $MAX_VQ   |  $VLS_MAP
 3)    host | kvm   |  N/A       |  $VLS_MAP

Where for (1) $MAX_VQ sets the maximum vq and smaller vqs are
all supported when $VLS_MAP is zero, or when the vqs are selected
in $VLS_MAP.

(2) is the same as (1) except KVM has the final say on what
vqs are valid.

(3) doesn't accept sve-max-vq because a guest that uses this
property without sve-vls-map cannot be safely migrated.

There is never any need to provide both properties, but if both
are provided then they are checked for consistency.

The QMP query returns a list of valid vq lists. For example, if
a guest can use vqs 1, 2, 3, and 4, then the following list will
be returned

 [ [ 1 ], [ 1, 2 ], [ 1, 2, 3 ], [ 1, 2, 3, 4 ] ]

Another example might be 1, 2, 4, as the architecture states 3
is optional. In that case the list would be

 [ [ 1 ], [ 1, 2 ], [ 1, 2, 4 ] ]

This may look redundant, but it's necessary to provide a future-
proof query, because while KVM currently requires vector sets to
be strict truncations of the full valid vector set, that may change
at some point. Additionally, TCG doesn't have this restriction so
more vector sets can be returned that aren't so easily derived from
the full set already. (Note, this series doesn't do that yet. See
the TODO below.)

And now for what might be a bit more controversial; how we input
the valid vector set with sve-vls-map. Well, sve-vls-map is a
64-bit bitmap, which is admittedly not user friendly and also not
the same size as KVM's vls bitmap (which is 8 64-bit words). Here's
the justification:

 1) We want to use the QEMU command line in order for the information
    to be migrated without needing to add more VM state.
 2) It's not easy/pretty to input arrays on the QEMU command line.
 3) We already need to use the QMP query to get a valid set, which
    isn't user friendly either, meaning we're already in libvirt
    territory.
 4) A 64-bit map (supporting up to 8192-bit vectors) is likely big
    enough for quite some time (currently KVM and TCG only support
    2048-bit vectors).
 5) If user friendliness is needed more than migratability then
    the 'max' cpu type can be used with the sve-max-vq property.
 6) It's possible to probe the full valid vector set from the
    command line by using something like sve-vls-map=3D0xffff and
    then, when it fails, the error message will state the correct
    map, e.g. 0xb.

TODO:
 1) More testing. Initial testing looks good, and I'm doing more
    now, but wanted to get the series out for review in parallel.
 2) Extension to target/arm/arch_dump.c for SVE state. I'll try
    to get to this early next week.
 3) Modify the QMP query to output all valid vector sets for
    TCG, rather than just the ones derived by truncation as
    is required by KVM.

[1] https://www.spinics.net/lists/kvm-arm/msg35844.html

Thanks!

Andrew Jones (13):
  target/arm/kvm64: fix error returns
  update-linux-headers: Add sve_context.h to asm-arm64
  HACK: linux header update
  target/arm/kvm: Move the get/put of fpsimd registers out
  target/arm/kvm: Add kvm_arch_get/put_sve
  target/arm/kvm: max cpu: Enable SVE when available
  target/arm/kvm: max cpu: Allow sve max vector length setting
  target/arm/monitor: Add query-sve-vector-lengths
  target/arm/kvm: Export kvm_arm_get_sve_vls
  target/arm/monitor: kvm: only return valid sve vector sets
  target/arm/cpu64: max cpu: Introduce sve-vls-map
  target/arm/kvm: max cpu: Add support for sve-vls-map
  target/arm/kvm: host cpu: Add support for sve-vls-map

 linux-headers/asm-arm64/kvm.h         |  41 +++
 linux-headers/asm-arm64/sve_context.h |  53 ++++
 linux-headers/linux/kvm.h             |   5 +
 qapi/target.json                      |  34 +++
 scripts/update-linux-headers.sh       |   3 +
 target/arm/cpu.c                      |   5 +
 target/arm/cpu.h                      |   9 +
 target/arm/cpu64.c                    |  81 ++++-
 target/arm/helper.c                   |  10 +-
 target/arm/kvm.c                      |   5 +
 target/arm/kvm64.c                    | 418 ++++++++++++++++++++++----
 target/arm/kvm_arm.h                  |  32 ++
 target/arm/monitor.c                  | 106 +++++++
 tests/qmp-cmd-test.c                  |   1 +
 14 files changed, 732 insertions(+), 71 deletions(-)
 create mode 100644 linux-headers/asm-arm64/sve_context.h

--=20
2.20.1


