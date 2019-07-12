Return-Path: <SRS0=r3/N=VJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FB07C742B2
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2019 10:27:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C7F32173B
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2019 10:27:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C7F32173B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48026 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hlsmN-0005Ks-GF
	for qemu-devel@archiver.kernel.org; Fri, 12 Jul 2019 06:27:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32810)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <sgarzare@redhat.com>) id 1hlsmC-0004rw-RN
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 06:27:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <sgarzare@redhat.com>) id 1hlsmB-0007Ck-LE
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 06:27:40 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:56064)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <sgarzare@redhat.com>) id 1hlsmB-0007CB-F7
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 06:27:39 -0400
Received: by mail-wm1-f66.google.com with SMTP id a15so8406240wmj.5
 for <qemu-devel@nongnu.org>; Fri, 12 Jul 2019 03:27:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=hKAg8c7EqIuJjKHk38LxkElcLoSDr+edD1uH7E1Qd+4=;
 b=ppB9n3C7oMOCY4pwwjW/+UpcGZyHPQbDfD3O1+dYY5Z9WwRA0mUet4aJd6VLI4PJma
 wU9hFGwLXiMl2RJFslr9gX3MZAarVzzQt5v5zlfMuHIBmmLXFoQNwbZwjPtxF9z397Yj
 ustxaqyb3vXjSV5tReLOKZhDCk0OhHnOqUXWFkwP6Z53FkI/DDUl+sw8mvDj5e0NuXPP
 QK6LPtGugg/fIqcDsxRffxYNMpHSONXO0sfXmrtr0LRj2afZQIQas7JJ13k7XgxLdwtu
 8KKwaI1CgW0SLtN7RRnw5FhvOzReI2pJ+RyGMGW326BBMRAM3emu+yY0hqiD42tyYmEM
 w9gw==
X-Gm-Message-State: APjAAAUwLCRLXBCWP68kNFkbVpsnQYeT72+lwZQmeBOVL8iydJNRHGqj
 /A7Z76jOUd5nQzZnq9cTW9XF2g==
X-Google-Smtp-Source: APXvYqwXjNR0l04us1WUh3dRzPr0bA1mn2Lk97AZ91jWTQcDVGDv5+yhBnmky97Ypv+dI47TRTrJCQ==
X-Received: by 2002:a1c:e710:: with SMTP id e16mr9488178wmh.38.1562927258304; 
 Fri, 12 Jul 2019 03:27:38 -0700 (PDT)
Received: from steredhat (host122-201-dynamic.13-79-r.retail.telecomitalia.it.
 [79.13.201.122])
 by smtp.gmail.com with ESMTPSA id o126sm6976642wmo.1.2019.07.12.03.27.37
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 12 Jul 2019 03:27:37 -0700 (PDT)
Date: Fri, 12 Jul 2019 12:27:35 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Max Reitz <mreitz@redhat.com>
Message-ID: <20190712102735.ea5f4aqqgok7qdxa@steredhat>
References: <20190711132935.13070-1-mreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190711132935.13070-1-mreitz@redhat.com>
User-Agent: NeoMutt/20180716
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.66
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH] doc: Preallocation does not
 require writing zeroes
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Jul 11, 2019 at 03:29:35PM +0200, Max Reitz wrote:
> When preallocating an encrypted qcow2 image, it just lets the protocol
> driver write data and then does not mark the clusters as zero.
> Therefore, reading this image will yield effectively random data.
> 
> As such, we have not fulfilled the promise of always writing zeroes when
> preallocating an image in a while.  It seems that nobody has really
> cared, so change the documentation to conform to qemu's actual behavior.
> 
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>  qapi/block-core.json         | 9 +++++----
>  docs/qemu-block-drivers.texi | 4 ++--
>  qemu-img.texi                | 4 ++--
>  3 files changed, 9 insertions(+), 8 deletions(-)
> 
> diff --git a/qapi/block-core.json b/qapi/block-core.json
> index 0d43d4f37c..a4363b84d2 100644
> --- a/qapi/block-core.json
> +++ b/qapi/block-core.json
> @@ -5167,10 +5167,11 @@
>  # @off: no preallocation
>  # @metadata: preallocate only for metadata
>  # @falloc: like @full preallocation but allocate disk space by
> -#          posix_fallocate() rather than writing zeros.
> -# @full: preallocate all data by writing zeros to device to ensure disk
> -#        space is really available. @full preallocation also sets up
> -#        metadata correctly.
> +#          posix_fallocate() rather than writing data.
> +# @full: preallocate all data by writing it to the device to ensure
> +#        disk space is really available. This data may or may not be
> +#        zero, depending on the image format and storage.
> +#        @full preallocation also sets up metadata correctly.
>  #
>  # Since: 2.2
>  ##
> diff --git a/docs/qemu-block-drivers.texi b/docs/qemu-block-drivers.texi
> index 91ab0eceae..c02547e28c 100644
> --- a/docs/qemu-block-drivers.texi
> +++ b/docs/qemu-block-drivers.texi
> @@ -31,8 +31,8 @@ Supported options:
>  @item preallocation
>  Preallocation mode (allowed values: @code{off}, @code{falloc}, @code{full}).
>  @code{falloc} mode preallocates space for image by calling posix_fallocate().
> -@code{full} mode preallocates space for image by writing zeros to underlying
> -storage.
> +@code{full} mode preallocates space for image by writing data to underlying
> +storage.  This data may or may not be zero, depending on the storage location.
>  @end table
>  
>  @item qcow2
> diff --git a/qemu-img.texi b/qemu-img.texi
> index c8e9bba515..b5156d6316 100644
> --- a/qemu-img.texi
> +++ b/qemu-img.texi
> @@ -666,8 +666,8 @@ Supported options:
>  @item preallocation
>  Preallocation mode (allowed values: @code{off}, @code{falloc}, @code{full}).
>  @code{falloc} mode preallocates space for image by calling posix_fallocate().
> -@code{full} mode preallocates space for image by writing zeros to underlying
> -storage.
> +@code{full} mode preallocates space for image by writing data to underlying
> +storage.  This data may or may not be zero, depending on the storage location.
>  @end table
>  
>  @item qcow2

Just a question:
if a protocol driver returns 1 with the .bdrv_has_zero_init callback, is it
expected that the preallocation will fill the image with zeroes?

IIUC, for example, the qcow2 returns 1 with the .bdrv_has_zero_init. but during
the qcow2_co_truncate() it calls bdrv_co_truncate() and, depending on the
backend driver, it should fill the image with zeroes (or not?).

Maybe I miss something related to the metadata...


Thanks,
Stefano

