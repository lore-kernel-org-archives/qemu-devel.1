Return-Path: <SRS0=7MIY=3D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C98A8C33CB2
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 10:02:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9884B2465B
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 10:02:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FQdFD+uw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9884B2465B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35816 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irJ1p-0002Lw-8W
	for qemu-devel@archiver.kernel.org; Tue, 14 Jan 2020 05:02:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36218)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1irIzq-0000J0-1G
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 05:00:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1irIzm-0007hE-OF
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 05:00:23 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:26286
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1irIzm-0007gD-KO
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 05:00:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578996019;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AdW706mGMELjFKPefet8+wZuDp3fcXCwxLlEEhjT1T4=;
 b=FQdFD+uwjI84rVYmRZP1XdEynqHmZ91UYyIaEw+ycDOZ0dAhZCpUJO46dW4uxrdErC0LQC
 PV6XtXXFwMUwmI4GBe86SApqofGwEdQSTYqo+Jg6Q/FcZ+lMpeE4KDdvzz7f/HpioGD/Na
 0UCnbMVo6Ptjtksn/71gvOfJSo5JU28=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-97-j82rfiFJOuivhsrvKKVAWQ-1; Tue, 14 Jan 2020 05:00:16 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CC9E110054E3;
 Tue, 14 Jan 2020 10:00:15 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-131.ams2.redhat.com
 [10.36.116.131])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 910ED843F4;
 Tue, 14 Jan 2020 10:00:15 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 1C0A61138600; Tue, 14 Jan 2020 11:00:14 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Juan Quintela <quintela@redhat.com>
Subject: Re: [PATCH v3 1/2] migration: Fix incorrect integer->float conversion
 caught by clang
References: <20191122080039.12771-1-armbru@redhat.com>
 <20191122080039.12771-2-armbru@redhat.com> <87zhgoi93z.fsf@trasno.org>
 <87r220qa5p.fsf@dusky.pond.sub.org>
Date: Tue, 14 Jan 2020 11:00:14 +0100
In-Reply-To: <87r220qa5p.fsf@dusky.pond.sub.org> (Markus Armbruster's message
 of "Fri, 22 Nov 2019 15:05:06 +0100")
Message-ID: <874kwygxxt.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: j82rfiFJOuivhsrvKKVAWQ-1
X-Mimecast-Spam-Score: 0
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
Cc: Fangrui Song <i@maskray.me>, richard.henderson@linaro.org,
 qemu-devel@nongnu.org, dgilbert@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Markus Armbruster <armbru@redhat.com> writes:

> Juan Quintela <quintela@redhat.com> writes:
>
>> Markus Armbruster <armbru@redhat.com> wrote:
>>> From: Fangrui Song <i@maskray.me>
>>>
>>> Clang does not like qmp_migrate_set_downtime()'s code to clamp double
>>> @value to 0..INT64_MAX:
>>>
>>>     qemu/migration/migration.c:2038:24: error: implicit conversion from=
 'long' to 'double' changes value from 9223372036854775807 to 9223372036854=
775808 [-Werror,-Wimplicit-int-float-conversion]
>>>
>>> The warning will be enabled by default in clang 10. It is not
>>> available for clang <=3D 9.
>>>
>>> The clamp is actually useless; @value is checked to be within
>>> 0..MAX_MIGRATE_DOWNTIME_SECONDS immediately before.  Delete it.
>>>
>>> While there, make the conversion from double to int64_t explicit.
>>>
>>> Signed-off-by: Fangrui Song <i@maskray.me>
>>> Reviewed-by: Markus Armbruster <armbru@redhat.com>
>>> [Patch split, commit message improved]
>>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>>
>> Reviewed-by: Juan Quintela <quintela@redhat.com>
>>
>> Should I get this through migration tree, or are you going to pull it?
>
> Plase take this patch through the migration tree.

Ping...


