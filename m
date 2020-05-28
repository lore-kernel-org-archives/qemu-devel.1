Return-Path: <SRS0=D+kF=7K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44888C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 09:35:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 174F42074B
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 09:35:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 174F42074B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53098 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jeEwV-0001gt-A5
	for qemu-devel@archiver.kernel.org; Thu, 28 May 2020 05:35:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36684)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1jeEvf-0001Gr-7h
 for qemu-devel@nongnu.org; Thu, 28 May 2020 05:34:23 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:35289)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1jeEvc-0001cy-Cb
 for qemu-devel@nongnu.org; Thu, 28 May 2020 05:34:22 -0400
Received: from [192.168.100.1] ([82.252.135.106]) by mrelayeu.kundenserver.de
 (mreue009 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1Mn2eN-1jBoH01gX9-00k9SI; Thu, 28 May 2020 11:34:17 +0200
Subject: Re: [PATCH] linux-user/mmap.c: fix integer underflow in target_mremap
To: Jonathan Marler <johnnymarler@gmail.com>, qemu-devel@nongnu.org
References: <20200502161225.14346-1-johnnymarler@gmail.com>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <e1dd114f-101a-4024-df35-1a0e8bcd0ea2@vivier.eu>
Date: Thu, 28 May 2020 11:34:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200502161225.14346-1-johnnymarler@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:kMj23APA2PWy8O1XZDg4Yzm7146isw8bPhML6WBG6ljBPKIZXLL
 PIc8hexNfTag7yrKpr3WoCckdD1tSLb5DthwK+vAY1pcOOOwXINjrXUzx9wjWbeTbWj1Lu3
 rNoSUOIr119lk9Ctikd5KxSBPRRDoIRY0wTZgMXJwLdyu8Ed6XZVijaApWWIdPz8a6+ICqA
 bLDkHqg8yLJ74B5fdFv4Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:pV9DyJ+L5Xc=:ZdFkahCcI/tatrPYuKLp1W
 hL3Drd0dxuIdiYvD0FraH3VGV1CXNfHQkeduFoTd2V23FVilOez0dWYI818BFj8I/gKvG9y3F
 KQyAjNTcSwHgktUjOJJQcFHd8g+0rnB+pPIn3Iy/bmTuaP0OGgN5Fi6LFlHwuTEoBziNO5gRJ
 shqKY7cvexDg6Z3zlKEvlsQE/s0qZVZWI+sHACGce4mlZP7bxFe/27rRoq3W0511YDGwLha63
 3fJFweNQAw01su3ujyWEg/gzvdA2AxN/Moc6fS9pqv2O07PMHgvVwKEQY9EmVwyzoTdXR6hoT
 0UmwXU0W/8QELSOsW/BIp186eh0zvBTvYqOYTy1UkIUXfbXDrvyjgAZXB839wJ94nj8b+ItDX
 ImyuGaHCjw/lWX/HsGFRd4Rqx700/iyr0UOMMDGJVwadQWeaXmx2M9iSkg5DXY0J/EeYL2oZu
 HjKcyE2FFKbEKB0bGMIOpv8PWCFVP4rcQ8Oo4jGdURQr2JIXIm/BXFvBCK4ogTOaAS+qBu63U
 CEBbM22YSXKpIjYr8/tVCTjTCqz02yiM7PJmMEqGIQGw4HCIpWVSfJXZ0k/tMITiSN2TEjwyR
 SIkxDQLJ5FKoKdAWCf9xOqbhJ8EfMHcsq/EkIn52AF6R3XOZUFvmxk9NkAQW337D/SdA2BLMS
 RM+6UbNSb9qnIlIbL0JgtIgoanClzM+nmDWVeae6CCqtiS+FMYd0411lHV2TjV9Yp9/HvUDM7
 0drGjRYOrk1pYc4A3tI34XMsJAzZpmWbl8FPUO2vJ3S8iONwvogiI7G0bTo02KhSGDypZxB+t
 Uod2yOHRYHo9FP1hf/72S5KM15pBIGGs07+l+ceFwnTLcDqtD0C2OA6G8anbTV+0O1wvrDx
Received-SPF: none client-ip=212.227.126.131; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/28 05:34:18
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 02/05/2020 à 18:12, Jonathan Marler a écrit :
> Fixes: https://bugs.launchpad.net/bugs/1876373
> 
> This code path in mmap occurs when a page size is decreased with mremap.  When a section of pages is shrunk, qemu calls mmap_reserve on the pages that were released.  However, it has the diff operation reversed, subtracting the larger old_size from the smaller new_size.  Instead, it should be subtracting the smaller new_size from the larger old_size.  You can also see in the previous line of the change that this mmap_reserve call only occurs when old_size > new_size.
> 
> Signed-off-by: Jonathan Marler <johnnymarler@gmail.com>
> ---
>  linux-user/mmap.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/linux-user/mmap.c b/linux-user/mmap.c
> index e378033797..caab62909e 100644
> --- a/linux-user/mmap.c
> +++ b/linux-user/mmap.c
> @@ -708,7 +708,7 @@ abi_long target_mremap(abi_ulong old_addr, abi_ulong old_size,
>          if (prot == 0) {
>              host_addr = mremap(g2h(old_addr), old_size, new_size, flags);
>              if (host_addr != MAP_FAILED && reserved_va && old_size > new_size) {
> -                mmap_reserve(old_addr + old_size, new_size - old_size);
> +                mmap_reserve(old_addr + old_size, old_size - new_size);
>              }
>          } else {
>              errno = ENOMEM;
> 

Reviewed-by: Laurent Vivier <laurent@vivier.eu>

