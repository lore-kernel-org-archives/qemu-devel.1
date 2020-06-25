Return-Path: <SRS0=KdPs=AG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BD93C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 09:51:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 46F2D206C3
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 09:51:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dXQBXB2s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46F2D206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41088 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joOXh-0006fs-Jb
	for qemu-devel@archiver.kernel.org; Thu, 25 Jun 2020 05:51:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55314)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1joOWp-0005uN-VO
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 05:50:43 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:37451
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1joOWo-0007OS-F9
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 05:50:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593078641;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KedBPS+NpC8etXkXNTeGxZ25U7K2d6TeusgIBHRfbZM=;
 b=dXQBXB2sgSYGpQFNGXTRBXSukh0NAZfNVT3H7E1r5NAgsiQ8DFctgCQxos4fe8cjHpH6BE
 zBi4RuCiznyxyj8TwSb6YoeQflDRkFbKkFEXr6zNjHxmSYB5CdQIGhEvyhjS4QmnT1G0Wm
 asSIdgUGZlFoWm2wAYzQEKLRrYWjYcg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-245-wGy3wj-TNfWzFH6L1zzIXQ-1; Thu, 25 Jun 2020 05:50:37 -0400
X-MC-Unique: wGy3wj-TNfWzFH6L1zzIXQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F2990100960F;
 Thu, 25 Jun 2020 09:50:35 +0000 (UTC)
Received: from gondolin (ovpn-112-36.ams2.redhat.com [10.36.112.36])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7B3DF619C0;
 Thu, 25 Jun 2020 09:50:26 +0000 (UTC)
Date: Thu, 25 Jun 2020 11:49:58 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v3 0/9] Generalize memory encryption models
Message-ID: <20200625114958.6d1981fe.cohuck@redhat.com>
In-Reply-To: <778050eb-c6b2-e471-1945-598520fdc894@redhat.com>
References: <20200619020602.118306-1-david@gibson.dropbear.id.au>
 <e045e202-cd56-4ddc-8c1d-a2fe5a799d32@redhat.com>
 <20200619094820.GJ17085@umbus.fritz.box>
 <a1f47bc3-40d6-f46e-42e7-9c44597c3c90@redhat.com>
 <20200625054201.GE172395@umbus.fritz.box>
 <778050eb-c6b2-e471-1945-598520fdc894@redhat.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Received-SPF: pass client-ip=207.211.31.81; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/25 02:30:11
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

On Thu, 25 Jun 2020 08:59:00 +0200
David Hildenbrand <david@redhat.com> wrote:

> >>>> How do upper layers actually figure out if memory encryption etc is
> >>>> available? on s390x, it's simply via the expanded host CPU model.  
> >>>
> >>> Haven't really tackled that yet.  But one way that works for multiple
> >>> systems has got to be better than a separate one for each, right?  
> >>
> >> I think that's an important piece. Especially once multiple different
> >> approaches are theoretically available one wants to sense from upper layers.  
> > 
> > Fair point.
> > 
> > So... IIRC there's a general way of looking at available properties
> > for any object, including the machine.  So we can probe for
> > availability of the "host-trust-limitation" property itself easily
> > enough.  
> 
> You can have a look at how it's currently probed by libvirt in
> 
> https://www.redhat.com/archives/libvir-list/2020-June/msg00518.html
> 
> For now, the s390x check consists of
> - checking if /sys/firmware/uv is available
> - checking if the kernel cmdline contains 'prot_virt=1'
> 
> The sev check is
> - checking if /sys/module/kvm_amd/parameters/sev contains the
>    value '1'
> - checking if /dev/sev
> 
> So at least libvirt does not sense via the CPU model on s390x yet.

It checks for 158 (which is apparently 'host supports secure
execution'). IIUC, only 161 ('unpack facility') is relevant for the
guest... does that also show up on the host? (I guess it does, as it
describes an ultravisor feature, IIUC.) If it is always implied,
libvirt probably does not need an extra check.


