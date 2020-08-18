Return-Path: <SRS0=kYy5=B4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFFFCC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2020 06:25:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D02720825
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2020 06:25:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TBT2SE+N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D02720825
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38172 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7v47-0001Id-PO
	for qemu-devel@archiver.kernel.org; Tue, 18 Aug 2020 02:25:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45778)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1k7v3b-0000mu-4B
 for qemu-devel@nongnu.org; Tue, 18 Aug 2020 02:25:15 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:31016
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1k7v3Z-0004RX-EZ
 for qemu-devel@nongnu.org; Tue, 18 Aug 2020 02:25:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597731912;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/eJHnS7lGkZRNdC672zcBxD0G6w2MNLVzRaRLOSFWfM=;
 b=TBT2SE+NE+1/JClGk4iyBBikTjwBrDb6OgZ0C27P+x+dMJIi8TQR3c3vcPAU2VrcQTFS5c
 BdcoRWzUJ1W73+8QU19bvd4pWWpMX6Def6uKV1Wh4L94eNy08cowJUF2YmMp+tEwNtqw2U
 XHUkV0mEYCsAHUAb51MeRDrWGgBc3A4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-409-CABUfqDaOfOsuWHdybF72g-1; Tue, 18 Aug 2020 02:25:10 -0400
X-MC-Unique: CABUfqDaOfOsuWHdybF72g-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A9D251005E65
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2020 06:25:09 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-112-195.ams2.redhat.com
 [10.36.112.195])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4CEC326164;
 Tue, 18 Aug 2020 06:25:03 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 0BFBA9D59; Tue, 18 Aug 2020 08:25:02 +0200 (CEST)
Date: Tue, 18 Aug 2020 08:25:02 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Subject: Re: [PATCH 1/4] edid: use physical dimensions if available
Message-ID: <20200818062502.k6iliffbuo6mod5g@sirius.home.kraxel.org>
References: <20200817120056.56751-1-marcandre.lureau@redhat.com>
 <20200817120056.56751-2-marcandre.lureau@redhat.com>
 <20200817122135.cmi2lfhoggsfpx3d@sirius.home.kraxel.org>
 <CAMxuvawcpPEE0e4gEpe1ihFtibuJf0-wFAWuWtuURPAjwOVqXg@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAMxuvawcpPEE0e4gEpe1ihFtibuJf0-wFAWuWtuURPAjwOVqXg@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kraxel@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: none client-ip=207.211.31.120; envelope-from=kraxel@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/18 02:25:12
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Cc: qemu-devel <qemu-devel@nongnu.org>, "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Aug 17, 2020 at 04:57:55PM +0400, Marc-André Lureau wrote:
> Hi
> 
> On Mon, Aug 17, 2020 at 4:21 PM Gerd Hoffmann <kraxel@redhat.com> wrote:
> >
> > On Mon, Aug 17, 2020 at 04:00:53PM +0400, marcandre.lureau@redhat.com wrote:
> > > From: Marc-André Lureau <marcandre.lureau@redhat.com>
> > >
> > > Add width_mm/height_mm to qemu_edid_info, and use it if it is
> > > set (non-zero) to generate the EDID.
> >
> > Any specific reason why you switch from dpi to xmm/ymm?
> 
> Not really, but there is no DPI information from Gtk. I also find it
> difficult to reason with DPI, dimensions are simpler to check about
> correctness imho (I take the ruler from my desk for example ;). And
> also DPI is a space density, without horizontal and vertical
> distinction.

Typically computer displays have square pixels, so that shouldn't be a
problem.  For manually configuration it is easier if you have to deal
with one value only not two.

> So by giving width/height in mm we actually have something more
> correct and easier to debug imho. No?

I dislike having both with/height and dpi in struct qemu_edid_info.

Suggestion:  Drop dpi struct member (should be easy, I think it isn't
wired anywhere yet).  Add two little qemu_edid_* helpers to convert
from/to dpi.  If only one of xmm/ymm is given go calculate the other
automatically (assuming square pixels).  If none is given use 100 dpi
(like the current code does).

take care,
  Gerd


