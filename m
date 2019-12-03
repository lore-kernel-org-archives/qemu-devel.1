Return-Path: <SRS0=HheB=ZZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11DF6C43141
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 11:48:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D1C9120684
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 11:48:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="baWrfLAc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1C9120684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52170 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ic6fA-0005H9-UJ
	for qemu-devel@archiver.kernel.org; Tue, 03 Dec 2019 06:48:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37236)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1ic6c9-0003Te-Ga
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 06:45:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1ic6c1-0001aB-GO
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 06:45:03 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:57199
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1ic6c0-0001Yw-9W
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 06:45:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575373499;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nJ41p/tzxbTOC8IoXb8AO9fnQXerJ9pxq69DVS6la58=;
 b=baWrfLAc2NjJW1koXZQmysEpaSRxA0w/NlSeJrpvAim546ExTZi4xdB+qGoIBGeDAr5DMc
 SuhWEw8KP3yrLAQw0qXCRxHOfwcbiD9msv4yUYk81BOFmxWEhdWeRfiWs+NlonCeT2IMZG
 Nv/B5aY4x6dNOxyN4e199jzjuAUGTTA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-3-0FEI4IavMOCpV58pIn4DAQ-1; Tue, 03 Dec 2019 06:44:58 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 15DCA800D41;
 Tue,  3 Dec 2019 11:44:57 +0000 (UTC)
Received: from gondolin (ovpn-116-214.ams2.redhat.com [10.36.116.214])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 20892608E2;
 Tue,  3 Dec 2019 11:44:51 +0000 (UTC)
Date: Tue, 3 Dec 2019 12:44:49 +0100
From: Cornelia Huck <cohuck@redhat.com>
To: Damien Hedde <damien.hedde@greensocs.com>
Subject: Re: [PATCH v5 00/13] Multi-phase reset mechanism
Message-ID: <20191203124449.72158cb9.cohuck@redhat.com>
In-Reply-To: <20191018150630.31099-1-damien.hedde@greensocs.com>
References: <20191018150630.31099-1-damien.hedde@greensocs.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: 0FEI4IavMOCpV58pIn4DAQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: peter.maydell@linaro.org, berrange@redhat.com, ehabkost@redhat.com,
 qemu-s390x@nongnu.org, mark.burton@greensocs.com, qemu-devel@nongnu.org,
 edgari@xilinx.com, qemu-arm@nongnu.org, pbonzini@redhat.com, philmd@redhat.com,
 david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 18 Oct 2019 17:06:17 +0200
Damien Hedde <damien.hedde@greensocs.com> wrote:

> Hi all,
> 
> The purpose of this series is to split the current reset procedure
> into multiple phases. This will help to solve some ordering
> difficulties we have during reset. Previous version can be found here:
> https://lists.gnu.org/archive/html/qemu-devel/2019-08/msg04359.html
> 
> This series adds resettable interface and transitions base Device and
> Bus classes (sysbus subclasses are ok too). It provides new reset
> functions but does not switch anymore the old functions
> (device_reset() and qdev/qbus_reset_all()) to resettable interface.
> These functions keep the exact same behavior as before.
> 
> The series also transition the main reset handlers registration which
> has no impact until devices and buses are transitioned.
> 
> I think this version is way better regarding the transition from the
> legacy to the resettable interface than the previous one.
> After this series, the plan is then to transition devices, buses and
> legacy reset call sites. Devices and buses have to be transitioned
> from mother class to daughter classes order but until the final
> (daughter) class is transitioned, old monolitic reset behavior will
> be kept for this class.

I have looked over this patchset a bit (with an eye to the s390 stuff).
Seems sane, although I currently don't have the resources to review
more in detail.


