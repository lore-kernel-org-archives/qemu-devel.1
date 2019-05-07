Return-Path: <SRS0=60fc=TH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09073C004C9
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 15:38:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C94CC20825
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 15:38:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="1RDaQiep"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C94CC20825
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:48810 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hO2B0-0007pC-4h
	for qemu-devel@archiver.kernel.org; Tue, 07 May 2019 11:38:42 -0400
Received: from eggs.gnu.org ([209.51.188.92]:35584)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dan.j.williams@intel.com>) id 1hO29a-0006qw-FV
	for qemu-devel@nongnu.org; Tue, 07 May 2019 11:37:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dan.j.williams@intel.com>) id 1hO29Z-0000B8-Id
	for qemu-devel@nongnu.org; Tue, 07 May 2019 11:37:14 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:38849)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <dan.j.williams@intel.com>)
	id 1hO29Z-0000Al-E5
	for qemu-devel@nongnu.org; Tue, 07 May 2019 11:37:13 -0400
Received: by mail-ot1-x342.google.com with SMTP id b1so15366348otp.5
	for <qemu-devel@nongnu.org>; Tue, 07 May 2019 08:37:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=intel-com.20150623.gappssmtp.com; s=20150623;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=6dOaY+uD9DJjErKzQ4lbx3sa2d0JDi7CHezoB5wTbvY=;
	b=1RDaQiep4r+5NZ7RO5zftr0FnsMUZwAyLWkMBkR9iTDOBSIJayhPK4u9DWG7+9yxpt
	9FJnbG3lrhIL0LedEM5ytUIEEGfVVBYdsCV16Q3ZevH87Y7p3IJljktvzFGtbrtOW9jV
	qgMeHUIAfkrXfVgCh+wJIUgLwx8HPs0Hso14g3nE34tG3uE5Kaf93v1albOqeZ8FtzEo
	MRnNU+jjU7Bd7Hg2HKOClTmC45crVs8w8TurxKr/6z1WENdYw/y//CLDQEQmIA9Rf7i+
	OKLRLxxsnQvga0Mn1E5gFobavHOZ9OlvYblRdklzqgaUM3FSIzUzMZWnI38rOf5/Ueyc
	SI6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=6dOaY+uD9DJjErKzQ4lbx3sa2d0JDi7CHezoB5wTbvY=;
	b=riViE4Zil53FYjim9qYTLFCVvNg6iNUshKrR/0UXdyV32iXFq70pPSeaYteWbTj2Ob
	My6/zwaW2AoFPipoxZf+Xjs1MNgoLuvTsIC6bW6+wLmG+HZSkIS1IIPkgE4Z3wjD6B1T
	4v5sl1jwdAwFzCUiPmZd9pQhRtHRfEUC7HpzwKQUcv5Qn7COv0UxZIIN+c1JkcJ2u27Y
	xm9GUApry+SeMt+iKk4ht79fQcq95nOI6woCB8KkxgH0iBXwFXcO4WfEgh1MgjsX3cq3
	KQt3N+c1vfY6i01PvBLhvRmTdEDnBrUR6ZML9SWn/oJQPPwqqGe+99y8xMYOZW7aVeIY
	7lSQ==
X-Gm-Message-State: APjAAAVKcYIeyYyYGK2INg/32BCd67fXt/s3nnnk8UJ4NfecDb8KTurX
	JacBTH/tqF09ZhzdJocsN8Y6Kh4hsNX/hQGO7BPBhg==
X-Google-Smtp-Source: APXvYqxbxERKNtTaVpMxD9jAh6w8zsl3plIje9NPoM99XF0whcoJ/rqAndFua0o+8QlJA2fPNaeXZRcDVPm+ejCVDvk=
X-Received: by 2002:a9d:222c:: with SMTP id o41mr22019501ota.353.1557243432435;
	Tue, 07 May 2019 08:37:12 -0700 (PDT)
MIME-Version: 1.0
References: <20190426050039.17460-1-pagupta@redhat.com>
	<20190426050039.17460-7-pagupta@redhat.com>
In-Reply-To: <20190426050039.17460-7-pagupta@redhat.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Tue, 7 May 2019 08:37:01 -0700
Message-ID: <CAPcyv4hCP4E4xPkQx25tqhznon6ADwrYJB1yujkrO-A7LUnsmg@mail.gmail.com>
To: Pankaj Gupta <pagupta@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::342
Subject: Re: [Qemu-devel] [PATCH v7 6/6] xfs: disable map_sync for async
 flush
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: cohuck@redhat.com, Jan Kara <jack@suse.cz>, KVM list <kvm@vger.kernel.org>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>, david <david@fromorbit.com>,
	Qemu Developers <qemu-devel@nongnu.org>,
	virtualization@lists.linux-foundation.org,
	Andreas Dilger <adilger.kernel@dilger.ca>,
	Ross Zwisler <zwisler@kernel.org>, Andrea Arcangeli <aarcange@redhat.com>,
	Dave Jiang <dave.jiang@intel.com>,
	linux-nvdimm <linux-nvdimm@lists.01.org>,
	Vishal L Verma <vishal.l.verma@intel.com>,
	David Hildenbrand <david@redhat.com>, Matthew Wilcox <willy@infradead.org>,
	Christoph Hellwig <hch@infradead.org>,
	Linux ACPI <linux-acpi@vger.kernel.org>, jmoyer <jmoyer@redhat.com>,
	linux-ext4 <linux-ext4@vger.kernel.org>,
	Len Brown <lenb@kernel.org>, kilobyte@angband.pl,
	Rik van Riel <riel@surriel.com>, yuval shaia <yuval.shaia@oracle.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>, lcapitulino@redhat.com,
	Kevin Wolf <kwolf@redhat.com>, Nitesh Narayan Lal <nilal@redhat.com>,
	Theodore Ts'o <tytso@mit.edu>,
	Xiao Guangrong <xiaoguangrong.eric@gmail.com>,
	"Darrick J. Wong" <darrick.wong@oracle.com>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-xfs <linux-xfs@vger.kernel.org>,
	linux-fsdevel <linux-fsdevel@vger.kernel.org>,
	Igor Mammedov <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Apr 25, 2019 at 10:03 PM Pankaj Gupta <pagupta@redhat.com> wrote:
>
> Dont support 'MAP_SYNC' with non-DAX files and DAX files
> with asynchronous dax_device. Virtio pmem provides
> asynchronous host page cache flush mechanism. We don't
> support 'MAP_SYNC' with virtio pmem and xfs.
>
> Signed-off-by: Pankaj Gupta <pagupta@redhat.com>
> ---
>  fs/xfs/xfs_file.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)

Darrick, does this look ok to take through the nvdimm tree?

>
> diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
> index a7ceae90110e..f17652cca5ff 100644
> --- a/fs/xfs/xfs_file.c
> +++ b/fs/xfs/xfs_file.c
> @@ -1203,11 +1203,14 @@ xfs_file_mmap(
>         struct file     *filp,
>         struct vm_area_struct *vma)
>  {
> +       struct dax_device       *dax_dev;
> +
> +       dax_dev = xfs_find_daxdev_for_inode(file_inode(filp));
>         /*
> -        * We don't support synchronous mappings for non-DAX files. At least
> -        * until someone comes with a sensible use case.
> +        * We don't support synchronous mappings for non-DAX files and
> +        * for DAX files if underneath dax_device is not synchronous.
>          */
> -       if (!IS_DAX(file_inode(filp)) && (vma->vm_flags & VM_SYNC))
> +       if (!daxdev_mapping_supported(vma, dax_dev))
>                 return -EOPNOTSUPP;
>
>         file_accessed(filp);
> --
> 2.20.1
>

