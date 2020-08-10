Return-Path: <SRS0=QvPl=BU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 067BBC433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 19:46:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C3C0522BF3
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 19:46:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="APlib/mR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3C0522BF3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48870 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5Dku-00058K-46
	for qemu-devel@archiver.kernel.org; Mon, 10 Aug 2020 15:46:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50188)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k5DkE-0004Im-VB
 for qemu-devel@nongnu.org; Mon, 10 Aug 2020 15:46:07 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:44868
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k5DkC-0004Pn-9W
 for qemu-devel@nongnu.org; Mon, 10 Aug 2020 15:46:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597088762;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZFQDvFq5XUSVqWCxkVwQHes3KI9PFlIo12g+4SRXqjc=;
 b=APlib/mRJut9F24a6iUITFycipIoPRqdftfAxXvc+c+bmIIT7GdeV0wyVSZ4ps+tPYWAa+
 R2FP79DtG1pC+ySO3SLsS+x7FqNH+AKH5sUH5GwzJQGt1W4OKi26uuYIXVd0cxFffUjUwW
 3QSW9BVaUn6fvMRiHtxKQL6xVoX06BM=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-337-oBXmjuwtNQ25IlzlUORKUQ-1; Mon, 10 Aug 2020 15:46:01 -0400
X-MC-Unique: oBXmjuwtNQ25IlzlUORKUQ-1
Received: by mail-wr1-f69.google.com with SMTP id t3so4612240wrr.5
 for <qemu-devel@nongnu.org>; Mon, 10 Aug 2020 12:46:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ZFQDvFq5XUSVqWCxkVwQHes3KI9PFlIo12g+4SRXqjc=;
 b=XhQU7ZRvx+DXrwPvGJLmLqj2t15rKcMQ2pMOzDMlKu5MtQA7tAP6PBVrEhkJ/clLi4
 Akebfre3zYOLSJ3woRe7FNFHdpLkEJqYMS3iVIwdJMizAfpS2JSHpAEDpGguormCBxwZ
 URB3Y8YYQYt7eSO12WBt6TJUhpGVCW+s5XK9+WB0YWerBHm8E849RRneBLh0O6BbqhKp
 uos7w4eHYNWI2IS5VDpZ9d2CHFjENjE9uS+FeJE6UHrxNyqdjud+PKen+Obi1pGNgwyb
 h8StHUbYlC2zYrGEx7kkKFgfKaJgy2MVH0tIDJwv0R4DtkKletdE5PLTVTAm1orY2bxf
 8tWg==
X-Gm-Message-State: AOAM5305ld0CwzM4kn8obUyEm3i3pR96IN9xS/3O2pVxmsLCpy4vtZi/
 gKl2tU2L5SH2RLSq7WqtPtPA5EV2EA/+kG/putZ+7osGQHwKA6Ed6Cso3ICvba6UFMKac+o8ZXD
 HK4P5SoX2cGPwPXc=
X-Received: by 2002:adf:e550:: with SMTP id z16mr26037771wrm.329.1597088759865; 
 Mon, 10 Aug 2020 12:45:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyFFAr6hus8cOlEXO/zeyOHpYum/lcfilO7MhH7emRPi1OXdwyPctryiSbqKLndqaigVYsatQ==
X-Received: by 2002:adf:e550:: with SMTP id z16mr26037758wrm.329.1597088759641; 
 Mon, 10 Aug 2020 12:45:59 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:5d6c:f50:4462:5103?
 ([2001:b07:6468:f312:5d6c:f50:4462:5103])
 by smtp.gmail.com with ESMTPSA id b129sm957535wmb.29.2020.08.10.12.45.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Aug 2020 12:45:59 -0700 (PDT)
Subject: Re: [PATCH 135/147] meson: sphinx-build
To: Peter Maydell <peter.maydell@linaro.org>
References: <1597079345-42801-1-git-send-email-pbonzini@redhat.com>
 <1597079345-42801-136-git-send-email-pbonzini@redhat.com>
 <CAFEAcA8J3-Sb4r4CqmLE=cmZHL311_B4EZD7L5+N-OhHD+X9jg@mail.gmail.com>
 <0c4c75a6-0165-6549-6d3d-24c3f3f7d180@redhat.com>
 <CAFEAcA8o6PvVMhxS5VPmqMiXEjCdFf194-LAOqrMm4VhaOAV6w@mail.gmail.com>
 <85e3b495-9855-dc16-986a-1042de99237c@redhat.com>
 <CAFEAcA8Azxzyjwg8YG2ALmEkXGrm0csFYPzJRdzYMkdHag+01w@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <0e1a3132-2426-b553-c4c7-747c339f2eaa@redhat.com>
Date: Mon, 10 Aug 2020 21:45:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8Azxzyjwg8YG2ALmEkXGrm0csFYPzJRdzYMkdHag+01w@mail.gmail.com>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/10 04:13:00
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/08/20 21:36, Peter Maydell wrote:
>> It should be possible and probably not too hard once I figure out how
>> Sphinx events work.  It's a fair request since build_always_stale is
>> inferior and Meson requires no particular magic to include the depfile.
>>  Maybe that will win you over. :)
>>
>> I can also leave out sphinx from the initial conversion.
> If we have a working-but-build-always conversion for Sphinx
> I'd be happy to take that and then upgrade it to processing
> the dependencies properly later.
> 
> (The thing I'm not really looking forward to is updating
> the qapi-doc-to-rst patchset to Meson...)

Since it's all handled internally by sphinx, I think you only need to 
add the man pages to the dictionary, and get rid of the corresponding 
Texinfo outputs in qapi/meson.build and qga/meson.build?

In other words, it should be just this:

diff --git a/qapi/meson.build b/qapi/meson.build
index de5b16f..315252f 100644
--- a/qapi/meson.build
+++ b/qapi/meson.build
@@ -96,7 +96,7 @@ foreach module : qapi_all_modules
 endforeach
 
 qapi_files = custom_target('shared QAPI source files',
-  output: qapi_util_outputs + qapi_specific_outputs + qapi_nonmodule_outputs + ['qapi-doc.texi'],
+  output: qapi_util_outputs + qapi_specific_outputs + qapi_nonmodule_outputs,
   input: [ files('qapi-schema.json') ],
   command: [ qapi_gen, '-o', 'qapi', '-b', '@INPUT0@' ],
   depend_files: [ qapi_inputs, qapi_gen_depends ])
@@ -120,5 +120,3 @@ foreach output : qapi_specific_outputs + qapi_nonmodule_outputs
   specific_ss.add(when: 'CONFIG_SOFTMMU', if_true: qapi_files[i])
   i = i + 1
 endforeach
-
-qapi_doc_texi = qapi_files[i]
diff --git a/qga/meson.build b/qga/meson.build
index 6fdddd6..741b683 100644
--- a/qga/meson.build
+++ b/qga/meson.build
@@ -16,7 +16,7 @@ qga_qapi_outputs = [
 ]
 
 qga_qapi_files = custom_target('QGA QAPI files',
-                               output: qga_qapi_outputs + ['qga-qapi-doc.texi'],
+                               output: qga_qapi_outputs,
                                input: 'qapi-schema.json',
                                command: [ qapi_gen, '-o', 'qga', '-p', 'qga-', '@INPUT0@' ],
                                depend_files: qapi_gen_depends)
@@ -27,7 +27,6 @@ foreach output: qga_qapi_outputs
   qga_ss.add(qga_qapi_files[i])
   i = i + 1
 endforeach
-qga_qapi_doc_texi = qga_qapi_files[i]
 
 qga_ss.add(files(
   'commands.c',


Paolo


