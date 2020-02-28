Return-Path: <SRS0=EIn8=4Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50C22C3F2D0
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 09:10:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 143C5246A2
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 09:10:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CncMMIG3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 143C5246A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43882 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7bet-00017u-6V
	for qemu-devel@archiver.kernel.org; Fri, 28 Feb 2020 04:10:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48642)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <quintela@redhat.com>) id 1j7beJ-0000gL-BN
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 04:09:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <quintela@redhat.com>) id 1j7beH-00042L-89
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 04:09:34 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:57908
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <quintela@redhat.com>) id 1j7beH-00040q-1H
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 04:09:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582880972;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FWl0WKcJ9dQO0k55Ts5hv7Wk7YLffW+ijB8JO79CDXs=;
 b=CncMMIG3wKkqTPMUjSsXJZ18WW8lPFVLVZRuPzwDdhdL1rNJY8AzWPCcGQf90sge0eZeXX
 wiC0s6Uw93C/B5+iV5IGdYLyrIdNEyTjA6J99EF0Owzbcf/VRFAsrWM42YsTAW/lK2fRbc
 918CFGVIlj83Gt37zOVROibf6fFgvjE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-360-iSzOCTmNOnWBblBUuWyXCg-1; Fri, 28 Feb 2020 04:09:30 -0500
X-MC-Unique: iSzOCTmNOnWBblBUuWyXCg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5EB2613E4;
 Fri, 28 Feb 2020 09:09:29 +0000 (UTC)
Received: from redhat.com (ovpn-116-72.ams2.redhat.com [10.36.116.72])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B763090539;
 Fri, 28 Feb 2020 09:09:28 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Subject: Re: [PATCH v2 3/3] savevm: check RAM is pagesize aligned
In-Reply-To: <CAL1e-=h+SkEPy1VVvdNeo9T1mAT5-dA7orsj0TFtfDsTofwzFg@mail.gmail.com>
 (Aleksandar Markovic's message of "Thu, 27 Feb 2020 22:00:27 +0100")
References: <20200103074000.1006389-1-marcandre.lureau@redhat.com>
 <20200103074000.1006389-4-marcandre.lureau@redhat.com>
 <8736cqi07g.fsf@secure.laptop>
 <CAJ+F1CLgg6Yz=2V8_eCVtsJ1zPm=1-piz-Nw05KGXkSqWytLgA@mail.gmail.com>
 <87r1yfc1q1.fsf@secure.laptop>
 <CAL1e-=h+SkEPy1VVvdNeo9T1mAT5-dA7orsj0TFtfDsTofwzFg@mail.gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
Date: Fri, 28 Feb 2020 10:09:23 +0100
Message-ID: <87mu9384e4.fsf@secure.laptop>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Reply-To: quintela@redhat.com
Cc: QEMU <qemu-devel@nongnu.org>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Stefan Berger <stefanb@linux.ibm.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Aleksandar Markovic <aleksandar.m.mail@gmail.com> wrote:
> On Thursday, February 27, 2020, Juan Quintela <quintela@redhat.com> wrote=
:
>
>  Marc-Andr=C3=A9 Lureau <marcandre.lureau@gmail.com> wrote:
>  > Hi Juan
>  >
>  > On Wed, Jan 8, 2020 at 2:08 PM Juan Quintela <quintela@redhat.com> wro=
te:
>  >>
>  >> Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> wrote:
>  >> n> Check the host pointer is correctly aligned, otherwise we may fail
>  >> > during migration in ram_block_discard_range().
>  >> >
>  >> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>  >>
>  >> Reviewed-by: Juan Quintela <quintela@redhat.com>
>  >>
>  >> queued
>  >>
>  >
>  > Did it get lost? thanks
>
>  I dropped it in the past, because it made "make check" for mips fail.
>  (I put it on my ToDo list to investigate and forgot about it)
>
> Thank you for caring for mips.
>
> Do you perhaps remember what was tgevtest and environment for the failing=
 test?


And here we are again.
I only compile on an x86 32bit host when I am going to do a pull
request.

qemu-system-mips64el: /mnt/code/qemu/full/migration/savevm.c:2923: vmstate_=
register_ram: Assertion `QEMU_PTR_IS_ALIGNED(qemu_ram
_get_host_addr(rb), qemu_ram_pagesize(rb))' failed.
Broken pipe
/mnt/code/qemu/full/tests/qtest/libqtest.c:175: kill_qemu() detected QEMU d=
eath from signal 6 (Aborted) (core dumped)
  TEST    check-qtest-aarch64: tests/qtest/qom-test
ERROR - too few tests run (expected 4, got 0)
make: *** [/mnt/code/qemu/full/tests/Makefile.include:632: check-qtest-mips=
64el] Error 1
make: *** Waiting for unfinished jobs....


As you can see, this is mips tcg running in a 32bit host.

$ export QTEST_QEMU_BINARY=3D./mips64el-softmmu/qemu-system-mips64el=20
$ ./tests/qtest/qom-test
/mips64el/qom/pica61: OK
/mips64el/qom/mipssim: OK
/mips64el/qom/mips: OK
/mips64el/qom/fulong2e: OK
/mips64el/qom/malta: OK
/mips64el/qom/boston: OK
/mips64el/qom/none: OK
/mips64el/qom/magnum: qemu-system-mips64el: /mnt/code/qemu/full/migration/s=
avevm.c:2923: vmstate_register_ram: Assertion `QEMU_PTR_IS_ALIGNED(qemu_ram=
_get_host_addr(rb), qemu_ram_pagesize(rb))' failed.
Broken pipe
/mnt/code/qemu/full/tests/qtest/libqtest.c:175: kill_qemu() detected QEMU d=
eath from signal 6 (Aborted) (core dumped)
Aborted (core dumped)
$=20

Can you take a look at this?

mips64-softmmu also fails on the same place, mips[el]-softmmu passes,
but they don't use magnum.

Code is supposed to be right, I will expect that the problem is in the
magnum board, but this is qemu + mips + migration.  Anything can happen.

Marc, I have to drop it again.

Later, Juan.


