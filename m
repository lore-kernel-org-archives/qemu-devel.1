Return-Path: <SRS0=TsRd=ZO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1009DC432C0
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2019 21:54:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA86120708
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2019 21:54:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (4096-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="YsKGicPR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA86120708
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55120 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iYGsK-0004Gy-RC
	for qemu-devel@archiver.kernel.org; Fri, 22 Nov 2019 16:54:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38252)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <qemu_oss@crudebyte.com>) id 1iYGrf-0003oi-1D
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 16:53:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <qemu_oss@crudebyte.com>) id 1iYGrd-0007F3-Pl
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 16:53:18 -0500
Received: from kylie.crudebyte.com ([5.189.157.229]:40315)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <qemu_oss@crudebyte.com>)
 id 1iYGra-0007BM-Us
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 16:53:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Content-ID:Content-Description;
 bh=XgDiAqm+5S1K+M6Pys2A/elRZaPH2hbeXgHRz5jyTh4=; b=YsKGicPRQ06ElfsfLp0h4OKJKB
 TNiO7bSNCXnXV88+OXk14/D2lyhfjXFQTSIY/SACEeOF7pUaDWf8pjC8PCRrbg4W6Bm5Ma3b3XqUq
 4PndKBYtna4/CG19NsCQ6btnLVcWtMasU47JDdOvXElaoGTETGceKgP/93YAGPZWIojHp/XpP4m+B
 kV5Rwtn8DmSeFUT1gxDRBwIzsnasAbIGGZa/wfZeP5Pfj6nojYFWpHdDc3Fmo0RTSiCLa0bjv9t9U
 m6SDSok59Yj5T6VNro1SjkDD2V2fwGNDzS/lMHfHpKbPIDggHrY8dh1+hrhOWtJTjxPZ5eWGlR59S
 VRNIWUYnMDmJ6CjahMhyOJ6mlP0HwB3hEqojED+s4Qnfkal24RW93PZofDAxqj4vn0M060eLW6lTV
 PdFWSRNP11jtFI00jxaH4eA4zaODTlAmLbOlcH79RpkM8ACoZ9vngzFppY3asFkVVdUuC20oocGVM
 IJ698FIEyzb8YOGUmIdh98lDl2/Dr4XRQgsoWNGEVSFXwJYtLn+UWohY21K3LKJktnzEttN8eBLaN
 vKccR53bkZvZiyXlm/YHFU0FhQJnLJ949g+pKS4jNsY6q7j+0ULVthX+24GJP9J4nCzVggWBgze4E
 bWkr7c5HHKiB79L3fQOOUoK70MmDUiUn2u3WEaIZc=;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
To: qemu-devel@nongnu.org
Cc: Dan Schatzberg <dschatzberg@fb.com>, Greg Kurz <groug@kaod.org>
Subject: Re: [PATCH] 9pfs: Fix divide by zero bug
Date: Fri, 22 Nov 2019 22:53:09 +0100
Message-ID: <1786866.o8IioZIX2y@silver>
In-Reply-To: <20191122200034.122564-1-dschatzberg@fb.com>
References: <20191122200034.122564-1-dschatzberg@fb.com>
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

On Freitag, 22. November 2019 21:00:34 CET Dan Schatzberg wrote:
> Some filesystems may return 0s in statfs (trivially, a FUSE filesystem
> can do so). QEMU should handle this gracefully and just behave the
> same as if statfs failed.

Is that actually legal in non-error cases? Shouldn't a driver without a block 
size concept return 512 according to POSIX?

> Signed-off-by: Dan Schatzberg <dschatzberg@fb.com>
> ---
>  hw/9pfs/9p.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
> index 37abcdb71e..520177f40c 100644
> --- a/hw/9pfs/9p.c
> +++ b/hw/9pfs/9p.c
> @@ -1834,8 +1834,10 @@ static int32_t coroutine_fn get_iounit(V9fsPDU *pdu,
> V9fsPath *path) * and as well as less than (client msize - P9_IOHDRSZ))
>       */
>      if (!v9fs_co_statfs(pdu, path, &stbuf)) {
> -        iounit = stbuf.f_bsize;
> -        iounit *= (s->msize - P9_IOHDRSZ)/stbuf.f_bsize;
> +        if (stbuf.f_bsize) {
> +            iounit = stbuf.f_bsize;
> +            iounit *= (s->msize - P9_IOHDRSZ) / stbuf.f_bsize;
> +        }
>      }
>      if (!iounit) {
>          iounit = s->msize - P9_IOHDRSZ;

Nevertheless, since that will leave iounit initialized with zero and since 
there is already an !ionunit case handling there ...

Acked-by: Christian Schoenebeck <qemu_oss@crudebyte.com>

Best regards,
Christian Schoenebeck



