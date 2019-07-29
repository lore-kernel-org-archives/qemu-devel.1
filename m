Return-Path: <SRS0=7VQp=V2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32231C433FF
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2019 07:04:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 07058206DD
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2019 07:04:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07058206DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50112 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hrziC-0003v6-8b
	for qemu-devel@archiver.kernel.org; Mon, 29 Jul 2019 03:04:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33216)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <imammedo@redhat.com>) id 1hrzhb-0003WY-IC
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 03:04:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1hrzha-0007qp-NN
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 03:04:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38564)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1hrzha-0007oA-FC
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 03:04:10 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id E0ACD335CE;
 Mon, 29 Jul 2019 07:04:08 +0000 (UTC)
Received: from localhost (unknown [10.43.2.182])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1641F5D71D;
 Mon, 29 Jul 2019 07:04:02 +0000 (UTC)
Date: Mon, 29 Jul 2019 09:04:01 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Wei Yang <richardw.yang@linux.intel.com>
Message-ID: <20190729090401.524ff8cd@redhat.com>
In-Reply-To: <20190728131304.1282-3-richardw.yang@linux.intel.com>
References: <20190728131304.1282-1-richardw.yang@linux.intel.com>
 <20190728131304.1282-3-richardw.yang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.38]); Mon, 29 Jul 2019 07:04:09 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 2/3] memory-device: break the loop if no
 hint is provided
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
Cc: david@redhat.com, qemu-devel@nongnu.org, mst@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, 28 Jul 2019 21:13:03 +0800
Wei Yang <richardw.yang@linux.intel.com> wrote:

> When there is no hint, the first un-overlapped range is the proper one.
> Just break the loop instead of iterate the whole list.
could it change default pc-dimm mapping (will address assignment stay
the same as before this change)?

In commit message I'd suggest to replace 'the proper one' with more
verbose explanation why it is safe to break earlier.

otherwise patch look good to me

> 
> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
> ---
>  hw/mem/memory-device.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/hw/mem/memory-device.c b/hw/mem/memory-device.c
> index df3261b32a..413b514586 100644
> --- a/hw/mem/memory-device.c
> +++ b/hw/mem/memory-device.c
> @@ -180,6 +180,8 @@ static uint64_t memory_device_get_free_addr(MachineState *ms,
>                  range_make_empty(&new);
>                  break;
>              }
> +        } else if (!hint) {
> +            break;
>          }
>      }
>  

