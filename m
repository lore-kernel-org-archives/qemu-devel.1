Return-Path: <SRS0=/TnL=AT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16158C433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 23:01:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C8678206DF
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 23:01:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HXNTqOEz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8678206DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43476 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtJ3k-0005KC-2I
	for qemu-devel@archiver.kernel.org; Wed, 08 Jul 2020 19:01:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57566)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jtJ1v-00022i-Hg
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 18:59:07 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:32041
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jtJ1u-00062u-1I
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 18:59:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594249145;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9uhR7QoQgVQUY3RgfAYYUsaHg7utPK8LVq8kWz3F7IM=;
 b=HXNTqOEzxdAvN1vHFP8yynsyI8Ov8FuNMsdwCFmJcToktH1TTpBAmJlsRJDXYs4G/iOSte
 2jWGBVr+kwtUw0PVfR1NGRz1+tKYSLF/vEqlI5tYGMnnMElFuyQ+DyV8bH/EsbHnlzJWTI
 A8IwWBIjAMTGfgF9WLTNFpUnMNv3gYU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-180-3keVeGEvNpmx-CsyHtK7Jw-1; Wed, 08 Jul 2020 02:57:31 -0400
X-MC-Unique: 3keVeGEvNpmx-CsyHtK7Jw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D7C3F80183C;
 Wed,  8 Jul 2020 06:57:30 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-143.ams2.redhat.com
 [10.36.112.143])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A3AFD60E1C;
 Wed,  8 Jul 2020 06:57:30 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 309371132FD2; Wed,  8 Jul 2020 08:57:29 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Subject: Re: [PATCH v2 3/3] block: switch to use qemu_open_err for improved
 errors
References: <20200702125612.2176194-1-berrange@redhat.com>
 <20200702125612.2176194-4-berrange@redhat.com>
Date: Wed, 08 Jul 2020 08:57:29 +0200
In-Reply-To: <20200702125612.2176194-4-berrange@redhat.com> ("Daniel
 P. =?utf-8?Q?Berrang=C3=A9=22's?= message of "Thu, 2 Jul 2020 13:56:12
 +0100")
Message-ID: <87y2nu3352.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.61; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/07 17:25:10
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org,
 P J P <ppandit@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> Currently at startup if using cache=3Dnone on a filesystem lacking
> O_DIRECT such as tmpfs, at startup QEMU prints
>
> qemu-system-x86_64: -drive file=3D/tmp/foo.img,cache=3Dnone: file system =
may not support O_DIRECT
> qemu-system-x86_64: -drive file=3D/tmp/foo.img,cache=3Dnone: Could not op=
en '/tmp/foo.img': Invalid argument
>
> while at QMP level the hint is missing, so QEMU reports just
>
>   "error": {
>       "class": "GenericError",
>       "desc": "Could not open '/tmp/foo.img': Invalid argument"
>   }
>
> which is close to useless for the end user trying to figure out what
> they did wrong
>
> With this change at startup QEMU prints
>
> qemu-system-x86_64: -drive file=3D/tmp/foo.img,cache=3Dnone: Unable to op=
en '/tmp/foo.img' flags 0x4000: filesystem does not support O_DIRECT
>
> while at the QMP level QEMU reports a massively more informative
>
>   "error": {
>      "class": "GenericError",
>      "desc": "Unable to open '/tmp/foo.img' flags 0x4002: filesystem does=
 not support O_DIRECT"
>   }
>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>

Narrowing down the error's cause takes extra code, but the error message
improvement is worth it.

Reviewed-by: Markus Armbruster <armbru@redhat.com>


