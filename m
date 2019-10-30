Return-Path: <SRS0=68uo=YX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4759CA9EC5
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Oct 2019 16:08:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 97BDE21835
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Oct 2019 16:08:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="hs0QRuVJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97BDE21835
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42310 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iPqWC-0002VK-Ku
	for qemu-devel@archiver.kernel.org; Wed, 30 Oct 2019 12:08:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50863)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berto@igalia.com>) id 1iPqQJ-0004Yf-Du
 for qemu-devel@nongnu.org; Wed, 30 Oct 2019 12:02:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berto@igalia.com>) id 1iPqQI-0007FJ-65
 for qemu-devel@nongnu.org; Wed, 30 Oct 2019 12:02:15 -0400
Received: from fanzine.igalia.com ([178.60.130.6]:53601)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <berto@igalia.com>)
 id 1iPqQH-0006yc-J4; Wed, 30 Oct 2019 12:02:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
 s=20170329; 
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From;
 bh=w7DSZUNl5JVfQsIZkENlD4zKfSckHtLnbUeBTSYpV9Q=; 
 b=hs0QRuVJRqDK39vkFZAcBCuitL6kVeKNAgiUanAWQ0jjtL/W6UPWPiCxfEhw4xTxUC8pP6nYUJJMmeOuyK2H4uxG03Vp/B9hoAvBCO+lQFHysr8OW1nmKpfrs2LjArYBoEYyLe6a20d+R4fayB2wYkgb+mtxMcjhGnxxPiJR9vHumLNTJObEnV3NTxMNHbH4UXrQC7yF1W6zHEHujAovrcmgKRXQBfdW6JJ65S7F1CiW5NtUPbfLLQTSJjlEys29g5tXvfcfYMjrHU9ADt1dnysN3QPIzw+kBzOzI75bGJgPBLa9MM8DPouCz4EhPdXu88qxrZmZtKbgn0CH46ahVw==;
Received: from maestria.local.igalia.com ([192.168.10.14] helo=mail.igalia.com)
 by fanzine.igalia.com with esmtps 
 (Cipher TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim)
 id 1iPqQC-0004AS-Pg; Wed, 30 Oct 2019 17:02:08 +0100
Received: from berto by mail.igalia.com with local (Exim)
 id 1iPqQC-00080K-NN; Wed, 30 Oct 2019 17:02:08 +0100
From: Alberto Garcia <berto@igalia.com>
To: Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [RFC PATCH v2 01/26] qcow2: Add calculate_l2_meta()
In-Reply-To: <49444fb1-d0b2-4325-20ed-91159182ed37@redhat.com>
References: <cover.1572125022.git.berto@igalia.com>
 <22820af5867124e4fdf3d0cb74b99f31edc1b37f.1572125022.git.berto@igalia.com>
 <49444fb1-d0b2-4325-20ed-91159182ed37@redhat.com>
User-Agent: Notmuch/0.18.2 (http://notmuchmail.org) Emacs/24.4.1
 (i586-pc-linux-gnu)
Date: Wed, 30 Oct 2019 17:02:08 +0100
Message-ID: <w51y2x2b4sf.fsf@maestria.local.igalia.com>
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

On Wed 30 Oct 2019 01:04:02 PM CET, Max Reitz wrote:
> (I intended not to comment on such things on an RFC, but here I am...)

No problem with that :-)

> I=E2=80=99d call it host_cluster_offset to make clear that it points to a
> cluster and isn=E2=80=99t the host offset for @guest_offset.

Sure, why not. We can also accept the exact offset within the cluster
and then use start_of_cluster(), but I prefer this one.

> And now that I=E2=80=99ve gone this far already, I might as well say that=
 I=E2=80=99d
> like if it the comment noted that this function not only creates the
> L2Meta structure but also adds it to the cluster_allocs list.

I'll update the comment.

>> + * @guest_offset and @bytes indicate the offset and length of the
>> + * request.
>> + *
>> + * If @keep_old is true it means that the clusters were already
>> + * allocated and will be overwritten. If false then the clusters are
>> + * new and we have to decrease the reference count of the old ones.
>> + */
>> +static void calculate_l2_meta(BlockDriverState *bs, uint64_t host_offse=
t,
>> +                              uint64_t guest_offset, uint64_t bytes,
>
> And now I=E2=80=99m so deep into non-RFC-level review territory, I might =
as
> well say I=E2=80=99d prefer @bytes to be an unsigned (or maybe even a pla=
in
> int), because anything more wouldn=E2=80=99t work.  (Not least because
> cow_end_to is an unsigned).

True, I'll correct that too.

Thanks!

Berto

