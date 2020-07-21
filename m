Return-Path: <SRS0=zL9l=BA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA9F7C433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2020 08:35:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B069D20709
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2020 08:35:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LOKxsoOb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B069D20709
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55132 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jxnjp-0002k0-02
	for qemu-devel@archiver.kernel.org; Tue, 21 Jul 2020 04:35:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40988)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jxniu-0001TW-Jk
 for qemu-devel@nongnu.org; Tue, 21 Jul 2020 04:34:04 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:38449
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jxnis-00085P-T6
 for qemu-devel@nongnu.org; Tue, 21 Jul 2020 04:34:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595320440;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=0mo9FJd1FFZJhIubUUo9UhweUi0S1u9RMig2Mv3FpQ0=;
 b=LOKxsoObhUl2qcZJ4awPXVP59ksUjvssjLjzf93PQACv8RUeFY6UBVKQh19QvDCSWQ7Up+
 AnSbMpm8YEKM/NyyLKtjl1j5F2A8CcV+FnByq5RscICR5ye/GbyRRXRA7dlFNl1lm+w/we
 KBy2NRVjXuohVAUb6c6xRAJ45++yXOU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-428-T1VYdZMJPgSnXAsKRfk_rw-1; Tue, 21 Jul 2020 04:33:58 -0400
X-MC-Unique: T1VYdZMJPgSnXAsKRfk_rw-1
Received: by mail-wm1-f69.google.com with SMTP id g138so729003wme.7
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2020 01:33:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=0mo9FJd1FFZJhIubUUo9UhweUi0S1u9RMig2Mv3FpQ0=;
 b=gvqF00q15IvDPOhkrqm9RNUsoiqpK/wchlkRHe/JnwVWeGa2042cPnijbgETgwFGX8
 wsSL8j9iv2Y0qq3fLtHbSqIeIIctyWozEZeCXt4xE34BcBMg9MmJBw83RRMAvODtu4Fi
 182byfC12gxMWRxbAtO8coovdcxLI/+MQ4kLeJlFLPEDqkvDBiBqpwaY/F6R0p8o0cSS
 aHGAU0u1ZlJg4zB1FpJdfaC7zvi5MBO+BIckMdFBgS9MU8XrqD4jtI3v3A55LXD9I8cc
 RLlJGYj+1lECeVFDm8JmjN2axS8Gtd/zmbPudh6Xoau2SrsUUt8mQpBrMJn87NjFT2/7
 D+vg==
X-Gm-Message-State: AOAM533KNk6h9FdltIyh6UV5imBruvEuOgYJdSvqFw9IuT3CX/eoSKVy
 6LtrgyCaBKlUovOo0VoV708EGHTQZRJeABufaeS1fQAdmnSMovO2/atRjuzJDbQZSFN/cKZERWz
 z39ZR7sUWiwOMq+U=
X-Received: by 2002:a5d:4051:: with SMTP id w17mr24562979wrp.183.1595320437476; 
 Tue, 21 Jul 2020 01:33:57 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwQ6bGlKYh8U1vdqoHmHNRp5ZGHufKWdQLVv9QCpza1zvprjaFndwdY0yiHwaqITtY1XCP3MA==
X-Received: by 2002:a5d:4051:: with SMTP id w17mr24562961wrp.183.1595320437274; 
 Tue, 21 Jul 2020 01:33:57 -0700 (PDT)
Received: from [192.168.1.37] (138.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id l14sm37430966wrn.18.2020.07.21.01.33.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Jul 2020 01:33:56 -0700 (PDT)
Subject: Re: [PATCH v2 5/9] nvram: add nrf51_soc flash read method
To: P J P <ppandit@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
References: <20200624185523.762240-1-ppandit@redhat.com>
 <20200624185523.762240-6-ppandit@redhat.com>
 <CAKXe6SKBYpdouoN=C_NZawLOnDMYjDU2X3c2CsCv7X7rPym1Rg@mail.gmail.com>
 <CAFEAcA8s8-OCmKEJsp6bJXBXH+JiyxrtSbHPiLimCj8+xz3obw@mail.gmail.com>
 <nycvar.YSQ.7.78.906.2007211212380.4380@xnncv>
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
Message-ID: <03c8f705-9e6c-9369-c547-eb09ede77fc1@redhat.com>
Date: Tue, 21 Jul 2020 10:33:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <nycvar.YSQ.7.78.906.2007211212380.4380@xnncv>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/21 01:30:29
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
Cc: Li Qiang <liq3ea@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Lei Sun <slei.casper@gmail.com>, Alex Williamson <alex.williamson@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/21/20 8:47 AM, P J P wrote:
> +-- On Thu, 16 Jul 2020, Peter Maydell wrote --+
> | > P J P <ppandit@redhat.com> ���2020���6���25��������� ������3:01���������
> | > > +static uint64_t flash_read(void *opaque, hwaddr offset, unsigned size)
> | > > +{
> | > > +    NRF51NVMState *s = NRF51_NVM(opaque);
> | > > +
> | > > +    assert(offset + size <= s->flash_size);
> | > > +    return ldl_le_p(s->storage + offset);
> | > > +}
> | >
> | > The 'flash_ops' is for ROM, though I don't see where it calls 
> | > 'memory_region_rom_device_set_romd' to ROMD, so this MR is in MMIO mode 
> | > and it needs a read callback.
> | 
> | I think that 'romd mode' (ie reads-go-directly-to-RAM) is the default: 
> | memory_region_initfn() sets romd_mode to true. So unless the device actively 
> | calls memory_region_rom_device_set_romd(mr, false) then the read callback 
> | can't be reached.
> 
> So, we go with g_assert_not_reached() ? We seem to have differing opinions 
> about these callbacks.

- Callback missing because we neglected to implement the
  hardware behavior:

  => qemu_log_mask(LOG_UNIMP, ...)

- Callback missing because the access is illegal on hardware
  (write on read-only register, read on write-only register):

  => qemu_log_mask(LOG_GUEST_ERROR, ...)

- Impossible situation unrelated to the hardware/guest behavior
  (problem in QEMU design)

  => g_assert_not_reached()


Note, when we runs QEMU with LOG_UNIMP/LOG_GUEST_ERROR enabled,
we are usually interested in what address the guest is accessing,
and in the write case, what value is written.

> 
> Thank you.
> --
> Prasad J Pandit / Red Hat Product Security Team
> 8685 545E B54C 486B C6EB 271E E285 8B5A F050 DE8D
> 


