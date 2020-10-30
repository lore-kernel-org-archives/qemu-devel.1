Return-Path: <SRS0=q+n2=EF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C73DC00A89
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 17:14:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 821BA20756
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 17:14:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Jtdv8YHo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 821BA20756
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35290 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYXyz-0005py-95
	for qemu-devel@archiver.kernel.org; Fri, 30 Oct 2020 13:14:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34780)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kYXxq-0005Ga-Qb
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 13:13:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:56470)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kYXxo-0006k2-U6
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 13:13:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604078000;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DuNzb5Kn5X9pUmStEj+JKnJyNB4NfLrBdeM6NHGeIbs=;
 b=Jtdv8YHofOcyEvUTIR7Dfok/J0d+ubRHA+IW/kh/OFQ54wgjbHEml7HaMabRRmitYBUkDS
 Cix3+lNvFjcR/R89FbBaqOyxEsYSonm6vP/pKQfSO/++xcW4uQ6xxft8rZpdooCCC1Qvlz
 JYsth7zjRBoZtyYPJUgx/YyDvmx70zo=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-396-nbYi3KZ1Pi2dhn5DCGfkJQ-1; Fri, 30 Oct 2020 13:13:16 -0400
X-MC-Unique: nbYi3KZ1Pi2dhn5DCGfkJQ-1
Received: by mail-ej1-f71.google.com with SMTP id p19so2670113ejy.11
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2020 10:13:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=DuNzb5Kn5X9pUmStEj+JKnJyNB4NfLrBdeM6NHGeIbs=;
 b=fuISfqzIwP4smG/YIlEHOu8OCjxZfXBaYdFp12ucKiU/7pm+QtPksxxrRlSERlHu8K
 lirN48Nhr46PwIrPCsLqU7teixmvLzQtTr7x+7jm4NsBGJ/tPrk9y+tTnyueeq4EFpiV
 Diy1dboV1fQxjlkh/yITqIvr5TqjwutlxyyCrD68uYy8WfgzZMLJhTBGszbuNKcPb3IT
 xOIrzazlBiikIVVqZ7wwIQfCkaRJaspLldLrHnY9GM08oVP1fhmZDQiY4rNrweagB/rq
 nzi8U0ZpIsdH3nPjYL0vtx67GPKxf+xdhNQgTNYorUzjTow0nN7jKZH6KFdvji9ho0/j
 8WqA==
X-Gm-Message-State: AOAM532KwEJ0PHV++PjoG83G/zJcLMir72nxIrKw1Wx5Z5W677g/qrYY
 +F7ehy2Lj24v2bIxl3u6ujiJWpEIHI4TEgqvjy4nZF0rpFLG7f/HMk3vZHUkPNYKkZ9+v4qs6hZ
 6mUl01GMH7ZgARn0=
X-Received: by 2002:a17:906:3ed0:: with SMTP id
 d16mr3611031ejj.477.1604077994642; 
 Fri, 30 Oct 2020 10:13:14 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxNrqw+IPZ72SgiHrvzWBvPiDF1WXxJhZYdZEXFTddoFS+f0M1aGXH70Zz6DFO5MzIbmGeOKA==
X-Received: by 2002:a17:906:3ed0:: with SMTP id
 d16mr3610991ejj.477.1604077994450; 
 Fri, 30 Oct 2020 10:13:14 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a?
 ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
 by smtp.gmail.com with ESMTPSA id rn28sm2612035ejb.22.2020.10.30.10.13.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 30 Oct 2020 10:13:13 -0700 (PDT)
Subject: Re: --enable-xen on gitlab CI? (was Re: [PATCH 09/36] qdev: Make
 qdev_get_prop_ptr() get Object* arg)
To: Eduardo Habkost <ehabkost@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>,
 Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?=
 <philmd@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
References: <20201029220246.472693-1-ehabkost@redhat.com>
 <20201029220246.472693-10-ehabkost@redhat.com>
 <CAJ+F1CKqo3D20=qSAovVKWCGz4otctaWnGC0O5p-Z1ZG9Pj_Mw@mail.gmail.com>
 <20201030113516.GP5733@habkost.net>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <7645972e-5cad-6511-b057-bd595b91c4aa@redhat.com>
Date: Fri, 30 Oct 2020 18:13:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201030113516.GP5733@habkost.net>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/30 01:22:25
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.253, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Matthew Rosato <mjrosato@linux.ibm.com>, Paul Durrant <paul@xen.org>,
 QEMU <qemu-devel@nongnu.org>, Stefano Stabellini <sstabellini@kernel.org>,
 "open list:Block layer core" <qemu-block@nongnu.org>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>,
 David Hildenbrand <david@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 Anthony Perard <anthony.perard@citrix.com>, xen-devel@lists.xenproject.org,
 Qemu-s390x list <qemu-s390x@nongnu.org>, John Snow <jsnow@redhat.com>,
 Richard Henderson <rth@twiddle.net>, Kevin Wolf <kwolf@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 30/10/20 12:35, Eduardo Habkost wrote:
> 
> What is necessary to make sure we have a CONFIG_XEN=y job in
> gitlab CI?  Maybe just including xen-devel in some of the
> container images is enough?

Fedora already has it, but build-system-fedora does not include
x86_64-softmmu.

Paolo


