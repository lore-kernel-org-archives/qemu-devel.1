Return-Path: <SRS0=J7/p=6I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C686FC54FCB
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2020 18:38:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 92864206EC
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2020 18:38:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="N6mLp6TS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92864206EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48134 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jS3Dx-00014L-NT
	for qemu-devel@archiver.kernel.org; Fri, 24 Apr 2020 14:38:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41592)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berto@igalia.com>) id 1jS3Ct-0008N5-Ru
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 14:37:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <berto@igalia.com>) id 1jS3Cs-0003yB-Un
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 14:37:47 -0400
Received: from fanzine.igalia.com ([178.60.130.6]:57990)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1jS3Cs-0003xP-3x; Fri, 24 Apr 2020 14:37:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
 s=20170329; 
 h=Content-Type:MIME-Version:Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From;
 bh=YHTGEtlnY35Pn04MaJmbtXAE/U4qntWZ3aVhCaObJmA=; 
 b=N6mLp6TSS+imFdLiFFXakpp8NKK/P5YhthXbncd+pBZx//p7rnGq864jcVlWBODW4aMlBrwl+bUZqslsNByw9vUwVGvxVfNA6+VySniltUUbMpKd/F2AfjeOw4RqvCUe+Rusz/gs+AZydaLgesanFrjCp+2iiuKH6pQggJFkUDCkZEh9uBmCm2/Gxiy1Hi/zk4nBBgJrr5KKOE2e1gcoRrowTSc+rBRM9ZK/ist3yx/5s3GFnrdq2f87x7qvh3h2RWnE4JEusyewsiEa+MbZRF3byjue+hI5JogtxngtkgJAfFa5O6MjdJs35IjEUaAHYDVLqfJ3t+UUTe9N/KKDVg==;
Received: from maestria.local.igalia.com ([192.168.10.14] helo=mail.igalia.com)
 by fanzine.igalia.com with esmtps 
 (Cipher TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim)
 id 1jS3Ck-0003YZ-Ug; Fri, 24 Apr 2020 20:37:38 +0200
Received: from berto by mail.igalia.com with local (Exim)
 id 1jS3Ck-00088N-KL; Fri, 24 Apr 2020 20:37:38 +0200
From: Alberto Garcia <berto@igalia.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH v4 24/30] qcow2: Clear the L2 bitmap when allocating a
 compressed cluster
In-Reply-To: <2ed917cb-edf1-faeb-532b-ad5edb39d293@virtuozzo.com>
References: <cover.1584468723.git.berto@igalia.com>
 <6d596d82ed62615a8565b661691a06bfaf32237e.1584468723.git.berto@igalia.com>
 <w51r1wcn7eu.fsf@maestria.local.igalia.com>
 <1606ecb5-98ea-fefb-bb98-2ecda1d65f5c@redhat.com>
 <w51o8rgn6j6.fsf@maestria.local.igalia.com>
 <57ac1a2f-1632-1a00-b18d-1fc2169175b6@redhat.com>
 <w51lfmkn4ws.fsf@maestria.local.igalia.com>
 <2ed917cb-edf1-faeb-532b-ad5edb39d293@virtuozzo.com>
User-Agent: Notmuch/0.18.2 (http://notmuchmail.org) Emacs/24.4.1
 (i586-pc-linux-gnu)
Date: Fri, 24 Apr 2020 20:37:38 +0200
Message-ID: <w51imhon30t.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=178.60.130.6; envelope-from=berto@igalia.com;
 helo=fanzine.igalia.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/24 13:02:51
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x (no timestamps) [generic] [fuzzy]
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
Cc: Kevin Wolf <kwolf@redhat.com>, "Denis V . Lunev" <den@openvz.org>,
 Anton Nefedov <anton.nefedov@virtuozzo.com>, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri 24 Apr 2020 08:25:45 PM CEST, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com> wrote:
>>> Reading the entire cluster will be interesting - you'll have to
>>> decompress the entire memory, then overwrite the zeroed portions.
>> 
>> I don't think so, qcow2_get_host_offset() would detect the number of
>> contiguous subclusters of the same type at the given offset. In this
>> case they would be _ZERO subclusters so there's no need to decompress
>> anything, or even read it (it works the same with uncompressed
>> clusters).
>
> But if at least one of subclusters to read is not _ZERO, you'll have
> to decompress the whole cluster, and after decompression rewrite
> zero-subclusters by zeroes, as Eric says.. Or I lost the thread:)

I don't see why you would need to rewrite anything... you do have to
decompress the whole cluster, and the uncompressed cluster in memory
would have stale data, but you never need to use that data for anything,
let alone to return it to the guest.

Even if there's a COW, the new cluster would inherit the compressed
cluster's bitmap so the zeroized subclusters still read as zeroes.

It's the same with normal clusters, 'write -P 0xff 0 64k' followed by
'write -z 16k 16k'. The host cluster on disk still reads as 0xff but the
L2 entry indicates that part of it is just zeroes.

Berto

