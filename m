Return-Path: <SRS0=/hVT=5E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6317BC4332D
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2020 11:10:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1BCD1206D7
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2020 11:10:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SxfM6K6/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BCD1206D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36212 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEt45-0002kP-AU
	for qemu-devel@archiver.kernel.org; Thu, 19 Mar 2020 07:10:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35922)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1jEt3Q-0002ED-VS
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 07:09:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1jEt3P-0003NB-Qx
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 07:09:36 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:32341)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1jEt3P-0003M9-Nk
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 07:09:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584616175;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uj+CP1nXamEl9v2lG/SpkgkH3Bl2qCU1naDrfqZ4tqM=;
 b=SxfM6K6/dV4aAA5KDLEgQVFqnluxVHTrQstDOMWyT6kjUE8HtKyr+9yuyWn58PkM1/OGet
 NZJM4XWtrAns33t88PvRIv4HdOpUmlBNzkBPr/rUiETn0JgW4QK6EfBEEj/q7Pm7LCwg+m
 vYa2Q0rhU7EWbXYs8AbwwJoF8MZNPxk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-331-7f06vW3FMj68ozrGyZiw9Q-1; Thu, 19 Mar 2020 07:09:32 -0400
X-MC-Unique: 7f06vW3FMj68ozrGyZiw9Q-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C096C1005510;
 Thu, 19 Mar 2020 11:09:30 +0000 (UTC)
Received: from gondolin (ovpn-113-188.ams2.redhat.com [10.36.113.188])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E9765196AE;
 Thu, 19 Mar 2020 11:09:26 +0000 (UTC)
Date: Thu, 19 Mar 2020 12:08:48 +0100
From: Cornelia Huck <cohuck@redhat.com>
To: Janosch Frank <frankja@linux.ibm.com>
Subject: Re: [PATCH v10 03/16] s390x: protvirt: Support unpack facility
Message-ID: <20200319120848.19b34cb8.cohuck@redhat.com>
In-Reply-To: <20200318143047.2335-4-frankja@linux.ibm.com>
References: <20200318143047.2335-1-frankja@linux.ibm.com>
 <20200318143047.2335-4-frankja@linux.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: borntraeger@de.ibm.com, qemu-s390x@nongnu.org, qemu-devel@nongnu.org,
 david@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 18 Mar 2020 10:30:34 -0400
Janosch Frank <frankja@linux.ibm.com> wrote:

> The unpack facility provides the means to setup a protected guest. A
> protected guest cannot be introspected by the hypervisor or any
> user/administrator of the machine it is running on.
> 
> Protected guests are encrypted at rest and need a special boot
> mechanism via diag308 subcode 8 and 10.
> 
> Code 8 sets the PV specific IPLB which is retained separately from
> those set via code 5.
> 
> Code 10 is used to unpack the VM into protected memory, verify its
> integrity and start it.
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> Co-developed-by: Christian Borntraeger <borntraeger@de.ibm.com> [Changes
> to machine]
> Reviewed-by: David Hildenbrand <david@redhat.com>
> Reviewed-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
> ---
>  hw/s390x/Makefile.objs              |   1 +
>  hw/s390x/ipl.c                      |  59 +++++++++++++-
>  hw/s390x/ipl.h                      |  91 ++++++++++++++++++++-
>  hw/s390x/pv.c                       |  98 +++++++++++++++++++++++

More of an aside: In MAINTAINERS, this new file will be covered by the
general s390x section, the tcg section, and the s390-ccw-virtio machine
section, but not by the kvm section. Do we want to tweak that?

>  hw/s390x/s390-virtio-ccw.c          | 119 +++++++++++++++++++++++++++-
>  include/hw/s390x/pv.h               |  55 +++++++++++++
>  include/hw/s390x/s390-virtio-ccw.h  |   1 +
>  target/s390x/cpu.c                  |   2 +
>  target/s390x/cpu_features_def.inc.h |   1 +
>  target/s390x/diag.c                 |  39 ++++++++-
>  target/s390x/kvm-stub.c             |   5 ++
>  target/s390x/kvm.c                  |   5 ++
>  target/s390x/kvm_s390x.h            |   1 +
>  13 files changed, 467 insertions(+), 10 deletions(-)
>  create mode 100644 hw/s390x/pv.c
>  create mode 100644 include/hw/s390x/pv.h

(...)

> diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
> index 3dd396e870357944..84029f14814b4980 100644
> --- a/target/s390x/cpu.c
> +++ b/target/s390x/cpu.c
> @@ -37,6 +37,8 @@
>  #include "sysemu/hw_accel.h"
>  #include "hw/qdev-properties.h"
>  #ifndef CONFIG_USER_ONLY
> +#include "hw/s390x/s390-virtio-ccw.h"
> +#include "hw/s390x/pv.h"

These are probably needed because of some inline stuff dragging
definitions in?

>  #include "hw/boards.h"
>  #include "sysemu/arch_init.h"
>  #include "sysemu/sysemu.h"

Reviewed-by: Cornelia Huck <cohuck@redhat.com>


