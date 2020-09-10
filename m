Return-Path: <SRS0=7f1Q=CT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C979C43461
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 13:08:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F5A3207FB
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 13:08:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MUAVACpK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F5A3207FB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47508 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGMJN-0000k2-BU
	for qemu-devel@archiver.kernel.org; Thu, 10 Sep 2020 09:08:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59592)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kGMIm-0008Sa-K3
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 09:07:48 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:41297
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kGMIj-00059F-B6
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 09:07:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599743262;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=k3lUv8VXrAaHce+Szelc7Vfn0dwZoRA4F+d4EDKaqHY=;
 b=MUAVACpK4iIZJy8omW/Xe9Y4+pRjfIrNu8HEG6jvrz3Gff8/Q8JqtwC/5QRH4OsD5z+kxd
 H1H9t7in8qdA80ulq0F/NDkhNpywHB/RaEvSRvSDfACD3DKL0fZ2pRWaQaatsJrtAXVv6Q
 F3QbPJOR6HoVdtSZvkdXVZwSFGJxu2Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-402-ua8JTMxFOu-dHm2m6EnDxg-1; Thu, 10 Sep 2020 09:07:26 -0400
X-MC-Unique: ua8JTMxFOu-dHm2m6EnDxg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 216881882FBC;
 Thu, 10 Sep 2020 13:07:25 +0000 (UTC)
Received: from redhat.com (ovpn-112-4.ams2.redhat.com [10.36.112.4])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 22DAB5C3E2;
 Thu, 10 Sep 2020 13:07:22 +0000 (UTC)
Date: Thu, 10 Sep 2020 14:07:20 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Subject: Re: [PATCH v6 0/8] block: improve error reporting for unsupported
 O_DIRECT
Message-ID: <20200910130720.GR1083348@redhat.com>
References: <20200903152210.1917355-1-berrange@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200903152210.1917355-1-berrange@redhat.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=berrange@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/10 09:07:42
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Kevin / Max,

Could you confirm whether you're ok with me sending a pull request for
this, or prefer to funnel it through the block tree for sanity checking.

It changes error messages from the block file driver on non-win32
platforms.

I've tested qemu-iotests with -raw and -qcow2 and didn't see failures

On Thu, Sep 03, 2020 at 04:22:02PM +0100, Daniel P. Berrangé wrote:
> v1: https://lists.gnu.org/archive/html/qemu-devel/2020-07/msg00269.html
> v2: https://lists.gnu.org/archive/html/qemu-devel/2020-07/msg00589.html
> v3: https://lists.gnu.org/archive/html/qemu-devel/2020-07/msg07098.html
> v4: https://lists.gnu.org/archive/html/qemu-devel/2020-08/msg05334.html
> v5: https://lists.gnu.org/archive/html/qemu-devel/2020-09/msg00947.html
> 
> See patch commit messages for rationale
> 
> Ideally we would convert other callers of qemu_open_old to use
> qemu_open, and eventually remove qemu_open_old entirely, so every
> caller gets use of Error **errp.
> 
> Improved in v6:
> 
>  - Fix errno regression dup'ing FD
>  - Move qapi header to correct patch
>  - Fix whitespace and commit messages
>  - Converted more use of qemu_open to qemu_open_old after rebase
> 
> Improved in v5:
> 
>  - Drop reporting of flags in failed open call
>  - Split O_CLOEXEC handling off into separate helper
>  - Refactor monitor FD set APIs to simplify their use
> 
> Improved in v4:
> 
>  - Use assert() for programmer mistakes
>  - Split second patch into three distinct parts
>  - Misc typos
>  - Improve commit message
> 
> Improved in v3:
> 
>  - Re-arrange the patches series, so that the conversion to Error
>    takes place first, then the improve O_DIRECT reporting
>  - Rename existing method to qemu_open_old
>  - Use a pair of new methods qemu_open + qemu_create to improve
>    arg checking
> 
> Improved in v2:
> 
>  - Mention that qemu_open_err is preferred over qemu_open
>  - Get rid of obsolete error_report call
>  - Simplify O_DIRECT handling
>  - Fixup iotests for changed error message text
> 
> Daniel P. Berrangé (8):
>   monitor: simplify functions for getting a dup'd fdset entry
>   util: split off a helper for dealing with O_CLOEXEC flag
>   util: rename qemu_open() to qemu_open_old()
>   util: refactor qemu_open_old to split off variadic args handling
>   util: add Error object for qemu_open_internal error reporting
>   util: introduce qemu_open and qemu_create with error reporting
>   util: give a specific error message when O_DIRECT doesn't work
>   block/file: switch to use qemu_open/qemu_create for improved errors
> 
>  accel/kvm/kvm-all.c            |   2 +-
>  backends/rng-random.c          |   2 +-
>  backends/tpm/tpm_passthrough.c |   8 +--
>  block/file-posix.c             |  16 ++---
>  block/file-win32.c             |   5 +-
>  block/vvfat.c                  |   5 +-
>  chardev/char-fd.c              |   2 +-
>  chardev/char-pipe.c            |   6 +-
>  chardev/char.c                 |   2 +-
>  dump/dump.c                    |   2 +-
>  hw/s390x/s390-skeys.c          |   2 +-
>  hw/usb/host-libusb.c           |   2 +-
>  hw/usb/u2f-passthru.c          |   4 +-
>  hw/vfio/common.c               |   4 +-
>  include/monitor/monitor.h      |   3 +-
>  include/qemu/osdep.h           |   9 ++-
>  io/channel-file.c              |   2 +-
>  monitor/misc.c                 |  58 ++++++++----------
>  net/vhost-vdpa.c               |   2 +-
>  os-posix.c                     |   2 +-
>  qga/channel-posix.c            |   4 +-
>  qga/commands-posix.c           |   6 +-
>  stubs/fdset.c                  |   8 +--
>  target/arm/kvm.c               |   2 +-
>  ui/console.c                   |   2 +-
>  util/osdep.c                   | 104 +++++++++++++++++++++++----------
>  util/oslib-posix.c             |   2 +-
>  27 files changed, 150 insertions(+), 116 deletions(-)
> 
> -- 
> 2.26.2
> 

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


