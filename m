Return-Path: <SRS0=Oie8=3L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E215C2D0DB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 15:33:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CCD622071E
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 15:33:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g4GOrLGt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCD622071E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43480 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuI0j-000294-Tk
	for qemu-devel@archiver.kernel.org; Wed, 22 Jan 2020 10:33:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39027)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iuHzt-0001a2-7Q
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 10:32:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iuHzr-0006Er-Jw
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 10:32:48 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:47293
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iuHzr-0006CE-GN
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 10:32:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579707166;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pU0QcvAiNbvXp4G4rm89cpxoCBSxcWLHa0O2UdTctWA=;
 b=g4GOrLGtL34NpeSAqYk34jj0nqqF/xpHEgq2z4I+rSk22PBb2+uIuNlwa59H6pphVMA6cH
 7bWTK1n7jW+yKlcoF1AIAVIIXqCbVpJ+zDxpq07dXzFKvBL86UHkgzPJyLDcP4M6MMenQo
 uyCzX90sfy39twqUisPsluzjl3x6ES0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-60-kTvSk_VxNS2Ex35Oz9uY0A-1; Wed, 22 Jan 2020 10:32:44 -0500
Received: by mail-wr1-f71.google.com with SMTP id o6so3232009wrp.8
 for <qemu-devel@nongnu.org>; Wed, 22 Jan 2020 07:32:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:cc:references:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=yvucSfhyk0QeZRoMux79CrjMoPzwd2C4gIJnIqlB10c=;
 b=ffXIKHMX6VwXuKJdhLNqVUnKpAG5yymfRYCn7MM4l/FlOub6UiTr64rFAz6EzBjHwl
 92OhcP2b2B2sWMFMK/AYJISNwCPeCtrUJ0zMCTt7vDg0MRTeSVAnQbGdLw5RCBFsgBzq
 cK4u/Ky6J/bMhRdyvtOSij0Mh6oExC8X7XJtFp2BBVjKjfZAayyFYJPg7jP4wrgm5NOv
 DLyZfNfOK4CI7hyVmzIckouEK0a/61jAJ2pvmBpVMny5V73l3qAdlhTTCqwRaVHwVvcL
 8pu1JKenrPxzZiGfOoEqYWF24Eki4Te05X38fsZM0IYWf1axxkSYtFOn6Du3Y391LuZ5
 4Fag==
X-Gm-Message-State: APjAAAUEh9d1uCHORRpD7YMl521McAuwV2S1O1adYE//N0W9DSAPkotb
 EPGBJco5zETOmJy+LfLIim7nAJPE2Lw/1uMjnVgHxb6CjhBOASfA2qsnZBpr4BkRB3Msq22posr
 0kk+uop+j3PQlgeU=
X-Received: by 2002:a05:600c:2301:: with SMTP id
 1mr3621738wmo.147.1579707163193; 
 Wed, 22 Jan 2020 07:32:43 -0800 (PST)
X-Google-Smtp-Source: APXvYqyJ3NiM9aSjmUUTmzz7TkoaMFjBPUJBuoZV2CZ24/vbEDqMZGyYENXbnXhUAP7yZpT/njPqXQ==
X-Received: by 2002:a05:600c:2301:: with SMTP id
 1mr3621720wmo.147.1579707162975; 
 Wed, 22 Jan 2020 07:32:42 -0800 (PST)
Received: from [192.168.1.35] (113.red-83-57-172.dynamicip.rima-tde.net.
 [83.57.172.113])
 by smtp.gmail.com with ESMTPSA id q11sm58156365wrp.24.2020.01.22.07.32.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 Jan 2020 07:32:42 -0800 (PST)
Subject: Re: [PATCH v2 011/109] virtiofsd: Fix common header and define for
 QEMU builds
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>,
 qemu-devel@nongnu.org, stefanha@redhat.com, vgoyal@redhat.com,
 berrange@redhat.com, slp@redhat.com
References: <20200121122433.50803-1-dgilbert@redhat.com>
 <20200121122433.50803-12-dgilbert@redhat.com>
 <8bf51480-fdef-14b5-2d4f-0068fa94e808@redhat.com>
Message-ID: <f4d282dc-5de9-c3c8-f0e4-ff40a576a7a3@redhat.com>
Date: Wed, 22 Jan 2020 16:32:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <8bf51480-fdef-14b5-2d4f-0068fa94e808@redhat.com>
Content-Language: en-US
X-MC-Unique: kTvSk_VxNS2Ex35Oz9uY0A-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: m.mizuma@jp.fujitsu.com, misono.tomohiro@jp.fujitsu.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/21/20 4:24 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> On 1/21/20 1:22 PM, Dr. David Alan Gilbert (git) wrote:
>> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>>
>> All of the fuse files include config.h and define GNU_SOURCE
>> where we don't have either under our build - remove them.
>> Fixup path to the kernel's fuse.h in the QEMUs world.
>>
>> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
>> ---
>> =C2=A0 tools/virtiofsd/buffer.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 | 3 ---
>> =C2=A0 tools/virtiofsd/fuse_i.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 | 3 +++
>> =C2=A0 tools/virtiofsd/fuse_lowlevel.c=C2=A0 | 5 +----
>> =C2=A0 tools/virtiofsd/fuse_opt.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | =
1 -
>> =C2=A0 tools/virtiofsd/fuse_signals.c=C2=A0=C2=A0 | 1 -
>> =C2=A0 tools/virtiofsd/passthrough_ll.c | 7 +------
>> =C2=A0 6 files changed, 5 insertions(+), 15 deletions(-)
>>
>> diff --git a/tools/virtiofsd/buffer.c b/tools/virtiofsd/buffer.c
>> index 5df946c82c..db1885ab19 100644
>> --- a/tools/virtiofsd/buffer.c
>> +++ b/tools/virtiofsd/buffer.c
>> @@ -9,9 +9,6 @@
>> =C2=A0=C2=A0 * See the file COPYING.LIB
>> =C2=A0=C2=A0 */
>> -#define _GNU_SOURCE
>> -
>> -#include "config.h"
>> =C2=A0 #include "fuse_i.h"
>> =C2=A0 #include "fuse_lowlevel.h"
>> =C2=A0 #include <assert.h>
>> diff --git a/tools/virtiofsd/fuse_i.h b/tools/virtiofsd/fuse_i.h
>> index e63cb58388..bae06992e0 100644
>> --- a/tools/virtiofsd/fuse_i.h
>> +++ b/tools/virtiofsd/fuse_i.h
>> @@ -6,6 +6,9 @@
>> =C2=A0=C2=A0 * See the file COPYING.LIB
>> =C2=A0=C2=A0 */
>> +#define FUSE_USE_VERSION 31
>> +
>> +
>> =C2=A0 #include "fuse.h"
>> =C2=A0 #include "fuse_lowlevel.h"
>> diff --git a/tools/virtiofsd/fuse_lowlevel.c=20
>> b/tools/virtiofsd/fuse_lowlevel.c
>> index b3d26cab66..f76f3d3fdc 100644
>> --- a/tools/virtiofsd/fuse_lowlevel.c
>> +++ b/tools/virtiofsd/fuse_lowlevel.c
>> @@ -9,11 +9,8 @@
>> =C2=A0=C2=A0 * See the file COPYING.LIB
>> =C2=A0=C2=A0 */
>> -#define _GNU_SOURCE
>> -
>> -#include "config.h"
>> =C2=A0 #include "fuse_i.h"
>> -#include "fuse_kernel.h"
>> +#include "standard-headers/linux/fuse.h"
>> =C2=A0 #include "fuse_misc.h"
>> =C2=A0 #include "fuse_opt.h"
>> diff --git a/tools/virtiofsd/fuse_opt.c b/tools/virtiofsd/fuse_opt.c
>> index edd36f4a3b..1fee55e266 100644
>> --- a/tools/virtiofsd/fuse_opt.c
>> +++ b/tools/virtiofsd/fuse_opt.c
>> @@ -10,7 +10,6 @@
>> =C2=A0=C2=A0 */
>> =C2=A0 #include "fuse_opt.h"
>> -#include "config.h"
>> =C2=A0 #include "fuse_i.h"
>> =C2=A0 #include "fuse_misc.h"
>> diff --git a/tools/virtiofsd/fuse_signals.c=20
>> b/tools/virtiofsd/fuse_signals.c
>> index 19d6791cb9..10a6f88088 100644
>> --- a/tools/virtiofsd/fuse_signals.c
>> +++ b/tools/virtiofsd/fuse_signals.c
>> @@ -8,7 +8,6 @@
>> =C2=A0=C2=A0 * See the file COPYING.LIB
>> =C2=A0=C2=A0 */
>> -#include "config.h"
>> =C2=A0 #include "fuse_i.h"
>> =C2=A0 #include "fuse_lowlevel.h"
>> diff --git a/tools/virtiofsd/passthrough_ll.c=20
>> b/tools/virtiofsd/passthrough_ll.c
>> index 9377718d9d..e702f7dec6 100644
>> --- a/tools/virtiofsd/passthrough_ll.c
>> +++ b/tools/virtiofsd/passthrough_ll.c
>> @@ -35,15 +35,10 @@
>> =C2=A0=C2=A0 * \include passthrough_ll.c
>> =C2=A0=C2=A0 */
>> -#define _GNU_SOURCE
>> -#define FUSE_USE_VERSION 31
>> -
>> -#include "config.h"
>> -
>> +#include "fuse_lowlevel.h"
>> =C2=A0 #include <assert.h>
>> =C2=A0 #include <dirent.h>
>> =C2=A0 #include <errno.h>
>> -#include <fuse_lowlevel.h>
>> =C2=A0 #include <inttypes.h>
>> =C2=A0 #include <limits.h>
>> =C2=A0 #include <pthread.h>
>>
>=20
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Shouldn't these files include "qemu/osdep.h" first, like the rest of the=20
QEMU C files?


