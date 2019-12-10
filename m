Return-Path: <SRS0=2P1T=2A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6903C43603
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2019 10:11:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8099A2073D
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2019 10:11:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IFv3KDgH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8099A2073D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52848 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iecUm-0004JD-Jd
	for qemu-devel@archiver.kernel.org; Tue, 10 Dec 2019 05:11:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38038)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1iecU7-0003Zd-5u
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 05:11:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1iecU4-0006Kw-E6
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 05:11:13 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:24473
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1iecU4-0006Kk-0B
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 05:11:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575972670;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BpUUqUY5N2BC9WX32+SK1zdbNARsC8lMI1FiDmh/c60=;
 b=IFv3KDgHlu4zd09OKmnYQ5XnhPyuMjiWSqvZrwvogggNM0w3SKPQB8m8ph8N3Hs004s27d
 ystswNsN/g+8O5x4Fng2Hf83znaWETS4xjBw9T8TB2iZduP1EufeEUrM6T46n033ihlKEL
 lPS+xfBAFLwP9H2vYNDilD5+EVd4j70=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-30-Mjl8MsPiNzKA0PLrfwfiAw-1; Tue, 10 Dec 2019 05:11:09 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 18E27107ACC4;
 Tue, 10 Dec 2019 10:11:08 +0000 (UTC)
Received: from gondolin (dhcp-192-245.str.redhat.com [10.33.192.245])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 763775C1B0;
 Tue, 10 Dec 2019 10:11:04 +0000 (UTC)
Date: Tue, 10 Dec 2019 11:11:02 +0100
From: Cornelia Huck <cohuck@redhat.com>
To: Richard Henderson <rth@twiddle.net>, David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v2] s390x/tcg: clear local interrupts on reset normal
Message-ID: <20191210111102.21215254.cohuck@redhat.com>
In-Reply-To: <20191206135404.16051-1-cohuck@redhat.com>
References: <20191206135404.16051-1-cohuck@redhat.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: Mjl8MsPiNzKA0PLrfwfiAw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri,  6 Dec 2019 14:54:04 +0100
Cornelia Huck <cohuck@redhat.com> wrote:

> We neglected to clean up pending interrupts and emergency signals;
> fix that.
> 
> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> ---
> 
> v1->v2:
> - rebased on top of my s390-next branch; we can now move the fields
>   to be reset instead of clearing them manually
> 
> Further cleanup possible in a follow-up patch.
> 
> ---
>  target/s390x/cpu.h | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Queued to s390-next.


