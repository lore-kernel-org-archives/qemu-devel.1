Return-Path: <SRS0=H0ck=CE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62EC8C433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 15:43:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E74A2078A
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 15:43:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DA8Jr5Wq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E74A2078A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38994 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAxac-0001OP-Eo
	for qemu-devel@archiver.kernel.org; Wed, 26 Aug 2020 11:43:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38416)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kAxYf-00084S-J5
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 11:41:53 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:28142
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kAxYd-0008Ib-A4
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 11:41:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598456510;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XELHgrkm+K8lkrdj5vD1uJxxkTfmzueWyKoYgsc3u0M=;
 b=DA8Jr5WqcSbgGNsfUtAvCBce742NF0cClTzcUuIDovcU++8oAaF1ctlnfF6MM7sgkeXIly
 o/FcqrFVq1ofofydz5z005b+B3TQ97YpRE91g/uhawYbqnX0zc17IhJ3VmIO5esD0skcWs
 KNefvqXYPayOSPWenr8q8/VUdPRYBgw=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-436-UDpV-Nh9MJOVtTqybAma9A-1; Wed, 26 Aug 2020 11:41:48 -0400
X-MC-Unique: UDpV-Nh9MJOVtTqybAma9A-1
Received: by mail-ej1-f71.google.com with SMTP id f10so1152825ejc.23
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2020 08:41:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=XELHgrkm+K8lkrdj5vD1uJxxkTfmzueWyKoYgsc3u0M=;
 b=aJgPye3jImsWUhpMq3CipDnC2DmSSdqOgPXlgIV2OQsqVULG3Fr1b/4fBsPqFhfzZa
 OCsXXRcnFQGJjLIDzf2FoOpjP8N9sNZboqUfXFCm7g2f0OjjRkawlUTQHJ+w99pOAh2e
 kryidWtb87T9CMIYu/cL60xakA17N8/39TtHxVt4kLVga/EkvOe4hHh3Us+8dPKQD15x
 4yxF6oYluuPqFfQWxAUz2SdjK3W0awanbnHicuWMxNLyGMyNI2Wc+ZKHwY26uFbZo8uC
 vcGHKHme6CBZxkHkloPS78kZb3mdQvLjE+uYfCQAs0glTKZX5QCCulwFgUosdiKuYijl
 BrRQ==
X-Gm-Message-State: AOAM532uUbAjzMVT/s+MGwTq8/DGxstq+tfke2RzaTOoJSVpGloKNw9L
 5bTr2asTFMIjxNNRhM1/cTuyNCu3ugr+pqxoWpt8VoKV1mLX6oXLd2Q1hrwfNutv6eQeSnFBMdv
 v5s40+QWxKeo+EJ5iKCdK3qm3LmZpoMs=
X-Received: by 2002:a17:906:d9db:: with SMTP id
 qk27mr15409683ejb.230.1598456506796; 
 Wed, 26 Aug 2020 08:41:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyune7+YHXKMZ/ZA+YdfIUtqFOlzGrZnWohDBa+I7hQY1xTUhzoepSQvaoaVJ1cIHYCSe3ISFtJVuOHsWSniPA=
X-Received: by 2002:a17:906:d9db:: with SMTP id
 qk27mr15409670ejb.230.1598456506575; 
 Wed, 26 Aug 2020 08:41:46 -0700 (PDT)
MIME-Version: 1.0
References: <20200826151006.80-1-luoyonggang@gmail.com>
 <CABgObfYdjLouNp8ZvqHmB-xsOJdUgxv3zJL4A1GKuWggh7fnbA@mail.gmail.com>
 <CAE2XoE-JKpqQj7H3wMt0+WNTBR1JS6ZyiLOhqOYkaVj5Zzgp5A@mail.gmail.com>
 <CABgObfYk8zG3TBB3UZhvmZLGqLO+bZF+AmL6hSQkCgiCKKW4ug@mail.gmail.com>
 <CAE2XoE-U6Ls9gMSSDB4Qajn-m0vrBBP-+C0K4tncvzzr3Nwq9w@mail.gmail.com>
In-Reply-To: <CAE2XoE-U6Ls9gMSSDB4Qajn-m0vrBBP-+C0K4tncvzzr3Nwq9w@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 26 Aug 2020 17:41:35 +0200
Message-ID: <CABgObfaByaW9jqRZkV3BGONmqFaYwnQDREemYit8s+qYTAeP4g@mail.gmail.com>
Subject: Re: [PATCH v5 1/6] meson: Fixes the ninjatool issue that E$$: are
 generated in Makefile.ninja
To: luoyonggang@gmail.com
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/26 01:10:45
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.959,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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
Cc: =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Aug 26, 2020 at 5:39 PM =E7=BD=97=E5=8B=87=E5=88=9A(Yonggang Luo) <=
luoyonggang@gmail.com> wrote:
>> Ok, that's useful. But can you just send the whole file (it's huge but
>> you can gzip it or something similar)?
>>
>> Paolo
>
> I am OK with that, but where should I post

Just pbonzini@redhat.com.

Regarding the version.rc_version.o target in build.ninja, I see it translat=
ed to

version.rc_version.o: private .var.command :=3D
"C:/CI-Tools/msys64/mingw64/bin/x86_64-w64-mingw32-windres.EXE"
"-I./." "-I../qemu.org/." "../qemu.org/version.rc"
"version.rc_version.o" "--preprocessor-arg=3D-MD"
"--preprocessor-arg=3D-MQversion.rc_version.o"
"--preprocessor-arg=3D-MFversion.rc_version.o.d"
version.rc_version.o: private .var.description :=3D Generating Windows
resource for file 'version.rc' with a custom command
version.rc_version.o: private .var.out :=3D version.rc_version.o

Is this wrong?

Paolo


