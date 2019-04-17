Return-Path: <SRS0=PAXx=ST=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49E24C282DA
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Apr 2019 11:33:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E6252073F
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Apr 2019 11:33:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E6252073F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:50908 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hGion-0001x6-5W
	for qemu-devel@archiver.kernel.org; Wed, 17 Apr 2019 07:33:33 -0400
Received: from eggs.gnu.org ([209.51.188.92]:59874)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1hGinF-0001Ax-GF
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 07:31:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1hGinE-0001of-AT
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 07:31:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33178)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>)
	id 1hGinE-0001nz-2J; Wed, 17 Apr 2019 07:31:56 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0DD7A300744C;
	Wed, 17 Apr 2019 11:31:55 +0000 (UTC)
Received: from t460s.redhat.com (ovpn-117-141.ams2.redhat.com [10.36.117.141])
	by smtp.corp.redhat.com (Postfix) with ESMTP id DA06C1001DF1;
	Wed, 17 Apr 2019 11:31:49 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Date: Wed, 17 Apr 2019 13:31:41 +0200
Message-Id: <20190417113143.5551-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.43]);
	Wed, 17 Apr 2019 11:31:55 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v3 0/2] s390x/kvm: Properly detect page size of
 initial memory
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
Cc: peter.maydell@linaro.org, Thomas Huth <thuth@redhat.com>,
	David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	Halil Pasic <pasic@linux.ibm.com>,
	Christian Borntraeger <borntraeger@de.ibm.com>,
	qemu-s390x@nongnu.org, qemu-ppc@nongnu.org, pbonzini@redhat.com,
	Igor Mammedov <imammedo@redhat.com>, Richard Henderson <rth@twiddle.net>,
	David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190417113141.j3EdilJ7ZvpqoXsSgnMEa3NRQ93J81N7GbIOZROKMlA@z>

While the detection on s390x of the maximum ram pagesize works by pure lu=
ck,
we should try to do better. Especially, once "-mem-path" is replaced
by memory backends, the current approach will break.

Configure the maximum page size after configuring initital memory. Provid=
e
a function to detect the maximum ram pagesize

I think this can be deferred to 4.1 as I don't think anything is actually
broken right now.

v2 -> v3:
- Fix compile error
- Tested that hugepages correctly result in an error with
  "modprobe kvm hpage=3D0", but not with "modprobe kvm hpage=3D1".

v1 -> v2:
- Add a better comment describing that only initial memory is considered
- Add "exec: Introduce qemu_getmaxrampagesize() and rename
  qemu_getrampagesize()"

David Hildenbrand (2):
  s390x/kvm: Configure page size after memory has actually been
    initialized
  exec: Introduce qemu_maxrampagesize() and rename qemu_getrampagesize()

 exec.c                     | 44 ++++++++++++++++++++++++++++++++++----
 hw/ppc/spapr_caps.c        |  4 ++--
 hw/s390x/s390-virtio-ccw.c | 12 +++++++++++
 hw/vfio/spapr.c            |  2 +-
 include/exec/ram_addr.h    |  3 ++-
 target/ppc/kvm.c           |  2 +-
 target/s390x/cpu.c         |  7 ++++++
 target/s390x/cpu.h         |  1 +
 target/s390x/kvm-stub.c    |  4 ++++
 target/s390x/kvm.c         | 35 ++++++++++++------------------
 target/s390x/kvm_s390x.h   |  1 +
 11 files changed, 85 insertions(+), 30 deletions(-)

--=20
2.20.1


