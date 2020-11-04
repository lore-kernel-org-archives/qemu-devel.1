Return-Path: <SRS0=hH57=EK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4442AC2D0A3
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 15:42:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E9272074B
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 15:42:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HhXSkVkA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E9272074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57438 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaKvh-0005Y6-Ik
	for qemu-devel@archiver.kernel.org; Wed, 04 Nov 2020 10:42:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36180)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kaKsr-0001qB-LK
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 10:39:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:52107)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kaKso-0002K4-S2
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 10:39:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604504373;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Pvd61lW4hm/5iaB+TqMQcdVZqcaZaeqNIivcQ4EYhHo=;
 b=HhXSkVkAXbVOkX6GPqLpnPaZMI4DzAbYD3liIvmkRZenIIfkJh6+OVkAeUGosgu/5yjgCy
 dvuvD1JTWaTpgnES48TiPz/OtK70ZNNWP2eWUDWgAX2g7g1cL19oWGnAYdjSb8UeO/3/wf
 i9uhRwnA7bgduEeiAxZ2cRFpvdrb3sw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-284-MJJowykWO0a4wdi0o0g2SA-1; Wed, 04 Nov 2020 10:39:30 -0500
X-MC-Unique: MJJowykWO0a4wdi0o0g2SA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D05481099F62;
 Wed,  4 Nov 2020 15:39:28 +0000 (UTC)
Received: from merkur.fritz.box (ovpn-112-238.ams2.redhat.com [10.36.112.238])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7FB4973661;
 Wed,  4 Nov 2020 15:39:27 +0000 (UTC)
Date: Wed, 4 Nov 2020 16:39:25 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Subject: Re: [PATCH] Prefer 'on' | 'off' over 'yes' | 'no' for bool options
Message-ID: <20201104153925.GA8710@merkur.fritz.box>
References: <20201104140528.608015-1-berrange@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20201104140528.608015-1-berrange@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kwolf@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 22:09:52
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Max Reitz <mreitz@redhat.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org,
 Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 04.11.2020 um 15:05 hat Daniel P. Berrangé geschrieben:
> Update some docs and test cases to use 'on' | 'off' as the preferred
> value for bool options.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>  docs/system/vnc-security.rst | 6 +++---
>  include/authz/listfile.h     | 2 +-
>  qemu-options.hx              | 4 ++--
>  tests/qemu-iotests/233       | 4 ++--
>  4 files changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/docs/system/vnc-security.rst b/docs/system/vnc-security.rst
> index b237b07330..e97b42dfdc 100644
> --- a/docs/system/vnc-security.rst
> +++ b/docs/system/vnc-security.rst
> @@ -89,7 +89,7 @@ but with ``verify-peer`` set to ``yes`` instead.

Looks like it's not only in example, but the text has a mention of
"yes", too. It seems to be the only one, but we'll probably want to
replace it there as well.

There is also an example of verify-peer=no in the file which this patch
misses.

Kevin


