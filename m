Return-Path: <SRS0=1Qun=7R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8816EC433E2
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 07:33:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 532D020663
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 07:33:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Qy3IWN8G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 532D020663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53344 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgkNk-0007zX-Hv
	for qemu-devel@archiver.kernel.org; Thu, 04 Jun 2020 03:33:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44768)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jgkND-0007aJ-2h
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 03:33:11 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:25459
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jgkNB-0002ci-HX
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 03:33:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591255987;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:autocrypt:autocrypt;
 bh=QTPyxvXDKpuftA7gsYICyDkbprmnAWNpNaDEo8073x8=;
 b=Qy3IWN8GHin073xY6tUVT+QcXVpGtG06oCsfngKtf4P+2ZXzYnRy96I1WShksscUQQk1Mv
 aePu3i+eH3quhYMHOzEo17HcISSPqxp5asD4EOSTV6CjBXQcKfImudd3MYngJNiUAdVnMH
 XT5yEX8I+iJjx6DNxPn/lHzKeqcNdbM=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-82-Q8M-HGqqNI-toM9GDjugFQ-1; Thu, 04 Jun 2020 03:33:05 -0400
X-MC-Unique: Q8M-HGqqNI-toM9GDjugFQ-1
Received: by mail-wr1-f70.google.com with SMTP id h6so2073222wrx.4
 for <qemu-devel@nongnu.org>; Thu, 04 Jun 2020 00:33:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:to:cc:from:autocrypt:subject:message-id:date
 :user-agent:mime-version:content-language:content-transfer-encoding;
 bh=QTPyxvXDKpuftA7gsYICyDkbprmnAWNpNaDEo8073x8=;
 b=kOM+4LFad2+G7fMRw6+0A5VL/2kdyaw4c+x+cKl2BwSyYQS9Ow+s7AP2MYGFaFMAtC
 7Ui9LtZZRtYsJXRdBpnzmVeRZWSweoj6k81sN97gr/NwFvywthrYg17Al1jfnyWG6JiS
 ZOIm2/6roXrpE/B6nkiMOvrNePw2mB2b2PDAonkOoKLD0hHC67Iw4Fiakow+Ucpzt4mB
 5Vs5NGUO86UcXBXrp85dKysT/witNaJjwzjdMUKB1XpRnxKMV/ZRTzKkptqDTJK8NQBK
 ml61VwysUQ1k10VDi45EzBeUFaDPeUJbz1BEIrXhfL5f30PFHozicJXhqonROWdZqPwA
 HIHA==
X-Gm-Message-State: AOAM532ip5KT+HHq2fSbb6St2DcPEDuwAa6lpfq8wq6FldnVQpFV2ftt
 Qfhuh8ZjiyM2oVhW/sIy4deAtJQgUXFc8raKJfqBHbCCDbidzloN1Bpr+xE0taOPMcYotuQgqEB
 jChU3VycOJc1IkgI=
X-Received: by 2002:a1c:7f44:: with SMTP id a65mr2830615wmd.53.1591255984285; 
 Thu, 04 Jun 2020 00:33:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx839qjPN6LyllJ2nIcggSfXS6Nhp+/u1q6qaIzwPlFXcx+DXPTeNtDkEiVdtdIz1oVyfX6hA==
X-Received: by 2002:a1c:7f44:: with SMTP id a65mr2830598wmd.53.1591255984061; 
 Thu, 04 Jun 2020 00:33:04 -0700 (PDT)
Received: from [192.168.1.43] (181.red-88-10-103.dynamicip.rima-tde.net.
 [88.10.103.181])
 by smtp.gmail.com with ESMTPSA id n7sm6641329wrx.82.2020.06.04.00.33.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 04 Jun 2020 00:33:03 -0700 (PDT)
To: qemu-devel <qemu-devel@nongnu.org>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
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
Subject: About improving devices and renaming migration stream...
Message-ID: <b24c8f81-703c-16c2-94e9-e485962eca42@redhat.com>
Date: Thu, 4 Jun 2020 09:33:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/04 01:12:15
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hello Dave,

==[background]==

I've been doing this pflash rework:

* Add abstract TYPE_NOR_FLASH

  - qdev type
  - blockdev backend
  - manage bank/sector,
  - manage timer for erase/write delays
  - can be used by I2C/SPI NOR flash too

* Add abstract TYPE_PARALLEL_NOR_FLASH

  - mostly SysBusDevice bindings

* Add TYPE_COMMON_FLASH_MEMORY_INTERFACE

  - common CFI code
  - abstracts CFI methods

* Refactor TYPE_PFLASH_CFI02
  -> TYPE_PARALLEL_NOR_CFI02_FLASH

  - Inherit TYPE_NOR_FLASH -> TYPE_PARALLEL_NOR_FLASH
  - Implements TYPE_COMMON_FLASH_MEMORY_INTERFACE


I kept the harder for the end... (maybe bad idea):
  - migration
  - CFI01


==[problems]==


1/ Can I change the name of a migration stream?

I want to add migration from old TYPE_PFLASH_CFI02 to
TYPE_PARALLEL_NOR_CFI02_FLASH, and deprecate TYPE_PFLASH_CFI02.

From docs/devel/migration.rst:

  "The ``ID string`` is normally unique, having been
   formed from a bus name and device address, PCI devices
   and storage devices hung off PCI controllers fit this
   pattern well.  Some devices are fixed single instances
   (e.g. "pc-ram").
   Others (especially either older devices or system devices
   which for some reason don't have a bus concept) make use
   of the ``instance id`` for otherwise identically named
   devices."

I started TYPE_PARALLEL_NOR_CFI02_FLASH from a clean design,
I'm not sure I can redo everything keeping the same type name.

Is it possible to use massaging functions to migrate from
TYPE_A (version y) to TYPE_B (version x)?


2/ Do I need to care about backward compatibility?

I understand we want to migrate from old -> new QEMU version.

From docs/devel/migration.rst:

  "In general QEMU tries to maintain forward migration
   compatibility (i.e. migrating from QEMU n->n+1) and
   there are users who benefit from backward
   compatibility as well."

When is it important to migrate from new -> old?
Can this be a blocker?
Am I doomed to keep the old device forever?

Is this what are versioned machines for?
I.e. adding machine-v6 that start with the newer devices,
breaking backward compat.

Thanks,

Phil.


