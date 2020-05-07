Return-Path: <SRS0=s5cl=6V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDB90C38A24
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 08:40:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8248D2078C
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 08:40:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fJXnPX/3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8248D2078C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45864 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWc5C-0007VK-OM
	for qemu-devel@archiver.kernel.org; Thu, 07 May 2020 04:40:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50652)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jWc45-0006dM-9v
 for qemu-devel@nongnu.org; Thu, 07 May 2020 04:39:33 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:57179
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jWc43-0005fH-Vz
 for qemu-devel@nongnu.org; Thu, 07 May 2020 04:39:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588840769;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CIxq2Hx0IXzi5mkrMoVHdt8FBm10jW3l2WSbK13g4C8=;
 b=fJXnPX/3hw69fvK/KeLaSHK8Vbf89T/hbXG5ge/qTOlKwkWo4eusuqXojS2qjXB7rk0zt3
 Kcexs1pmitxcqDG48v8AtSZrT3KQArCdodrl6rLmD1GhMNp2oNpI0SsHM1J5rYadtdHuEj
 bt3nEGObCt9kRC7B56/XPZIcv3hUBzw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-35-OUs_WOoXOnmm2_KV8XP7eg-1; Thu, 07 May 2020 04:39:27 -0400
X-MC-Unique: OUs_WOoXOnmm2_KV8XP7eg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BCB15461;
 Thu,  7 May 2020 08:39:26 +0000 (UTC)
Received: from linux.fritz.box (ovpn-113-33.ams2.redhat.com [10.36.113.33])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id EC19E62A9C;
 Thu,  7 May 2020 08:39:25 +0000 (UTC)
Date: Thu, 7 May 2020 10:39:24 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Max Reitz <mreitz@redhat.com>
Subject: Re: [PATCH] qcow2: Fix preallocation on block devices
Message-ID: <20200507083924.GA6019@linux.fritz.box>
References: <20200505141801.1096763-1-mreitz@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200505141801.1096763-1-mreitz@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/07 00:55:34
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
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 05.05.2020 um 16:18 hat Max Reitz geschrieben:
> Calling bdrv_getlength() to get the pre-truncate file size will not
> really work on block devices, because they have always the same length,
> and trying to write beyond it will fail with a rather cryptic error
> message.
>=20
> Instead, we should use qcow2_get_last_cluster() and bdrv_getlength()
> only as a fallback.
>=20
> Before this patch:
> $ truncate -s 1G test.img
> $ sudo losetup -f --show test.img
> /dev/loop0
> $ sudo qemu-img create -f qcow2 -o preallocation=3Dfull /dev/loop0 64M
> Formatting '/dev/loop0', fmt=3Dqcow2 size=3D67108864 cluster_size=3D65536
> preallocation=3Dfull lazy_refcounts=3Doff refcount_bits=3D16
> qemu-img: /dev/loop0: Could not resize image: Failed to resize refcount
> structures: No space left on device
>=20
> With this patch:
> $ sudo qemu-img create -f qcow2 -o preallocation=3Dfull /dev/loop0 64M
> Formatting '/dev/loop0', fmt=3Dqcow2 size=3D67108864 cluster_size=3D65536
> preallocation=3Dfull lazy_refcounts=3Doff refcount_bits=3D16
> qemu-img: /dev/loop0: Could not resize image: Failed to resize
> underlying file: Preallocation mode 'full' unsupported for this
> non-regular file
>=20
> So as you can see, it still fails, but now the problem is missing
> support on the block device level, so we at least get a better error
> message.
>=20
> Note that we cannot preallocate block devices on truncate by design,
> because we do not know what area to preallocate.  Their length is always
> the same, the truncate operation does not change it.
>=20
> Signed-off-by: Max Reitz <mreitz@redhat.com>

Thanks, applied to the block branch.

Kevin


