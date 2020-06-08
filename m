Return-Path: <SRS0=zEF8=7V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD77AC433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 05:21:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 834202074B
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 05:21:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OCBqVJVe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 834202074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38076 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jiAE5-0000sn-OR
	for qemu-devel@archiver.kernel.org; Mon, 08 Jun 2020 01:21:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56458)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jiADJ-0000Lk-6Q
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 01:20:49 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:53110
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jiADI-0004ZQ-GE
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 01:20:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591593647;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9DteUfW1Igl0WBPybwJBLgHplQlskIiWgD6mTOB6518=;
 b=OCBqVJVeTJkXFp/+m+DgNqifxBbodCulaIFvreBso5syXfgCGFZQ03QH7KSzQtD83ari4u
 l5blV5PX9mD2DHW4QdcVd9fwaiZ6zneFasozGSRSqJPQU58c15q8xD4lva9t5dPWQol7fn
 62uiMYK4CxwbnZen6BLJ4pYP/F0UI1c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-484-RWOBGdVpMYKL73FJl47URQ-1; Mon, 08 Jun 2020 01:20:43 -0400
X-MC-Unique: RWOBGdVpMYKL73FJl47URQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9FD02464;
 Mon,  8 Jun 2020 05:20:42 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-121.ams2.redhat.com
 [10.36.112.121])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6A28D5C557;
 Mon,  8 Jun 2020 05:20:42 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id DA79B11386A6; Mon,  8 Jun 2020 07:20:40 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: [PATCH 13/16] qdev: Make qdev_prop_set_drive() match the other
 helpers
References: <20200605145625.2920920-1-armbru@redhat.com>
 <20200605145625.2920920-14-armbru@redhat.com>
 <71a59dd5-9cea-9474-e318-4da3cb4f107b@redhat.com>
Date: Mon, 08 Jun 2020 07:20:40 +0200
In-Reply-To: <71a59dd5-9cea-9474-e318-4da3cb4f107b@redhat.com> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Fri, 5 Jun 2020 17:33:07
 +0200")
Message-ID: <87v9k2xhef.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.61; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/08 01:20:45
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: kwolf@redhat.com, berrange@redhat.com, ehabkost@redhat.com,
 qemu-block@nongnu.org, qemu-devel@nongnu.org, mreitz@redhat.com,
 pbonzini@redhat.com, jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:

> On 6/5/20 4:56 PM, Markus Armbruster wrote:
>> qdev_prop_set_drive() can fail.  None of the other qdev_prop_set_FOO()
>> can; they abort on error.
>>=20
>> To clean up this inconsistency, rename qdev_prop_set_drive() to
>> qdev_prop_set_drive_err(), and create a qdev_prop_set_drive() that
>> aborts on error.
>>=20
>> Coccinelle script to update callers:
>>=20
>>     @ depends on !(file in "hw/core/qdev-properties-system.c")@
>>     expression dev, name, value;
>>     symbol error_abort;
>>     @@
>>     -    qdev_prop_set_drive(dev, name, value, &error_abort);
>>     +    qdev_prop_set_drive(dev, name, value);
>
> Why not open-code qdev_prop_set_drive_err(..., &error_abort)?

Consistency with qdev_prop_set_chr() and qdev_prop_set_netdev().

My starting point was "what makes block backends so different that they
need error handling where nothing else does?"

After a considerable amount of digging, my answer is "nothing".
qdev_prop_set_drive(), qdev_prop_set_chr() and qdev_prop_set_netdev()
can all run into errors.  On closer examination, all programming errors
(thus &error_abort), except for "backend is already in use", and to
trigger that one, you have to get creative and steal the backend for
another purpose, e.g. with -global.  This is the abridged version of a
longwinded argument I didn't want to make in this series, so I left the
error handling alone.

In the longer run, I want qdev_prop_set_drive_err() to die.

>
>>=20
>>     @@
>>     expression dev, name, value, errp;
>>     @@
>>     -    qdev_prop_set_drive(dev, name, value, errp);
>>     +    qdev_prop_set_drive_err(dev, name, value, errp);
>>=20
> [...]


