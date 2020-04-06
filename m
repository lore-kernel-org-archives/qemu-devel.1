Return-Path: <SRS0=By5p=5W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88D4EC2BA19
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 09:41:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 535F42051A
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 09:41:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X3Z/VcAl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 535F42051A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56894 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLOFz-0000xl-6Q
	for qemu-devel@archiver.kernel.org; Mon, 06 Apr 2020 05:41:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43892)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1jLOFD-0000Mz-Va
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 05:40:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1jLOFC-0000yh-JR
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 05:40:39 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:36368
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1jLOFC-0000xG-F8
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 05:40:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586166037;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ofDwXZoPUyrJ86w/j4ZuB1N4Wl991NPjIn4MqAAHqPk=;
 b=X3Z/VcAl93AmJSWfLyx9XxCNrO0r0g66r2hDcYwY0S3+HeMofPkdQ5mZCWTIO1pMnroBmm
 +BQYeLMQJvjKCY4cdPeyZUUYHUE7SbUN/ZY4FM2xn5UxRbDG4QvdpcobPOSKRUb8zK59Vz
 CqdIDh4uVhsVLIRmSDIvHzdmLlVFZBk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-246-VvDZscrTO8KIqNCSWrY0HQ-1; Mon, 06 Apr 2020 05:40:34 -0400
X-MC-Unique: VvDZscrTO8KIqNCSWrY0HQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B27008017F3;
 Mon,  6 Apr 2020 09:40:32 +0000 (UTC)
Received: from gondolin (ovpn-113-129.ams2.redhat.com [10.36.113.129])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B8AE25C28F;
 Mon,  6 Apr 2020 09:40:25 +0000 (UTC)
Date: Mon, 6 Apr 2020 11:40:23 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [PATCH 1/1] s390x/s390-virtio-ccw: Fix build on systems without
 KVM
Message-ID: <20200406114023.1594a8c0.cohuck@redhat.com>
In-Reply-To: <95faf831-5382-0c3e-fed4-67485f04a4b7@de.ibm.com>
References: <20200406075931.26232-1-borntraeger@de.ibm.com>
 <20200406075931.26232-2-borntraeger@de.ibm.com>
 <27304f4e-3801-3200-c5ba-9fb5ac0f8715@redhat.com>
 <95faf831-5382-0c3e-fed4-67485f04a4b7@de.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: Thomas Huth <thuth@redhat.com>, Janosch Frank <frankja@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
 Bruce Rogers <brogers@suse.com>, Halil Pasic <pasic@linux.ibm.com>,
 qemu-s390x <qemu-s390x@nongnu.org>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 6 Apr 2020 11:29:21 +0200
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> On 06.04.20 11:07, David Hildenbrand wrote:
> >   
> >>  static inline bool s390_is_pv(void)
> >> @@ -41,6 +42,7 @@ int s390_pv_unpack(uint64_t addr, uint64_t size, uint64_t tweak);
> >>  void s390_pv_perf_clear_reset(void);
> >>  int s390_pv_verify(void);
> >>  void s390_pv_unshare(void);
> >> +void s390_machine_inject_pv_error(CPUState *cs);
> >>  #else /* CONFIG_KVM */
> >>  static inline bool s390_is_pv(void) { return false; }
> >>  static inline int s390_pv_vm_enable(void) { return 0; }
> >> @@ -50,6 +52,7 @@ static inline int s390_pv_unpack(uint64_t addr, uint64_t size, uint64_t tweak) {
> >>  static inline void s390_pv_perf_clear_reset(void) {}
> >>  static inline int s390_pv_verify(void) { return 0; }
> >>  static inline void s390_pv_unshare(void) {}
> >> +static inline void s390_machine_inject_pv_error(CPUState *cs) {};  
> > 
> > I'd suggest renaming that to s390_pv_inject_error() or similar right away.  
> 
> Makes sense.
> Conny any preference?
> 

I think s390_pv_inject_error() fits in a bit better.


