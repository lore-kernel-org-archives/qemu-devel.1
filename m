Return-Path: <SRS0=6OCO=YI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2829ECE58C
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2019 18:56:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8AE6320663
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2019 18:56:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="o4LszdTq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8AE6320663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56396 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iKRzq-0002Ce-Ll
	for qemu-devel@archiver.kernel.org; Tue, 15 Oct 2019 14:56:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35377)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iKRyX-0001fo-4p
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 14:55:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iKRyV-0007bz-RM
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 14:55:16 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:37665)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iKRyV-0007bO-8M
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 14:55:15 -0400
Received: by mail-wr1-x443.google.com with SMTP id p14so25137482wro.4
 for <qemu-devel@nongnu.org>; Tue, 15 Oct 2019 11:55:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=uowN7Jvg9YZ/oWPNZRyoPfxI//fH3KolMkG6kf/X5SQ=;
 b=o4LszdTq5d3LXqv6fUcHayjR5Ds7JP0WEB1cVrSWZ7q9imjgzryEoBG+PbrmLdem4t
 w35nB9aA6Pdt1rq8jpEhBCFAvmfl/hEjrdFxZlm5jucXR3+Sw7g8V5yMFsNeo0hklwvp
 8NpupLnlsd0+TEgbqzBvo5/qZnw/jA1khGc34SL8fx5TdNKxadBNTAEqc/vzn4shWMEW
 QMIq9sFqI6Ms0ll6R52YntVkmVgb730Hkf7VCs1oPIQWCH4jpx3pB7SiwldFmAQgP8V/
 G+owT0Ba8Ia+INn4yujVCt57g0rplw9SXJUcc9F5VOEJH4xhjbhUptZDFlHpPLqH8QC0
 OJvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=uowN7Jvg9YZ/oWPNZRyoPfxI//fH3KolMkG6kf/X5SQ=;
 b=SuFgb7M8PrybEcp94+z6qgB+NdteEhSLhYL91JAcsuV+RnaI3n3MYiL9WkCLHrjSvS
 sqvJCJ+3ky2VOqcFNMS9K9zn2HseILoV88LdyiyqJUryVSV3InpWaj9mPEo6eWzRgpzU
 DBNgLH05sDCrQjaIMKjoXN0wcrNVrCAQbSCpIMWOzzZQT3anN30UhbIEC7cAHVBxWgtW
 CAewty2PaRTR454EMWP/CgIKUa6QUhBMI2nQyqTfakLt8/Kr3+c4vGrNjCUxzfWuPKSV
 WK8Vl0XVX0Ln0bbXMpxUKtuUFo0+H82zt/vXLMcpxAX12Zz+Fk/nUV2ak9zQ+VvhD8UF
 Gd4A==
X-Gm-Message-State: APjAAAXJQmb2DTkhynDDdMVmuZztY4aGrv7muQE9kXZ/4CirSf6AYNZT
 2ZTTaNHqEePIIDwoJ41nnch3cQ==
X-Google-Smtp-Source: APXvYqyQnTAwJcINFtBLBpaeX3PbZEmM+a4Gj6m3fx79UbHayNfTxvWwltdAjZyExfesw6OSqJtPqw==
X-Received: by 2002:adf:fac2:: with SMTP id a2mr30500233wrs.290.1571165713857; 
 Tue, 15 Oct 2019 11:55:13 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id g1sm19718338wrv.68.2019.10.15.11.55.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Oct 2019 11:55:12 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 083411FF87;
 Tue, 15 Oct 2019 19:55:12 +0100 (BST)
References: <20191014104948.4291-1-alex.bennee@linaro.org>
 <20191014104948.4291-24-alex.bennee@linaro.org>
 <CAFEAcA-PJ8V4to4SKu6PXZH6yFkrQ7FJBZR=2O-fJFoZgEq=TQ@mail.gmail.com>
User-agent: mu4e 1.3.5; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH v5 23/55] translator: add translator_ld{ub,sw,uw,l,q}
In-reply-to: <CAFEAcA-PJ8V4to4SKu6PXZH6yFkrQ7FJBZR=2O-fJFoZgEq=TQ@mail.gmail.com>
Date: Tue, 15 Oct 2019 19:55:11 +0100
Message-ID: <87zhi1ltyo.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
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
Cc: robert.foley@futurewei.com,
 Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, peter.puhov@futurewei.com,
 Aaron Lindsay <aaron@os.amperecomputing.com>,
 "Emilio G. Cota" <cota@braap.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Peter Maydell <peter.maydell@linaro.org> writes:

> On Mon, 14 Oct 2019 at 12:38, Alex Benn=C3=A9e <alex.bennee@linaro.org> w=
rote:
>>
>> From: "Emilio G. Cota" <cota@braap.org>
>>
>> We don't bother with replicating the fast path (tlb_hit) of the old
>> cpu_ldst helpers as it has no measurable effect on performance. This
>> probably indicates we should consider flattening the whole set of
>> helpers but that is out of scope for this change.
>>
>> Suggested-by: Richard Henderson <richard.henderson@linaro.org>
>> Signed-off-by: Emilio G. Cota <cota@braap.org>
>> [AJB: directly plumb into softmmu/user helpers]
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>>
>> diff --git a/tcg/tcg.h b/tcg/tcg.h
>> index a38659ea5b..302533b463 100644
>> --- a/tcg/tcg.h
>> +++ b/tcg/tcg.h
>> @@ -1317,6 +1317,7 @@ uint64_t helper_be_ldq_cmmu(CPUArchState *env, tar=
get_ulong addr,
>>  # define helper_ret_stl_mmu   helper_be_stl_mmu
>>  # define helper_ret_stq_mmu   helper_be_stq_mmu
>>  # define helper_ret_ldw_cmmu  helper_be_ldw_cmmu
>> +# define helper_ret_lduw_cmmu helper_be_ldw_cmmu
>>  # define helper_ret_ldl_cmmu  helper_be_ldl_cmmu
>>  # define helper_ret_ldq_cmmu  helper_be_ldq_cmmu
>>  #else
>> @@ -1330,6 +1331,7 @@ uint64_t helper_be_ldq_cmmu(CPUArchState *env, tar=
get_ulong addr,
>>  # define helper_ret_stl_mmu   helper_le_stl_mmu
>>  # define helper_ret_stq_mmu   helper_le_stq_mmu
>>  # define helper_ret_ldw_cmmu  helper_le_ldw_cmmu
>> +# define helper_ret_lduw_cmmu helper_le_ldw_cmmu
>>  # define helper_ret_ldl_cmmu  helper_le_ldl_cmmu
>>  # define helper_ret_ldq_cmmu  helper_le_ldq_cmmu
>>  #endif
>
> This looks odd. Why is it ok to define a 'lduw' helper
> as the 'ldw' cmmu helper ? One ought to be sign
> extending and the other not...

This was attempting to make things line up between the softmmu helpers
and the user-mode ld*_p helpers that we need to expand to. I'm not sure
a sign extending loader even makes sense for code load anyway.

>
> thanks
> -- PMM


--
Alex Benn=C3=A9e

