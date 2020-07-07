Return-Path: <SRS0=B5/Q=AS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D9E8C433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 09:04:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 54DF120702
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 09:04:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PZEV43aO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54DF120702
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57330 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsjWT-0006RJ-Io
	for qemu-devel@archiver.kernel.org; Tue, 07 Jul 2020 05:04:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39210)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jsjVt-0005sn-4Y
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 05:03:41 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:50203
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jsjVr-0006QO-Eb
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 05:03:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594112617;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=cUhXfr2whPAvtZwQWcx22YO4ugHQDE7CaiEbwGDxj8Q=;
 b=PZEV43aOXHye5RSmn3Cbo6Ds7MGjMfJoT/47VItv02jAIDdotDib4H9C7HCkUB1Sj45UlV
 xj291JEyWV5PZk+XEkH2STntdOohhJQH/1Nqa3M/yI2RlG7VOQvRfzMkZjrpkyuIe4kv/m
 1X7kIRXtfLi0ylyIBKN3I5bo4qv+8gg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-30-ncd-BEWIP6SllxR6aE8DPQ-1; Tue, 07 Jul 2020 05:03:36 -0400
X-MC-Unique: ncd-BEWIP6SllxR6aE8DPQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2184D800688;
 Tue,  7 Jul 2020 09:03:35 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-112-77.ams2.redhat.com [10.36.112.77])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1033810013D7;
 Tue,  7 Jul 2020 09:03:32 +0000 (UTC)
Subject: Re: [PATCH] tests/qtest/libqtest: Do not overwrite child coredump
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
References: <20200707031920.17428-1-f4bug@amsat.org>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <9a16d2d9-405c-2110-debe-c92b8dbece33@redhat.com>
Date: Tue, 7 Jul 2020 11:03:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200707031920.17428-1-f4bug@amsat.org>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/07 00:31:00
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: Laurent Vivier <lvivier@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, Yury Kotov <yury-kotov@yandex-team.ru>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 07/07/2020 05.19, Philippe Mathieu-Daudé wrote:
> We are interested by the coredump of the child, not the qtest
> parent. If the child generated a coredump, simply call
> exit(EXIT_FAILURE) in the parent to avoid overwriting the
> child coredump.
> 
> Fixes: 71a268a5fd ("tests/libqtest: Improve kill_qemu()")
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
>  tests/qtest/libqtest.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/tests/qtest/libqtest.c b/tests/qtest/libqtest.c
> index 49075b55a1..bd85d01145 100644
> --- a/tests/qtest/libqtest.c
> +++ b/tests/qtest/libqtest.c
> @@ -173,7 +173,12 @@ static void kill_qemu(QTestState *s)
>          fprintf(stderr, "%s:%d: kill_qemu() detected QEMU death "
>                  "from signal %d (%s)%s\n",
>                  __FILE__, __LINE__, sig, signame, dump);
> -        abort();
> +        if (WCOREDUMP(wstatus)) {
> +            /* Preserve child coredump */
> +            exit(1);
> +        } else {
> +            abort();
> +        }
>      }
>  }

Would it maybe rather make sense to always use exit(1) unconditionally here?

 Thomas


