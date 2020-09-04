Return-Path: <SRS0=8bV5=CN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4500FC433E2
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 02:52:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 06E7A206CA
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 02:52:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bmhNoPnG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06E7A206CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48816 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kE1pq-00026A-5b
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 22:52:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45154)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1kE1pE-0001Pw-RX
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 22:51:40 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:42048
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1kE1pC-0002ql-Fy
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 22:51:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599187897;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AySLD2TUcZnoyVLi2KbI606eg0CChKDIVXlT4o/jbZA=;
 b=bmhNoPnGquvyNDI2vban+gUIGNOG/rmIz5NR6Hb2jUp5LWNFVDNgrdyXjEqPmLCp6fI5+J
 qf23KkKWXpWpbWUfQLl0+msZpe16hE5PVjhhLw+EoPWV6Z+sgRGZYwyBS8sFovslSmK1U7
 Bx9kIVEptRn6t5X3CuTQdvUU7O33RA0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-511-lTWDeDbXOZ6j0hn5EzhvCw-1; Thu, 03 Sep 2020 22:51:33 -0400
X-MC-Unique: lTWDeDbXOZ6j0hn5EzhvCw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7A6CA1084C80;
 Fri,  4 Sep 2020 02:51:28 +0000 (UTC)
Received: from [10.72.13.157] (ovpn-13-157.pek2.redhat.com [10.72.13.157])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6EF687E405;
 Fri,  4 Sep 2020 02:50:58 +0000 (UTC)
Subject: Re: [RFC PATCH 00/12] hw: Forbid DMA write accesses to MMIO regions
To: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20200903110831.353476-1-philmd@redhat.com>
 <658fdd16-33da-af3a-6d8d-f7ea1253f061@redhat.com>
 <CAFEAcA8aOzq8UQwKiyuvJokBT9ui6JWxzf=T8=r13Vuu6+_kkQ@mail.gmail.com>
 <20200903142410.GX2954729@toto>
 <d030f14b-5b1d-6028-8fdd-5dbc25abdf74@redhat.com>
 <20200903155023.GC14249@toto>
 <9105d1fb-8064-076f-9408-ba94c889b765@redhat.com>
 <20200903194629.GH14249@toto>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <0dc3d4a3-489a-7b96-d07d-4b65b86d0782@redhat.com>
Date: Fri, 4 Sep 2020 10:50:57 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200903194629.GH14249@toto>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=207.211.31.120; envelope-from=jasowang@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/03 22:51:37
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-2.403, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
 "Michael S. Tsirkin" <mst@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 QEMU Developers <qemu-devel@nongnu.org>, Peter Xu <peterx@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Qemu-block <qemu-block@nongnu.org>,
 Li Qiang <liq3ea@163.com>, "Emilio G . Cota" <cota@braap.org>,
 Joel Stanley <joel@jms.id.au>, David Gibson <david@gibson.dropbear.id.au>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Robert Foley <robert.foley@linaro.org>,
 Alistair Francis <alistair@alistair23.me>,
 Richard Henderson <richard.henderson@linaro.org>,
 Beniamino Galvani <b.galvani@gmail.com>, Eric Auger <eric.auger@redhat.com>,
 qemu-arm <qemu-arm@nongnu.org>, Jan Kiszka <jan.kiszka@web.de>,
 =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, John Snow <jsnow@redhat.com>,
 Richard Henderson <rth@twiddle.net>, Tony Nguyen <tony.nguyen@bt.com>,
 Prasad J Pandit <pjp@fedoraproject.org>, Alexander Bulekov <alxndr@bu.edu>,
 Andrew Jeffery <andrew@aj.id.au>, Laszlo Ersek <lersek@redhat.com>,
 Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>, qemu-ppc <qemu-ppc@nongnu.org>,
 Klaus Jensen <k.jensen@samsung.com>, Peter Chubb <peter.chubb@nicta.com.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 2020/9/4 上午3:46, Edgar E. Iglesias wrote:
> On Thu, Sep 03, 2020 at 07:53:33PM +0200, Paolo Bonzini wrote:
>> On 03/09/20 17:50, Edgar E. Iglesias wrote:
>>>>> Hmm, I guess it would make sense to have a configurable option in KVM
>>>>> to isolate passthrough devices so they only can DMA to guest RAM...
>>>> Passthrough devices are always protected by the IOMMU, anything else
>>>> would be obviously insane^H^H^Hecure. :)
>>> Really? To always do that blindly seems wrong.
>>>
>>> I'm refering to the passthrough device not being able to reach registers
>>> of other passthrough devices within the same guest.
>> Ah okay; sorry, I misunderstood.  That makes more sense now!
>>
>> Multiple devices are put in the same IOMMU "container" (page table
>> basically), and that takes care of reaching registers of other
>> passthrough devices.
> Thanks, yes, that's a sane default. What I was trying to say before is that
> it may make sense to allow the user to "harden" the setup by selectivly
> putting certain passthrough devs on a separate group that can *only*
> DMA access guest RAM (not other device regs).


This makes sens but it requires the knowledge from the management layer 
of whether P2P is needed which is probably not easy.

Thanks


>
> Some devs need access to other device's regs but many passthrough devs don't
> need DMA access to anything else but RAM (e.g an Ethernet MAC).
>
> That could mitigate the damage caused by wild DMA pointers...
>
> Cheers,
> Edgar
>


