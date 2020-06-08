Return-Path: <SRS0=zEF8=7V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E47C5C433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 17:39:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ADD16208A9
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 17:39:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iabRwTaJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADD16208A9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40338 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jiLjn-0005Sn-Q7
	for qemu-devel@archiver.kernel.org; Mon, 08 Jun 2020 13:39:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51674)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jiLiP-0004SH-O6
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 13:37:42 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:45984
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jiLiO-0000Kb-U0
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 13:37:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591637860;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=IaI75RxTU9jtVvOtNWo4VByTn1tODzTplByzyDcoNo8=;
 b=iabRwTaJBVG0hrKDj7zk4l1xsBtrGgoP1ChUlUisuNoTSeclW2w0Bz+BIqHKiBZp7uwr8S
 lHLPwDSaDcNzQ8JeM/aRfG+zRtyRasyFdHl1ovKJOpSErg/05ZWQ8MzQp2+ZXqK0lLLoeb
 /AA9dPcmHaAkDsMn8ODzSLlYb4Ixjms=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-481-Ruye6tzLPuWCQvs7PyRk6g-1; Mon, 08 Jun 2020 13:37:36 -0400
X-MC-Unique: Ruye6tzLPuWCQvs7PyRk6g-1
Received: by mail-wm1-f72.google.com with SMTP id j128so60937wmj.6
 for <qemu-devel@nongnu.org>; Mon, 08 Jun 2020 10:37:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=IaI75RxTU9jtVvOtNWo4VByTn1tODzTplByzyDcoNo8=;
 b=eZz4KlMABVjk4K6axSdy358LOEmkoEi1RgyJCRFS2vxxYPoE4fBt6/p0SEzNB0vetB
 RRB4huIwtaxnxlbiqdJiBmFlVDqWc3fHMozGZuTNAF6ZL5cDxw152m3xiIDHdvuNGVsU
 oIeY8ezLyI0v0kVGv6+FQqM/PvOSb1qg5QBamIgSicdQGNWlI6fgFKjRlxyZqFdqLOZp
 2vLmIE8qrsLs7fZFkbk1grtzfvsSQygObYEzIBPGflX+THS+NbITPSld4klbT2INjUC1
 HTArxTNN5Pr+WpNxyDXFfXwdRclqvnxMx4e32WcimjVSub5tsvdWJbAAkIKX0qrlDE9T
 aVHg==
X-Gm-Message-State: AOAM530zI1x/lr6AHAi9JSk5wYMelWdShcPCSfrc6lk0Newyx+GpLRu2
 Ei8B7QJUgFaEpJY1HUCgbiF5vxPjmJQ+xdmHf6BkBx5pmqjhcXPJ/llgo5v5M0x38sC4asD6bJ1
 YVaOrfgWLBa/uKlw=
X-Received: by 2002:a1c:c3d7:: with SMTP id t206mr404339wmf.69.1591637855655; 
 Mon, 08 Jun 2020 10:37:35 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx2PP8Jam0jrAYWvl6HUndlzbkmQydkF0EZCtZp+EtGb77Su/VpiOiSTjN4I5rK9hrbErrKaQ==
X-Received: by 2002:a1c:c3d7:: with SMTP id t206mr404296wmf.69.1591637855427; 
 Mon, 08 Jun 2020 10:37:35 -0700 (PDT)
Received: from [192.168.1.38] (181.red-88-10-103.dynamicip.rima-tde.net.
 [88.10.103.181])
 by smtp.gmail.com with ESMTPSA id z9sm214694wmi.41.2020.06.08.10.37.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 08 Jun 2020 10:37:34 -0700 (PDT)
Subject: Re: [RFC PATCH 15/35] hw/i386/xen/xen-hvm: Emit warning when old code
 is used
To: paul@xen.org, qemu-devel@nongnu.org
References: <20200608160044.15531-1-philmd@redhat.com>
 <20200608160044.15531-16-philmd@redhat.com>
 <004b01d63db5$87a83110$96f89330$@xen.org>
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
Message-ID: <a14be45a-9296-c0ca-2b04-44703f2b9756@redhat.com>
Date: Mon, 8 Jun 2020 19:37:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <004b01d63db5$87a83110$96f89330$@xen.org>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/08 05:40:44
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: 'Peter Maydell' <peter.maydell@linaro.org>,
 'Sagar Karandikar' <sagark@eecs.berkeley.edu>,
 "'Michael S. Tsirkin'" <mst@redhat.com>,
 'Mark Cave-Ayland' <mark.cave-ayland@ilande.co.uk>,
 'Max Filippov' <jcmvbkbc@gmail.com>,
 'Alistair Francis' <Alistair.Francis@wdc.com>,
 'Gerd Hoffmann' <kraxel@redhat.com>,
 "'Edgar E. Iglesias'" <edgar.iglesias@gmail.com>,
 'Stefano Stabellini' <sstabellini@kernel.org>,
 'Magnus Damm' <magnus.damm@gmail.com>, 'Markus Armbruster' <armbru@redhat.com>,
 'Anthony Perard' <anthony.perard@citrix.com>,
 =?UTF-8?Q?=27Marc-Andr=c3=a9_Lureau=27?= <marcandre.lureau@redhat.com>,
 'David Gibson' <david@gibson.dropbear.id.au>,
 'Eduardo Habkost' <ehabkost@redhat.com>,
 'Alistair Francis' <alistair@alistair23.me>, qemu-arm@nongnu.org,
 xen-devel@lists.xenproject.org, qemu-riscv@nongnu.org,
 'Stafford Horne' <shorne@gmail.com>, 'Palmer Dabbelt' <palmer@dabbelt.com>,
 'Richard Henderson' <rth@twiddle.net>,
 "'Daniel P . Berrange'" <berrange@redhat.com>,
 'Thomas Huth' <huth@tuxfamily.org>,
 'Bastian Koppelmann' <kbastian@mail.uni-paderborn.de>,
 'Michael Walle' <michael@walle.cc>, qemu-ppc@nongnu.org,
 'Paolo Bonzini' <pbonzini@redhat.com>, 'Aurelien Jarno' <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/8/20 6:54 PM, Paul Durrant wrote:
>> -----Original Message-----
>> From: Philippe Mathieu-Daudé <philmd@redhat.com>
>>
>> This code hasn't been QOM'ified yet. Warn the user.
> 
> "Based on today's IRC chat, this is a trivial RFC series
> to anotate pre-qdev/QOM devices so developers using them
> without knowing they are not QOM'ified yet can realize
> it and convert them if they have time."
> 
> So, how should this be coded then? The XenIOState doesn't really qualify as a 'device', does it?

There is a pending question whether Machines are Devices or not.

Xen is a tricky case, it is created as a Q35 machine overloaded with Xen
features.

>> @@ -1401,6 +1401,8 @@ void xen_hvm_init(PCMachineState *pcms, MemoryRegion **ram_memory)
>>      xen_pfn_t ioreq_pfn;
>>      XenIOState *state;
>>
>> +    qdev_warn_deprecated_function_used();
>> +
>>      state = g_malloc0(sizeof (XenIOState));

XenIOState is indeed not a device, it is allocated once, we won't gain
anything making it a QOM object... so this patch is incorrect.

Sorry for the noise :S

Regards,

Phil.

>>
>>      state->xce_handle = xenevtchn_open(NULL, 0);
>> --
>> 2.21.3
> 
> 


