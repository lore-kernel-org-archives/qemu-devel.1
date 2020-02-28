Return-Path: <SRS0=EIn8=4Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D70DCC3F2CD
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 17:42:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F8BD246A3
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 17:42:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QBFRX8Q+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F8BD246A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51744 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7jek-0003NF-Qb
	for qemu-devel@archiver.kernel.org; Fri, 28 Feb 2020 12:42:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49674)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1j7jdg-00020G-V8
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 12:41:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1j7jdf-0001gL-NS
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 12:41:28 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:52418
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1j7jdf-0001g2-Gf
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 12:41:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582911686;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=//hsPm9sWIMfSZv4e3ZMMIruCqvVs/LY1x87MX40wtc=;
 b=QBFRX8Q+qSdGzgtuP9LG8up++dWkdMXRlkj6FZR9SBD+2hWiMr4oQtNVPl8zyeRBWEbvML
 JPdDR5VGCQTwepWLK73LkMv25owHgWqWy1ll/UE7c+MB0A/zonUMsEgVCyQ6kPgugpiOTf
 eVzkx10/WdCZdJAb9I4mRJH9Styrq+4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-227-dHm_KLZoMKmWsgN_J9UX9w-1; Fri, 28 Feb 2020 12:41:25 -0500
X-MC-Unique: dHm_KLZoMKmWsgN_J9UX9w-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 046D813E6;
 Fri, 28 Feb 2020 17:41:24 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-129.ams2.redhat.com
 [10.36.116.129])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A2F8519C70;
 Fri, 28 Feb 2020 17:41:18 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 2B96011386A6; Fri, 28 Feb 2020 18:41:17 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: [PATCH v2 2/6] util: Replace fprintf(stderr,
 "*\n" with error_report()
References: <20200227163101.414-1-philmd@redhat.com>
 <20200227163101.414-3-philmd@redhat.com>
 <87ftevma26.fsf@dusky.pond.sub.org>
 <12c7c23b-2a6f-6a54-5974-13492d6fcd4f@redhat.com>
 <b6b4f7fb-65bf-9b2d-fc0c-63456e70af6f@redhat.com>
Date: Fri, 28 Feb 2020 18:41:17 +0100
In-Reply-To: <b6b4f7fb-65bf-9b2d-fc0c-63456e70af6f@redhat.com> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Fri, 28 Feb 2020 10:57:07
 +0100")
Message-ID: <87tv3ahao2.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
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
Cc: Kevin Wolf <kwolf@redhat.com>, Stefan Weil <sw@weilnetz.de>,
 Alistair Francis <alistair@alistair23.me>, qemu-devel@nongnu.org,
 Michael Roth <mdroth@linux.vnet.ibm.com>,
 =?utf-8?B?VG9tw6HFoSBHb2xlbWJpb3Zza8O9?= <tgolembi@redhat.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:

> On 2/28/20 10:50 AM, Philippe Mathieu-Daud=C3=A9 wrote:
[...]
>> Thanks for your review. I'll drop the changes in util/oslib-win32.c
>> for for now, and add a note in my TODO for after the 5.0 release.
>
> Well if I follow this line, I'v to drop the changes in util/osdep.c too.
> Maybe we can keep fprintf() for now and improve the error message, and
> do the fprintf -> error_report cleanup later?

I recommend to convert from fprintf() to error_report() & friends and
improve the message all in one go.

Separating different kinds of changes makes sense when some kinds are
mechanical and the resulting mechanical patches are large.  These
patches aren't large.

But it's really up to you.  I'm not going to veto an improvement only
because further improvement is called for.


