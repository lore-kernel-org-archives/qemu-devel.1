Return-Path: <SRS0=+Hf+=3G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 603B7C33CB1
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 15:54:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B85C2064C
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 15:54:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="NlP12gS3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B85C2064C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59382 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1isTxG-0003YU-Qo
	for qemu-devel@archiver.kernel.org; Fri, 17 Jan 2020 10:54:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39620)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <deller@gmx.de>) id 1isTsU-0007yC-Jg
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 10:49:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <deller@gmx.de>) id 1isTsT-00010Y-39
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 10:49:42 -0500
Received: from mout.gmx.net ([212.227.17.20]:38223)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <deller@gmx.de>) id 1isTsS-0000uM-LL
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 10:49:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
 s=badeba3b8450; t=1579276174;
 bh=2SUcImC9l/i24s+gkMXJYCZ/XZPC584l/C9I5BKCvMM=;
 h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
 b=NlP12gS31MoeekC5engTzNVPLqTQrJb+0snkosvxvMdA+X4FC32SLBgSh3ZmkGbxc
 jh/wOOJTySChxW8iWbA7YED7JsOKBXWdNaCYdenNr6yJMiuA1Dflz7Tncn2PX7S+3d
 qwN+aX2TnxZU/8XVUtZi91tFIxZ95HplxIji/jhI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [10.20.71.116] ([193.16.224.4]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MGhuU-1ioe8S1wDi-00DrXR; Fri, 17
 Jan 2020 16:49:34 +0100
Subject: Re: [PATCH] target/hppa: Allow, but diagnose, LDCW aligned only mod 4
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20200117015322.12953-1-richard.henderson@linaro.org>
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 mQINBF3Ia3MBEAD3nmWzMgQByYAWnb9cNqspnkb2GLVKzhoH2QD4eRpyDLA/3smlClbeKkWT
 HLnjgkbPFDmcmCz5V0Wv1mKYRClAHPCIBIJgyICqqUZo2qGmKstUx3pFAiztlXBANpRECgwJ
 r+8w6mkccOM9GhoPU0vMaD/UVJcJQzvrxVHO8EHS36aUkjKd6cOpdVbCt3qx8cEhCmaFEO6u
 CL+k5AZQoABbFQEBocZE1/lSYzaHkcHrjn4cQjc3CffXnUVYwlo8EYOtAHgMDC39s9a7S90L
 69l6G73lYBD/Br5lnDPlG6dKfGFZZpQ1h8/x+Qz366Ojfq9MuuRJg7ZQpe6foiOtqwKym/zV
 dVvSdOOc5sHSpfwu5+BVAAyBd6hw4NddlAQUjHSRs3zJ9OfrEx2d3mIfXZ7+pMhZ7qX0Axlq
 Lq+B5cfLpzkPAgKn11tfXFxP+hcPHIts0bnDz4EEp+HraW+oRCH2m57Y9zhcJTOJaLw4YpTY
 GRUlF076vZ2Hz/xMEvIJddRGId7UXZgH9a32NDf+BUjWEZvFt1wFSW1r7zb7oGCwZMy2LI/G
 aHQv/N0NeFMd28z+deyxd0k1CGefHJuJcOJDVtcE1rGQ43aDhWSpXvXKDj42vFD2We6uIo9D
 1VNre2+uAxFzqqf026H6cH8hin9Vnx7p3uq3Dka/Y/qmRFnKVQARAQABtBxIZWxnZSBEZWxs
 ZXIgPGRlbGxlckBnbXguZGU+iQJRBBMBCAA7AhsDBQsJCAcCBhUKCQgLAgQWAgMBAh4BAheA
 FiEERUSCKCzZENvvPSX4Pl89BKeiRgMFAl3J1zsCGQEACgkQPl89BKeiRgNK7xAAg6kJTPje
 uBm9PJTUxXaoaLJFXbYdSPfXhqX/BI9Xi2VzhwC2nSmizdFbeobQBTtRIz5LPhjk95t11q0s
 uP5htzNISPpwxiYZGKrNnXfcPlziI2bUtlz4ke34cLK6MIl1kbS0/kJBxhiXyvyTWk2JmkMi
 REjR84lCMAoJd1OM9XGFOg94BT5aLlEKFcld9qj7B4UFpma8RbRUpUWdo0omAEgrnhaKJwV8
 qt0ULaF/kyP5qbI8iA2PAvIjq73dA4LNKdMFPG7Rw8yITQ1Vi0DlDgDT2RLvKxEQC0o3C6O4
 iQq7qamsThLK0JSDRdLDnq6Phv+Yahd7sDMYuk3gIdoyczRkXzncWAYq7XTWl7nZYBVXG1D8
 gkdclsnHzEKpTQIzn/rGyZshsjL4pxVUIpw/vdfx8oNRLKj7iduf11g2kFP71e9v2PP94ik3
 Xi9oszP+fP770J0B8QM8w745BrcQm41SsILjArK+5mMHrYhM4ZFN7aipK3UXDNs3vjN+t0zi
 qErzlrxXtsX4J6nqjs/mF9frVkpv7OTAzj7pjFHv0Bu8pRm4AyW6Y5/H6jOup6nkJdP/AFDu
 5ImdlA0jhr3iLk9s9WnjBUHyMYu+HD7qR3yhX6uWxg2oB2FWVMRLXbPEt2hRGq09rVQS7DBy
 dbZgPwou7pD8MTfQhGmDJFKm2ju5Ag0EXchrcwEQAOsDQjdtPeaRt8EP2pc8tG+g9eiiX9Sh
 rX87SLSeKF6uHpEJ3VbhafIU6A7hy7RcIJnQz0hEUdXjH774B8YD3JKnAtfAyuIU2/rOGa/v
 UN4BY6U6TVIOv9piVQByBthGQh4YHhePSKtPzK9Pv/6rd8H3IWnJK/dXiUDQllkedrENXrZp
 eLUjhyp94ooo9XqRl44YqlsrSUh+BzW7wqwfmu26UjmAzIZYVCPCq5IjD96QrhLf6naY6En3
 ++tqCAWPkqKvWfRdXPOz4GK08uhcBp3jZHTVkcbo5qahVpv8Y8mzOvSIAxnIjb+cklVxjyY9
 dVlrhfKiK5L+zA2fWUreVBqLs1SjfHm5OGuQ2qqzVcMYJGH/uisJn22VXB1c48yYyGv2HUN5
 lC1JHQUV9734I5cczA2Gfo27nTHy3zANj4hy+s/q1adzvn7hMokU7OehwKrNXafFfwWVK3OG
 1dSjWtgIv5KJi1XZk5TV6JlPZSqj4D8pUwIx3KSp0cD7xTEZATRfc47Yc+cyKcXG034tNEAc
 xZNTR1kMi9njdxc1wzM9T6pspTtA0vuD3ee94Dg+nDrH1As24uwfFLguiILPzpl0kLaPYYgB
 wumlL2nGcB6RVRRFMiAS5uOTEk+sJ/tRiQwO3K8vmaECaNJRfJC7weH+jww1Dzo0f1TP6rUa
 fTBRABEBAAGJAjYEGAEIACAWIQRFRIIoLNkQ2+89Jfg+Xz0Ep6JGAwUCXchrcwIbDAAKCRA+
 Xz0Ep6JGAxtdEAC54NQMBwjUNqBNCMsh6WrwQwbg9tkJw718QHPw43gKFSxFIYzdBzD/YMPH
 l+2fFiefvmI4uNDjlyCITGSM+T6b8cA7YAKvZhzJyJSS7pRzsIKGjhk7zADL1+PJei9p9idy
 RbmFKo0dAL+ac0t/EZULHGPuIiavWLgwYLVoUEBwz86ZtEtVmDmEsj8ryWw75ZIarNDhV74s
 BdM2ffUJk3+vWe25BPcJiaZkTuFt+xt2CdbvpZv3IPrEkp9GAKof2hHdFCRKMtgxBo8Kao6p
 Ws/Vv68FusAi94ySuZT3fp1xGWWf5+1jX4ylC//w0Rj85QihTpA2MylORUNFvH0MRJx4mlFk
 XN6G+5jIIJhG46LUucQ28+VyEDNcGL3tarnkw8ngEhAbnvMJ2RTx8vGh7PssKaGzAUmNNZiG
 MB4mPKqvDZ02j1wp7vthQcOEg08z1+XHXb8ZZKST7yTVa5P89JymGE8CBGdQaAXnqYK3/yWf
 FwRDcGV6nxanxZGKEkSHHOm8jHwvQWvPP73pvuPBEPtKGLzbgd7OOcGZWtq2hNC6cRtsRdDx
 4TAGMCz4j238m+2mdbdhRh3iBnWT5yPFfnv/2IjFAk+sdix1Mrr+LIDF++kiekeq0yUpDdc4
 ExBy2xf6dd+tuFFBp3/VDN4U0UfG4QJ2fg19zE5Z8dS4jGIbLrgzBF3IbakWCSsGAQQB2kcP
 AQEHQNdEF2C6q5MwiI+3akqcRJWo5mN24V3vb3guRJHo8xbFiQKtBBgBCAAgFiEERUSCKCzZ
 ENvvPSX4Pl89BKeiRgMFAl3IbakCGwIAgQkQPl89BKeiRgN2IAQZFggAHRYhBLzpEj4a0p8H
 wEm73vcStRCiOg9fBQJdyG2pAAoJEPcStRCiOg9fto8A/3cti96iIyCLswnSntdzdYl72SjJ
 HnsUYypLPeKEXwCqAQDB69QCjXHPmQ/340v6jONRMH6eLuGOdIBx8D+oBp8+BGLiD/9qu5H/
 eGe0rrmE5lLFRlnm5QqKKi4gKt2WHMEdGi7fXggOTZbuKJA9+DzPxcf9ShuQMJRQDkgzv/VD
 V1fvOdaIMlM1EjMxIS2fyyI+9KZD7WwFYK3VIOsC7PtjOLYHSr7o7vDHNqTle7JYGEPlxuE6
 hjMU7Ew2Ni4SBio8PILVXE+dL/BELp5JzOcMPnOnVsQtNbllIYvXRyX0qkTD6XM2Jbh+xI9P
 xajC+ojJ/cqPYBEALVfgdh6MbA8rx3EOCYj/n8cZ/xfo+wR/zSQ+m9wIhjxI4XfbNz8oGECm
 xeg1uqcyxfHx+N/pdg5Rvw9g+rtlfmTCj8JhNksNr0NcsNXTkaOy++4Wb9lKDAUcRma7TgMk
 Yq21O5RINec5Jo3xeEUfApVwbueBWCtq4bljeXG93iOWMk4cYqsRVsWsDxsplHQfh5xHk2Zf
 GAUYbm/rX36cdDBbaX2+rgvcHDTx9fOXozugEqFQv9oNg3UnXDWyEeiDLTC/0Gei/Jd/YL1p
 XzCscCr+pggvqX7kI33AQsxo1DT19sNYLU5dJ5Qxz1+zdNkB9kK9CcTVFXMYehKueBkk5MaU
 ou0ZH9LCDjtnOKxPuUWstxTXWzsinSpLDIpkP//4fN6asmPo2cSXMXE0iA5WsWAXcK8uZ4jD
 c2TFWAS8k6RLkk41ZUU8ENX8+qZx/Q==
Message-ID: <7b14c840-0d3f-0c67-06be-81b058c727fb@gmx.de>
Date: Fri, 17 Jan 2020 16:49:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200117015322.12953-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:B5rov7XRMpttgCvEzppnvb1QJT+jlABY2wrXdleQqgLCawDpVn9
 krqTglHu0TE9JqTKqyp5GzKVTYgnNCB7oBHV1e0wzp31IP5u8QvKLqZoucrMYeESX10BRz4
 J+7g8n/A1Nti84N65ItuQ44hlfyYwDWq19fL2aYEnJWYfijy96Q18XvBt9mYrI4LPWYkd3B
 wThNsOTA0+RChXANRFPlw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:0tcmzAFIx00=:F8UTv5fPGxiF74u5nFd9LH
 wWsRn33WuuZ/tLhm/Z+ws7aDz9J9+Q9BQwnElvLKetF9NnRhtKpIoP57t3SDiSqtp1mxXr2DO
 nuCRFHe3E5guApkU0hkvRkg61UufX0PwtbJCLni5Ox4DhKVAWDcyVrplpv9A4RFNJFJ1xGd8Q
 mrVwIt6jO+S0/CdTUem8S+ZpN8jZlGoY1UrOV7KAwlI8tetspSzFsxAsHZy9QX5pYZ+A4MUhl
 KY/hysHLVwqNLd/b3yg2palOD/wa2r6kTVvLxylPQkv4bsY6jhBjZSFx8thkijBM7i5Ih4gcI
 pPIRRvK5lVdXmTZ4vxr5oo5A1imm3LFh1UJqHRMRr3s2hpicBP6Lk1hVtox/PDrdhxRdeAja0
 naTXbXHg6NIep7xdADVVbW/Uu9EyLtMSkdAF+aDahepeo203p0/GTzWLtog8YxOeig3B0+jRN
 mRxRZw8Gus9WEENl0rsa+6ofjTyaYBx3ZFT+69BjdYaTSp4HARKPl23Q00jwd0of+wwlKiHpY
 Lq9nLyzPXneZNz5vaCNFXJI+MVlu8Jfxgd57CFdiXnFpcdqApHyqgz/NVLauipGrXb2fpbDmN
 VwbT4d1VeJhDXfWFiYL9gHlVbh5BSjIYEJIAi1coV7l8NuafkDXxna6D6E2LFZQ1nx3qjXpIt
 jDxV4kzgNqZdfb3aYthVghuMZyvUn5qqA7DEMxEi+aLQ6RJi0T7+W1P+ltoAUzWqoQVGLPAb9
 UiMZ/HGhuro81Q1OLhY3grUIdAAWR7WBpfSz4R8XfHCPYkv6Bwm4hdHFn9aSZYuZ5wsOnXaqv
 q20Q+ClQ3a+DPUyne+2Q4C/dtjA5v16epQkxiK4T6NZhFRSOuPI022VztVQMdNqyz3OZu7hn/
 Ld7Ovi0E7fL6jDKUk65RV+hZ7jmTIEr641EbxjGyHtfgm0t/GEYA2ihehHGRgG1rywujzQlf/
 WYEhwaU3sQ0If7rJODgoow5d6ixBUBjLSE/ioH5t1zwfPkcR79+62xEEO96ETTEhsyXO1t7vl
 yJ7Me6U49A0xT8Y4nTcHRxLwd5edNWkEJ5ksTKipkBRXGLbXAwffJuAO/nq+O3+//VAKrOiFq
 IedUGIl/G7yCljjMVsIIqOwtDS10goS0ID5MlqHL+c3eRgqyat2YL4b1JmmNJxCtJaH2Iz1x7
 MmWmy1wuGN2FK55QePaOeUVcAWIcPNEZdS7WWpWQT+3/MMxmyEOSrM9qSFIU70uq8KqHlCyxN
 Z7qYxps5t6trXFEULx8jlVPON7sza/fz0G+U4kw==
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 212.227.17.20
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
Cc: dave.anglin@bell.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 17.01.20 02:53, Richard Henderson wrote:
> The PA-RISC 1.1 specification says that LDCW must be aligned mod 16
> or the operation is undefined.  However, real hardware only generates
> an unaligned access trap for unaligned mod 4.
>
> Match real hardware, but diagnose with GUEST_ERROR a violation of the
> specification.
>
> Reported-by: Helge Deller <deller@gmx.de>
> Suggested-by: John David Anglin <dave.anglin@bell.net>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>
> Helge, can you please test this against your failing kernel?
> You will of course want to add -D logfile -d guest_errors to
> you qemu command-line.

Yes, works as expected.
Thanks!

Please add:
Tested-by: Helge Deller <deller@gmx.de>


[deller]$ tail -f logfile
Undefined ldc to address unaligned mod 16: 00000504fa6c7848
Undefined ldc to address unaligned mod 16: 00000504fa6c7a48
Undefined ldc to address unaligned mod 16: 00000506f9434848
Undefined ldc to address unaligned mod 16: 00000506f9434a48
Undefined ldc to address unaligned mod 16: 00000508fa036848
Undefined ldc to address unaligned mod 16: 00000508fa036a48
Undefined ldc to address unaligned mod 16: 0000050afa8c4848
Undefined ldc to address unaligned mod 16: 0000050afa8c4a48
Undefined ldc to address unaligned mod 16: 0000050cf94d1848
Undefined ldc to address unaligned mod 16: 0000050cf94d1a48
....



>
>
> r~
>
> ---
>  target/hppa/helper.h    | 2 ++
>  target/hppa/op_helper.c | 9 +++++++++
>  target/hppa/translate.c | 6 +++++-
>  3 files changed, 16 insertions(+), 1 deletion(-)
>
> diff --git a/target/hppa/helper.h b/target/hppa/helper.h
> index 38d834ef6b..2d483aab58 100644
> --- a/target/hppa/helper.h
> +++ b/target/hppa/helper.h
> @@ -17,6 +17,8 @@ DEF_HELPER_FLAGS_3(stby_b_parallel, TCG_CALL_NO_WG, vo=
id, env, tl, tr)
>  DEF_HELPER_FLAGS_3(stby_e, TCG_CALL_NO_WG, void, env, tl, tr)
>  DEF_HELPER_FLAGS_3(stby_e_parallel, TCG_CALL_NO_WG, void, env, tl, tr)
>
> +DEF_HELPER_FLAGS_1(ldc_check, TCG_CALL_NO_RWG, void, tl)
> +
>  DEF_HELPER_FLAGS_4(probe, TCG_CALL_NO_WG, tr, env, tl, i32, i32)
>
>  DEF_HELPER_FLAGS_1(loaded_fr0, TCG_CALL_NO_RWG, void, env)
> diff --git a/target/hppa/op_helper.c b/target/hppa/op_helper.c
> index f0516e81f1..345cef2c08 100644
> --- a/target/hppa/op_helper.c
> +++ b/target/hppa/op_helper.c
> @@ -153,6 +153,15 @@ void HELPER(stby_e_parallel)(CPUHPPAState *env, tar=
get_ulong addr,
>      do_stby_e(env, addr, val, true, GETPC());
>  }
>
> +void HELPER(ldc_check)(target_ulong addr)
> +{
> +    if (unlikely(addr & 0xf)) {
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "Undefined ldc to address unaligned mod 16: "
> +                      TARGET_FMT_lx "\n", addr);
> +    }
> +}
> +
>  target_ureg HELPER(probe)(CPUHPPAState *env, target_ulong addr,
>                            uint32_t level, uint32_t want)
>  {
> diff --git a/target/hppa/translate.c b/target/hppa/translate.c
> index 2f8d407a82..669381dc1d 100644
> --- a/target/hppa/translate.c
> +++ b/target/hppa/translate.c
> @@ -2942,7 +2942,7 @@ static bool trans_st(DisasContext *ctx, arg_ldst *=
a)
>
>  static bool trans_ldc(DisasContext *ctx, arg_ldst *a)
>  {
> -    MemOp mop =3D MO_TEUL | MO_ALIGN_16 | a->size;
> +    MemOp mop =3D MO_TE | MO_ALIGN | a->size;
>      TCGv_reg zero, dest, ofs;
>      TCGv_tl addr;
>
> @@ -2958,8 +2958,12 @@ static bool trans_ldc(DisasContext *ctx, arg_ldst=
 *a)
>
>      form_gva(ctx, &addr, &ofs, a->b, a->x, a->scale ? a->size : 0,
>               a->disp, a->sp, a->m, ctx->mmu_idx =3D=3D MMU_PHYS_IDX);
> +
> +    gen_helper_ldc_check(addr);
>      zero =3D tcg_const_reg(0);
>      tcg_gen_atomic_xchg_reg(dest, addr, zero, ctx->mmu_idx, mop);
> +    tcg_temp_free(zero);
> +
>      if (a->m) {
>          save_gpr(ctx, a->b, ofs);
>      }
>


