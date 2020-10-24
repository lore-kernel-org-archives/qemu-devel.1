Return-Path: <SRS0=SOuJ=D7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C900C4363A
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Oct 2020 20:01:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C14921D41
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Oct 2020 20:01:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HZ7AdpqK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C14921D41
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47316 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kWPjg-000860-LV
	for qemu-devel@archiver.kernel.org; Sat, 24 Oct 2020 16:01:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59160)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kWPhc-0006fm-GZ
 for qemu-devel@nongnu.org; Sat, 24 Oct 2020 15:59:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:25998)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kWPha-0000PL-Ov
 for qemu-devel@nongnu.org; Sat, 24 Oct 2020 15:59:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603569585;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TVJxg8p+uCywNQtn53etvx9DPIog8lwUeMlRmVnOeBE=;
 b=HZ7AdpqKizSsxZv0L2xAaFRux/HY+FBYck4HX8a2A+nfFTa5K7yDyBmnuGM46oKv/IpfTJ
 6OlEsuhl/VUKsmUG+Minjw4gIX9B3beDAMFhnKbdH8GsFQVdm4K/iu6UYE9kaL9Vtz5dAg
 4M0+2ecuXkCk6RNDtRW4sBz2slqunBY=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-469-w9iJXoaGN_amIhcFdCb3MA-1; Sat, 24 Oct 2020 15:59:44 -0400
X-MC-Unique: w9iJXoaGN_amIhcFdCb3MA-1
Received: by mail-wr1-f70.google.com with SMTP id t11so3721741wrv.10
 for <qemu-devel@nongnu.org>; Sat, 24 Oct 2020 12:59:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=TVJxg8p+uCywNQtn53etvx9DPIog8lwUeMlRmVnOeBE=;
 b=IlM/jD6XtPtksg0mRgPdphDN1KIXtjX5qpGQ6RHsQyZ0BxxZdarfMxAwAl2FHLaS/z
 wy8+TpTLL4Dd4jPu+TE3V5YzHbK7bKEdbz7uT33YXEuCH57doUw8HfLi3Ka/xyQvuL30
 syIAf0+4SO1H56zk+MN9MMmRqxR6psrybogY3vMcVnR0zqTsOL8ekOqYlBcJnbKKxP8V
 XpqeGbCZ4eFPK4EqPgqhx9c+/FpsJxpTie4ZJb0hVN3lXxdCHZICFBknLcGm93Wk3L1l
 Qs9WmWKpyRKJoM6bdt04wuVCXVTjrmeFyt3SF3xZeimqVPN+26wMIl+ahGRrLKfAnd8J
 D9uw==
X-Gm-Message-State: AOAM531CCn+ZeqFI6T4q2aWFDXfDvbr1YCl7PqLs9KUchNAymMwoCzcW
 /vAbxL376WCKCpQvcyBKvrXRlBqxOLppb+EAA6IX1+yb3IrJCv/I9QpBug9Sn6uliOPIUSP+4MA
 EH0pnxe8omAzQ6OE=
X-Received: by 2002:adf:e412:: with SMTP id g18mr9086235wrm.211.1603569582866; 
 Sat, 24 Oct 2020 12:59:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx+OVuILbm4A01gGEh/wvjPy1y3E5hRFIYtM0Jc3NDTM5HTfn4ujVlE8g0Gif+zEdvsZoULrw==
X-Received: by 2002:adf:e412:: with SMTP id g18mr9086211wrm.211.1603569582597; 
 Sat, 24 Oct 2020 12:59:42 -0700 (PDT)
Received: from [192.168.1.36] (237.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.237])
 by smtp.gmail.com with ESMTPSA id f8sm12580659wrw.85.2020.10.24.12.59.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 24 Oct 2020 12:59:42 -0700 (PDT)
Subject: Re: [PATCH 03/15] scripts/qmp: redirect qom-xxx scripts to
 python/qemu/qmp/
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
References: <20201021185208.1611145-1-jsnow@redhat.com>
 <20201021185208.1611145-4-jsnow@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <544573e3-e4a2-3dfc-c1c9-7cb334ffcaa9@redhat.com>
Date: Sat, 24 Oct 2020 21:59:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201021185208.1611145-4-jsnow@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/24 15:52:22
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.107, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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
Cc: Cleber Rosa <crosa@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/21/20 8:51 PM, John Snow wrote:
> Redirect to the new qom scripts. These forwarders can be deleted
> eventually when there has been more time for the dust on the Python
> packaging to settle and people understand how to find these commands.
> 
> Note: You can run these by setting $PYTHONPATH in your shell and then
> running "python3 -m qemu.qmp.qom", or you can install the qemu namespace
> package and use the "qom" or "qom-set" scripts.
> 
> I've written how to install the package elsewhere, but for the sake of
> git-blame, cd to ./python, and then do:
> 
> - pip3 install [--user] [-e] .
> 
> --user will install to your local user install (will not work inside of
>    a venv), omitting this flag installs to your system-wide packages
>    (outside of a venv) or to your current virtual environment (inside the
>    venv).
> 
>    When installing to a venv or to your system-wide packages, "qom"
>    should be in your $PATH already. If you do a user install, you may
>    need to add ~/.local/bin to your $PATH if you haven't already.
> 
> -e installs in editable mode: the installed package is effectively just
>   a symlink to this folder; so changes to your git working tree are
>   reflected in the installed package.
> 
> Alternatively to the above, If you have `pipenv` installed (`pip3
> install --user pipenv`), you may also invoke 'pipenv shell' to enter a
> pipenv-managed virtual environment (as a shell process that you may
> leave with ctrt+d) that has 'qom' already in $PATH.
> 
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>   scripts/qmp/qom-get  | 66 +++------------------------------------
>   scripts/qmp/qom-list | 63 +++----------------------------------
>   scripts/qmp/qom-set  | 63 +++----------------------------------
>   scripts/qmp/qom-tree | 74 +++-----------------------------------------
>   4 files changed, 16 insertions(+), 250 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>


