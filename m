Return-Path: <SRS0=bgql=3H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94038C32771
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Jan 2020 18:08:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6059E20748
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Jan 2020 18:08:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="fhwPA7RN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6059E20748
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43390 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1issWf-0007Ge-IM
	for qemu-devel@archiver.kernel.org; Sat, 18 Jan 2020 13:08:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42722)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berto@igalia.com>) id 1issW4-0006mH-38
 for qemu-devel@nongnu.org; Sat, 18 Jan 2020 13:08:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berto@igalia.com>) id 1issW2-0001nZ-VY
 for qemu-devel@nongnu.org; Sat, 18 Jan 2020 13:08:11 -0500
Received: from fanzine.igalia.com ([178.60.130.6]:39621)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <berto@igalia.com>)
 id 1issW2-0001YP-Ac; Sat, 18 Jan 2020 13:08:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
 s=20170329; 
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From;
 bh=T624l/Dr+wBcdJsOrht2d+jJe9UJUn0ouA0Jzix1WzQ=; 
 b=fhwPA7RN+a/flOVAVkNdVaApEMmABZLzwlvC5nZcm3+ZVP11tycQr0KiDw44uYc/xavsDWo6x544sEg33/4zyfTaIkC7uP8WNv7R6f75U3mFDlZDBNdakAKkR2jouRqpp4AU/Jg0Cy47GsXd027+Qcoee0QXj2jywVsW0wpxqGkVTF+5+x7Eak9M/ttLGT9UXpOEGmExpIzZlIQ27yX6vInf77OeeTVwTuowwo268OHClQdOlttNK8oYd2piY4CtcWkPqusItRs9tlmkbR/mlQ6BMP2rhGdnXwBFnPBmlWqEjPo4tYmk+tRxSEo6+YdqCZgkOEtsx3GLzyR0qONTLw==;
Received: from maestria.local.igalia.com ([192.168.10.14] helo=mail.igalia.com)
 by fanzine.igalia.com with esmtps 
 (Cipher TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim)
 id 1issVh-0007wL-Gg; Sat, 18 Jan 2020 19:07:49 +0100
Received: from berto by mail.igalia.com with local (Exim)
 id 1issVh-000158-6L; Sat, 18 Jan 2020 19:07:49 +0100
From: Alberto Garcia <berto@igalia.com>
To: Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH v2 4/4] qcow2: Use BDRV_SECTOR_SIZE instead of the
 hardcoded value
In-Reply-To: <02552511-6fcf-d678-362c-707ce6d73659@redhat.com>
References: <cover.1578596897.git.berto@igalia.com>
 <e3982d5118a90db2442c6ac18f339ec8ba006df2.1578596897.git.berto@igalia.com>
 <02552511-6fcf-d678-362c-707ce6d73659@redhat.com>
User-Agent: Notmuch/0.18.2 (http://notmuchmail.org) Emacs/24.4.1
 (i586-pc-linux-gnu)
Date: Sat, 18 Jan 2020 19:07:49 +0100
Message-ID: <w51muak3afe.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x (no
 timestamps) [generic] [fuzzy]
X-Received-From: 178.60.130.6
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
Cc: Kevin Wolf <kwolf@redhat.com>, Nir Soffer <nsoffer@redhat.com>,
 qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue 14 Jan 2020 03:15:48 PM CET, Max Reitz <mreitz@redhat.com> wrote:
>> @@ -3836,7 +3837,7 @@ qcow2_co_copy_range_from(BlockDriverState *bs,
>>          case QCOW2_CLUSTER_NORMAL:
>>              child =3D s->data_file;
>>              copy_offset +=3D offset_into_cluster(s, src_offset);
>> -            if ((copy_offset & 511) !=3D 0) {
>> +            if (!QEMU_IS_ALIGNED(copy_offset, BDRV_SECTOR_SIZE)) {
>
> Hm.  I don=E2=80=99t get this one.

Ok, this came with Fam's "qemu-img convert with copy offloading" series:

   https://lists.gnu.org/archive/html/qemu-block/2018-06/msg00015.html

and qemu-img uses sectors here:

   blk_co_copy_range(..., sector_num << BDRV_SECTOR_BITS,
                     n << BDRV_SECTOR_BITS, ...)

so I guess that's why the check is there. Again, I think this should be
bl.request_alignment, because as far as I can tell copy_file_range()
works just fine unless O_DIRECT is used.

Berto

