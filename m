Return-Path: <SRS0=Uy1J=BP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85F85C433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2020 08:26:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 53A2720792
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2020 08:26:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AMqTePED"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53A2720792
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43124 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3El1-0006Si-KB
	for qemu-devel@archiver.kernel.org; Wed, 05 Aug 2020 04:26:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46028)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1k3EkE-0005Zf-Ll
 for qemu-devel@nongnu.org; Wed, 05 Aug 2020 04:25:54 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:38038
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1k3EkD-00063f-24
 for qemu-devel@nongnu.org; Wed, 05 Aug 2020 04:25:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596615952;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5QGEqCpi5QQT6OfiaWJJsqFQAznUF5cLCWJdGfF1hAU=;
 b=AMqTePEDC4bkINUip47jRgZcsQYT/Mlqc/Pxsii9/Ai5VB0eb3s3NjDDJeovBOIBGRw/7Y
 +yznUKflOAmiOeOknTA59BI4mjiKWiey8deJt22WTXJ7OH4x8geJoANFsrde92oTyn2iT9
 IQ6qCj6M4nkyiP+jUd9Po4eLFNma1Sw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-214-W78PFr5RNdiIffgqbtaw9A-1; Wed, 05 Aug 2020 04:25:50 -0400
X-MC-Unique: W78PFr5RNdiIffgqbtaw9A-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6295018C63C5;
 Wed,  5 Aug 2020 08:25:49 +0000 (UTC)
Received: from linux.fritz.box (ovpn-113-121.ams2.redhat.com [10.36.113.121])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3DC308AC23;
 Wed,  5 Aug 2020 08:25:48 +0000 (UTC)
Date: Wed, 5 Aug 2020 10:25:46 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH v6 02/12] monitor: Use getter/setter functions for cur_mon
Message-ID: <20200805082546.GA4679@linux.fritz.box>
References: <20200528153742.274164-1-kwolf@redhat.com>
 <20200528153742.274164-3-kwolf@redhat.com>
 <87lfiubmu3.fsf@dusky.pond.sub.org>
 <20200804161634.GC4860@linux.fritz.box>
 <87wo2d5zky.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
In-Reply-To: <87wo2d5zky.fsf@dusky.pond.sub.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=kwolf@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/05 00:45:55
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: marcandre.lureau@gmail.com, qemu-devel@nongnu.org, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 05.08.2020 um 09:19 hat Markus Armbruster geschrieben:
> Kevin Wolf <kwolf@redhat.com> writes:
> 
> > Am 04.08.2020 um 14:46 hat Markus Armbruster geschrieben:
> >> > diff --git a/monitor/hmp.c b/monitor/hmp.c
> >> > index d598dd02bb..f609fcf75b 100644
> >> > --- a/monitor/hmp.c
> >> > +++ b/monitor/hmp.c
> >> > @@ -1301,11 +1301,11 @@ cleanup:
> >> >  static void monitor_read(void *opaque, const uint8_t *buf, int size)
> >> >  {
> >> >      MonitorHMP *mon;
> >> > -    Monitor *old_mon = cur_mon;
> >> > +    Monitor *old_mon = monitor_cur();
> >> >      int i;
> >> >  
> >> > -    cur_mon = opaque;
> >> > -    mon = container_of(cur_mon, MonitorHMP, common);
> >> > +    monitor_set_cur(opaque);
> >> > +    mon = container_of(monitor_cur(), MonitorHMP, common);
> >> 
> >> Simpler:
> >> 
> >>        MonitorHMP *mon = container_of(opaque, MonitorHMP, common);
> >
> > opaque is void*, so it doesn't have a field 'common'.
> 
> I actually compile-tested before I sent this.  For once ;)
> 
> Here's container_of():
> 
>     #define container_of(ptr, type, member) ({                      \
>             const typeof(((type *) 0)->member) *__mptr = (ptr);     \
>             (type *) ((char *) __mptr - offsetof(type, member));})
> 
> Its first argument's only use is as an initializer for a pointer
> variable.  Both type * and void * work fine there.

Ah, we just lose type checking.

That's what I get for replying from what I remember from over two months
ago. I was pretty sure I didn't like this way, but went with it because
the other way didn't work. Maybe I just assumed it didn't work, or tried
something different that actually fails. Who knows.

Kevin


