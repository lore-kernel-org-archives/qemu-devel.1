Return-Path: <SRS0=p/0J=2J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CEB2C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 14:57:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 169F820684
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 14:57:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pHMQkhSq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 169F820684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43200 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihxFQ-0007S2-AE
	for qemu-devel@archiver.kernel.org; Thu, 19 Dec 2019 09:57:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59532)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1ihx2U-0005DE-IH
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 09:44:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1ihx2S-0006HR-Vz
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 09:44:30 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:37159)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1ihx2S-00069p-HK
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 09:44:28 -0500
Received: by mail-wr1-x442.google.com with SMTP id w15so6260463wru.4
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2019 06:44:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=eoZ+3T8SHVP1YZ3CtrSrrOzb74U6DpoOKtkYh3ULrSw=;
 b=pHMQkhSq0lSR4mGh3Wc4w76i27tVc/97gTef+7cE4jIWfn5td+ozJdLCQkw7U3rdu7
 E6w0dwVJZ4ayUvrN64lC6GAUqBK8PEceKKTmWmSI1w3iaHsEc+BYPn+SpBt1quuP3fsO
 iR/fzReUnN3cYLtiVthgA6qnjsBHOwAFQLmMzJH93qA9zO3dzxzJDcfrSWxcdZPevuDz
 2hxlZsP/R678YYNfCB6IAewZPhIIkC0fSq58gcDf3gjoSCnSHTO5gBCFKsqcgshsLwdH
 t/7rcWi1dqkDCLQy7MqVB2By7iL/53/OnLbtrMUg6XKf20maNnD66jUEJk8qSwxP3OGw
 ygpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=eoZ+3T8SHVP1YZ3CtrSrrOzb74U6DpoOKtkYh3ULrSw=;
 b=HKfE72KHHafn3VeGcv4vZgfl0kS0PCW22ivDnicb7Z1HX2WN4O3XPp3+B9M8No5Qq/
 1sG8WzPuWEZeEnmS2xu9/Dz0LVj+jHrPbZoZRfOtMmnqy6rbM/dheveE5hqeWvCm5cMK
 NxWcf7E9Rz0+XEKkiFdW5YYiKmoqgzOuyuWI4Ylqzg1ott6eq+4Wqe8UetVTJptsRc+l
 mqBzead5HbI8Y4LRmwpQ7S19cVLOtmQEinp7xL49DAXSuDDPhFLshq6j9nuuR1jnZjta
 xo1T3LFZ60P6YLEvD5Gl1a9Ls0sR4DvrXSOGhceCkSMYewKAb02wn709wLGeoiwhMNb5
 Wkvg==
X-Gm-Message-State: APjAAAVnjNhxJhpkrVZNgRl7vZNHfpiy3beVJdZ3VN4FYICUa/7F5Jys
 o5dTubkoEIebqpEu11HYqN8gdQ==
X-Google-Smtp-Source: APXvYqy/HNIlGtSY/5dO6qCMM71vUt0CgX4kZ0HW2A9VCcruwelbh9a0tez1KuEz6s2S99/EhRc43A==
X-Received: by 2002:adf:9427:: with SMTP id 36mr9826595wrq.166.1576766667084; 
 Thu, 19 Dec 2019 06:44:27 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id y6sm6499831wrl.17.2019.12.19.06.44.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Dec 2019 06:44:25 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id A52F81FF87;
 Thu, 19 Dec 2019 14:44:24 +0000 (GMT)
References: <20191211170520.7747-1-alex.bennee@linaro.org>
 <20191211170520.7747-5-alex.bennee@linaro.org>
 <b5cfb77b-b969-f7e8-fb7f-a2eddd394578@greensocs.com>
User-agent: mu4e 1.3.5; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Damien Hedde <damien.hedde@greensocs.com>
Subject: Re: [PATCH v3 04/20] gdbstub: move mem_buf to GDBState and use
 GByteArray
In-reply-to: <b5cfb77b-b969-f7e8-fb7f-a2eddd394578@greensocs.com>
Date: Thu, 19 Dec 2019 14:44:24 +0000
Message-ID: <87sglge5o7.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
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
Cc: luis.machado@linaro.org,
 Philippe =?utf-8?Q?Mathieu?= =?utf-8?Q?-Daud=C3=A9?= <philmd@redhat.com>,
 richard.henderson@linaro.org, qemu-devel@nongnu.org, alan.hayward@arm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Damien Hedde <damien.hedde@greensocs.com> writes:

> On 12/11/19 6:05 PM, Alex Benn=C3=A9e wrote:
>> This is in preparation for further re-factoring of the register API
>> with the rest of the code. Theoretically the read register function
>> could overwrite the MAX_PACKET_LENGTH buffer although currently all
>> registers are well within the size range.
>>=20
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>> Reviewed-by: Damien Hedde <damien.hedde@greensocs.com>
>> Tested-by: Damien Hedde <damien.hedde@greensocs.com>
>>=20
>> ---
>> v3
>>   - fixed up email on Damien's tags
>> ---
>>  gdbstub.c | 56 ++++++++++++++++++++++++++++++++++---------------------
>>  1 file changed, 35 insertions(+), 21 deletions(-)
>>=20
>
>> @@ -2092,11 +2105,12 @@ static void handle_query_rcmd(GdbCmdContext *gdb=
_ctx, void *user_ctx)
>>      }
>>=20=20
>>      len =3D len / 2;
>> -    hextomem(gdb_ctx->mem_buf, gdb_ctx->params[0].data, len);
>> -    gdb_ctx->mem_buf[len++] =3D 0;
>> -    qemu_chr_be_write(gdbserver_state.mon_chr, gdb_ctx->mem_buf, len);
>> +    g_byte_array_set_size(gdbserver_state.mem_buf, len);
>
> Hi Alex,
>
> Just found out that the g_byte_array_set_size() above should be removed.
> hextomem() will append data starting at offset [len] instead of [0] and
> we end up with an uninitialized prefix in the array.

Oops, fixed. I should assert len is 0 before we start.

>
>> +    hextomem(gdbserver_state.mem_buf, gdb_ctx->params[0].data, len);
>> +    g_byte_array_append(gdbserver_state.mem_buf, &zero, 1);
>> +    qemu_chr_be_write(gdbserver_state.mon_chr, gdbserver_state.mem_buf-=
>data,
>> +                      gdbserver_state.mem_buf->len);
>>      put_packet("OK");
>> -
>>  }
>>  #endif
>>=20=20
>>=20
>
> I did double-checked the rest of the patch and it is it the only resize
> that passed through v2 review.
>
> Regards,
> Damien


--=20
Alex Benn=C3=A9e

