Return-Path: <SRS0=H3r+=CW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B834C43461
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Sep 2020 16:12:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1FD66221EB
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Sep 2020 16:12:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JoIyBS5x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FD66221EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39056 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHUcV-0006iY-AC
	for qemu-devel@archiver.kernel.org; Sun, 13 Sep 2020 12:12:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55918)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kHUbp-0006DY-SC
 for qemu-devel@nongnu.org; Sun, 13 Sep 2020 12:12:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:53414)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kHUbm-0002Nx-Bx
 for qemu-devel@nongnu.org; Sun, 13 Sep 2020 12:12:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600013525;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Gk7xVrLg+I1SKBhyr7Q8iv17NF0QWXX4qlgZUO0d9cg=;
 b=JoIyBS5xlv4t4/g3fKNwxb999r0LXMMkUPPJm3K+w3zCvANzWk/ooummNhpYij2Al2Sp5I
 54A24e4cZjk6GX8CcFuGMtv9+Zx+ElWuovJZo1dWwMwYLa+irJcfQg4co4WlrdM2dTT+az
 FiZyww4BWREjhaKumAPTvQ3WKdF7RRE=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-327-raXCEUF_MMKQAGAAnkG-Yg-1; Sun, 13 Sep 2020 12:12:03 -0400
X-MC-Unique: raXCEUF_MMKQAGAAnkG-Yg-1
Received: by mail-ed1-f72.google.com with SMTP id d13so8363497edz.18
 for <qemu-devel@nongnu.org>; Sun, 13 Sep 2020 09:12:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Gk7xVrLg+I1SKBhyr7Q8iv17NF0QWXX4qlgZUO0d9cg=;
 b=BQjlFxHUv4mfn7PpObXdwPWYnsSdUuktUrn5w1XV+YuZlgaFjjC4BatPyxMMcwfTop
 Iy57S2JPYITUyzpHd2Da3IlRFzT3CqFp0xRLoRdq3w9vzJku3YtSIHVerP6d5s4FagyA
 ScaqnqNjTFLDrh6HQfIcb9Do+GOrTUhDgDWWOK2nA75cZgBimV9Mqu4D6bHpol0I25xx
 ZMg40QW6VI7p80TzHp1CHLQZsdwsJ7XedHruihHvNTfjvS7tfbiTtlwASLkIys55MtJo
 VTJpTEqC17XdbtEcmp3f7NdcGna4/bR+zbOKUthX3JOfkr57ZivgBfnjBWvu+VzGv8en
 0ndw==
X-Gm-Message-State: AOAM532zwDZRlICufJNf/RUS/Kt6xBiezEruGu6H5u5WE4jdkzEKVyHP
 9v5B4CTBK+uCGNyt5xoN7lU05HJPkVw4Yp9+qQUO4TS4vAO8aTOODrPcdaamlsX8y7/XrR2Z0YH
 MRRgqP4qlUFyNhrQ=
X-Received: by 2002:a50:8d4b:: with SMTP id t11mr13603335edt.5.1600013522687; 
 Sun, 13 Sep 2020 09:12:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxwPBUvuuDXlTpWzd5uNm4zIi8Sm3p39wa7UxAtEUr9T0H9R+J5FgnIqmVbbIUYFUj6ikRF9w==
X-Received: by 2002:a50:8d4b:: with SMTP id t11mr13603304edt.5.1600013522420; 
 Sun, 13 Sep 2020 09:12:02 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:d03c:628a:ca24:cea1?
 ([2001:b07:6468:f312:d03c:628a:ca24:cea1])
 by smtp.gmail.com with ESMTPSA id o11sm7192293edr.2.2020.09.13.09.12.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 13 Sep 2020 09:12:01 -0700 (PDT)
Subject: Re: [PATCH v8 27/27] Revert "configure: add --ninja option"
To: luoyonggang@gmail.com
References: <20200912224431.1428-1-luoyonggang@gmail.com>
 <20200912224431.1428-28-luoyonggang@gmail.com>
 <34306ec4-bafb-20dc-f90f-ff320fa4b575@redhat.com>
 <CAE2XoE9GEB2svRZVJVWxc4uC1afv9hEvij0G8Xxygw_Xk4DxXw@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <404087db-7710-653b-da39-f47d4d4b26da@redhat.com>
Date: Sun, 13 Sep 2020 18:12:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <CAE2XoE9GEB2svRZVJVWxc4uC1afv9hEvij0G8Xxygw_Xk4DxXw@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=216.205.24.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/13 11:31:51
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.695,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1,
 RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, Ed Maste <emaste@freebsd.org>,
 Michael Roth <mdroth@linux.vnet.ibm.com>, Qemu-block <qemu-block@nongnu.org>,
 Stefan Weil <sw@weilnetz.de>, Xie Changlong <xiechanglong.d@gmail.com>,
 Peter Lieven <pl@kamp.de>, qemu-level <qemu-devel@nongnu.org>,
 Max Reitz <mreitz@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Wen Congyang <wencongyang2@huawei.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Li-Wen Hsu <lwhsu@freebsd.org>, Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 13/09/20 18:03, 罗勇刚(Yonggang Luo) wrote:
> 
> _WIN32 are more precise and only depends on the compiler, on the
> other hand, CONFIG_POSIX  and  CONFIG_WIN32  need configure
> scripts. I prefer  _WIN32  unless the compiler can not provide enough
> information.

That's not what the QEMU coding standards say; we generally don't test
the preprocessor symbols.  If we were to change to _WIN32, it should be
done at once on the whole codebase (don't do it :)).

Paolo


