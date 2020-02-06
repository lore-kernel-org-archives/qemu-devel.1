Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67978C2D0B1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 13:21:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 34CD420661
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 13:21:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hq2HKheR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34CD420661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39024 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izh67-000647-D4
	for qemu-devel@archiver.kernel.org; Thu, 06 Feb 2020 08:21:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44940)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1izh51-0004y1-2F
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 08:20:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1izh4z-00064Z-SC
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 08:20:26 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:55293
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1izh4z-00063l-OI
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 08:20:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580995225;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fEItrBjWgEvJjNHlqjqRTtFat1cgKEGX/DNXWZIRNh8=;
 b=hq2HKheR8gaEVLpSQBhjtzM3vapvcVcwNO1JgJytJzcMu40lvV4I5VXPw6izsWjOxWGxvT
 N4drh27j5cH2cu9rAyKH9VRTGaZSisNi5zxg80tRBycBf5TosCrLVt1nG/RXvRi20q/8/L
 BtwwUWFeGp2E/AmjMqcybm/N9c6UZeQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-201-7O-khPFPPMSdt_9g-7211w-1; Thu, 06 Feb 2020 08:20:20 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DE2058018A1;
 Thu,  6 Feb 2020 13:20:19 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-136.ams2.redhat.com
 [10.36.116.136])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D3CE71001B30;
 Thu,  6 Feb 2020 13:20:12 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 6233811386A7; Thu,  6 Feb 2020 14:20:11 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,  Kevin Wolf
 <kwolf@redhat.com>
Subject: Re: [PATCH 02/13] qcrypto-luks: implement encryption key management
References: <dc902f2ba314b63da7ae7a003463f9268e7b3535.camel@redhat.com>
 <20200128171116.GU1446339@redhat.com>
 <20200128173251.GZ1446339@redhat.com>
 <20200130123847.GE6438@linux.fritz.box>
 <20200130125319.GD1891831@redhat.com>
 <87zhe5ovbv.fsf@dusky.pond.sub.org>
 <20200130150108.GM1891831@redhat.com>
 <877e18oq76.fsf@dusky.pond.sub.org>
 <87mu9xxwzv.fsf@dusky.pond.sub.org>
 <20200205093011.GA5768@dhcp-200-226.str.redhat.com>
 <20200205102303.GB2221087@redhat.com>
 <87a75xgl6w.fsf@dusky.pond.sub.org>
Date: Thu, 06 Feb 2020 14:20:11 +0100
In-Reply-To: <87a75xgl6w.fsf@dusky.pond.sub.org> (Markus Armbruster's message
 of "Wed, 05 Feb 2020 15:31:19 +0100")
Message-ID: <87h803ua2c.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: 7O-khPFPPMSdt_9g-7211w-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Max Reitz <mreitz@redhat.com>, John Snow <jsnow@redhat.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org,
 Maxim Levitsky <mlevitsk@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

One more question regarding the array in

    { 'struct': 'QCryptoBlockAmendOptionsLUKS',
      'data' : {
                'keys': ['LUKSKeyslotUpdate'],
                 '*unlock-secret' : 'str' } }

Why an array?  Do we really need multiple keyslot updates in one amend
operation?


