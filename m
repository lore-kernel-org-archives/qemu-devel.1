Return-Path: <SRS0=wjGh=DT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8948DC433E7
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 16:40:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 070BC20757
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 16:40:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IUY+opBs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 070BC20757
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58252 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kS0sS-0003w8-57
	for qemu-devel@archiver.kernel.org; Mon, 12 Oct 2020 12:40:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44160)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1kS0qJ-0002Iv-Va
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 12:38:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:56906)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1kS0qG-0007Ev-US
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 12:38:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602520711;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JkWmlF6f9z7579S+w2s/Ps8JhylqNQAW33BZXAbJ67g=;
 b=IUY+opBsOdjHBAwHVauS0IIrPnv+59seBge9FHzHz1jjee9MvCgCW4+O5TRbIRilLGrOHq
 NYTSt8+RumGt6t7NqHI4NQOwp32P3Bat11JM7kO9VeRyfpV1S6nGkBTBRYGTXAIziCwX9Z
 9FbdFd1zJ8cq/+5ojjYL+uGBbaw26LI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-18-L0oLXJwINuWx6hivIUAeVg-1; Mon, 12 Oct 2020 12:38:27 -0400
X-MC-Unique: L0oLXJwINuWx6hivIUAeVg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 797F01015CA2;
 Mon, 12 Oct 2020 16:38:26 +0000 (UTC)
Received: from work-vm (ovpn-113-244.ams2.redhat.com [10.36.113.244])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A2E425578B;
 Mon, 12 Oct 2020 16:38:24 +0000 (UTC)
Date: Mon, 12 Oct 2020 17:38:21 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: James Bottomley <jejb@linux.ibm.com>, pbonzini@redhat.com
Subject: Re: [PATCH v3] SEV: QMP support for Inject-Launch-Secret
Message-ID: <20201012163821.GJ6677@work-vm>
References: <20200706215451.59179-1-tobin@linux.vnet.ibm.com>
 <20200921190800.GA32491@work-vm>
 <b7faab72e909b709797e6098ec894c72@linux.vnet.ibm.com>
 <20201012155718.GH6677@work-vm>
 <b6137b4997b0729e576bc6c0c5476960d1992115.camel@linux.ibm.com>
MIME-Version: 1.0
In-Reply-To: <b6137b4997b0729e576bc6c0c5476960d1992115.camel@linux.ibm.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=dgilbert@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/12 02:58:41
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: thomas.lendacky@amd.com, brijesh.singh@amd.com, tobin@ibm.com,
 qemu-devel@nongnu.org, Tobin Feldman-Fitzthum <tobin@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* James Bottomley (jejb@linux.ibm.com) wrote:
> On Mon, 2020-10-12 at 16:57 +0100, Dr. David Alan Gilbert wrote:
> > * Tobin Feldman-Fitzthum (tobin@linux.ibm.com) wrote:
> > > On 2020-09-21 15:16, Dr. David Alan Gilbert wrote:
> > > > * Tobin Feldman-Fitzthum (tobin@linux.vnet.ibm.com) wrote:
> > > > > AMD SEV allows a guest owner to inject a secret blob
> > > > > into the memory of a virtual machine. The secret is
> > > > > encrypted with the SEV Transport Encryption Key and
> > > > > integrity is guaranteed with the Transport Integrity
> > > > > Key. Although QEMU faciliates the injection of the
> > > > > launch secret, it cannot access the secret.
> > > > > 
> > > > > Signed-off-by: Tobin Feldman-Fitzthum <tobin@linux.vnet.ibm.com
> > > > > >
> > > > 
> > > > Hi Tobin,
> > > >   Did the ovmf stuff for agreeing the GUID for automating this
> > > > ever happen?
> > > > 
> > > OVMF patches have not been upstreamed yet. I think we are planning
> > > to do that relatively soon.
> > 
> > So as we're getting to the end of another qemu dev cycle; do we aim
> > to get this one in by itself, or to wait for the GUID?
> 
> Since they're independent of each other, I'd say get this one in now if
> it's acceptable.  The GUID will come as a discoverable way of setting
> the GPA, but this patch at least gives people a way to play with SEV
> secret injection.  I'm also reworking the OVMF GUID patch to tack on to
> the reset vector GUID that just went upstream, so it will be a few more
> weeks yet before we have it all integrated with the -ES patch set.

OK, so I've just replied with a minor error leak that needs fixing, but
other than that it looks OK to me.
I've not quite figured out who would pull it, Paolo?

Dave

> James
> 
> 
-- 
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


