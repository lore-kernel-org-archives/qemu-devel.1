Return-Path: <SRS0=Z1O7=DF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6B62C4741F
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 08:32:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB982206DC
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 08:32:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KkFP71MF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB982206DC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32940 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kMoaW-0005Ln-Sc
	for qemu-devel@archiver.kernel.org; Mon, 28 Sep 2020 04:32:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36578)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kMoZH-0004ru-3f
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 04:31:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:23521)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kMoZE-0005Oe-Dd
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 04:31:30 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601281886;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=V0rcwqohXWfokTxyHJDya1mIw8pUt6sv39tJMSIiYRk=;
 b=KkFP71MFd+qOvOfDl+xzbs9xQuMuKUyRiddKtEw7WBxA3OBew4Xz3tZCNfPAL79Q5sxpPv
 qmUpN0MFELEzVZ5okJRwWISEopnP35ucbLZ64Gc8Ru7DFX1Q7YAkPVHs3ATcb5c8GrIwcF
 U5ByAH7pISsmid+fV34IlFU3cfzTICA=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-407-WVozibzdMiGSTTaSwJj0Zw-1; Mon, 28 Sep 2020 04:31:24 -0400
X-MC-Unique: WVozibzdMiGSTTaSwJj0Zw-1
Received: by mail-wr1-f69.google.com with SMTP id a2so104620wrp.8
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2020 01:31:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=V0rcwqohXWfokTxyHJDya1mIw8pUt6sv39tJMSIiYRk=;
 b=N8+lVklJPXNwMieI080RaC0fVkNaqds4cTxEtKpuDvppdMOVsrVAWKxm+Ea3hh+Pdm
 9SKGtkP6jy8Bkd/uyRVYAPX70jW/DKmr/8F3n7ivJnHdRm2nXDyr3tnlOJ8SrmR28W5R
 fy5uVXOhPd4JXMSZt9VPXZdJ6QFewhL2lB6YUYwL8Abs67xN5WnF7qYLZQqTdlqnEfTr
 jVMaI8a8w449d/MlRihW9Rc3gFli+VflWxwTtZnKMvs3rcOHRDZwRPCn0Rn1Pe1feMfS
 YaXoV5hyz4y0Z8pecbeqAFlCWaWeb22+f05zr4V75yfYhTsdUq86DU7dUlIWK3kiFdUp
 U+Cg==
X-Gm-Message-State: AOAM530+4YmIqk3UAVp+kMxVag2jOL92BV+Tc+iWji2k0qFRvXGIm7Sq
 7e8o4bXVcQ/YQ9FpgmAjMKjIQBnup6h5aMCBe2ADsz9TsWgGktLQOIJeiZZyIEYpvuxr3+B9Rrs
 PBkUC2dJOOzBRIYk=
X-Received: by 2002:a7b:c210:: with SMTP id x16mr424673wmi.76.1601281883223;
 Mon, 28 Sep 2020 01:31:23 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxL7vUAYc4wb0BbLAB58xedkxEeZBNv3vsJwU3i86kdk4S5JwOSXnBp3XpzK9ScNftOcikXIQ==
X-Received: by 2002:a7b:c210:: with SMTP id x16mr424649wmi.76.1601281883030;
 Mon, 28 Sep 2020 01:31:23 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:f4f8:dc3e:26e3:38c7?
 ([2001:b07:6468:f312:f4f8:dc3e:26e3:38c7])
 by smtp.gmail.com with ESMTPSA id k8sm419689wrl.42.2020.09.28.01.31.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Sep 2020 01:31:22 -0700 (PDT)
Subject: Re: [PATCH 06/12] tests/qtest/qos-test: add environment variable
 QTEST_DEBUG
To: Christian Schoenebeck <qemu_oss@crudebyte.com>, qemu-devel@nongnu.org
References: <cover.1601203436.git.qemu_oss@crudebyte.com>
 <cc6109fcc03d47a68d01ceac5ade71fe8467a3f7.1601203436.git.qemu_oss@crudebyte.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <2c5db347-4d17-c735-a153-3043566d7c21@redhat.com>
Date: Mon, 28 Sep 2020 10:31:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <cc6109fcc03d47a68d01ceac5ade71fe8467a3f7.1601203436.git.qemu_oss@crudebyte.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/28 03:29:35
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.576,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.011, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1,
 RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>,
 Greg Kurz <groug@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 27/09/20 12:40, Christian Schoenebeck wrote:
> For now this new environment variable QTEST_DEBUG will cause the
> assembled qemu command line to be printed before running each test.
> 
> Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
> ---
>  tests/qtest/qos-test.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/tests/qtest/qos-test.c b/tests/qtest/qos-test.c
> index 4b1a1922fc..571d1e140a 100644
> --- a/tests/qtest/qos-test.c
> +++ b/tests/qtest/qos-test.c
> @@ -89,6 +89,9 @@ static void qos_set_machines_devices_available(void)
>  
>  static void restart_qemu_or_continue(char *path)
>  {
> +    if (getenv("QTEST_DEBUG") != NULL) {
> +        printf("run QEMU with: '%s'\n", path);
> +    }
>      /* compares the current command line with the
>       * one previously executed: if they are the same,
>       * don't restart QEMU, if they differ, stop previous
> 

You can just use g_test_message for this and do it unconditionally.

Paolo


