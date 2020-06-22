Return-Path: <SRS0=TEh4=AD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2106AC433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 12:04:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E01DF2071A
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 12:04:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Uod1+XEn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E01DF2071A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57982 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnLBy-000388-2E
	for qemu-devel@archiver.kernel.org; Mon, 22 Jun 2020 08:04:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55016)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1jnLAS-0001mf-3t
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 08:03:16 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:49683
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1jnLAP-0005Xd-Qd
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 08:03:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592827392;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bVZM5JCuZkIi5xnj5bE3R/j/IYiq0+TYez1QiVgCgow=;
 b=Uod1+XEnPcRksbEXOdBcGV0OVfgqFN0UkJevoBdstgiUG2qgMXjyNXhpd3pzl5WsgcMsPS
 4TK8fu0n6P2Zt/2cC6Zl+kbRHgQCRMzawwGLSdfomAivlmabCqWh+pY42i1iXVbJZZ6ZUO
 GhRleJZBPl9YFAdF9QY2rwbJJmGclvU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-264-EnuZ-F8lNi-ouCQj2c7U3Q-1; Mon, 22 Jun 2020 08:03:11 -0400
X-MC-Unique: EnuZ-F8lNi-ouCQj2c7U3Q-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1B3728014D4;
 Mon, 22 Jun 2020 12:03:09 +0000 (UTC)
Received: from gondolin (ovpn-113-56.ams2.redhat.com [10.36.113.56])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D5742100238C;
 Mon, 22 Jun 2020 12:02:56 +0000 (UTC)
Date: Mon, 22 Jun 2020 14:02:54 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v3 0/9] Generalize memory encryption models
Message-ID: <20200622140254.0dbe5d8c.cohuck@redhat.com>
In-Reply-To: <358d48e5-4c57-808b-50da-275f5e2a352c@redhat.com>
References: <20200619020602.118306-1-david@gibson.dropbear.id.au>
 <e045e202-cd56-4ddc-8c1d-a2fe5a799d32@redhat.com>
 <20200619114526.6a6f70c6.cohuck@redhat.com>
 <79890826-f67c-2228-e98d-25d2168be3da@redhat.com>
 <20200619120530.256c36cb.cohuck@redhat.com>
 <358d48e5-4c57-808b-50da-275f5e2a352c@redhat.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Received-SPF: pass client-ip=205.139.110.61; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/22 03:17:49
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: pair@us.ibm.com, brijesh.singh@amd.com, frankja@linux.ibm.com,
 kvm@vger.kernel.org, mst@redhat.com, qemu-devel@nongnu.org,
 Eduardo Habkost <ehabkost@redhat.com>, dgilbert@redhat.com,
 pasic@linux.ibm.com, qemu-s390x@nongnu.org, qemu-ppc@nongnu.org,
 pbonzini@redhat.com, Richard Henderson <rth@twiddle.net>,
 mdroth@linux.vnet.ibm.com, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 19 Jun 2020 12:10:13 +0200
David Hildenbrand <david@redhat.com> wrote:

> On 19.06.20 12:05, Cornelia Huck wrote:
> > On Fri, 19 Jun 2020 11:56:49 +0200
> > David Hildenbrand <david@redhat.com> wrote:
> >   
> >>>>> For now this series covers just AMD SEV and POWER PEF.  I'm hoping it
> >>>>> can be extended to cover the Intel and s390 mechanisms as well,
> >>>>> though.      
> >>>>
> >>>> The only approach on s390x to not glue command line properties to the
> >>>> cpu model would be to remove the CPU model feature and replace it by the
> >>>> command line parameter. But that would, of course, be an incompatible break.    
> >>>
> >>> Yuck.
> >>>
> >>> We still need to provide the cpu feature to the *guest* in any case, no?    
> >>
> >> Yeah, but that could be wired up internally. Wouldn't consider it clean,
> >> though (I second the "overengineered" above).  
> > 
> > Could an internally wired-up cpu feature be introspected? Also, what  
> 
> Nope. It would just be e.g., a "machine feature" indicated to the guest
> via the STFL interface/instruction. I was tackling the introspect part
> when asking David how to sense from upper layers. It would have to be
> sense via a different interface as it would not longer be modeled as
> part of CPU features in QEMU.
> 
> > happens if new cpu features are introduced that have a dependency on or
> > a conflict with this one?  
> 
> Conflict: bail out in QEMU when incompatible options are specified.
> Dependency: warn and continue/fixup (e.g., mask off?)

Masking off would likely be surprising to the user.

> Not clean I think.

I agree.

Still unsure how to bring this new machine property and the cpu feature
together. Would be great to have the same interface everywhere, but
having two distinct command line objects depend on each other sucks.
Automatically setting the feature bit if pv is supported complicates
things further.

(Is there any requirement that the machine object has been already set
up before the cpu features are processed? Or the other way around?)

Does this have any implications when probing with the 'none' machine?


