Return-Path: <SRS0=/hVT=5E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFDBFC4332B
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2020 02:32:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 99E2F20768
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2020 02:32:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YKh6u5eH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99E2F20768
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60842 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEkyt-0005U7-NC
	for qemu-devel@archiver.kernel.org; Wed, 18 Mar 2020 22:32:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50124)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <npiggin@gmail.com>) id 1jEkyC-00051e-Aa
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 22:31:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <npiggin@gmail.com>) id 1jEkyB-0005kO-7B
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 22:31:40 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:33610)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <npiggin@gmail.com>)
 id 1jEkyB-0005e5-0p; Wed, 18 Mar 2020 22:31:39 -0400
Received: by mail-pf1-x442.google.com with SMTP id n7so568529pfn.0;
 Wed, 18 Mar 2020 19:31:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:subject:to:cc:references:in-reply-to:mime-version
 :user-agent:message-id:content-transfer-encoding;
 bh=DDdJXlIjlTtgBVSTfndIqTJktubVppTBBfGg8u1UrF8=;
 b=YKh6u5eH3DkzDPGq5KUfW6SQGKEg0YSieDNVXNpvFrrieGMI9XXOAdckZOhzX7Oizr
 tBlMno/9Fliw0E915wbkmJau6coVHbAXRWj9dMKzmwkSjxcl0n4+PuCbJwR+jFU1owFl
 W46Wgzfj1nQHYuozrwWdjMXFPnWo52xRTxL0Sg0QvyVeaTOjlaWjZPGn6juAQN+FBChD
 8UkYUXFwhEE0EpKppi1f93gi9tXT1ejwB7R8IFWiZcSYabaIa9qqduXxGhPaT8usUyF2
 Ebz5QmXrUKuw0Bn9fpRFL2uC43YJNPUiGpnkqYb9hfvEIxVt8veTyfFSdirqYJcBquDT
 cmDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
 :mime-version:user-agent:message-id:content-transfer-encoding;
 bh=DDdJXlIjlTtgBVSTfndIqTJktubVppTBBfGg8u1UrF8=;
 b=ewlgU/6TRfQy51GUg2vsJ2aZtguroFyH+Z+Y897986YYvLN+RoPFeWuGVbVWU2uKOD
 gK2mWBTatIifTPnOY4FlSZx+fhZGdvHAn8K2wwPHuquB1kPPmIu3qcRT8VIVYEfS6zkr
 YCsix+wt+YCVB8nN8Lb5apQI3GfNiwUMTy2i1neBAYWuoTm4JRbpP3ewzpZkVGe/xZzE
 v9ar2vK71H+eniPdVD5UmoLJFKcldGprN/v1P/pS5/KGwRgUNbdQYY5QjVakiV+9o9ne
 Ak5CCUvnVnhB4kyhNeiDejU6QfdhmC1pAcjv3m47voxpol0xdRUUg4Ohu0U035KR0b47
 b8Tg==
X-Gm-Message-State: ANhLgQ0dzqHc9/hSUYgQudcAmi5DZ1zDu8AfRQAxMeljB8aSqQ2yIbZm
 jK6JuG2nS+HiS31dudSmms8=
X-Google-Smtp-Source: ADFU+vswwr/HJ/0CvW0damk3EHJcUQmsM7jfQW3Sp2vSOhvXtBR399KhLIvMmN/av/YhymQ87MU+6g==
X-Received: by 2002:a63:4752:: with SMTP id w18mr821274pgk.379.1584585097840; 
 Wed, 18 Mar 2020 19:31:37 -0700 (PDT)
Received: from localhost (14-202-190-183.tpgi.com.au. [14.202.190.183])
 by smtp.gmail.com with ESMTPSA id q9sm341343pgs.89.2020.03.18.19.31.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Mar 2020 19:31:37 -0700 (PDT)
Date: Thu, 19 Mar 2020 12:29:48 +1000
From: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH 4/5] ppc/spapr: Don't kill the guest if a recovered FWNMI
 machine check delivery fails
To: Greg Kurz <groug@kaod.org>
References: <20200317050215.159334-1-npiggin@gmail.com>
 <20200317050215.159334-5-npiggin@gmail.com>
 <20200317175724.711884d5@bahia.lan>
In-Reply-To: <20200317175724.711884d5@bahia.lan>
MIME-Version: 1.0
User-Agent: astroid/0.15.0 (https://github.com/astroidmail/astroid)
Message-Id: <1584584910.lak7pp7qkv.astroid@bobo.none>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::442
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
Cc: Aravinda Prasad <arawinda.p@gmail.com>,
 Alexey Kardashevskiy <aik@ozlabs.ru>,
 Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>, qemu-devel@nongnu.org,
 =?iso-8859-1?q?C=E9dric_Le=0A?= Goater <clg@fr.ibm.com>,
 Ganesh Goudar <ganeshgr@linux.ibm.com>, qemu-ppc@nongnu.org,
 =?iso-8859-1?q?David=0A?= Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Greg Kurz's on March 18, 2020 2:57 am:
> On Tue, 17 Mar 2020 15:02:14 +1000
> Nicholas Piggin <npiggin@gmail.com> wrote:
>=20
>> Try to be tolerant of errors if the machine check had been recovered
>> by the host.
>>=20
>> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
>> ---
>=20
> Same comment as previous patch on multi-line error strings and
> warn_report() in the !recovered case.
>=20
>>  hw/ppc/spapr_events.c | 25 ++++++++++++++++++-------
>>  1 file changed, 18 insertions(+), 7 deletions(-)
>>=20
>> diff --git a/hw/ppc/spapr_events.c b/hw/ppc/spapr_events.c
>> index d35151eeb0..3f524cb0ca 100644
>> --- a/hw/ppc/spapr_events.c
>> +++ b/hw/ppc/spapr_events.c
>> @@ -807,13 +807,20 @@ static void spapr_mce_dispatch_elog(PowerPCCPU *cp=
u, bool recovered)
>>      /* get rtas addr from fdt */
>>      rtas_addr =3D spapr_get_rtas_addr();
>>      if (!rtas_addr) {
>> -        warn_report("FWNMI: Unable to deliver machine check to guest: "
>> -                    "rtas_addr not found.");
>> -        qemu_system_guest_panicked(NULL);
>> +        if (!recovered) {
>> +            warn_report("FWNMI: Unable to deliver machine check to gues=
t: "
>> +                        "rtas_addr not found.");
>> +            qemu_system_guest_panicked(NULL);
>> +        } else {
>> +            warn_report("FWNMI: Unable to deliver machine check to gues=
t: "
>> +                        "rtas_addr not found. Machine check recovered."=
);
>> +        }
>>          g_free(ext_elog);
>>          return;
>>      }
>> =20
>> +    spapr->fwnmi_machine_check_interlock =3D cpu->vcpu_id;
>> +
>=20
> I don't understand this change.

If we bail out without delivering the interrupt, we can't take the
interlock otherwise the guest can never release it.

Thanks,
Nick
=

