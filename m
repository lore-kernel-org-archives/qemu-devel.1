Return-Path: <SRS0=4Hnu=AF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B555C433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 08:35:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DAF882088E
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 08:35:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZI9yghoV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DAF882088E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60238 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jo0sV-0007OY-0T
	for qemu-devel@archiver.kernel.org; Wed, 24 Jun 2020 04:35:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47046)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jo0rP-00067X-Ai
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 04:34:23 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:51415
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jo0rN-00086S-Ei
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 04:34:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592987659;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MdueP/hqGo7xubncScyCB4hYVCZZ6OaWdOC6zOwHUtY=;
 b=ZI9yghoVy4BOBWk6mGp6+AHpg8Aczh24m2FDpp/9n0Zlj9FlD76M8B9+BuEGL/V5SPVg3t
 m2A6TtI26nGIa9ZIw7481wDLw3NyBxsk+jDQxFTVKcB2kJsNy88f3Mn3OayYf4F+pSsVoR
 MXZhlGn632iFf2t6KHGS908jTQIvc7k=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-62-Ecc9nca_POig3ICtEPQaNw-1; Wed, 24 Jun 2020 04:34:18 -0400
X-MC-Unique: Ecc9nca_POig3ICtEPQaNw-1
Received: by mail-wr1-f72.google.com with SMTP id o25so2181452wro.16
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2020 01:34:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=MdueP/hqGo7xubncScyCB4hYVCZZ6OaWdOC6zOwHUtY=;
 b=hOd7zJ/H7WThFTo/dKFip2YviGnYRNlazUoe3Vaem/LNBu36HZoBQHip3o9I/kGUAb
 J75JDkIffNffS/iH/oah0/SwrKD3nQcjbnqgD5kUNiH1U1H4iW0b7AD+cq0eZsVzsCX3
 Vjk5dbXtsCrZboCgT4WaYJmQttiuVy/14Ur+hA1w1srZfwqf3sM3e0+ZUfekHIJgINN6
 276ODiHEV/bDlDRvbcuYfUxndiLSztW0WGdAMAu4u0VqNz+S9VfEN4fS6Hi9UdiyjpUC
 rZnDC+Obe5gxndniGxgFLD+Nna5uTJV1/kYCJ1ZauH1fouPFCEK2/WgMxXlFZ9NcfFfH
 NjXA==
X-Gm-Message-State: AOAM531e2heZriWB33h44PvVHySYHsedwJunwTlmTO0H4f/y8uXlVPr0
 /4txdA4M+wQlrkkf00lOFgYfyW9KZAC4ed0e7Jedy4ks+vCCQXWXXQWw6qOB+NKo2N//ozD5KV/
 CdfdXIfVFCmEetzs=
X-Received: by 2002:adf:f751:: with SMTP id z17mr20275263wrp.114.1592987656664; 
 Wed, 24 Jun 2020 01:34:16 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyiXedthyjrvxU2qXg5/MGp7cUqffrTGHXGWWIEO4lkP/2JyLqJyTSWvpEQ3pr/OU+hAAWD9g==
X-Received: by 2002:adf:f751:: with SMTP id z17mr20275207wrp.114.1592987656060; 
 Wed, 24 Jun 2020 01:34:16 -0700 (PDT)
Received: from [192.168.178.58] ([151.20.253.55])
 by smtp.gmail.com with ESMTPSA id 11sm7236623wmg.41.2020.06.24.01.34.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 Jun 2020 01:34:15 -0700 (PDT)
Subject: Re: [PATCH] i386: Mask SVM features if nested SVM is disabled
To: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org
References: <20200623230116.277409-1-ehabkost@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <bf2f3ada-49ba-265d-044e-c817618520f2@redhat.com>
Date: Wed, 24 Jun 2020 10:34:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200623230116.277409-1-ehabkost@redhat.com>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/24 00:34:35
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
Cc: Babu Moger <babu.moger@amd.com>, Igor Mammedov <imammedo@redhat.com>,
 Yanan Fu <yfu@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 24/06/20 01:01, Eduardo Habkost wrote:
> QEMU incorrectly validates FEAT_SVM feature flags against
> GET_SUPPORTED_CPUID even if SVM features are being masked out by
> cpu_x86_cpuid().  This can make QEMU print warnings on most AMD
> CPU models, even when SVM nesting is disabled (which is the
> default).
> 
> This bug was never detected before because of a Linux KVM bug:
> until Linux v5.6, KVM was not filtering out SVM features in
> GET_SUPPORTED_CPUID when nested was disabled.  This KVM bug was
> fixed in Linux v5.7-rc1, on Linux commit a50718cc3f43 ("KVM:
> nSVM: Expose SVM features to L1 iff nested is enabled").
> 
> Fix the problem by adding a CPUID_EXT3_SVM dependency to all
> FEAT_SVM feature flags in the feature_dependencies table.
> 
> Reported-by: Yanan Fu <yfu@redhat.com>
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> ---
>  target/i386/cpu.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index b1b311baa2..a9edcaf531 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -1404,6 +1404,10 @@ static FeatureDep feature_dependencies[] = {
>          .from = { FEAT_VMX_SECONDARY_CTLS,  VMX_SECONDARY_EXEC_ENABLE_VMFUNC },
>          .to = { FEAT_VMX_VMFUNC,            ~0ull },
>      },
> +    {
> +        .from = { FEAT_8000_0001_ECX,       CPUID_EXT3_SVM },
> +        .to = { FEAT_SVM,                   ~0ull },
> +    },
>  };
>  
>  typedef struct X86RegisterInfo32 {
> 

Queued with this fixup:

diff --git a/tests/qtest/test-x86-cpuid-compat.c b/tests/qtest/test-x86-cpuid-compat.c
index 772287bdb4..8709e7d9ce 100644
--- a/tests/qtest/test-x86-cpuid-compat.c
+++ b/tests/qtest/test-x86-cpuid-compat.c
@@ -256,7 +256,7 @@ int main(int argc, char **argv)
                    "-cpu 486,+invtsc", "xlevel", 0x80000007);
     /* CPUID[8000_000A].EDX: */
     add_cpuid_test("x86/cpuid/auto-xlevel/486/npt",
-                   "-cpu 486,+npt", "xlevel", 0x8000000A);
+                   "-cpu 486,+svm,+npt", "xlevel", 0x8000000A);
     /* CPUID[C000_0001].EDX: */
     add_cpuid_test("x86/cpuid/auto-xlevel2/phenom/xstore",
                    "-cpu phenom,+xstore", "xlevel2", 0xC0000001);
@@ -348,7 +348,7 @@ int main(int argc, char **argv)
                    "-machine pc-i440fx-2.4 -cpu SandyBridge,",
                    "xlevel", 0x80000008);
     add_cpuid_test("x86/cpuid/xlevel-compat/pc-i440fx-2.4/npt-on",
-                   "-machine pc-i440fx-2.4 -cpu SandyBridge,+npt",
+                   "-machine pc-i440fx-2.4 -cpu SandyBridge,+svm,+npt",
                    "xlevel", 0x80000008);
 
     /* Test feature parsing */

Paolo


