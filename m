Return-Path: <SRS0=M6H1=DI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D5E4C4727C
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 13:31:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EDA0F20759
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 13:31:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hoKFhawm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDA0F20759
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48248 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNygX-0002iX-V7
	for qemu-devel@archiver.kernel.org; Thu, 01 Oct 2020 09:31:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49856)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kNyfD-00029R-HG
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 09:30:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:46442)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kNyf6-0000Q6-6J
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 09:30:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601559019;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=gdT3FUoikGG2sOOba69gZXX1f9qeRVeMmz2u+mFnKeQ=;
 b=hoKFhawmXnf+BLTnZc+YaisTH8AvTm2AydpGMaDRkVebITIc86Tu/2l5elZBBza7dt1plP
 eu4q9GnGxd1kaEzgdO1z4TNv3yve2diKub2YTx2xlzRCNGZUTaEM6Q6njJHfEZFsJYfKUj
 itLRHdjGfg53Ky/lsZdG+Ya+Uf4XLMM=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-167-HUOS4FkrMiyAZOR4Qoug_Q-1; Thu, 01 Oct 2020 09:30:16 -0400
X-MC-Unique: HUOS4FkrMiyAZOR4Qoug_Q-1
Received: by mail-wr1-f71.google.com with SMTP id s8so2037448wrb.15
 for <qemu-devel@nongnu.org>; Thu, 01 Oct 2020 06:30:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=gdT3FUoikGG2sOOba69gZXX1f9qeRVeMmz2u+mFnKeQ=;
 b=hIqeod4Ziq+29C3USX+U8qQm6cC7YHbhZzpuNbjnignboPsl0jI7CO5xolCpi6ohpi
 TmZbOJDOxx3An1yxnq/NBASu19PJfM2rAaX5HQOu6sQc7E+BxM3PuQ4i1/v+mAPkNBQV
 jsm2S2uOhCHXsNmq6zwIPWkSps5Sc97P/Rwo60uGH4fBMdTPVkJg39ZW3mJF1KZU6EAc
 ItgEtmBBvkicTnjI4sEJNpOJkSIPntBlIxJMW11YDiCrG9UGgQ+lY1FsokHzUN6lSLY7
 2YyvbYkmIKPgdnjXaI4EucnphZAhwEESFthhFB5uNrYDs/+oN/SKKVlgh7/8G9GIrgYR
 3gkA==
X-Gm-Message-State: AOAM530Uswn1lRR7wsBNxUstDQ9L6+2AZeDEhH5ZKdV/UOrYkD+wIXrW
 6jU0eSDikqxiudEb0TEwbkG6CtHPD551O06Fu3VPOVp8uVzaXwcmQ7d1PvwX8EaO933qpPCwG3s
 gyev12duaq6X8XDo=
X-Received: by 2002:adf:d4c7:: with SMTP id w7mr9261091wrk.263.1601559014506; 
 Thu, 01 Oct 2020 06:30:14 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxH0lb7XE/pk8HYP/zUYLPO2sOzLHe4SSvTuo557BcPTBpFzj4EaLx+rDPafL28TJF3eMDt1A==
X-Received: by 2002:adf:d4c7:: with SMTP id w7mr9261063wrk.263.1601559014269; 
 Thu, 01 Oct 2020 06:30:14 -0700 (PDT)
Received: from [192.168.1.36] (74.red-83-53-161.dynamicip.rima-tde.net.
 [83.53.161.74])
 by smtp.gmail.com with ESMTPSA id n2sm9322240wma.29.2020.10.01.06.30.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 Oct 2020 06:30:13 -0700 (PDT)
Subject: Re: [PATCH] block/export: fix QAPI doc indentation style violation
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
References: <20201001131439.386431-1-stefanha@redhat.com>
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
Message-ID: <fd9dbaec-11e9-95bf-cd56-fb688bca3336@redhat.com>
Date: Thu, 1 Oct 2020 15:30:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20201001131439.386431-1-stefanha@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/01 04:25:37
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.26, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/1/20 3:14 PM, Stefan Hajnoczi wrote:
> Since commit a69a6d4b4d4fae2e3d2506241e22a78ff1732283
> ("scripts/qapi/parser.py: improve doc comment indent handling") the QAPI
> generator emits an error when unindented text follows "Returns:".
> 
> Fix block-export.json by moving the comment to make the QAPI generator
> happy.
> 
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
> Based-on: git://repo.or.cz/qemu/kevin.git block
> 
>  qapi/block-export.json | 24 ++++++++++++------------
>  1 file changed, 12 insertions(+), 12 deletions(-)
> 
> diff --git a/qapi/block-export.json b/qapi/block-export.json
> index 87ac5117cd..a793e34af9 100644
> --- a/qapi/block-export.json
> +++ b/qapi/block-export.json
> @@ -39,21 +39,21 @@
>  # server will present them as named exports; for example, another
>  # QEMU instance could refer to them as "nbd:HOST:PORT:exportname=NAME".
>  #
> -# @addr: Address on which to listen.
> -# @tls-creds: ID of the TLS credentials object (since 2.6).
> -# @tls-authz: ID of the QAuthZ authorization object used to validate
> -#             the client's x509 distinguished name. This object is
> -#             is only resolved at time of use, so can be deleted and
> -#             recreated on the fly while the NBD server is active.
> -#             If missing, it will default to denying access (since 4.0).
> -# @max-connections: The maximum number of connections to allow at the same
> -#                   time, 0 for unlimited. (since 5.2; default: 0)
> -#
> -# Returns: error if the server is already running.
> -#
>  # Keep this type consistent with the NbdServerOptions type. The only intended
>  # difference is using SocketAddressLegacy instead of SocketAddress.
>  #
> +# @addr: Address on which to listen.
> +# @tls-creds: ID of the TLS credentials object (since 2.6).
> +# @tls-authz: ID of the QAuthZ authorization object used to validate
> +#             the client's x509 distinguished name. This object is
> +#             is only resolved at time of use, so can be deleted and
> +#             recreated on the fly while the NBD server is active.
> +#             If missing, it will default to denying access (since 4.0).
> +# @max-connections: The maximum number of connections to allow at the same
> +#                   time, 0 for unlimited. (since 5.2; default: 0)
> +#
> +# Returns: error if the server is already running.
> +#
>  # Since: 1.3.0
>  ##
>  { 'command': 'nbd-server-start',
> 

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>


