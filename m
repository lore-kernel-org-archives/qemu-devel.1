Return-Path: <SRS0=Q7uJ=36=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=3.0 tests=DATE_IN_PAST_12_24,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D643C352A4
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2020 08:07:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 144D1214DB
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2020 08:07:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 144D1214DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nutanix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58100 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j146R-0002DN-Ac
	for qemu-devel@archiver.kernel.org; Mon, 10 Feb 2020 03:07:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36040)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <raphael.norwitz@nutanix.com>) id 1j145c-0001oT-2j
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 03:06:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <raphael.norwitz@nutanix.com>) id 1j145a-0004XW-MG
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 03:06:43 -0500
Received: from [192.146.154.1] (port=43911 helo=mcp01.nutanix.com)
 by eggs.gnu.org with esmtp (Exim 4.71)
 (envelope-from <raphael.norwitz@nutanix.com>) id 1j145a-0004X9-HU
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 03:06:42 -0500
Received: from localhost.localdomain (unknown [10.40.36.165])
 by mcp01.nutanix.com (Postfix) with ESMTP id B1EC01007A33;
 Mon, 10 Feb 2020 08:06:41 +0000 (UTC)
Date: Sun, 9 Feb 2020 12:21:51 -0500
From: Raphael Norwitz <raphael.norwitz@nutanix.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v2 2/3] Refactor vhost_user_set_mem_table functions
Message-ID: <20200209172151.GA14982@localhost.localdomain>
References: <1579143426-18305-1-git-send-email-raphael.norwitz@nutanix.com>
 <1579143426-18305-3-git-send-email-raphael.norwitz@nutanix.com>
 <20200206032007-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200206032007-mutt-send-email-mst@kernel.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 192.146.154.1
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Sounds good

On Thu, Feb 06, 2020 at 03:21:42AM -0500, Michael S. Tsirkin wrote:
> 
> On Wed, Jan 15, 2020 at 09:57:05PM -0500, Raphael Norwitz wrote:
> > vhost_user_set_mem_table() and vhost_user_set_mem_table_postcopy() have
> > gotten convoluted, and have some identical code.
> > 
> > This change moves the logic populating the VhostUserMemory struct and
> > fds array from vhost_user_set_mem_table() and
> > vhost_user_set_mem_table_postcopy() to a new function,
> > vhost_user_fill_set_mem_table_msg().
> > 
> > No functionality is impacted.
> > 
> > Signed-off-by: Raphael Norwitz <raphael.norwitz@nutanix.com>
> > Signed-off-by: Peter Turschmid <peter.turschm@nutanix.com>
> 
> 
> Looks ok, but just cosmetics: let's have the flag say what
> it does, not who uses it.
> 
> So s/postcopy/track_ramblocks/ ?
> 


