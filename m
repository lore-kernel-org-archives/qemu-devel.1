Return-Path: <SRS0=peXq=25=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DC06C282DD
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 15:19:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6001220692
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 15:19:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6001220692
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45592 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipD7R-0006M6-9q
	for qemu-devel@archiver.kernel.org; Wed, 08 Jan 2020 10:19:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52651)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1ipD21-0003QS-J2
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 10:14:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1ipD20-0001LB-E9
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 10:14:01 -0500
Received: from mout.kundenserver.de ([212.227.17.24]:40667)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1ipD20-0001KA-5O
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 10:14:00 -0500
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue109 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1MuDPf-1jgdUX4BeH-00uX7c; Wed, 08 Jan 2020 16:13:49 +0100
Subject: Re: [PATCH] vl: fix memory leak in configure_accelerators
To: kuhn.chenqun@huawei.com, qemu-devel@nongnu.org, pbonzini@redhat.com
References: <20200108114207.58084-1-kuhn.chenqun@huawei.com>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <ae9bae62-6c59-813a-187b-e7b670294399@vivier.eu>
Date: Wed, 8 Jan 2020 16:13:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20200108114207.58084-1-kuhn.chenqun@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:dQd7kD+AoiiV0hqL/Dt9qIHtyxrSKGGjGjk7UBwP/mzAxnaW9DM
 UzLaSWJhWGc/j8RkSR08IL4RYZOhsuGTqel50ikDL0yXvcny6bEC7TwW0ThY1jKTKA6ENra
 uY4tibIMYaMWMDPAQTgkv3WTFlECE8WEmLSLWxCf8981vhhN4mK53TGnYTwASBBEok9xvJa
 RUT+kRwZTkqoONV/8++Hw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:qp78Gpi3bnU=:x9lzMFa42Tx62S0CGaNvrz
 0bEsjUBe3anItG70335GDczyvY9rN9bx1VVtPVWqzNtVPNKzLvqo079L/v8qJzyBXBx5RNARI
 g6JKpSWAiuXi/u0coAMA36xihwvHcE3QqtqnJ050VDVpBFC7q+4UkH9aHBlNXbTG9QyHCJL79
 8Sc9QD84fVz4a4tRKt/fmi3NguOS4YFy+YVdMV2qBiqgS4zsnu5sSDKkFSexP9jFGs8NFpAQ5
 jPD487ZjYQsz62xyP90ghgAKFqMeBcalhasEaakznj46cByRuraB0mykGxShR9KCTdnrWE3xq
 90eos7jwCTxB53FspCXKoWZ+cMhgWZ/x68PPYfUl3coNM9BxcjJWJpGsatmkjiMbRS3pj9i48
 4nvntOFJT5B36xu+pWjhOW638fYXdz2gl0Shfo07KWNFWcggAhqeCEXhJYD1Ra13bvsfdmwy4
 4dwLBZnSAK7thJ3cTNyp0QJftBs6jbc0QWFJGNdNcp39bj5vfIpbOtsMf9e0eBvKonIdP2aLl
 Ar2q4RkO8KQsR8ahR38y5H783W9gD78LV3PMZuXjVf2STPpGpqdZzB2QfO32YFzC4St6SYLXg
 sf9onsy6DhYwsiT1c0U8S6FkZkrEDGnaY5kdrqXhw+R5TgAyQQDd9kp4jFr25NLfIiYvMa3YM
 +t45snDIVaeZRGFFwC1kv4Md4/EErRR0QyLTMmuDqazAEZLNKS+9LuHl7CvK+4haFpdZUsuIw
 g9Yf5cGyoWzHMdRSGS4QYeIXC0BOnCYJxpjvIXyqu0M1z4Uhoa670TEI1y+QU7oJfNlOL2mO7
 H6TmzwAlaOwlV0Kw/iJmoav399lSOeezG61IBgvDNK1UB7Bpoi/wCVe9rlrz68g3+LVxuLxhx
 dgP82RwkTPFiTkxguinA==
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 212.227.17.24
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
Cc: liyiting@huawei.com, pannengyuan@huawei.com, zhang.zhanghailiang@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 08/01/2020 à 12:42, kuhn.chenqun@huawei.com a écrit :
> From: Chen Qun <kuhn.chenqun@huawei.com>
> 
> The accel_list forgot to free, the asan output:
> 
> Direct leak of 16 byte(s) in 1 object(s) allocated from:
>     #0 0xffff919331cb in __interceptor_malloc (/lib64/libasan.so.4+0xd31cb)
>     #1 0xffff913f7163 in g_malloc (/lib64/libglib-2.0.so.0+0x57163)
>     #2 0xffff91413d9b in g_strsplit (/lib64/libglib-2.0.so.0+0x73d9b)
>     #3 0xaaab42fb58e7 in configure_accelerators /qemu/vl.c:2777
>     #4 0xaaab42fb58e7 in main /qemu/vl.c:4121
>     #5 0xffff8f9b0b9f in __libc_start_main (/lib64/libc.so.6+0x20b9f)
>     #6 0xaaab42fc1dab  (/qemu/build/aarch64-softmmu/qemu-system-aarch64+0x8b1dab)
> 
> Indirect leak of 4 byte(s) in 1 object(s) allocated from:
>     #0 0xffff919331cb in __interceptor_malloc (/lib64/libasan.so.4+0xd31cb)
>     #1 0xffff913f7163 in g_malloc (/lib64/libglib-2.0.so.0+0x57163)
>     #2 0xffff9141243b in g_strdup (/lib64/libglib-2.0.so.0+0x7243b)
>     #3 0xffff91413e6f in g_strsplit (/lib64/libglib-2.0.so.0+0x73e6f)
>     #4 0xaaab42fb58e7 in configure_accelerators /qemu/vl.c:2777
>     #5 0xaaab42fb58e7 in main /qemu/vl.c:4121
>     #6 0xffff8f9b0b9f in __libc_start_main (/lib64/libc.so.6+0x20b9f)
>     #7 0xaaab42fc1dab  (/qemu/build/aarch64-softmmu/qemu-system-aarch64+0x8b1dab)
> 
> Reported-by: Euler Robot <euler.robot@huawei.com>
> Signed-off-by: Chen Qun <kuhn.chenqun@huawei.com>
> ---
>  vl.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/vl.c b/vl.c
> index 86474a55c9..035a24e52b 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -2788,6 +2788,7 @@ static void configure_accelerators(const char *progname)
>                  error_report("invalid accelerator %s", *tmp);
>              }
>          }
> +        g_strfreev(accel_list);
>      } else {
>          if (accel != NULL) {
>              error_report("The -accel and \"-machine accel=\" options are incompatible");
> 

Applied to my trivial-patches branch.

Thanks,
Laurent

