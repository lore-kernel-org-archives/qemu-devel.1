Return-Path: <SRS0=Uy1J=BP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10BE3C433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2020 13:52:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF63A2075A
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2020 13:52:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HDxxOW0z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF63A2075A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51832 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3JqC-0003li-27
	for qemu-devel@archiver.kernel.org; Wed, 05 Aug 2020 09:52:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41744)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k3Jpd-0003IH-2o
 for qemu-devel@nongnu.org; Wed, 05 Aug 2020 09:51:49 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:38215
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k3Jpa-0005F5-Bd
 for qemu-devel@nongnu.org; Wed, 05 Aug 2020 09:51:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596635504;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Hux6OYwN5apcDoKpqBwnqJNQYxgp4CW0PxgLBuj5K54=;
 b=HDxxOW0zplDLGKQ/2v6D+kpfyL2RcMT16xv9dJTPwHWC7h/DfA1CGAWc3xfp5XXRgGP75I
 kdMWSM/I6Ie1WWagOtPOFou3/+OBR7geiTa/9JkOiUSFo8wU4BpCNZhaBB8DU/9V2DIQUx
 JwgPfdCz8sTbqofw53+QVgIyFB9VTQs=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-398-9tpT08qONHGjUmIsNvnWmg-1; Wed, 05 Aug 2020 09:51:43 -0400
X-MC-Unique: 9tpT08qONHGjUmIsNvnWmg-1
Received: by mail-wr1-f70.google.com with SMTP id r29so9287214wrr.10
 for <qemu-devel@nongnu.org>; Wed, 05 Aug 2020 06:51:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=Hux6OYwN5apcDoKpqBwnqJNQYxgp4CW0PxgLBuj5K54=;
 b=dje3dsqDRmF6G2LBdr4OaFlYwI5lqx1xfwn+pTqkos8Y4CdVoZSqCZX1QUQ82X/aa1
 mftCDKxuFV4Ll+mZwDWQD4RyKlYVnPGyj2ptds8UMZ/VpjT30G2AVQGhNp2zzMRre7zz
 /CisZw2yq31Jt1tdf7m048XKV9vIhJaObmdYT/TOsHMoQ+M+UkFBQ7xkXTntGjMAXrP2
 nwjfNx9hv1uuuH3TpcwhPiMpMkKJmqO2aOPk3jn8wcY9iABnefDcYXbrv+tyb6h2mg7k
 7Xtt9OurHXS7pp247jAG0Xnd2BtmnElyMSOnXN7BVAnj2owpMUIJv90MOlTcR56RBe7g
 wzxA==
X-Gm-Message-State: AOAM532Pd8CirdayF6BNP7xQtZFdiv59+yF8f/GBso4vk/RYil+UaYXv
 WJMp1hFwneMR3aINlfZzpVcdfSduGCcuWpHSeAx1bo5mFdbvAPr9OPksTxr219oWdcoMvQgSvNm
 7zAYJfy6q2rE3xlo=
X-Received: by 2002:a1c:e907:: with SMTP id q7mr3565262wmc.155.1596635501847; 
 Wed, 05 Aug 2020 06:51:41 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwJsKW3wUuVfehZMZA9l6frU9PKt3FCdgMG4Fdy/AFJCstKyLFLip1l75r48mrmwylmtPoSKw==
X-Received: by 2002:a1c:e907:: with SMTP id q7mr3565247wmc.155.1596635501651; 
 Wed, 05 Aug 2020 06:51:41 -0700 (PDT)
Received: from [192.168.1.36] (121.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.121])
 by smtp.gmail.com with ESMTPSA id z6sm3145511wml.41.2020.08.05.06.51.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Aug 2020 06:51:40 -0700 (PDT)
Subject: Re: [PATCH 2/3] block: add logging facility for long standing IO
 requests
To: "Denis V. Lunev" <den@openvz.org>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org
References: <20200805100824.16817-1-den@openvz.org>
 <20200805100824.16817-3-den@openvz.org>
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
Message-ID: <703a491d-2281-608d-b5e7-7b143c404111@redhat.com>
Date: Wed, 5 Aug 2020 15:51:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200805100824.16817-3-den@openvz.org>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/05 04:10:11
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
Cc: Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/5/20 12:08 PM, Denis V. Lunev wrote:
> There are severe delays with IO requests processing if QEMU is running in
> virtual machine or over software defined storage. Such delays potentially
> results in unpredictable guest behavior. For example, guests over IDE or
> SATA drive could remount filesystem read-only if write is performed
> longer than 10 seconds.
> 
> Such reports are very complex to process. Some good starting point for this
> seems quite reasonable. This patch provides one. It adds logging of such
> potentially dangerous long IO operations.
> 
> Signed-off-by: Denis V. Lunev <den@openvz.org>
> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> CC: Stefan Hajnoczi <stefanha@redhat.com>
> CC: Kevin Wolf <kwolf@redhat.com>
> CC: Max Reitz <mreitz@redhat.com>
> ---
>  block/accounting.c         | 59 +++++++++++++++++++++++++++++++++++++-
>  blockdev.c                 |  7 ++++-
>  include/block/accounting.h |  5 +++-
>  slirp                      |  2 +-
>  4 files changed, 69 insertions(+), 4 deletions(-)
> 
...

>  typedef struct BlockAcctCookie {
> @@ -101,7 +104,7 @@ typedef struct BlockAcctCookie {
>  
>  void block_acct_init(BlockAcctStats *stats);
>  void block_acct_setup(BlockAcctStats *stats, bool account_invalid,
> -                     bool account_failed);
> +                      bool account_failed, unsigned latency_log_threshold_ms);
>  void block_acct_cleanup(BlockAcctStats *stats);
>  void block_acct_add_interval(BlockAcctStats *stats, unsigned interval_length);
>  BlockAcctTimedStats *block_acct_interval_next(BlockAcctStats *stats,
> diff --git a/slirp b/slirp
> index ce94eba204..2faae0f778 160000
> --- a/slirp
> +++ b/slirp
> @@ -1 +1 @@
> -Subproject commit ce94eba2042d52a0ba3d9e252ebce86715e94275
> +Subproject commit 2faae0f778f818fadc873308f983289df697eb93

SLiRP change unrelated I presume...


