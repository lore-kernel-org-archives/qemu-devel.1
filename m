Return-Path: <SRS0=9vyd=ZP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70286C432C0
	for <qemu-devel@archiver.kernel.org>; Sat, 23 Nov 2019 19:28:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C7F820679
	for <qemu-devel@archiver.kernel.org>; Sat, 23 Nov 2019 19:28:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (4096-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="OBPtwo9m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C7F820679
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60756 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iYb4s-0003xP-8t
	for qemu-devel@archiver.kernel.org; Sat, 23 Nov 2019 14:28:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47948)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <qemu_oss@crudebyte.com>) id 1iYb3e-0003W2-FJ
 for qemu-devel@nongnu.org; Sat, 23 Nov 2019 14:27:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <qemu_oss@crudebyte.com>) id 1iYb3d-0002xt-89
 for qemu-devel@nongnu.org; Sat, 23 Nov 2019 14:27:02 -0500
Received: from kylie.crudebyte.com ([5.189.157.229]:55793)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <qemu_oss@crudebyte.com>)
 id 1iYb3c-0002wb-QS
 for qemu-devel@nongnu.org; Sat, 23 Nov 2019 14:27:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Content-ID:Content-Description;
 bh=oiEzbeV6eZ1A+8KyTR6A8AhsvIiwsFB42KvjZwna+E0=; b=OBPtwo9mbfM5xt+5UNHYnJWJ2d
 UwZ0Bmi1HwjqR09fZigB0ITBDcQMMG+vcDjfLgM60kRugb4wZeiCon0W1SMCZNumVtCn8oUxcTiFd
 KhHf+y/9/QEGnU2mflWmOGLIzuA/9UrUxn00RKWq26mcacDJVttK6ZMfBNLINd+napLvU+kLD/vC6
 hxVTaLQ6DK0vKHKglcRe95aGCRAsDGmCRHojj6FQyDFcv/kr6fa1i/A8Ue+i2mMEZjYXDrEBnLa2Q
 FuCsNSutm5WVp7yFUZRCyPtr/zAAw/YGEIfx9vGMvUuxm/IdEf948KdlNQfVgjF3BHIcNSEembtxq
 4Xx8TAc2u20oQaXPomF7hrZpIyZIWfGM2mL3ZwImwj7TtMKmaK8zv7j2vl8QE9hK7jicaWe3w32X6
 9dE+f//4e+7iT27jWx2zIiEvu+NdMx+D2EkNNemLL2PRsAZJsKj/zzlz/daGfI0CT9kLvzKJLEIOM
 HaJF0MSU49cgsqeORNWixQuQ0zqVaqhSW2HcJzxGTxJ0fhrSOHDSiZT88i09S7mlieD5qLHkkJf3Z
 1jfcwUgZS9YuzY6oc/6ef+UPIPLHgKhur4KUEMTQMajvIs0K8L0rGbf/gYwzhcRh3LLQgPr3qOIdh
 hEQ86NQFpt8DPbp+BKxAD8j5Mb5DaXK8K0yDScJNs=;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
To: qemu-devel@nongnu.org
Cc: Christian Schoenebeck <qemu_oss@crudebyte.com>, Greg Kurz <groug@kaod.org>
Subject: Re: 9p: requests efficiency
Date: Sat, 23 Nov 2019 20:26:57 +0100
Message-ID: <2263612.oZDIEGKQVF@silver>
In-Reply-To: <2782774.O0duVuAc2B@silver>
References: <1686691.fQlv7Ls6oC@silver> <20191115142656.4f2c0f4b@bahia.lan>
 <2782774.O0duVuAc2B@silver>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 5.189.157.229
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

On Donnerstag, 21. November 2019 00:37:36 CET Christian Schoenebeck wrote:
> If so, I haven't understood how precisely v9fs_co_run_in_worker() works. I
> mean I understand now how QEMU coroutines are working, and the idea of
> v9fs_co_run_in_worker() is dispatching the passed code block to the worker
> thread, but immediately returning back to main thread and continueing there
> on main thread with other coroutines while the worker thread's dispatched
> coroutine finished. But how that happens there precisely in
> v9fs_co_run_in_worker() is not yet clear to me.
> 
> Also where are the worker threads spawned actually?

Never mind about these questions; I figured them out by myself in the 
meantime.

Another question though: I see that you introduced those readdir mutex locks 
with commit 7cde47d4a89. Do you remember the scenario where this concurrency 
issue happened? 

V9fsDir exists per file ID. So I think concurrency should only happen there if 
the same file ID (of a directory) was shared and used concurrently on guest 
side. Because otherwise if the file ID was used by only one thread on guest 
side, then all 9p requests on that fid should end up being completely 
serialized end to end.

Best regards,
Christian Schoenebeck



