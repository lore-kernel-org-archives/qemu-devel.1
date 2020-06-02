Return-Path: <SRS0=xYMn=7P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2622C433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 16:58:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D5CC2068D
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 16:58:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="v4xIdhcI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D5CC2068D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36010 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgAEk-0003Gn-Oc
	for qemu-devel@archiver.kernel.org; Tue, 02 Jun 2020 12:58:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39006)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jgADm-0002iR-JH
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 12:57:02 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:35640)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jgADk-0006Tj-V8
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 12:57:02 -0400
Received: by mail-wm1-x344.google.com with SMTP id q25so3888358wmj.0
 for <qemu-devel@nongnu.org>; Tue, 02 Jun 2020 09:57:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=JUhHTgJ6y2FODR5rOHsRXvWs/nuhSTpbzMG2fX7ny1g=;
 b=v4xIdhcI4cWOZJxYgYI24VzO60SpWpsJxa/QXUu//Xyej9otXN/6u6wibSTHShG4SJ
 0uSSfH4SM/SzMqCjjY16dtSMwrgYoEfrG9WnbZA8p5EWylSfZdwRkfr6Gf4Dzep1x3dn
 Mhf0/p1G94lYFdjOx3ilyTe9vO6D6YTCdgP8HWhJ6ZuLDCDOhMxAAoc1/cQOkiOQN9ZB
 EzGzupO8/UZEvQ74UIT/rT8YbvuXvT1i/wtMA9Obvj46OctqKr58JA+8cN22cwMjBn7s
 bb00tqN21fwZaYo8l4tq9cX/iSg2KdTD56z16Vn8f+KaThGZ9iPkaZb0mqT6VRZWVkt/
 BRJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=JUhHTgJ6y2FODR5rOHsRXvWs/nuhSTpbzMG2fX7ny1g=;
 b=tNErQjX7vjenrIndojAJ27JQQkgs1ypfZODpeJorpUtgUxNL3KGPwzZQbSbp9FaJaM
 Y1QaVEFHx6OR1p9VFjX2R0GKTOfT+8nvqtb2kstIxdkDRj0JfoXt8wWateFXPJ9TQO7s
 l9DleGSk+q/9GPSUTdQAsE2y/5uFMKnhkuFMSDO4UUgF9WPi9vybKjLVnJWCsXTrNzS2
 LW03fQn3yBe75fWz5natHTR7np/bfu34T6HCScNbM33HcBRxVS+DovRodF5EkJRh0GqW
 R0ec57TbY01ISLwFUgIeirTztZuWgmp2mks2TuDhZ5CKo6BuwXj9I3fEvjzW6U8a7tnJ
 /QoA==
X-Gm-Message-State: AOAM5312TA3Ph2S3crsX5oZ8zI0DAYMmpSLUSafa1O0Ij0jQNse5yZUB
 RZ8pRt32+JRhsAkcaLUsXehHcg==
X-Google-Smtp-Source: ABdhPJzpXAlE2ndGBVs/TqoNWDClGRKRMGqnkHgFYdzUCfUHZf0STET4UmWij86dyVvnSh1j6mOTIg==
X-Received: by 2002:a1c:6606:: with SMTP id a6mr4715527wmc.37.1591117019156;
 Tue, 02 Jun 2020 09:56:59 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id h18sm4676275wru.7.2020.06.02.09.56.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jun 2020 09:56:57 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id D0A801FF7E;
 Tue,  2 Jun 2020 17:56:56 +0100 (BST)
References: <20200602154624.4460-1-alex.bennee@linaro.org>
 <20200602154624.4460-6-alex.bennee@linaro.org>
 <d27ce2e9-f6a3-0f54-83ed-888d731002fb@linaro.org>
User-agent: mu4e 1.5.1; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH v1 5/9] cputlb: ensure we re-fill the TLB if it has reset
In-reply-to: <d27ce2e9-f6a3-0f54-83ed-888d731002fb@linaro.org>
Date: Tue, 02 Jun 2020 17:56:56 +0100
Message-ID: <87h7vt76ef.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x344.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: robert.foley@linaro.org, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-devel@nongnu.org, robhenry@microsoft.com, aaron@os.amperecomputing.com,
 cota@braap.org, kuhn.chenqun@huawei.com, peter.puhov@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Richard Henderson <richard.henderson@linaro.org> writes:

> On 6/2/20 8:46 AM, Alex Benn=C3=A9e wrote:
>> Any write to a device might cause a re-arrangement of memory
>> triggering a TLB flush and potential re-size of the TLB invalidating
>> previous entries. This would cause users of qemu_plugin_get_hwaddr()
>> to see the warning:
>>=20
>>   invalid use of qemu_plugin_get_hwaddr
>>=20
>> because of the failed tlb_lookup which should always succeed. We catch
>> this case by checking to see if the list of entries has been cleared
>> and if so triggering a re-fill.
>>=20
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> ---
>>  accel/tcg/cputlb.c | 14 ++++++++++++++
>>  1 file changed, 14 insertions(+)
>>=20
>> diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
>> index eb2cf9de5e6..b7d329f7155 100644
>> --- a/accel/tcg/cputlb.c
>> +++ b/accel/tcg/cputlb.c
>> @@ -1091,6 +1091,20 @@ static void io_writex(CPUArchState *env, CPUIOTLB=
Entry *iotlbentry,
>>                                 MMU_DATA_STORE, mmu_idx, iotlbentry->att=
rs, r,
>>                                 retaddr);
>>      }
>> +
>> +    /*
>> +     * The memory_region_dispatch may have triggered a flush/resize
>> +     * so for plugins we need to ensure we have reset the tlb_entry
>> +     * so any later lookup is correct.
>> +     */
>> +#ifdef CONFIG_PLUGIN
>> +    if (env_tlb(env)->d[mmu_idx].n_used_entries =3D=3D 0) {
>> +        int size =3D op & MO_SIZE;
>> +        tlb_fill(env_cpu(env), addr, size, MMU_DATA_STORE,
>> +                 mmu_idx, retaddr);
>
> Ouch.  What if the target has a soft tlb fill, so this requires a call in=
to the
> OS, so this fill actually raises another exception?  This will not be hap=
py fun
> making.
>
> I recall I had objections to recording this translation, saying that "we =
can
> always get it back again".  Clearly I was wrong, and we should just prese=
rve
> the required CPUTLBEntry details before they're lost by a device.

Maybe we could just RCU the old TLB if it gets flushed thus ensuring the
whole TLB is preserved until after the critical section (i.e. between
the actual store and looking it up). However I don't know if the
MemoryRegion will be similarly preserved.

Paolo?

>
>
> r~


--=20
Alex Benn=C3=A9e

