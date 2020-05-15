Return-Path: <SRS0=sZ1e=65=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD828C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 09:06:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB961206F4
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 09:06:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iljRr3xN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB961206F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36236 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZWIh-0007uH-2t
	for qemu-devel@archiver.kernel.org; Fri, 15 May 2020 05:06:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32942)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jZWHo-00071N-O1
 for qemu-devel@nongnu.org; Fri, 15 May 2020 05:05:44 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:58263
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jZWHn-00027U-Sn
 for qemu-devel@nongnu.org; Fri, 15 May 2020 05:05:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589533542;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vLs7D00WQoY84ERVb/0Cm7IeiJVHNOoAofknN04FgX8=;
 b=iljRr3xNqRVvfbGM3eVA5k4NYexED8EFxo4g4ObpPAyDsyzaPRy0Dnl3Ozd6mLw37zvHfz
 BKAHbi0r+MAuJp9wuTbvwDxZgr01PZl1SaBd0r83MzRtkgZpD9PdMRnyElgn+W1FOhqYO8
 VtLtpgpmHjPpq2tvrsK/PVZ0yAiD2rE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-481-CyikWZF6O9-Tlbmo9242ug-1; Fri, 15 May 2020 05:05:41 -0400
X-MC-Unique: CyikWZF6O9-Tlbmo9242ug-1
Received: by mail-wm1-f72.google.com with SMTP id x11so680058wmc.9
 for <qemu-devel@nongnu.org>; Fri, 15 May 2020 02:05:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=vLs7D00WQoY84ERVb/0Cm7IeiJVHNOoAofknN04FgX8=;
 b=bc7I+AJ7XB0NQ4u6aDQ2RHJLht7LDZAq7LptAOTZ/1YxwCxe1uKVklllpC2h1L4BR1
 fWwTrA8FEmfz4xAln3p5ccN+PrgPjOTApHrYLD3AdlmxBsXcGPNGcbi2Adbnhzk4GtHn
 gkPEcbLmR2zyDNBlcMZvYwX5YDaxxh0aqNpyp/lS12ZL8eakVHpqesnkIjkpqUqhSy+v
 htOHIOIAMePLxQe0ENBj5TO9SuuQf8KNGPkMS7PcBXwvBOx4hc258RIeIUODBZR16YFx
 Xr4/QCaIDr+zemeWDnOkCZyv1V3FErgCHkh4KTCqdplllCacOtf2peeuvgSg/pbgmspY
 fRLw==
X-Gm-Message-State: AOAM532FsNVhlEQWX7wtVThMjXCGLP3BuEt2Bn5NkZNVj6LBBAbIKb01
 hnoY3TfDohC+szxLAcSQxiZ3g1gi5Qv3kNUckNDl2z7u1pKiu6QyF2pd6s/jUE6FFYeuLe7tT03
 cOrLxNoNDBUMFPKc=
X-Received: by 2002:adf:e9d2:: with SMTP id l18mr3160068wrn.34.1589533540207; 
 Fri, 15 May 2020 02:05:40 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxZk5B8bxsDZe9J64N+702MXklb/vxc8NV2NJON2jDsSyBnsd5aHQ7q8O2swP9ZoL8lYVyrHg==
X-Received: by 2002:adf:e9d2:: with SMTP id l18mr3160045wrn.34.1589533539926; 
 Fri, 15 May 2020 02:05:39 -0700 (PDT)
Received: from [192.168.1.39] (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id q5sm2828326wra.36.2020.05.15.02.05.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 15 May 2020 02:05:39 -0700 (PDT)
Subject: Re: [PATCH 0/5] docs/system: Document some arm board models
To: Peter Maydell <peter.maydell@linaro.org>
References: <20200507151819.28444-1-peter.maydell@linaro.org>
 <CAFEAcA_p1x6S10yswHgOkMd=KrxcTGh9TD47+k1LRKM0xy5x+Q@mail.gmail.com>
 <567755c6-3bb1-b16e-af26-431dec4616ba@redhat.com>
 <CAFEAcA-67uGcwSu7mJ+w26xYqpTm4C0t3Yrr8gWCsA1VtHeaLg@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <49f4fc6f-329b-9afc-92db-c59dd1ce67ea@redhat.com>
Date: Fri, 15 May 2020 11:05:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-67uGcwSu7mJ+w26xYqpTm4C0t3Yrr8gWCsA1VtHeaLg@mail.gmail.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/14 22:56:02
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>,
 Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/15/20 10:51 AM, Peter Maydell wrote:
> On Fri, 15 May 2020 at 09:03, Philippe Mathieu-Daudé <philmd@redhat.com> wrote:
>> However I'd rather see the board documentation in the source code, and
>> extract it when building. It'd be harder to miss updating the
>> documentation when modifying the code.
> 
> I definitely agree in principle; but for the moment at least
> we can have some documentation...

Yes, thank you very much for this effort!

> 
>> Another way (rather than using external program to extract from source
>> code) can be to add a method/field to MachineClass, and once a build is
>> finished, we could run 'qemu-system-arch -M gendoc' which go thru all
>> machines and display the documentation properly formatted.
> 
> The documentation needs to include all machines, not just
> the ones that got compiled into a particular binary, so
> I'm not sure this will work. I also would prefer it if
> we avoided having the docs build depend on doing a full
> binary build -- places like readthedocs will just do a docs
> build by invoking Sphinx directly, and we'd like the machine
> docs to be visible there.

Sphinx consumes docs/system/$arch/$machine.rst files committed to the 
repository, and we don't need to build various qemu-system-arch to 
generate the documentation.

If you work on a particular board, you might end up only building its 
corresponding qemu-system-ARCH. Maybe we can add an extra-pass once a 
binary is linked, and re-generate the docs/system/ARCH/$machine.rst 
files, so if you modified a board and its documentation placeholder in 
the code, when commiting your code change, you also have to commit the 
rst changes.

Just brainstorming an idea for now ;)

> 
> thanks
> -- PMM
> 


