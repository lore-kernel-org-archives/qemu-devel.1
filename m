Return-Path: <SRS0=zj/5=4O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B126C4BA0B
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 11:59:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 06D5D24684
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 11:59:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EGftrjS8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06D5D24684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43206 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6vLr-0002Ef-6A
	for qemu-devel@archiver.kernel.org; Wed, 26 Feb 2020 06:59:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39630)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eric.auger@redhat.com>) id 1j6vKV-0000F3-K2
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 06:58:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eric.auger@redhat.com>) id 1j6vKU-0001dS-FS
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 06:58:19 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:51248
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eric.auger@redhat.com>)
 id 1j6vKU-0001ck-BW
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 06:58:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582718298;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NBDRsQwNUbNzP+QooB1eTn8YugDawSHkcwRNbopfuqw=;
 b=EGftrjS8tF6BCnxTgssHH08I3ULO9uKt+ZoeCfkEY4G79YPDwIG0I/7H7ws+RlxoqbdAH9
 8pmjBcMxJhjhsXiMOSvadUd9dSoSo0wnMrOK0BK5+HQMlx95bLT7lu+AtPWzJO0P7Ar7z9
 N5ZGgDyfHhg8yrM0EdJl2oFegQeHePw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-197-gTVWxw8PNmebnr5z8nVNzQ-1; Wed, 26 Feb 2020 06:58:14 -0500
X-MC-Unique: gTVWxw8PNmebnr5z8nVNzQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0FEDC1005514;
 Wed, 26 Feb 2020 11:58:13 +0000 (UTC)
Received: from [10.36.116.59] (ovpn-116-59.ams2.redhat.com [10.36.116.59])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B68A1100164D;
 Wed, 26 Feb 2020 11:58:11 +0000 (UTC)
Subject: Re: [PATCH] hw/intc/arm_gic_kvm: Don't assume kernel can provide a
 GICv2
To: Andrew Jones <drjones@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
References: <20200225182435.1131-1-peter.maydell@linaro.org>
 <20200226085209.ni7oph6odt24warq@kamzik.brq.redhat.com>
 <CAFEAcA-Bhuy+2dU3joZoip5=tOkiTSoC+LzdNzyd+urUnoRNXw@mail.gmail.com>
 <20200226091750.mqkbqffod247bori@kamzik.brq.redhat.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <85d78328-0843-3f11-7a79-6010aea3d3dd@redhat.com>
Date: Wed, 26 Feb 2020 12:58:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20200226091750.mqkbqffod247bori@kamzik.brq.redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
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
Cc: Marc Zyngier <maz@kernel.org>, qemu-arm <qemu-arm@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Peter,

On 2/26/20 10:17 AM, Andrew Jones wrote:
> On Wed, Feb 26, 2020 at 08:56:03AM +0000, Peter Maydell wrote:
>> On Wed, 26 Feb 2020 at 08:52, Andrew Jones <drjones@redhat.com> wrote:
>>> Although, many QEMU command line users still won't know what to do
>>> without an explicit "Try -machine gic-version=host" hint, so that
>>> might be nice to add too.
>>
>> In the GIC code we don't know if the machine even has a
>> gic-version property, so we're not in the right place to try to
>> produce that message.
>>
> 
> Ah yes, we use qdev_init_nofail() in virt::create_gic(), so there's
> no chance to append another hint at the machine level.
> 
> And what about when machine.gic-version is not provided and KVM is
> in use? Shouldn't we try version '2', as we do now, but then also
> '3', if '2' fails, before erroring out?

In case of KVM accelerated mode we could effectively probe v2 first and
if not supported choose v3, as mentioned by Drew.

Couldn't kvm_arm_vgic_probe() return a bitmap by calling
kvm_create_device on both versions in dryrun mode?

Thanks

Eric

> 
> Thanks,
> drew
> 
> 


