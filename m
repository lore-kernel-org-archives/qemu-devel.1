Return-Path: <SRS0=Z/nf=BQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 252E0C433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 12:24:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E9ABA204FD
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 12:24:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Um4jMr5K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9ABA204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57658 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3bq9-0000LL-E7
	for qemu-devel@archiver.kernel.org; Thu, 06 Aug 2020 05:05:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45950)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1k3bp6-0007r0-3C
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 05:04:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:28728)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1k3bp4-0003ld-68
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 05:04:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596704665;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=yCjsoJwOo8RNzGv0M8JgFauuFmm9lIRV4uSxpiob0eM=;
 b=Um4jMr5KxYW8OZ3fwqHH+qo8DfG3qZOLGY7giSutMoxtTsFws0rSsjXOlA4N13dldth7g/
 t0QIEXxbJofbAXKlGYXcc+AID9PPLXFobxSwDt3emz/X5r9Jmk5f1ETEuxTx/rCiMueMRp
 +ArfVHclnG/RpsYmC+3Nq5XrkOHn+6g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-296-OII95FHPM6qyCEo_PwZluA-1; Thu, 06 Aug 2020 05:04:19 -0400
X-MC-Unique: OII95FHPM6qyCEo_PwZluA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6BDA8101C8AC;
 Thu,  6 Aug 2020 09:04:18 +0000 (UTC)
Received: from redhat.com (unknown [10.36.110.44])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C1AC97C0F6;
 Thu,  6 Aug 2020 09:04:15 +0000 (UTC)
Date: Thu, 6 Aug 2020 10:04:12 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Ying Fang <fangying1@huawei.com>
Subject: Re: [PATCH] qcow2: flush qcow2 l2 meta for new allocated clusters
Message-ID: <20200806090412.GC4159383@redhat.com>
References: <159659539087.12210.2061753185498913487@66eaa9a8a123>
 <6239531a-08d8-e538-30ac-ee58fef77aec@huawei.com>
MIME-Version: 1.0
In-Reply-To: <6239531a-08d8-e538-30ac-ee58fef77aec@huawei.com>
User-Agent: Mutt/1.14.5 (2020-06-23)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/06 04:39:39
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=unavailable autolearn_force=no
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: kwolf@redhat.com, zhang.zhanghailiang@huawei.com, qemu-block@nongnu.org,
 qemu-devel@nongnu.org, mreitz@redhat.com, alex.chen@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Aug 06, 2020 at 05:01:51PM +0800, Ying Fang wrote:
> 
> 
> On 8/5/2020 10:43 AM, no-reply@patchew.org wrote:
> > Patchew URL: https://patchew.org/QEMU/20200805023826.184-1-fangying1@huawei.com/
> > 
> > 
> > 
> > Hi,
> > 
> > This series failed the docker-quick@centos7 build test. Please find the testing commands and
> > their output below. If you have Docker installed, you can probably reproduce it
> > locally.
> > I see some error message which says ** No space left on device **
> However I do not know what is wrong with this build test.
> Could you give me some help here?

It isn't your fault - this is just QEMU's  patchew CI that is broken yet again
due to lack of disk space. Just ignore the error report here.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


