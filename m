Return-Path: <SRS0=FIxb=52=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A7E0C2BA2B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2020 12:48:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B439820769
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2020 12:48:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="Uw0BPi4H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B439820769
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33924 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jMt5c-0004tJ-Ue
	for qemu-devel@archiver.kernel.org; Fri, 10 Apr 2020 08:48:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39410)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berto@igalia.com>) id 1jMt4F-0004CP-EE
 for qemu-devel@nongnu.org; Fri, 10 Apr 2020 08:47:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berto@igalia.com>) id 1jMt4E-0001jg-7b
 for qemu-devel@nongnu.org; Fri, 10 Apr 2020 08:47:31 -0400
Received: from fanzine.igalia.com ([178.60.130.6]:57076)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <berto@igalia.com>)
 id 1jMt4D-0001iq-MQ; Fri, 10 Apr 2020 08:47:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
 s=20170329; 
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From;
 bh=UEu8nINLdgmecKLdd+dY3ekmKx4uSztw04PX8MRvYu8=; 
 b=Uw0BPi4HkgUnA5uBiFD95fu5Z5PI6NvLnIeQz7fix8L5cGcc1dfdNGgQf8Fk/FWjAIEmDM25az42apEG0tOwLop6bA1kv3fqE9jjQN5Ny2Jb5R2hNbkANc9ZSto01a4Etv7+Yp5WcjKHHXV1fx6VinpRPtVtpD18rG5yg7D2HyPF7/KdHvXuNemylpbASw2luJQOg+NxVoRW2wKnrwzoJadOSxUBBFzZ0VRdoQDZL1+NyeAhqmKg8xvsYJOjP+wE+RRq8x2ctKhlZ7ZGz3oR/fBmyfI02rrSiLp7jP1Aey38ycHWm0l6Tw0Lj9ywt+vs3WjbrZzmfdj8OCZIlsArlA==;
Received: from maestria.local.igalia.com ([192.168.10.14] helo=mail.igalia.com)
 by fanzine.igalia.com with esmtps 
 (Cipher TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim)
 id 1jMt4A-0003VT-Le; Fri, 10 Apr 2020 14:47:26 +0200
Received: from berto by mail.igalia.com with local (Exim)
 id 1jMt4A-00078D-Bb; Fri, 10 Apr 2020 14:47:26 +0200
From: Alberto Garcia <berto@igalia.com>
To: Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH v4 20/30] qcow2: Add subcluster support to
 discard_in_l2_slice()
In-Reply-To: <4b3b1ef4-2f8b-b16f-3c48-2ba6137763e4@redhat.com>
References: <cover.1584468723.git.berto@igalia.com>
 <99b45e3beb4a38b17eb50fcde1e09cdefdb99724.1584468723.git.berto@igalia.com>
 <4b3b1ef4-2f8b-b16f-3c48-2ba6137763e4@redhat.com>
User-Agent: Notmuch/0.18.2 (http://notmuchmail.org) Emacs/24.4.1
 (i586-pc-linux-gnu)
Date: Fri, 10 Apr 2020 14:47:26 +0200
Message-ID: <w51k12n5wyp.fsf@maestria.local.igalia.com>
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
Cc: Kevin Wolf <kwolf@redhat.com>, Anton Nefedov <anton.nefedov@virtuozzo.com>,
 qemu-block@nongnu.org, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "Denis V . Lunev" <den@openvz.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu 09 Apr 2020 12:05:12 PM CEST, Max Reitz wrote:
>>          switch (qcow2_get_cluster_type(bs, old_l2_entry)) {
>>          case QCOW2_CLUSTER_UNALLOCATED:
>> -            if (full_discard || !bs->backing) {
>> +            if (full_discard) {
>> +                /* If the image has extended L2 entries we can only
>> +                 * skip this operation if the L2 bitmap is zero. */
>> +                uint64_t bitmap =3D has_subclusters(s) ?
>> +                    get_l2_bitmap(s, l2_slice, l2_index + i) : 0;
>
> Isn=E2=80=99t this bitmap only valid for standard clusters?  In this case=
, the
> whole cluster is unallocated, so the bitmap shouldn=E2=80=99t be relevant,
> AFAIU.

I'm not sure if I follow you.

An unallocated cluster can still have QCOW_OFLAG_SUB_ZERO set in some of
its subclusters. Those read as zeroes and the rest go to the backing
file.

After a full discard all subclusters should be completely deallocated so
those bits should be cleared.

If the bitmap is already 0 (the whole cluster is already unallocated) or
if the image does not have extended L2 entries (which also means that
the whole cluster is already unallocated) then we can skip the discard.

Berto

