Return-Path: <SRS0=VR7F=TO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68881C04AB4
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 15:11:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 300BB2085A
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 15:11:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="DmxHDtqu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 300BB2085A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:49644 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQZ50-0003dk-TI
	for qemu-devel@archiver.kernel.org; Tue, 14 May 2019 11:10:58 -0400
Received: from eggs.gnu.org ([209.51.188.92]:49871)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rdunlap@infradead.org>) id 1hQZ4E-0003FC-D5
	for qemu-devel@nongnu.org; Tue, 14 May 2019 11:10:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rdunlap@infradead.org>) id 1hQZ4D-0001eM-FS
	for qemu-devel@nongnu.org; Tue, 14 May 2019 11:10:10 -0400
Received: from merlin.infradead.org ([2001:8b0:10b:1231::1]:58746)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <rdunlap@infradead.org>)
	id 1hQZ4C-0001V3-U6
	for qemu-devel@nongnu.org; Tue, 14 May 2019 11:10:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=merlin.20170209;
	h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=vg3ia/r810H9SSaaH0GiclbWcxBsBWmX3eOHv52f7hg=;
	b=DmxHDtquirwoRt3leeWs0jqe4p
	OBuVqen+B+T1sPmdQ/Xh/kJtVL1TYRU19cMa/+RiVhkDSyjlRsTaD8G7BLmbV/Erk3ZU9rNHcJAcz
	AzPBib/3h55XEBCNcTmML3raNdaT8gVxGKrIDuTzMFSxcwxp90UfjeuWN/JU3sNy4iFSnaGH6kbtG
	HICqbTL075Zfbakmx1maJv8+hRz1ukLMs87jNeIa2qAUbh4QZQaCfx1yAaQOHVQ0m/aqSDpXot4I5
	fRMJhaeNDyY1S2W6k7vWeIWbdl1vpuIPODlGt6g9JU+fJi9lgIGmpqCHh9KDTrw8etTDZNxt/2mqI
	qo+2U/+g==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16]
	helo=midway.dunlab)
	by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
	id 1hQZ3R-0000BE-Iq; Tue, 14 May 2019 15:09:22 +0000
To: Pankaj Gupta <pagupta@redhat.com>, linux-nvdimm@lists.01.org,
	linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
	kvm@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-acpi@vger.kernel.org, qemu-devel@nongnu.org,
	linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org
References: <20190514145422.16923-1-pagupta@redhat.com>
	<20190514145422.16923-3-pagupta@redhat.com>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <c22d42f6-ef94-0310-36f2-e9085d3464c2@infradead.org>
Date: Tue, 14 May 2019 08:09:03 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190514145422.16923-3-pagupta@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2001:8b0:10b:1231::1
Subject: Re: [Qemu-devel] [PATCH v9 2/7] virtio-pmem: Add virtio pmem driver
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
Cc: jack@suse.cz, mst@redhat.com, jasowang@redhat.com, david@fromorbit.com,
	lcapitulino@redhat.com, adilger.kernel@dilger.ca,
	zwisler@kernel.org, aarcange@redhat.com, dave.jiang@intel.com,
	jstaron@google.com, darrick.wong@oracle.com,
	vishal.l.verma@intel.com, david@redhat.com, willy@infradead.org,
	hch@infradead.org, jmoyer@redhat.com, nilal@redhat.com,
	lenb@kernel.org, kilobyte@angband.pl, riel@surriel.com,
	yuval.shaia@oracle.com, stefanha@redhat.com, pbonzini@redhat.com,
	dan.j.williams@intel.com, kwolf@redhat.com, tytso@mit.edu,
	xiaoguangrong.eric@gmail.com, cohuck@redhat.com,
	rjw@rjwysocki.net, imammedo@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/14/19 7:54 AM, Pankaj Gupta wrote:
> diff --git a/drivers/virtio/Kconfig b/drivers/virtio/Kconfig
> index 35897649c24f..94bad084ebab 100644
> --- a/drivers/virtio/Kconfig
> +++ b/drivers/virtio/Kconfig
> @@ -42,6 +42,17 @@ config VIRTIO_PCI_LEGACY
>  
>  	  If unsure, say Y.
>  
> +config VIRTIO_PMEM
> +	tristate "Support for virtio pmem driver"
> +	depends on VIRTIO
> +	depends on LIBNVDIMM
> +	help
> +	This driver provides access to virtio-pmem devices, storage devices
> +	that are mapped into the physical address space - similar to NVDIMMs
> +	 - with a virtio-based flushing interface.
> +
> +	If unsure, say M.

<beep>
from Documentation/process/coding-style.rst:
"Lines under a ``config`` definition
are indented with one tab, while help text is indented an additional two
spaces."

> +
>  config VIRTIO_BALLOON
>  	tristate "Virtio balloon driver"
>  	depends on VIRTIO

thanks.
-- 
~Randy

