Return-Path: <SRS0=QWrs=3F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA6ECC33CB6
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 23:27:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A41392073A
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 23:27:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="QyTva4QV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A41392073A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49758 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1isEXU-0000oP-NC
	for qemu-devel@archiver.kernel.org; Thu, 16 Jan 2020 18:27:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53362)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berto@igalia.com>) id 1isEWg-0008Od-NJ
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 18:26:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berto@igalia.com>) id 1isEWd-0004fY-Oe
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 18:26:10 -0500
Received: from fanzine.igalia.com ([178.60.130.6]:44330)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <berto@igalia.com>)
 id 1isEWd-0004eC-5e; Thu, 16 Jan 2020 18:26:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
 s=20170329; 
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From;
 bh=qWyxUFBqbTwOfxKgzmRMlH2LPLN1sPbaesWDG1PqPaI=; 
 b=QyTva4QVk99afG0P3l2mnYP6/UOREsmhYQSGppoPy2l6xSVLUdo2Hy8e7mY7C5WTsu80IbmvstnkhGOMfdx3S8IGXAzqHk9lgdspsVnunOHR9LYyu7kDp10+tiY/VarAWi9CXlAqybJYRMNtNL3MxDsIJQlL8847Q27Wwc7DZUuZIRkCc40pNbGOk2uwvQ/bqa7oPc2D44fJf32cLM+oA/dR5GDzdhYXMKCevq08tmYx/NhfvqJplw3fdbDX47dOYnZHcwcHmT9vFACy7uFbreAaCzsDIHxsyn9BdNmQSRhIGDEc4YiDWkDp4i8DYodSJ9hAlYh2Guf8bvpWJ/Y4oQ==;
Received: from maestria.local.igalia.com ([192.168.10.14] helo=mail.igalia.com)
 by fanzine.igalia.com with esmtps 
 (Cipher TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim)
 id 1isEWZ-0002E7-Jq; Fri, 17 Jan 2020 00:26:03 +0100
Received: from berto by mail.igalia.com with local (Exim)
 id 1isEWZ-0001Bn-AK; Fri, 17 Jan 2020 00:26:03 +0100
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
Date: Fri, 17 Jan 2020 00:26:03 +0100
Message-ID: <w517e1rf0fo.fsf@maestria.local.igalia.com>
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

On Tue 14 Jan 2020 03:15:48 PM CET, Max Reitz wrote:
>> @@ -219,7 +219,7 @@ static int l2_load(BlockDriverState *bs, uint64_t of=
fset,
>>   * Writes one sector of the L1 table to the disk (can't update single e=
ntries
>>   * and we really don't want bdrv_pread to perform a read-modify-write)
>>   */
>> -#define L1_ENTRIES_PER_SECTOR (512 / 8)
>> +#define L1_ENTRIES_PER_SECTOR (BDRV_SECTOR_SIZE / 8)
>>  int qcow2_write_l1_entry(BlockDriverState *bs, int l1_index)
>
> Here it=E2=80=99s because the comment is wrong: =E2=80=9CCan=E2=80=99t up=
date single entries=E2=80=9D =E2=80=93
> yes, we can.  We=E2=80=99d just have to do a bdrv_pwrite() to a single en=
try.

What's the point of qcow2_write_l1_entry() then?

>> @@ -3836,7 +3837,7 @@ qcow2_co_copy_range_from(BlockDriverState *bs,
>>          case QCOW2_CLUSTER_NORMAL:
>>              child =3D s->data_file;
>>              copy_offset +=3D offset_into_cluster(s, src_offset);
>> -            if ((copy_offset & 511) !=3D 0) {
>> +            if (!QEMU_IS_ALIGNED(copy_offset, BDRV_SECTOR_SIZE)) {
>
> Hm.  I don=E2=80=99t get this one.

Checking the code (e.g. block_copy_do_copy()) it seems that the whole
chunk must be cluster aligned so I don't get this one either.

Berto

