Return-Path: <SRS0=Zx28=6B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9686C2BB1D
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2020 04:11:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BCA3721D93
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2020 04:11:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCA3721D93
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nutanix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42132 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jPILJ-0006qL-U7
	for qemu-devel@archiver.kernel.org; Fri, 17 Apr 2020 00:11:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49177)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <raphael.norwitz@nutanix.com>) id 1jPIKe-0006Mi-GU
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 00:10:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <raphael.norwitz@nutanix.com>) id 1jPIKb-0004S0-A3
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 00:10:22 -0400
Received: from [192.146.154.243] (port=7260 helo=mcp01.nutanix.com)
 by eggs.gnu.org with esmtp (Exim 4.71)
 (envelope-from <raphael.norwitz@nutanix.com>) id 1jPIKb-0004Rm-4L
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 00:10:21 -0400
Received: from localhost.localdomain (unknown [10.40.36.165])
 by mcp01.nutanix.com (Postfix) with ESMTP id C359F1044E43;
 Fri, 17 Apr 2020 04:10:19 +0000 (UTC)
Date: Mon, 13 Apr 2020 21:54:48 -0400
From: Raphael Norwitz <raphael.norwitz@nutanix.com>
To: Li Feng <fengli@smartx.com>
Subject: Re: [PATCH 4/4] vhost-user-blk: fix crash in realize process
Message-ID: <20200414015448.GA8307@localhost.localdomain>
References: <20200415032826.16701-1-fengli@smartx.com>
 <20200415032826.16701-5-fengli@smartx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200415032826.16701-5-fengli@smartx.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 192.146.154.243
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
Cc: qemu-devel@nongnu.org, mst@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Mostly looks good - just a few superficial notes.

On Wed, Apr 15, 2020 at 11:28:26AM +0800, Li Feng wrote:
> 1. set s->connected to true after vhost_dev_init;
> 2. call vhost_dev_get_config when s->connected is true, otherwise the
>     hdev->host_ops will be nullptr.

You mean hdev->vhost_ops, right?

>=20
> Signed-off-by: Li Feng <fengli@smartx.com>
> ---
>  hw/block/vhost-user-blk.c | 47 +++++++++++++++++++++++++--------------=
--------
>  1 file changed, 25 insertions(+), 22 deletions(-)
> +    /*
> +     * set true util vhost_dev_init return ok, because CLOSE event may=
 happen
> +     * in vhost_dev_init routine.
> +     */

I'm a little confused by this comment. Do you mean to say =E2=80=9Cwait u=
ntil vhost_dev_init
succeeds to set connected to true, because a close event may happen while
vhost_dev_init is executing=E2=80=9D?

