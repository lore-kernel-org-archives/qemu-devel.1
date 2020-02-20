Return-Path: <SRS0=d4IR=4I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A6ACC11D04
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 10:51:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 05DE824656
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 10:51:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JB37ZuLX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05DE824656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39742 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4jQl-0002GW-53
	for qemu-devel@archiver.kernel.org; Thu, 20 Feb 2020 05:51:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35749)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1j4jQ0-0001p3-9A
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 05:50:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1j4jPz-0006LJ-18
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 05:50:56 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:35589
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1j4jPy-0006LE-Ta
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 05:50:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582195854;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xtirbp2bqScAIYjEiGfHbSX03TjfUjOqz7zDNqNpziM=;
 b=JB37ZuLXyWSfqMK9uU/EEU9ujv5WamFvZ0kGS+QQqOrTjTUhReAd5pGmEITnMcbSfeISf7
 pr7jHzNT/U1Litdhb5HQUkKh++HiQsjVH4n5ZywXOPUYQ1t3ZxJxuUYE3nZsOXl6PDrS+E
 6OxQyZib2+4gOFwQ5UNJTs2LpTKQgk0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-16-FrU-iE9VP1yD_NN8F8aTXA-1; Thu, 20 Feb 2020 05:50:51 -0500
X-MC-Unique: FrU-iE9VP1yD_NN8F8aTXA-1
Received: by mail-wm1-f69.google.com with SMTP id y125so901549wmg.1
 for <qemu-devel@nongnu.org>; Thu, 20 Feb 2020 02:50:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=+d8hl556E1CGji4NKJOp9x8Q91xWz/tUgDoNivWsZVQ=;
 b=FMTbn11gOfl6bJzYPUzi5Oqb2Zfa1faPdlgD6sZ3m/3VeVmHaHbkT3UzsO2KQJ4yvU
 11CvWLQwNRV2L/sYMGMARfFfCQARQ7d/cFDm4MhpPDJ1bEkQimitMSF9GysEd8bc3mOF
 xUaLfY+ZhGVJ+ohrcQWSpNUaJ3eclpMU2wiQMUHwo71nhhv137rGr/xVvzxatOQuDrPc
 pamgOY9VaH7YrT9Y6VntC5XBRMlp/in6u4/lwFFTr731NHWgn9/BlQNqdzfGDiDZxDNj
 wg112GTSLB95EWezmrhhyBPchttEwVQmnr7KySSpMnf5kIrTZUSoXv+abit8c2Rs84OI
 F2XQ==
X-Gm-Message-State: APjAAAVGwIrasFnAz2uyLX4GadTw7TxTJVSY2uyeoTusOYhxMrUnDakw
 eNDLHx7Mip1HsIO5vmwOnEKRdWMIkU5XBGGwObfRBtUpRdULG+XwnO8gqJUj/FtHKVwTkLzlpfY
 ZUXJBFY+GGanQSt4=
X-Received: by 2002:a1c:f606:: with SMTP id w6mr3753141wmc.109.1582195850190; 
 Thu, 20 Feb 2020 02:50:50 -0800 (PST)
X-Google-Smtp-Source: APXvYqxifN+2QsXGk1osPE2Z2Iu/vteMF8gX/UNkdgQy4XWvHifcG4NPeQVWAs5xSKis+4dPm/8dGw==
X-Received: by 2002:a1c:f606:: with SMTP id w6mr3753096wmc.109.1582195849808; 
 Thu, 20 Feb 2020 02:50:49 -0800 (PST)
Received: from [10.201.49.12] (nat-pool-mxp-u.redhat.com. [149.6.153.187])
 by smtp.gmail.com with ESMTPSA id 5sm4156340wrc.75.2020.02.20.02.50.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Feb 2020 02:50:49 -0800 (PST)
Subject: Re: [PATCH v2] hw/i386: disable smbus migration for xenfv
To: Olaf Hering <olaf@aepfle.de>
References: <20200113174521.3336-1-olaf@aepfle.de>
 <20200116180321.24968-1-olaf@aepfle.de>
 <0335edd2-3d33-88f8-2ab4-4791f7289885@redhat.com>
 <20200219123530.11064fc5.olaf@aepfle.de>
 <20200219151459.5a6b9690.olaf@aepfle.de>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <5bb74529-5db9-65e0-b6c6-9b2ebf3bafb3@redhat.com>
Date: Thu, 20 Feb 2020 11:50:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20200219151459.5a6b9690.olaf@aepfle.de>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: Stefano Stabellini <sstabellini@kernel.org>,
 Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Paul Durrant <paul@xen.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>,
 Anthony Perard <anthony.perard@citrix.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 19/02/20 15:14, Olaf Hering wrote:
>> Is any of the things done by pc_i440fx_5_0_machine_options and
>> pc_i440fx_machine_options a desired, or even breaking, change for the
>> current result of pc_xen_hvm_init?
> I tried to follow a few of the initialized members:
>=20
> default_nic_model, perhaps the involved code paths are not called, so the=
 NULL pointer does not matter.
>=20
> pvh_enabled, does this mean the PVH domU type? If yes, this would be lost=
 when xenfv is locked at v3.1.

No, pvh_enabled means recognizing uncompressed kernels and setting up
the pvh.bin ROM to boot them.  On Xen, this is done by the domain loader.

Paolo


