Return-Path: <SRS0=HheB=ZZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DD78C432C0
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 18:38:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D9082206E4
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 18:38:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CF5414ln"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9082206E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57324 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1icD3d-0001wM-M3
	for qemu-devel@archiver.kernel.org; Tue, 03 Dec 2019 13:37:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33328)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1icBy1-0005Df-V9
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 12:28:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1icBxs-0007Oj-Ee
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 12:27:59 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:23733
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1icBxr-0007A5-Ai
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 12:27:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575394067;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SDFRBhregaWR6UCPYA48ea7W+JzhzpaIQSt2Oza1ncI=;
 b=CF5414lnLW0u0dyO+jkREvi+LZF4viE1Jtw6utZSV7H3dmnnyQpUyhuCZJlpAx1RiMFRGn
 ykIp2873VB6TuT1D7VS3SvGSGhPmaHJjkS+FHcg1+IxpYywmbYv0AQH7iq3Im78rThxJg3
 qldRLxUrMKLuVBgciisxtZIu7nIrkPU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-39-joCplyXEMuajDOH65RtKNA-1; Tue, 03 Dec 2019 12:27:43 -0500
Received: by mail-wm1-f72.google.com with SMTP id f16so1216235wmb.2
 for <qemu-devel@nongnu.org>; Tue, 03 Dec 2019 09:27:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=0D6PkLGHTZYjnPVu9XAb8Uu49tCjXJV4smH8ssuZw2s=;
 b=oWdUKh5SxO+qT0XcSA9KaHtveOtOaOZj3QpjoSu6ncBEeWW8DFIgqR0AqBaqtGajK/
 aKsb60yRH/9yn3QQ7wnjjhPvLt+m2pB4aKSUAzwknJuwIFqr0uKKL+95cSZ5Sx/8PCzg
 IOwjFUDfd2MlV0fTktPSC8kDmtKMsLmbjS/d01xwHwOFd8xNvhai7u+5WI6qH33Qp7mQ
 hQogqBvtqnZioYj934S5/h1OnxeEKz4Uw0ADK9UU5dWouV0U4UwkVOgNtwIOUwjLjQPO
 enqr0cWndb6w6VIH5fIBxOIRUVj9R99lPi6liaCcr+9soird6TdZcsHFJksd/3qP4hDH
 W3Bg==
X-Gm-Message-State: APjAAAWh0jSR/HxZrLr+mPvGMvfScbvPWrl4aVDldbH0o5AMhE5KmVTU
 saPKdI9nCItyPt9ufGis8C3yg7ZwxTPh6w3WfSGegquAfaDahnS6Ru1EVs2mEwRq0osBXnon3sJ
 9IEJwR8AgJkP+6Uw=
X-Received: by 2002:a5d:49c7:: with SMTP id t7mr6345194wrs.369.1575394062922; 
 Tue, 03 Dec 2019 09:27:42 -0800 (PST)
X-Google-Smtp-Source: APXvYqwl5x7IJPTK960yATmh8P588D+vnq9K07QphsjWR6m2ZM+sDyg4iQ/ZdfLRMiWr172FftpTYA==
X-Received: by 2002:a5d:49c7:: with SMTP id t7mr6345170wrs.369.1575394062698; 
 Tue, 03 Dec 2019 09:27:42 -0800 (PST)
Received: from [192.168.1.35] (182.red-88-21-103.staticip.rima-tde.net.
 [88.21.103.182])
 by smtp.gmail.com with ESMTPSA id l3sm4465275wrt.29.2019.12.03.09.27.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Dec 2019 09:27:42 -0800 (PST)
Subject: Re: [PATCH v2 2/4] target/arm: Abstract the generic timer frequency
To: Andrew Jeffery <andrew@aj.id.au>, qemu-arm@nongnu.org
References: <20191203041440.6275-1-andrew@aj.id.au>
 <20191203041440.6275-3-andrew@aj.id.au>
 <283c152b-b1c7-551e-bec0-c087b14de996@redhat.com>
 <4e90d36d-aa13-441f-9298-56f83a5bff6a@www.fastmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <87bf3c1d-9e77-f4a1-1163-548a3cfee3bc@redhat.com>
Date: Tue, 3 Dec 2019 18:27:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <4e90d36d-aa13-441f-9298-56f83a5bff6a@www.fastmail.com>
Content-Language: en-US
X-MC-Unique: joCplyXEMuajDOH65RtKNA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Joel Stanley <joel@jms.id.au>, Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/3/19 1:48 PM, Andrew Jeffery wrote:
> On Tue, 3 Dec 2019, at 16:39, Philippe Mathieu-Daud=C3=A9 wrote:
>> On 12/3/19 5:14 AM, Andrew Jeffery wrote:
>>> Prepare for SoCs such as the ASPEED AST2600 whose firmware configures
>>> CNTFRQ to values significantly larger than the static 62.5MHz value
>>> currently derived from GTIMER_SCALE. As the OS potentially derives its
>>> timer periods from the CNTFRQ value the lack of support for running
>>> QEMUTimers at the appropriate rate leads to sticky behaviour in the
>>> guest.
>>>
>>> Substitute the GTIMER_SCALE constant with use of a helper to derive the
>>> period from gt_cntfrq stored in struct ARMCPU. Initially set gt_cntfrq
>>> to the frequency associated with GTIMER_SCALE so current behaviour is
>>> maintained.
>>>
>>> Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
>>> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>>> ---
>>>    target/arm/cpu.c    |  2 ++
>>>    target/arm/cpu.h    | 10 ++++++++++
>>>    target/arm/helper.c | 10 +++++++---
>>>    3 files changed, 19 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/target/arm/cpu.c b/target/arm/cpu.c
>>> index 7a4ac9339bf9..5698a74061bb 100644
>>> --- a/target/arm/cpu.c
>>> +++ b/target/arm/cpu.c
>>> @@ -974,6 +974,8 @@ static void arm_cpu_initfn(Object *obj)
>>>        if (tcg_enabled()) {
>>>            cpu->psci_version =3D 2; /* TCG implements PSCI 0.2 */
>>>        }
>>> +
>>> +    cpu->gt_cntfrq =3D NANOSECONDS_PER_SECOND / GTIMER_SCALE;
>>>    }
>>>   =20
>>>    static Property arm_cpu_reset_cbar_property =3D
>>> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
>>> index 83a809d4bac4..666c03871fdf 100644
>>> --- a/target/arm/cpu.h
>>> +++ b/target/arm/cpu.h
>>> @@ -932,8 +932,18 @@ struct ARMCPU {
>>>         */
>>>        DECLARE_BITMAP(sve_vq_map, ARM_MAX_VQ);
>>>        DECLARE_BITMAP(sve_vq_init, ARM_MAX_VQ);
>>> +
>>> +    /* Generic timer counter frequency, in Hz */
>>> +    uint64_t gt_cntfrq;
>>
>> You can also explicit the unit by calling it 'gt_cntfrq_hz'.
>=20
> Fair call, I'll fix that.
>=20
>>
>>>    };
>>>   =20
>>> +static inline unsigned int gt_cntfrq_period_ns(ARMCPU *cpu)
>>> +{
>>> +    /* XXX: Could include qemu/timer.h to get NANOSECONDS_PER_SECOND? =
*/
>>
>> Why inline this call? I doubt there is a significant performance gain.
>=20
> It wasn't so much performance. It started out as a macro for a simple cal=
culation
> because I didn't want to duplicate it across a number of places, then I w=
anted type
> safety for the pointer so  I switched the macro in the header to an inlin=
e function. So
> it is an evolution of the patch rather than something that came from an e=
xplicit goal
> of e.g. performance.

OK. Eventually NANOSECONDS_PER_SECOND will move to "qemu/units.h".

Should the XXX comment stay? I'm not sure, it is confusing.

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>


