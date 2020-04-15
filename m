Return-Path: <SRS0=EwQe=57=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93C62C2BA19
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 07:49:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5CAC520768
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 07:49:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JpU/r3/3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CAC520768
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45342 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jOcnI-0004u6-FF
	for qemu-devel@archiver.kernel.org; Wed, 15 Apr 2020 03:49:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50736)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jOcmP-0003NR-6v
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 03:48:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jOcmO-0006wT-9u
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 03:48:17 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:27934
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jOcmO-0006wH-60
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 03:48:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586936895;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AF+e7TpCW7HNvuvnmW3nWhqAkFfE1AiJRNDi2eqd65c=;
 b=JpU/r3/3GhpyvT+xVVtd0vbqCmho2ixTvES7ZWj29E4SWR5ay8j+QPC5pOe/WlneFlNi4c
 KciEDSHy4izc3dVFk933YLZKt9tR9eEYfxmErP+Q1DDMpvwrT/vQYQi310ViicdQeExXks
 +PmVIMvXaA+oJlKO4XP4CaIOJciyNBk=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-488-vfPtlND_Oyq2MMTJC1nQHw-1; Wed, 15 Apr 2020 03:48:14 -0400
X-MC-Unique: vfPtlND_Oyq2MMTJC1nQHw-1
Received: by mail-ed1-f71.google.com with SMTP id b9so2207798edj.10
 for <qemu-devel@nongnu.org>; Wed, 15 Apr 2020 00:48:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=KR7xsr+24veqwxj09foJj4lRNHecEqvy06ieolHb95s=;
 b=JKeNJjoFHHKeiuADm4C08rYR6qvYyD9duYRh0Eb0+7KKRHPtL68o9nCbwTcqv800GJ
 N0/6eNs8L68z+s46Z4nQD+LM/5O3Yhm+YvD3nARl8i/uoiN0YGo6ntGZJXkWzHpiAM/p
 IrAyydMjIwO2M3aCxsu9VkkbZ/D4WpwZCXhEMc4uJrpN70fu7WSvvVOJDcJKVSwaFVB4
 bTsDQ85qcCP4zbhNqbYmYj2zXzMX+zIo0rqpEVxyMltazc0LK92JVOcR2E9yMj3EXwEo
 tOvlGs47505S2UgFi70LQevJuXCVQPBBUaB9z13LN9VA/7uCGY3afhkcX5ODat0qTo9k
 Z8gQ==
X-Gm-Message-State: AGi0PuZSM7KvPXDiE0uVj3db1zjVLVHzVYpVnUntW58NRjyOon84upSv
 PJ6DvhtE6x4IHu2m/DP8Ai91xebk+s9E/nw7x3th9PhsQkD5PIfpvBPCovaJn4H+vuhyjyn0GqE
 0TtxOju7M7VRzME0=
X-Received: by 2002:a05:6402:1543:: with SMTP id
 p3mr4643888edx.333.1586936893209; 
 Wed, 15 Apr 2020 00:48:13 -0700 (PDT)
X-Google-Smtp-Source: APiQypKpItHSEn57+htSvX5IlTOvDs0OidhZ2OQ3a4vHeFv/1iyVDvu8UHWrTyiZEL/ltmeQA4aANQ==
X-Received: by 2002:a05:6402:1543:: with SMTP id
 p3mr4643875edx.333.1586936893022; 
 Wed, 15 Apr 2020 00:48:13 -0700 (PDT)
Received: from [192.168.1.39] (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id s17sm800454edq.16.2020.04.15.00.48.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Apr 2020 00:48:12 -0700 (PDT)
Subject: Re: [PATCH v7 10/48] nvme: remove redundant cmbloc/cmbsz members
To: Klaus Birkelund Jensen <its@irrelevant.dk>
References: <20200415055140.466900-1-its@irrelevant.dk>
 <20200415055140.466900-11-its@irrelevant.dk>
 <62ec4481-a31d-d2cf-efb4-9107ae23bb76@redhat.com>
 <20200415071952.cdrdjura6aj3j346@apples.localdomain>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <a1d2b9b0-4f02-05f5-50a6-ed36d5cf40b0@redhat.com>
Date: Wed, 15 Apr 2020 09:48:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200415071952.cdrdjura6aj3j346@apples.localdomain>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
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
Cc: Kevin Wolf <kwolf@redhat.com>, Beata Michalska <beata.michalska@linaro.org>,
 qemu-block@nongnu.org, Klaus Jensen <k.jensen@samsung.com>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Keith Busch <kbusch@kernel.org>, Javier Gonzalez <javier.gonz@samsung.com>,
 Maxim Levitsky <mlevitsk@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/15/20 9:19 AM, Klaus Birkelund Jensen wrote:
> On Apr 15 09:10, Philippe Mathieu-Daud=C3=A9 wrote:
>>
>> "hw/block/nvme.h" should not pull in "block/nvme.h", both should include=
 a
>> common "hw/block/nvme_spec.h" (or better named). Not related to this pat=
ch
>> although.
>>
>=20
> Hmm. It does pull in the "include/block/nvme.h" which is basically the
> "nvme_spec.h" you are talking about. That file holds all spec related
> structs that are shared between the VFIO based nvme driver
> (block/nvme.c) and the emulated device (hw/block/nvme.c).
>=20
> Isn't that what is intended?

You are correct, "include/block/nvme.h" contains the spec definitions. I=20
was expecting to see (QEMU) block-related structure in it, but they aren't.


