Return-Path: <SRS0=37Ja=DO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F917C4363C
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 05:04:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4899F208C7
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 05:04:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FCP8+/Gc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4899F208C7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46248 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQ1dD-0000Cx-36
	for qemu-devel@archiver.kernel.org; Wed, 07 Oct 2020 01:04:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37440)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kQ1Rx-0007Wy-GO
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 00:53:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:59594)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kQ1Rs-0004rf-FE
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 00:53:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602046387;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=cSrx7M7kjcVriE4aqLlHuPsFDUQ2cqFj9XAV5+1KWXM=;
 b=FCP8+/GcWZCPVrJ9K/y+4zBwv44cg5lrcT7wSy04E+lNT3hiXPDVsT+Wb/9duX2lXPwqOd
 0XqWEKH9bHJXlknBA9pn31apxopUP/xz4Rtb5ymglltsz35twaEB15yEu+0/yxKGelIRk3
 2tDIVil+uKpJW7i/fywEMMm3Yj5oowc=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-460-9pRT_74iNWW6hiMlJJg01w-1; Wed, 07 Oct 2020 00:53:05 -0400
X-MC-Unique: 9pRT_74iNWW6hiMlJJg01w-1
Received: by mail-wr1-f72.google.com with SMTP id x16so109527wrg.7
 for <qemu-devel@nongnu.org>; Tue, 06 Oct 2020 21:53:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=cSrx7M7kjcVriE4aqLlHuPsFDUQ2cqFj9XAV5+1KWXM=;
 b=RSlbolaffZ+vcNDCiBMZdU+n+Bw75DB/Bp3cALDCXve0D4jAf+pDTEskd6fSUUabq2
 otxBo8SKVcs+9aH7EsJPPZNv2maRSN8B+tYDHfbstuOgRWv588Dqwe+1sNJzYXgRkXoU
 5TnpFRHV11XMR0wjSs4W1PVW3IX8Ki2jq4/Zo1kRprZipOP+SNaMkK9JlrWuA3GZawy5
 MinocHyX4VnHbENVnOJ8r6IMTGeZ0wRKzqzC2ok3qcjO67etZEJiSP9iZgcQbim18/lQ
 5XSdY2VxiesVxGE2Jtx9banEpmtwyD+UE8YIwD9KaqK6Z9cINoxjeWCQWt/MvfcuQkK+
 rYyA==
X-Gm-Message-State: AOAM532LiY3t4COInqfLV2m8qqcyJngl0gVl+gJr3fl59jLDCqkgZhIe
 ZD/shf7RzntcylxUv1MJx8lNkNgjY+VoABGPWNC5RPnBEbmn89xIXGjzlRdOL4jKrbVIIcOBj18
 VaZJz1TBTnL7Do4g=
X-Received: by 2002:a1c:2187:: with SMTP id h129mr1206570wmh.51.1602046384391; 
 Tue, 06 Oct 2020 21:53:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwv3KJo9uT1anedURfFsHU+HmNrwWhMaykbr6tg3NRHH2qbq1O4sVW0+o+fzP1E+CzLBFd45w==
X-Received: by 2002:a1c:2187:: with SMTP id h129mr1206550wmh.51.1602046384147; 
 Tue, 06 Oct 2020 21:53:04 -0700 (PDT)
Received: from [192.168.1.36] (106.red-83-59-162.dynamicip.rima-tde.net.
 [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id a10sm928702wmb.23.2020.10.06.21.53.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 06 Oct 2020 21:53:03 -0700 (PDT)
Subject: Re: [PATCH 01/20] python/qemu: use isort to lay out imports
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
References: <20201006235817.3280413-1-jsnow@redhat.com>
 <20201006235817.3280413-2-jsnow@redhat.com>
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
Message-ID: <44747cf7-cdc7-02a7-f375-8360de40c71f@redhat.com>
Date: Wed, 7 Oct 2020 06:53:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20201006235817.3280413-2-jsnow@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/07 00:44:56
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.733,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/7/20 1:57 AM, John Snow wrote:
> Borrowed from the QAPI cleanup series, use the same configuration to
> standardize the way we write and sort imports.
> 
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  python/qemu/.isort.cfg        |  7 +++++++
>  python/qemu/accel.py          |  1 +
>  python/qemu/console_socket.py |  2 +-
>  python/qemu/machine.py        |  8 ++++----
>  python/qemu/qmp.py            | 10 +++++-----
>  python/qemu/qtest.py          |  2 +-
>  6 files changed, 19 insertions(+), 11 deletions(-)
>  create mode 100644 python/qemu/.isort.cfg

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>


