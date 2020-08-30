Return-Path: <SRS0=e36u=CI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53FA6C433E2
	for <qemu-devel@archiver.kernel.org>; Sun, 30 Aug 2020 09:45:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 183CE206FA
	for <qemu-devel@archiver.kernel.org>; Sun, 30 Aug 2020 09:45:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Qhf0ouri"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 183CE206FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52092 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kCJuO-0001wZ-9c
	for qemu-devel@archiver.kernel.org; Sun, 30 Aug 2020 05:45:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53146)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kCJtG-0001Jh-CV
 for qemu-devel@nongnu.org; Sun, 30 Aug 2020 05:44:46 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:39542
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kCJtE-0002bR-2j
 for qemu-devel@nongnu.org; Sun, 30 Aug 2020 05:44:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598780683;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kld8iRGJd+Yx3pGp+8eb8FNPt1NEofiuSmqEdB9Ujt8=;
 b=Qhf0ouriz95LhpEiFjWXmPTE/vAaKt2ipSMqbd5mHQ2Aifho/2mc3ZxQar9PnFpx1X8D2V
 33iypGhKMv56fYUKOBRrTem4qjyT4Ilas3yT5wzcaMUsXGoKZjPXZh1KRmeOBV5pxWm75w
 T5Vhi9QhTVZXwh8Pb5sE2TJJQtbifKs=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-323-pjPBdeFUOs6M13QufGwqMA-1; Sun, 30 Aug 2020 05:44:41 -0400
X-MC-Unique: pjPBdeFUOs6M13QufGwqMA-1
Received: by mail-wr1-f69.google.com with SMTP id 33so1891914wre.0
 for <qemu-devel@nongnu.org>; Sun, 30 Aug 2020 02:44:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=kld8iRGJd+Yx3pGp+8eb8FNPt1NEofiuSmqEdB9Ujt8=;
 b=FpCT9JyBp6EPLFKYgmp6WO1XOe5HWHu+qpidWV4Y64FIOiCW8rPJ2f0yOJoIsA7m3A
 YjklWg3n4eQPzWpjVoE4iYgINlnnQ/xrOkMlwH45xNycIXzWIYitsJyJYIlqLYI4UgbI
 OYVQL6OX8ehXv7tPlvbeDlGDn9lqsMPZL++4U/MncOKgt8dkNdVCcVhypojmes5kddGf
 Nplj2yjHiz4OHdryiO1ujjCJl14WgI973AajzpgDcArfZt6PdLHnuZSqg+nowginDpFh
 diuSZPXp1EkpqMqJqmM/gsHTtROTmD/CPTitAaeMuQWgU50db6qbq8HwjMuzmPDqsTDD
 LPCw==
X-Gm-Message-State: AOAM5305pC8oQ9fnvq2g8ezuTmDYrbKBTzLL+2zhsccKy1e1KmmkysFC
 LwrXRUPFR4fhiw8aVdfqwL/CJWGShYJJlc7fjcehypVqQlw6CvGmA1oaiTpSD5inN+ua0KPG/43
 qnnYezbqouUNbkjU=
X-Received: by 2002:a1c:740c:: with SMTP id p12mr6249707wmc.53.1598780680131; 
 Sun, 30 Aug 2020 02:44:40 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwoDPdIMWvo3OEJR4L1zWopJoi7y4vLT9nSbkcMRJerD5r5lF81HG/2yYdwgqM0dgYX/G9hmg==
X-Received: by 2002:a1c:740c:: with SMTP id p12mr6249693wmc.53.1598780679858; 
 Sun, 30 Aug 2020 02:44:39 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:9d8:ed0a:2dde:9ff7?
 ([2001:b07:6468:f312:9d8:ed0a:2dde:9ff7])
 by smtp.gmail.com with ESMTPSA id z8sm6280926wmf.10.2020.08.30.02.44.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 30 Aug 2020 02:44:39 -0700 (PDT)
Subject: Re: [PATCH 5/6] meson: install $localstatedir/run for qga
To: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
References: <20200826130622.553318-1-marcandre.lureau@redhat.com>
 <20200826130622.553318-6-marcandre.lureau@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <ea92a59d-2620-2a8c-fb9f-c90a4ad1eace@redhat.com>
Date: Sun, 30 Aug 2020 11:44:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200826130622.553318-6-marcandre.lureau@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Received-SPF: pass client-ip=207.211.31.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/30 05:44:43
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.959,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.809, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: berrange@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 26/08/20 15:06, marcandre.lureau@redhat.com wrote:
> diff --git a/qga/meson.build b/qga/meson.build
> index 3f28f74b52..e5c5778a3e 100644
> --- a/qga/meson.build
> +++ b/qga/meson.build
> @@ -82,6 +82,8 @@ if targetos == 'windows'
>      all_qga += [qga_msi]
>      alias_target('msi', qga_msi)
>    endif
> +else
> +  install_subdir('run', install_dir: get_option('localstatedir'))
>  endif

This doesn't work if /var/run exists and is a symlink:

Installing subdir /home/pbonzini/ff/run to /home/pbonzini/ff/build/test/var/local/run
Traceback (most recent call last):
  File "/usr/lib/python3.8/site-packages/mesonbuild/mesonmain.py", line 131, in run
    return options.run_func(options)
  File "/usr/lib/python3.8/site-packages/mesonbuild/minstall.py", line 538, in run
    installer.do_install(datafilename)
  File "/usr/lib/python3.8/site-packages/mesonbuild/minstall.py", line 357, in do_install
    self.install_subdirs(d) # Must be first, because it needs to delete the old subtree.
  File "/usr/lib/python3.8/site-packages/mesonbuild/minstall.py", line 383, in install_subdirs
    d.dirmaker.makedirs(full_dst_dir, exist_ok=True)
  File "/usr/lib/python3.8/site-packages/mesonbuild/minstall.py", line 60, in makedirs
    os.makedirs(path, exist_ok=exist_ok)
  File "/usr/lib64/python3.8/os.py", line 223, in makedirs
    mkdir(name, mode)
FileExistsError: [Errno 17] File exists: '/home/pbonzini/ff/build/test/var/local/run'

Since DESTDIR is not available, there isn't really a good way to do
this check.  We can:

- keep the makefile

- use an install script

- create it in qemu-ga just like on win32

Probably the last one is the best.

Paolo


