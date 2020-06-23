Return-Path: <SRS0=Q9tF=AE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25F09C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 15:44:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A5AA32072E
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 15:44:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LCZLuPfL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5AA32072E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53604 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnl6Q-00067a-KO
	for qemu-devel@archiver.kernel.org; Tue, 23 Jun 2020 11:44:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52774)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1jnl5f-0005Fo-FX
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 11:44:03 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:29746
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1jnl5d-0001ib-Qt
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 11:44:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592927041;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HKWiIbEnoBKdrEpt4leFANplYkn60/HbZQG9iAnotP8=;
 b=LCZLuPfLimMnYMqvfXh7yG3M0Or/CDSR2+cAzVBR0/JIycF7uWwiWDHew4Ldzf32qRyqut
 a7F35/5XnrjOsrEiZx8WJDpP+gu3pVp1heUU9iXrsipZz3SxoPC4guMKNuKjsLzFUi7eWj
 k/CPJfHU2qVcXKyYwpQwH9jgdLGf4pM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-158-GE8oYt_2NMWGgR_EhjhW6Q-1; Tue, 23 Jun 2020 11:43:57 -0400
X-MC-Unique: GE8oYt_2NMWGgR_EhjhW6Q-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4F1958031E1;
 Tue, 23 Jun 2020 15:43:55 +0000 (UTC)
Received: from gondolin (ovpn-112-222.ams2.redhat.com [10.36.112.222])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9EC8C5C240;
 Tue, 23 Jun 2020 15:43:42 +0000 (UTC)
Date: Tue, 23 Jun 2020 17:43:40 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>
Subject: Re: [PATCH 2/7] accel/kvm: Simplify kvm_check_extension()
Message-ID: <20200623174340.0dbc1989.cohuck@redhat.com>
In-Reply-To: <20200623105052.1700-3-philmd@redhat.com>
References: <20200623105052.1700-1-philmd@redhat.com>
 <20200623105052.1700-3-philmd@redhat.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Received-SPF: pass client-ip=205.139.110.61; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/23 01:55:08
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 kvm@vger.kernel.org, David Hildenbrand <david@redhat.com>,
 qemu-s390x@nongnu.org, "Michael S.
 Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>, qemu-arm@nongnu.org,
 qemu-ppc@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 23 Jun 2020 12:50:47 +0200
Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> wrote:

> In previous commit we let kvm_check_extension() use the
> global kvm_state. Since the KVMState* argument is now
> unused, drop it.
>=20
> Convert callers with this Coccinelle script:
>=20
>   @@
>   expression kvm_state, extension;
>   @@
>   -   kvm_check_extension(kvm_state, extension)
>   +   kvm_check_extension(extension)
>=20
> Unused variables manually removed:
> - CPUState* in hyperv_enabled()
> - KVMState* in kvm_arm_get_max_vm_ipa_size()
>=20
> Inspired-by: Paolo Bonzini <pbonzini@redhat.com>

=F0=9F=8C=9F=F0=9F=92=A1=F0=9F=8C=9F

> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  include/sysemu/kvm.h         |  2 +-
>  accel/kvm/kvm-all.c          | 64 ++++++++++++++++++------------------
>  hw/hyperv/hyperv.c           |  2 +-
>  hw/i386/kvm/clock.c          |  2 +-
>  hw/i386/kvm/i8254.c          |  4 +--
>  hw/i386/kvm/ioapic.c         |  2 +-
>  hw/intc/arm_gic_kvm.c        |  2 +-
>  hw/intc/openpic_kvm.c        |  2 +-
>  hw/intc/xics_kvm.c           |  2 +-
>  hw/s390x/s390-stattrib-kvm.c |  2 +-
>  target/arm/kvm.c             | 13 ++++----
>  target/arm/kvm32.c           |  2 +-
>  target/arm/kvm64.c           | 15 ++++-----
>  target/i386/kvm.c            | 61 ++++++++++++++++------------------
>  target/mips/kvm.c            |  4 +--
>  target/ppc/kvm.c             | 34 +++++++++----------
>  target/s390x/cpu_models.c    |  3 +-
>  target/s390x/kvm.c           | 30 ++++++++---------
>  18 files changed, 119 insertions(+), 127 deletions(-)

Reviewed-by: Cornelia Huck <cohuck@redhat.com>


