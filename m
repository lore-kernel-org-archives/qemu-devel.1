Return-Path: <SRS0=sZ1e=65=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CF71C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 18:38:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E00272070A
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 18:38:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HG4DgOUI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E00272070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35072 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZfE1-00030U-2t
	for qemu-devel@archiver.kernel.org; Fri, 15 May 2020 14:38:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52632)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jZfCn-0002Bc-9M
 for qemu-devel@nongnu.org; Fri, 15 May 2020 14:37:09 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:20871
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jZfCl-0002v0-SR
 for qemu-devel@nongnu.org; Fri, 15 May 2020 14:37:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589567826;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=iS2BZEZhYnHE5mi0Tf0cUE2Vbxbk8ajM07NE1jWnMoA=;
 b=HG4DgOUIcBLWUcwjmssNuVyPsSwcepB0oWK4PhVdXwZyMbrSSKtpzCSiA4EFK5+ALHrZI9
 zQQ9kY6p+UlHaLjRo72vi/3HJWWvkDp8leJqL4LioG6yi9G5qIl1Eks3LUdS+cRckv663a
 vgc4H9vPChxswmC8Tlu667GqHf7PuFs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-466-Zy5vaWusMkeTl9eED5XF2g-1; Fri, 15 May 2020 14:37:04 -0400
X-MC-Unique: Zy5vaWusMkeTl9eED5XF2g-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9B7B480B73A;
 Fri, 15 May 2020 18:37:03 +0000 (UTC)
Received: from work-vm (ovpn-114-149.ams2.redhat.com [10.36.114.149])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0F3725C3E7;
 Fri, 15 May 2020 18:36:54 +0000 (UTC)
Date: Fri, 15 May 2020 19:36:52 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v1 07/17] migration/rdma: Use
 ram_block_discard_set_broken()
Message-ID: <20200515183652.GM2954@work-vm>
References: <20200506094948.76388-1-david@redhat.com>
 <20200506094948.76388-8-david@redhat.com>
 <20200515124501.GE2954@work-vm>
 <96a58e88-2629-f2ee-5884-38d11e571548@redhat.com>
 <20200515175105.GL2954@work-vm>
 <1cac6cb0-7804-bab2-4ecf-044c369c1135@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1cac6cb0-7804-bab2-4ecf-044c369c1135@redhat.com>
User-Agent: Mutt/1.13.4 (2020-02-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Received-SPF: pass client-ip=205.139.110.120; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/14 23:27:07
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 T_HK_NAME_DR=0.01 autolearn=_AUTOLEARN
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, kvm@vger.kernel.org,
 "Michael S . Tsirkin" <mst@redhat.com>, Juan Quintela <quintela@redhat.com>,
 qemu-devel@nongnu.org, qemu-s390x@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* David Hildenbrand (david@redhat.com) wrote:
> On 15.05.20 19:51, Dr. David Alan Gilbert wrote:
> > * David Hildenbrand (david@redhat.com) wrote:
> >> On 15.05.20 14:45, Dr. David Alan Gilbert wrote:
> >>> * David Hildenbrand (david@redhat.com) wrote:
> >>>> RDMA will pin all guest memory (as documented in docs/rdma.txt). We want
> >>>> to mark RAM block discards to be broken - however, to keep it simple
> >>>> use ram_block_discard_is_required() instead of inhibiting.
> >>>
> >>> Should this be dependent on whether rdma->pin_all is set?
> >>> Even with !pin_all some will be pinned at any given time
> >>> (when it's registered with the rdma stack).
> >>
> >> Do you know how much memory this is? Is such memory only temporarily pinned?
> > 
> > With pin_all not set, only a subset of memory, I think multiple 1MB
> > chunks, are pinned at any one time.
> > 
> >> At least with special-cases of vfio, it's acceptable if some memory is
> >> temporarily pinned - we assume it's only the working set of the driver,
> >> which guests will not inflate as long as they don't want to shoot
> >> themselves in the foot.
> >>
> >> This here sounds like the guest does not know the pinned memory is
> >> special, right?
> > 
> > Right - for RDMA it's all of memory that's being transferred, and the
> > guest doesn't see when each part is transferred.
> 
> 
> Okay, so all memory will eventually be pinned, just not at the same
> time, correct?
> 
> I think this implies that any memory that was previously discarded will
> be backed my new pages, meaning we will consume more memory than intended.
> 
> If so, always disabling discarding of RAM seems to be the right thing to do.

Yeh that's probably true, although there's a check for 'buffer_is_zero'
in the !rdma->pin_all case, if the entire area is zero (or probably if
unmapped) then it sends a notification rather than registering; see
qemu_rdma_write_one and search for 'This chunk has not yet been
registered, so first check to see'

Dave

> 
> -- 
> Thanks,
> 
> David / dhildenb
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


