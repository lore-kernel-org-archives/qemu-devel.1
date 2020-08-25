Return-Path: <SRS0=2GMi=CD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38D3EC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 14:54:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E74C72075F
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 14:54:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="azy6H77P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E74C72075F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52560 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAaKr-000685-TT
	for qemu-devel@archiver.kernel.org; Tue, 25 Aug 2020 10:54:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50058)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kAaJs-0004fu-O2
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 10:53:04 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:57624
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kAaJp-0000jz-IE
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 10:53:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598367178;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Rnn9zZwhYZQ99kPoM4iUmNpph/60qOHrkcZYyiemcLU=;
 b=azy6H77PvlCwLqB3AtkZjBg5H60M6oZJB6H9ISFEn2sE9aCN2GmIy+vkFtf3b0itToqK07
 JnDoLQ/95HPgELtBIXOrGFME165Z7hBl93K7NOjHxpt2GalEoLU3s+r51LDXcY+rcgMMgC
 rPXYQH2MACAWSMPLjX+li0S+s0wZWpI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-449-TL7naBWOMGyRsNWO0pZTWw-1; Tue, 25 Aug 2020 10:52:54 -0400
X-MC-Unique: TL7naBWOMGyRsNWO0pZTWw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 319FD85C706;
 Tue, 25 Aug 2020 14:52:53 +0000 (UTC)
Received: from localhost (ovpn-113-101.ams2.redhat.com [10.36.113.101])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B90CD5D9CA;
 Tue, 25 Aug 2020 14:52:52 +0000 (UTC)
Date: Tue, 25 Aug 2020 15:52:50 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: wanghonghao <wanghonghao@bytedance.com>
Subject: Re: [PATCH 2/2] coroutine: take exactly one batch from global pool
 at a time
Message-ID: <20200825145250.GB7124@stefanha-x1.localdomain>
References: <20200824043121.13421-1-wanghonghao@bytedance.com>
 <20200824043121.13421-2-wanghonghao@bytedance.com>
MIME-Version: 1.0
In-Reply-To: <20200824043121.13421-2-wanghonghao@bytedance.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0.0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="oC1+HKm2/end4ao3"
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=stefanha@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/25 01:37:44
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.958,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: kwolf@redhat.com, pbonzini@redhat.com, fam@euphon.net,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--oC1+HKm2/end4ao3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 24, 2020 at 12:31:21PM +0800, wanghonghao wrote:
> This patch replace the global coroutine queue with a lock-free stack of w=
hich
> the elements are coroutine queues. Threads can put coroutine queues into =
the
> stack or take queues from it and each coroutine queue has exactly
> POOL_BATCH_SIZE coroutines. Note that the stack is not strictly LIFO, but=
 it's
> enough for buffer pool.
>=20
> Coroutines will be put into thread-local pools first while release. Now t=
he
> fast pathes of both allocation and release are atomic-free, and there won=
't
> be too many coroutines remain in a single thread since POOL_BATCH_SIZE ha=
s been
> reduced to 16.
>=20
> In practice, I've run a VM with two block devices binding to two differen=
t
> iothreads, and run fio with iodepth 128 on each device. It maintains arou=
nd
> 400 coroutines and has about 1% chance of calling to `qemu_coroutine_new`
> without this patch. And with this patch, it maintains no more than 273
> coroutines and doesn't call `qemu_coroutine_new` after initial allocation=
s.

Does throughput or IOPS change?

Is the main purpose of this patch to reduce memory consumption?

Stefan

--oC1+HKm2/end4ao3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl9FJcIACgkQnKSrs4Gr
c8ieKAf/XJgilV5dUd/Dk+/gv5Y36ICzC3FTsDVUlafMCVpVUn8G6HO6mdxdmzVy
fBKoz6654+tLk2AJbrgvhi9g3sNseVy16J94tn04QS9DIG06ybpWgfpILu13pltX
xpSeGYfZUXreyUgsob4vg14uilapVhHjw+zIGmA6VV00XlSoXEerLkgLNsThvDqF
TkAHT2uB98RUSTNGOXFmFJTmf/t6v8AvfggYbYUPKrDhiEOR3E2gU00N8kT9gPEP
DQhE0pKtMZEK5aJOiA64eNUQyA8+8DbjlsO4ZxNG3hr++TzBxkmf6WC9zWaC1Qiq
0xOA/5/f+JW0dnnuvfed7wN6witVJg==
=N2Vo
-----END PGP SIGNATURE-----

--oC1+HKm2/end4ao3--


