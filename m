Return-Path: <SRS0=s5cl=6V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8495FC38A2A
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 12:18:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4FC742083B
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 12:18:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (4096-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="KZCTPH5J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FC742083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47096 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWfTi-00089o-GR
	for qemu-devel@archiver.kernel.org; Thu, 07 May 2020 08:18:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42590)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1jWfSj-0007N0-GF
 for qemu-devel@nongnu.org; Thu, 07 May 2020 08:17:13 -0400
Received: from kylie.crudebyte.com ([5.189.157.229]:52919)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1jWfSh-0007KQ-Si
 for qemu-devel@nongnu.org; Thu, 07 May 2020 08:17:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Content-ID:Content-Description;
 bh=mv04ZJs3rrcf/JOXe+WKu73THNryL5pzoWrBCN5U08Q=; b=KZCTPH5JzLzRj8+cYj3Bbq1y8X
 7KLRfkyVdEpMXrxYr2LZg3nXGUfz/Q+/9AiKG7/9ccrFmVuvhSN8nwGWD9I4hpXpCesIESQX/+O22
 ZRofkZh+b+3BcyRrgbAseWz2Vv4Lu9/4YDkwcGQMis0NBzRGdaPgzu+6xvTeoj0Q/H4d0bpEOvuqc
 jB3CZE2Nu9bbT7xbZJFNLEUAacPNy7AT1k1uZq9CRoA2glbM/CRZ3iOybc+1G9a229LU3UGOh1OjA
 2gQ0c7lNHiIMOGm0YlnCyuNhtZKxl8ZlWl7AA1xvVXqoI+/JOZSz+ADSQVmy9DH64H6Tof5ZUsJ45
 pudxUpT2Gr5Q31lJWTpQFO+lA2CRmkp0HFYmkAAuUZl31X6WypGU3twAaArmjlwcfruI2K2xy2MUf
 f7msdh68i4zYYV4zWUg94S0GNZKCuH3JYyclui05Vha5gyQ8UWhVpdbuGRt3+eUdac4e2Hfpla6F1
 UN7lvYMZZfSqMZjd7p9I1kgKr+ns80FDaHcGt006P+KknTVS+vdmuWbmXh821ojdfWQ7yfqZEqErq
 Of+9dZOufJlzacqdQZDol3j/5jM3U5LpRrudQW2fjR8tEmdv3D09qac9fivpnqnTex+aJx8P8qbDk
 0SImCzq7FYSkU8R3TC5Wetq6AJEzpMpRIMGJlLIsg=;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
To: qemu-devel@nongnu.org
Cc: Greg Kurz <groug@kaod.org>
Subject: Re: [PATCH v6 3/5] 9pfs: add new function v9fs_co_readdir_many()
Date: Thu, 07 May 2020 14:16:43 +0200
Message-ID: <4330996.EtvE2UMZrz@silver>
In-Reply-To: <20200504111834.117c98d9@bahia.lan>
References: <cover.1587309014.git.qemu_oss@crudebyte.com>
 <5819799.mbObChnQ2B@silver> <20200504111834.117c98d9@bahia.lan>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Received-SPF: pass client-ip=5.189.157.229;
 envelope-from=qemu_oss@crudebyte.com; helo=kylie.crudebyte.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/07 07:37:31
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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

On Montag, 4. Mai 2020 11:18:34 CEST Greg Kurz wrote:
> On Fri, 01 May 2020 16:04:41 +0200
> 
> Christian Schoenebeck <qemu_oss@crudebyte.com> wrote:
> > On Donnerstag, 30. April 2020 15:30:49 CEST Greg Kurz wrote:
> > > > > I agree that a client that issues concurrent readdir requests on the
> > > > > same fid is probably asking for troubles, but this permitted by the
> > > > > spec. Whether we should detect such conditions and warn or even fail
> > > > > is discussion for another thread.
> > > > > 
> > > > > The locking is only needed to avoid concurrent accesses to the
> > > > > dirent
> > > > > structure returned by readdir(), otherwise we could return partially
> > > > > overwritten file names to the client. It must be done for each
> > > > > individual
> > > > > call to readdir(), but certainly not for multiple calls.
> > > > 
> > > > Yeah, that would resolve this issue more appropriately for 9p2000.L,
> > > > since
> > > > Treaddir specifies an offset, but for 9p2000.u the result of a
> > > > concurrent
> > > > read on a directory (9p2000.u) would still be undefined.
> > > 
> > > The bad client behavior you want to tackle has nothing to do with
> > > the locking itself. Since all the code in 9p.c runs serialized in
> > > the context of the QEMU main loop, concurrent readdir requests could
> > > easily be detected up-front with a simple flag in the fid structure.
> > 
> > Well, it's fine with me. I don't really see an issue here right now. But
> > that all the code was serialized is not fully true. Most of the 9p.c code
> > is still heavily dispatching between main thread and worker threads back
> > and forth. And for that reason the order of request processing might
> > change quite arbitrarily in between. Just keep that in mind.
> 
> Just to make things clear. The code in 9p.c is ALWAYS exclusively run by
> the main thread. Only the code called under v9fs_co_run_in_worker() is
> dispatched on worker threads. So, yes the order of individual backend
> operations may change, but the start of a new client request is necessarily
> serialized with the completion of pending ones, which is the only thing
> we care for actually.

I just looked at this. 9p.c code is called by main I/O thread only, that's 
clear. The start of requests come also in in order, yes, but it seems you 
would think that main I/O thread would not grab the next client request from 
queue before completing the current/previous client request (that is not 
before transmitting result to client). If yes, I am not so sure about this 
claim:

For instance v9fs_path_write_lock() is using a co-mutex, right? So an 
unsuccesful lock would cause main I/O thread to grab the next request before 
completing the current/previous request.

And what happens on any run_in_worker({}) call? If there is another client 
request in the queue, main I/O thread would pull that request from the queue 
before waiting for the worker thread to complete its task, wouldn't it?

Just looked at the code so far, haven't tested it yet ...

Best regards,
Christian Schoenebeck



