Return-Path: <SRS0=PUPy=YH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 563BBC4CECE
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 13:52:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2992D207FF
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 13:52:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2992D207FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49894 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iK0lZ-00079o-9Z
	for qemu-devel@archiver.kernel.org; Mon, 14 Oct 2019 09:52:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39745)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1iK0iC-0003Wu-0h
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 09:48:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1iK0i9-0007hV-Ec
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 09:48:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55872)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1iK0i9-0007g4-96
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 09:48:33 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id C70A9A707;
 Mon, 14 Oct 2019 13:48:31 +0000 (UTC)
Received: from gondolin (dhcp-192-233.str.redhat.com [10.33.192.233])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4BBCF1001B03;
 Mon, 14 Oct 2019 13:48:27 +0000 (UTC)
Date: Mon, 14 Oct 2019 15:48:25 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: Tianyu Lan <Tianyu.Lan@microsoft.com>
Subject: Re: [PATCH] target/i386/kvm: Add Hyper-V direct tlb flush support
Message-ID: <20191014154825.7eb5017d.cohuck@redhat.com>
In-Reply-To: <KL1P15301MB02611D1F7C54C4A599766B8D92900@KL1P15301MB0261.APCP153.PROD.OUTLOOK.COM>
References: <20191012034153.31817-1-Tianyu.Lan@microsoft.com>
 <87r23h58th.fsf@vitty.brq.redhat.com>
 <KL1P15301MB02611D1F7C54C4A599766B8D92900@KL1P15301MB0261.APCP153.PROD.OUTLOOK.COM>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.29]); Mon, 14 Oct 2019 13:48:31 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: "ehabkost@redhat.com" <ehabkost@redhat.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "mst@redhat.com" <mst@redhat.com>,
 "mtosatti@redhat.com" <mtosatti@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Roman Kagan <rkagan@virtuozzo.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>, vkuznets <vkuznets@redhat.com>,
 "rth@twiddle.net" <rth@twiddle.net>,
 "lantianyu1986@gmail.com" <lantianyu1986@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 14 Oct 2019 13:29:12 +0000
Tianyu Lan <Tianyu.Lan@microsoft.com> wrote:

> > > diff --git a/linux-headers/linux/kvm.h b/linux-headers/linux/kvm.h
> > > index 18892d6541..923fb33a01 100644
> > > --- a/linux-headers/linux/kvm.h
> > > +++ b/linux-headers/linux/kvm.h
> > > @@ -995,6 +995,7 @@ struct kvm_ppc_resize_hpt {
> > >  #define KVM_CAP_ARM_SVE 170
> > >  #define KVM_CAP_ARM_PTRAUTH_ADDRESS 171
> > >  #define KVM_CAP_ARM_PTRAUTH_GENERIC 172
> > > +#define KVM_CAP_HYPERV_DIRECT_TLBFLUSH 174  
> >
> > I was once told that scripts/update-linux-headers.sh script is supposed
> > to be used instead of cherry-picking stuff you need (adn this would be a
> > separate patch - update linux headers to smth).
> >  
> 
> Thanks for suggestion. I just try the update-linux-headers.sh and there are a lot
> of changes which are not related with my patch. I also include these
> changes in my patch, right?

The important part is that you split out the headers update as a
separate patch.

If this change is already included in the upstream kernel, just do a
complete update via the script (mentioning the base you did the update
against.) If not, include a placeholder patch that can be replaced by a
real update when applying.

