Return-Path: <SRS0=/cID=ZR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00D67C432C0
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2019 08:43:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C8AEF2071E
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2019 08:43:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8AEF2071E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41364 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZ9y3-0005Yy-So
	for qemu-devel@archiver.kernel.org; Mon, 25 Nov 2019 03:43:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52501)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1iZ9xG-0004qi-Jw
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 03:42:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1iZ9xF-0003wE-GL
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 03:42:46 -0500
Received: from mout.kundenserver.de ([212.227.17.24]:44911)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1iZ9xF-0003vM-7E
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 03:42:45 -0500
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue107 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1Mf0yy-1hsfBt1Ecs-00gYLY; Mon, 25 Nov 2019 09:42:39 +0100
Subject: Re: [PATCH] linux-user: fix translation of statx structures
To: Ariadne Conill <ariadne@dereferenced.org>, riku.voipio@iki.fi
References: <20191122174040.569252-1-ariadne@dereferenced.org>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <e3fe46c7-d02e-a896-b06e-d4570f40b5fc@vivier.eu>
Date: Mon, 25 Nov 2019 09:42:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191122174040.569252-1-ariadne@dereferenced.org>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:GfR6KmqXe1Nclrj6mqmHvsv5kvC85aW0vUiqzbscggkQDaq3+PY
 jUwV72y91uji1iI26saC2SUcNRjoE1mSLizhDPeI2VTTXJEhEM43sGUf2oRS7aLhKr/erBN
 L/9sSmsdVS+4ikApc2F9n1gpCTN7qu6irnbtRiAMdmhdsyaSm9sHAkWfc4ZikeySn8eU5ge
 XLrZ7dZYDxxbOK7d+RSUg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:gez6MMeRzN4=:4uSVLulIiI2nvcw5HP/jXS
 9EI8A7Bnu7kPzLKO5u7drNLYrrBrAeUi2BQr1kRozBKkXTULpnjbSy4kOUSRHSvInKhTkJ4Xu
 /G4p11NKak2+IwKuOTGQ1E7ffzS2blAjRCYhr3HpoHKbtWvt8c1XNB9p+rEb7xCkT3qXhYDyr
 kPseP+BIU87Fwh1xf/OM8SXoTWl+txH2q0YDJoS1fSKbgT71dvi58UcFhT/O/3jL0kfEm0UFd
 0DydyIwwN0VI/DObAAnjL64s9whdit1/6YVUb3Wik8yf36krVWLC8ZDciH4DFjujV3g+PD1Cw
 3EH6SgCS9XPgHIQziA8BH2MDguDYqyqatQqQqd5wT5PanoaYAZ7H1dIjZKDICvKBLY0jpLGTl
 nuwJ6/S30tXBEU38IFfLNXucTsrGotqyCVEcK/ZpDhltriNxKIMun7V3cjOPjjt4gANCtu18u
 45PNVOpIRAC8wefDr2Oa+odW/P0SvSHck1Z9SKiq6Mxrl3df1wixzsqM/HUjQoSOtqpr6FCaK
 h2/VCzhBx2W+mAcSyjAe+dBtovJPIwdLSoVhF06FfqdIdnkoJCyCbPGGElsFeXKbuuUbo/1xQ
 nQ2RWjAb+rvwD3udWYWAHU80qiXl2B42mbQLUpxgz2jGP3AlUC4WkVNkqjlb+5B+qKPzY2eaC
 eY4mXsLdalMgiGKh9c1+MNbccAv6IC8IaMhjJ/5ioRYrX7q0EaGWPMBaXYLCSbtz1ZHsjQ9GR
 brdZ3jWXkdASb0zweM7fg9mu8LWQ3OL6p7x+peCYlKjqxDFNGRGGFM4vPqc770PbfEiy2LvZZ
 6uMgA6ZeTDv/bEX4GIWEBj9Cn7xAFa9iwhWhUA78+C8WAvLa2zLML4WqdJcgbSAfdlaOLMhU5
 DvEUYR+zBOSk5oVpVmqgY8Bm3o3eCTvD1Ia5AK4A4=
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 22/11/2019 à 18:40, Ariadne Conill a écrit :
> All timestamps were copied to atime instead of to their respective
> fields.
> 
> Signed-off-by: Ariadne Conill <ariadne@dereferenced.org>
> ---
>  linux-user/syscall.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index ce399a55f0..171c0caef3 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -6743,12 +6743,12 @@ static inline abi_long host_to_target_statx(struct target_statx *host_stx,
>      __put_user(host_stx->stx_attributes_mask, &target_stx->stx_attributes_mask);
>      __put_user(host_stx->stx_atime.tv_sec, &target_stx->stx_atime.tv_sec);
>      __put_user(host_stx->stx_atime.tv_nsec, &target_stx->stx_atime.tv_nsec);
> -    __put_user(host_stx->stx_btime.tv_sec, &target_stx->stx_atime.tv_sec);
> -    __put_user(host_stx->stx_btime.tv_nsec, &target_stx->stx_atime.tv_nsec);
> -    __put_user(host_stx->stx_ctime.tv_sec, &target_stx->stx_atime.tv_sec);
> -    __put_user(host_stx->stx_ctime.tv_nsec, &target_stx->stx_atime.tv_nsec);
> -    __put_user(host_stx->stx_mtime.tv_sec, &target_stx->stx_atime.tv_sec);
> -    __put_user(host_stx->stx_mtime.tv_nsec, &target_stx->stx_atime.tv_nsec);
> +    __put_user(host_stx->stx_btime.tv_sec, &target_stx->stx_btime.tv_sec);
> +    __put_user(host_stx->stx_btime.tv_nsec, &target_stx->stx_btime.tv_nsec);
> +    __put_user(host_stx->stx_ctime.tv_sec, &target_stx->stx_ctime.tv_sec);
> +    __put_user(host_stx->stx_ctime.tv_nsec, &target_stx->stx_ctime.tv_nsec);
> +    __put_user(host_stx->stx_mtime.tv_sec, &target_stx->stx_mtime.tv_sec);
> +    __put_user(host_stx->stx_mtime.tv_nsec, &target_stx->stx_mtime.tv_nsec);
>      __put_user(host_stx->stx_rdev_major, &target_stx->stx_rdev_major);
>      __put_user(host_stx->stx_rdev_minor, &target_stx->stx_rdev_minor);
>      __put_user(host_stx->stx_dev_major, &target_stx->stx_dev_major);
> 

Applied to my linux-user branch for 4.2.

Thanks,
Laurent


