Return-Path: <SRS0=NBT7=6W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 948B2C47257
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 18:14:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 61D41208CA
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 18:14:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JH2syRJp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61D41208CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59084 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jX7Vp-0007vP-Dw
	for qemu-devel@archiver.kernel.org; Fri, 08 May 2020 14:14:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58568)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1jX7V3-0006vJ-TK
 for qemu-devel@nongnu.org; Fri, 08 May 2020 14:13:29 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:48298
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1jX7V1-00011f-Nk
 for qemu-devel@nongnu.org; Fri, 08 May 2020 14:13:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588961606;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6rSqaLD10t2F/EmurDFluFwlhdPW6OmQ5N1HQMGxCxo=;
 b=JH2syRJpCrGvfr586A0B+QkyF1ujyxTS+C8G66Vd3DC8yVEpoPddNxy/EmYIV1M0st5C9W
 AbUytGL/LinR2sQrHFUru+xEooYYHFFb5g1FjWN41xBHtgwhiS/lFQAO0xrgM5RHCZBcUR
 jxDLswWYv6p4qy4fuSPmTwoMGuyny+Q=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-441-WKSJhAeCOTeSAQgYIOVC2g-1; Fri, 08 May 2020 14:13:25 -0400
X-MC-Unique: WKSJhAeCOTeSAQgYIOVC2g-1
Received: by mail-wr1-f71.google.com with SMTP id f15so1276922wrj.2
 for <qemu-devel@nongnu.org>; Fri, 08 May 2020 11:13:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:content-transfer-encoding:from:mime-version
 :subject:date:message-id:references:cc:in-reply-to:to;
 bh=Mx3GKkaDTJhQGvoZ5R6Z20RMSa1lbFA43/KRiVg0GYc=;
 b=IaFJMwYE6dfViNsIxAl9hh5S1pyfI+xYdeo9EsgzDl/xuk0rHhAkCM95WoJM8FGpuY
 Qo5Yx6kqPfm3uR4iw5/DGZgcL7fdeWfTiVakyGp5S/LtQge9I0JblBDZp2YfR1JKUawq
 lHr5/mqkDjB7R3mzNCjSurVhoiDg4Pnz0qy12B3qTt2ZBfEUosDJDlPNLeREB5/9G9qQ
 IamoUAlQh1z3/eQtPclogzTtnr5TnRsIRT00D2DXh/IIUR6ebSbel0YOI4r2BNCbe6VR
 UzgWjHcrIvSzPHI1jSuOaF3NLi6fPdIVcCILzAoXuf7i195mgJjTG0MJRdSqfENLibiL
 m4tQ==
X-Gm-Message-State: AGi0PubWA0fdS9qAsjvqjQJE2SQ05Vja2myvWxFJ8s9A73NhTMP5L5t0
 L3RgxgjiHAM7XvFtpExK9ih4LRHMyF5SIKt7HN12miXLJon5rI8ZEuE6pfEpeBi1vRls/tQVBT2
 GR4mrdZYk/e0+8pA=
X-Received: by 2002:adf:bb4e:: with SMTP id x14mr4178026wrg.63.1588961603693; 
 Fri, 08 May 2020 11:13:23 -0700 (PDT)
X-Google-Smtp-Source: APiQypKVCkd4durHDfQE0F8YN/M9b9vvzRhUJHYqeFztvlx4LW4zeksqUdDc14mHPbobYbsiul4BCg==
X-Received: by 2002:adf:bb4e:: with SMTP id x14mr4178007wrg.63.1588961603460; 
 Fri, 08 May 2020 11:13:23 -0700 (PDT)
Received: from [192.168.3.122] (p5B0C65A5.dip0.t-ipconnect.de. [91.12.101.165])
 by smtp.gmail.com with ESMTPSA id r2sm4646176wrg.84.2020.05.08.11.13.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 08 May 2020 11:13:22 -0700 (PDT)
From: David Hildenbrand <david@redhat.com>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v23 QEMU 0/5] virtio-balloon: add support for page poison
 reporting and free page reporting
Date: Fri, 8 May 2020 20:13:21 +0200
Message-Id: <DB82EE9A-39EF-414B-9BB7-C5B283F014A4@redhat.com>
References: <CAKgT0UcygsdURGivgTb08i2Ot0TQAzahLKhkkzXvhsoEU-7p3Q@mail.gmail.com>
In-Reply-To: <CAKgT0UcygsdURGivgTb08i2Ot0TQAzahLKhkkzXvhsoEU-7p3Q@mail.gmail.com>
To: Alexander Duyck <alexander.duyck@gmail.com>
X-Mailer: iPhone Mail (17D50)
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.81; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/08 01:34:54
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: virtio-dev@lists.oasis-open.org, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-devel@nongnu.org, David Hildenbrand <david@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



> Am 08.05.2020 um 19:31 schrieb Alexander Duyck <alexander.duyck@gmail.com=
>:
>=20
> =EF=BB=BFI just wanted to follow up since it has been a little over a wee=
k
> since I submitted this and I haven't heard anything back. It looks
> like the linux-headers patches can be dropped since the headers appear
> to have been synced. I was wondering if I should resubmit with just
> the 3 patches that are adding the functionality, or if this patch-set
> is good as-is?

Should be good as-is. However, if the new compat machines are already upstr=
eam, you might want to tackle that right away.

Cheers and have a nice weekend!

>=20
> Thanks.
>=20
> - Alex
>=20
>> On Mon, Apr 27, 2020 at 5:53 PM Alexander Duyck
>> <alexander.duyck@gmail.com> wrote:
>>=20
>> This series provides an asynchronous means of reporting free guest pages
>> to QEMU through virtio-balloon so that the memory associated with those
>> pages can be dropped and reused by other processes and/or guests on the
>> host. Using this it is possible to avoid unnecessary I/O to disk and
>> greatly improve performance in the case of memory overcommit on the host=
.
>>=20
>> I originally submitted this patch series back on February 11th 2020[1],
>> but at that time I was focused primarily on the kernel portion of this
>> patch set. However as of April 7th those patches are now included in
>> Linus's kernel tree[2] and so I am submitting the QEMU pieces for
>> inclusion.
>>=20
>> [1]: https://lore.kernel.org/lkml/20200211224416.29318.44077.stgit@local=
host.localdomain/
>> [2]: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/=
commit/?id=3Db0c504f154718904ae49349147e3b7e6ae91ffdc
>>=20
>> Changes from v17:
>> Fixed typo in patch 1 title
>> Addressed white-space issues reported via checkpatch
>> Added braces {} for two if statements to match expected coding style
>>=20
>> Changes from v18:
>> Updated patches 2 and 3 based on input from dhildenb
>> Added comment to patch 2 describing what keeps us from reporting a bad p=
age
>> Added patch to address issue with ROM devices being directly writable
>>=20
>> Changes from v19:
>> Added std-headers change to match changes pushed for linux kernel header=
s
>> Added patch to remove "report" from page hinting code paths
>> Updated comment to better explain why we disable hints w/ page poisoning
>> Removed code that was modifying config size for poison vs hinting
>> Dropped x-page-poison property
>> Added code to bounds check the reported region vs the RAM block
>> Dropped patch for ROM devices as that was already pulled in by Paolo
>>=20
>> Changes from v20:
>> Rearranged patches to push Linux header sync patches to front
>> Removed association between free page hinting and VIRTIO_BALLOON_F_PAGE_=
POISON
>> Added code to enable VIRTIO_BALLOON_F_PAGE_POISON if page reporting is e=
nabled
>> Fixed possible resource leak if poison or qemu_balloon_is_inhibited retu=
rn true
>>=20
>> Changes from v21:
>> Added ack for patch 3
>> Rewrote patch description for page poison reporting feature
>> Made page-poison independent property and set to enabled by default
>> Added logic to migrate poison_val
>> Added several comments in code to better explain features
>> Switched free-page-reporting property to disabled by default
>>=20
>> Changes from v22:
>> Added ack for patches 4 & 5
>> Added additional comment fixes in patch 3 to remove "reporting" referenc=
e
>> Renamed rvq in patch 5 to reporting_vq to improve readability
>> Moved call adding reporting_vq to after free_page_vq to fix VQ ordering
>>=20
>> ---
>>=20
>> Alexander Duyck (5):
>>      linux-headers: Update to allow renaming of free_page_report_cmd_id
>>      linux-headers: update to contain virito-balloon free page reporting
>>      virtio-balloon: Replace free page hinting references to 'report' wi=
th 'hint'
>>      virtio-balloon: Implement support for page poison reporting feature
>>      virtio-balloon: Provide an interface for free page reporting
>>=20
>>=20
>> hw/virtio/virtio-balloon.c                      |  176 +++++++++++++++++=
+-----
>> include/hw/virtio/virtio-balloon.h              |   23 ++-
>> include/standard-headers/linux/virtio_balloon.h |   12 +-
>> 3 files changed, 159 insertions(+), 52 deletions(-)
>>=20
>> --
>=20


