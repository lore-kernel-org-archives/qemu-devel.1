Return-Path: <SRS0=e3er=AV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D418C433E5
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 13:27:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF5D9207DF
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 13:27:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ezlCpgRe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF5D9207DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36100 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtt4H-00016L-N7
	for qemu-devel@archiver.kernel.org; Fri, 10 Jul 2020 09:27:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49898)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jtsot-0004Nc-VO
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 09:12:03 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:21792
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jtsop-0001jJ-QC
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 09:12:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594386718;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=JuTmDEshOYBkfZZzsJnqpBp+8KLaVBqsoCELSDAKmBg=;
 b=ezlCpgReIRAGhYW9EcWRGQchYpMpGTlgdaURxNdR+zeCmEbQalsd9mcf3e/Z9Vz9yz3Gen
 Hev+UEyJMlNEu1NR3VHMn1M9o6w63oBUTEBTzxRZAkC0olesY1+3yfi8chK6/jK7uN85Ot
 5SUdv4BFJpBHhVWLXZ7LMWeJixuf1bk=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-291-v9KMrYjdPtyTTngEsMPW2g-1; Fri, 10 Jul 2020 09:11:53 -0400
X-MC-Unique: v9KMrYjdPtyTTngEsMPW2g-1
Received: by mail-wr1-f70.google.com with SMTP id o25so6010122wro.16
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2020 06:11:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=JuTmDEshOYBkfZZzsJnqpBp+8KLaVBqsoCELSDAKmBg=;
 b=M6GwN9pU6sow6/v4+vthAZOPZlC9C0uIaHfJAFW7COJ1QoiP3tiIjh/g06707wPZH5
 W8jdP6YFkuhd1RDi9jA50vnwKugKnNEd1ws5BPunUUt7P76skABzhZtkHWFaNIDc/6Qu
 kphG/UE0JKOL0BhXgqs14oxemFq6qYR9K0UADmP0LKTlB4f1vyxdZoudHyVmfb2vHN+G
 Ma+nf4dBbcLU9eL966ha1lOAhHwhFUaKt+1MBssCKSrw3yeWQmz+dK7pFZMaG7XMzx0E
 91lYAo262yCYcmAEleCNm+8xLBaYPlymCr0I0raz7ans10RdpS2f5J4RvXiUHFD6pNZQ
 5eZA==
X-Gm-Message-State: AOAM5307RGmToIr161MBuGO2bRg4uo8SkpPjxU2qJgiOqFnieImfiTrf
 R8nRyCUbVREn3Ep7ekIG/0MZ6drY2FSHpOQbw9wIawQoiSRVt68q6Mabntl7pCDE8hf0Rped3Az
 TAT/gDi8Of+uo0Wo=
X-Received: by 2002:a5d:4283:: with SMTP id k3mr66815785wrq.322.1594386711519; 
 Fri, 10 Jul 2020 06:11:51 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzFpLrMDrBqdYLcFoIGNH+brrlWjrqZWrc7ZpSSKtcyv2oxN/4CPbXScx/g1S/5nQRko5aNEg==
X-Received: by 2002:a5d:4283:: with SMTP id k3mr66815758wrq.322.1594386711254; 
 Fri, 10 Jul 2020 06:11:51 -0700 (PDT)
Received: from [192.168.1.37] (138.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id t141sm10270725wmt.26.2020.07.10.06.11.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 10 Jul 2020 06:11:50 -0700 (PDT)
Subject: Re: [PULL v2 00/52] Misc patches for QEMU 5.1 soft freeze
To: Peter Maydell <peter.maydell@linaro.org>,
 Claudio Fontana <cfontana@suse.de>
References: <20200708172542.25012-1-pbonzini@redhat.com>
 <CAFEAcA8b6sn8fXOKwqOF6MvsKT5oKqS+4jjYDPAPvnXmVimLiQ@mail.gmail.com>
 <9631042d-00e4-2a2e-292b-66ca1b590120@suse.de>
 <CAFEAcA-UbHpj_xSbqjTsaURt8yPZjuYOmd3pe97vg_G7--17Cw@mail.gmail.com>
 <e78820bb-af5f-c2a0-7727-1a0caedfa584@suse.de>
 <CAFEAcA-raDJ2pSUG-OYHcJi_LnQwxMHvcyjsD7+=WxGYcrSz3w@mail.gmail.com>
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
Message-ID: <a8113ed1-c508-0502-4f88-77f875d1a739@redhat.com>
Date: Fri, 10 Jul 2020 15:11:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-raDJ2pSUG-OYHcJi_LnQwxMHvcyjsD7+=WxGYcrSz3w@mail.gmail.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/09 23:35:58
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/10/20 2:55 PM, Peter Maydell wrote:
> On Fri, 10 Jul 2020 at 13:52, Claudio Fontana <cfontana@suse.de> wrote:
>> If you can access it,
>>
>> https://cirrus-ci.com/task/5537514263937024?command=main#L2039
>>
>> the thing is treated here as a warning, which is in the middle of a large amount of other warnings.
>>
>> private/var/folders/3y/l0z1x3693dl_8n0qybp4dqwh0000gn/T/cirrus-ci-build/ui/vnc-auth-sasl.c:648:29: warning: 'sasl_errdetail' is deprecated: first deprecated in macOS 10.11 [-Wdeprecated-declarations]
>>                             sasl_errdetail(vs->sasl.conn));
>>
>> /* ... lots of similar warnings */
>>
>> private/var/folders/3y/l0z1x3693dl_8n0qybp4dqwh0000gn/T/cirrus-ci-build/ui/cocoa.m:1478:9: warning: implicit declaration of function 'cpu_throttle_set' is invalid in C99 [-Wimplicit-function-declaration]
>>         cpu_throttle_set(throttle_pct);
>>         ^
>>
>>
>> Apparently the cirrus-ci I am using is not treating this as an error, while what you are using is..
> 
> Ah, I see. Yeah, configure by default doesn't enable -Werror for OSX.
> My build tree has
>  '--extra-cflags=-fdiagnostics-color=never -Werror
> -Wno-error=deprecated-declarations'

TIL this is different on OSX...

> 
> (of which the last two are relevant here). We should probably
> make configure use -Werror on OSX now with the same logic as Linux,
> I've been using it that way for ages without issues.

Yes please!


