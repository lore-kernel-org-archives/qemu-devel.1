Return-Path: <SRS0=QWrs=3F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FB17C33CB1
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 14:24:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C5CB820748
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 14:24:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KZm9eREF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5CB820748
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42892 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1is64c-0003vc-V6
	for qemu-devel@archiver.kernel.org; Thu, 16 Jan 2020 09:24:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51214)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1is62z-0002F1-PS
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 09:23:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1is62v-0003vg-So
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 09:22:57 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:58425
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1is62v-0003uR-MJ
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 09:22:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579184570;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Mv+REG+PdtnjaKCd0EpUzMaFNBaQBLMC0Mfjp4ogEUY=;
 b=KZm9eREFd0gEEUovPw7MYyoFCxkua4f312wmrFfWecSGNy77sTdKVqUXvI9bLqcrZHbMtg
 x1uCBY8D1EelqBqM3qXiV/4aLAtr6wTXvUa+iqvou8yLWXfEUd+XVxjtXs8tMB7CV9isc6
 ue3fjZZsw7/gi4x5na3mhtwzjjCC6rs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-22-Yw3fak1_N6mhM5m7BVRpzg-1; Thu, 16 Jan 2020 09:22:47 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 50AF51800D48;
 Thu, 16 Jan 2020 14:22:46 +0000 (UTC)
Received: from gondolin (unknown [10.36.117.255])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6E53D9CA3;
 Thu, 16 Jan 2020 14:22:42 +0000 (UTC)
Date: Thu, 16 Jan 2020 15:22:39 +0100
From: Cornelia Huck <cohuck@redhat.com>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [PATCH] target/s390x/kvm: Enable adapter interruption
 suppression again
Message-ID: <20200116152239.7aa1df68.cohuck@redhat.com>
In-Reply-To: <1e181d83-98ec-a8dd-2b43-0371b8eb65af@de.ibm.com>
References: <20200116122026.5804-1-thuth@redhat.com>
 <20200116135038.2c8cf3c6.cohuck@redhat.com>
 <20b2df78-8d5c-3508-cc80-06cf127ca635@redhat.com>
 <1e181d83-98ec-a8dd-2b43-0371b8eb65af@de.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: Yw3fak1_N6mhM5m7BVRpzg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: Thomas Huth <thuth@redhat.com>, Matthew Rosato <mjrosato@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org,
 Halil Pasic <pasic@linux.ibm.com>, qemu-s390x@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 16 Jan 2020 14:22:15 +0100
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> On 16.01.20 13:55, Thomas Huth wrote:
> > On 16/01/2020 13.50, Cornelia Huck wrote:  
> >> On Thu, 16 Jan 2020 13:20:26 +0100
> >> Thomas Huth <thuth@redhat.com> wrote:
> >>  
> >>> The AIS feature has been disabled late in the v2.10 development
> >>> cycle since there were some issues with migration (see commit
> >>> 3f2d07b3b01ea61126b - "s390x/ais: for 2.10 stable: disable ais
> >>> facility"). We originally wanted to enable it again for newer
> >>> machine types, but apparently we forgot to do this so far. Let's
> >>> do it for the new s390-ccw-virtio-5.0 machine now.
> >>>
> >>> Buglink: https://bugzilla.redhat.com/show_bug.cgi?id=1756946
> >>> Signed-off-by: Thomas Huth <thuth@redhat.com>
> >>> ---
> >>>  hw/s390x/s390-virtio-ccw.c         |  4 ++++
> >>>  include/hw/s390x/s390-virtio-ccw.h |  4 ++++
> >>>  target/s390x/kvm.c                 | 11 ++++++++---
> >>>  3 files changed, 16 insertions(+), 3 deletions(-)
> >>>  
> >>  
> >>> @@ -365,10 +367,13 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
> >>>      /*
> >>>       * The migration interface for ais was introduced with kernel 4.13
> >>>       * but the capability itself had been active since 4.12. As migration
> >>> -     * support is considered necessary let's disable ais in the 2.10
> >>> -     * machine.
> >>> +     * support is considered necessary we only enable this for newer  
> >>
> >> s/necessary we only enable this/necessary, we only try to enable this/
> >>  
> >>> +     * machine types and if KVM_CAP_S390_AIS_MIGRATION is available.  
> >>
> >> maybe s/and if/if/  
> > 
> > Sure ... could you fix it up when picking up the patch (in case I don't
> > have to respin), or do you want me to send a v2?

Sure, can do that.


