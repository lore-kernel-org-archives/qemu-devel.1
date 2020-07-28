Return-Path: <SRS0=L+nc=BH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC26BC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 10:01:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 83DA920786
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 10:01:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CjZDapWH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83DA920786
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42516 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0MQa-0005cG-Oe
	for qemu-devel@archiver.kernel.org; Tue, 28 Jul 2020 06:01:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43378)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k0MPZ-0004u6-Ez
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 06:00:41 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:52612
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k0MPX-0005Us-Pb
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 06:00:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595930438;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=8llwRlhuTRz0kMN5En47W7+f3GRPs0B7vs9qH049YxE=;
 b=CjZDapWHKhVVWQ0RK1gfyXOFibhCSS3FczT4lIVEaZGqEax0aG8MxoLwChEyPPdWpJIYKN
 uEc9O4qdjMpkmHwRU6Wu6j+Sx6kENdtpcmYxqrvBed/cyu5/73X8lLevszo86OdoQoEX40
 fjsBbwxJMCVRoadf5iw5MDKl/p1m3/E=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-91-7WzPWq0HOZ-lgPn7TMmX7w-1; Tue, 28 Jul 2020 06:00:36 -0400
X-MC-Unique: 7WzPWq0HOZ-lgPn7TMmX7w-1
Received: by mail-wm1-f69.google.com with SMTP id z74so7007792wmc.4
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2020 03:00:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:cc:references:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=8llwRlhuTRz0kMN5En47W7+f3GRPs0B7vs9qH049YxE=;
 b=EPsedKQvRBMpgypud1rtOLjhVb7SsgYHKwdE0Su6XYHC+BW0x1qs2VyX/6MH7oaJVE
 02UY+5O4RfXJuZkPG26ts0Zbb2T1sZ2jBpy/lyUCzHMpYGx0P7OtFbvMUjekBIk16shX
 Q3ZJCPN7rezfHD4/SBM+CC1oodh5b/766WONCRKjrxyJsTai3wGuHTU+ikWOhDeasqH7
 pxhGNAkozKPK0iG7pO6NAgvvjPhDrqq9MEEg5thKzZ1120zdI+GCkjwcHdYxN1wmS3pW
 dNdaZ/sSe6ojwml2zyl9eCkjQ1GvSx3g3hbEMm3Ufak5u6s0NTFbjQDfCH8OCE1Qa6kA
 gE6Q==
X-Gm-Message-State: AOAM532DH5USEp68tSLSi8YetwfH+s7vvpSYrCw0HwJUMU/2SmNV/Z52
 Ar3HNwib7QhaDUlf6k4MVC4z+NKiYmR1eXUjUc3nqqtpkYWnhdZ9EvSlGGODsCV89W2dvwEplJr
 3pw9wyFoeU89zlb0=
X-Received: by 2002:a7b:c2a1:: with SMTP id c1mr3230786wmk.89.1595930435135;
 Tue, 28 Jul 2020 03:00:35 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx3X9HbyE+SCPrq9Yc39ZhAsG9Vz8HVwZoIaX6iNk77HjX+r29efYJXwp7uBX+x6ies5bt5LQ==
X-Received: by 2002:a7b:c2a1:: with SMTP id c1mr3230759wmk.89.1595930434887;
 Tue, 28 Jul 2020 03:00:34 -0700 (PDT)
Received: from [192.168.1.39] (214.red-88-21-68.staticip.rima-tde.net.
 [88.21.68.214])
 by smtp.gmail.com with ESMTPSA id z127sm3454400wme.44.2020.07.28.03.00.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Jul 2020 03:00:34 -0700 (PDT)
Subject: Re: [PATCH] configure: define CONFIG_XEN when Xen is enabled
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
References: <20200728091828.21702-1-paul@xen.org>
 <CAFEAcA_wKTFWk9Uk5HMabqfa6QkkTAdzBotmnrA_EH1BR4XjYg@mail.gmail.com>
 <32ad0742-bff2-1fbc-2f7a-d078980eb171@redhat.com>
 <CAFEAcA84fH3aGpbrJoA6S3qJ-FjD3NZMoj0G7jqvRneH_pS6=A@mail.gmail.com>
 <a09853d3-5c27-893f-54ed-63dc461bfacb@redhat.com>
Autocrypt: addr=philmd@redhat.com; keydata=
 mQINBDXML8YBEADXCtUkDBKQvNsQA7sDpw6YLE/1tKHwm24A1au9Hfy/OFmkpzo+MD+dYc+7
 bvnqWAeGweq2SDq8zbzFZ1gJBd6+e5v1a/UrTxvwBk51yEkadrpRbi+r2bDpTJwXc/uEtYAB
 GvsTZMtiQVA4kRID1KCdgLa3zztPLCj5H1VZhqZsiGvXa/nMIlhvacRXdbgllPPJ72cLUkXf
 z1Zu4AkEKpccZaJspmLWGSzGu6UTZ7UfVeR2Hcc2KI9oZB1qthmZ1+PZyGZ/Dy+z+zklC0xl
 XIpQPmnfy9+/1hj1LzJ+pe3HzEodtlVA+rdttSvA6nmHKIt8Ul6b/h1DFTmUT1lN1WbAGxmg
 CH1O26cz5nTrzdjoqC/b8PpZiT0kO5MKKgiu5S4PRIxW2+RA4H9nq7nztNZ1Y39bDpzwE5Sp
 bDHzd5owmLxMLZAINtCtQuRbSOcMjZlg4zohA9TQP9krGIk+qTR+H4CV22sWldSkVtsoTaA2
 qNeSJhfHQY0TyQvFbqRsSNIe2gTDzzEQ8itsmdHHE/yzhcCVvlUzXhAT6pIN0OT+cdsTTfif
 MIcDboys92auTuJ7U+4jWF1+WUaJ8gDL69ThAsu7mGDBbm80P3vvUZ4fQM14NkxOnuGRrJxO
 qjWNJ2ZUxgyHAh5TCxMLKWZoL5hpnvx3dF3Ti9HW2dsUUWICSQARAQABtDJQaGlsaXBwZSBN
 YXRoaWV1LURhdWTDqSAoUGhpbCkgPHBoaWxtZEByZWRoYXQuY29tPokCVQQTAQgAPwIbDwYL
 CQgHAwIGFQgCCQoLBBYCAwECHgECF4AWIQSJweePYB7obIZ0lcuio/1u3q3A3gUCXsfWwAUJ
 KtymWgAKCRCio/1u3q3A3ircD/9Vjh3aFNJ3uF3hddeoFg1H038wZr/xi8/rX27M1Vj2j9VH
 0B8Olp4KUQw/hyO6kUxqkoojmzRpmzvlpZ0cUiZJo2bQIWnvScyHxFCv33kHe+YEIqoJlaQc
 JfKYlbCoubz+02E2A6bFD9+BvCY0LBbEj5POwyKGiDMjHKCGuzSuDRbCn0Mz4kCa7nFMF5Jv
 piC+JemRdiBd6102ThqgIsyGEBXuf1sy0QIVyXgaqr9O2b/0VoXpQId7yY7OJuYYxs7kQoXI
 6WzSMpmuXGkmfxOgbc/L6YbzB0JOriX0iRClxu4dEUg8Bs2pNnr6huY2Ft+qb41RzCJvvMyu
 gS32LfN0bTZ6Qm2A8ayMtUQgnwZDSO23OKgQWZVglGliY3ezHZ6lVwC24Vjkmq/2yBSLakZE
 6DZUjZzCW1nvtRK05ebyK6tofRsx8xB8pL/kcBb9nCuh70aLR+5cmE41X4O+MVJbwfP5s/RW
 9BFSL3qgXuXso/3XuWTQjJJGgKhB6xXjMmb1J4q/h5IuVV4juv1Fem9sfmyrh+Wi5V1IzKI7
 RPJ3KVb937eBgSENk53P0gUorwzUcO+ASEo3Z1cBKkJSPigDbeEjVfXQMzNt0oDRzpQqH2vp
 apo2jHnidWt8BsckuWZpxcZ9+/9obQ55DyVQHGiTN39hkETy3Emdnz1JVHTU0Q==
Message-ID: <ee8374bd-1257-1d29-6800-3902426b1a0b@redhat.com>
Date: Tue, 28 Jul 2020 12:00:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <a09853d3-5c27-893f-54ed-63dc461bfacb@redhat.com>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/27 23:55:28
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: Stefano Stabellini <sstabellini@kernel.org>, Paul Durrant <paul@xen.org>,
 Paul Durrant <pdurrant@amazon.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Laurent Vivier <laurent@vivier.eu>,
 "open list:X86" <xen-devel@lists.xenproject.org>,
 Anthony Perard <anthony.perard@citrix.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/28/20 11:56 AM, Philippe Mathieu-Daudé wrote:
> On 7/28/20 11:53 AM, Peter Maydell wrote:
>> On Tue, 28 Jul 2020 at 10:51, Philippe Mathieu-Daudé <philmd@redhat.com> wrote:
>>> I'd rather uninline xen_enabled() but I'm not sure this has perf
>>> penalties. Paolo is that OK to uninline it?
> 
> I suppose no because it is in various hot paths:
> 
> exec.c:588:    if (xen_enabled() && memory_access_is_direct(mr, is_write)) {
> exec.c:2243:        if (xen_enabled()) {
> exec.c:2326:    if (xen_enabled()) {
> exec.c:2478:    } else if (xen_enabled()) {
> exec.c:2525:            } else if (xen_enabled()) {
> exec.c:2576:    if (xen_enabled() && block->host == NULL) {
> exec.c:2609:    if (xen_enabled() && block->host == NULL) {
> exec.c:2657:    if (xen_enabled()) {
> exec.c:3625:        if (xen_enabled()) {
> exec.c:3717:    if (xen_enabled()) {
> include/exec/ram_addr.h:295:    if (!mask && !xen_enabled()) {
> 
>>
>> Can we just follow the same working pattern we already have
>> for kvm_enabled() etc ?
> 
> This was the idea... I'll look at what I missed.

Apparently kvm_enabled() checks CONFIG_KVM_IS_POSSIBLE instead
of CONFIG_KVM, I suppose to bypass this limitation (from osdep.h):

 21 #ifdef NEED_CPU_H
 22 # ifdef CONFIG_KVM
 24 #  define CONFIG_KVM_IS_POSSIBLE
 25 # endif
 26 #else
 27 # define CONFIG_KVM_IS_POSSIBLE
 28 #endif
 29
 30 #ifdef CONFIG_KVM_IS_POSSIBLE
    ...

Paolo do you confirm this is the reason?

I'll prepare a similar patch.

> 
> Phil.
> 


