Return-Path: <SRS0=DsKm=5S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MISSING_HEADERS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1D33C43331
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 15:07:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B4BD206CC
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 15:07:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fW8+MEZz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B4BD206CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42814 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jK1Qy-0006cl-QY
	for qemu-devel@archiver.kernel.org; Thu, 02 Apr 2020 11:07:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42979)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1jK1Lc-0008Ho-Ie
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 11:01:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1jK1La-00014e-BQ
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 11:01:36 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:25460
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1jK1La-00012O-5f
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 11:01:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585839693;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mZgyUPwLrUFarChIoo/f/EiP+C1ovxB90ngX6/X2O/g=;
 b=fW8+MEZzNDAWvqd0nCxvNtXyQaWJ2CKskxrgPFd3xcwkh+SCvvE3r17xV1Hu7jXR5qVYSY
 I5ATZ7pQsj46M6DipgjV8YH0uoPTggnEmJwsSIQmChl8E8tgaT6CTeH+RSdkw91Q91bwZG
 gAtyXEbCHI+GqdNtQeMPLRKcYVViYTg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-408-R-g7E9H8Mwegg2Xp-Viyyw-1; Thu, 02 Apr 2020 11:01:29 -0400
X-MC-Unique: R-g7E9H8Mwegg2Xp-Viyyw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EB73818AB2C0
 for <qemu-devel@nongnu.org>; Thu,  2 Apr 2020 15:01:28 +0000 (UTC)
Received: from localhost (unknown [10.40.208.7])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3DC991001925;
 Thu,  2 Apr 2020 15:01:25 +0000 (UTC)
Date: Thu, 2 Apr 2020 17:01:23 +0200
From: Igor Mammedov <imammedo@redhat.com>
Subject: Re: [PATCH v3 1/1] vl/s390x: fixup ram sizes for compat machines
Message-ID: <20200402170123.2e132d0a@redhat.com>
In-Reply-To: <98d87752-ba5d-7ac1-6074-978ade3d2652@de.ibm.com>
References: <20200401123754.109602-1-borntraeger@de.ibm.com>
 <20200401183456.09ba3540@redhat.com>
 <20200402112735.6961297d.cohuck@redhat.com>
 <20200402133958.72fabf45@redhat.com>
 <e3dfecd4-2905-dc8b-92e7-2194a52ea9ea@de.ibm.com>
 <20200402140536.1b9e7c41@redhat.com>
 <03077928-4d17-f860-1907-3d1fcea3ab3c@de.ibm.com>
 <98d87752-ba5d-7ac1-6074-978ade3d2652@de.ibm.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 2
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: qemu-devel <qemu-devel@nongnu.org>, peterx@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 2 Apr 2020 14:35:21 +0200
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> On 02.04.20 14:09, Christian Borntraeger wrote:
> > 
> > 
> > On 02.04.20 14:05, Igor Mammedov wrote:  
> >> On Thu, 2 Apr 2020 13:42:22 +0200
> >> Christian Borntraeger <borntraeger@de.ibm.com> wrote:
> >>  
> >>> On 02.04.20 13:39, Igor Mammedov wrote:
> >>> [...]  
> >>>>>>       
> >>>>>>> +                    "MB to match machine restrictions. Consider updating "
> >>>>>>> +                    "the guest definition.i\n", sz / MiB, newsz / MiB);        
> >>>>>>
> >>>>>> also it might be better to use size_to_str() to format numbers      
> >>>>>
> >>>>> The text explicitly talks about 'MB'... not sure if it would be
> >>>>> confusing if the user specified MB and ended up with GB or so in this
> >>>>> message.    
> >>>>
> >>>> MB can be dropped, since it still might not match what user specified with -m
> >>>> it could be specified in b/kb/mb/gb over there
> >>>>
> >>>> so I'd drop MB and print value size_to_str() returns
> >>>> (it will add appropriate suffix if I'm not mistaken)  
> > 
> > Another thing: size_to_str is also do rounding (whenever the integer part is >1000).
> > Doesnt this result in potential messages where both numbers are the same?  
> 
> For example
> 
> 10241263616-> 9.54 GiB
> 10241262592-> 9.54 GiB

doesn't seem to be working as one would expect (and it's used in number of places now)
CCing original author of it

> The only guaranteed way to actually see a difference is to use MB.
> 
> 


