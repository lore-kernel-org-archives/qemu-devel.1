Return-Path: <SRS0=37Ja=DO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55B2FC41604
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 17:51:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 94C3A20679
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 17:51:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E0J8m/dY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94C3A20679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49752 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQDbP-0003Zz-Fk
	for qemu-devel@archiver.kernel.org; Wed, 07 Oct 2020 13:51:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34886)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kQDaC-0002aL-Ab
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 13:50:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:38639)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kQDa8-00031D-Lb
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 13:50:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602093026;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=a54dLyoHfWLvYVfrDW9YKtGjscMrE+CPCU7zwIofNGM=;
 b=E0J8m/dYLOQCirsOIFSVXV4P133ueCE5kT3BalU1uZnAcDnRN5MeD0M265QU4UXT8R5FOw
 7QLKbxQ1qyB2M5NXSXTvlzGv9RXooldTOv+iNki9kGroa7qPo+dXJFzLSVvxJFzV4RiTaq
 mJBWZ3+hSuBF+9qkq+OUeAKqtRNp93Q=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-124-YTd5uKEjPfSKpm_R0iadvg-1; Wed, 07 Oct 2020 13:50:24 -0400
X-MC-Unique: YTd5uKEjPfSKpm_R0iadvg-1
Received: by mail-wm1-f71.google.com with SMTP id i9so1211607wml.2
 for <qemu-devel@nongnu.org>; Wed, 07 Oct 2020 10:50:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=a54dLyoHfWLvYVfrDW9YKtGjscMrE+CPCU7zwIofNGM=;
 b=k4AFGRIu3a0fFG3iIBai1qrG0e5hZf/vaTE0flTRaTP8TY+onDJEoX6iBQZRO3TgEz
 sydEXDHGtD5dUooTlTgFp3tYf+84wmCblrjNdqXumfiQdLBR9LkPt2e7A6wy1Zl0qPbA
 nURScxsNbJX32/xfxwrKToMkAnCyEZ6WJ+QECCQIYBnQaRAW719Tu7fZgkzag2Qts+Gi
 eEI81laFFRo9VUhOFnRJk/noephRI+affTv8IKpNYv06ZJbBp60R39e2fcdErPjtWNvg
 Tdmr2tr0CyJ6G8oLaEuHPabYx9Rg0xZH5g6Hz4DYmtev08tiLRni9xldlX45M/IjS9Cp
 kqhA==
X-Gm-Message-State: AOAM533n31Q6ZpSdeRXuv7o5tqXsF9FybYzQrAnDEPyxigfZjjnk0WRF
 fkYF/hUpR2ccZx54M4k+QqIQF7ojRbZ59AsLa4t9BrLgJi+XgZSRFz+7ty38sXTkUYlWmk4LPlB
 Lr0cJlqHzKx1zUFY=
X-Received: by 2002:a5d:6a85:: with SMTP id s5mr5068983wru.90.1602093022768;
 Wed, 07 Oct 2020 10:50:22 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw+KNtLI6Q/fyWROjeJM0mDYXTnMD0R+iAiJ5XgupNU6bUZjaCv9qjZyVDsi8DSRg0AvSX5+w==
X-Received: by 2002:a5d:6a85:: with SMTP id s5mr5068965wru.90.1602093022533;
 Wed, 07 Oct 2020 10:50:22 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:d2f4:5943:190c:39ff?
 ([2001:b07:6468:f312:d2f4:5943:190c:39ff])
 by smtp.gmail.com with ESMTPSA id d30sm4079023wrc.19.2020.10.07.10.50.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 07 Oct 2020 10:50:21 -0700 (PDT)
Subject: Re: KVM call for agenda for 2020-10-06
To: Stefan Hajnoczi <stefanha@gmail.com>
References: <874kndm1t3.fsf@secure.mitica>
 <20201005144615.GE5029@stefanha-x1.localdomain>
 <CAJSP0QVZcEQueXG1gjwuLszdUtXWi1tgB5muLL6QHJjNTOmyfQ@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <8fce8f99-56bd-6a87-9789-325d6ffff54d@redhat.com>
Date: Wed, 7 Oct 2020 19:50:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <CAJSP0QVZcEQueXG1gjwuLszdUtXWi1tgB5muLL6QHJjNTOmyfQ@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/07 00:44:56
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.742,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>, Daniel Berrange <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, kvm-devel <kvm@vger.kernel.org>,
 qemu-devel <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 06/10/20 20:21, Stefan Hajnoczi wrote:
>     * Does command-line order matter?
>         * Two options: allow any order OR left-to-right ordering
>         * Andrea Bolognani: Most users expect left-to-right ordering,
> why allow any order?
>         * Eduardo Habkost: Can we enforce left-to-right ordering or do
> we need to follow the deprecation process?
>         * Daniel Berrange: Solve compability by introducing new
> binaries without the burden of backwards compability

I think "new binaries" shouldn't even have a command line; all
configuration should happen through QMP commands.  Those are naturally
time-ordered, which is equivalent to left-to-right, and therefore the
question is sidestepped.  Perhaps even having a command line in
qemu-storage-daemon was a mistake.

For "old binaries" we are not adding too many options, so apart from the
nasty distinction between early and late objects we're at least not
making it worse.

The big question to me is whether the configuration should be
QAPI-based, that is based on QAPI structs, or QMP-based.  If the latter,
"object-add" (and to a lesser extent "device-add") are fine mechanisms
for configuration.  There is still need for better QOM introspection,
but it would be much simpler than doing QOM object creation via QAPI
struct, if at all possible.						

Paolo


