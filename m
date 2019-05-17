Return-Path: <SRS0=PxdI=TR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60AC3C04AB4
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 14:21:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3749A21897
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 14:21:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3749A21897
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:49343 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hRdk6-0006vF-AQ
	for qemu-devel@archiver.kernel.org; Fri, 17 May 2019 10:21:50 -0400
Received: from eggs.gnu.org ([209.51.188.92]:41350)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vkuznets@redhat.com>) id 1hRdiB-0005ii-Pg
	for qemu-devel@nongnu.org; Fri, 17 May 2019 10:19:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vkuznets@redhat.com>) id 1hRdiA-00066K-RL
	for qemu-devel@nongnu.org; Fri, 17 May 2019 10:19:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50274)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vkuznets@redhat.com>) id 1hRdiA-0005j5-LC
	for qemu-devel@nongnu.org; Fri, 17 May 2019 10:19:50 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 383B97572A;
	Fri, 17 May 2019 14:19:28 +0000 (UTC)
Received: from vitty.brq.redhat.com (unknown [10.43.2.155])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 728B97857B;
	Fri, 17 May 2019 14:19:26 +0000 (UTC)
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: qemu-devel@nongnu.org
Date: Fri, 17 May 2019 16:19:15 +0200
Message-Id: <20190517141924.19024-1-vkuznets@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.25]);
	Fri, 17 May 2019 14:19:33 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v2 0/9] i386/kvm/hyper-v: refactor and
 implement 'hv-stimer-direct' and 'hv-passthrough' enlightenments
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
Cc: =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
	Eduardo Habkost <ehabkost@redhat.com>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	"Dr . David Alan Gilbert" <dgilbert@redhat.com>,
	Roman Kagan <rkagan@virtuozzo.com>, Paolo Bonzini <pbonzini@redhat.com>,
	Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

It has been a while since my 'v1' and I (again) apologize for that.

Changes since v1:
- Existing Hyper-V properties are converted from BOOL to BIT64, this allo=
ws
  us to express dependencies between them in a more natural way as well a=
s
  simplifies search in kvm_hyperv_properties [Roman Kagan] (hope I got th=
e
  idea right, but in any case this should be an improvement). PATCH1 adde=
d
  to the series.
- 'hv-all' renamed to 'hv-passthrough' [Roman Kagan]
- minor changes mostly related to support the addition of PATCH1.

Original description:

The recently introduced Direct Mode for Hyper-V synthetic timers
enlightenment is only exposed through KVM_GET_SUPPORTED_HV_CPUID ioctl.
Take the opportunity and re-implement the way we handle Hyper-V
enlightenments in QEMU, add support for hv-stimer-direct and 'hv-all'
pass-through mode, add missing dependencies between enlightenments.

Vitaly Kuznetsov (9):
  i386/kvm: convert hyperv enlightenments properties from bools to bits
  i386/kvm: add support for KVM_GET_SUPPORTED_HV_CPUID
  i386/kvm: move Hyper-V CPUID filling to hyperv_handle_properties()
  i386/kvm: document existing Hyper-V enlightenments
  i386/kvm: implement 'hv-passthrough' mode
  i386/kvm: hv-stimer requires hv-time and hv-synic
  i386/kvm: hv-tlbflush/ipi require hv-vpindex
  i386/kvm: hv-evmcs requires hv-vapic
  i386/kvm: add support for Direct Mode for Hyper-V synthetic timers

 docs/hyperv.txt            | 201 ++++++++++
 hw/i386/pc.c               |   3 +-
 target/i386/cpu.c          |  47 ++-
 target/i386/cpu.h          |  39 +-
 target/i386/hyperv-proto.h |   1 +
 target/i386/hyperv.c       |   2 +-
 target/i386/kvm.c          | 770 ++++++++++++++++++++++++++-----------
 target/i386/machine.c      |   2 +-
 8 files changed, 813 insertions(+), 252 deletions(-)
 create mode 100644 docs/hyperv.txt

--=20
2.20.1


