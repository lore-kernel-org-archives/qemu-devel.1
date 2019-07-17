Return-Path: <SRS0=PWhW=VO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32DD8C7618F
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2019 14:29:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F27F121743
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2019 14:29:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O7TwgdO6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F27F121743
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=twiddle.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57856 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hnkvt-0000CB-AK
	for qemu-devel@archiver.kernel.org; Wed, 17 Jul 2019 10:29:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40770)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <rth7680@gmail.com>) id 1hnkvj-0008F1-7C
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 10:29:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <rth7680@gmail.com>) id 1hnkvi-0003Rw-D2
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 10:29:15 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:46209)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1hnkvi-0003Qa-62
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 10:29:14 -0400
Received: by mail-pg1-x542.google.com with SMTP id i8so11236367pgm.13
 for <qemu-devel@nongnu.org>; Wed, 17 Jul 2019 07:29:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:openpgp:autocrypt:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=TOxP4IHVrbcKJ9wiri509rfcmA5XDp9lJ0Ly6seSrkM=;
 b=O7TwgdO6mUhTyhA35N1nIR9zozZR1C/ass9nMWHvEOZavKrmBoG226cZKRC3QnQLTD
 N3lxtdMbu4AuWRssyoU7AcZ+YuJyuYTr8+M62EQI5EaD/Nfh244VHdGqOQ/hdWOsruJF
 oJZcCOv8dgO2oQKM5xHfAvfFuorGigcJJjreOOnUgrIlIIemKXl9zxxInPpuMLvKdjRj
 erMGK+d0ZR3OQZbRhnQDdpaiclDP4tINdPJ4o7nbH7BHwi3u8oqXTw6O84WSP9rFIM3W
 cXP1WAVWXhh310IlzUKhgsmmkqpGCkw6NIPJnjG0dD4OGkco+sVHJd+yzJAFSkoiVYKs
 C+UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:openpgp
 :autocrypt:message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=TOxP4IHVrbcKJ9wiri509rfcmA5XDp9lJ0Ly6seSrkM=;
 b=D5pLSHfsVFbO5zvkcQDBr12qil1A7ij4lgiJ6Ry2ZgbIVrrtwOhffCDOV1Bf7uWvCH
 oe4VK0jqx1ELzniRH98VnRsvxiBt4tZUe/JC4IZs7wp2L0c4z2geKykr0o3HDEtk/pYO
 C2tZOfmddMRgIMyqg1SwM+pjREaytgGmVwn0RnySLUA7mykLvUEo8ahnKFYeHjXM++MA
 EKrkzgwaEK9uPvHJTAMzlu3Xtehw6LwZ+7mq9zNuM896CLKDcU2efwmO7Hoqxw8AEmym
 8/yNxyFkBzdPZDn3SmQIjeDgcS6NYNGfj72SUVBHUCImcVWod4TbPtkFIhFWNE+GVXD3
 fpOw==
X-Gm-Message-State: APjAAAVnuIS7cEtuvyQpGaBa433gYBqKcXiWuoiKVHMzR+ZwLPTgzA6I
 +LxUZ7s5Be/uzoviI/R74K8=
X-Google-Smtp-Source: APXvYqxbEpZLdA33ySwfTdQx2F3Lv01VZj7DdylC3ClL38e4lD/UUagX4Ggw3C70a/eIFf1ddg9WFg==
X-Received: by 2002:a63:6686:: with SMTP id
 a128mr34082002pgc.361.1563373752572; 
 Wed, 17 Jul 2019 07:29:12 -0700 (PDT)
Received: from [192.168.1.11] (97-113-176-6.tukw.qwest.net. [97.113.176.6])
 by smtp.googlemail.com with ESMTPSA id 2sm44573375pgm.39.2019.07.17.07.29.11
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 17 Jul 2019 07:29:11 -0700 (PDT)
To: tony.nguyen@bt.com, qemu-devel@nongnu.org
References: <a5f7f8854af046c18c6342035662a193@tpw09926dag18e.domain1.systemhost.net>
 <1563343691021.27469@bt.com>
From: Richard Henderson <rth@twiddle.net>
Openpgp: preference=signencrypt
Autocrypt: addr=rth@twiddle.net; prefer-encrypt=mutual; keydata=
 mQENBFGuLC8BCADcAoWcnW9lTsDMzbO3MBU+KbiGaj5JPatEUscRDkQYM2fyNjJp2tIWDK5a
 n4yngeXB3eX61WbYR3QraRK8mlYLGxyAdHMEQfPipbqf3TmN043fssT2bc82ApJcs1zvLYgI
 rhMht7Dck7A0wNC1jo+ZjVVFig5gDTN7gOzaAdBtV8tVNUddwkLzzaGpfihhSD6U46NdqKOG
 Wlnn6TrkMy0QGdQ5NaXHkRlUjnnUTSW/nKfoxD+EI+A9V4sYOd8mc/TL4aJh/i/AiU57eLbo
 n17uQI6/VTWDUWl8USiz4x9c8vmqlywLx00tAFxxoRWqk4KVJlj+Sh0up/D/sJ+vPpgBABEB
 AAG0I1JpY2hhcmQgSGVuZGVyc29uIDxydGhAdHdpZGRsZS5uZXQ+iQFBBBMBAgArAhsDBgsJ
 CAcDAgYVCAIJCgsEFgIDAQIeAQIXgAUJC7UHogUCWaDNVgIZAQAKCRCtEnDMTdAnm9N5CADO
 cB8F/SudJ72IupxQf40hbJdBK176+gb3sHMsixyLtrU59lee+lIM1OZmlNjsnCYmiSnbA5ks
 Q7p0HfO7DgdmfLzcK6xsHZukqSZy5LByw348Y913ZyjOrJZFdPP7kDg1MnqRqH4+3ZdzxV4y
 eYBWFU9GYMIF06JbUubossOOO4ArNVZbnIPu8Vn2tDZVVqsCBqkoCSBMj519xrvyOu5z4mHS
 LkCglXmVDOXMbqLuNAC3rfNXSnyM4hYkLUyfALJlAAy1Ro+jUqYhu7XUFV/MiwRuFMh5GbtY
 Urkx7tqsWQXLT3GeDk/LqvpWJQwk4cHHckYjRih+70CHIenm81PVuQENBFGuLC8BCACyEx3x
 94HIkTX0CHu2sA0w75+h9wuoA8ggJ7+S4ri0y2YsijWad5TTt6z6MMiqxk9kSA5bppaj4HXh
 86hBF/dWCtMpNr3Rb8FNOKyeA/qkYHVD6HiAiw9c6D8Dr9hWmOk3/HSmGrNURxeUFOckDXsv
 I+yGGKBNshj59j7QZr7ZiuIi2rWlBL8dFN/OWa/o3x7HKsE4k6K8ngwvCKP/QbDLwLLBOWH+
 VEUtpyeyxTr3OJ47ECTxdYvXoAV2iJaKr+6doVQiiR5eVFiMYrUPUECJeolOCwqc/JlWE18L
 +PCAFaW1H+/mpPVfSpN4wnkJ5cQiQVB41IaCM4p20iRzx7ZJABEBAAGJASUEGAECAA8CGwwF
 AlmgzYEFCQu1CEoACgkQrRJwzE3QJ5s7rggAwABzDAGrZ6uWsMxg5PeiiAYPy6LBnCBJSpB5
 Tfy5jH8QTmLfXW+u4Ib4sWXG7PYNR7sIrtqUHjRqXLVXrSnBX9ASGcYw/Xil45khW6LsRpO1
 prHv9gkwQfa6fTiWXVfSfm2Nant6u02q+MaYtQpCVTiz/9ki4FfftUwUHFLU0MhIQogjd11y
 /E08RJsqBwaHQdt14PwU1HphDOzSkhOXRXQLSd3ysyeGUXvL+gqQoXl5XYdvk8IId4PoJRo4
 jcyJ4VbnldvXh5gdGhFA/f9JgkLk9tPW+C3wNtNWyRUq8azR9hF2fg2HJUf4IXQlIu8OOgh1
 VcROBqvtH3ecaIL9iw==
Message-ID: <abca2890-728e-6681-57ad-d8c5a01c57fd@twiddle.net>
Date: Wed, 17 Jul 2019 07:29:10 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <1563343691021.27469@bt.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::542
Subject: Re: [Qemu-devel] [PATCH 3/4] cputlb: Byte swap memory transaction
 attribute
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
Cc: pbonzini@redhat.com, mark.cave-ayland@ilande.co.uk, atar4qemu@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/16/19 11:08 PM, tony.nguyen@bt.com wrote:
> diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
> index baa61719ad..11debb7dda 100644
> --- a/accel/tcg/cputlb.c
> +++ b/accel/tcg/cputlb.c
> @@ -731,7 +731,7 @@ void tlb_set_page_with_attrs(CPUState *cpu, target_ulong vaddr,
>                vaddr, paddr, prot, mmu_idx);
>  
>      address = vaddr_page;
> -    if (size < TARGET_PAGE_SIZE) {
> +    if (size < TARGET_PAGE_SIZE || attrs.byte_swap) {

I don't think you want to re-use TLB_RECHECK.  This operation requires the
slow-path, yes, but not another call into cpu->cc->tlb_fill.


r~

