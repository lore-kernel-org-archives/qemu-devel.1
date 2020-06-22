Return-Path: <SRS0=TEh4=AD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DE26C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 08:28:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2964020706
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 08:28:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="apXXoyfl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2964020706
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37240 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnHoV-00053o-Ex
	for qemu-devel@archiver.kernel.org; Mon, 22 Jun 2020 04:28:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33214)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jnHnj-000431-9t
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 04:27:35 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:40824
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jnHnh-0008VT-PG
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 04:27:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592814452;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=OMPREXxFjD4Kng8k0SaVlZaM1LU932FfdMdibCejhWo=;
 b=apXXoyflOUUK0alf9zbuBaDPP/U2vQuujn3IrKXMtWxh9Q/TNBHnXcHv3Uet4JfwynKvdF
 ogUd5iBKxQTjuQUv508Hsq6LHnUksZo76DSB7D0UK/2P90LVddSEJrfG311D/BYy3FfIqZ
 1E1JwuB0e3BgKy8W0tN77KaHGv89uSE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-319-e2CW-ZuCMuaC9Abg2vKMcg-1; Mon, 22 Jun 2020 04:27:28 -0400
X-MC-Unique: e2CW-ZuCMuaC9Abg2vKMcg-1
Received: by mail-wm1-f72.google.com with SMTP id g187so2771547wme.0
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2020 01:27:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=OMPREXxFjD4Kng8k0SaVlZaM1LU932FfdMdibCejhWo=;
 b=gTxFrjYThAieSxztkYMn7HxkloTZXns23ts4Xjr/8QTC+W1KW+d5FKx4Zo8x+D9mq1
 0irKlumvVAVph0Jh87YbSAFmtDUbJmEGdrxO3aOwI/nnzFXq7iNvLDBrIVUzkhc2jTr/
 88bLqaNq2xjAEkeGzGt0+gBDffhyylJft7dmbEb3JxBPACHP+3aSbLGjYYkHVXaADAHy
 E6qWbW4YBLqu/y96RYvuzYsNFKTHxrnmYbB3nFT1VhELh/gLcou2KFKacO2/qRmgYKaE
 C6l536ujjs4SYiWYYsIb2FUCbkmdTO7J6cZ3aAfeQdw8Fd9FN4j3yeEVibLl0tP7whXR
 LCnQ==
X-Gm-Message-State: AOAM5331YkUVd3c5w04YfinldGypGozlbr913OkEK4C64uwS44qGIGVE
 K3lVt5aSyEK4cH6YEqJug7ngaIsSQPEG96KeQeztB66+CH+owMNp9IHpSd+O9w8okK6fyQBNt6a
 NBNy9xfGbOoJdi8s=
X-Received: by 2002:a5d:404e:: with SMTP id w14mr15455636wrp.268.1592814447589; 
 Mon, 22 Jun 2020 01:27:27 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz9i1TwjwT/FZGW3Fq27GUQ0G38xdGy//jbc0rpD4PdbWKBtsweTuJ/Px5wAKyJ0UVaMJP8hQ==
X-Received: by 2002:a5d:404e:: with SMTP id w14mr15455608wrp.268.1592814447309; 
 Mon, 22 Jun 2020 01:27:27 -0700 (PDT)
Received: from [192.168.1.39] (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id g3sm18713706wrb.46.2020.06.22.01.27.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 Jun 2020 01:27:26 -0700 (PDT)
Subject: Re: [PULL 10/10] ppc/pnv: Create BMC devices only when defaults are
 enabled
To: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
 David Gibson <david@gibson.dropbear.id.au>
References: <20200407043606.291546-1-david@gibson.dropbear.id.au>
 <20200407043606.291546-11-david@gibson.dropbear.id.au>
 <CAP+75-UdJ9iT7T5ABETzdh38tLfM3ZB3OXtxc-WUu9zr93RYcA@mail.gmail.com>
 <919a0804-3ea0-dc05-c789-224919be66c8@kaod.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Autocrypt: addr=philmd@redhat.com; keydata=
 mQINBDXML8YBEADXCtUkDBKQvNsQA7sDpw6YLE/1tKHwm24A1au9Hfy/OFmkpzo+MD+dYc+7
 bvnqWAeGweq2SDq8zbzFZ1gJBd6+e5v1a/UrTxvwBk51yEkadrpRbi+r2bDpTJwXc/uEtYAB
 GvsTZMtiQVA4kRID1KCdgLa3zztPLCj5H1VZhqZsiGvXa/nMIlhvacRXdbgllPPJ72cLUkXf
 z1Zu4AkEKpccZaJspmLWGSzGu6UTZ7UfVeR2Hcc2KI9oZB1qthmZ1+PZyGZ/Dy+z+zklC0xl
 XIpQPmnfy9+/1hj1LzJ+pe3HzEodtlVA+rdttSvA6nmHKIt8Ul6b/h1DFTmUT1lN1WbAGxmg
 CH1O26cz5nTrzdjoqC/b8PpZiT0kO5MKKgiu5S4PRIxW2+RA4H9nq7nztNZ1Y39bDpzwE5Sp
 bDHzd5owmLxMLZAINtCtQuRbSOcMjZlg4zohA9TQP9krGIk+qTR+H4CV22sWldSkVtsoTaA2
 qNeSJhfHQY0TyQvFbqRsSNIe2gTDzzEQ8itsmdHHE/yzhcCVvlUzXhAT6pIN0OT+cdsTTfif
 MIcDboys92auTuJ7U+4jWF1+WUaJ8gDL69ThAsu7mGDBbm80P3vvUZ4fQM14NkxOnuGRrJxO
 qjWNJ2ZUxgyHAh5TCxMLKWZoL5hpnvx3dF3Ti9HW2dsUUWICSQARAQABtDJQaGlsaXBwZSBN
 YXRoaWV1LURhdWTDqSAoUGhpbCkgPHBoaWxtZEByZWRoYXQuY29tPokCVQQTAQgAPwIbDwYL
 CQgHAwIGFQgCCQoLBBYCAwECHgECF4AWIQSJweePYB7obIZ0lcuio/1u3q3A3gUCXsfWwAUJ
 KtymWgAKCRCio/1u3q3A3ircD/9Vjh3aFNJ3uF3hddeoFg1H038wZr/xi8/rX27M1Vj2j9VH
 0B8Olp4KUQw/hyO6kUxqkoojmzRpmzvlpZ0cUiZJo2bQIWnvScyHxFCv33kHe+YEIqoJlaQc
 JfKYlbCoubz+02E2A6bFD9+BvCY0LBbEj5POwyKGiDMjHKCGuzSuDRbCn0Mz4kCa7nFMF5Jv
 piC+JemRdiBd6102ThqgIsyGEBXuf1sy0QIVyXgaqr9O2b/0VoXpQId7yY7OJuYYxs7kQoXI
 6WzSMpmuXGkmfxOgbc/L6YbzB0JOriX0iRClxu4dEUg8Bs2pNnr6huY2Ft+qb41RzCJvvMyu
 gS32LfN0bTZ6Qm2A8ayMtUQgnwZDSO23OKgQWZVglGliY3ezHZ6lVwC24Vjkmq/2yBSLakZE
 6DZUjZzCW1nvtRK05ebyK6tofRsx8xB8pL/kcBb9nCuh70aLR+5cmE41X4O+MVJbwfP5s/RW
 9BFSL3qgXuXso/3XuWTQjJJGgKhB6xXjMmb1J4q/h5IuVV4juv1Fem9sfmyrh+Wi5V1IzKI7
 RPJ3KVb937eBgSENk53P0gUorwzUcO+ASEo3Z1cBKkJSPigDbeEjVfXQMzNt0oDRzpQqH2vp
 apo2jHnidWt8BsckuWZpxcZ9+/9obQ55DyVQHGiTN39hkETy3Emdnz1JVHTU0Q==
Message-ID: <22a6705d-3206-3133-eebb-35e8735a48d5@redhat.com>
Date: Mon, 22 Jun 2020 10:27:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <919a0804-3ea0-dc05-c789-224919be66c8@kaod.org>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/22 02:57:26
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Alexey Kardashevskiy <aik@ozlabs.ru>, QEMU Developers <qemu-devel@nongnu.org>,
 Greg Kurz <groug@kaod.org>, "open list:sPAPR" <qemu-ppc@nongnu.org>,
 Nathan Chancellor <natechancellor@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/22/20 9:09 AM, Cédric Le Goater wrote:
> On 6/19/20 8:02 PM, Philippe Mathieu-Daudé wrote:
>> Hi,
>>
>> On Tue, Apr 7, 2020 at 6:42 AM David Gibson <david@gibson.dropbear.id.au> wrote:
>>>
>>> From: Cédric Le Goater <clg@kaod.org>
>>>
>>> Commit e2392d4395dd ("ppc/pnv: Create BMC devices at machine init")
>>> introduced default BMC devices which can be a problem when the same
>>> devices are defined on the command line with :
>>>
>>>   -device ipmi-bmc-sim,id=bmc0 -device isa-ipmi-bt,bmc=bmc0,irq=10
>>>
>>> QEMU fails with :
>>>
>>>   qemu-system-ppc64: error creating device tree: node: FDT_ERR_EXISTS
>>>
>>> Use defaults_enabled() when creating the default BMC devices to let
>>> the user provide its own BMC devices using '-nodefaults'. If no BMC
>>> device are provided, output a warning but let QEMU run as this is a
>>> supported configuration. However, when multiple BMC devices are
>>> defined, stop QEMU with a clear error as the results are unexpected.
>>>
>>> Fixes: e2392d4395dd ("ppc/pnv: Create BMC devices at machine init")
>>> Reported-by: Nathan Chancellor <natechancellor@gmail.com>
>>> Signed-off-by: Cédric Le Goater <clg@kaod.org>
>>> Message-Id: <20200404153655.166834-1-clg@kaod.org>
>>> Tested-by: Nathan Chancellor <natechancellor@gmail.com>
>>> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
>>> ---
>>
>> Not sure if directly related to this patch, but on gitlab-ci we get:
>>
>> TEST check-qtest-ppc64: tests/qtest/m48t59-test
>> TEST check-qtest-ppc64: tests/qtest/device-plug-test
>> TEST check-qtest-ppc64: tests/qtest/pnv-xscom-test
>> TEST check-qtest-ppc64: tests/qtest/migration-test
>> TEST check-qtest-ppc64: tests/qtest/rtas-test
>> TEST check-qtest-ppc64: tests/qtest/usb-hcd-uhci-test
>> TEST check-qtest-ppc64: tests/qtest/usb-hcd-xhci-test
>> TEST check-qtest-ppc64: tests/qtest/test-filter-mirror
>> TEST check-qtest-ppc64: tests/qtest/test-filter-redirector
>> TEST check-qtest-ppc64: tests/qtest/display-vga-test
>> TEST check-qtest-ppc64: tests/qtest/numa-test
>> TEST check-qtest-ppc64: tests/qtest/ivshmem-test
>> TEST check-qtest-ppc64: tests/qtest/cpu-plug-test
>> TEST check-qtest-ppc64: tests/qtest/cdrom-test
>> TEST check-qtest-ppc64: tests/qtest/device-introspect-test
>> qemu-system-ppc64: warning: machine has no BMC device. Use '-device
>> ipmi-bmc-sim,id=bmc0 -device isa-ipmi-bt,bmc=bmc0,irq=10' to define
>> one
>> qemu-system-ppc64: warning: machine has no BMC device. Use '-device
>> ipmi-bmc-sim,id=bmc0 -device isa-ipmi-bt,bmc=bmc0,irq=10' to define
>> one
>> qemu-system-ppc64: warning: machine has no BMC device. Use '-device
>> ipmi-bmc-sim,id=bmc0 -device isa-ipmi-bt,bmc=bmc0,irq=10' to define
>> one
> 
> I can not reproduce. Is gitlab-ci doing something special ? 

(Greg already answered elsewhere, for for other readers):

The test is ran when using:

  $ make check-qtest SPEED=slow


