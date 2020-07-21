Return-Path: <SRS0=zL9l=BA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF35CC433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2020 14:53:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C38820717
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2020 14:53:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CJhlKplZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C38820717
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60716 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jxteS-00007B-UH
	for qemu-devel@archiver.kernel.org; Tue, 21 Jul 2020 10:53:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43740)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jxtdl-00085u-1y
 for qemu-devel@nongnu.org; Tue, 21 Jul 2020 10:53:09 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:51368
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jxtdi-0008K3-0C
 for qemu-devel@nongnu.org; Tue, 21 Jul 2020 10:53:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595343184;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=2cF6XLa/gpJOdY+NohUIStn2j4w7QpysyTzh/tSvGC4=;
 b=CJhlKplZI0gp78V0flMskd0t7fZPiCobWjOT/zPTro4c99kI2D3WaeA9A5mW5C+Su2Acs1
 4L4J+s8HBc35m/d4cKN6rsyHBCEomgeRskS59mxR2tXxF16nMxKxJn317x613O0+l5Ya5j
 uLVBhJ/Whll/u172wxHbjhhaF3F9trs=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-32-mIn9VQNPNlCPSfaoWllWdQ-1; Tue, 21 Jul 2020 10:53:02 -0400
X-MC-Unique: mIn9VQNPNlCPSfaoWllWdQ-1
Received: by mail-wr1-f70.google.com with SMTP id e12so2085256wra.13
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2020 07:53:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=2cF6XLa/gpJOdY+NohUIStn2j4w7QpysyTzh/tSvGC4=;
 b=OhVVggyVY7T014bs2nBZm1Gr1PJTOaJj+ipFG7u2rHV102k/KB6XroylCpVUU4E1aK
 GZVc8VzM8S4Ysgd1asOqXOwmMRNHGDuhuxpEKong01TirneoHSyyUAUjJ/5k5Y9I1yk1
 9cUkS/ql3TmzhsQdi8KszVm+Vg+ZUQoJwaiIYAygquZcul9Q8X7ntARJfBExd48vS1xl
 8XFuDqh3EH0ZnbaQZ75DcbShbndZowtfvFZigzefKWrZEvq84hgGbceH40SKddZYdtBX
 rg6HGEOHvbZxmw/ag/+SazoLP7VVbU5tP2AJjO+1m52q2aAamkvlXktA2L9zezjFZrsb
 62IQ==
X-Gm-Message-State: AOAM531kcp4uZqON4FjaUPSVf93dcisFcchc9+6x+uHgMi+6mYsL27XJ
 SKlMJ5ZmrAdKDz9GEA1PFF5eIRAraT/ssjUyCTWCcBlAfB6alOIWlverRl4l4cwbbCJWkbmrjnO
 1Gz6n9EYLE8ZPXHc=
X-Received: by 2002:a1c:bc02:: with SMTP id m2mr3823943wmf.132.1595343178053; 
 Tue, 21 Jul 2020 07:52:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx/5RGGgGVhrZ0X1xovzrZKHnih2Mg2Qa97/OlO32t8z0xhrqR3UZn/pj2qG0D7Uq31WOo4tg==
X-Received: by 2002:a1c:bc02:: with SMTP id m2mr3823928wmf.132.1595343177866; 
 Tue, 21 Jul 2020 07:52:57 -0700 (PDT)
Received: from [192.168.1.36] (138.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id 62sm22024412wrq.31.2020.07.21.07.52.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Jul 2020 07:52:57 -0700 (PDT)
Subject: Re: [PATCH v2 0/2] hw/nvram/fw_cfg: Let fw_cfg_add_from_generator()
 return boolean value
To: qemu-devel@nongnu.org
References: <20200721131911.27380-1-philmd@redhat.com>
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
Message-ID: <fc93df96-aa57-9981-d542-33514925b2e4@redhat.com>
Date: Tue, 21 Jul 2020 16:52:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200721131911.27380-1-philmd@redhat.com>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/21 10:17:05
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Laszlo Ersek <lersek@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/21/20 3:19 PM, Philippe Mathieu-Daudé wrote:
> Since v1:
> - Addressed Markus review comments
> - Added patch to clarify fw_cfg_add_from_generator (Markus)
> 
> Philippe Mathieu-Daudé (2):
>   hw/nvram/fw_cfg: Simplify fw_cfg_add_from_generator() error
>     propagation
>   hw/nvram/fw_cfg: Let fw_cfg_add_from_generator() return boolean value
> 
>  include/hw/nvram/fw_cfg.h |  8 ++++++--
>  hw/nvram/fw_cfg.c         | 13 +++++++------
>  softmmu/vl.c              |  6 +-----
>  3 files changed, 14 insertions(+), 13 deletions(-)
> 

Thanks for the reviews, patches applied to fw_cfg-next tree.

Phil.


