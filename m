Return-Path: <SRS0=1jZz=6T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FDCBC47254
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 10:39:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EDD85206A5
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 10:39:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="diOMH/Oc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDD85206A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58896 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVuzJ-0003nW-5v
	for qemu-devel@archiver.kernel.org; Tue, 05 May 2020 06:39:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35782)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jVuxV-0002EN-UU
 for qemu-devel@nongnu.org; Tue, 05 May 2020 06:37:53 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:56654
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jVuxT-00034b-Ti
 for qemu-devel@nongnu.org; Tue, 05 May 2020 06:37:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588675070;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bSx/kWL/ZVRgKsCRK30Dcu0oHdGGzbVXKC1CW2hhbg8=;
 b=diOMH/OcB0uHSc6mXjeFhHmk1zl2nWNa3WPj7F1YXaTwSsZSu+fM37HGZ6tk45NZBDqHhJ
 7aWoHiFW4gW+nbvV+Nmrdl3CEQzcwCEcZ4VASQOjK2wc1Xk0A+EqVmJTwuw34witfu6amI
 s0dOy3y+pAY4BTWxFpDW0ktWHqZ67AY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-354-vsDUe76LN8aeOPWfXNCd3A-1; Tue, 05 May 2020 06:37:48 -0400
X-MC-Unique: vsDUe76LN8aeOPWfXNCd3A-1
Received: by mail-wm1-f71.google.com with SMTP id t62so872878wma.0
 for <qemu-devel@nongnu.org>; Tue, 05 May 2020 03:37:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=NCIQxRJF4U66WeF1XU5kIVorK2Nc5LlUu3obB8tWSJg=;
 b=Jj9JRfz5hMdaqUd6baFN5ODZB3Z9qrJxvl5l2y8eQwEzHUHuL0QqJLNs7IlBtn5v9z
 hY/ACqgf7b+vPzmzdKI9MaO89g9DO7yyrGJy6/8duLz4U5TMolsgYuP9j83w5sjXxwLl
 nhq9agcAGnugAemjiXBmECo/eKdhZvKivXsZ2VCzVK5Gp5fanwrImJAeQlesEWlMaO5B
 UYf5gVffoddJ1iwMWWVTkdkOe8zj5Kq12HEAp5gOEqrZOf8PI3/t0VRqz5OmhWP5fXMx
 ykCcK86b2OFjGKDThzEoHpNdFk9J89ZPh6nOoVoOc9eq3v05GF/d7D6USsKShJAxvPX4
 mYjQ==
X-Gm-Message-State: AGi0PubBFq0m3G/8kTWCHeWfpH8qmwuOjMWt7lx/4uJfwxEB97z988G4
 ZnG+MA9TZa8Fj63CYEazOV4FkxgpjwJ8mwTgYNpg1ujtoheMObDby+1kwu3Dz/laZaNUn6+XQI4
 8D7rmxnHUZXE+LWE=
X-Received: by 2002:a1c:9cc6:: with SMTP id f189mr2536425wme.75.1588675066938; 
 Tue, 05 May 2020 03:37:46 -0700 (PDT)
X-Google-Smtp-Source: APiQypJhjitJOs9HIhpcyBYPb7ncPWWNVtSojIy70TGwBhi/5EXAtftBkU9lq/0IvF7H3UhLyNx1ag==
X-Received: by 2002:a1c:9cc6:: with SMTP id f189mr2536406wme.75.1588675066709; 
 Tue, 05 May 2020 03:37:46 -0700 (PDT)
Received: from [192.168.1.38] (26.red-88-21-207.staticip.rima-tde.net.
 [88.21.207.26])
 by smtp.gmail.com with ESMTPSA id g6sm2610474wrw.34.2020.05.05.03.37.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 05 May 2020 03:37:45 -0700 (PDT)
Subject: Re: [PATCH v2 04/10] tests/migration: Tighten error checking
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20200505101908.6207-1-armbru@redhat.com>
 <20200505101908.6207-5-armbru@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <fa61ef20-1e34-5560-32ef-dd6226211cb8@redhat.com>
Date: Tue, 5 May 2020 12:37:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200505101908.6207-5-armbru@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.61; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/05 00:37:40
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/5/20 12:19 PM, Markus Armbruster wrote:
> migrate_get_socket_address() neglects to check
> visit_type_SocketAddressList() failure.  This smells like a leak, but
> it actually will crash dereferencing @addrs.  Pass &error_abort to
> remove the code smell.
>=20
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>   tests/qtest/migration-test.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
> index 2568c9529c..dc3490c9fa 100644
> --- a/tests/qtest/migration-test.c
> +++ b/tests/qtest/migration-test.c
> @@ -13,6 +13,7 @@
>   #include "qemu/osdep.h"
>  =20
>   #include "libqtest.h"
> +#include "qapi/error.h"
>   #include "qapi/qmp/qdict.h"
>   #include "qemu/module.h"
>   #include "qemu/option.h"
> @@ -301,7 +302,6 @@ static char *migrate_get_socket_address(QTestState *w=
ho, const char *parameter)
>   {
>       QDict *rsp;
>       char *result;
> -    Error *local_err =3D NULL;
>       SocketAddressList *addrs;
>       Visitor *iv =3D NULL;
>       QObject *object;
> @@ -310,7 +310,7 @@ static char *migrate_get_socket_address(QTestState *w=
ho, const char *parameter)
>       object =3D qdict_get(rsp, parameter);
>  =20
>       iv =3D qobject_input_visitor_new(object);
> -    visit_type_SocketAddressList(iv, NULL, &addrs, &local_err);
> +    visit_type_SocketAddressList(iv, NULL, &addrs, &error_abort);
>       visit_free(iv);
>  =20
>       /* we are only using a single address */
>=20

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>


