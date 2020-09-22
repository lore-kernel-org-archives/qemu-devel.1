Return-Path: <SRS0=0j61=C7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3EB0C2D0E2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 13:05:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E6B22396D
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 13:05:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J/c3IZUq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E6B22396D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46680 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKhyn-0000M0-6Q
	for qemu-devel@archiver.kernel.org; Tue, 22 Sep 2020 09:05:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51924)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kKhsl-0004Dh-Vg
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 08:58:56 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:54564
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kKhsk-0003wb-6p
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 08:58:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600779532;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=kPDsO1eyFkdVPDmYwUfg9U/1aBMKStps2jue86hmL4I=;
 b=J/c3IZUqAY+btoHBMXy3BP2HYx3oMl+hwgdYOnRnITbp/NCOD5lQDenuaEXoGzBHFenvRa
 ddLDzm/2qwi7ozvidlfIR3OTYZJnlLWqyLtbUlHWrn7VdKl5iLT9KFB2cmrivKDMdtduyF
 4uhDad9DiH05++yBBw5+8c+qgqP4pP0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-487-Yaeu4L9sOTaxK2zellWqGQ-1; Tue, 22 Sep 2020 08:58:51 -0400
X-MC-Unique: Yaeu4L9sOTaxK2zellWqGQ-1
Received: by mail-wm1-f70.google.com with SMTP id w3so882943wmg.4
 for <qemu-devel@nongnu.org>; Tue, 22 Sep 2020 05:58:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=kPDsO1eyFkdVPDmYwUfg9U/1aBMKStps2jue86hmL4I=;
 b=YcCITcq2RW9fEfDNeRbOar3IV7w5z68CAfxtMS6CExkr3bGfhubRTTEqiwC2NELald
 JgvK0edpkwojVOR2ruQ6nI72Fi14bljRBQ8mhkrpj0N3n6/1dVs2Pk9DR+EDgj9SICVi
 9ma63C3r89R1GiwEZK9+5xUZhj5iwO684LJDpGqeFE8FWtPvQdnxXuJz4tm6UEhtgCs2
 F08C+SNzitRfDGB5Tzi8fS9gJZ0p2ogGoebsjcoSUQX1cFjjtlqefQ4PnwhDAj8B77vZ
 dSMuBBmIhmRZ+lJ6efDwj4TCz73K44cjY6yQXTk7yaQawRg1KVLTQ76Q60G031clyYVU
 fqfA==
X-Gm-Message-State: AOAM531ogndsOf+/PE7tSXdRo9RRs8c2qlU/6/4YKoa2AfuKiT3ZfdaX
 GIpx9zQ3maH1Wq2DZMA8hezR8Q8AtunuL1R9TAc0r7w4lxTB32w3JutaKZjM3L+1I3FzrLhSMcI
 tjikCIJI3jyJzOJE=
X-Received: by 2002:a5d:5307:: with SMTP id e7mr5174628wrv.215.1600779530097; 
 Tue, 22 Sep 2020 05:58:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzyl5DneBg84kZH2QakEAsVj6ETYpORtWCTOvgxY88YSqu9rDrcpdpMrmBau79qs+9lCCpf0Q==
X-Received: by 2002:a5d:5307:: with SMTP id e7mr5174612wrv.215.1600779529910; 
 Tue, 22 Sep 2020 05:58:49 -0700 (PDT)
Received: from [192.168.1.36] (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id 2sm4407378wmf.25.2020.09.22.05.58.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Sep 2020 05:58:49 -0700 (PDT)
Subject: Re: [PATCH v5 02/15] replay: provide an accessor for rr filename
To: Pavel Dovgalyuk <pavel.dovgalyuk@ispras.ru>, qemu-devel@nongnu.org
References: <160077693745.10249.9707329107813662236.stgit@pasha-ThinkPad-X280>
 <160077694915.10249.14893037100345813692.stgit@pasha-ThinkPad-X280>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
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
Message-ID: <0ca456d5-6b3e-2eed-46db-1b85fddb3928@redhat.com>
Date: Tue, 22 Sep 2020 14:58:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <160077694915.10249.14893037100345813692.stgit@pasha-ThinkPad-X280>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=207.211.31.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 01:57:21
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.455,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: kwolf@redhat.com, wrampazz@redhat.com, ehabkost@redhat.com,
 mtosatti@redhat.com, armbru@redhat.com, mreitz@redhat.com, stefanha@redhat.com,
 crosa@redhat.com, pbonzini@redhat.com, alex.bennee@linaro.org,
 zhiwei_liu@c-sky.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/22/20 2:15 PM, Pavel Dovgalyuk wrote:
> From: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
> 
> This patch adds an accessor function for the name of the record/replay
> log file. Adding an accessor instead of making variable global,
> prevents accidental modification of this variable by other modules.
> 
> Signed-off-by: Pavel Dovgalyuk <Pavel.Dovgalyuk@ispras.ru>
> Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  include/sysemu/replay.h |    2 ++
>  replay/replay.c         |    5 +++++
>  2 files changed, 7 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>


