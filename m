Return-Path: <SRS0=H0ck=CE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2960C433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 10:34:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD77520786
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 10:34:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WM+jXmUZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD77520786
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41702 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAsl7-0007xo-Vh
	for qemu-devel@archiver.kernel.org; Wed, 26 Aug 2020 06:34:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39590)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1kAskR-0007Xd-Od
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 06:33:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:52487)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1kAskP-0007gn-F0
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 06:33:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598438020;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IW3gN9+0RDuDLGIydtzmFYpj3H2MYw6BOZ52gAPegQA=;
 b=WM+jXmUZGhs8wKI97BEHs0ttqBR989I6OgWAt0onfYmul3LyrAkyrX3TlNvV4gq4N/4G1U
 9rbEe0wwyEeiWyNqKbtDfurDNR9OLfNqqUYx0tQtx5qnDJsdVrHx9cYxKbBmx/gJbeOmK3
 XRN6/u9x8jz6DoJosdUAlKKPaLl0iZ8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-371-HpO-CzPGOyyfD4M1Zoh9jQ-1; Wed, 26 Aug 2020 06:33:38 -0400
X-MC-Unique: HpO-CzPGOyyfD4M1Zoh9jQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B27041074644;
 Wed, 26 Aug 2020 10:33:36 +0000 (UTC)
Received: from work-vm (ovpn-114-48.ams2.redhat.com [10.36.114.48])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B09471992F;
 Wed, 26 Aug 2020 10:33:33 +0000 (UTC)
Date: Wed, 26 Aug 2020 11:33:30 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: David Edmondson <dme@dme.org>
Subject: Re: [PATCH v5 03/12] migration/dirtyrate: Add RamlockDirtyInfo to
 store sampled page info
Message-ID: <20200826103330.GB2726@work-vm>
References: <1598260480-64862-1-git-send-email-zhengchuan@huawei.com>
 <1598260480-64862-4-git-send-email-zhengchuan@huawei.com>
 <m2lfi1lpqj.fsf@dme.org>
MIME-Version: 1.0
In-Reply-To: <m2lfi1lpqj.fsf@dme.org>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=dgilbert@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/25 23:30:47
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.958,
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
Cc: alex.chen@huawei.com, berrange@redhat.com, zhang.zhanghailiang@huawei.com,
 quintela@redhat.com, qemu-devel@nongnu.org, xiexiangyou@huawei.com,
 Chuan Zheng <zhengchuan@huawei.com>, ann.zhuangyanying@huawei.com,
 fangying1@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* David Edmondson (dme@dme.org) wrote:
> On Monday, 2020-08-24 at 17:14:31 +08, Chuan Zheng wrote:
> 
> > Add RamlockDirtyInfo to store sampled page info of each ramblock.
> >
> > Signed-off-by: Chuan Zheng <zhengchuan@huawei.com>
> > ---
> >  migration/dirtyrate.h | 18 ++++++++++++++++++
> >  1 file changed, 18 insertions(+)
> >
> > diff --git a/migration/dirtyrate.h b/migration/dirtyrate.h
> > index 33669b7..70000da 100644
> > --- a/migration/dirtyrate.h
> > +++ b/migration/dirtyrate.h
> > @@ -19,6 +19,11 @@
> >   */
> >  #define DIRTYRATE_DEFAULT_SAMPLE_PAGES            512
> >  
> > +/*
> > + * Record ramblock idstr
> > + */
> > +#define RAMBLOCK_INFO_MAX_LEN                     256
> > +
> >  /* Take 1s as default for calculation duration */
> >  #define DEFAULT_FETCH_DIRTYRATE_TIME_SEC          1
> >  
> > @@ -27,6 +32,19 @@ struct DirtyRateConfig {
> >      int64_t sample_period_seconds; /* time duration between two sampling */
> >  };
> >  
> > +/*
> > + * Store dirtypage info for each ramblock.
> > + */
> > +struct RamblockDirtyInfo {
> > +    char idstr[RAMBLOCK_INFO_MAX_LEN]; /* idstr for each ramblock */
> > +    uint8_t *ramblock_addr; /* base address of ramblock we measure */
> > +    uint64_t ramblock_pages; /* ramblock size in 4K-page */
> 
> It's probably a stupid question, but why not store a pointer to the
> RAMBlock rather than copying some of the details?

I think I figured that out in the last round;  this code runs as:

    rcu lock {
       calculate initial CRCs
    }

    <sleep 1 second ish>
    rcu lock {
       calculate new CRCs
    }

A RAMBlock might get deleted between the two.

Dave

       
> > +    uint64_t *sample_page_vfn; /* relative offset address for sampled page */
> > +    uint64_t sample_pages_count; /* count of sampled pages */
> > +    uint64_t sample_dirty_count; /* cout of dirty pages we measure */
> 
> "cout" -> "count"
> 
> > +    uint32_t *hash_result; /* array of hash result for sampled pages */
> > +};
> > +
> >  void *get_dirtyrate_thread(void *arg);
> >  #endif
> >  
> > -- 
> > 1.8.3.1
> 
> dme.
> -- 
> Please forgive me if I act a little strange, for I know not what I do.
> 
-- 
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


