Return-Path: <SRS0=ZkAM=AH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FDF5C433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 20:40:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2FBCA204EC
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 20:40:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DMgqV3aj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FBCA204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54602 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jov9D-0005t8-H6
	for qemu-devel@archiver.kernel.org; Fri, 26 Jun 2020 16:40:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33108)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jov8b-0005N9-Hf
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 16:39:53 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:42632
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jov8Z-0005Gb-Lc
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 16:39:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593203990;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=dP0LPqYzlMZsd31BMJlYdRUVInYnXXsz85jg1tfaPu4=;
 b=DMgqV3aj7OZQnM3F8h/AE4G6P2c5mA6nLoGxJdeotBuNZA7sCrpwf73S/SC0ehiHxiWuHp
 hTQeOFZMyZAYSuY/rn9oV4PUbjogps4+W+ny/WbEqah9tcIBFtsiJp/AZUI1bbWVUZGcjc
 lDQgFCSwlI5+QuMHyobNOUWZk2bD3Kg=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-117-E1oAu6WlNhacV_3eXC-Rvw-1; Fri, 26 Jun 2020 16:39:49 -0400
X-MC-Unique: E1oAu6WlNhacV_3eXC-Rvw-1
Received: by mail-wr1-f69.google.com with SMTP id c18so4621336wrp.15
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2020 13:39:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=dP0LPqYzlMZsd31BMJlYdRUVInYnXXsz85jg1tfaPu4=;
 b=YCskOCdugb9LUrsOeudBsVM5hMSS/Zyb2YIPRmqA97hJDCsfYrTSl4+qWMHJAGx4Fj
 HkmAggiZSkag85WljYhaOPZzZZQQEeFj6v99n9LIdo4u20Eqdo/30t8r5R27cmajZKBc
 D+kBNdKlKfjt0UAqYmJO5Z0uZLeEtZT19tk7DUbNSr8Cs6Wg+XJRYNhgjOht86+utf8H
 w23TYCkpAav+VEFAtg9AGsDTFb07ctOPoRfWpXR7/8s6FSny6Ap3qFlcsCDVKfJcoJ93
 HG/M2nkM2ZsysyW2DoEQicZpidZT92y7C4BnNp9zvRyhZdLkNhgIY+K406kYmwS8YOd+
 UpdA==
X-Gm-Message-State: AOAM533B2ja4AViR5OZUmTlEvuu0yTm6SmE7sVUuDZe0dzCMHWj2B8yj
 RuAfv/gQJlB78u68SHy5cNPZBdW5WUUh+TWpZ7sT4AiZh1IjVsDVEJ9oLpAfgurXkbvYrgjj4Oz
 mdPpoL9HEIh3lCL4=
X-Received: by 2002:a1c:5603:: with SMTP id k3mr5363763wmb.116.1593203987201; 
 Fri, 26 Jun 2020 13:39:47 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx8wGl36eS/AL+xm49GzkxZen/m3Ld3mq2C0ZPVnzO2Ig0MVdp73VOgCf45/a0m2QzCCt2vgQ==
X-Received: by 2002:a1c:5603:: with SMTP id k3mr5363657wmb.116.1593203985159; 
 Fri, 26 Jun 2020 13:39:45 -0700 (PDT)
Received: from [192.168.1.37] (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id x7sm39414593wrr.72.2020.06.26.13.39.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 26 Jun 2020 13:39:44 -0700 (PDT)
Subject: Re: [PATCH v2 1/2] tests/qht-bench: Adjust testing rate by -1
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20200626200950.1015121-1-richard.henderson@linaro.org>
 <20200626200950.1015121-2-richard.henderson@linaro.org>
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
Message-ID: <9627ba2e-7ea0-432e-6005-8534156049a9@redhat.com>
Date: Fri, 26 Jun 2020 22:39:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200626200950.1015121-2-richard.henderson@linaro.org>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/26 03:23:21
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: cota@braap.org, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/26/20 10:09 PM, Richard Henderson wrote:
> Since the seed must be non-zero, subtracting 1 means puts the
> rate in 0..UINT64_MAX-1, which allows the 0 and UINT64_MAX
> thresholds to corrspond to 0% (never) and 100% (always).
> 
> Suggested-by: Emilio G. Cota <cota@braap.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  tests/qht-bench.c | 22 +++++++++++++++-------
>  1 file changed, 15 insertions(+), 7 deletions(-)
> 
> diff --git a/tests/qht-bench.c b/tests/qht-bench.c
> index eb88a90137..ad885d89d0 100644
> --- a/tests/qht-bench.c
> +++ b/tests/qht-bench.c
> @@ -25,7 +25,13 @@ struct thread_stats {
>  struct thread_info {
>      void (*func)(struct thread_info *);
>      struct thread_stats stats;
> -    uint64_t r;
> +    /*
> +     * Seed is in the range [1..UINT64_MAX], because the RNG requires
> +     * a non-zero seed.  To use, subtract 1 and compare against the
> +     * threshold with </>=.  This lets threshold = 0 never match (0% hit),
> +     * and threshold = UINT64_MAX always match (100% hit).
> +     */
> +    uint64_t seed;
>      bool write_op; /* writes alternate between insertions and removals */
>      bool resize_down;
>  } QEMU_ALIGNED(64); /* avoid false sharing among threads */
> @@ -131,8 +137,9 @@ static uint64_t xorshift64star(uint64_t x)
>  static void do_rz(struct thread_info *info)
>  {
>      struct thread_stats *stats = &info->stats;
> +    uint64_t r = info->seed - 1;
>  
> -    if (info->r < resize_threshold) {
> +    if (r < resize_threshold) {
>          size_t size = info->resize_down ? resize_min : resize_max;
>          bool resized;
>  
> @@ -151,13 +158,14 @@ static void do_rz(struct thread_info *info)
>  static void do_rw(struct thread_info *info)
>  {
>      struct thread_stats *stats = &info->stats;
> +    uint64_t r = info->seed - 1;
>      uint32_t hash;
>      long *p;
>  
> -    if (info->r >= update_threshold) {
> +    if (r >= update_threshold) {
>          bool read;
>  
> -        p = &keys[info->r & (lookup_range - 1)];
> +        p = &keys[r & (lookup_range - 1)];
>          hash = hfunc(*p);
>          read = qht_lookup(&ht, p, hash);
>          if (read) {
> @@ -166,7 +174,7 @@ static void do_rw(struct thread_info *info)
>              stats->not_rd++;
>          }
>      } else {
> -        p = &keys[info->r & (update_range - 1)];
> +        p = &keys[r & (update_range - 1)];
>          hash = hfunc(*p);
>          if (info->write_op) {
>              bool written = false;
> @@ -208,7 +216,7 @@ static void *thread_func(void *p)
>  
>      rcu_read_lock();
>      while (!atomic_read(&test_stop)) {
> -        info->r = xorshift64star(info->r);
> +        info->seed = xorshift64star(info->seed);
>          info->func(info);
>      }
>      rcu_read_unlock();
> @@ -221,7 +229,7 @@ static void *thread_func(void *p)
>  static void prepare_thread_info(struct thread_info *info, int i)
>  {
>      /* seed for the RNG; each thread should have a different one */
> -    info->r = (i + 1) ^ time(NULL);
> +    info->seed = (i + 1) ^ time(NULL);
>      /* the first update will be a write */
>      info->write_op = true;
>      /* the first resize will be down */
> 

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>


