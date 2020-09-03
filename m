Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30720C433E2
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 13:43:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA9372072A
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 13:43:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gD6IhY+V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA9372072A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47624 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDpWt-0007jo-3p
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 09:43:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47062)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kDpWH-0006pq-1w
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 09:43:17 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:23010
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kDpWE-0000uv-TI
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 09:43:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599140593;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2JjLeOhnrG+lsFCenhM45DwtDLHZzwBBDNh5TMsj4tY=;
 b=gD6IhY+VbL7IUB5liiMyMThI1XeJ3GrmsWSC0z2ujYVtUJTVBqkZYOnHDGMu2IdijCU3UL
 7LIgJvow1JrJGunL3y1MAjktO/LrID9qoZMJxEMB7+MeUSdkYJGBCAR5OBCiWAND6bIYPw
 XHfkoHBa7o/y1goJ20zZHASyrek4GFw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-240-mw90F5kEODuVHoDawTn2Bw-1; Thu, 03 Sep 2020 09:43:12 -0400
X-MC-Unique: mw90F5kEODuVHoDawTn2Bw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3690B801AEA;
 Thu,  3 Sep 2020 13:43:11 +0000 (UTC)
Received: from linux.fritz.box (ovpn-114-183.ams2.redhat.com [10.36.114.183])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E75B978B38;
 Thu,  3 Sep 2020 13:43:09 +0000 (UTC)
Date: Thu, 3 Sep 2020 15:43:08 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Fabian =?iso-8859-1?Q?Gr=FCnbichler?= <f.gruenbichler@proxmox.com>
Subject: Re: [RFC qemu 0/6] mirror: implement incremental and bitmap modes
Message-ID: <20200903134308.GE8835@linux.fritz.box>
References: <20200218100740.2228521-1-f.gruenbichler@proxmox.com>
 <d35a76de-78d5-af56-0b34-f7bd2bbd3733@redhat.com>
 <1599127031.9uxdp5h9o2.astroid@nora.none>
 <ef545f46-7cbb-43f0-2ab8-f3d49643d1e6@redhat.com>
 <20200903123850.GB8835@linux.fritz.box>
 <ec747431-b2fa-2e67-984b-3cf70e0c79e4@redhat.com>
 <20200903132343.GD8835@linux.fritz.box>
 <1599140071.n44h532eeu.astroid@nora.none>
MIME-Version: 1.0
In-Reply-To: <1599140071.n44h532eeu.astroid@nora.none>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kwolf@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/03 01:28:33
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: qemu-devel@nongnu.org, John Snow <jsnow@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 03.09.2020 um 15:36 hat Fabian Grünbichler geschrieben:
> On September 3, 2020 3:23 pm, Kevin Wolf wrote:
> > Am 03.09.2020 um 14:57 hat Max Reitz geschrieben:
> >> On 03.09.20 14:38, Kevin Wolf wrote:
> >> > Am 03.09.2020 um 13:04 hat Max Reitz geschrieben:
> >> >> On 03.09.20 12:13, Fabian Grünbichler wrote:
> >> >>> On August 21, 2020 3:03 pm, Max Reitz wrote:
> >> >>>> On 18.02.20 11:07, Fabian Grünbichler wrote:
> >> >>> I am not sure how 
> >> >>> the S-O-B by John is supposed to enter the mix - should I just include 
> >> >>> it in the squashed patch (which would be partly authored, but 
> >> >>> not-yet-signed-off by him otherwise?)?
> >> >>
> >> >> I’m not too sure on the proceedings, actually.  I think it should be
> >> >> fine if you put his S-o-b there, as long as your patch is somehow based
> >> >> on a patch that he sent earlier with his S-o-b underneath.  But I’m not
> >> >> sure.
> >> > 
> >> > Signed-off-by means that John certifies the DCO for the patch (at least
> >> > the original version that you possibly modified), so you cannot just add
> >> > it without asking him.
> >> 
> >> But what if you take a patch from someone and heavily modify it –
> >> wouldn’t you keep the original S-o-b and explain the modifications in
> >> the commit message?
> > 
> > Ah, if that patch already had a S-o-b, then yes. You keep it not only to
> > show who touched the patch, but also because your own S-o-b depends on
> > the one from the original author (you only have the rights to contribute
> > it because the original author had them and could pass them on to you).
> > 
> > I thought it was based on a patch that came without S-o-b.
> 
> it is (taken from John's git, with his approval, and implicit admission 
> that S-O-B is just missing because it was a WIP branch/tree that I 
> started from). that was also the reason why I kept that patch unmodified 
> and sent my modifications as patches on-top, to make it easier for John 
> to verify that that one patch is his original WIP one and add this 
> missing S-O-B ;)

Yeah, then John should just reply to the patch and add the S-o-b.

Complications like this are why I always use 'git commit -s' and have it
already in my development branches rather than only adding it when
preparing the patch emails to send.

Kevin


