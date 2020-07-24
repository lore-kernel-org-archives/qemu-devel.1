Return-Path: <SRS0=2cnN=BD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19774C433E3
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 16:52:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DABCB2067D
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 16:52:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dnXLFwUl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DABCB2067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45378 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jz0vz-0007HM-0Y
	for qemu-devel@archiver.kernel.org; Fri, 24 Jul 2020 12:52:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58454)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1jz0uv-0006Av-Kq
 for qemu-devel@nongnu.org; Fri, 24 Jul 2020 12:51:29 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:26913
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1jz0ut-0003ui-QY
 for qemu-devel@nongnu.org; Fri, 24 Jul 2020 12:51:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595609487;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nWIiOSuXe+Q+okSLGCDh4yIfClofIpSGsK1prWzGQmY=;
 b=dnXLFwUlGpN8li5xcpGKDrxzEtoINnIVu10ISNBk8FsdCOu/jgiDDb2R+k+tf1kSsju7g/
 VvVjHJ8g9sTGsekGjfsFYUO7T2wqLrFlsU6NN3+bivu/DjMv80+ET4bWbk8jdOr1q1Xf+y
 1mqotKSXf0EOlsskdT0Vo9WhUfeL1Q8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-384-hl-lHPVyNhe1PvjR0ntuIA-1; Fri, 24 Jul 2020 12:51:25 -0400
X-MC-Unique: hl-lHPVyNhe1PvjR0ntuIA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 56980102CC3C
 for <qemu-devel@nongnu.org>; Fri, 24 Jul 2020 16:51:24 +0000 (UTC)
Received: from ibm-p8-OVS-01-fsp.mgmt.pnr.lab.eng.rdu2.redhat.com
 (ovpn-120-206.rdu2.redhat.com [10.10.120.206])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2556769330;
 Fri, 24 Jul 2020 16:51:22 +0000 (UTC)
Subject: Re: [PATCH 1/3] scripts/qmp/qom-fuse: Unbreak import of
 QEMUMonitorProtocol
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20200723142738.1868568-1-armbru@redhat.com>
 <20200723142738.1868568-2-armbru@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <11e45be0-e37b-00e2-2880-1e3bd55461ee@redhat.com>
Date: Fri, 24 Jul 2020 12:51:22 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200723142738.1868568-2-armbru@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=jsnow@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/24 08:23:04
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/23/20 10:27 AM, Markus Armbruster wrote:
> Commit c7b942d7f8 "scripts/qmp: Fix shebang and imports" messed with
> it for reasons I don't quite understand.  I do understand how it fails
> now: it neglects to import sys.  Fix that.
> 

Apologies. These scripts didn't appear to work because they don't have 
any clue where the script they are trying to import lives. I was working 
on a series that refactored ./python/qemu into a python package.

The back half of that series hasn't landed upstream yet, so the import 
refuddling looks an awful lot more arbitrary at the moment, but the idea 
is that the scripts SHOULD work without needing to explicitly set your 
PYTHONPATH. For the moment, I think that's better.

My ultimate end-game is to get most python scripts under ./python/ and 
checked with pylint/mypy etc. as it will help detect breaking changes if 
library routines change. I want to institute a tree-wide regime for 
python code management that has a unified vision about how imports work 
and so on.

I would hope that this would reduce confusion in the future about how to 
execute scripts, how to write import statements, etc.

Most of what I am doing is baby steps towards that.

> It now fails because it expects an old version of module fuse.  That's
> next.
> 

See also my commit message: "There's more wrong with these scripts; ..."

> Fixes: c7b942d7f84ef54f266921bf7668d43f1f2c7c79
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

Thanks:

Reviewed-by: John Snow <jsnow@redhat.com>

> ---
>   scripts/qmp/qom-fuse | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/scripts/qmp/qom-fuse b/scripts/qmp/qom-fuse
> index 5fa6b3bf64..b7dabe8d65 100755
> --- a/scripts/qmp/qom-fuse
> +++ b/scripts/qmp/qom-fuse
> @@ -13,7 +13,7 @@
>   
>   import fuse, stat
>   from fuse import Fuse
> -import os, posix
> +import os, posix, sys
>   from errno import *
>   
>   sys.path.append(os.path.join(os.path.dirname(__file__), '..', '..', 'python'))
> @@ -134,7 +134,7 @@ class QOMFS(Fuse):
>               yield fuse.Direntry(str(item['name']))
>   
>   if __name__ == '__main__':
> -    import sys, os
> +    import os
>   
>       fs = QOMFS(QEMUMonitorProtocol(os.environ['QMP_SOCKET']))
>       fs.main(sys.argv)
> 


