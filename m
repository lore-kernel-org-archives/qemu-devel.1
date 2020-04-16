Return-Path: <SRS0=3HrQ=6A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F77DC2BB85
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2020 14:59:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 08940206D9
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2020 14:59:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="Z+MOhj4w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08940206D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35622 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jP5zK-0001JW-5m
	for qemu-devel@archiver.kernel.org; Thu, 16 Apr 2020 10:59:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46700)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <qemu_oss@crudebyte.com>) id 1jP5yP-0000C2-4s
 for qemu-devel@nongnu.org; Thu, 16 Apr 2020 10:58:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <qemu_oss@crudebyte.com>) id 1jP5yN-0006c0-Rn
 for qemu-devel@nongnu.org; Thu, 16 Apr 2020 10:58:37 -0400
Received: from lizzy.crudebyte.com ([91.194.90.13]:37173)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <qemu_oss@crudebyte.com>)
 id 1jP5yN-0006Zo-DR
 for qemu-devel@nongnu.org; Thu, 16 Apr 2020 10:58:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=lizzy; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Content-ID:Content-Description;
 bh=KuJHOZkwOLl9JG4yyAEnGgs92UAnvUgDZAyjJoBvkWc=; b=Z+MOhj4wjBoE8/fAjnWthGjzPy
 6kxtfyhZrpdeQvrnAOcfW+W3sIDlwOV6SHPdt2vQpA52PdghyySEVIeY6hsPxhBIJaA6QAL/hydSF
 VDSOGXxEA8VYGDRSepEWJOuxo1a1gnMIDxbgpC97a00zkmLiHT5jTbTfBH4kemHEuYXqce3fWmZG3
 rt/RSMQzgp7qm8TZmlBfYgDp6mMCTcJ04fjVE3NBhhdlvdKu9YGXu7fsFmQGZxP1XXr8i9hYDMBLE
 MPhsLBNm5eVmEUHW87J1GSxErfI15Wwj8L4OFB3k6osmIZaadhKBNZhoUI40qwAAKjIlvCj8j2/kL
 N7SADRvw==;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
To: qemu-devel@nongnu.org
Cc: Omar Sandoval <osandov@osandov.com>, Greg Kurz <groug@kaod.org>
Subject: Re: [PATCH] 9pfs: local: ignore O_NOATIME if we don't have permissions
Date: Thu, 16 Apr 2020 16:58:31 +0200
Message-ID: <2496702.lrWaslOkEp@silver>
In-Reply-To: <1e65cffe9778857735e7ae6066d6f0df0b0e2db3.1586997767.git.osandov@fb.com>
References: <1e65cffe9778857735e7ae6066d6f0df0b0e2db3.1586997767.git.osandov@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 91.194.90.13
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Donnerstag, 16. April 2020 02:44:33 CEST Omar Sandoval wrote:
> From: Omar Sandoval <osandov@fb.com>
> 
> QEMU's local 9pfs server passes through O_NOATIME from the client. If
> the QEMU process doesn't have permissions to use O_NOATIME (namely, it
> does not own the file nor have the CAP_FOWNER capability), the open will
> fail. This causes issues when from the client's point of view, it
> believes it has permissions to use O_NOATIME (e.g., a process running as
> root in the virtual machine). Additionally, overlayfs on Linux opens
> files on the lower layer using O_NOATIME, so in this case a 9pfs mount
> can't be used as a lower layer for overlayfs (cf.
> https://github.com/osandov/drgn/blob/dabfe1971951701da13863dbe6d8a1d172ad965
> 0/vmtest/onoatimehack.c and https://github.com/NixOS/nixpkgs/issues/54509).
> 
> Luckily, O_NOATIME is effectively a hint, and is often ignored by, e.g.,
> network filesystems. open(2) notes that O_NOATIME "may not be effective
> on all filesystems. One example is NFS, where the server maintains the
> access time." This means that we can honor it when possible but fall
> back to ignoring it.

I am not sure whether NFS would simply silently ignore O_NOATIME i.e. without 
returning EPERM. I don't read it that way. Fact is on Linux the expected 
behaviour is returning EPERM if O_NOATIME cannot be satisfied, consistent 
since its introduction 22 years ago:
http://lkml.iu.edu/hypermail/linux/kernel/9811.2/0118.html

> Signed-off-by: Omar Sandoval <osandov@fb.com>
> ---
>  hw/9pfs/9p-util.h | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/hw/9pfs/9p-util.h b/hw/9pfs/9p-util.h
> index 79ed6b233e..50842d540f 100644
> --- a/hw/9pfs/9p-util.h
> +++ b/hw/9pfs/9p-util.h
> @@ -37,9 +37,14 @@ static inline int openat_file(int dirfd, const char
> *name, int flags, {
>      int fd, serrno, ret;
> 
> +again:
>      fd = openat(dirfd, name, flags | O_NOFOLLOW | O_NOCTTY | O_NONBLOCK,
>                  mode);
>      if (fd == -1) {
> +        if (errno == EPERM && (flags & O_NOATIME)) {
> +            flags &= ~O_NOATIME;
> +            goto again;
> +        }
>          return -1;
>      }

It would certainly fix the problem in your use case. But it would also unmask 
O_NOATIME for all other ones (i.e. regular users on guest).

I mean I understand your point, but I also have to take other use cases into 
account which might expect to receive EPERM if O_NOATIME cannot be granted.

May I ask how come that file/dir in question does not share the same uid in 
your specific use case? Are the file(s) created outside of QEMU, i.e. directly 
by some app on host?

Best regards,
Christian Schoenebeck



