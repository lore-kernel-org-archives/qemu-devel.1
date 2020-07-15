Return-Path: <SRS0=mmJ2=A2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15BB3C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2020 14:43:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D347A20658
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2020 14:42:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UvXugOqU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D347A20658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50344 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvicd-0006Wl-62
	for qemu-devel@archiver.kernel.org; Wed, 15 Jul 2020 10:42:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55972)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jvibo-0005wr-P1
 for qemu-devel@nongnu.org; Wed, 15 Jul 2020 10:42:08 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:33233
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jvibm-0006yx-Ou
 for qemu-devel@nongnu.org; Wed, 15 Jul 2020 10:42:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594824125;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8kfqOhXnPnf+UyFn8mp8BmKwKeI7wjv8FW71ouctYZ4=;
 b=UvXugOqUMz1tb1aHXS+wF/og4RgbCdxz4HJJyxwSHB93M0W1T6s3DaIetedKKorGU2mPOU
 972l/06U7kAFutpvkVwusBf8BvTFiiKdClUbnC729bVMR/LC0wS9oZ8YmAb5eypc/sOvDC
 P3zXHCa7Mi7kaH9KedJ8B7IUkjdX8oc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-438-Gx7VUQYKNBSbSnJxRP6ccA-1; Wed, 15 Jul 2020 10:42:00 -0400
X-MC-Unique: Gx7VUQYKNBSbSnJxRP6ccA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7905819200C0;
 Wed, 15 Jul 2020 14:41:58 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-143.ams2.redhat.com
 [10.36.112.143])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4277219C4F;
 Wed, 15 Jul 2020 14:41:58 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id BE12D11386A6; Wed, 15 Jul 2020 16:41:56 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Subject: Re: [PATCH for-5.1 1/2] msf2: Unbreak device-list-properties for
 "msf-soc"
References: <20200715140440.3540942-1-armbru@redhat.com>
 <20200715140440.3540942-2-armbru@redhat.com>
 <ef1d7fe4-0558-cc7b-16d7-906c4aa9915b@amsat.org>
Date: Wed, 15 Jul 2020 16:41:56 +0200
In-Reply-To: <ef1d7fe4-0558-cc7b-16d7-906c4aa9915b@amsat.org> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Wed, 15 Jul 2020 16:15:51
 +0200")
Message-ID: <87wo34u9fv.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.61; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/15 02:37:03
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=unavailable autolearn_force=no
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
Cc: peter.maydell@linaro.org, thuth@redhat.com, qemu-riscv@nongnu.org,
 sagark@eecs.berkeley.edu, kbastian@mail.uni-paderborn.de,
 alistair@alistair23.me, mark.cave-ayland@ilande.co.uk, qemu-devel@nongnu.org,
 sundeep.lkml@gmail.com, b.galvani@gmail.com, nieklinnenbank@gmail.com,
 qemu-arm@nongnu.org, palmer@dabbelt.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> writes:

> On 7/15/20 4:04 PM, Markus Armbruster wrote:
>> Watch this:
>>=20
>>     $ qemu-system-aarch64 -M ast2600-evb -S -display none -qmp stdio
>>     {"QMP": {"version": {"qemu": {"micro": 50, "minor": 0, "major": 5}, =
"package": "v5.0.0-2464-g3a9163af4e"}, "capabilities": ["oob"]}}
>>     {"execute": "qmp_capabilities"}
>>     {"return": {}}
>>     {"execute": "device-list-properties", "arguments": {"typename": "msf=
2-soc"}}
>>     Unsupported NIC model: ftgmac100
>>     armbru@dusky:~/work/images$ echo $?
>>     1
>>=20
>> This is what breaks "make check SPEED=3Dslow".
>>=20
>> Root cause is m2sxxx_soc_initfn()'s messing with nd_table[] via
>> qemu_check_nic_model().  That's wrong.
>>=20
>> We fixed the exact same bug for device "allwinner-a10" in commit
>> 8aabc5437b "hw/arm/allwinner-a10: Do not use nd_table in instance_init
>> function".  Fix this instance the same way: move the offending code to
>> m2sxxx_soc_realize(), where it's less wrong, and add a FIXME comment.
>
> That addresses this other thread, right?
> https://www.mail-archive.com/qemu-devel@nongnu.org/msg720658.html

Correct!  I wasn't aware of it, thanks for making the connection.


