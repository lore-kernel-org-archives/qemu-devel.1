Return-Path: <SRS0=73np=ZA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D382C5DF60
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 15:31:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1493921882
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 15:31:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="sp+k0UBB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1493921882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56258 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iT6EX-0002Am-4G
	for qemu-devel@archiver.kernel.org; Fri, 08 Nov 2019 10:31:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49217)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berto@igalia.com>) id 1iT623-0004b0-N9
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 10:18:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berto@igalia.com>) id 1iT621-0004Kq-PW
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 10:18:39 -0500
Received: from fanzine.igalia.com ([178.60.130.6]:59192)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <berto@igalia.com>)
 id 1iT621-0004Bn-8O; Fri, 08 Nov 2019 10:18:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
 s=20170329; 
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From;
 bh=l93rntP3HCHNqNqdB9jqieWKGnMQtVheTV13gnehYj4=; 
 b=sp+k0UBBwIOQNX195h/uJ/MuL+6rnqwNuG7enslbAMPTTrC8MFHmAkmjVfkSKcOcapwB7TuEOfpNSmV4pbpl0XfG3KiND6+ESC10xmBQ+Kk4/urd72kJAJegPw8IB94DoGap9diy0/bWIFTa12Mf06mVlU3xLQ1ILdZKoaS8PZ9Nk9NcAn/Kb7/YejvtJb/a3IVQD9NK6iKr8+78EC0dit1aSB5jkO5X4zTj+jFpCN6Qz0ffTQIvoXKtwrDedXauPMlWxjJNyKSykNWW/VuBgS7VecJSNX5t6B0bnM4dHpQgs5zuMT/mRKvQM7tsrluiBGIoBk90FaayURZ0RJdQbA==;
Received: from maestria.local.igalia.com ([192.168.10.14] helo=mail.igalia.com)
 by fanzine.igalia.com with esmtps 
 (Cipher TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim)
 id 1iT61e-0000PC-0T; Fri, 08 Nov 2019 16:18:14 +0100
Received: from berto by mail.igalia.com with local (Exim)
 id 1iT61d-0008RA-UG; Fri, 08 Nov 2019 16:18:13 +0100
From: Alberto Garcia <berto@igalia.com>
To: Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [RFC PATCH v2 13/26] qcow2: Add subcluster support to
 calculate_l2_meta()
In-Reply-To: <5a45821e-564f-957e-5121-e11db318d214@redhat.com>
References: <cover.1572125022.git.berto@igalia.com>
 <4cf84e3126dc87486b19514c211d46941cdff243.1572125022.git.berto@igalia.com>
 <5a45821e-564f-957e-5121-e11db318d214@redhat.com>
User-Agent: Notmuch/0.18.2 (http://notmuchmail.org) Emacs/24.4.1
 (i586-pc-linux-gnu)
Date: Fri, 08 Nov 2019 16:18:13 +0100
Message-ID: <w51imnus8ga.fsf@maestria.local.igalia.com>
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

On Mon 04 Nov 2019 03:21:41 PM CET, Max Reitz wrote:
>> If an image has subclusters then there are more copy-on-write
>> scenarios that we need to consider. Let's say we have a write request
>> from the middle of subcluster #3 until the end of the cluster:
>>=20
>>    - If the cluster is new, then subclusters #0 to #3 from the old
>>      cluster must be copied into the new one.
>
> You mean for snapshots?
>
> (That isn=E2=80=99t quite clear, and I only guess this based on the next
> bullet point which differentiates based on =E2=80=9Cthe old cluster was
> unallocated=E2=80=9D.  That=E2=80=99s weird, too, because what does that =
mean, old
> cluster and new cluster?

Yes, perhaps the terminology is a bit unclear.

When I say "new cluster" is this context I mean that a write request
requires that a new cluster is allocated in the qcow2 file.

Then the "old cluster" would be what was there before the write (i.e. a
cluster with refcount > 1 or an unallocated cluster). Where we are doing
the copy-on-write from.

>>   * If @keep_old is true it means that the clusters were already
>>   * allocated and will be overwritten. If false then the clusters are
>>   * new and we have to decrease the reference count of the old ones.
>> + *
>> + * Returns 1 on success, -errno on failure.
>
> I think there should be a note here on why this doesn=E2=80=99t follow the
> general 0/-errno schema (i.e., =E2=80=9C, because that is what callers ge=
nerally
> expect=E2=80=9D).

Good idea.

>> +    if (!keep_old) {
>> +        switch (type) {
>> +        case QCOW2_CLUSTER_NORMAL:
>> +        case QCOW2_CLUSTER_COMPRESSED:
>> +        case QCOW2_CLUSTER_ZERO_ALLOC:
>> +        case QCOW2_CLUSTER_UNALLOCATED_SUBCLUSTER:
>> +            cow_start_from =3D 0;
>
> Somehow (I don=E2=80=99t know why) I find this a bit tough to understand.
>
> Wouldn=E2=80=99t it work to let cow_start start from the first subcluster=
 for
> ZERO_ALLOC and UNALLOCATED_SUBCLUSTER?  We don=E2=80=99t need to COW thos=
e, it
> should be sufficient to just make the subclusters before that zero or
> unallocated, respectively.

Here's one good example why I should probably add a QCow2SubclusterType
different from the existing QCow2ClusterType.

In this context, 'type' is the type of the subcluster, and because of
that _ZERO_ALLOC means that the subcluster reads as zeros but the
cluster itself is allocated. Other subcluster may contain data and
that's why we have to copy all of them.

Berto

