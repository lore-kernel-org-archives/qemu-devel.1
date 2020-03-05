Return-Path: <SRS0=BVCf=4W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8B34C3F2CD
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 14:26:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B5B3C20732
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 14:26:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="mclYmM0T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5B3C20732
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yandex-team.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50152 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9rSR-0000Ob-TJ
	for qemu-devel@archiver.kernel.org; Thu, 05 Mar 2020 09:26:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34319)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lekiravi@yandex-team.ru>) id 1j9rRO-00061o-08
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 09:25:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <lekiravi@yandex-team.ru>) id 1j9rRM-00060f-Qc
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 09:25:33 -0500
Received: from forwardcorp1o.mail.yandex.net ([95.108.205.193]:41258)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <lekiravi@yandex-team.ru>)
 id 1j9rR9-0005lY-D9; Thu, 05 Mar 2020 09:25:20 -0500
Received: from mxbackcorp2j.mail.yandex.net (mxbackcorp2j.mail.yandex.net
 [IPv6:2a02:6b8:0:1619::119])
 by forwardcorp1o.mail.yandex.net (Yandex) with ESMTP id 9AE9B2E154F;
 Thu,  5 Mar 2020 17:25:14 +0300 (MSK)
Received: from localhost (localhost [::1])
 by mxbackcorp2j.mail.yandex.net (mxbackcorp/Yandex) with ESMTP id
 z5MNPQhVm2-PBO06DpE; Thu, 05 Mar 2020 17:25:14 +0300
Precedence: bulk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; 
 t=1583418314; bh=YyF2qBT8dm3IZGrfiOfUkAj9l9sxVno25dxtEJYNu9s=;
 h=Subject:In-Reply-To:Cc:Date:References:To:From:Message-Id;
 b=mclYmM0T5/GYKQWvd06n/AP7uK3ujTwm+rq5ZfUyy7ssRi+6foz4CwBc506ZleAaA
 9Mwe4pQ12xO/Xuiv70sxX/Uu3NNlloZG8VC92BGPknHEYN0TOcYDPSe2h0nM7IOLDJ
 kVh2HZoqnwxdVfYWPpOr9CBpKmZFQB/G+EvpMuZA=
Authentication-Results: mxbackcorp2j.mail.yandex.net;
 dkim=pass header.i=@yandex-team.ru
X-Yandex-Sender-Uid: 1120000000161690
X-Yandex-Avir: 1
Received: from mxbackcorp1g.mail.yandex.net (localhost [::1])
 by mxbackcorp1g.mail.yandex.net with LMTP id iUMswpJpt2-EsudiJzi
 for <lekiravi@yandex-team.ru>; Thu, 05 Mar 2020 17:25:01 +0300
Received: by vla1-bfecef18a7a0.qloud-c.yandex.net with HTTP;
 Thu, 05 Mar 2020 17:25:01 +0300
From: Alexey Kirillov <lekiravi@yandex-team.ru>
To: Laurent Vivier <lvivier@redhat.com>, Eric Blake <eblake@redhat.com>,
 Thomas Huth <huth@tuxfamily.org>, Markus Armbruster <armbru@redhat.com>
In-Reply-To: <274ce4fc-f7ef-791c-7c25-c99b694c1e78@redhat.com>
References: <20200304130656.16859-1-lekiravi@yandex-team.ru>
 <20200304130656.16859-2-lekiravi@yandex-team.ru>
 <274ce4fc-f7ef-791c-7c25-c99b694c1e78@redhat.com>
Subject: Re: [PATCH v2 1/4] qapi: net: Add query-netdevs command
MIME-Version: 1.0
X-Mailer: Yamail [ http://yandex.ru ] 5.0
Date: Thu, 05 Mar 2020 17:25:11 +0300
Message-Id: <1039831583412539@myt4-457577cc370d.qloud-c.yandex.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 95.108.205.193
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Vincenzo Maffione <v.maffione@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Sven Schnelle <svens@stackframe.org>, Rob Herring <robh@kernel.org>,
 Stefano Stabellini <sstabellini@kernel.org>, Paul Durrant <paul@xen.org>,
 Joel Stanley <joel@jms.id.au>, Anthony Perard <anthony.perard@citrix.com>,
 Samuel Thibault <samuel.thibault@ens-lyon.org>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 David Gibson <david@gibson.dropbear.id.au>, Jiri Pirko <jiri@resnulli.us>,
 "yc-core@yandex-team.ru" <yc-core@yandex-team.ru>,
 Stefan Weil <sw@weilnetz.de>, Alistair Francis <alistair@alistair23.me>,
 Beniamino Galvani <b.galvani@gmail.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 Peter Chubb <peter.chubb@nicta.com.au>,
 =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>,
 "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
 Giuseppe Lettieri <g.lettieri@iet.unipi.it>, Luigi Rizzo <rizzo@iet.unipi.it>,
 Richard Henderson <rth@twiddle.net>, Andrew Jeffery <andrew@aj.id.au>,
 Michael Walle <michael@walle.cc>, "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



04.03.2020, 18:57, "Laurent Vivier" <lvivier@redhat.com>:
> On 04/03/2020 14:06, Alexey Kirillov wrote:
>> =C2=A0Add a qmp command that provides information about currently atta=
ched
>> =C2=A0network devices and their configuration.
>>
>> =C2=A0Signed-off-by: Alexey Kirillov <lekiravi@yandex-team.ru>
>> =C2=A0---
>> =C2=A0=C2=A0include/net/net.h | 1 +
>> =C2=A0=C2=A0net/hub.c | 8 +++
>> =C2=A0=C2=A0net/l2tpv3.c | 19 +++++++
>> =C2=A0=C2=A0net/net.c | 91 +++++++++++++++++++++++++++++++++
>> =C2=A0=C2=A0net/netmap.c | 13 +++++
>> =C2=A0=C2=A0net/slirp.c | 126 ++++++++++++++++++++++++++++++++++++++++=
++++++
>> =C2=A0=C2=A0net/socket.c | 71 ++++++++++++++++++++++++++
>> =C2=A0=C2=A0net/tap-win32.c | 9 ++++
>> =C2=A0=C2=A0net/tap.c | 103 +++++++++++++++++++++++++++++++++++--
>> =C2=A0=C2=A0net/vde.c | 26 ++++++++++
>> =C2=A0=C2=A0net/vhost-user.c | 18 +++++--
>> =C2=A0=C2=A0qapi/net.json | 89 ++++++++++++++++++++++++++++++++
>> =C2=A0=C2=A012 files changed, 566 insertions(+), 8 deletions(-)
>
> ...
>> =C2=A0diff --git a/net/net.c b/net/net.c
>> =C2=A0index 9e93c3f8a1..01e0548295 100644
>> =C2=A0--- a/net/net.c
>> =C2=A0+++ b/net/net.c
>> =C2=A0@@ -54,6 +54,7 @@
>> =C2=A0=C2=A0#include "sysemu/sysemu.h"
>> =C2=A0=C2=A0#include "net/filter.h"
>> =C2=A0=C2=A0#include "qapi/string-output-visitor.h"
>> =C2=A0+#include "qapi/clone-visitor.h"
>>
>> =C2=A0=C2=A0/* Net bridge is currently not supported for W32. */
>> =C2=A0=C2=A0#if !defined(_WIN32)
>> =C2=A0@@ -128,6 +129,12 @@ char *qemu_mac_strdup_printf(const uint8_t =
*macaddr)
>>
>> =C2=A0=C2=A0void qemu_format_nic_info_str(NetClientState *nc, uint8_t =
macaddr[6])
>> =C2=A0=C2=A0{
>> =C2=A0+ g_assert(nc->stored_config);
>> =C2=A0+
>> =C2=A0+ g_free(nc->stored_config->u.nic.macaddr);
>> =C2=A0+ nc->stored_config->u.nic.macaddr =3D g_strdup_printf(MAC_FMT,
>> =C2=A0+ MAC_ARG(macaddr));
>> =C2=A0+
>
> Why do you use this rather than the qemu_mac_strdup_printf() function
> defined above?
>
> qemu_mac_strdup_printf():
> =C2=A0=C2=A0890ee6abb385 ("net: add MAC address string printer")
>
> MAC_FMT/MAC_ARG:
> =C2=A0=C2=A06d1d4939a647 ("net: Add macros for MAC address tracing")
>
> MAC_FMT/MAC_ARG seems to be reserved for tracing.
>
> Thanks,
> Laurent

Somehow, I managed not to notice this feature.
Thank you for pointing this out, I will definitely fix this place.

--=C2=A0
Alexey Kirillov
Yandex.Cloud


