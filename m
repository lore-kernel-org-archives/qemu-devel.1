Return-Path: <SRS0=Dndf=B6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1859EC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 17:56:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D90B720885
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 17:56:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bn/iJRje"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D90B720885
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40642 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8onF-0007km-7Y
	for qemu-devel@archiver.kernel.org; Thu, 20 Aug 2020 13:56:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50852)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1k8omb-0006ww-9v
 for qemu-devel@nongnu.org; Thu, 20 Aug 2020 13:55:25 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:39300
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1k8omZ-0005P6-J3
 for qemu-devel@nongnu.org; Thu, 20 Aug 2020 13:55:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597946122;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4TnQ3qRI7tkOc0ejey74a+HLtupTjCcp2vmdvHY2iuI=;
 b=bn/iJRjenjRZG9CfBPL/C39MOHvVkCYxy2C47d5Jbdm7D1O6slIBxpLo/qgXg/v8i5MVQD
 7J0HJqI8d491iohY+cheweqWBG4cf2sFyio0vm0oX48sxB88qqP7CrtN7xS0/tbuv8GoG0
 O7njzYFIQaQ3owh1PypQSn83d0JZTLE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-174-bHwI1aA0ORasyrIOly2WDQ-1; Thu, 20 Aug 2020 13:55:18 -0400
X-MC-Unique: bHwI1aA0ORasyrIOly2WDQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 50BED425E3;
 Thu, 20 Aug 2020 17:55:17 +0000 (UTC)
Received: from work-vm (ovpn-114-2.ams2.redhat.com [10.36.114.2])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 29288614F5;
 Thu, 20 Aug 2020 17:55:15 +0000 (UTC)
Date: Thu, 20 Aug 2020 18:55:12 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Subject: Re: [PATCH v3 05/10] migration/dirtyrate: Record hash results for
 each sampled page
Message-ID: <20200820175512.GQ2664@work-vm>
References: <1597634433-18809-1-git-send-email-zhengchuan@huawei.com>
 <1597634433-18809-6-git-send-email-zhengchuan@huawei.com>
 <20200820173009.GM2664@work-vm>
 <20200820175149.GA244434@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200820175149.GA244434@redhat.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=dgilbert@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/20 03:03:34
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: alex.chen@huawei.com, zhang.zhanghailiang@huawei.com, quintela@redhat.com,
 linyilu@huawei.com, qemu-devel@nongnu.org, Chuan Zheng <zhengchuan@huawei.com>,
 ann.zhuangyanying@huawei.com, fangying1@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Daniel P. Berrangé (berrange@redhat.com) wrote:
> On Thu, Aug 20, 2020 at 06:30:09PM +0100, Dr. David Alan Gilbert wrote:
> > * Chuan Zheng (zhengchuan@huawei.com) wrote:
> > > Record hash results for each sampled page.
> > > 
> > > Signed-off-by: Chuan Zheng <zhengchuan@huawei.com>
> > > Signed-off-by: YanYing Zhuang <ann.zhuangyanying@huawei.com>
> > > ---
> > >  migration/dirtyrate.c | 144 ++++++++++++++++++++++++++++++++++++++++++++++++++
> > >  migration/dirtyrate.h |   7 +++
> > >  2 files changed, 151 insertions(+)
> > > 
> > > diff --git a/migration/dirtyrate.c b/migration/dirtyrate.c
> > > index c4304ef..62b6f69 100644
> > > --- a/migration/dirtyrate.c
> > > +++ b/migration/dirtyrate.c
> > > @@ -25,6 +25,7 @@
> > >  #include "dirtyrate.h"
> > >  
> > >  CalculatingDirtyRateState CalculatingState = CAL_DIRTY_RATE_INIT;
> > > +static unsigned long int qcrypto_hash_len = QCRYPTO_HASH_LEN;
> > 
> > Why do we need this static rather than just using the QCRYPTO_HASH_LEN ?
> > It's never going to change is it?
> > (and anyway it's just a MD5 len?)
> 
> I wouldn't want to bet on that given that this is use of MD5. We might
> claim this isn't security critical, but surprises happen, and we will
> certainly be dinged on security audits for introducing new use of MD5
> no matter what.
> 
> If a cryptographic hash is required, then sha256 should be the choice
> for any new code that doesn't have back compat requirements.
> 
> If a cryptographic hash is not required then how about crc32 

It doesn't need to be cryptographic; is crc32 the fastest reasonable hash for use
in large areas?

Dave

> IOW, it doesn't make a whole lot of sense to say we need a cryptographic
> hash, but then pick the most insecure one.
> 
> sha256 is slower than md5, but it is conceivable that in future we might
> gain support for something like Blake2b which is similar security level
> to SHA3, while being faster than MD5.
> 
> Overall I'm pretty unethusiastic about use of MD5 being introduced and
> worse, being hardcoded as the only option.
> 
> Regards,
> Daniel
> -- 
> |: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
> |: https://libvirt.org         -o-            https://fstop138.berrange.com :|
> |: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
-- 
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


