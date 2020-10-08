Return-Path: <SRS0=Ajie=DP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A10F5C4363A
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 12:37:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D9F962083B
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 12:37:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y1vKzfBH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9F962083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55820 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQVB6-0004Yi-Ln
	for qemu-devel@archiver.kernel.org; Thu, 08 Oct 2020 08:37:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38198)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kQV9l-0003cO-6Y
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 08:36:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:48599)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kQV9h-00078b-Dp
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 08:36:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602160578;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CH65A35vrSuu2q11JTLwvgynqKxx/R77OIttjAdg6/I=;
 b=Y1vKzfBHSk5P2hZQDvnJi7NjpMTPC/jqweMNcYcQ7WtT6IKcd4VdWAFjya6ZlkoQYNM6XL
 i1ghTl51pXRY4eXGfkTP+SfTpmPH9uNCwFAyGyCvpvBMwXLzj4eJTEYHQUGYFdrWOsKKiB
 6Q4TwoeyBQEfONbK/6RPthh/I6wepRs=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-527-kNQuHCRyOBeSRmgyuAPSNg-1; Thu, 08 Oct 2020 08:36:15 -0400
X-MC-Unique: kNQuHCRyOBeSRmgyuAPSNg-1
Received: by mail-wm1-f70.google.com with SMTP id z7so3109563wmi.3
 for <qemu-devel@nongnu.org>; Thu, 08 Oct 2020 05:36:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=CH65A35vrSuu2q11JTLwvgynqKxx/R77OIttjAdg6/I=;
 b=Kv8sxKylcow+qWEvySBVnhp6MjBkc0H+VOPbt6Zs2nx9NRjyHGsoUgSBHu1Ni3b9iC
 BZHuENSCOkT7MvnJKSa9zsdTAnRRXJpyJEbQa/bKhxS908FNfovTTRJfij1xgEmY7Rad
 fa2azTUcbABTz+8M/5BL/v22DuRNjnmX3F21I0TbmkGric8tNB6acwxJQSma4jwbIcHy
 yqO3tPrXhiLpyNa0BM2Hc3yGGv1vdFgTnd8NxxDSWzuDKwXCdTImT5xGnx1MquIBm7IJ
 /4f0Efy3j+1MUIz3T7f1rBlp6TFI3iUC5zrERqvDfC1Dz0MBe4kLU4DkzVjo6OjYQehY
 5BHg==
X-Gm-Message-State: AOAM530sHFAQInWWoRYZCcQtv1nn2vYHPAURS7v0F/DxT0DXLDrad//C
 O8h0BdCTFZIEUP1iK/6glcizC1TaebBbwZpSsrIJ/aHiv10NkJVgVtA/aT7ly5x0AbFdcoDZ2Em
 qj0OPN/RYaMAksBE=
X-Received: by 2002:a5d:43d2:: with SMTP id v18mr6477763wrr.64.1602160574262; 
 Thu, 08 Oct 2020 05:36:14 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwgO6kqwJCM0XOrf1Hh3NtMJ4eiEeLhchH2y/hz/7D6uBrKUnW5gno7wmQQwEHs9YGMnkTDvg==
X-Received: by 2002:a5d:43d2:: with SMTP id v18mr6477725wrr.64.1602160573969; 
 Thu, 08 Oct 2020 05:36:13 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:bb8c:429c:6de1:f4ec?
 ([2001:b07:6468:f312:bb8c:429c:6de1:f4ec])
 by smtp.gmail.com with ESMTPSA id f14sm7677917wrt.53.2020.10.08.05.36.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 Oct 2020 05:36:13 -0700 (PDT)
Subject: Re: [PATCH v3 06/11] tests/qtest/qos-test: dump QEMU command if
 verbose
To: Christian Schoenebeck <qemu_oss@crudebyte.com>, qemu-devel@nongnu.org
References: <cover.1601655308.git.qemu_oss@crudebyte.com>
 <54781ff3e3231fa1b7e1bea8d16e825c5084a74f.1601655308.git.qemu_oss@crudebyte.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <68eaa9ac-0de6-a426-52bb-8a91f03664de@redhat.com>
Date: Thu, 8 Oct 2020 14:36:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <54781ff3e3231fa1b7e1bea8d16e825c5084a74f.1601655308.git.qemu_oss@crudebyte.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/08 02:56:27
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.214, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Cc: Laurent Vivier <lvivier@redhat.com>, berrange@redhat.com,
 Thomas Huth <thuth@redhat.com>,
 Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>,
 Greg Kurz <groug@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 02/10/20 18:15, Christian Schoenebeck wrote:
> If qtests are run in verbose mode (i.e. if --verbose CL argument
> was provided) then print the assembled qemu command line for each
> test.
> 
> Instead of using g_test_message() rather use printf() in combination
> with g_test_verbose(), to avoid g_test_message() cluttering the
> output.
> 
> Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
> ---
>  tests/qtest/qos-test.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/tests/qtest/qos-test.c b/tests/qtest/qos-test.c
> index fe240b32a7..b9f0942386 100644
> --- a/tests/qtest/qos-test.c
> +++ b/tests/qtest/qos-test.c
> @@ -89,6 +89,9 @@ static void qos_set_machines_devices_available(void)
>  
>  static void restart_qemu_or_continue(char *path)
>  {
> +    if (g_test_verbose()) {
> +        printf("Run QEMU with: '%s'\n", path);
> +    }
>      /* compares the current command line with the
>       * one previously executed: if they are the same,
>       * don't restart QEMU, if they differ, stop previous
> 

This need not even be made verbose I think.

Paolo


