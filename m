Return-Path: <SRS0=Yszf=AA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BED79C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 09:46:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8AEC62070A
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 09:46:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GzICyCvm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8AEC62070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33418 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jmDbd-0005Zr-Ms
	for qemu-devel@archiver.kernel.org; Fri, 19 Jun 2020 05:46:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44280)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1jmDao-0004VG-Gt
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 05:45:50 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:22642
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1jmDam-00085J-D2
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 05:45:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592559947;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=girqsAB7scwypOzLVrMu9QZwQRjdhR1EvBT/sBZ/kQQ=;
 b=GzICyCvmxlddQNfrNB7olo2SmYKrito8o5AD3qeQkP6wK3/9GSuFkD50Be6kbBUH8t3eir
 ph01l+cKgKjFjhZDNR5MCWoY12StnCrS3eRRjTFmDOzi7P2XHjrmfDcYFhCidvSWDdZACi
 391XVXXI+rIDmTe7729TpLEqr9zh72k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-448-31x90bOgOwuXqNM715sfcg-1; Fri, 19 Jun 2020 05:45:44 -0400
X-MC-Unique: 31x90bOgOwuXqNM715sfcg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1A1588015CB;
 Fri, 19 Jun 2020 09:45:42 +0000 (UTC)
Received: from gondolin (ovpn-112-224.ams2.redhat.com [10.36.112.224])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2D6BD7C1E8;
 Fri, 19 Jun 2020 09:45:29 +0000 (UTC)
Date: Fri, 19 Jun 2020 11:45:26 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v3 0/9] Generalize memory encryption models
Message-ID: <20200619114526.6a6f70c6.cohuck@redhat.com>
In-Reply-To: <e045e202-cd56-4ddc-8c1d-a2fe5a799d32@redhat.com>
References: <20200619020602.118306-1-david@gibson.dropbear.id.au>
 <e045e202-cd56-4ddc-8c1d-a2fe5a799d32@redhat.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Received-SPF: pass client-ip=205.139.110.120; envelope-from=cohuck@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/19 05:19:18
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

On Fri, 19 Jun 2020 10:28:22 +0200
David Hildenbrand <david@redhat.com> wrote:

> On 19.06.20 04:05, David Gibson wrote:
> > A number of hardware platforms are implementing mechanisms whereby the
> > hypervisor does not have unfettered access to guest memory, in order
> > to mitigate the security impact of a compromised hypervisor.
> > 
> > AMD's SEV implements this with in-cpu memory encryption, and Intel has
> > its own memory encryption mechanism.  POWER has an upcoming mechanism
> > to accomplish this in a different way, using a new memory protection
> > level plus a small trusted ultravisor.  s390 also has a protected
> > execution environment.  
> 
> Each architecture finds its own way to vandalize the original
> architecture, some in more extreme/obscure ways than others. I guess in
> the long term we'll regret most of that, but what do I know :)
> 
> > 
> > The current code (committed or draft) for these features has each
> > platform's version configured entirely differently.  That doesn't seem
> > ideal for users, or particularly for management layers.
> > 
> > AMD SEV introduces a notionally generic machine option
> > "machine-encryption", but it doesn't actually cover any cases other
> > than SEV.
> > 
> > This series is a proposal to at least partially unify configuration
> > for these mechanisms, by renaming and generalizing AMD's
> > "memory-encryption" property.  It is replaced by a
> > "host-trust-limitation" property pointing to a platform specific
> > object which configures and manages the specific details.
> >   
> 
> I consider the property name sub-optimal. Yes, I am aware that there are
> other approaches being discussed on the KVM list to disallow access to
> guest memory without memory encryption. (most of them sound like people
> are trying to convert KVM into XEN, but again, what do I know ... :)  )
> 
> "host-trust-limitation"  sounds like "I am the hypervisor, I configure
> limited trust into myself". Also, "untrusted-host" would be a little bit
> nicer (I think trust is a black/white thing).
> 
> However, once we have multiple options to protect a guest (memory
> encryption, unmapping guest pages ,...) the name will no longer really
> suffice to configure QEMU, no?

Hm... we could have a property that accepts bits indicating where the
actual limitation lies. Different parts of the code could then make
more fine-grained decisions of what needs to be done. Feels a bit
overengineered today; but maybe there's already stuff with different
semantics in the pipeline somewhere?

> 
> > For now this series covers just AMD SEV and POWER PEF.  I'm hoping it
> > can be extended to cover the Intel and s390 mechanisms as well,
> > though.  
> 
> The only approach on s390x to not glue command line properties to the
> cpu model would be to remove the CPU model feature and replace it by the
> command line parameter. But that would, of course, be an incompatible break.

Yuck.

We still need to provide the cpu feature to the *guest* in any case, no?

> 
> How do upper layers actually figure out if memory encryption etc is
> available? on s390x, it's simply via the expanded host CPU model.
> 


