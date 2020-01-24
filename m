Return-Path: <SRS0=z9mi=3N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 081D3C35242
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 09:51:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC416214AF
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 09:51:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A5FwnkZ7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC416214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39462 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuvcI-0004b1-Ud
	for qemu-devel@archiver.kernel.org; Fri, 24 Jan 2020 04:51:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36020)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iuvbY-0003py-8V
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 04:50:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iuvbW-0003J4-Mo
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 04:50:20 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:60612
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iuvbW-0003I5-Ii
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 04:50:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579859417;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=K4MbEmUcjT26ki78wRel742Jm5k5425+QlV0Ts2IY8o=;
 b=A5FwnkZ732vc7/7dDhKkwEzFNrH7Jg2ISWYVNqWx6qgrOMAtFY1votZtYZoRyIfMetBtXB
 lvo2FBYVlTNiBqKpNrQIRIrCsggL+JTh6b+HEJlFi1WBaeCcZ/DIg9/dWtdgCWFQQ+Pmiv
 2/sWKoOz54T+ciHIm0pGcSwlsEjTkwo=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-40-pDRW068zO26idzDfqZuswQ-1; Fri, 24 Jan 2020 04:50:13 -0500
Received: by mail-wr1-f69.google.com with SMTP id z15so917922wrw.0
 for <qemu-devel@nongnu.org>; Fri, 24 Jan 2020 01:50:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=mgid5mXPvk6KVOb6p24Xkfu9zXyL4soPCRdPvTqWdkM=;
 b=DKgh7KM2FoAJ6dq+vBfucBtCes3Bo4dVkQEajTrZQABWgFB997Wu9SyWcAAJRuG5BG
 pXfXZciLAXbLPqyw8g7nTlVsZ5ycyQFJ7PTCVAj5V7KT1bgladMwqit7pC5scKbkUFli
 STZl23a8jjYuw8mW3XMMvt9PPcbQB3Zki5BfxPlxu0Gj5OIZdqthNTa9koG9VqtCi5HR
 O1qJH4KSUgD6IcP/7FrG6HrJOovuDBNPMqJVYwxeyUaI/OvUOrwQEHiaCvKM7/F3bCXI
 N5xFnsbNR8t3WQPoOfmW0WF06UQzy+3oedei8+gIq5+sPrh35Wk3x3VS5gCp73VLTSD3
 DQxg==
X-Gm-Message-State: APjAAAWxk7t+iz2GWk49U414BaUWpfb/wUDNqpotu/13W5okpS4exBfY
 t5/0ZRdxhvjogl/1sIcR2s30pe9NRknbrsT+F75zPli34Gz3lhfI+o3Vhcc/VWNCzCuz6HksevN
 ISgrSyWe0L+m5vyk=
X-Received: by 2002:adf:82e7:: with SMTP id 94mr3608288wrc.60.1579859412127;
 Fri, 24 Jan 2020 01:50:12 -0800 (PST)
X-Google-Smtp-Source: APXvYqwjGnolcGId0nm0hBc6Mg9dhq0NcNe8eCN2JUqG/V7Evhv/ahd0BkXLN9r8De4pauhS4pN5Hg==
X-Received: by 2002:adf:82e7:: with SMTP id 94mr3608266wrc.60.1579859411871;
 Fri, 24 Jan 2020 01:50:11 -0800 (PST)
Received: from [192.168.1.35] (113.red-83-57-172.dynamicip.rima-tde.net.
 [83.57.172.113])
 by smtp.gmail.com with ESMTPSA id 60sm7026786wrn.86.2020.01.24.01.50.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 24 Jan 2020 01:50:11 -0800 (PST)
Subject: Re: [PATCH v3 01/21] migration-test: Use g_free() instead of free()
To: Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org
References: <20200123115831.36842-1-quintela@redhat.com>
 <20200123115831.36842-2-quintela@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <ae7e0c5c-1d6d-60a9-91bf-3e3866af6509@redhat.com>
Date: Fri, 24 Jan 2020 10:50:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200123115831.36842-2-quintela@redhat.com>
Content-Language: en-US
X-MC-Unique: pDRW068zO26idzDfqZuswQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/23/20 12:58 PM, Juan Quintela wrote:
> Signed-off-by: Juan Quintela <quintela@redhat.com>

Nothing changed since v4 (apart it is now v3),
however it misses:

Fixes: b99784ef6c3
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

See:
https://www.mail-archive.com/qemu-devel@nongnu.org/msg672805.html
https://www.mail-archive.com/qemu-devel@nongnu.org/msg672853.html

> ---
>   tests/qtest/migration-test.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
> index 26e2e77289..b6a74a05ce 100644
> --- a/tests/qtest/migration-test.c
> +++ b/tests/qtest/migration-test.c
> @@ -1291,7 +1291,7 @@ static void test_multifd_tcp(void)
>       wait_for_serial("dest_serial");
>       wait_for_migration_complete(from);
>       test_migrate_end(from, to, true);
> -    free(uri);
> +    g_free(uri);
>   }
>  =20
>   int main(int argc, char **argv)
>=20


