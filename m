Return-Path: <SRS0=be0Y=DK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B08E8C4363D
	for <qemu-devel@archiver.kernel.org>; Sat,  3 Oct 2020 07:13:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C05F206C9
	for <qemu-devel@archiver.kernel.org>; Sat,  3 Oct 2020 07:13:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Zw0vk6Rd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C05F206C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55720 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kObjT-0001Uf-T0
	for qemu-devel@archiver.kernel.org; Sat, 03 Oct 2020 03:13:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43362)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kObiM-00013C-SJ
 for qemu-devel@nongnu.org; Sat, 03 Oct 2020 03:12:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:43021)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kObiJ-0001Fb-O6
 for qemu-devel@nongnu.org; Sat, 03 Oct 2020 03:12:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601709134;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+fRZsKPEy5y6HK3qTRilR4ubF4SoNqZpU3aiClpoKcM=;
 b=Zw0vk6RdZ6Uc7h8w0BzCdQdXgQxTXRCN12imKKaodHTezvUBBhSvQRFR2Bo4RkDKktF0D7
 lx7bNy1w9do0vxPy+7vRJHqm0/Saq9j6JJh5ytY/NUPWcOp3KGSkyOzlnSRJHg6wf68BZP
 +6WS/LW/DePSfsD5WsTctR0TIKVWIDQ=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-404-CrGT0ligOfS0nllqTcsxCw-1; Sat, 03 Oct 2020 03:12:12 -0400
X-MC-Unique: CrGT0ligOfS0nllqTcsxCw-1
Received: by mail-wr1-f69.google.com with SMTP id v5so1492026wrs.17
 for <qemu-devel@nongnu.org>; Sat, 03 Oct 2020 00:12:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=+fRZsKPEy5y6HK3qTRilR4ubF4SoNqZpU3aiClpoKcM=;
 b=Wf+penjJppI+1LArsJG5i1IIN0mt2Kdoc+ZNfUmcboiYE9gJExl6Cc7K4jq3obmezK
 zr87n1g+uKuWJ1G6k98VpYHygn6nfPwPvhqtXU3bUdCFEmrEVXg26WrkxKUFklhfrHLh
 Zy7qm/cAbw8xsC1EL/kH+nQonr+oPbv+OcbSrXNTwXUTFuC6pDGeO5QvLJJ7aznBwsug
 uJsOK1Y3z1RglRT2DwK4nW+zQTWEfzcrTgXdYP193k9eKSEcAwwyls1p2dtD+nx8AL6G
 +pR8wYM8eR7VEquqLBz3rtx/7ihFVu7hJKl0iuGxnWUJMNg0y75V3WatdjBmwdum/ZNW
 Hgtw==
X-Gm-Message-State: AOAM531rvqyC8WudzfK1iIcS46QrrJh/js5lMxrIuJxYmDeA14FAAv/N
 GjgQJOv1duTvTrw5J3CSGGJHvxSStJHpI2uzdZmMove86y5BU22NXsbWJDjbpjtONtLD1S8ebn6
 eWndlkW8+/HVkEpc=
X-Received: by 2002:a7b:c0d8:: with SMTP id s24mr1477353wmh.156.1601709130863; 
 Sat, 03 Oct 2020 00:12:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzTR+fWzMPo0IRGWtsuzq11sJjLwdG9zmiBC60d+EtFFPH7nXqFaMha7vReqciITn4hU5vjBQ==
X-Received: by 2002:a7b:c0d8:: with SMTP id s24mr1477339wmh.156.1601709130642; 
 Sat, 03 Oct 2020 00:12:10 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:47e0:e742:75ba:b84d?
 ([2001:b07:6468:f312:47e0:e742:75ba:b84d])
 by smtp.gmail.com with ESMTPSA id o6sm480909wrm.69.2020.10.03.00.12.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 03 Oct 2020 00:12:10 -0700 (PDT)
Subject: Re: [PULL v2 00/11] capstone + disassembler patch queue
To: Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20201002165127.130369-1-richard.henderson@linaro.org>
 <CAFEAcA_kr5M+TbLDiYVMZbSMgpZE8fN+ae27rgOVkpOj2b9-xQ@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <8156e2b2-241c-11b6-cf4b-0da4f59215db@redhat.com>
Date: Sat, 3 Oct 2020 09:12:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_kr5M+TbLDiYVMZbSMgpZE8fN+ae27rgOVkpOj2b9-xQ@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/03 02:43:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.256, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 02/10/20 22:37, Peter Maydell wrote:
> ../src/meson.build:753: WARNING: Trying to compare values of different
> types (bool, str) using ==.
> The result of this is undefined and will become a hard error in a
> future Meson release.
> Configuring config-host.h using configuration
> Program scripts/hxtool found: YES
> Program scripts/shaderinclude.pl found: YES
> Program scripts/qapi-gen.py found: YES
> Program scripts/qemu-version.sh found: YES
> Run-time dependency threads found: YES
> Program keycodemapdb/tools/keymap-gen found: YES
> Program scripts/decodetree.py found: YES

This can be rewritten like

-if capstone_opt == 'disabled'
-  capstone_opt = false
-elif capstone_opt in ['enabled', 'auto', 'system']
+if capstone_opt in ['enabled', 'auto', 'system']
   have_internal = fs.exists('capstone/Makefile')
   capstone = dependency('capstone', static: enable_static,
                         required: capstone_opt == 'system' or
                                   capstone_opt == 'enabled' and not have_internal)
   if capstone.found()
     capstone_opt = 'system'
   elif have_internal
     capstone_opt = 'internal'
   else
-    capstone_opt = false
+    capstone_opt = 'disabled'
   endif
 endif
 if capstone_opt == 'internal'

...
-summary_info += {'capstone':          capstone_opt}
+summary_info += {'capstone':          capstone_opt == 'disabled' ? false : capstone_opt}


That said, this also showed a bug which can be fixed like this:

-  have_internal = fs.exists('capstone/Makefile')
+  have_internal = fs.exists(meson.current_source_dir() / 'capstone/Makefile')

Paolo


