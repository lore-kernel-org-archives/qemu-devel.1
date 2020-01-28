Return-Path: <SRS0=Nty2=3R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52CD4C2D0DB
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 15:09:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1DF7D207FD
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 15:09:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JiSEFyAW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DF7D207FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60350 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwSUs-00080w-Bl
	for qemu-devel@archiver.kernel.org; Tue, 28 Jan 2020 10:09:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59590)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1iwSTZ-000697-0B
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 10:08:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1iwSTW-0006AE-27
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 10:08:22 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:28576
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1iwSTV-00069x-QJ
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 10:08:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580224101;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=h8Sk4XXoFZ1qSB06xuYCkVeJQR3VFDPJdxnkLA1k4Es=;
 b=JiSEFyAW+vTB/ozlbiK8qt4XJXgg8C81LOVoOVw0ObLQtq1EEhASRC+WkKT/Ekcn5+81zv
 d8e78N2l5V7v1nOzwJzSqv/YJmDHXADPpsUOtsrRY4OC6H3a6EbLryxqwAzpt7udhN3V5n
 SX/qbTfpZH4h5PAPnU6ICLdUBjfPhOw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-197-f50DuYQoOAW7GPC1ecLNlg-1; Tue, 28 Jan 2020 10:08:18 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A38261882CCC;
 Tue, 28 Jan 2020 15:08:16 +0000 (UTC)
Received: from gondolin (ovpn-116-186.ams2.redhat.com [10.36.116.186])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9463F60BE0;
 Tue, 28 Jan 2020 15:08:12 +0000 (UTC)
Date: Tue, 28 Jan 2020 16:08:09 +0100
From: Cornelia Huck <cohuck@redhat.com>
To: Collin Walling <walling@linux.ibm.com>
Subject: Re: [PATCH v6 2/2] s390: diagnose 318 info reset and migration support
Message-ID: <20200128160809.2b5bec10.cohuck@redhat.com>
In-Reply-To: <4c7cfd8f-3994-404e-1587-293e19f471de@linux.ibm.com>
References: <1579904044-20790-1-git-send-email-walling@linux.ibm.com>
 <1579904044-20790-3-git-send-email-walling@linux.ibm.com>
 <20200127124756.3627f754.cohuck@redhat.com>
 <1cbd5354-d9ca-a10e-0053-a61a00223f53@linux.ibm.com>
 <20200127183504.2de2654f.cohuck@redhat.com>
 <4c7cfd8f-3994-404e-1587-293e19f471de@linux.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: f50DuYQoOAW7GPC1ecLNlg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: borntraeger@de.ibm.com, qemu-s390x@nongnu.org, david@redhat.com,
 qemu-devel@nongnu.org, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 28 Jan 2020 09:37:46 -0500
Collin Walling <walling@linux.ibm.com> wrote:

> On 1/27/20 12:35 PM, Cornelia Huck wrote:
> > On Mon, 27 Jan 2020 11:39:02 -0500
> > Collin Walling <walling@linux.ibm.com> wrote:
> >   
> >> On 1/27/20 6:47 AM, Cornelia Huck wrote:  
> >>> On Fri, 24 Jan 2020 17:14:04 -0500
> >>> Collin Walling <walling@linux.ibm.com> wrote:
> >>>     
> >>>> DIAGNOSE 0x318 (diag318) is a privileged s390x instruction that must
> >>>> be intercepted by SIE and handled via KVM. Let's introduce some
> >>>> functions to communicate between QEMU and KVM via ioctls. These
> >>>> will be used to get/set the diag318 information.    
> >>>
> >>> Do you want to give a hint what diag 318 actually does?
> >>>     
> >>
> >> For the sake of completeness, I'll have to get back to you on this.
> >>  
> 
> The DIAGNOSE 318 instruction allows the guest to store diagnostic data
> that is collected by the firmware in the case of hardware/firmware
> service events. The instruction is invoked in the Linux kernel and
> intercepted in KVM. QEMU needs to collect this data for migration
> so that this data is consistent on the destination host.
> 
> Perhaps I should add this to the patch description as well? :)

Yes, please :) It will make things easier for any unfortunate soul
wanting to find out what this is about in the future.


