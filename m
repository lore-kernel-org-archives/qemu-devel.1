Return-Path: <SRS0=zL9l=BA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 276D9C433E3
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2020 14:29:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E820920714
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2020 14:29:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fEQ4UGhy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E820920714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50104 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jxtHE-0007w6-5R
	for qemu-devel@archiver.kernel.org; Tue, 21 Jul 2020 10:29:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33402)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jxtGE-0006fE-Au
 for qemu-devel@nongnu.org; Tue, 21 Jul 2020 10:28:50 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:44051
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jxtGB-0004TS-LC
 for qemu-devel@nongnu.org; Tue, 21 Jul 2020 10:28:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595341722;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=k3KfV3j5Vp1n0D93cbzgqvyrEcCNh90Bo6e3qprwoxU=;
 b=fEQ4UGhyhZ2QrE3ar4MQJjOYndm3B8CJVi9Ois8gRKIV/oAhe+UraMs9+7M0ztjSKRC3gj
 ayWWaoC3W5AkZpsC0czc8UbAmIs2pqU80vHXoDYcWdseaLdXh6Gsu9XFWCdAoGFbt+uAwK
 A8NfPuTkLCLneU0Q++vdHvLqwouWWQ0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-247-XDGSt-RcNDiWBCvq8O4ETw-1; Tue, 21 Jul 2020 10:28:40 -0400
X-MC-Unique: XDGSt-RcNDiWBCvq8O4ETw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2B0EA1083FA2;
 Tue, 21 Jul 2020 14:28:39 +0000 (UTC)
Received: from linux.fritz.box (ovpn-113-97.ams2.redhat.com [10.36.113.97])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B1ECC5DA30;
 Tue, 21 Jul 2020 14:28:37 +0000 (UTC)
Date: Tue, 21 Jul 2020 16:28:36 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: Re: [PATCH for-5.1 v2 1/2] qcow2: Implement v2 zero writes with
 discard if possible
Message-ID: <20200721142836.GD18481@linux.fritz.box>
References: <20200721135520.72355-1-kwolf@redhat.com>
 <20200721135520.72355-2-kwolf@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200721135520.72355-2-kwolf@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/21 10:15:27
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: nsoffer@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 21.07.2020 um 15:55 hat Kevin Wolf geschrieben:
> qcow2 version 2 images don't support the zero flag for clusters, so for
> write_zeroes requests, we return -ENOTSUP and get explicit zero buffer
> writes. If the image doesn't have a backing file, we can do better: Just
> discard the respective clusters.
> 
> This is relevant for 'qemu-img convert -O qcow2 -n', where qemu-img has
> to assume that the existing target image may contain any data, so it has
> to write zeroes. Without this patch, this results in a fully allocated
> target image, even if the source image was empty.
> 
> Reported-by: Nir Soffer <nsoffer@redhat.com>
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>

Oops, forgot to apply this from v1:

Reviewed-by: Max Reitz <mreitz@redhat.com>

The patch is unchanged, so I'll include this when applying.

Kevin


