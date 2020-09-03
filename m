Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ED5CC433E9
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 16:04:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F73D20716
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 16:04:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kOBGm2b9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F73D20716
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60718 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDrj5-0005Ov-61
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 12:04:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33808)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kDrhb-0003ae-CO; Thu, 03 Sep 2020 12:03:07 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:45890)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kDrhZ-0006hs-97; Thu, 03 Sep 2020 12:03:06 -0400
Received: by mail-wr1-x444.google.com with SMTP id x14so3775910wrl.12;
 Thu, 03 Sep 2020 09:03:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:from:to:cc:references:autocrypt:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=I2Byr56cyXTRbPa/SpfHUInW5n3CaXxpESr1e4AX1MQ=;
 b=kOBGm2b92qJv1jVKoL8OyzS3/lE3xtdHyzqpi4kfUG6OXJb8PMl7HF6euHlGlQMzL9
 BMfLiU4IpEzRoNMCxseuqxFvtiTgaVEmH24oONwiQoxRsTIZxPsXtm31wG6qOclleoLD
 VXGd9py1VS8T/uKc1Pe2eWGyzVYq6a/KJ+wNKqH2jqMtEHpKmtX0Ms6jpPu0dEPXh27J
 8LCYyQjwwPYB4MUdDJpLdno//Bb7j8peGQ4GodSyy1+V7vKIatdiKHhS0hAGOAS9/ie4
 lmh6PaNRKbi1UWJYwx0WD7W/UrXbjJR78nhVb98DsEGWkiUL9KyEHxmlh0Yezf204bsZ
 bhTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:from:to:cc:references:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=I2Byr56cyXTRbPa/SpfHUInW5n3CaXxpESr1e4AX1MQ=;
 b=ZFQPgT2I5qfnyv6tQnHv3+za03SXZRwCBPmJj8fkSYELFE93YzDOi4qzu4p5WArJWI
 UnUnweCBOmv9ziIRPt119kz0YxLxEsXw3iR4JKP0YKiVVPOn4PmJzLQltbIBkFZNgYy8
 XBT9RUnYGn+SUmZe3fBNmSleGwQAyBCTzpjfLJFTpCijKVggPdicrjIQIiT3+zBfTIF4
 Imo44bn1xviWeITWzzz2FUZVffpSuvnPmLCX34FXBKh+RSO08afS79nOdAPv3L2fz/vn
 mm84KQvn8ho6HBdhoY5w+quGbu8q10vgPVxJ4BQ3ruqPT2Y3cbgzNRGraQNu2uAg5Pmh
 TZzw==
X-Gm-Message-State: AOAM532wSbLcP5y/9Iwol8vz4UzSbRRoKKH3zZfQClQFntBXchfG2+we
 mSKEGH3vQDZGgNSe7snn/ic=
X-Google-Smtp-Source: ABdhPJyS1YSSB/v8ZJ4Nth07OnsRuh2GuNcpZ/sr9SvalypUtoYnCjX04b4JN67oCRvonmclaPRdZQ==
X-Received: by 2002:adf:e601:: with SMTP id p1mr3446008wrm.172.1599148982853; 
 Thu, 03 Sep 2020 09:03:02 -0700 (PDT)
Received: from [192.168.1.36] (50.red-83-52-54.dynamicip.rima-tde.net.
 [83.52.54.50])
 by smtp.gmail.com with ESMTPSA id j14sm5288144wrr.66.2020.09.03.09.03.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Sep 2020 09:03:02 -0700 (PDT)
Subject: Re: [PATCH v1] sd: sdhci: assert data_count is within fifo_buffer
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
To: P J P <ppandit@redhat.com>
References: <20200903070842.2125083-1-ppandit@redhat.com>
 <d7af91ab-5874-0619-b7c7-5f475ebf07ca@amsat.org>
Autocrypt: addr=f4bug@amsat.org; keydata=
 mQINBDU8rLoBEADb5b5dyglKgWF9uDbIjFXU4gDtcwiga9wJ/wX6xdhBqU8tlQ4BroH7AeRl
 u4zXP0QnBDAG7EetxlQzcfYbPmxFISWjckDBFvDbFsojrZmwF2/LkFSzlvKiN5KLghzzJhLO
 HhjGlF8deEZz/d/G8qzO9mIw8GIBS8uuWh6SIcG/qq7+y+2+aifaj92EdwU79apZepT/U3vN
 YrfcAuo1Ycy7/u0hJ7rlaFUn2Fu5KIgV2O++hHYtCCQfdPBg/+ujTL+U+sCDawCyq+9M5+LJ
 ojCzP9rViLZDd/gS6jX8T48hhidtbtsFRj/e9QpdZgDZfowRMVsRx+TB9yzjFdMO0YaYybXp
 dg/wCUepX5xmDBrle6cZ8VEe00+UQCAU1TY5Hs7QFfBbjgR3k9pgJzVXNUKcJ9DYQP0OBH9P
 ZbZvM0Ut2Bk6bLBO5iCVDOco0alrPkX7iJul2QWBy3Iy9j02GnA5jZ1Xtjr9kpCqQT+sRXso
 Vpm5TPGWaWljIeLWy/qL8drX1eyJzwTB3A36Ck4r3YmjMjfmvltSZB1uAdo1elHTlFEULpU/
 HiwvvqXQ9koB15U154VCuguvx/Qnboz8GFb9Uw8VyawzVxYVNME7xw7CQF8FYxzj6eI7rBf2
 Dj/II6wxWPgDEy3oUzuNOxTB7sT3b/Ym76yOJzWX5BylXQIJ5wARAQABtDFQaGlsaXBwZSBN
 YXRoaWV1LURhdWTDqSAoRjRCVUcpIDxmNGJ1Z0BhbXNhdC5vcmc+iQJVBBMBCAA/AhsPBgsJ
 CAcDAgYVCAIJCgsEFgIDAQIeAQIXgBYhBPqr514SkXIh3P1rsuPjLCzercDeBQJd660aBQks
 klzgAAoJEOPjLCzercDe2iMP+gMG2dUf+qHz2uG8nTBGMjgK0aEJrKVPodFA+iedQ5Kp3BMo
 jrTg3/DG1HMYdcvQu/NFLYwamUfUasyor1k+3dB23hY09O4xOsYJBWdilkBGsJTKErUmkUO2
 3J/kawosvYtJJSHUpw3N6mwz/iWnjkT8BPp7fFXSujV63aZWZINueTbK7Y8skFHI0zpype9s
 loU8xc4JBrieGccy3n4E/kogGrTG5jcMTNHZ106DsQkhFnjhWETp6g9xOKrzZQbETeRBOe4P
 sRsY9YSG2Sj+ZqmZePvO8LyzGRjYU7T6Z80S1xV0lH6KTMvq7vvz5rd92f3pL4YrXq+e//HZ
 JsiLen8LH/FRhTsWRgBtNYkOsd5F9NvfJtSM0qbX32cSXMAStDVnS4U+H2vCVCWnfNug2TdY
 7v4NtdpaCi4CBBa3ZtqYVOU05IoLnlx0miKTBMqmI05kpgX98pi2QUPJBYi/+yNu3fjjcuS9
 K5WmpNFTNi6yiBbNjJA5E2qUKbIT/RwQFQvhrxBUcRCuK4x/5uOZrysjFvhtR8YGm08h+8vS
 n0JCnJD5aBhiVdkohEFAz7e5YNrAg6kOA5IVRHB44lTBOatLqz7ntwdGD0rteKuHaUuXpTYy
 CRqCVAKqFJtxhvJvaX0vLS1Z2dwtDwhjfIdgPiKEGOgCNGH7R8l+aaM4OPOd
Message-ID: <ce447ded-8078-9437-daae-ffe0891494c5@amsat.org>
Date: Thu, 3 Sep 2020 18:03:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <d7af91ab-5874-0619-b7c7-5f475ebf07ca@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.001, NICE_REPLY_A=-2.403,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: Ruhr-University <bugs-syssec@rub.de>,
 QEMU Developers <qemu-devel@nongnu.org>, qemu-block@nongnu.org,
 Prasad J Pandit <pjp@fedoraproject.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/3/20 4:01 PM, Philippe Mathieu-Daudé wrote:
> On 9/3/20 9:08 AM, P J P wrote:
>> From: Prasad J Pandit <pjp@fedoraproject.org>
>>
>> While doing multi block SDMA, transfer block size may exceed
>> the 's->fifo_buffer[s->buf_maxsz]' size. It may leave the
>> current element pointer 's->data_count' pointing out of bounds.
>> Leading the subsequent DMA r/w operation to OOB access issue.
>> Assert that 's->data_count' is within fifo_buffer.
>>
>>  -> https://ruhr-uni-bochum.sciebo.de/s/NNWP2GfwzYKeKwE?path=%2Fsdhci_oob_write1
>>  ==1459837==ERROR: AddressSanitizer: heap-buffer-overflow
>>  WRITE of size 54722048 at 0x61500001e280 thread T3
>>  #0  __interceptor_memcpy (/lib64/libasan.so.6+0x3a71d)
>>  #1  flatview_read_continue ../exec.c:3245
>>  #2  flatview_read ../exec.c:3278
>>  #3  address_space_read_full ../exec.c:3291
>>  #4  address_space_rw ../exec.c:3319
>>  #5  dma_memory_rw_relaxed ../include/sysemu/dma.h:87
>>  #6  dma_memory_rw ../include/sysemu/dma.h:110
>>  #7  dma_memory_read ../include/sysemu/dma.h:116
>>  #8  sdhci_sdma_transfer_multi_blocks ../hw/sd/sdhci.c:629
>>  #9  sdhci_write ../hw/sd/sdhci.c:1097
>>  #10 memory_region_write_accessor ../softmmu/memory.c:483
>>  ...
>>
>> Reported-by: Ruhr-University <bugs-syssec@rub.de>
>> Suggested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>> Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
>> ---
>>  hw/sd/sdhci.c | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> Update v1: use assert(3) calls
>>   -> https://lists.nongnu.org/archive/html/qemu-devel/2020-09/msg00966.html
>>
>> diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
>> index 1785d7e1f7..023acbed41 100644
>> --- a/hw/sd/sdhci.c
>> +++ b/hw/sd/sdhci.c
>> @@ -604,6 +604,7 @@ static void sdhci_sdma_transfer_multi_blocks(SDHCIState *s)
>>                      s->blkcnt--;
>>                  }
>>              }
>> +            assert(s->data_count <= s->buf_maxsz && s->data_count > begin);
>>              dma_memory_write(s->dma_as, s->sdmasysad,
>>                               &s->fifo_buffer[begin], s->data_count - begin);
>>              s->sdmasysad += s->data_count - begin;
>> @@ -626,6 +627,7 @@ static void sdhci_sdma_transfer_multi_blocks(SDHCIState *s)
>>                  s->data_count = block_size;
>>                  boundary_count -= block_size - begin;
>>              }
>> +            assert(s->data_count <= s->buf_maxsz && s->data_count > begin);
>>              dma_memory_read(s->dma_as, s->sdmasysad,
>>                              &s->fifo_buffer[begin], s->data_count - begin);
>>              s->sdmasysad += s->data_count - begin;
>>
> 
> qemu-system-i386: hw/sd/sdhci.c:632: void
> sdhci_sdma_transfer_multi_blocks(SDHCIState *): Assertion `s->data_count
> <= s->buf_maxsz && s->data_count > begin' failed.
> 
> Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> 
> If you don't mind I might split the assert in 2 when applying:
> 
> -            assert(s->data_count <= s->buf_maxsz && s->data_count > begin);
> +            assert(s->data_count <= s->buf_maxsz);
> +            assert(s->data_count > begin);

Doesn't seem enough, guest crash here, having:

(gdb) p begin
$1 = 0
(gdb) p s->data_count
$2 = 0
(gdb) p s->blksize
$3 = 0

Beh, something is wrong in this model, because when using ADMA2
length 0 means 65536 bytes (see '1.13.4. Descriptor Table' in
"SD Host Controller Simplified Specification Version 2.00").

