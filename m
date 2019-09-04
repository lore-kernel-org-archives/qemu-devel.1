Return-Path: <SRS0=c3jH=W7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A880C3A5A2
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 02:10:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4461F21897
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 02:10:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4461F21897
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52688 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5KkQ-00054g-9J
	for qemu-devel@archiver.kernel.org; Tue, 03 Sep 2019 22:10:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39680)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tiwei.bie@intel.com>) id 1i5Kjl-0004dm-9C
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 22:09:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tiwei.bie@intel.com>) id 1i5Kjj-0004Cl-Pg
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 22:09:32 -0400
Received: from mga09.intel.com ([134.134.136.24]:57871)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <tiwei.bie@intel.com>) id 1i5Kjj-000497-I4
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 22:09:31 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 03 Sep 2019 19:09:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,465,1559545200"; d="scan'208";a="198911868"
Received: from dpdk-virtio-tbie-2.sh.intel.com (HELO ___) ([10.67.104.71])
 by fmsmga001.fm.intel.com with ESMTP; 03 Sep 2019 19:09:22 -0700
Date: Wed, 4 Sep 2019 10:06:55 +0800
From: Tiwei Bie <tiwei.bie@intel.com>
To: Johannes Berg <johannes@sipsolutions.net>
Message-ID: <20190904020655.GA30746@___>
References: <20190903200422.11693-1-johannes@sipsolutions.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190903200422.11693-1-johannes@sipsolutions.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 134.134.136.24
Subject: Re: [Qemu-devel] [PATCH v2] libvhost-user: fix SLAVE_SEND_FD
 handling
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
Cc: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org, Johannes Berg <johannes.berg@intel.com>,
 "Michael S . Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Sep 03, 2019 at 11:04:22PM +0300, Johannes Berg wrote:
> From: Johannes Berg <johannes.berg@intel.com>
> 
> It doesn't look like this could possibly work properly since
> VHOST_USER_PROTOCOL_F_SLAVE_SEND_FD is defined to 10, but the
> dev->protocol_features has a bitmap. I suppose the peer this
> was tested with also supported VHOST_USER_PROTOCOL_F_LOG_SHMFD,
> in which case the test would always be false, but nevertheless
> the code seems wrong.

Ooops.. I tested `tests/vhost-user-bridge -H`. But as you
said it worked because VHOST_USER_PROTOCOL_F_LOG_SHMFD has
been negotiated. Thanks for spotting this!

> 
> Use has_feature() to fix this.
> 
> Fixes: d84599f56c82 ("libvhost-user: support host notifier")

Cc: qemu-stable@nongnu.org

> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> ---
>  contrib/libvhost-user/libvhost-user.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/contrib/libvhost-user/libvhost-user.c b/contrib/libvhost-user/libvhost-user.c
> index 6a02eaffc672..fcf4a8a00ed2 100644
> --- a/contrib/libvhost-user/libvhost-user.c
> +++ b/contrib/libvhost-user/libvhost-user.c
> @@ -1097,7 +1097,8 @@ bool vu_set_queue_host_notifier(VuDev *dev, VuVirtq *vq, int fd,
>  
>      vmsg.fd_num = fd_num;
>  
> -    if ((dev->protocol_features & VHOST_USER_PROTOCOL_F_SLAVE_SEND_FD) == 0) {
> +    if (!has_feature(dev->protocol_features,
> +                     VHOST_USER_PROTOCOL_F_SLAVE_SEND_FD)) {

We have both of has_feature() and vu_has_feature() called by
other code in this file directly. Not sure which one is preferred..
Personally, I think vu_has_feature() might be better.

Thanks!
Tiwei

>          return false;
>      }
>  
> -- 
> 2.23.0
> 

