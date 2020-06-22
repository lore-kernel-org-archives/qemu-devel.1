Return-Path: <SRS0=TEh4=AD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2320C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 11:26:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6EF172068F
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 11:26:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PBEDpmb4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6EF172068F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40192 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnKb7-0008GS-Lp
	for qemu-devel@archiver.kernel.org; Mon, 22 Jun 2020 07:26:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43614)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jnKXr-0004hf-4L
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 07:23:23 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:29268
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jnKXe-0007Gf-Li
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 07:23:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592824988;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=SuXi+u+3wqoHLgRNaz6sY5d4KjJWozGDun9NYB6juTg=;
 b=PBEDpmb433yKkMcZsPIJT3A1XVOOYV17JCdWt/uEl0u/Khc9WYQ0grLHuz9Qm4vdTqQgY0
 PJKHBfNQHMpyJtPxtKmOqBY2Phiju1tnam+F8uJvHOwYhvZnqOqQN5BPYLCEvrDVSd7kIZ
 5AGiOgy7X3YD0tvODLlnnHR5ouKbxHc=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-297-LY3emnygMZG6wdBBXBEpmw-1; Mon, 22 Jun 2020 07:23:06 -0400
X-MC-Unique: LY3emnygMZG6wdBBXBEpmw-1
Received: by mail-wr1-f71.google.com with SMTP id p9so10719473wrx.10
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2020 04:23:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=SuXi+u+3wqoHLgRNaz6sY5d4KjJWozGDun9NYB6juTg=;
 b=E50K5NaajeX1UeV9iIyH62nU++gDH1mPKX3nU57Tr5PyaUEQSorVo41bFinTKcISiR
 71jq5p3mmUNxh9GwE5tObt/+qH09wrMCBxL5TcaNQ1sDNYbmBktYcCTZ4fPT7FrgULxu
 ch11PTPtx7yTB43t5yk6YohogLBCGHS0P3kENqeK11F+1wCX7EbLosuN7Z1359MgrbnT
 JnS8qZ4BJWSzTuUBHpsUw5Z5WPMhDTpM096k4bh3eXGe+wh37QOhjEK7ANfK/93mNIN7
 gOMM+nZOyLwnx/W54aWIszkx0UPef5pLIv5LkUnuGiilZWz0qJs74avMHLq8hErRbcZl
 26nw==
X-Gm-Message-State: AOAM533Fypzei0KFSIEKGsx7R1QHsgx0uAPJqIqQfMgkt30Eazs+b2dO
 eQxUwkFNvMXgy/7CD0r2vJu29yz/EB6fTW9ILdrNs6lH1GQRLA/vTm4Z7iTKADLgDnHWRisweJ8
 4vvR/d1+l0x2pHsg=
X-Received: by 2002:a1c:e285:: with SMTP id
 z127mr13639655wmg.162.1592824984662; 
 Mon, 22 Jun 2020 04:23:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyXNeJ9odxZkUsgwFO4XCabGq8PohNJg8c+jfFkJsMvyLaguySwVpemgxWq0BQbwtuskj/sFw==
X-Received: by 2002:a1c:e285:: with SMTP id
 z127mr13639628wmg.162.1592824984443; 
 Mon, 22 Jun 2020 04:23:04 -0700 (PDT)
Received: from [192.168.1.39] (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id l190sm5240687wml.12.2020.06.22.04.23.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 Jun 2020 04:23:03 -0700 (PDT)
Subject: Re: [PATCH] tests/qtest: Unify the test for the xenfv and xenpv
 machines
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
References: <20200622104339.21000-1-thuth@redhat.com>
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
Message-ID: <17ab5c19-a387-e5aa-e7a3-cd4a3aee8d1c@redhat.com>
Date: Mon, 22 Jun 2020 13:23:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200622104339.21000-1-thuth@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/22 02:57:26
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
Cc: Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/22/20 12:43 PM, Thomas Huth wrote:
> We have the same check in three places. Let's unify it in a central
> place instead.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  tests/qtest/device-introspect-test.c | 5 -----
>  tests/qtest/libqtest.c               | 4 ++++
>  tests/qtest/qom-test.c               | 5 -----
>  tests/qtest/test-hmp.c               | 5 -----
>  4 files changed, 4 insertions(+), 15 deletions(-)
> 
> diff --git a/tests/qtest/device-introspect-test.c b/tests/qtest/device-introspect-test.c
> index f2c1576cae..9abb5ec889 100644
> --- a/tests/qtest/device-introspect-test.c
> +++ b/tests/qtest/device-introspect-test.c
> @@ -287,11 +287,6 @@ static void add_machine_test_case(const char *mname)
>  {
>      char *path, *args;
>  
> -    /* Ignore blacklisted machines */
> -    if (!memcmp("xenfv", mname, 5) || g_str_equal("xenpv", mname)) {
> -        return;
> -    }
> -
>      path = g_strdup_printf("device/introspect/concrete/defaults/%s", mname);
>      args = g_strdup_printf("-M %s", mname);
>      qtest_add_data_func(path, args, test_device_intro_concrete);
> diff --git a/tests/qtest/libqtest.c b/tests/qtest/libqtest.c
> index 49075b55a1..fd4680590d 100644
> --- a/tests/qtest/libqtest.c
> +++ b/tests/qtest/libqtest.c
> @@ -1232,6 +1232,10 @@ void qtest_cb_for_every_machine(void (*cb)(const char *machine),
>          qstr = qobject_to(QString, qobj);
>          g_assert(qstr);
>          mname = qstring_get_str(qstr);
> +        /* Ignore machines that cannot be used for qtests */
> +        if (!memcmp("xenfv", mname, 5) || g_str_equal("xenpv", mname)) {
> +            continue;
> +        }

The patch is correct.

Since qtest uses QMP introspection, it would be cleaner to have
a MachineClass::qtest_allowed property (default to true), set
it to false in the xenfv/pv machines, and either check the property
here or have a query-qtest-machines QMP command.
Just thinking loudly.

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

>          if (!skip_old_versioned || !qtest_is_old_versioned_machine(mname)) {
>              cb(mname);
>          }
> diff --git a/tests/qtest/qom-test.c b/tests/qtest/qom-test.c
> index e338a41194..1acf0d7369 100644
> --- a/tests/qtest/qom-test.c
> +++ b/tests/qtest/qom-test.c
> @@ -81,11 +81,6 @@ static void add_machine_test_case(const char *mname)
>  {
>      char *path;
>  
> -    /* Ignore blacklisted machines that have known problems */
> -    if (!memcmp("xenfv", mname, 5) || g_str_equal("xenpv", mname)) {
> -        return;
> -    }
> -
>      path = g_strdup_printf("qom/%s", mname);
>      qtest_add_data_func(path, g_strdup(mname), test_machine);
>      g_free(path);
> diff --git a/tests/qtest/test-hmp.c b/tests/qtest/test-hmp.c
> index b8b1271b9e..d5e7ebd176 100644
> --- a/tests/qtest/test-hmp.c
> +++ b/tests/qtest/test-hmp.c
> @@ -143,11 +143,6 @@ static void add_machine_test_case(const char *mname)
>  {
>      char *path;
>  
> -    /* Ignore blacklisted machines that have known problems */
> -    if (!memcmp("xenfv", mname, 5) || g_str_equal("xenpv", mname)) {
> -        return;
> -    }
> -
>      path = g_strdup_printf("hmp/%s", mname);
>      qtest_add_data_func(path, g_strdup(mname), test_machine);
>      g_free(path);
> 


