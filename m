Return-Path: <SRS0=EIn8=4Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E05DAC3F2D1
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 10:37:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB934246A8
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 10:37:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LGPG710a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB934246A8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45130 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7d1A-0002Mv-Rq
	for qemu-devel@archiver.kernel.org; Fri, 28 Feb 2020 05:37:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60840)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eric.auger@redhat.com>) id 1j7d0D-0000sp-V3
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 05:36:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eric.auger@redhat.com>) id 1j7d0D-0000go-2F
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 05:36:17 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:25338
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eric.auger@redhat.com>)
 id 1j7d0C-0000ga-U1
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 05:36:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582886176;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wNiFe36+jSHVeUnFxzHb1i9e4NrNPl5lb1ru4bjCy34=;
 b=LGPG710adixfYNWJndRxrawa7z5cLHUztEJz4PHJJxpdZBPuyhEN4zeQbEG30QXZIsCSZ9
 3ur8UXAJl9frkXTBDhDtL18/tgJhwIdhHu0KRjbC7sWXgjhQUbPgE5onr9XFKCw4V3F29b
 pAaDeKt2NB798MTWg2kzQITQTvO0AMc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-12-Y7IKc1eaOTq2eycO8iYt9A-1; Fri, 28 Feb 2020 05:36:14 -0500
X-MC-Unique: Y7IKc1eaOTq2eycO8iYt9A-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CFFC38024CF
 for <qemu-devel@nongnu.org>; Fri, 28 Feb 2020 10:36:13 +0000 (UTC)
Received: from [10.36.116.59] (ovpn-116-59.ams2.redhat.com [10.36.116.59])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1CFF11CB;
 Fri, 28 Feb 2020 10:36:06 +0000 (UTC)
Subject: Re: [PATCH v1.1 4/5] KVM: Kick resamplefd for split kernel irqchip
To: Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>
References: <20200227170048.236599-1-peterx@redhat.com>
 <5e69c385-b27c-61d4-5856-21bcf5e9c8f5@redhat.com>
 <20200227180003.GJ180973@xz-x1>
 <2852480c-89fe-4c4e-75be-7322592976b6@redhat.com>
 <20200227191900.GK180973@xz-x1>
 <8ab9ccaa-7060-9e90-d4a9-a9de32610381@redhat.com>
 <8c3e3f25-b20e-08bd-fa1e-f307fe7f02a4@redhat.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <7851fc72-6001-25d3-8b17-f6fda827ea74@redhat.com>
Date: Fri, 28 Feb 2020 11:36:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <8c3e3f25-b20e-08bd-fa1e-f307fe7f02a4@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
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
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Paolo,

On 2/28/20 11:34 AM, Paolo Bonzini wrote:
> On 27/02/20 22:14, Auger Eric wrote:
>>> Yes KVM kernel side should not be involed when we're using split
>>> irqchip in this case.  However it should still belongs to the work of
>>> the userspace KVM module (kvm-all.c) so that it can still "mimic" the
>>> resamplefd feature that KVM_IRQFD provides.
>> OK. So that what my actual question. Should this be handled by kvm-all.c?
> 
> I think it should; kvm-all.c in this case is providing the API to enable
> irqfds (including resamplefds).
> 
> You could have a generic file descriptor<->interrupt routing subsystem,
> but for now that only exists for KVM so that's where Peter's code need
> to go.

OK

Thanks

Eric
> 
> Paolo
> 


