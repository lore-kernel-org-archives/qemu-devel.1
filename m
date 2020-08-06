Return-Path: <SRS0=Z/nf=BQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D807C433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 17:47:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C33A0206B2
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 17:47:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PDlpGj2w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C33A0206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46158 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3jzc-00032Y-GJ
	for qemu-devel@archiver.kernel.org; Thu, 06 Aug 2020 13:47:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51128)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vgoyal@redhat.com>) id 1k3jxz-0001ho-Vh
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 13:46:11 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:37825
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <vgoyal@redhat.com>) id 1k3jxy-00049a-8G
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 13:46:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596735969;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yjI2fhOAj5B0UV4H9mE4/DjLd8w5W/J4l0+VxV9AArA=;
 b=PDlpGj2wrNuepXtN+DkUEgN9P98VKlBgi+LP++KSXXyJwIG4MhgejQrftDuvU5zPrRtpsM
 ncNPt/dHyniS5BYKnauqIZi0oNetxVMXJXxb4C/I1dL3ogAzJl4WL9WJZGnzMmvJiclU5i
 WC3GwEVVli2E5uAMSYEXgqXxKN0V9Bk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-120-q1cMNtHKNpi-tRAG-1xlMA-1; Thu, 06 Aug 2020 13:46:05 -0400
X-MC-Unique: q1cMNtHKNpi-tRAG-1xlMA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3173B10059AB;
 Thu,  6 Aug 2020 17:46:04 +0000 (UTC)
Received: from horse.redhat.com (ovpn-112-23.rdu2.redhat.com [10.10.112.23])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 11BCF1002391;
 Thu,  6 Aug 2020 17:46:04 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
 id 8CB14220441; Thu,  6 Aug 2020 13:46:03 -0400 (EDT)
Date: Thu, 6 Aug 2020 13:46:03 -0400
From: Vivek Goyal <vgoyal@redhat.com>
To: "misono.tomohiro@fujitsu.com" <misono.tomohiro@fujitsu.com>
Subject: Re: [Virtio-fs] [PATCH] virtiofsd: Disable remote posix locks by
 default
Message-ID: <20200806174603.GF367847@redhat.com>
References: <20200727161841.GA54539@redhat.com>
 <OSBPR01MB4582AB9CD2DB32A48A8BB13FE5480@OSBPR01MB4582.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <OSBPR01MB4582AB9CD2DB32A48A8BB13FE5480@OSBPR01MB4582.jpnprd01.prod.outlook.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=vgoyal@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=vgoyal@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/06 00:07:42
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: virtio-fs-list <virtio-fs@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Aug 06, 2020 at 08:20:39AM +0000, misono.tomohiro@fujitsu.com wrote:
> > Right now we enable remote posix locks by default. That means when guest does a posix lock it sends request to server
> > (virtiofsd). But currently we only support non-blocking posix lock and return -EOPNOTSUPP for blocking version.
> > 
> > This means that existing applications which are doing blocking posix locks get -EOPNOTSUPP and fail. To avoid this,
> > people have been running virtiosd with option "-o no_posix_lock". For new users it is still a surprise and trial and error
> > takes them to this option.
> > 
> > Given posix lock implementation is not complete in virtiofsd, disable it by default. This means that posix locks will work
> > with-in applications in a guest but not across guests. Anyway we don't support sharing filesystem among different guests
> > yet in virtiofs so this should not lead to any kind of surprise or regression and will make life little easier for virtiofs users.
> > 
> > Reported-by: Aa Aa <jimbothom@yandex.com>
> > Suggested-by: Miklos Szeredi <mszeredi@redhat.com>
> > Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
> > ---
> >  tools/virtiofsd/passthrough_ll.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> We should update docs/tools/virtiofsd.rst as well. Given that:
>  Reviewed-by: Misono Tomohiro <misono.tomohiro@jp.fujitsu.com>

Good point Misono. I will update doc to reflect that now default
is "no_posix_lock". Will send V2 and retain all the Reviewed-by tags.

Thanks
Vivek


