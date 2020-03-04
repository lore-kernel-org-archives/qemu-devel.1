Return-Path: <SRS0=3KIA=4V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1114C3F2CD
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2020 14:20:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E14420842
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2020 14:20:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Mx5wbmJu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E14420842
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34924 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9Usv-0000fw-HQ
	for qemu-devel@archiver.kernel.org; Wed, 04 Mar 2020 09:20:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53773)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1j9Urj-0008SF-2n
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 09:19:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1j9Urh-0000Xw-SA
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 09:19:14 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:40101
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1j9Urh-0000Wm-Oa
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 09:19:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583331553;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WNvxBkc+0sLn/M93sJq0r8WECREa81du/QTpzjZXEt8=;
 b=Mx5wbmJuzJ5pn7iuYPO+0jnU9i9NWZHP99oT9XiEgV2k3ypbfBGNilyHvZgzO8JpekB7+Q
 McQBMWUw12FPuPojBt7x7RBOb6cP7wcpcWRUiGIt44eeVliYpBf//Yfh1ynDOe7uN0i6a2
 Z8ATrvsbi+GJovy7PlOFianG7YEx3u0=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-179-q98SJRZqPPCG5-2oB66-AQ-1; Wed, 04 Mar 2020 09:19:09 -0500
X-MC-Unique: q98SJRZqPPCG5-2oB66-AQ-1
Received: by mail-wr1-f69.google.com with SMTP id p11so915660wrn.10
 for <qemu-devel@nongnu.org>; Wed, 04 Mar 2020 06:19:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=18OMrVfu00BGHTajXs/3slGyD4i/96bG2uMqkT7G3sA=;
 b=Ji8X0ZNR2brVGVVCK3cmCmCwbRossRT9x3xG4hhU4U+9vpTur+evWcNTjdixvPqMEq
 c0HoBCD9TSRT1ws1Hcf1LZFxRQ5VsenuehlMusOGpbyAzhno14Gfvj5Yk8kEyJ6zWEO4
 nCNPSKHuz2mZXg1LCa+ucu3gdipKFIqw0FNYgddrDER1PNEPZQcNZ6jSeXYh1JPdlTdI
 gp3AJu11xZQ4l6OUPcsNK0E6gajYlGUZc92m6M+Wsn8FYDIBnr/cgW8JD5uGddlQdsDj
 uz0V6L73ByBcjmTFThicbosNhMh+vvad3O6ArCl7JSF0TDXUEw9jXp+DiQ8/SIsTGJkz
 sgsQ==
X-Gm-Message-State: ANhLgQ0/c6yRfkkq9C5mLcG9tx2nEP0I32BDjcdX98IbHi61nyHa19y/
 VkZ3vem6OuvdAjs3Eys+foeCc8XefpsQCBv3aVGn3saSG/pAOscJw6upI1hcATM4tXnneJqBigw
 8qN4BzyaiSZCe0FE=
X-Received: by 2002:adf:ed42:: with SMTP id u2mr4446976wro.345.1583331548694; 
 Wed, 04 Mar 2020 06:19:08 -0800 (PST)
X-Google-Smtp-Source: ADFU+vsEcToJJ6f8QbbBHBqWodF6qXnmm+v231lj0jYmyJ2AAOJZwxYVnD7AK7dmnZoEvl9kglaFJQ==
X-Received: by 2002:adf:ed42:: with SMTP id u2mr4446930wro.345.1583331548416; 
 Wed, 04 Mar 2020 06:19:08 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:9def:34a0:b68d:9993?
 ([2001:b07:6468:f312:9def:34a0:b68d:9993])
 by smtp.gmail.com with ESMTPSA id o3sm5426191wme.36.2020.03.04.06.19.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Mar 2020 06:19:07 -0800 (PST)
Subject: Re: [PATCH 1/2] misc: Replace zero-length arrays with flexible array
 member (automatic)
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20200304005105.27454-1-philmd@redhat.com>
 <20200304005105.27454-2-philmd@redhat.com>
 <1e1a1491-15ca-29d4-8bd6-1bf14edb4ad5@redhat.com>
 <38b55649-b1cd-8891-5c13-ec4c6ef3ae5e@redhat.com>
 <f1d4241c-e82e-53db-cc33-898890a0b070@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <f10c129e-bef2-67ab-2aff-d3c9bda14b82@redhat.com>
Date: Wed, 4 Mar 2020 15:19:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <f1d4241c-e82e-53db-cc33-898890a0b070@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Yuval Shaia <yuval.shaia.ml@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>, qemu-block@nongnu.org,
 David Hildenbrand <david@redhat.com>,
 "Gustavo A . R . Silva" <gustavo@embeddedor.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 "Gonglei \(Arei\)" <arei.gonglei@huawei.com>,
 Anthony Perard <anthony.perard@citrix.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>, Thomas Huth <thuth@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Paul Durrant <paul@xen.org>,
 Eric Auger <eric.auger@redhat.com>, qemu-s390x@nongnu.org, qemu-arm@nongnu.org,
 xen-devel@lists.xenproject.org, John Snow <jsnow@redhat.com>,
 Richard Henderson <rth@twiddle.net>, Kevin Wolf <kwolf@redhat.com>,
 Xiao Guangrong <xiaoguangrong.eric@gmail.com>,
 Cornelia Huck <cohuck@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 Max Reitz <mreitz@redhat.com>, Igor Mammedov <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 04/03/20 15:12, Philippe Mathieu-Daud=C3=A9 wrote:
> I'll send a fix for the dangerous code.
> Do you want to drop this series, or only the change in 'struct srp_rsp'
> (or in all hw/scsi/srp.h). Actually I guess it makes sense I move the
> 'hw/scsi/srp.h' changes with the series cleaning dangerous code.

As you prefer, it's not urgent to merge it.

Paolo


