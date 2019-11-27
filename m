Return-Path: <SRS0=bFmd=ZT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B96D7C432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2019 15:50:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 82BDF20665
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2019 15:50:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jHprxKr+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82BDF20665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39772 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZzad-0007VU-H5
	for qemu-devel@archiver.kernel.org; Wed, 27 Nov 2019 10:50:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53715)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1iZzYk-0006em-Uy
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 10:48:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1iZzYi-0001eX-75
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 10:48:53 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:28848
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1iZzYh-0001eC-ML
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 10:48:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574869730;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/UeIGIa3gLGeNVYGs4+6LIT56gA9ceRYXu2BupYX+fw=;
 b=jHprxKr+6pmxcQ2EwxYZE5L97ptV+oUGHn/g1R+arxNStk/6NslMZfyaUctxhar8VFm/jd
 B7OVeqgL1pQ4kNixim7Vz3xiFGoF6uxd6bOHVSvon23FFnbjfW1RxmfQ2FCZosYc8Jxco2
 zKg+BSXxs5X6+tkbCvn4dntL0pQ1vUo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-125-R87MuD1EOKez81imChc37g-1; Wed, 27 Nov 2019 10:48:47 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 525E510054D4;
 Wed, 27 Nov 2019 15:48:46 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-134.ams2.redhat.com
 [10.36.116.134])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 005F45D9E5;
 Wed, 27 Nov 2019 15:48:45 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 8652A1138606; Wed, 27 Nov 2019 16:48:44 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: "Zhang\, Chen" <chen.zhang@intel.com>
Subject: Re: [PATCH V2 0/4] Introduce Advanced Watch Dog module
References: <20191101024850.20808-1-chen.zhang@intel.com>
 <9CFF81C0F6B98A43A459C9EDAD400D78062F1384@shsmsx102.ccr.corp.intel.com>
Date: Wed, 27 Nov 2019 16:48:44 +0100
In-Reply-To: <9CFF81C0F6B98A43A459C9EDAD400D78062F1384@shsmsx102.ccr.corp.intel.com>
 (Chen Zhang's message of "Fri, 8 Nov 2019 03:03:11 +0000")
Message-ID: <87eext8gmb.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: R87MuD1EOKez81imChc37g-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-dev <qemu-devel@nongnu.org>, Zhang Chen <zhangckid@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

"Zhang, Chen" <chen.zhang@intel.com> writes:

> Hi~ All~=20
>
> Ping.... Anyone have time to review this series? I need more comments~

Any takers?


