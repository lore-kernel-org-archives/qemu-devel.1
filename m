Return-Path: <SRS0=hU7S=42=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A440C10F27
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 12:39:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D73D420674
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 12:39:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RBQBNnqO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D73D420674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42434 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBHgh-0002xr-08
	for qemu-devel@archiver.kernel.org; Mon, 09 Mar 2020 08:39:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60277)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jBHcX-0004YE-0c
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 08:34:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1jBHcV-0006Vd-UH
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 08:34:56 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:32972
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1jBHcV-0006T8-QB
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 08:34:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583757295;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nvE84SjIEINbSofldnNVBPWQUJRXlT4nsJTPlXlSPSE=;
 b=RBQBNnqOLYLCVZq0uJ3fkM3W69rDGIlqZDEZgc6sNKeZO1pevTXBAmRompzeP1m4psevwn
 V3Y9CTrD2fTR8VzDaFOXV1/4HosD6unttjN4B0/8elxp0g9zsphF03r4qrI2mYPQfGGO5X
 6ygnjeFtK3mt/XWuj1sUxigv80RqMqM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-259-GskMCi-9NHSLFictMMl1Nw-1; Mon, 09 Mar 2020 08:34:52 -0400
X-MC-Unique: GskMCi-9NHSLFictMMl1Nw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E744618A8C81;
 Mon,  9 Mar 2020 12:34:49 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-34.ams2.redhat.com
 [10.36.116.34])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1CD0F1001B3F;
 Mon,  9 Mar 2020 12:34:49 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 9FC8011386A6; Mon,  9 Mar 2020 13:34:47 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH v4 2/3] mac_via: fix incorrect creation of mos6522 device
 in mac_via
References: <20200305065422.12707-1-pannengyuan@huawei.com>
 <20200305065422.12707-3-pannengyuan@huawei.com>
 <CAFEAcA_twjUHpvf5ZpzA_bKyf8MZ4BuSY0MvNTgSEyVTYf9mXQ@mail.gmail.com>
 <0b2d3222-d122-e0db-db04-1c4e3028f8f8@huawei.com>
 <CAFEAcA9PQd=PwuF+j=3kOA_eCiRd_8TLEwPx8qB-jWvV_9CcMQ@mail.gmail.com>
 <0c3ae5aa-36c3-a809-4a42-159348f44780@huawei.com>
 <CAFEAcA8_RkECOT=YJ3ML0wxBrKiqVw=CssORU=jyryfcNueB0w@mail.gmail.com>
Date: Mon, 09 Mar 2020 13:34:47 +0100
In-Reply-To: <CAFEAcA8_RkECOT=YJ3ML0wxBrKiqVw=CssORU=jyryfcNueB0w@mail.gmail.com>
 (Peter Maydell's message of "Mon, 9 Mar 2020 10:10:07 +0000")
Message-ID: <87a74pso48.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
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
Cc: zhanghailiang <zhang.zhanghailiang@huawei.com>,
 Pan Nengyuan <pannengyuan@huawei.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 QEMU Developers <qemu-devel@nongnu.org>, Laurent Vivier <laurent@vivier.eu>,
 Euler Robot <euler.robot@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Peter Maydell <peter.maydell@linaro.org> writes:

> On Mon, 9 Mar 2020 at 10:02, Pan Nengyuan <pannengyuan@huawei.com> wrote:
>> On 3/9/2020 5:21 PM, Peter Maydell wrote:
>> > Could you explain more? My thought is that we should be using
>> > sysbus_init_child_obj() and we should be doing it in the init method.
>> > Why does that break the tests ? It's the same thing various other
>> > devices do.
>>
>> device-introspect-test do the follow check for each device type:
>>
>>     qtree_start =3D qtest_hmp(qts, "info qtree");
>>     ...
>>     qtest_qmp(qts, "{'execute': 'device-list-properties','arguments': {'=
typename': %s}}", type);
>>     ...
>>     qtree_end =3D qtest_hmp(qts, "info qtree");
>>     g_assert_cmpstr(qtree_start, =3D=3D, qtree_end);
>>
>> If we do qdev_set_parent_bus in init, it will check fail when type =3D '=
mac_via'.
>> mac_via_init() is called by q800_init(). But it will not be called in qt=
est(-machine none) in the step qtree_start.
>> And after we call 'device-list-properties', mac_via_init() was called an=
d set dev parent bus. We can find these
>> devices in the qtree_end. So it break the test on the assert.
>
> Markus, do you know what's happening here? Why is
> trying to use sysbus_init_child_obj() breaking the
> device-introspect-test for this particular device,
> but fine for the other places where we use it?
> (Maybe we're accidentally leaking a reference to
> something so the sub-device stays on the sysbus
> when it should have removed itself when the
> device was deinited ?)

Pan Nengyuan, please provide the exact patch that fails for you.


