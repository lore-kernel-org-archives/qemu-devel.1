Return-Path: <SRS0=+pSw=DC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5825BC4727C
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 15:52:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B7CB421741
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 15:52:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="h2bq8Guj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7CB421741
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43684 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLq1V-0005kR-Om
	for qemu-devel@archiver.kernel.org; Fri, 25 Sep 2020 11:52:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37724)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1kLpwY-00015a-9L
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 11:47:33 -0400
Received: from lizzy.crudebyte.com ([91.194.90.13]:39521)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1kLpwU-0000E7-BR
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 11:47:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=lizzy; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Content-ID:Content-Description;
 bh=F6mcedIpg5w876yARFX2BeCE/zuKLgBW/YTc2xMOwYs=; b=h2bq8GujGL2lRk3oXTBBG8LRo8
 YxCYpUvZ4nmv7Bq1Vx88aab5lfs2CqRroM8CqZkZBUW/gsAYArsiWo0BZIIsDf5+AH2o5QuO+7RZ1
 /k7SMz0jYc8w83BOc2syySLFu2zCRQ/9+qvUzRghQwSaZiIq4Zb8IEyW7rJ+grsyMvaW+J9AgM6bv
 hA5UW6G+nNchQej3TCia3nnFTk7ldZ3V98OINeZRo9OpSaIPfvO7NO56EXRaMIvd/RypOLJmBWhHr
 sTOqVnJN+XI7ut2FKRW30mQbbau/2H8ne7kclMNWYLNgSoQ7iE0RcN7rY+dOUI1rtxC2Uf4sKfnsq
 yLpTKUPQ==;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
To: qemu-devel@nongnu.org
Cc: Vivek Goyal <vgoyal@redhat.com>, "Shinde,
 Archana M" <archana.m.shinde@intel.com>, "Venegas Munoz,
 Jose Carlos" <jose.carlos.venegas.munoz@intel.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 virtio-fs-list <virtio-fs@redhat.com>, Greg Kurz <groug@kaod.org>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 "cdupontd@redhat.com" <cdupontd@redhat.com>
Subject: Re: virtiofs vs 9p performance
Date: Fri, 25 Sep 2020 17:47:21 +0200
Message-ID: <4615316.mGufCYyPMH@silver>
In-Reply-To: <20200925131356.GD132653@redhat.com>
References: <20200918213436.GA3520@redhat.com> <17216624.eqST2d0sUl@silver>
 <20200925131356.GD132653@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Received-SPF: pass client-ip=91.194.90.13; envelope-from=qemu_oss@crudebyte.com;
 helo=lizzy.crudebyte.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/25 11:47:23
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

On Freitag, 25. September 2020 15:13:56 CEST Vivek Goyal wrote:
> On Fri, Sep 25, 2020 at 10:06:41AM +0200, Christian Schoenebeck wrote:
> > On Freitag, 25. September 2020 00:10:23 CEST Vivek Goyal wrote:
> > > In my testing, with cache=none, virtiofs performed better than 9p in
> > > all the fio jobs I was running. For the case of cache=auto  for virtiofs
> > > (with xattr enabled), 9p performed better in certain write workloads. I
> > > have identified root cause of that problem and working on
> > > HANDLE_KILLPRIV_V2 patches to improve WRITE performance of virtiofs
> > > with cache=auto and xattr enabled.
> > 
> > Please note, when it comes to performance aspects, you should set a
> > reasonable high value for 'msize' on 9p client side:
> > https://wiki.qemu.org/Documentation/9psetup#msize
> 
> Interesting. I will try that. What does "msize" do?

Simple: it's the "maximum message size" ever to be used for communication 
between host and guest, in both directions that is.

So if that 'msize' value is too small, a potential large 9p message would be 
split into several smaller 9p messages, and each message adds latency which is 
the main problem.

Keep in mind: The default value with Linux clients for msize is still only 
8kB!

Think of doing 'dd bs=8192 if=/src.dat of=/dst.dat count=...' as analogy, 
which probably makes its impact on performance clear.

However the negative impact of a small 'msize' value is not just limited to 
raw file I/O like that; calling readdir() for instance on a guest directory 
with several hundred files or more, will likewise slow down in the same way 
tremendously as both sides have to transmit a large amount of 9p messages back 
and forth instead of just 2 messages (Treaddir and Rreaddir).

> > I'm also working on performance optimizations for 9p BTW. There is plenty
> > of headroom to put it mildly. For QEMU 5.2 I started by addressing
> > readdir requests:
> > https://wiki.qemu.org/ChangeLog/5.2#9pfs
> 
> Nice. I guess this performance comparison between 9p and virtiofs is good.
> Both the projects can try to identify weak points and improve performance.

Yes, that's indeed handy being able to make comparisons.

Best regards,
Christian Schoenebeck



