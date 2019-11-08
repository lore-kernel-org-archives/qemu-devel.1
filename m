Return-Path: <SRS0=73np=ZA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BBD6C5DF60
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 15:44:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 986CC21882
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 15:44:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="BbvXJoR5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 986CC21882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56560 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iT6RG-0000QS-UV
	for qemu-devel@archiver.kernel.org; Fri, 08 Nov 2019 10:44:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53370)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berto@igalia.com>) id 1iT6PC-0007Hk-SO
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 10:42:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berto@igalia.com>) id 1iT6PA-0000j3-4d
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 10:42:34 -0500
Received: from fanzine.igalia.com ([178.60.130.6]:47372)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <berto@igalia.com>)
 id 1iT6P9-0000hq-SC; Fri, 08 Nov 2019 10:42:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
 s=20170329; 
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From;
 bh=FvYcp3uc0deWfNrYF2v+QHECyFzOCJtqx2LIrsSBts8=; 
 b=BbvXJoR5iv/bh5PESbfdFOYnSrKIiDhC8CR7e60OdxaizS7wB1GBcSW3EgAPsJnjXmBAEMnDrbUKrWeSi5XmZnJ/JMwN/u/QzaPL0EOY54bLREdDU23rZZlvfy9Eie4O0bEjaYqSwQ7nesLhYFwQmflOWQmNmDIunF03DfMN0C/l67gHVji3LGVXQ6qvBklrpQm3jrIKG55bQV+kjosJ/OHFefwvrF3/xDjcSYJFdPSbegVUpgl/MyUOrWcBIhtRyjqZ8jgUfHqcISJGLWVAIdahWTzrF4KgKD6PeNvzV3AmgAG1zD1l8dtvSamPCBs32GpIwZixYiMpcuBagT+A5A==;
Received: from maestria.local.igalia.com ([192.168.10.14] helo=mail.igalia.com)
 by fanzine.igalia.com with esmtps 
 (Cipher TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim)
 id 1iT6P6-0002jj-N0; Fri, 08 Nov 2019 16:42:28 +0100
Received: from berto by mail.igalia.com with local (Exim)
 id 1iT6P6-0006j0-KT; Fri, 08 Nov 2019 16:42:28 +0100
From: Alberto Garcia <berto@igalia.com>
To: Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [RFC PATCH v2 14/26] qcow2: Add subcluster support to
 qcow2_get_cluster_offset()
In-Reply-To: <673d72da-bf8c-3ffb-a324-79e93f88a140@redhat.com>
References: <cover.1572125022.git.berto@igalia.com>
 <6932c2ddfe19a564cad7c54246290e166525fc46.1572125022.git.berto@igalia.com>
 <673d72da-bf8c-3ffb-a324-79e93f88a140@redhat.com>
User-Agent: Notmuch/0.18.2 (http://notmuchmail.org) Emacs/24.4.1
 (i586-pc-linux-gnu)
Date: Fri, 08 Nov 2019 16:42:28 +0100
Message-ID: <w51ftiys7bv.fsf@maestria.local.igalia.com>
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

On Mon 04 Nov 2019 03:58:57 PM CET, Max Reitz wrote:
> OTOH, what I don=E2=80=99t like so far about this series is that the =E2=
=80=9Ccluster
> logic=E2=80=9D is still everywhere when I think it should just be about
> subclusters now.  (Except in few places where it must be about
> clusters as in something that can have a distinct host offset and/or
> has an own L2 entry.)  So maybe the parameter should really be
> @nb_subclusters.

> But I=E2=80=99m not sure.  For how this function is written right now, it
> makes sense for it to be @nb_clusters, but I think it could be changed
> so it would work with @nb_subclusters, too.

I'm still reviewing your (much appreciated) feedback, but one thing I
can tell you is that my initial versions were doing everything with
subclusters because of the reasons you mention (i.e. there was
@nb_subclusters and all that).

Later when I started to tidy things up I realized that most of those
places only needed the number of clusters after all, and in some cases
the necessary changes were really minimal (like in handle_copied()).

>> +static int count_contiguous_subclusters(BlockDriverState *bs, int nb_cl=
usters,
>> +                                        unsigned sc_index, uint64_t *l2=
_slice,
>> +                                        int l2_index)
>>  {
   /* ... */
>> +    if (type =3D=3D QCOW2_CLUSTER_COMPRESSED) {
>> +        return 1; /* Compressed clusters are always counted one by one =
*/
>
> Hm, yes, but cluster by cluster, not subcluster by subcluster, so this
> should be s->subclusters_per_cluster, and perhaps sc_index should be
> asserted to be 0.  (Or it should be s->subclusters_per_cluster -
> sc_index.)

Right, that's a bug, it forces the caller to decompress the cluster 32
times in order to read it completely! Thanks!

(in reality this is not used because this function doesn't get called
for compressed clusters but the same problem happens in the calling
function, as you correctly point out. Maybe I should assert here
instead)

>> @@ -514,8 +499,8 @@ int qcow2_get_cluster_offset(BlockDriverState *bs, u=
int64_t offset,
>
> I suppose this is get_subcluster_offset now.

Hmmm no, this returns the actual host cluster offset, then the caller
uses offset_into_cluster() to get the final value (which doesn't need to
be subcluster-aligned anyway).

Berto

