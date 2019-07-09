Return-Path: <SRS0=huOX=VG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37D5BC606B0
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2019 05:47:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F76C2073D
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2019 05:47:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F76C2073D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46922 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hkiyG-00048X-MN
	for qemu-devel@archiver.kernel.org; Tue, 09 Jul 2019 01:47:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52589)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <armbru@redhat.com>) id 1hkixi-0003jR-Es
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 01:46:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1hkixg-0005bv-I4
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 01:46:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:12001)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hkixg-0005am-Ah
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 01:46:44 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id E7E5A59455;
 Tue,  9 Jul 2019 05:40:14 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-111.ams2.redhat.com
 [10.36.116.111])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 08F023AD1;
 Tue,  9 Jul 2019 05:40:13 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 6D99B1138648; Tue,  9 Jul 2019 07:40:12 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Stefan Weil <sw@weilnetz.de>
References: <1534182832-554-1-git-send-email-aleksandar.markovic@rt-rk.com>
 <1534182832-554-5-git-send-email-aleksandar.markovic@rt-rk.com>
 <4da49ffe-902f-2cf2-8a21-2bbd511b17a4@weilnetz.de>
 <87imsdcf5l.fsf@dusky.pond.sub.org>
 <7e6fb611-ef18-459a-4676-3c10c2f41249@weilnetz.de>
Date: Tue, 09 Jul 2019 07:40:12 +0200
In-Reply-To: <7e6fb611-ef18-459a-4676-3c10c2f41249@weilnetz.de> (Stefan Weil's
 message of "Mon, 8 Jul 2019 06:52:38 +0200")
Message-ID: <874l3vbwar.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.39]); Tue, 09 Jul 2019 05:40:20 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] Handling of fall through code
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
Cc: peter.maydell@linaro.org, pburton@wavecomp.com, smarkovic@wavecomp.com,
 riku.voipio@iki.fi, richard.henderson@linaro.org, qemu-devel@nongnu.org,
 laurent@vivier.eu, Aleksandar Markovic <aleksandar.markovic@rt-rk.com>,
 philippe.mathieu.daude@gmail.com, amarkovic@wavecomp.com,
 pjovanovic@wavecomp.com, aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Stefan Weil <sw@weilnetz.de> writes:

> Am 08.07.19 um 06:40 schrieb Markus Armbruster:
>
[...]
>> However, the gnu_ in gnu_scanf tells the compiler we're linking with the
>> GNU C Library, which seems unwise.  Hmm, we already use gnu_printf.
>> Commit 9c9e7d51bf0:
>>
>>      Newer gcc versions support format gnu_printf which is
>>      better suited for use in QEMU than format printf
>>      (QEMU always uses standard format strings (even with mingw32)).
>>
>> Should we limit the use of gnu_printf to #ifdef _WIN32?
>
>
> No, because we don't want lots of conditional code with different
> format strings for POSIX and Windows (I made that commit 9 years ago).

I'm afraid I failed to express myself clearly.

I'm not proposing to conditionally use MS conversion specifications
instead of ISO C ones.  That's mess we can do without indeed.

The documentation of gnu_printf vs. plain printf format attribute in
"The GNU Compiler Collection" made me expect gnu_printf accepts
extensions over ISO C provided by glibc, while plain printf rejects
them.  Since we don't require glibc, catching use of extensions would be
useful, even if we still had to use gnu_printf with MinGW.  However, it
appears not to be the case (I tried on Fedora 30).

[...]

