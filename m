Return-Path: <SRS0=fJPX=DJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56F3CC4727F
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 08:51:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B6B2A206C3
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 08:51:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J75B9eD7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6B2A206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51538 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kOGmh-0001a1-TS
	for qemu-devel@archiver.kernel.org; Fri, 02 Oct 2020 04:51:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43536)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kOGlf-0000aa-Qb
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 04:50:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:24109)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kOGld-0004mt-Fy
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 04:50:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601628616;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0CIzjEYp18qgsiX7wwR7uxH0uREo1M9QGA/xyPD+Dgk=;
 b=J75B9eD72tKmTKhje8A7GQnS7TrohLSbuot9OxgmPAOHl7ONoRt75yGOHObif6s3EtcQ/J
 g2GAIus8pymGmuZFCIE8g6gvaQ94U86nxvfgaqdQkQ3fbLkP6xCkuNKPlohUShhFWrftpE
 LQLFy01taG1qJwfPP84IeEmrDHJqse4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-157-mwXpZb30OquK71P7lWjMSg-1; Fri, 02 Oct 2020 04:50:14 -0400
X-MC-Unique: mwXpZb30OquK71P7lWjMSg-1
Received: by mail-wm1-f71.google.com with SMTP id r10so370297wmh.0
 for <qemu-devel@nongnu.org>; Fri, 02 Oct 2020 01:50:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=0CIzjEYp18qgsiX7wwR7uxH0uREo1M9QGA/xyPD+Dgk=;
 b=N1DWNCRRWsLfy9N0qVE6Hryj7QYbwYxXq4zufNCaP6vhS+xE1WvwfF4GnpkxpwKc6M
 dtYXFjptPkMQE2+kLGfMFWqpIscuhPqVjIWpv53Y8+5ZmjyHSKiRhGkaGwN3XCcAotGE
 qwssVaSN4/EGxh8SBMNXn7zUus/q8uonH4NLwyZzbGEOXn7W4i9L90iCCPTALp6LF1qi
 hqVowoC0N9DbT78pQ6I1tXtQBYXtqJh2s4MC+nbBc6gIyE2P4DpC1xwU2btmvjh75J7t
 8INSGmZpdvNctFNNslT+C/j3tIBE4cFa5hA1Uk8dVZktr6Nc/SQO9YYIc86c5mogtBNQ
 HshA==
X-Gm-Message-State: AOAM532mE6WvOOSn2EwRQhqj6lNUbzOF5mCjWCtY4J48UqDgzZ5V0Lf6
 92smMFA/sTUbf74vjYRjxnArbDARYZ810PKepjbXEO6PQGxm5cLapECYZ2HCEkAFjhcSxMnHdXU
 ZVk4zHeat2EkEmZs=
X-Received: by 2002:a7b:c1c5:: with SMTP id a5mr1581964wmj.187.1601628613326; 
 Fri, 02 Oct 2020 01:50:13 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJybAXnAAaOnv3xgJ2kxjiXvzq1EJf6lnpHVsUvX6ndzfEnhFrHh5gq+AKYzzuSaJ5tIRCakAA==
X-Received: by 2002:a7b:c1c5:: with SMTP id a5mr1581938wmj.187.1601628613114; 
 Fri, 02 Oct 2020 01:50:13 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:11eb:3314:c22:e3c7?
 ([2001:b07:6468:f312:11eb:3314:c22:e3c7])
 by smtp.gmail.com with ESMTPSA id r19sm960802wmh.7.2020.10.02.01.50.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 02 Oct 2020 01:50:12 -0700 (PDT)
Subject: Re: [PATCH v4 1/1] qapi: Restrict code generated for user-mode
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20201002073621.1653924-1-philmd@redhat.com>
 <20201002073621.1653924-2-philmd@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <17772b79-07db-98ff-96c5-01a9ac1cbcca@redhat.com>
Date: Fri, 2 Oct 2020 10:50:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20201002073621.1653924-2-philmd@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/02 01:13:31
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.26, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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
Cc: Michael Roth <mdroth@linux.vnet.ibm.com>,
 Markus Armbruster <armbru@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 02/10/20 09:36, Philippe Mathieu-Daudé wrote:
> A lot of QAPI generated code is never used by user-mode.
> 
> Split out qapi_system_modules and qapi_system_or_tools_modules
> from the qapi_all_modules array. We now have 4 groups:
> - always used
> - only used by system-mode
> - not used by user-mode
> - not used by tools
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
>  qapi/meson.build | 51 ++++++++++++++++++++++++++++++++++--------------
>  1 file changed, 36 insertions(+), 15 deletions(-)
> 
> diff --git a/qapi/meson.build b/qapi/meson.build
> index 7c4a89a882..10cf01ef65 100644
> --- a/qapi/meson.build
> +++ b/qapi/meson.build
> @@ -14,39 +14,60 @@ util_ss.add(files(
>  ))
>  
>  qapi_all_modules = [
> +  'common',
> +  'introspect',
> +  'misc',
> +]
> +
> +qapi_system_modules = [
>    'acpi',
>    'audio',
> +  'dump',
> +  'machine-target',
> +  'migration',
> +  'misc-target',
> +  'net',
> +  'pci',
> +  'rdma',
> +  'rocker',
> +  'tpm',
> +  'trace',
> +]
> +
> +qapi_system_or_user_modules = [
> +  'machine', # X86CPUFeatureWordInfo
> +  'qdev',
> +]
> +
> +qapi_system_or_tools_modules = [
>    'authz',
>    'block-core',
>    'block',
>    'char',
> -  'common',
>    'control',
>    'crypto',
> -  'dump',
>    'error',
> -  'introspect',
>    'job',
> -  'machine',
> -  'machine-target',
> -  'migration',
> -  'misc',
> -  'misc-target',
> -  'net',
>    'pragma',
> -  'qdev',
> -  'pci',
>    'qom',
> -  'rdma',
> -  'rocker',
>    'run-state',
>    'sockets',
> -  'tpm',
> -  'trace',
>    'transaction',
>    'ui',
>  ]
>  
> +if have_system
> +  qapi_all_modules += qapi_system_modules
> +endif
> +
> +if have_system or have_user
> +  qapi_all_modules += qapi_system_or_user_modules
> +endif
> +
> +if have_system or have_tools
> +  qapi_all_modules += qapi_system_or_tools_modules
> +endif
> +
>  qapi_storage_daemon_modules = [
>    'block-core',
>    'char',
> 

Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>


