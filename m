Return-Path: <SRS0=vczr=7A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A100C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 17:20:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2FFD7204EC
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 17:20:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (4096-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="QWYfCQ2o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FFD7204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50794 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jajRA-0002MI-CP
	for qemu-devel@archiver.kernel.org; Mon, 18 May 2020 13:20:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37650)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1jajQH-0001bC-Qf; Mon, 18 May 2020 13:19:29 -0400
Received: from kylie.crudebyte.com ([5.189.157.229]:47315)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1jajQG-0000Ln-6U; Mon, 18 May 2020 13:19:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Content-ID:Content-Description;
 bh=q4PQmhLnrPh32MxwRrmQYN8C9NQqY2xV4gvopcq0X3s=; b=QWYfCQ2ohWexyblUTWIz1CHNrK
 jRXT8ya0syMxPDymbEemJAd8Tpe+GOKDGABu3Xx2xBzVYAXbkrZ3NcdTH+dveV7JZKeXP4z4Fg0VE
 3IHaPeKx69OVTCZX2uwcDHpJmN8kfv3mqXqpchMUewzVRJ4zQ+eG3PdPLiHBiPaUx8+rIWqHGOrd7
 UjWIQR7ZRV/EtPLgMRfRXDNaeycHju2i0yGYtI5PXUrbq8KxjQJC/0xisHlPxZy+RHoExpBV8eMBF
 MzdzHl6IHq1u0RTzapzHT3QmB2fWDM9mYQ3f8zzxLIwZFaQaAoYsMfHLJoXIOIYnip+QQJ0fbjAdc
 67Upen9pN7LvacaIqmQ6q4xcNXlvLfFexQ3PtTFnj8TIOQUhVOH5YZQM3j2wCnl0sx5iaTa2wUGYY
 xoqCy6FEsCybgtBk3IEn+5iyX8oCortN+xVTCMuPWQHRSKHHLfnQMJvOvComQ4+zsYW/08dEzqQS7
 yMPJtTAqINmx4ACpGV2LIqxUKkzCNT6WH5A3/FEos9vGnUys0EJ1F2YUggWbfNeDVSAl1NvLOFJcz
 Fv+eFbBpsQCbqRRDXNClhYw/qY19DdSoQ+uIbmgKUnXyiX9rzVePsTPZ9YfC7olVC3bmXUjb/ZXck
 FjmrgXZXJkZaafgrFCDLsbVxOsrsTifNY6lKZvD1A=;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
To: qemu-devel@nongnu.org
Cc: Greg Kurz <groug@kaod.org>, qemu-stable@nongnu.org
Subject: Re: [PATCH v2] 9p: Lock directory streams with a CoMutex
Date: Mon, 18 May 2020 19:19:23 +0200
Message-ID: <6260889.bZkrU2UVsV@silver>
In-Reply-To: <20200518183504.679a99aa@bahia.lan>
References: <158981894794.109297.3530035833368944254.stgit@bahia.lan>
 <20200518183504.679a99aa@bahia.lan>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Received-SPF: pass client-ip=5.189.157.229;
 envelope-from=qemu_oss@crudebyte.com; helo=kylie.crudebyte.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/18 13:19:25
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

On Montag, 18. Mai 2020 18:35:04 CEST Greg Kurz wrote:
> On Mon, 18 May 2020 18:22:28 +0200
> 
> Greg Kurz <groug@kaod.org> wrote:
> > Locking was introduced in QEMU 2.7 to address the deprecation of
> > readdir_r(3) in glibc 2.24. It turns out that the frontend code is
> > the worst place to handle a critical section with a pthread mutex:
> > the code runs in a coroutine on behalf of the QEMU mainloop and then
> > yields control, waiting for the fsdev backend to process the request
> > in a worker thread. If the client resends another readdir request for
> > the same fid before the previous one finally unlocked the mutex, we're
> > deadlocked.
> > 
> > This never bit us because the linux client serializes readdir requests
> > for the same fid, but it is quite easy to demonstrate with a custom
> > client.
> > 
> > A good solution could be to narrow the critical section in the worker
> > thread code and to return a copy of the dirent to the frontend, but
> > this causes quite some changes in both 9p.c and codir.c. So, instead
> > of that, in order for people to easily backport the fix to older QEMU
> > versions, let's simply use a CoMutex since all the users for this
> > sit in coroutines.
> > 
> > Fixes: 7cde47d4a89d ("9p: add locking to V9fsDir")
> > Signed-off-by: Greg Kurz <groug@kaod.org>
> > ---
> 
> Just to clarify, this is v2 of:
> 
> 9pfs: Fix potential deadlock of QEMU mainloop
> 
> https://patchwork.ozlabs.org/project/qemu-devel/patch/158826201391.1344781.9
> 403916162733181811.stgit@bahia.lan/

Good move!

Reviewed-by: Christian Schoenebeck <qemu_oss@crudebyte.com>




