Return-Path: <SRS0=UKTp=CS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B28CC10DAA
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 09:45:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C77E821973
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 09:45:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NoGWGsVw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C77E821973
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53696 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFwey-0003lw-Mh
	for qemu-devel@archiver.kernel.org; Wed, 09 Sep 2020 05:45:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56550)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1kFweA-0002st-OL
 for qemu-devel@nongnu.org; Wed, 09 Sep 2020 05:44:10 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:25306
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1kFwe8-0007Ih-Oo
 for qemu-devel@nongnu.org; Wed, 09 Sep 2020 05:44:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599644647;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=B+umb5F9v1Mf3Kcr7eNrizPaOwtFfBybZe6a9CjM/Cc=;
 b=NoGWGsVwOiNe7BsdBq3SA2/aBToDqu6FeHrp5ij5gsamwM5LbBehhSOxqwSZ0ysLGWtC3/
 f55eDymtV+EdKZnGmkLMS9953yL9X6H6ihAC1x3yvC3YMAHdmBz0f2Iie//UDB/liahx6z
 stceCE8qxEMdrOUka0pSRN/aGu28fvU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-388-i5QtLMleOmWhJKb8fM18bg-1; Wed, 09 Sep 2020 05:44:04 -0400
X-MC-Unique: i5QtLMleOmWhJKb8fM18bg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7D78A1074647;
 Wed,  9 Sep 2020 09:44:02 +0000 (UTC)
Received: from gondolin (ovpn-113-3.ams2.redhat.com [10.36.113.3])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 020A127BCF;
 Wed,  9 Sep 2020 09:43:53 +0000 (UTC)
Date: Wed, 9 Sep 2020 11:43:51 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [PATCH v4 0/8] s390: Extended-Length SCCB & DIAGNOSE 0x318
Message-ID: <20200909114351.1f91f330.cohuck@redhat.com>
In-Reply-To: <20200909104623.57664738.cohuck@redhat.com>
References: <20200624202312.28349-1-walling@linux.ibm.com>
 <b1d68acf-881f-be0f-c1ac-d32b8bfc859d@linux.ibm.com>
 <20200715180409.451d217e.cohuck@redhat.com>
 <d59bd0a5-0660-0c22-09dd-018be6dfe74f@linux.ibm.com>
 <20200716140214.3fdc7590.cohuck@redhat.com>
 <42dde86f-2f12-3b89-0c35-74d69fa3d449@de.ibm.com>
 <20200909104623.57664738.cohuck@redhat.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=cohuck@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/09 03:20:45
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Collin Walling <walling@linux.ibm.com>, frankja@linux.ibm.com,
 mst@redhat.com, david@redhat.com, qemu-devel@nongnu.org, pasic@linux.ibm.com,
 qemu-s390x@nongnu.org, svens@linux.ibm.com, thuth@redhat.com,
 pbonzini@redhat.com, mihajlov@linux.ibm.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 9 Sep 2020 10:46:23 +0200
Cornelia Huck <cohuck@redhat.com> wrote:

> On Wed, 9 Sep 2020 09:54:40 +0200
> Christian Borntraeger <borntraeger@de.ibm.com> wrote:
> 
> > On 16.07.20 14:02, Cornelia Huck wrote:  
> > > On Wed, 15 Jul 2020 12:26:20 -0400
> > > Collin Walling <walling@linux.ibm.com> wrote:
> > >     
> > >> On 7/15/20 12:04 PM, Cornelia Huck wrote:    
> > >>> On Wed, 15 Jul 2020 11:36:35 -0400
> > >>> Collin Walling <walling@linux.ibm.com> wrote:
> > >>>       
> > >>>> Polite ping. Patches have been sitting on the list for a few weeks now,
> > >>>> and it doesn't look like any further changes are requested (hopefully I
> > >>>> didn't miss something).      
> > >>>
> > >>> The only thing I had was (I think) the logging of the length you just
> > >>> replied to. We can still tweak things like that later, of course.
> > >>>
> > >>> As these patches depend on a headers sync, I could not yet queue them.
> > >>> I can keep a preliminary version on a branch. I assume that the header
> > >>> changes will go in during the next kernel merge window? (If I missed
> > >>> something, apologies for that.)
> > >>>       
> > >>
> > >> Gotcha. Thanks for the update :)
> > >>
> > >> There was an email on the KVM list a couple of days that made one change
> > >> to the Linux header. Just changed the integer used for the DIAG cap,
> > >> which should be reflected in QEMU as well.
> > >>
> > >> https://www.spinics.net/lists/kvm/msg220548.html
> > >>
> > >> Should I respin this patch series to include the new ack's and account
> > >> for the header sync?    
> > > 
> > > No need for that, my tooling picks up acks and the headers update needs
> > > to be replaced with a sync against a proper Linux version anyway.
> > > 
> > > I've queued the patches on a local branch, and the only patch that did
> > > not apply cleanly was the headers patch, which will get replaced later
> > > anyway :) Just ping me when the kernel patches hit upstream, then I'll
> > > do a header sync against the next -rc and queue the patches on
> > > s390-next.    
> > 
> > What is the status of this patchset? The kernel part has been merged in 5.9-rc1.
> >   
> 
> Thanks for letting me know, I'll go and process this now. (Had some
> busy weeks + PTO.)

There were some minor conflicts, please double check that everything
looks sane.

Thanks, applied.


