Return-Path: <SRS0=/TnL=AT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 153ECC433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 23:35:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD9DA20708
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 23:35:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YQ4f36/4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD9DA20708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53890 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtJal-0006gw-55
	for qemu-devel@archiver.kernel.org; Wed, 08 Jul 2020 19:35:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36720)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1jtJZt-0005OB-FA
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 19:34:14 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:49169
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1jtJZr-0001zC-IU
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 19:34:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594251250;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LoifMGgxTePknvrNXEUK97vhczdQZqBwq4sKBctm3k4=;
 b=YQ4f36/4oahm+tccJgQJo5cUnOm4V9jOso+w2wzHUdKMRtNDgTUsJeDCZcKHomQzZnhIYb
 kVMXdIbz6WN72f2xPIAJTBmkHIwN/V5hAoAFrYFTHWzjZYnjLN8mUFZ53X/xcvVeIsx1OG
 x+VJweHgiTpuOQ34bUZwr/v5nbuhl94=
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com
 [209.85.166.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-50-y8r62kXkP2q1DpRQisa42g-1; Wed, 08 Jul 2020 03:30:49 -0400
X-MC-Unique: y8r62kXkP2q1DpRQisa42g-1
Received: by mail-io1-f71.google.com with SMTP id a10so5095727ioc.23
 for <qemu-devel@nongnu.org>; Wed, 08 Jul 2020 00:30:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=LoifMGgxTePknvrNXEUK97vhczdQZqBwq4sKBctm3k4=;
 b=UL4PV+faUTq+j24PIVR0eN3AtVE6F86oNCpWVmaq+XLvtvOIEpfDcEyHfwo/TJ3MZj
 th6LlDYKGT0LA5DsOZK1GKRDEnGQJH0QytRdxppoU/soI+T7zui+sVU2R6YD460tsELK
 JlOU9gDvpdcBGuUm3x3dezsR+MPEJPsZ9zGdqzYUziPDZboUJxw0Yy5Fmnsb413TSP/g
 Q7ZhzfQa4uF4JzTjK3iZS8UYaqGkbF4uRZ2qIR7j+a8ESK50+z5L/krL62RsFDRp9N+f
 C47LwNO12pbUsai3Oh2ssFL1IkSiamtqsYvmXSrlz9m/8nOptzmGWIQl5QjPBq7lyC7i
 h8fQ==
X-Gm-Message-State: AOAM530MJFGJ1sSyvd3LvOjn0YJa4Rf+ua8EQ0TAcrUtj46h+nsu5KX0
 iDd8pS7+9BeAqHXgXINqQDgEeQZv2FDVTRid/rrou1QNqa7i/UfbZvkxWZbxiCuxHPm0yCyQrpE
 xtVQDmDiA4n38WN8DkVB3tIKvz13m+Sw=
X-Received: by 2002:a05:6e02:e43:: with SMTP id
 l3mr38859753ilk.11.1594193448405; 
 Wed, 08 Jul 2020 00:30:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyNi/xpzmXoF7pj5Gou1pjaGUzRkj0ygB6dEC2GuwEP/Yh35Ia5fhV7j1ML2RbhDTc/n32L3eNrmalqXU298bg=
X-Received: by 2002:a05:6e02:e43:: with SMTP id
 l3mr38859731ilk.11.1594193448196; 
 Wed, 08 Jul 2020 00:30:48 -0700 (PDT)
MIME-Version: 1.0
References: <20200707201625.4177419-1-stefanb@linux.vnet.ibm.com>
 <20200707201625.4177419-3-stefanb@linux.vnet.ibm.com>
In-Reply-To: <20200707201625.4177419-3-stefanb@linux.vnet.ibm.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Wed, 8 Jul 2020 11:30:36 +0400
Message-ID: <CAMxuvawBjKum=0HD8pKUuZ-rqFKEt-=67MUZknq2N-h6Mo4GNA@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] tests: tpm: Skip over pcrUpdateCounter byte in
 result comparison
To: Stefan Berger <stefanb@linux.vnet.ibm.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mlureau@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.120; envelope-from=mlureau@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/07 17:25:11
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
Cc: Stefan Berger <stefanb@linux.ibm.com>, qemu-ppc <qemu-ppc@nongnu.org>,
 qemu-devel <qemu-devel@nongnu.org>, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jul 8, 2020 at 12:16 AM Stefan Berger
<stefanb@linux.vnet.ibm.com> wrote:
>
> The TPM 2 code in libtpms was fixed to handle the PCR 'TCB group' accordi=
ng
> to the PCClient profile. The change of the PCRs belonging to the 'TCB gro=
up'
> now affects the pcrUpdateCounter in the TPM2_PCRRead() responses where it=
s
> value is now different (typically lower by '1') than what it was before. =
To
> not fail the tests, we skip the comparison of the 14th byte, which
> represents the pcrUpdateCounter.
>
> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>  tests/qtest/tpm-util.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/tests/qtest/tpm-util.c b/tests/qtest/tpm-util.c
> index 34efae8f18..58a9593745 100644
> --- a/tests/qtest/tpm-util.c
> +++ b/tests/qtest/tpm-util.c
> @@ -139,7 +139,11 @@ void tpm_util_pcrread(QTestState *s, tx_func *tx,
>
>      tx(s, tpm_pcrread, sizeof(tpm_pcrread), buffer, sizeof(buffer));
>
> -    g_assert_cmpmem(buffer, exp_resp_size, exp_resp, exp_resp_size);
> +    /* skip pcrUpdateCounter (14th byte) in comparison */
> +    g_assert(exp_resp_size >=3D 15);
> +    g_assert_cmpmem(buffer, 13, exp_resp, 13);
> +    g_assert_cmpmem(&buffer[14], exp_resp_size - 14,
> +                    &exp_resp[14], exp_resp_size - 14);
>  }
>
>  bool tpm_util_swtpm_has_tpm2(void)
> --
> 2.24.1
>


