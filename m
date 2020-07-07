Return-Path: <SRS0=B5/Q=AS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1A1AC433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 13:25:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D12F20771
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 13:25:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="azNF5n8j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D12F20771
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59450 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsnbV-0006q2-RC
	for qemu-devel@archiver.kernel.org; Tue, 07 Jul 2020 09:25:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46660)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jsnas-00064k-Ru
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 09:25:06 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:23329
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jsnaq-0001dS-Ep
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 09:25:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594128302;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=eNyxHh6ymHX+vtkh8Oj+PdQUbLl7sqYUzIQHCG0rxq4=;
 b=azNF5n8jGCGJkoZTpo67UEmABrRJodkmH1pofdrW/Sp872aGVtLXtS4mkOfds2kJe8A9Sk
 fOpNJBt/XmAHIwYqWq1YLqpJEcp78IEDkSXFjodQKESpy9iv2EcORx4TW4KH8frtbcpr/t
 GajgH2nJJIzLnSKthhbvn2UxI3KVRO8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-417-pj1B0ZslMc-MkXeVqxpvrg-1; Tue, 07 Jul 2020 09:25:01 -0400
X-MC-Unique: pj1B0ZslMc-MkXeVqxpvrg-1
Received: by mail-wm1-f70.google.com with SMTP id g187so52575203wme.0
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2020 06:25:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=eNyxHh6ymHX+vtkh8Oj+PdQUbLl7sqYUzIQHCG0rxq4=;
 b=p1zVxWCQMTzfhnbRuZLowjCAlQCOOhcot+FXbadDJOboy72rpJR+5EO2LZAElaKISK
 tAgOmgfJ8FxDZfBDMXXRun2Y2hPCoKyvZp0nY08hBt+ckhNyhvb8eiJmxstCqVO2JzVE
 jiLiy4EeV7yl2O/SNUFdV2/Bc48Xv3J+ShT704+tyhYIh8QFRD2m7SU5PUigpUnP/j+l
 1oi1HKv5heMQqMuN673rXRkX1+tZGuH4l4fZJm9YrwXSnWwJ9iJzrxxtgE7ETXXYJWaT
 xCSpVubC44tz/5zp8lsSX1y3QOtD+YmZRdMCN3s4kuTGINuuIUWbmsW5xHDrSinMEATl
 AyQw==
X-Gm-Message-State: AOAM533kLrqukssNZtcM0Q5/snkJG/HOaKkH6axDOoEPPcfGT6+Gjh0n
 2gMhCLj+XXgQiZu2vBTVqfexevcnl+XSGedFygVwDJN4VZN6+44I3/VFNZW3HcZpIIIRYxqwx4/
 QKtK5lkJ+xa/XYCI=
X-Received: by 2002:a1c:c38a:: with SMTP id t132mr4099118wmf.1.1594128300127; 
 Tue, 07 Jul 2020 06:25:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzDJ7eQtU7C0ynKH2q6fc+A59RaOtNDnZ04pT94+BTcPu8Ytw1dfCwmBxarBKy7d8Ifvtw5Tw==
X-Received: by 2002:a1c:c38a:: with SMTP id t132mr4099101wmf.1.1594128299935; 
 Tue, 07 Jul 2020 06:24:59 -0700 (PDT)
Received: from [192.168.1.36] (138.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id n16sm1025353wrq.39.2020.07.07.06.24.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Jul 2020 06:24:59 -0700 (PDT)
Subject: Re: [PATCH v2 1/2] tpm: tpm_spapr: Exit on TPM backend failures
To: Stefan Berger <stefanb@linux.ibm.com>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>, qemu-ppc@nongnu.org,
 marcandre.lureau@redhat.com
References: <20200707040522.4013885-1-stefanb@linux.vnet.ibm.com>
 <20200707040522.4013885-2-stefanb@linux.vnet.ibm.com>
 <aa63c5f3-308e-59e1-11ff-0e0d923658e8@redhat.com>
 <b974cd46-3902-3124-302d-ffa2a1120905@linux.ibm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Autocrypt: addr=philmd@redhat.com; keydata=
 mQINBDXML8YBEADXCtUkDBKQvNsQA7sDpw6YLE/1tKHwm24A1au9Hfy/OFmkpzo+MD+dYc+7
 bvnqWAeGweq2SDq8zbzFZ1gJBd6+e5v1a/UrTxvwBk51yEkadrpRbi+r2bDpTJwXc/uEtYAB
 GvsTZMtiQVA4kRID1KCdgLa3zztPLCj5H1VZhqZsiGvXa/nMIlhvacRXdbgllPPJ72cLUkXf
 z1Zu4AkEKpccZaJspmLWGSzGu6UTZ7UfVeR2Hcc2KI9oZB1qthmZ1+PZyGZ/Dy+z+zklC0xl
 XIpQPmnfy9+/1hj1LzJ+pe3HzEodtlVA+rdttSvA6nmHKIt8Ul6b/h1DFTmUT1lN1WbAGxmg
 CH1O26cz5nTrzdjoqC/b8PpZiT0kO5MKKgiu5S4PRIxW2+RA4H9nq7nztNZ1Y39bDpzwE5Sp
 bDHzd5owmLxMLZAINtCtQuRbSOcMjZlg4zohA9TQP9krGIk+qTR+H4CV22sWldSkVtsoTaA2
 qNeSJhfHQY0TyQvFbqRsSNIe2gTDzzEQ8itsmdHHE/yzhcCVvlUzXhAT6pIN0OT+cdsTTfif
 MIcDboys92auTuJ7U+4jWF1+WUaJ8gDL69ThAsu7mGDBbm80P3vvUZ4fQM14NkxOnuGRrJxO
 qjWNJ2ZUxgyHAh5TCxMLKWZoL5hpnvx3dF3Ti9HW2dsUUWICSQARAQABtDJQaGlsaXBwZSBN
 YXRoaWV1LURhdWTDqSAoUGhpbCkgPHBoaWxtZEByZWRoYXQuY29tPokCVQQTAQgAPwIbDwYL
 CQgHAwIGFQgCCQoLBBYCAwECHgECF4AWIQSJweePYB7obIZ0lcuio/1u3q3A3gUCXsfWwAUJ
 KtymWgAKCRCio/1u3q3A3ircD/9Vjh3aFNJ3uF3hddeoFg1H038wZr/xi8/rX27M1Vj2j9VH
 0B8Olp4KUQw/hyO6kUxqkoojmzRpmzvlpZ0cUiZJo2bQIWnvScyHxFCv33kHe+YEIqoJlaQc
 JfKYlbCoubz+02E2A6bFD9+BvCY0LBbEj5POwyKGiDMjHKCGuzSuDRbCn0Mz4kCa7nFMF5Jv
 piC+JemRdiBd6102ThqgIsyGEBXuf1sy0QIVyXgaqr9O2b/0VoXpQId7yY7OJuYYxs7kQoXI
 6WzSMpmuXGkmfxOgbc/L6YbzB0JOriX0iRClxu4dEUg8Bs2pNnr6huY2Ft+qb41RzCJvvMyu
 gS32LfN0bTZ6Qm2A8ayMtUQgnwZDSO23OKgQWZVglGliY3ezHZ6lVwC24Vjkmq/2yBSLakZE
 6DZUjZzCW1nvtRK05ebyK6tofRsx8xB8pL/kcBb9nCuh70aLR+5cmE41X4O+MVJbwfP5s/RW
 9BFSL3qgXuXso/3XuWTQjJJGgKhB6xXjMmb1J4q/h5IuVV4juv1Fem9sfmyrh+Wi5V1IzKI7
 RPJ3KVb937eBgSENk53P0gUorwzUcO+ASEo3Z1cBKkJSPigDbeEjVfXQMzNt0oDRzpQqH2vp
 apo2jHnidWt8BsckuWZpxcZ9+/9obQ55DyVQHGiTN39hkETy3Emdnz1JVHTU0Q==
Message-ID: <6b8d9e27-64a5-cea6-5680-bc7e36aafb90@redhat.com>
Date: Tue, 7 Jul 2020 15:24:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <b974cd46-3902-3124-302d-ffa2a1120905@linux.ibm.com>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/07 00:46:09
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: qemu-devel@nongnu.org, david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/7/20 2:52 PM, Stefan Berger wrote:
> On 7/7/20 12:20 AM, Philippe Mathieu-Daudé wrote:
>> Hi Stefan,
>>
>> On 7/7/20 6:05 AM, Stefan Berger wrote:
>>> Exit on TPM backend failures in the same way as the TPM CRB and TIS
>>> device
>>> models do.
>> Maybe the other models are not the best examples ;)
> 
> At least they are known to report the error...
> 
> 
>>
>>> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
>>> ---
>>>   hw/tpm/tpm_spapr.c | 5 ++++-
>>>   1 file changed, 4 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/hw/tpm/tpm_spapr.c b/hw/tpm/tpm_spapr.c
>>> index cb4dfd1e6a..8288ab0a15 100644
>>> --- a/hw/tpm/tpm_spapr.c
>>> +++ b/hw/tpm/tpm_spapr.c
>>> @@ -306,7 +306,10 @@ static void tpm_spapr_reset(SpaprVioDevice *dev)
>>>                               TPM_SPAPR_BUFFER_MAX);
>>>         tpm_backend_reset(s->be_driver);
>>> -    tpm_spapr_do_startup_tpm(s, s->be_buffer_size);
>>> +
>>> +    if (tpm_spapr_do_startup_tpm(s, s->be_buffer_size) < 0) {
>> I don't see error reported, how users can know the cause of the exit?
> 
> 
> virt-manager does report the error then. It seems to be taking it from
> the last error message reported in the emulator backend when TPM_INIT
> fails with error code 0x101:
> 
> error: internal error: qemu unexpectedly closed the monitor:
> 2020-07-07T12:49:28.333928Z qemu-system-ppc64: tpm-emulator: TPM result
> for CMD_INIT: 0x101 operation failed

Ah, good.

> 
>>
>>> +        exit(1);
>> What about using this instead?
>>
>>             qemu_system_shutdown_request(SHUTDOWN_CAUSE_HOST_ERROR);
> 
> It doesn't have any effect, the VM just keeps on running. So the exit(1)
> is better and does report an error.
> 

Hmm maybe something is missing or it was never totally implemented?

Anyway since virt-manager is notified, I'm not objecting to this patch
:)


