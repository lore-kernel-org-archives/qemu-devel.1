Return-Path: <SRS0=1sPN=D3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E30F2C4363A
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 15:51:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E9DB222244
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 15:51:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="AjeSJPCb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9DB222244
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45988 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUtud-0008Cp-Oh
	for qemu-devel@archiver.kernel.org; Tue, 20 Oct 2020 11:50:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35490)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1kUtu4-0007lm-4G
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 11:50:24 -0400
Received: from lizzy.crudebyte.com ([91.194.90.13]:59619)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1kUtu2-0002nq-1D
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 11:50:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=lizzy; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Content-ID:Content-Description;
 bh=I1gvsVDq1HL/dJm+ElMXKR9OwzD59ztA1FG+8RAlpP4=; b=AjeSJPCb/A/gnzT9dbFp7n5Vum
 7rd+R/yomy+ni44u03gQs1K6WZEMHNHx+sL0hWyg2QNFrTUsgXsPWFFTsVEBQg3QXslkbS0yanpfj
 LmjTkx83Hr7go1N+XeNKaA1mXVxm6TWOyjPxj5phP3wfpiNvnjDPuiLjsvyu67LFiSberfymXMl1V
 GJ/LFFixDZ9XLlQt6H6XIN8qTWhtutpGyDdXHeibQZXJY8fR0rc1yNKaYUqFrnrb3rlnATlJGlAS9
 F3UakE41kWIMwEBaInZAoDqw1msQXN/UP65GdpXvSE8nxkOk9ohnNqFOSHUHHqPODTWU+fFlD1oi6
 JPfsrBpg==;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
To: qemu-devel@nongnu.org
Cc: Greg Kurz <groug@kaod.org>
Subject: Re: [PATCH 1/5] tests/9pfs: Factor out do_fs_version() helper
Date: Tue, 20 Oct 2020 17:50:17 +0200
Message-ID: <5011369.IO3LVfFpa3@silver>
In-Reply-To: <20201020174156.229f8008@bahia.lan>
References: <160320655763.255209.3890094487013964615.stgit@bahia.lan>
 <3517148.drKrQmItIC@silver> <20201020174156.229f8008@bahia.lan>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Received-SPF: pass client-ip=91.194.90.13; envelope-from=qemu_oss@crudebyte.com;
 helo=lizzy.crudebyte.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/20 07:54:35
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Dienstag, 20. Oktober 2020 17:41:56 CEST Greg Kurz wrote:
> On Tue, 20 Oct 2020 17:34:05 +0200
> 
> Christian Schoenebeck <qemu_oss@crudebyte.com> wrote:
> > On Dienstag, 20. Oktober 2020 17:11:05 CEST Greg Kurz wrote:
> > > fs_version() is a top level test function. Factor out the sugar
> > > to a separate helper instead of hijacking it in other tests.
> > > 
> > > Signed-off-by: Greg Kurz <groug@kaod.org>
> > > ---
> > > 
> > >  tests/qtest/virtio-9p-test.c |   14 +++++++++-----
> > >  1 file changed, 9 insertions(+), 5 deletions(-)
> > > 
> > > diff --git a/tests/qtest/virtio-9p-test.c b/tests/qtest/virtio-9p-test.c
> > > index c15908f27b3d..63f91aaf77e6 100644
> > > --- a/tests/qtest/virtio-9p-test.c
> > > +++ b/tests/qtest/virtio-9p-test.c
> > > @@ -567,10 +567,8 @@ static void v9fs_rflush(P9Req *req)
> > > 
> > >      v9fs_req_free(req);
> > >  
> > >  }
> > > 
> > > -static void fs_version(void *obj, void *data, QGuestAllocator *t_alloc)
> > > +static void do_fs_version(QVirtio9P *v9p)
> > > 
> > >  {
> > > 
> > > -    QVirtio9P *v9p = obj;
> > > -    alloc = t_alloc;
> > > 
> > >      const char *version = "9P2000.L";
> > >      uint16_t server_len;
> > >      char *server_version;
> > > 
> > > @@ -585,13 +583,19 @@ static void fs_version(void *obj, void *data,
> > > QGuestAllocator *t_alloc) g_free(server_version);
> > > 
> > >  }
> > 
> > So the naming convention from now on shall be do_fs_*() for non-toplevel
> > functions there. Not that I care too much about the precise prefix, but
> > how
> > about just do_*() for them instead?
> 
> I've prepended "do_" to the existing names by pure laziness but I'm
> fine with any prefix or naming convention actually.
> 
> So just tell me what you prefer and I'll send a v2.

It's really just more pleasant for the eye to have the prefix a bit shorter. 
So use do_*() or any other kind of xx_*() or xxx_*() prefix that comes to your 
mind. It will be fine with me.

Thanks Greg!

Best regards,
Christian Schoenebeck



