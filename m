Return-Path: <SRS0=Yszf=AA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56876C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 11:02:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B8CC208B8
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 11:02:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FAthlsfu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B8CC208B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37848 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jmEmh-0000dA-5t
	for qemu-devel@archiver.kernel.org; Fri, 19 Jun 2020 07:02:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34766)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jmEl7-0008FV-Nz
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 07:00:33 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:37285
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jmEl4-0004NT-IF
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 07:00:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592564428;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pvf+mJiuAL+fNqfFwKpJJq0mZGMWy0yTIA5DYxYhh1Q=;
 b=FAthlsfuQaYznbQ/uO/qSuJEn0yt4yEW+7TxKPBfE/afqP4EMcH+ZTN+YBNqjBwIdNR/3W
 DGJ92EErWvXV4djn0wHwXvTc5Fh8NU77iRFa1xU0DweHe+GiuX/ntkKuDvO0xwiPe3ZOG0
 U0BNPEcnDaIHtMrXWMTdm82KKlbrg5g=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-32-GfpgtRabO-67XV5FuXjD7w-1; Fri, 19 Jun 2020 07:00:23 -0400
X-MC-Unique: GfpgtRabO-67XV5FuXjD7w-1
Received: by mail-wr1-f69.google.com with SMTP id p10so4124432wrn.19
 for <qemu-devel@nongnu.org>; Fri, 19 Jun 2020 04:00:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=pvf+mJiuAL+fNqfFwKpJJq0mZGMWy0yTIA5DYxYhh1Q=;
 b=K/6y1DGxZHRbrqUIVHgo9EwJd/DrCSkgilBHEuZ3iF+1MyVaNz4z1TKw9zTml0lnIK
 Frrf0bfe6ckrOFOF3rSC6s2Vxgh1EvDvff0kU0dS4nXQcUmm/OVzjddWGzStatNs/IhU
 MLgbdTO4qhaC+03euYtH9Z7zzF+8Rw4RHQc4DRJpkjLq82NEIcNkxowZVNj4h5g9rHUt
 ZcHlivErWjsYRvMD0Sg+tUXoxsPZvokxLyd57SvNgEogPdBX4agqzvpqVhkeB4h1ktf/
 1j0KkzF4aIn7znGIuiiYqs2u1xexaw7DI6x2nzUZM2JYxBvqPduxoZEK0rcK052fiSau
 t2Zg==
X-Gm-Message-State: AOAM530+CWY73y0k1xfXotlztio4B2qla4bNas5qWlrNgokfEnMPUl2e
 k5M+4A2StLjQ+z9w3yxpm48OGNpm/1IGIifB5LEQLMmjzZywpbBl/lI2QoOVZbvfH9mWAk0Y/+/
 G/N739Jv5xTCd57g=
X-Received: by 2002:a7b:c08e:: with SMTP id r14mr3330852wmh.78.1592564422176; 
 Fri, 19 Jun 2020 04:00:22 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwT4RCCtPRGTaEL8Mf+8LVK1u6dT98jQ3rxLEGylN4LVFDzGI6Zuse1CPplh4BdxjqOYG0nrQ==
X-Received: by 2002:a7b:c08e:: with SMTP id r14mr3330824wmh.78.1592564421935; 
 Fri, 19 Jun 2020 04:00:21 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:e1d2:138e:4eff:42cb?
 ([2001:b07:6468:f312:e1d2:138e:4eff:42cb])
 by smtp.gmail.com with ESMTPSA id d5sm7393585wrb.14.2020.06.19.04.00.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 19 Jun 2020 04:00:21 -0700 (PDT)
Subject: Re: [PATCH v1] memory: assert MemoryRegionOps callbacks are defined
To: P J P <ppandit@redhat.com>
References: <20200618121218.215808-1-ppandit@redhat.com>
 <87r1ucv7pe.fsf@linaro.org> <51f137f0-89ee-e130-a43e-c82d0b3623fa@redhat.com>
 <nycvar.YSQ.7.77.849.2006191022400.92950@xnncv>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <afec3585-c624-5145-687c-08ab813454cd@redhat.com>
Date: Fri, 19 Jun 2020 13:00:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <nycvar.YSQ.7.77.849.2006191022400.92950@xnncv>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/19 05:19:18
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Li Qiang <liq3ea@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Lei Sun <slei.casper@gmail.com>, Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 19/06/20 12:48, P J P wrote:
> | - hw/nvram/nrf51_nvm.c's flash_ops which is fixed if ROMD regions are
> | changed not to require a read callback.
> | 
> | - designware_pci_host_msi_ops which is broken and should have a dummy
> | read callback.
> 
> 
> ie. we add these routines along with the assertions here, right?
> 
> Earlier patch series adds routines for nrf51_nvm and designware. I'll add 
> r/w routines for tz_ppc_dummy_ops.

In this case, please add "Based-on: <MESSAGEID>" to the patch so that
it's clear to the reviewer that there are dependencies.

Thanks!

Paolo


