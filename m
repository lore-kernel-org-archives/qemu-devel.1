Return-Path: <SRS0=8N/K=Z4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34608C43603
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 16:21:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F300E206DF
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 16:21:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EU2GvkQg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F300E206DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40696 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1idGLp-00070K-2d
	for qemu-devel@archiver.kernel.org; Fri, 06 Dec 2019 11:21:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52094)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pkrempa@redhat.com>) id 1idExg-0006bO-CB
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 09:52:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pkrempa@redhat.com>) id 1idExe-0003Fy-TK
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 09:52:04 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:34463
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pkrempa@redhat.com>) id 1idExe-0003EV-PE
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 09:52:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575643922;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nBid/zYBzZZU2LQ5CgJZpPKteEOudWCDEageNwftzcs=;
 b=EU2GvkQgExx+U1dJtlKTXbxBwr+kqNaTPsxPCJgAV3t1gj5R4wqflgifoHqPXRQt3zJses
 rdvBDWu5ibwn+E9xYusVdAJR0TSlWkSK82pnJXoyrNfWutGyvPzqBG7D5LtbW1penqadQd
 CjSA/vQQ+SR5axUk/spLZ0J1uUmMb64=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-179-9wnGehJBOCKgrWDPjekNJg-1; Fri, 06 Dec 2019 04:49:57 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3A93A1005502;
 Fri,  6 Dec 2019 09:49:56 +0000 (UTC)
Received: from angien.pipo.sk (unknown [10.43.2.48])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3831667E52;
 Fri,  6 Dec 2019 09:49:49 +0000 (UTC)
Date: Fri, 6 Dec 2019 10:49:47 +0100
From: Peter Krempa <pkrempa@redhat.com>
To: John Snow <jsnow@redhat.com>
Subject: Re: [libvirt] Offline manipulation of Dirty Bitmaps by qemu-img
Message-ID: <20191206094947.GD2441258@angien.pipo.sk>
References: <4a9e19d1-fe87-e3f5-8faf-18127914b7b4@redhat.com>
MIME-Version: 1.0
In-Reply-To: <4a9e19d1-fe87-e3f5-8faf-18127914b7b4@redhat.com>
X-PGP-Key-ID: 0xD018682B
X-PGP-Key-Fingerprint: D294 FF38 A6A2 BF40 6C75  5DEF 36EC 16AC D018 682B
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: 9wnGehJBOCKgrWDPjekNJg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Qemu-block <qemu-block@nongnu.org>, qemu-devel <qemu-devel@nongnu.org>,
 libvirt-list@redhat.com, Nir Soffer <nsoffer@redhat.com>,
 "Denis V. Lunev" <den@openvz.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Dec 05, 2019 at 17:37:11 -0500, John Snow wrote:
> This has come up in the past, and I believe we discussed this at KVM
> Forum, too:
>=20
> There have been requests from oVirt (via Nir Soffer) to add some offline
> bitmap manipulation functionality. In the past, our stance has generally
> been "Use QEMU without an accelerator, and use QMP to manipulate the
> images."

This is a thing I wanted to do for a long time but never had time for.
I'm not sure whether that will change though.

We have a workaround for this tough: you can start the VM with CPUs
stopped:

virsh start --pause $VMNAME=20

(That translates to VIR_DOMAIN_START_PAUSED flag for
virDomainCreateWithFlags).

You can then use any libvirt API which requires a running VM including
blockjobs checkpoints etc.

The VM then can be destroyed. Since the CPUs didn't run the guest
visible image content was nott modified.

Alternatively to make this slightly more official we could introduce a
new flag for the VM starting API which will actually start the VM in the
no-machine mode, will interlock certain operations such as resuming of
the execution or migration perhaps  and the official purpose will be to
allow complex blockjobs without starting the actual VM.

Since starting an actual VM will be impossible anyways until such a VM
is gone it might be a sane thing to do here.

> We like this for a few reasons:
>=20
> 1. It keeps bitmap management code tightly centralized
> 2. It allows for the full suite of bitmap manipulations in either
> offline or online mode with one tool
> 3. We wouldn't have to write new code.
> 4. Or design new CLIs and duplicate our existing work.
> 5. Or write even more tests.

In libvirt we'd like to use it because qemu-img has no reasonable
progress reporting and we could reuse the code we have for interacting
with the jobs when the VM is running.

> However, tools like oVirt may or may not be fully equipped to launch
> QEMU in this context, and there is always a desire for qemu-img to be
> able to "do more", so existing management suites could extend
> functionality more easily.
>
> (Or so I am imagining.)
>=20
> I am still leaning heavily against adding any more CLI commands or
> options to qemu-img right now. Even if we do add some of the fundamental
> ones like "add" or "remove", it seems only a matter of time before we
> have to add "clear", "merge", etc. Is this just a race to code duplicatio=
n?
>=20
> On the other hand, one of the other suggestions is to have qemu-img
> check --repair optionally delete corrupted bitmaps. I kind of like this
> idea: it's a buyer beware operation that might make management layers
> unhappy, but then again ... repair is always something that could make
> things worse.

Well, dealing with corrupted bitmaps will be possible. I plan to expose
in the checkpoint XML whether a ckeckpoint is invalid (if it contains at
least one corrupted bitmap) and the user will have the option to delete
all previous checkpoints including the corrupted one to clear any
problem.

Note that deleting only the corrupted checkpoint will not be possible
until it's the oldest one as we attempt to merge them into the previous
ones. We could alternatively add a flag to skip merging of the invalid
checkpoint.

> Plus, if you manage to corrupt bitmaps badly enough that they can't even
> be parsed, you might need a heavyweight repair operation.
>=20
> Nir, do you think that'd be sufficient for your needs for now, or would
> you still like to see more granular offline management?
>=20
> --js
>=20
> --
> libvir-list mailing list
> libvir-list@redhat.com
> https://www.redhat.com/mailman/listinfo/libvir-list


