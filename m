Return-Path: <SRS0=6rdr=7Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEE42C433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 06:52:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 76E512077D
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 06:52:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iFNcRdlD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76E512077D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39428 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgNGa-0004V2-Oe
	for qemu-devel@archiver.kernel.org; Wed, 03 Jun 2020 02:52:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32940)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jgNFt-0003zl-VD
 for qemu-devel@nongnu.org; Wed, 03 Jun 2020 02:52:05 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:44030
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jgNFs-0002AV-Rw
 for qemu-devel@nongnu.org; Wed, 03 Jun 2020 02:52:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591167123;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Fst5dhvTrn6XZZ/VCzfPPMEO7a0ttJGYJX13bpNPh2A=;
 b=iFNcRdlDNK5l7v56VECzw8cQyJcezuI75/kiHggn+nwgptDAiTPVmjijcr0iJrXn7Z/HS6
 0AyIRMjn5EL4FTuEwTLARHDnGzx8uCO7cBjNzFAlqm429AK1yVmhI2Fc1RMjsvWDBd1rNP
 coyg5GNJJo96OpjJmT5rF2X41vRna8M=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-366-Rb3D9_FNO6W0S_EDoDsdgA-1; Wed, 03 Jun 2020 02:52:00 -0400
X-MC-Unique: Rb3D9_FNO6W0S_EDoDsdgA-1
Received: by mail-wr1-f72.google.com with SMTP id l1so686750wrc.8
 for <qemu-devel@nongnu.org>; Tue, 02 Jun 2020 23:52:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=Fst5dhvTrn6XZZ/VCzfPPMEO7a0ttJGYJX13bpNPh2A=;
 b=XDLpFLZLydDpMHbzMODNU7yt5/tpQ8WiunGjTXS8OzykzjvFAZP2HAlUBs6JTan64t
 WMD+uh0rjS52RB2C6NkC5YYupvWIcSlKEt286kfDc4NFnYaSjVLi8O9NIX19vFX7YJsi
 xAsxxmdzVSiSrFO6BFpByRSptsOIlhMFRiAyP/Pk5xGgiQWfzSbmL8iaeuDgvJmcPckc
 bCJfMIuSa70rbjm71B2nhnSRNnrcx+lqQdI0LVk0Xqxw7RLYDJHVf5ZpRVAsQ9uPO7QE
 9gA0y+erwjQJt5rQJgj98HVgU0HKoILoHdPOKII8u1rbIX0Qyqh6lwSuuHoDvZJUn0pz
 B0pQ==
X-Gm-Message-State: AOAM530bW7fzZAjRMTvuOj+algsWo7ql1k9Z/LFi37KwpXQolOkWMUQk
 xsknt2yJ17kuuJQLNLqvAZrmHMqFQhhNY3FQ4zulOd0iYUleYkYJx5jgl3CmHsm2ckhx6yJd1QX
 K/hWo0d/evR8C/sg=
X-Received: by 2002:a05:600c:2153:: with SMTP id
 v19mr7026014wml.47.1591167119575; 
 Tue, 02 Jun 2020 23:51:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJySKwzyUKVxnoHMH7M/i4B80R9ATGvJ+ffHsq7rGFihSAtl/b4O2caSWme+s+bNJoREz8hbdg==
X-Received: by 2002:a05:600c:2153:: with SMTP id
 v19mr7025994wml.47.1591167119325; 
 Tue, 02 Jun 2020 23:51:59 -0700 (PDT)
Received: from [192.168.1.43] (181.red-88-10-103.dynamicip.rima-tde.net.
 [88.10.103.181])
 by smtp.gmail.com with ESMTPSA id d24sm1410455wmb.45.2020.06.02.23.51.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 02 Jun 2020 23:51:58 -0700 (PDT)
Subject: Re: [PATCH] qom-hmp-cmds: fix a memleak in hmp_qom_get
To: Pan Nengyuan <pannengyuan@huawei.com>, pbonzini@redhat.com,
 berrange@redhat.com, ehabkost@redhat.com,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
References: <20200603070338.7922-1-pannengyuan@huawei.com>
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
Message-ID: <de3c8dc7-b039-71d7-6c33-5794a7ed9eb8@redhat.com>
Date: Wed, 3 Jun 2020 08:51:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200603070338.7922-1-pannengyuan@huawei.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/03 01:04:35
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: zhang.zhanghailiang@huawei.com, qemu-devel@nongnu.org,
 euler.robot@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Pan,

On 6/3/20 9:03 AM, Pan Nengyuan wrote:
> 'obj' forgot to free at the end of hmp_qom_get(). Fix that.
> 
> The leak stack:
> Direct leak of 40 byte(s) in 1 object(s) allocated from:
>     #0 0x7f4e3a779ae8 in __interceptor_malloc (/lib64/libasan.so.5+0xefae8)
>     #1 0x7f4e398f91d5 in g_malloc (/lib64/libglib-2.0.so.0+0x531d5)
>     #2 0x55c9fd9a3999 in qstring_from_substr /build/qemu/src/qobject/qstring.c:45
>     #3 0x55c9fd894bd3 in qobject_output_type_str /build/qemu/src/qapi/qobject-output-visitor.c:175
>     #4 0x55c9fd894bd3 in qobject_output_type_str /build/qemu/src/qapi/qobject-output-visitor.c:168
>     #5 0x55c9fd88b34d in visit_type_str /build/qemu/src/qapi/qapi-visit-core.c:308
>     #6 0x55c9fd59aa6b in property_get_str /build/qemu/src/qom/object.c:2064
>     #7 0x55c9fd5adb8a in object_property_get_qobject /build/qemu/src/qom/qom-qobject.c:38
>     #8 0x55c9fd4a029d in hmp_qom_get /build/qemu/src/qom/qom-hmp-cmds.c:66
> 
> Fixes: 89cf4fe34f4

When you fix a bug in a specific commit, please Cc the commit author and
the reviewers, so they have a chance to 1/ review your fix and 2/ learn
from their mistake.

> Reported-by: Euler Robot <euler.robot@huawei.com>
> Signed-off-by: Pan Nengyuan <pannengyuan@huawei.com>
> ---
>  qom/qom-hmp-cmds.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/qom/qom-hmp-cmds.c b/qom/qom-hmp-cmds.c
> index f704b6949a..3d2a23292d 100644
> --- a/qom/qom-hmp-cmds.c
> +++ b/qom/qom-hmp-cmds.c
> @@ -71,6 +71,7 @@ void hmp_qom_get(Monitor *mon, const QDict *qdict)
>          qobject_unref(str);
>      }
>  
> +    qobject_unref(obj);

The object_resolve_path() documentation is not clear about that...
Can we get the documentation clarified?

>      hmp_handle_error(mon, err);
>  }
>  
> 


