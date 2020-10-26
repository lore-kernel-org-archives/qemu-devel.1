Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AECFFC4363A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 10:02:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 05DC420674
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 10:02:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aE+d6J/n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05DC420674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47150 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kWzKu-0006cc-11
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 06:02:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36698)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kWzJ2-0004rJ-Fd
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 06:00:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:32052)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kWzIz-0004Tb-HT
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 06:00:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603706443;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pOMCclc21vjUH40ISk/gsqpOXuo0RH/Du+IAJDGnYuo=;
 b=aE+d6J/n/MKF/a3FgoE6RZwS1K56hPEe8/xWCbbiTsrCPs8M2IWzxj9P+2EfFs/GKvjV1Q
 gyAN/XFvktEMDoFn/8GGdiS7SHkSjxRiQ644vIy5jD5/lidJ8tsjqxwWuHoacUwfvd1hs4
 SmGXkmDP6Im1EuuKJOFuj91t0UghMC8=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-112-U5hoxdtSP1OM913ThQ4L4w-1; Mon, 26 Oct 2020 06:00:41 -0400
X-MC-Unique: U5hoxdtSP1OM913ThQ4L4w-1
Received: by mail-wr1-f72.google.com with SMTP id 91so8103636wrk.20
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2020 03:00:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:to:cc:references:from:subject:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=pOMCclc21vjUH40ISk/gsqpOXuo0RH/Du+IAJDGnYuo=;
 b=IF4Vtq0M/8G3Hv9UzpTJi+c1647w5MdkumGQRsi+RA6tEx/ZQ0Sc4dK+bSmnTjr5K3
 ff4Tszv3DGa4bFPJBCpL+k8Wny2gBTtGmwWqfiWNyNLBkKr8bnP2yaJeoLMqhpMc/p7v
 8eqZerCSg8i8yer1KSDwRE8l2xLos19VPuvrq7jN+gpVSc7c2+ELXOCGSrsYPqrwZ4FJ
 cn4qtZ0dwjBG++vQbY5SrTb7Z1VfT+/cTD4T7/mne/fXTaGmNa2gipyqCtXFaTwbLGdw
 P2i6r1zcWOib0aPft8j4YrDGuqpuJKanYW7yNUUKUFentJq1xNXh6FTCkhhmVSULzZ0c
 kW6g==
X-Gm-Message-State: AOAM533bROUpRu2F2uu3nhd0jk5fs62K5GmbkGq1Gqj2BnqPiktQBmCr
 7i7x5sM3zVlzNBtlNbCiRuPL+KEp9GZlSgBX/Om3WWLpbZIw8eu78PSMNufrsVJZg1ZnheBSzha
 uj4wkrsl+1MBVEEs=
X-Received: by 2002:a05:600c:2211:: with SMTP id
 z17mr15749006wml.92.1603706440462; 
 Mon, 26 Oct 2020 03:00:40 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzYB7Sg4VYvADZtF7lhxCjDELzR06PH86wnAVRf8yB5DZD3pW6URQk2U3nC5rFaMoPuJ7swOw==
X-Received: by 2002:a05:600c:2211:: with SMTP id
 z17mr15748980wml.92.1603706440218; 
 Mon, 26 Oct 2020 03:00:40 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a?
 ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
 by smtp.gmail.com with ESMTPSA id t83sm21339927wmt.43.2020.10.26.03.00.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 Oct 2020 03:00:39 -0700 (PDT)
To: Daniele Buono <dbuono@linux.vnet.ibm.com>, qemu-devel@nongnu.org
References: <20201023200645.1055-1-dbuono@linux.vnet.ibm.com>
 <20201023200645.1055-7-dbuono@linux.vnet.ibm.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v2 6/6] configure: add support for Control-Flow Integrity
Message-ID: <7fef8ff2-9c15-e3a0-5af8-a50e6c49f37f@redhat.com>
Date: Mon, 26 Oct 2020 11:00:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201023200645.1055-7-dbuono@linux.vnet.ibm.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/25 21:03:19
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1,
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
Cc: Alexander Bulekov <alxndr@bu.edu>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2e_Berrang=c3=a9?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 23/10/20 22:06, Daniele Buono wrote:
> +
> +if test "$cfi" = "yes"; then
> +  # Compiler/Linker Flags that needs to be added for cfi:
> +  # -fsanitize=cfi-icall to enable control-flow integrity checks on
> +  #            indirect function calls.
> +  # -fsanitize-cfi-icall-generalize-pointers to allow indirect function calls
> +  #            with pointers of a different type (i.e. pass a void* to a
> +  #            function that expects a char*). Used in some spots in QEMU,
> +  #            with compile-time type checks done by macros
> +  # -fno-sanitize-trap=cfi-icall, when debug is enabled, to display the
> +  #            position in the code that triggered a CFI violation
> +
> +  # Make sure that LTO is enabled
> +  if test "$lto" != "true"; then
> +    error_exit "Control Flow Integrity requires Link-Time Optimization (LTO)"
> +  fi
> +
> +  test_cflag="-fsanitize=cfi-icall -fsanitize-cfi-icall-generalize-pointers"
> +  test_ldflag="-fsanitize=cfi-icall"

Can you pass both options to the linker for simplicity?

Unless you need to add the flag to CONFIGURE_CFLAGS/CONFIGURE_LDFLAGS,
please do all the tests in meson instead, it's much simpler to do
something like

if get_option('cfi')
  cfi_flags=['-fsanitize=cfi-icall',
             '-fsanitize-cfi-icall-generalize-pointers']
  if get_option('cfi_debug')
    cfi_flags += 'fno-sanitize-trap=cfi-icall'
  endif
  if cc.get_supported_arguments(cfi_flags).length() != cfi_flags.length()
    error('...')
  endif
  add_project_arguments(cfi_flags, native: false, language: ['c', 'cpp',
'objc'])
)
  add_project_link_arguments(cfi_flags, native: false, language: ['c',
'cpp', 'objc'])
)
endif

> +  if test "$cfi_debug" = "yes"; then
> +    error_exit "Cannot enable Control Flow Integrity debugging since CFI is not enabled"
> +  fi
> +fi

Generally dependent options are ignored so you can remove this part.

Paolo


