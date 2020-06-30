Return-Path: <SRS0=gXk/=AL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 133D9C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 09:26:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D39C4204EC
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 09:26:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BAP2QvP6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D39C4204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54916 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqCXX-0007uW-51
	for qemu-devel@archiver.kernel.org; Tue, 30 Jun 2020 05:26:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45260)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlevitsk@redhat.com>)
 id 1jqCUA-00026B-Mx
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 05:23:26 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:42408
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mlevitsk@redhat.com>)
 id 1jqCU9-00060Z-6e
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 05:23:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593509004;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aDZcvfzw0hK8Fkeyg0vfnXChDUvqewVyO6l1EnEhsj0=;
 b=BAP2QvP6MTApfCfxpKBk1vdzMweBdp+6pF0Z1o7UBi3UzD5C6atV60+xE0H+9EvGCl3OaO
 r2kXzpGhXECfxJP6Hs76ypJdeqJbLMktbcxRiCliBCjhuiLR3ztRYdw9iCqprNif4GK6jo
 Fz/YFl1DgIOHslqVGM9+vJKFuzIpm44=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-314-lSnZVvTxPFS62lKC8Zzq_g-1; Tue, 30 Jun 2020 05:23:20 -0400
X-MC-Unique: lSnZVvTxPFS62lKC8Zzq_g-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 90831193F560;
 Tue, 30 Jun 2020 09:23:19 +0000 (UTC)
Received: from starship (unknown [10.35.207.5])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4AF2D5C1B0;
 Tue, 30 Jun 2020 09:23:18 +0000 (UTC)
Message-ID: <24b6fea6778fb92925bdb1da703e8563ae24353b.camel@redhat.com>
Subject: Re: [PATCH 15/19] iotests: qemu-img tests for luks key management
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Date: Tue, 30 Jun 2020 12:23:16 +0300
In-Reply-To: <0c8a96b3-9204-b138-d141-aaa9e0d02ac0@redhat.com>
References: <20200625125548.870061-1-mreitz@redhat.com>
 <20200625125548.870061-16-mreitz@redhat.com>
 <10a4f572b6276a99fdc925b11ff6aa137e0ea50a.camel@redhat.com>
 <0c8a96b3-9204-b138-d141-aaa9e0d02ac0@redhat.com>
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mlevitsk@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=mlevitsk@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/30 01:11:03
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 2020-06-30 at 10:56 +0200, Max Reitz wrote:
> On 29.06.20 14:05, Maxim Levitsky wrote:
> > On Thu, 2020-06-25 at 14:55 +0200, Max Reitz wrote:
> > > From: Maxim Levitsky <mlevitsk@redhat.com>
> > > 
> > > This commit adds two tests, which test the new amend interface
> > > of both luks raw images and qcow2 luks encrypted images.
> > > 
> > > Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> > > Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
> > > [mreitz: Let 293 verify that LUKS works; drop $(seq) usage from 293;
> > >          drop 293 and 294 from the auto group]
> > > Signed-off-by: Max Reitz <mreitz@redhat.com>
> > > ---
> > >  tests/qemu-iotests/293     | 208 +++++++++++++++++++++++++++++++++++++
> > >  tests/qemu-iotests/293.out |  99 ++++++++++++++++++
> > >  tests/qemu-iotests/294     |  90 ++++++++++++++++
> > >  tests/qemu-iotests/294.out |  30 ++++++
> > >  tests/qemu-iotests/group   |   2 +
> > >  5 files changed, 429 insertions(+)
> > >  create mode 100755 tests/qemu-iotests/293
> > >  create mode 100644 tests/qemu-iotests/293.out
> > >  create mode 100755 tests/qemu-iotests/294
> > >  create mode 100644 tests/qemu-iotests/294.out
> 
> [...]
> 
> > > diff --git a/tests/qemu-iotests/group b/tests/qemu-iotests/group
> > > index d886fa0cb3..b945dd4f20 100644
> > > --- a/tests/qemu-iotests/group
> > > +++ b/tests/qemu-iotests/group
> > > @@ -301,4 +301,6 @@
> > >  290 rw auto quick
> > >  291 rw quick
> > >  292 rw auto quick
> > > +293 rw
> > > +294 rw quick
> > >  297 meta
> > 
> > I guess now we can add these to 'auto' group?
> 
> Have you run them on all platforms?  I haven’t.
Me neither.
> 
> (I have run the openbsd build, but I’m not even sure I had these tests
> in auto at that point.  And that build takes a really long time.)
> 
> All in all, I don’t think I ever want to add a test to auto again,
> unless it’s done in a specific patch where the author guarantees they
> tested it everywhere.
If we look at this at this angle, it makes sense.
I fully agreee.

Best regards,
	Maxim Levitsky

> 
> Max
> 



