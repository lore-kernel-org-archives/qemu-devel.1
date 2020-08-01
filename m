Return-Path: <SRS0=xT3E=BL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C054C433DF
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Aug 2020 13:14:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3612E2087C
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Aug 2020 13:14:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="iYa8oLXq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3612E2087C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40876 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k1rKw-0005p2-42
	for qemu-devel@archiver.kernel.org; Sat, 01 Aug 2020 09:14:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37912)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1k1rHQ-0004wf-MQ
 for qemu-devel@nongnu.org; Sat, 01 Aug 2020 09:10:28 -0400
Received: from mout.gmx.net ([212.227.15.18]:35029)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1k1rHO-0003ee-O8
 for qemu-devel@nongnu.org; Sat, 01 Aug 2020 09:10:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
 s=badeba3b8450; t=1596287417;
 bh=yYSun86lxZi55MSReU2BnCVtqQNPdiECl2IkqQ3tM64=;
 h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
 b=iYa8oLXqEY59K7GL47t7pJMMhguw58rttI2cjH36/X0E5rfWAP/wFePGyRNQrAI+Z
 DT0tNRMUp00Flxw3429nBY2VnumCXDJCeao5Siz+sBq6yykyqXNASDO5S/p90Z7Lfx
 to2Tqd1JalShf7ogi5Xvv+rzTfpW59fJeeoUjg9I=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.20.60] ([92.116.162.176]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MTRMs-1kBeNx1rZc-00TnlS; Sat, 01
 Aug 2020 15:10:17 +0200
Subject: Re: [PATCH 4/4] hw/display/artist.c: fix out of bounds check
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20200727214608.32710-1-deller@gmx.de>
 <20200727214608.32710-5-deller@gmx.de>
 <767c4e05-6018-7f99-4401-cbc1480c3d28@linaro.org>
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
 c2TFWAS8k6RLkk41ZUU8ENX8+qZx/Q==
Message-ID: <a767a5b3-c10e-9ea3-ad6f-d342ca9d5c41@gmx.de>
Date: Sat, 1 Aug 2020 15:10:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <767c4e05-6018-7f99-4401-cbc1480c3d28@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:C8F/UArEEw5yb5LmQvM3l/oKiG1vmZl6c5mgJELE8m9Lk3TVyQI
 3NI7ncR0/IAbuFKF/omIIm4VVrD7Qz7c8MJyYWr4szfUyVr4+Xqu9zJ6sbKI850TOKtLqyj
 /2AB8BQ3nb+TjTwn0HxcXZ3CvLuB+6H0xZRDdxPJW6ytDTxflvG6AEU54jxVI4d3dsXs0jx
 2lH5miW6d3qsiOBbjpvEA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ZBnMs2COTD8=:SLrRcLtaOLIwyT0AFReMDL
 zdbv4cLqVNm+p/vjESoXCI7MpOrJ2O2P2WtxeZaVTi+oxyr1p1xnfQ11YnuTi6LYFwxTlUZBm
 CQXUQRJ7vvx8cjbpiWQGvAekBzF/YhNSmJgTi8ZcHH/T+xd2W64yd/FSUHOB6i5F+lzTuIS6H
 MpmW7xlMQPvaQ2CZxmHVbZasxfhouHVW2ini0cXQaRwWlYbDCVZrCxIwXy0bH3W9ra7QclBAb
 +b6Wg1ayw5r4+f1q+yOOJNVjzuAnT6GQIFrb2eDOCBrJW/DY6lHMG9jncps8yFuYdBkcBAAQ3
 UXsVF7n5XdULebWiOrETT8sIuswSkEZJo9bAeORpWdIeaAcGqZKKgzGmCJP0SLNxNjFJOlS7U
 SefGtCNojmipEf0fW9VFZ5jNO3/55U8SgJzeGx/h4Xz34rhEn9b1dHgV5S7L8PVpM+TtPDBPO
 X3NH5oAC2x4tOhOUnpEirXiorN9cMaD9VwXZpOicc69NQHdLdLlbKYvvxRBhzLnen02oxNx6k
 FliWo1GuvrL7uSvCzFPu/ShXvIlonKSpDyRTBb3S+3Xl+HO1yN2XstAA1b8OmJubyf2CwUQ+r
 bZ14FPiCVp4v1d7pbEiLxa0sACFNUHmMMdKTQarIPWXTO8BRd/XRbBdZcbYx1CR/kN54OjiA8
 182LJcxP7KNdZ7rHnxvkChAqoGW34cELWT1HZTXsWKabsvQot7kcsaXGII2M5g5+kqE4dGrDO
 aypJFU8XxVcWGblvgpBlm9LHF0PuTg5JWfBn2o493L8pxPHyu5HMb5V7mHEKHfsuNnA2pVJg/
 Qebkbw5oVCOeO1QytN2FYp+23wbiSYJs4TQd3otKC/lfD1zn1yF/Zt/R13Xm49HCbHv/4DYgZ
 KNze+yhv5l4FmaS+lmdFtUkISNSUOASaNKu1B4kBdOBukhWLcvRh1AUf1ShT4fwBnOEbOD8jV
 sU4ADE71946tM+U9FIELTTWLnq7WYuZ7P2a7iV7g1KhTI+32HXBAltetdyjTg4sM1ovMEmOvb
 ETDtiXLXH2CYZzk1eWPvQ9AK7/Fg+pdQ5VrtLPZBNPxDEctZaRaPm0D5Ys75iObINTAUUxl2d
 zbqwkVqOGTCQA12YIsACowMAsz/o9fUP7ISiYQuGOFTHty4/hpVGHa7MwkxyZgPzRkUqm5FPi
 +XfQtewvnAOQpCjkG6AV9qTl6keCgzF4gvA3aBHDfsB1XT0n78m4ZA2/j/CKDf8kvT7bjH9hO
 1pbuhgU82Tv5vBlk+
Received-SPF: pass client-ip=212.227.15.18; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/01 09:10:23
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
Cc: Sven Schnelle <svens@stackframe.org>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 29.07.20 19:26, Richard Henderson wrote:
> On 7/27/20 2:46 PM, Helge Deller wrote:
>> -        for (i =3D 0; i < pix_count; i++) {
>> +        for (i =3D 0; i < pix_count && offset + i < buf->size; i++) {
>>              artist_rop8(s, p + offset + pix_count - 1 - i,
>>                          (data & 1) ? (s->plane_mask >> 24) : 0);
>>              data >>=3D 1;
>
> This doesn't look right.
>
> You're writing to "offset + pix_count - 1 - i" and yet you're checking b=
ounds
> vs "offset + i".
>
> This could be fixed by computing the complete offset into a local variab=
le and
> then have an inner if to avoid the write, as you do for the second loop.
>
> But it would be better to precompute the correct loop bounds.

Thanks for the feedback.
Will send out a revised version soon.

Helge

>
> r~
>
>
>> @@ -398,7 +390,9 @@ static void vram_bit_write(ARTISTState *s, int posx=
, int posy, bool incr_x,
>>          for (i =3D 3; i >=3D 0; i--) {
>>              if (!(s->image_bitmap_op & 0x20000000) ||
>>                  s->vram_bitmask & (1 << (28 + i))) {
>> -                artist_rop8(s, p + offset + 3 - i, data8[ROP8OFF(i)]);
>> +                if (offset + 3 - i < buf->size) {
>> +                    artist_rop8(s, p + offset + 3 - i, data8[ROP8OFF(i=
)]);
>> +                }
>>              }
>>          }
>>          memory_region_set_dirty(&buf->mr, offset, 3);
>> @@ -420,7 +414,7 @@ static void vram_bit_write(ARTISTState *s, int posx=
, int posy, bool incr_x,
>>              break;
>>          }
>>
>> -        for (i =3D 0; i < pix_count; i++) {
>> +        for (i =3D 0; i < pix_count && offset + i < buf->size; i++) {
>>              mask =3D 1 << (pix_count - 1 - i);
>>
>>              if (!(s->image_bitmap_op & 0x20000000) ||


