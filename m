Return-Path: <SRS0=wQM/=BV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B17BC433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2020 16:21:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 367B02076C
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2020 16:21:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PsB7eHUn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 367B02076C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41442 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5X21-0006e8-1Q
	for qemu-devel@archiver.kernel.org; Tue, 11 Aug 2020 12:21:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39442)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k5X1H-0006EU-Nu
 for qemu-devel@nongnu.org; Tue, 11 Aug 2020 12:20:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:56607)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k5X1F-0008VD-7r
 for qemu-devel@nongnu.org; Tue, 11 Aug 2020 12:20:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597162855;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=dcTg+v1ilfn9Ik7hl2hOpJTcOJ+bL5wmqKf+1D19n8U=;
 b=PsB7eHUnSLsDJ5MMXCJQAWYa3tGB9jYXXt1bza0WIGhFV5zeV1FtZb7tdZ4V8wlktsbN96
 QGCL0Pz4hhbXPKQL5YU/5DQJPLPLiC4kvAUVkrLf8UaFLRN55cLyIdZRFbRtfv64SAn5Jt
 6aH6SQCn+kEQHbfaXOKZy9WZiAGUg/Y=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-182-eBQN2NE-PDGHN2bvMRsB2Q-1; Tue, 11 Aug 2020 12:20:51 -0400
X-MC-Unique: eBQN2NE-PDGHN2bvMRsB2Q-1
Received: by mail-wr1-f70.google.com with SMTP id b13so5791737wrq.19
 for <qemu-devel@nongnu.org>; Tue, 11 Aug 2020 09:20:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:cc:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=dcTg+v1ilfn9Ik7hl2hOpJTcOJ+bL5wmqKf+1D19n8U=;
 b=oCCm2BaHiJP0eoXEAj2y1LIgzW4yUPmOi8JHc3PmKJ6MGn3hK1UMB6c0Uzv66VPAay
 sh6GWXYAkTGKY5ILYPBVLYI5LX+vDiEpf9u8gzbKQIiuZ879JvrIUz05tKTdC5CF3bww
 T6NnKo8AnXYlcJFYbfmhEFvKnaAOSMTTk72uJByhrfq8g4NmagPEP5VYXnT9YjcwA2Sy
 ziqQiOhDTxPItKMH7ATVzoggpmRvLlgAbnO0fnmEVIUO+shV3HhQB2/lI3rnyelhva1x
 WSChFVPXQDjm3h7ys8PG5XLxWv3aqhu38dgmMHhgH4kcqrOECgTORAt0ep9fouba+fVq
 iqVA==
X-Gm-Message-State: AOAM530xer5fxT4zXh813D48ttzAAj6r4DcAgTjojOaU45mr/3jaA3Xk
 2cQkhO5ftksymt+3AnkSbbuKm/E7U2HxvOKzoVtqXkWA7vPPKxskblypHf1v2IGi9xnxb3nghC4
 G7f4ukrziJDnwV/U=
X-Received: by 2002:a5d:51c3:: with SMTP id n3mr30512698wrv.104.1597162850227; 
 Tue, 11 Aug 2020 09:20:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzs+vXP6Bj/GCAU8o4bneSC8WJZyfh9oWcMeRdZDtVMt38fOK4NmR4nEhlhvU2mLAtFe0KvHQ==
X-Received: by 2002:a5d:51c3:: with SMTP id n3mr30512681wrv.104.1597162850000; 
 Tue, 11 Aug 2020 09:20:50 -0700 (PDT)
Received: from [192.168.1.36] (121.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.121])
 by smtp.gmail.com with ESMTPSA id h7sm6233357wmf.43.2020.08.11.09.20.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 11 Aug 2020 09:20:49 -0700 (PDT)
Subject: Re: [PATCH 139/147] meson: replace create-config with meson
 configure_file
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <1597079345-42801-1-git-send-email-pbonzini@redhat.com>
 <1597079345-42801-140-git-send-email-pbonzini@redhat.com>
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
Message-ID: <21cc800d-c8bf-b737-1059-b83044ad9271@redhat.com>
Date: Tue, 11 Aug 2020 18:20:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <1597079345-42801-140-git-send-email-pbonzini@redhat.com>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/11 05:47:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: Alexander Bulekov <alxndr@bu.edu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/10/20 7:08 PM, Paolo Bonzini wrote:
> Move the create-config logic to meson.build; create a
> configuration_data object and let meson handle the
> quoting and output.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  Makefile                       |   2 +-
>  block.c                        |   4 +-
>  configure                      |   9 ++-
>  meson.build                    | 100 ++++++++++++++++++++++---------
>  scripts/create_config          | 131 -----------------------------------------
>  tests/qtest/bios-tables-test.c |   2 +-
>  6 files changed, 80 insertions(+), 168 deletions(-)
>  delete mode 100755 scripts/create_config
> 
> diff --git a/Makefile b/Makefile
> index cd4eeb5..1eec727 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -189,7 +189,7 @@ clean: recurse-clean
>  	rm -f fsdev/*.pod scsi/*.pod
>  	rm -f $(foreach f,$(generated-files-y),$(f) $(f)-timestamp)
>  
> -VERSION ?= $(shell cat VERSION)
> +VERSION = $(shell cat $(SRC_PATH)/VERSION)
>  
>  dist: qemu-$(VERSION).tar.bz2
>  
> diff --git a/block.c b/block.c
> index 67c5028..67ca543 100644
> --- a/block.c
> +++ b/block.c
> @@ -443,13 +443,13 @@ static int bdrv_format_is_whitelisted(const char *format_name, bool read_only)
>          return 1;               /* no whitelist, anything goes */
>      }
>  
> -    for (p = whitelist_rw; *p; p++) {
> +    for (p = whitelist_rw; p < &whitelist_rw[ARRAY_SIZE(whitelist_rw)]; p++) {

Alexander reported [*] a problem when ARRAY_SIZE(whitelist_rw) == 0 you
access an undefined address:

block.c:442:10: runtime error: index 0 out of bounds for type 'const
char *[0]'

[*] https://lists.gnu.org/archive/html/qemu-devel/2020-08/msg02066.html

>          if (!strcmp(format_name, *p)) {
>              return 1;
>          }
>      }
>      if (read_only) {
> -        for (p = whitelist_ro; *p; p++) {
> +        for (p = whitelist_ro; p < &whitelist_ro[ARRAY_SIZE(whitelist_ro)]; p++) {

Ditto.

>              if (!strcmp(format_name, *p)) {
>                  return 1;
>              }
[...]


