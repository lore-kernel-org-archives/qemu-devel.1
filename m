Return-Path: <SRS0=z9mi=3N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F75EC2D0CE
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 09:36:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 19BBD2077C
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 09:36:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AjqD0Yb9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19BBD2077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39252 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuvNt-0007yf-7Q
	for qemu-devel@archiver.kernel.org; Fri, 24 Jan 2020 04:36:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33270)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1iuvNG-0007WM-Ep
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 04:35:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1iuvNE-0008SB-Iy
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 04:35:33 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:41023
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1iuvNE-0008Mt-0k
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 04:35:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579858531;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iwNaWRFE2i0igurQvseighJJkjcCi2PPM6FGMR7S1wo=;
 b=AjqD0Yb9rvpiKmMSdVe6q1mlms3V41IlfZl3k36C5PoxHkA8O3IZUTH64+lIYx/+veFVmA
 sltId6jwbpcKnqcC+j8PB9d56rhM5vfgioj56DfaNNrl6yL7oEhbWvk7/tQvsuxOStIgnu
 pec5IkIYJYcarF/lhtI2Kv0P9sR1KXk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-66-hjed-nGoMjaMBUJfmVLzlg-1; Fri, 24 Jan 2020 04:35:27 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D16112F62;
 Fri, 24 Jan 2020 09:35:26 +0000 (UTC)
Received: from localhost (unknown [10.43.2.114])
 by smtp.corp.redhat.com (Postfix) with ESMTP id AA29D86CCC;
 Fri, 24 Jan 2020 09:35:22 +0000 (UTC)
Date: Fri, 24 Jan 2020 10:35:21 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Subject: Re: [PATCH REPOST v3 75/80] exec: drop bogus mem_path from
 qemu_ram_alloc_from_fd()
Message-ID: <20200124103521.7b84c569@redhat.com>
In-Reply-To: <1579779525-20065-76-git-send-email-imammedo@redhat.com>
References: <1579779525-20065-1-git-send-email-imammedo@redhat.com>
 <1579779525-20065-76-git-send-email-imammedo@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: hjed-nGoMjaMBUJfmVLzlg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: pbonzini@redhat.com, marcandre.lureau@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 23 Jan 2020 12:38:40 +0100
Igor Mammedov <imammedo@redhat.com> wrote:

> Function will report error that will mention global mem_path,
> which was valid the only if legacy -mem-path was used and
> only in case of main RAM.
>=20
> However it doesn't work with hostmem backends
> (for example:
> "
>   qemu: -object memory-backend-file,id=3Dram0,size=3D128M,mem-path=3Dfoo:
>     backing store (null) size 0x200000 does not match 'size' option 0x800=
0000
> ")
> and couldn't possibly work in general FD case the function
> is supposed to handle.
>=20
> Taking in account that main RAM was converted into
> memory-backend-foo object, there is no point in printing
> file name (from inappropriate place) as failing path is
> a part of backend's error message.
>=20
> Hence drop bogus mem_path usage from qemu_ram_alloc_from_fd(),
> it's a job of its user to add file name to error message if applicable.
>=20
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>

Marc-Andr=C3=A9,

git blames you as the one who introduced it,
could you take a look at this patch

probably I should add here as well
Fixes: 8d37b030fe ("exec: split file_ram_alloc()")

> ---
> CC: pbonzini@redhat.com
> CC: rth@twiddle.net
> ---
>  exec.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/exec.c b/exec.c
> index 809987c..dc844fd 100644
> --- a/exec.c
> +++ b/exec.c
> @@ -2308,9 +2308,9 @@ RAMBlock *qemu_ram_alloc_from_fd(ram_addr_t size, M=
emoryRegion *mr,
>      size =3D HOST_PAGE_ALIGN(size);
>      file_size =3D get_file_size(fd);
>      if (file_size > 0 && file_size < size) {
> -        error_setg(errp, "backing store %s size 0x%" PRIx64
> +        error_setg(errp, "backing store size 0x%" PRIx64
>                     " does not match 'size' option 0x" RAM_ADDR_FMT,
> -                   mem_path, file_size, size);
> +                   file_size, size);
>          return NULL;
>      }
> =20


