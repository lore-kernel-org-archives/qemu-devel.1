Return-Path: <SRS0=cfdO=BG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54A20C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 07:43:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1CC8020738
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 07:43:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f6Qkb68A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CC8020738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36922 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jzxne-0000Bb-Bv
	for qemu-devel@archiver.kernel.org; Mon, 27 Jul 2020 03:43:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36998)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jzxn0-00089D-JU
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 03:43:14 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:30097
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jzxmy-00065A-5f
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 03:43:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595835791;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nPdUR8gXjXEufvoEYRPSVro+A613d8pLLg3oYfdwesk=;
 b=f6Qkb68AhuysLYRCcHOqagDwMXccwTG1+6pnF5Ivffc1St2Ou57cL1TD+sdhIE0pT9DliO
 R2b+HXYLmHOZqjlEP9/uOZt/yWW4j++1UFIT+1qcpa2Q0z5U0OHEC/4yoYa3dt+ELmRQko
 TIMmpFGTNGYBfeb985Kps6rFYW5YXng=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-245-dDEARFrVNI-jrtd3fivyDg-1; Mon, 27 Jul 2020 03:43:09 -0400
X-MC-Unique: dDEARFrVNI-jrtd3fivyDg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 551EE1902EA1;
 Mon, 27 Jul 2020 07:43:08 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-143.ams2.redhat.com
 [10.36.112.143])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 04F3589500;
 Mon, 27 Jul 2020 07:43:08 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 92AF21138648; Mon, 27 Jul 2020 09:43:06 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Subject: Re: [PATCH v3 4/4] block: switch to use qemu_open/qemu_create for
 improved errors
References: <20200724132510.3250311-1-berrange@redhat.com>
 <20200724132510.3250311-5-berrange@redhat.com>
Date: Mon, 27 Jul 2020 09:43:06 +0200
In-Reply-To: <20200724132510.3250311-5-berrange@redhat.com> ("Daniel
 P. =?utf-8?Q?Berrang=C3=A9=22's?= message of "Fri, 24 Jul 2020 14:25:10
 +0100")
Message-ID: <875za9769h.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.120; envelope-from=armbru@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/27 00:16:29
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org,
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
> they did wrong.
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

Subject promises slightly more than the patch actually provides:

    block/vvfat.c:1355:        int fd =3D qemu_open(mapping->path, O_RDONLY=
 | O_BINARY | O_LARGEFILE);
    block/vvfat.c:2516:    fd =3D qemu_open(mapping->path, O_RDWR | O_CREAT=
 | O_BINARY, 0666);

If you'd rather not touch block/vvfat.c (I understand), consider
tweaking the subject to say

    block/file: ...


