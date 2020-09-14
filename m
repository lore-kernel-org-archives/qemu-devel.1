Return-Path: <SRS0=afRr=CX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17AA8C433E2
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 17:34:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 80A5020771
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 17:33:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g4HAUffj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80A5020771
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56698 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHsMY-0007qp-I1
	for qemu-devel@archiver.kernel.org; Mon, 14 Sep 2020 13:33:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47774)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kHsKz-0006W4-1k
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 13:32:21 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:41232
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kHsKw-0007ex-DN
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 13:32:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600104736;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=96+t0q8P+6kd6bgGrsMxi01aethB8Jg3R9JW9kS2wVg=;
 b=g4HAUffjGiODa+6lcf9KlGm2yRpwbE13aYx2FsJ0Fn8X0EYSmxbUbkbeqQxULZxP9XLgjs
 vx4tGCYUq29ThArG0QQOy2hJehZaLi7X6qsRyYpItulhGOw6HYFW7NqTJdviGxcTyHlF/V
 bzJDmT7TCijlfvmePVVvHMgWT/2UOLM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-246-4xgKEOG3ODKdGV1SVGontg-1; Mon, 14 Sep 2020 13:32:07 -0400
X-MC-Unique: 4xgKEOG3ODKdGV1SVGontg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2A5991005E7A;
 Mon, 14 Sep 2020 17:32:06 +0000 (UTC)
Received: from redhat.com (ovpn-114-99.ams2.redhat.com [10.36.114.99])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4A7301002D41;
 Mon, 14 Sep 2020 17:32:04 +0000 (UTC)
Date: Mon, 14 Sep 2020 18:32:01 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Nir Soffer <nirsof@gmail.com>
Subject: Re: [PATCH 2/2] block: file-posix: Replace posix_fallocate with
 fallocate
Message-ID: <20200914173201.GR1252186@redhat.com>
References: <20200831140127.657134-1-nsoffer@redhat.com>
 <20200831140127.657134-3-nsoffer@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200831140127.657134-3-nsoffer@redhat.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/14 02:33:07
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.792,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>, Nir Soffer <nsoffer@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Aug 31, 2020 at 05:01:27PM +0300, Nir Soffer wrote:
> If fallocate() is not supported, posix_fallocate() falls back to
> inefficient allocation, writing one byte for every 4k bytes[1]. This is
> very slow compared with writing zeros. In oVirt we measured ~400%
> improvement in allocation time when replacing posix_fallocate() with
> manually writing zeroes[2].
> 
> We also know that posix_fallocated() does not work well when using OFD
> locks[3]. We don't know the reason yet for this issue yet.
> 
> Change preallocate_falloc() to use fallocate() instead of
> posix_falloate(), and fall back to full preallocation if not supported.
> 
> Here are quick test results with this change.
> 
> Before (qemu-img-5.1.0-2.fc32.x86_64):
> 
> $ time qemu-img create -f raw -o preallocation=falloc /tmp/nfs3/test.raw 6g
> Formatting '/tmp/nfs3/test.raw', fmt=raw size=6442450944 preallocation=falloc
> 
> real 0m42.100s
> user 0m0.602s
> sys 0m4.137s
> 
> NFS stats:
> calls      retrans    authrefrsh    write
> 1571583    0          1572205       1571321
> 
> After:
> 
> $ time ./qemu-img create -f raw -o preallocation=falloc /tmp/nfs3/test.raw 6g
> Formatting '/tmp/nfs3/test.raw', fmt=raw size=6442450944 preallocation=falloc
> 
> real 0m15.551s
> user 0m0.070s
> sys 0m2.623s
> 
> NFS stats:
> calls      retrans    authrefrsh    write
> 24620      0          24624         24567  
> 
> [1] https://code.woboq.org/userspace/glibc/sysdeps/posix/posix_fallocate.c.html#96
> [2] https://bugzilla.redhat.com/1850267#c25
> [3] https://bugzilla.redhat.com/1851097

This bug appears to be private to RH employees only, so rather than link
to it, please summarize any important facts in it for benefit of nonn-RH
QEMU contributors.

> 
> Signed-off-by: Nir Soffer <nsoffer@redhat.com>
> ---
>  block/file-posix.c                     | 32 +++++++++-----------------
>  docs/system/qemu-block-drivers.rst.inc | 11 +++++----
>  docs/tools/qemu-img.rst                | 11 +++++----
>  qapi/block-core.json                   |  4 ++--
>  4 files changed, 25 insertions(+), 33 deletions(-)

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


