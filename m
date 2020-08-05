Return-Path: <SRS0=Uy1J=BP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50116C433E1
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2020 10:28:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 210F2206B6
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2020 10:28:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AxBn8Vt+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 210F2206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39194 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3Geb-000559-9n
	for qemu-devel@archiver.kernel.org; Wed, 05 Aug 2020 06:28:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44308)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1k3Ge1-0004g5-KE
 for qemu-devel@nongnu.org; Wed, 05 Aug 2020 06:27:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:48514)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1k3Gdz-0003uq-Rw
 for qemu-devel@nongnu.org; Wed, 05 Aug 2020 06:27:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596623254;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=P6AiNMRW67lC4QSHSkrWpdaPKSIn5mp6WlsNQ1x8cY8=;
 b=AxBn8Vt+SjGlWISqGF2Y2gWFwPtmck1CZT+0kH5mslolgojJaUDcC11BHVKRs9EA7ODMC0
 CSZJ5vfBhsDwmHtHOgHJb+FlRFuPJK7BAH4GVbWKTeTAXuspCfvngTZJNunb7BlJzKhfnG
 eiez8IdPsNhjimKMyPJUr3R/Vl1hwDM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-162-vR1xmLyGO06dxXw9h6vWkw-1; Wed, 05 Aug 2020 06:27:31 -0400
X-MC-Unique: vR1xmLyGO06dxXw9h6vWkw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A7A7A10059A2;
 Wed,  5 Aug 2020 10:27:29 +0000 (UTC)
Received: from gondolin (ovpn-113-4.ams2.redhat.com [10.36.113.4])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 00B815DA6B;
 Wed,  5 Aug 2020 10:27:27 +0000 (UTC)
Date: Wed, 5 Aug 2020 12:27:08 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH for-5.2 6/6] pc-bios/s390-ccw: Allow booting in case the
 first virtio-blk disk is bad
Message-ID: <20200805122708.070919ff.cohuck@redhat.com>
In-Reply-To: <7810397f-4199-ffab-1bc2-9b7513133aff@redhat.com>
References: <20200728183734.7838-1-thuth@redhat.com>
 <20200728183734.7838-7-thuth@redhat.com>
 <20200805120418.072042c8.cohuck@redhat.com>
 <7810397f-4199-ffab-1bc2-9b7513133aff@redhat.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/05 06:27:34
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: "Jason J . Herne" <jjherne@linux.ibm.com>,
 Collin Walling <walling@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>,
 qemu-devel@nongnu.org, Christian Borntraeger <borntraeger@de.ibm.com>,
 qemu-s390x@nongnu.org, Claudio Imbrenda <imbrenda@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 5 Aug 2020 12:08:59 +0200
Thomas Huth <thuth@redhat.com> wrote:

> On 05/08/2020 12.04, Cornelia Huck wrote:
> > On Tue, 28 Jul 2020 20:37:34 +0200
> > Thomas Huth <thuth@redhat.com> wrote:
> >   
> >> If you try to boot with two virtio-blk disks (without bootindex), and
> >> only the second one is bootable, the s390-ccw bios currently stops at
> >> the first disk and does not continue booting from the second one. This
> >> is annoying - and all other major QEMU firmwares succeed to boot from
> >> the second disk in this case, so we should do the same in the s390-ccw
> >> bios, too.  
> > 
> > Does it make sense to do something like that for other device types as
> > well?  
> 
> It would be nice if we could do the same for virtio-scsi disks, but the
> code is written in a way here that it will need much more thinking,
> cleanups and time to get this done right...

Yeah, let's just go for the lower-hanging fruit first, and then see if
someone's sufficiently motivated to grab a ladder.


