Return-Path: <SRS0=U3m5=5X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3E58C2D0EC
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 19:38:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C0BE20730
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 19:38:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DVvkPQDl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C0BE20730
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52534 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLu3M-0006uL-LS
	for qemu-devel@archiver.kernel.org; Tue, 07 Apr 2020 15:38:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50478)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jLu2U-0006Tz-0f
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 15:37:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1jLu2S-0004hY-5G
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 15:37:37 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:30944
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1jLu2R-0004gR-TO
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 15:37:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586288255;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=k1sVHa5TXdl/g4dPEohHn4Nr2+x0EfXJ90mZPXz0Iu4=;
 b=DVvkPQDlzFY6cq4dCSR/wh28eUC74I9jik+dJ2rBzxTbXup1QhUbW5uAm3qC1JAAkFI3JV
 OOdoOcygIKjkm+PDFYio4Lug6b15zYJ0i9qhU5ghXEQfyQXXUqapDwGS4XZvHrygsfOGGf
 DUFP06W0V/l+s5gauokANvEbLUyqkIo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-384-sUQa0hxOP3aHWl72y3cbnQ-1; Tue, 07 Apr 2020 15:37:30 -0400
X-MC-Unique: sUQa0hxOP3aHWl72y3cbnQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 87E698018A1;
 Tue,  7 Apr 2020 19:37:29 +0000 (UTC)
Received: from [10.3.114.49] (ovpn-114-49.phx2.redhat.com [10.3.114.49])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 277E45C1BB;
 Tue,  7 Apr 2020 19:37:26 +0000 (UTC)
Subject: Re: Domain backup file explodes on s3fs
To: Tim Haley <timhaley2112@gmail.com>, qemu-devel@nongnu.org,
 "libvirt-list@redhat.com" <libvirt-list@redhat.com>
References: <0d78c593-7b5d-5f73-ea05-e81d9bc35373@gmail.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <31d320ff-4ac7-80f5-e201-c059918697eb@redhat.com>
Date: Tue, 7 Apr 2020 14:37:26 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <0d78c593-7b5d-5f73-ea05-e81d9bc35373@gmail.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

[adding libvirt list]

On 4/7/20 2:13 PM, Tim Haley wrote:
> Hi all,
>=20
> Have been playing with `virsh backup-begin` of late and think it's an=20
> excellent feature. I've noticed one behavior I'm not sure I understand.=
=20

It looks like https://bugzilla.redhat.com/show_bug.cgi?id=3D1814664 is a=20
similar description of the same problem: namely, if qemu is not able to=20
determine that the destination already reads as zero, then it forcefully=20
zeroes the destination of a backup job.  We may want to copy the fact=20
that qemu 5.0 is adding 'qemu-img convert --target-is-zero' to add a=20
similar knob to the QMP commands that trigger disk copying=20
(blockdev-backup, blockdev-mirror, possibly others) as well as logic to=20
avoid writing zeroes when the destination is already treated as zero=20
(whether by a probe, or by the knob being set).

...

> If my /backups directory is just XFS, I get a backup file that looks=20
> like it is just the size of data blocks in use
>=20
> -rw------- 1 root=C2=A0 root=C2=A0 2769551360 Mar 19 16:56=20
> vda.2aa450cc-6d2e-11ea-8de0-52542e0d008a

For a local file, qemu is easily able to probe whether the destination=20
starts as all zeroes (thanks to lseek(SEEK_DATA));

>=20
> but if I write to an s3fs (object storage backend) the file blows up to=
=20
> the whole size of the disk
>=20
> -rw------- 1 root=C2=A0 root=C2=A0 8591507456 Mar 18 19:03=20
> vda.2aa450cc-6d2e-11ea-8de0-52542e0d008a

whereas for s3fs, it looks like qemu does not have access to a quick=20
test to learn if the image starts all zero (POSIX does not provide a=20
quick way for doing this on a generic block device, but if you are aware=20
of an ioctl or otherwise that qemu could use, that might be helpful).=20
Or maybe the s3fs really is random contents rather than all zero, in=20
which case forcefully writing zeroes is the only correct behavior.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


