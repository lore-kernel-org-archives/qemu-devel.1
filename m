Return-Path: <SRS0=xKpV=2I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5769BC43603
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 11:48:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 227DA21582
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 11:48:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f7Xq50bx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 227DA21582
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53014 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihXol-0004ss-BI
	for qemu-devel@archiver.kernel.org; Wed, 18 Dec 2019 06:48:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39817)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1ihXnr-00046m-Ce
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 06:47:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1ihXno-000871-JH
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 06:47:41 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:32243
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1ihXno-00082l-Dg
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 06:47:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576669659;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JkKzgVFviV1oz05kvLpRwSq9YD/v5ZWhz3u6FbmBZew=;
 b=f7Xq50bxwfP7qKA965LfDuXYVFc3xzjPrnGjIRK1f1zfGtNkESVyZh1pLV5nn+ZJ/QSp0J
 HVdVYba0w+C+ZPmtHA5qlywTncDQJNoC9V/MX18codjRLgNjO+H3ax/ba6p5oGbzanbWZz
 H3rWu/7M/ViDdAzohmVNzGqGZG7P1Qc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-360-Ck1lbBNSMfqfU1-LRK45iA-1; Wed, 18 Dec 2019 06:47:36 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7AF8E800D48;
 Wed, 18 Dec 2019 11:47:35 +0000 (UTC)
Received: from gondolin (ovpn-117-253.ams2.redhat.com [10.36.117.253])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 719666888A;
 Wed, 18 Dec 2019 11:47:34 +0000 (UTC)
Date: Wed, 18 Dec 2019 12:47:31 +0100
From: Cornelia Huck <cohuck@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH] tests/boot-sector: Fix the bad s390x assembler code
Message-ID: <20191218124731.24799ddf.cohuck@redhat.com>
In-Reply-To: <20191217150642.27946-1-thuth@redhat.com>
References: <20191217150642.27946-1-thuth@redhat.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: Ck1lbBNSMfqfU1-LRK45iA-1
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
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org,
 Janosch Frank <frankja@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 17 Dec 2019 16:06:42 +0100
Thomas Huth <thuth@redhat.com> wrote:

> There are currently two bugs in s390x_code[]: First, the initial jump
> uses the wrong offset, so it was jumping to 0x1014 instead of 0x1010.
> Second, LHI only loads the lower 32-bit of the register.
> 
> Everything worked fine as long as the s390-ccw bios code was jumping
> here with r3 containing zeroes in the uppermost 48 bit - which just
> happened to be the case so far by accident. But we can not rely on this
> fact, and indeed one of the recent suggested patches to jump2ipl.c cause
> the newer GCCs to put different values into r3. In that case the code
> from s390x_code[] crashes very ungracefully.
> 
> Thus let's make sure to jump to the right instruction, and use LGHI
> instead of LHI to make sure that we always zero out the upper bits
> of the register.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  tests/boot-sector.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tests/boot-sector.c b/tests/boot-sector.c
> index 7824286b9a..9e66c6d013 100644
> --- a/tests/boot-sector.c
> +++ b/tests/boot-sector.c
> @@ -75,11 +75,11 @@ static const uint8_t s390x_psw_and_magic[] = {
>      0x40, 0x40, 0x40, 0x40, 0x40, 0x40, 0x40, 0x40   /* in the s390-ccw bios */
>  };
>  static const uint8_t s390x_code[] = {
> -    0xa7, 0xf4, 0x00, 0x0a,                                /* j 0x10010 */
> +    0xa7, 0xf4, 0x00, 0x08,                                /* j 0x10010 */
>      0x00, 0x00, 0x00, 0x00,
>      'S', '3', '9', '0',
>      'E', 'P', 0x00, 0x01,
> -    0xa7, 0x38, HIGH(SIGNATURE_ADDR), LOW(SIGNATURE_ADDR), /* lhi r3,0x7c10 */
> +    0xa7, 0x39, HIGH(SIGNATURE_ADDR), LOW(SIGNATURE_ADDR), /* lghi r3,0x7c10 */
>      0xa7, 0x48, LOW(SIGNATURE), HIGH(SIGNATURE),           /* lhi r4,0xadde */
>      0x40, 0x40, 0x30, 0x00,                                /* sth r4,0(r3) */
>      0xa7, 0xf4, 0xff, 0xfa                                 /* j 0x10010 */

Looks good to me. I plan to queue this (and re-queue the other patches
I had dropped), but would not mind another review.


