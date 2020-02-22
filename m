Return-Path: <SRS0=sqIQ=4K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 007C1C35671
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Feb 2020 18:00:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C65C0206ED
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Feb 2020 18:00:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="TS0G6dM6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C65C0206ED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44828 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j5Z5D-0002JW-Tq
	for qemu-devel@archiver.kernel.org; Sat, 22 Feb 2020 13:00:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43405)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berto@igalia.com>) id 1j5Z4R-0001gm-Ua
 for qemu-devel@nongnu.org; Sat, 22 Feb 2020 13:00:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berto@igalia.com>) id 1j5Z4Q-0005zm-Ie
 for qemu-devel@nongnu.org; Sat, 22 Feb 2020 13:00:07 -0500
Received: from fanzine.igalia.com ([178.60.130.6]:58353)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <berto@igalia.com>)
 id 1j5Z4P-0005Nu-Td; Sat, 22 Feb 2020 13:00:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
 s=20170329; 
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From;
 bh=JsLOu4wJ76EecrvPcZK6r+a5N1fiJj2smoQjK98KzZ4=; 
 b=TS0G6dM6rFuUKBKjesVyJnvWBmk+QaCOUzRwPvLkEY8aQ8Wwja+3KWu1MHpj8rN54V+UKdS6Bwbc/uKyQHKY7z2/3x4kdvgoA2vzk+NIbeg4hLWypkZddEHtLek9IX5cCOEDENXsSWtm2CysEoIa2y1x6M3zJL3NEHt7+aFG5Dpu4ZUQL8XxkoHhjHuwcYOy0y2WZTY5rBXYo/wclh+gQ3QG8ociy377qd4KuUWzmd3uDFXCvtD9LY8ex4COETar4DhuumZ9Iju1eVKTXN/oMrbkr/3SD/buNbxMPb4tIRbfsEUwfJ1p3zO/bWdnz0DTJLG8o0jL1goj0Te85HekdA==;
Received: from maestria.local.igalia.com ([192.168.10.14] helo=mail.igalia.com)
 by fanzine.igalia.com with esmtps 
 (Cipher TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim)
 id 1j5Z46-0002Sk-H8; Sat, 22 Feb 2020 18:59:46 +0100
Received: from berto by mail.igalia.com with local (Exim)
 id 1j5Z46-0001CN-7a; Sat, 22 Feb 2020 18:59:46 +0100
From: Alberto Garcia <berto@igalia.com>
To: Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [RFC PATCH v3 00/27] Add subcluster allocation to qcow2
In-Reply-To: <a425b6e6-be14-0cbc-4498-26c632faa6fd@redhat.com>
References: <cover.1577014346.git.berto@igalia.com>
 <a425b6e6-be14-0cbc-4498-26c632faa6fd@redhat.com>
User-Agent: Notmuch/0.18.2 (http://notmuchmail.org) Emacs/24.4.1
 (i586-pc-linux-gnu)
Date: Sat, 22 Feb 2020 18:59:46 +0100
Message-ID: <w51zhdawlil.fsf@maestria.local.igalia.com>
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

On Fri 21 Feb 2020 06:10:52 PM CET, Max Reitz wrote:

> So now I wonder on what your plans are after this series.

Apart from some fixes here and there, there are some things that I would
live to solve:

- I'm not 100% happy with the separation between QCow2ClusterType and
  QCow2SubclusterType. The former is a strict subset of the latter and
  doesn't carry any additional information, so I think there's no need
  to have both in the code. So I'm thinking to get rid of
  QCow2ClusterType altogether.

- We discussed this already, and related to the previous point, in most
  places where the (sub)cluster type is checked what we want to know is
  whether there is a valid host address, or whether the data reads as
  zeroes, etc. So one possibility is to make qcow2_get_subcluster_type()
  return status flags like the existing BDRV_BLOCK_DATA,
  BDRV_BLOCK_OFFSET_VALID, ... and check those ones instead. Some
  functions become less verbose with this kind of approach, but I'm not
  sure that it works so well with others.

- We also discussed this already, but qcow2_get_cluster_offset() returns
  an offset to the beginning of the cluster. This makes less sense when
  we start working at the subcluster level, but even at the moment the
  reality is that no one uses that offset. All callers use the final
  unaligned host offset. So I have a few patches that change that.

> Here are some things that come to my mind, and I wonder whether you
> plan to address them or whether there are more things to do still:
>
> - In v2, you had a patch for preallocation support with backing files.
> It didn=E2=80=99t quite work, which is why I think you dropped it for now=
 (why
> not, it isn=E2=80=99t crucial).

There was already a problem with preallocation and backing files (
https://lists.gnu.org/archive/html/qemu-block/2019-11/msg00691.html ) so
I decided to withdraw the patches for subclusters and reevaluate the
situation when that was sorted out.

> - There is a TODO on subcluster zeroing.

I'm not sure if I'll fix that now, but I'll give it a try when we all
are happy with the rest the patches and the general design.

> - I think adding support to amend for switching extended_l2 on or off
> would make sense.  But maybe it=E2=80=99s too complicated to be worth the
> effort.

I haven't thought about that, but it does sound too complicated to be
worth it.

> - As I noted in v2, I think it=E2=80=99d be great if it were possible to =
run
> the iotests with -o extended_l2=3Don.  But I suppose this kind of
> depends on me adding data_file support to the Python tests first...

Yes.

Berto

