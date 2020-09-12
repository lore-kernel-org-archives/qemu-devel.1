Return-Path: <SRS0=E5X6=CV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B864C43461
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Sep 2020 08:37:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF688214F1
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Sep 2020 08:37:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ONi4SKYR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF688214F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50526 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kH12W-0007AR-Qe
	for qemu-devel@archiver.kernel.org; Sat, 12 Sep 2020 04:37:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46086)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kH11l-0006iV-RX
 for qemu-devel@nongnu.org; Sat, 12 Sep 2020 04:36:57 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:42469
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kH11g-0002uj-RG
 for qemu-devel@nongnu.org; Sat, 12 Sep 2020 04:36:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599899811;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TkdQFscA1Z9uNPnLSXEIJ9RGgfCkheNSA1OEjrjI3R4=;
 b=ONi4SKYRHx1HBWg2UGfwGxXs3UZeDy66QoJTJlU4tMpc/Iux8dKo7uskalXW0mGSJ7la9y
 hxM78vffp1tWtDNeR9QA1mYVGJ13jCkKJNBdSKRVtcCKkXmFYzb/SOApdRc+Id/4QkaE6P
 zbs3s6g5ib1brhJdjq7mSkiOyypNcFk=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-357-LD9XXDQtOSuZ3YRQgKt74A-1; Sat, 12 Sep 2020 04:36:49 -0400
X-MC-Unique: LD9XXDQtOSuZ3YRQgKt74A-1
Received: by mail-ed1-f71.google.com with SMTP id c25so6374024edx.11
 for <qemu-devel@nongnu.org>; Sat, 12 Sep 2020 01:36:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=TkdQFscA1Z9uNPnLSXEIJ9RGgfCkheNSA1OEjrjI3R4=;
 b=Y2VXLRHuaK773j/ZbYFS30KlThmtaX1O0b3QppPQDSk3rxmeP7BhY3/SJ1WYYPL89P
 7AWOKsjDthQh7I/K/fZ9CWhIKkqSWT5ozsh/Cev7Jz857CXcgcU0RIZZheQ9nn/ngQSe
 XC9EG1LKB6TLetYC1PuR6lCv8NwWUNU6Pxy6U+v3MnUc5kb22H6vghvyxtxfkvWyW+E4
 b9KzP4ySMhxm59gAk0PT15vP0nu2uG9OJvA0mABUpy8EhGITJtLPjBOcW8U5gDP12A9e
 oN7Y2dehwXWPv98KbYF+DBe0600cacfH5pfQNqRhlbfDvhdKwgRFtLpTxkaR5qystxrC
 2Fsw==
X-Gm-Message-State: AOAM531Ew3oa8xaqZB2aFoSzrDUISPm3huNPbDRhj2folJDPn2NGoPHn
 tyuYy8uDKeU2/ZahWeZ0G4nOYrc1+X707q4RNbwhCCaRTC3RZdAyCkjwyGXLIU6oZG/n3/aSScF
 AoZt6iUmOYh5Nwb4=
X-Received: by 2002:a17:907:213b:: with SMTP id
 qo27mr5158789ejb.441.1599899808558; 
 Sat, 12 Sep 2020 01:36:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxaYlbGRLfoWudPX+Jqz/AG0Ll2NPYJwBRYspLhfYkA71CByV0qBF21TFytZYzNTUvfCFvosw==
X-Received: by 2002:a17:907:213b:: with SMTP id
 qo27mr5158775ejb.441.1599899808351; 
 Sat, 12 Sep 2020 01:36:48 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:8825:3b3:6c1e:a82d?
 ([2001:b07:6468:f312:8825:3b3:6c1e:a82d])
 by smtp.gmail.com with ESMTPSA id p25sm3994773edm.60.2020.09.12.01.36.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 12 Sep 2020 01:36:47 -0700 (PDT)
Subject: Re: [PATCH] tests/qtest/qmp-cmd-test: Use inclusive language
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
References: <20200912074922.26103-1-thuth@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <81133ec5-e147-f71c-addd-9e71977ee35a@redhat.com>
Date: Sat, 12 Sep 2020 10:36:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200912074922.26103-1-thuth@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Received-SPF: pass client-ip=207.211.31.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/12 04:36:51
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-2.469, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Laurent Vivier <lvivier@redhat.com>, philmd@redhat.com,
 Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/09/20 09:49, Thomas Huth wrote:
> We simply want to ignore certain queries here, so let's rather
> use the term 'ignore' to express this intention.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  tests/qtest/qmp-cmd-test.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/tests/qtest/qmp-cmd-test.c b/tests/qtest/qmp-cmd-test.c
> index 3109a9fe96..18069a82fa 100644
> --- a/tests/qtest/qmp-cmd-test.c
> +++ b/tests/qtest/qmp-cmd-test.c
> @@ -82,9 +82,9 @@ static void test_query(const void *data)
>      qtest_quit(qts);
>  }
>  
> -static bool query_is_blacklisted(const char *cmd)
> +static bool ignore_query(const char *cmd)
>  {
> -    const char *blacklist[] = {
> +    const char *ignorelist[] = {

Just "ignored", it's obviously a list.

Paolo

>          /* Not actually queries: */
>          "add-fd",
>          /* Success depends on target arch: */
> @@ -101,8 +101,8 @@ static bool query_is_blacklisted(const char *cmd)
>      };
>      int i;
>  
> -    for (i = 0; blacklist[i]; i++) {
> -        if (!strcmp(cmd, blacklist[i])) {
> +    for (i = 0; ignorelist[i]; i++) {
> +        if (!strcmp(cmd, ignorelist[i])) {
>              return true;
>          }
>      }
> @@ -179,7 +179,7 @@ static void add_query_tests(QmpSchema *schema)
>              continue;
>          }
>  
> -        if (query_is_blacklisted(si->name)) {
> +        if (ignore_query(si->name)) {
>              continue;
>          }
>  
> 



