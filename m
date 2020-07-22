Return-Path: <SRS0=zezO=BB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C986FC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 09:23:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9050D206D7
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 09:23:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HV92wg1K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9050D206D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57876 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyAyJ-00015N-Sl
	for qemu-devel@archiver.kernel.org; Wed, 22 Jul 2020 05:23:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52760)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jyAsw-00067p-Le
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 05:17:58 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:40398
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jyAsu-0005GD-Pg
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 05:17:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595409476;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1V2mk/bwTHCUjmaKrY+2HRsiQcGFrKwTBYnEx3jPTS4=;
 b=HV92wg1K4NpbWGEJWgyVGFZ5iXOm9hkAX4EdnYTukQL9e8cRigprG+OWMHNV3dcZKZkRdp
 HsaG2rlHOzBYtT/4RanHKsBujaNUP/A0tLVtpwvf+CUKfZHRwa7XX6t9j/FL4jNC7765qr
 KtUFReWt2v6imMbRTkfaNJ/nOwXnwAs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-44-ixUiX2tpMgqNOeTWRAC5wg-1; Wed, 22 Jul 2020 05:17:53 -0400
X-MC-Unique: ixUiX2tpMgqNOeTWRAC5wg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 07F7A805721;
 Wed, 22 Jul 2020 09:17:52 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-143.ams2.redhat.com
 [10.36.112.143])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 648925C1C3;
 Wed, 22 Jul 2020 09:17:42 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 0161E10F5AF1; Wed, 22 Jul 2020 11:17:40 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH v2 2/3] usb/hcd-xhci: Move qemu-xhci device to
 hcd-xhci-pci.c
References: <1593008176-9629-1-git-send-email-sai.pavan.boddu@xilinx.com>
 <1593008176-9629-3-git-send-email-sai.pavan.boddu@xilinx.com>
 <87zh8rzi0e.fsf@dusky.pond.sub.org>
 <d8e247a3-5b50-0889-2522-37f2d486fdf9@redhat.com>
 <BY5PR02MB677295286C4193236973EC0ECA7B0@BY5PR02MB6772.namprd02.prod.outlook.com>
 <b3d4924f-5259-3f55-a52c-9693c532d40b@redhat.com>
 <BY5PR02MB6772EAC0125218AD9E09FC97CA790@BY5PR02MB6772.namprd02.prod.outlook.com>
 <391efac2-8600-3011-6aba-d29f44b57174@redhat.com>
Date: Wed, 22 Jul 2020 11:17:40 +0200
In-Reply-To: <391efac2-8600-3011-6aba-d29f44b57174@redhat.com> (Thomas Huth's
 message of "Wed, 22 Jul 2020 10:38:09 +0200")
Message-ID: <87r1t3ucwb.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.61; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/21 21:28:05
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Sai Pavan Boddu <saipava@xilinx.com>,
 Alistair Francis <alistair.francis@wdc.com>, Gerd Hoffmann <kraxel@redhat.com>,
 =?utf-8?Q?'Marc-Andr=C3=A9?= Lureau' <marcandre.lureau@redhat.com>,
 Ying Fang <fangying1@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud?= =?utf-8?Q?=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Thomas Huth <thuth@redhat.com> writes:

>  Hi,
>
> On 22/07/2020 09.49, Sai Pavan Boddu wrote:
> [...]
>>>>>>> + * This library is free software; you can redistribute it and/or
>>>>>>> + * modify it under the terms of the GNU Lesser General Public
>>>>>>> + * License as published by the Free Software Foundation; either
>>>>>>> + * version 2 of the License, or (at your option) any later version=
.
>>>
>>> And while you're at it: There was never a "version 2" of the Lesser GPL=
.
>>> In version 2.0, it was still called "Library" GPL. So it is quite likel=
y that version
>>> 2.1 is meant here instead.
>> [Sai Pavan Boddu] I have less knowledge here. But indeed I don=E2=80=99t=
 find LGPL 2.0 https://www.gnu.org/licenses/licenses.html#LicenseURLs
>
> You can find version 2.0 here, for example:
>
>  https://www.gnu.org/licenses/old-licenses/old-licenses.html#LGPL
>
> ... but as I said, v2.0 is called "Library" GPL instead of "Lesser" GPL.
>
>> BTW, I still see our repository use combination of GPL and LGPL. Is ther=
e any general rule to follow at high level.
>
> As long as the license is a standard license that is compatible with the
> GPLv2 or any later version, you should be fine. See the LICENSE file in
> the top directory of the sources for details.
>
> As a general rule, I'd say either use "GPLv2 or later" (see the file
> COPYING in the main directory) or "LGPLv2.1 or later" (see COPYING.LIB
> in the main directory) for new code, unless you contribute to the tcg/
> folder where MIT or BSD is preferred instead.

Please use "GPLv2 or later".

If you believe you have a compelling reason for using a different
license (compatible with GPLv2, of course), then explain yourself in the
commit message.


