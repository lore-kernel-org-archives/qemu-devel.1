Return-Path: <SRS0=Nty2=3R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B55CC33C9E
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 11:25:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB0D924681
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 11:25:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LRC4UmHl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB0D924681
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57454 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwOzV-0002Fp-5Z
	for qemu-devel@archiver.kernel.org; Tue, 28 Jan 2020 06:25:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60178)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1iwOys-0001q1-H7
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 06:24:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1iwOyq-0003uT-S2
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 06:24:30 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:27811
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1iwOyq-0003tJ-OY
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 06:24:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580210668;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=C9EhQdcctfHBal6s7JqbJIBfivGfxtbRt7Hg27OolxI=;
 b=LRC4UmHldPrtsaPrMPc7LOovzty0sTkadt38EHWIAXWeaKJqYS3uLkp5CI4hvF8MSLbhkK
 RagWAzH+Ms76wjeMwDPU94Gs8PhnIMA/eJcqnMMDu3mVfpJCaVnClZ1Ug12UdBHMo/+491
 CKPfOkIFlF2fHERADc1CUbinVn3pbAc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-423-Fzc_iIJhN2WyDbOjwCyi5w-1; Tue, 28 Jan 2020 06:24:26 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 33841800D4C;
 Tue, 28 Jan 2020 11:24:25 +0000 (UTC)
Received: from gondolin (ovpn-116-186.ams2.redhat.com [10.36.116.186])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 801CB5D9C9;
 Tue, 28 Jan 2020 11:24:21 +0000 (UTC)
Date: Tue, 28 Jan 2020 12:24:18 +0100
From: Cornelia Huck <cohuck@redhat.com>
To: Collin Walling <walling@linux.ibm.com>
Subject: Re: [PATCH v6 2/2] s390: diagnose 318 info reset and migration support
Message-ID: <20200128122418.7533f4bb.cohuck@redhat.com>
In-Reply-To: <a4bfb688-3641-6c31-ad7b-e72afd5e6d50@linux.ibm.com>
References: <1579904044-20790-1-git-send-email-walling@linux.ibm.com>
 <1579904044-20790-3-git-send-email-walling@linux.ibm.com>
 <20200127124756.3627f754.cohuck@redhat.com>
 <1cbd5354-d9ca-a10e-0053-a61a00223f53@linux.ibm.com>
 <20200127183504.2de2654f.cohuck@redhat.com>
 <a4bfb688-3641-6c31-ad7b-e72afd5e6d50@linux.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: Fzc_iIJhN2WyDbOjwCyi5w-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 207.211.31.120
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
Cc: borntraeger@de.ibm.com, qemu-s390x@nongnu.org, david@redhat.com,
 qemu-devel@nongnu.org, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 27 Jan 2020 18:05:36 -0500
Collin Walling <walling@linux.ibm.com> wrote:

> On 1/27/20 12:35 PM, Cornelia Huck wrote:
> > On Mon, 27 Jan 2020 11:39:02 -0500
> > Collin Walling <walling@linux.ibm.com> wrote:
> >   
> >> On 1/27/20 6:47 AM, Cornelia Huck wrote:  
> >>> On Fri, 24 Jan 2020 17:14:04 -0500
> >>> Collin Walling <walling@linux.ibm.com> wrote:
> >>>     
> 
> [...]
> 
> >>>>
> >>>> The availability of this instruction is determined by byte 134, bit 0
> >>>> of the Read Info block. This coincidentally expands into the space used    
> >>>
> >>> "SCLP Read Info"
> >>>     
> >>>> for CPU entries by taking away one byte, which means VMs running with
> >>>> the diag318 capability will not be able to retrieve information regarding
> >>>> the 248th CPU. This will not effect performance, and VMs can still be
> >>>> ran with 248 CPUs.    
> >>>
> >>> Are there other ways in which that might affect guests? I assume Linux
> >>> can deal with it? Is it ok architecture-wise?
> >>>
> >>> In any case, should go into the patch description :)
> >>>     
> >>
> >> Same as above. I'll try to provide more information regarding what happens
> >> here in my next reply.  
> > 
> > I think you can lift some stuff from the cover letter.
> >   
> 
> Here's what I found out:
> 
> Each CPU entry holds info regarding the CPU's address / ID as well as an 
> indication of the availability of certain CPU features. With these patches,
> we lose a CPU entry for one CPU (essentially what would be the CPU at the
> tail-end of the list). This CPU exists, but is essentially in limbo... the
> machine cannot access any information regarding it.

s/machine/guest/ ?

> 
> So, a VM can run with the original N max CPUs, but in reality we can only
> utilize n-1. 

s/we/the guest/ ?

With those changes, it makes sense to put your explanations into the
patch description (for later reference).

> 
> >>  
> >>>>  
> 
> [...]
> 
> 


