Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFE03C28CBC
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 13:54:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 426B92063A
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 13:54:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MJKNEXPl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 426B92063A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57532 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jU9dZ-0000pN-Dw
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 09:54:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49888)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jU9TR-0001On-KU
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 09:45:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jU9Qv-0000LL-Tx
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 09:43:33 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:20795
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jU9Qv-0000KP-CD
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 09:40:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588254055;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=M6F8e3oOHGsnHHiYexv8ZNzGtOOo0dGFGHA987TH518=;
 b=MJKNEXPlWzsaz8PlJpNs7exbuEHmmEHIEhasI8nFpZQzA8QVGYbktgM+VUXKE7MX7F77rJ
 U1+f/pdfFvcmXdBsGoFULOJZU89dC2PHi/Em1XFwkir4E2lU/kMi30XZlEkSXvh0HNjoM8
 jOqqrmmPyGLHl+jhWNA3evXlMluuvrw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-345-zdqDg4dfOKms8EUNT9-YsA-1; Thu, 30 Apr 2020 09:40:53 -0400
X-MC-Unique: zdqDg4dfOKms8EUNT9-YsA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8249F80B702;
 Thu, 30 Apr 2020 13:40:52 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-113-6.ams2.redhat.com [10.36.113.6])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 501151E4;
 Thu, 30 Apr 2020 13:40:52 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id CFAE511358BC; Thu, 30 Apr 2020 15:40:50 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Subject: Re: [PATCH] tests: add a "check-flake8" test for validating python
 code style
References: <20200429153621.1694266-1-berrange@redhat.com>
 <874kt1im1c.fsf@dusky.pond.sub.org>
 <20200430085515.GE2084570@redhat.com>
Date: Thu, 30 Apr 2020 15:40:50 +0200
In-Reply-To: <20200430085515.GE2084570@redhat.com> ("Daniel P. =?utf-8?Q?B?=
 =?utf-8?Q?errang=C3=A9=22's?=
 message of "Thu, 30 Apr 2020 09:55:15 +0100")
Message-ID: <87k11xdrbx.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.120; envelope-from=armbru@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/29 23:34:52
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
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
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> On Thu, Apr 30, 2020 at 07:23:59AM +0200, Markus Armbruster wrote:
>> Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:
>> > +check-flake8:
>> > +=09$(call quiet-command,flake8 --ignore=3D$(FLAKE8_IGNORE) $(PYTHON_F=
ILES))
>> > +else
>> > +check-flake8:
>> > +endif
>> > +
>> > +check: check-block check-qapi-schema check-unit check-softfloat check=
-qtest check-decodetree check-flake8
>> >  check-clean:
>> >  =09rm -rf $(check-unit-y) tests/*.o tests/*/*.o $(QEMU_IOTESTS_HELPER=
S-y)
>> >  =09rm -rf $(sort $(foreach target,$(SYSEMU_TARGET_LIST), $(check-qtes=
t-$(target)-y:%=3Dtests/qtest/%$(EXESUF))) $(check-qtest-generic-y:%=3Dtest=
s/qtest/%$(EXESUF)))
>>=20
>> The QAPI generator is already clean except for
>> F403,F405,E241,W503,W504,E226,E501,E261.  The new automated cleanliness
>> test is next to useless for keeping it that way.  How could we tailor it
>> to solve that?
>
> We would have to run flake8 multiple times, passing different exclusions
> for different sets of files.  This wouldn't be too bad as long as we don'=
t
> get too many different sets of files. We could split it into iotests,
> qapi and misc for example.

Sounds good to me!


