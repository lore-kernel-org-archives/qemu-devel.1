Return-Path: <SRS0=Rh1V=WE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 260CDC0650F
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2019 04:49:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EDAD8217D7
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2019 04:49:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDAD8217D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46922 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvaMa-00053T-5J
	for qemu-devel@archiver.kernel.org; Thu, 08 Aug 2019 00:49:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52393)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <armbru@redhat.com>) id 1hvaLt-00047Q-PH
 for qemu-devel@nongnu.org; Thu, 08 Aug 2019 00:48:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1hvaLq-0005zk-46
 for qemu-devel@nongnu.org; Thu, 08 Aug 2019 00:48:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60304)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hvaLp-0005za-Vg
 for qemu-devel@nongnu.org; Thu, 08 Aug 2019 00:48:34 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id F14B9309BF13;
 Thu,  8 Aug 2019 04:48:32 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-117-142.ams2.redhat.com
 [10.36.117.142])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7D0CC5C21F;
 Thu,  8 Aug 2019 04:48:27 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id EE617113864E; Thu,  8 Aug 2019 06:48:25 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
References: <20190806151435.10740-1-armbru@redhat.com>
 <20190806151435.10740-28-armbru@redhat.com>
 <8c2a6fad-6ac1-21b1-c17c-e1bd5ac41c9f@redhat.com>
 <87a7ckrat7.fsf@dusky.pond.sub.org>
 <ee3709c9-f351-081a-3aeb-53b7b6036b0a@redhat.com>
Date: Thu, 08 Aug 2019 06:48:25 +0200
In-Reply-To: <ee3709c9-f351-081a-3aeb-53b7b6036b0a@redhat.com> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Wed, 7 Aug 2019 23:05:36
 +0200")
Message-ID: <87imr8l0ti.fsf_-_@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.45]); Thu, 08 Aug 2019 04:48:33 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] Is network backend netmap worth keeping? (was: [PATCH
 v2 27/29] Include sysemu/sysemu.h a lot less)
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>,
 qemu-devel@nongnu.org, Vincenzo Maffione <v.maffione@gmail.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Giuseppe Lettieri <g.lettieri@iet.unipi.it>, Luigi Rizzo <rizzo@iet.unipi.it>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Please excuse the attention-grabbing subject.

Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:

> On 8/7/19 10:16 PM, Markus Armbruster wrote:
[...]
>> Can you tell me offhand what I have to install so configure enables
>> CONFIG_NETMAP?
>
> The steps are listed in tests/docker/dockerfiles/debian-amd64.docker,
> but you can get to this point running:
>
>   $ make docker-image-debian-amd64 V=3D1 DEBUG=3D1
>
> This will build the docker image with netmap (so you don't have to mess
> with your workstation setup), then build QEMU within the image.

So, to make use of QEMU's netmap backend (CONFIG_NETMAP), you have to
build and install netmap software from sources.  Which pretty much
ensures nobody uses it.  It was added in commit 58952137b0b (Nov 2013).
The commit message points to <http://info.iet.unipi.it/~luigi/netmap/>,
which gives me "connection timed out" right now.

On the other hand, it's covered in MAINTAINERS, and has seen
non-janitorial activity as late as Dec 2018 (commit c693fc748a).

Luigi, Giuseppe, Vincenzo, what's the status of the netmap project?

Why is the QEMU netmap backend worth keeping?

Who is using the netmap backend?

How do they obtain a netmap-enabled QEMU?  Compile it from sources
themselves?

Would it make sense to have netmap packaged in common Linux distros?

