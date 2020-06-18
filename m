Return-Path: <SRS0=FaGC=77=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F092EC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 07:57:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BABD8208D5
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 07:57:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QvooXPDF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BABD8208D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40550 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlpQd-0002cD-0B
	for qemu-devel@archiver.kernel.org; Thu, 18 Jun 2020 03:57:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52018)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1jlpPr-0002Bt-Ho
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 03:56:55 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:50859
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1jlpPp-00040M-Dv
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 03:56:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592467012;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+Rft2aFdT17F5NIYmC15tuFfKr9dgEsHmXbB0DaDCyE=;
 b=QvooXPDF4XThlwp0bVHowWhg+nbhRVaY5bf3orTYBWP3f+8+VI89orqzhi3mva5Z+DA+Me
 CSA89EsMJzfhNzQxCstihsU6BoFfgtnEEHpvAEVfD0eE30IXZPKX7lglhKed1IKz85ubGE
 0f9zIdsdoFPAxLtcF6AXU/ZWy9L/+no=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-430-cs2lyJsGNGGfBEqYLpA-Bw-1; Thu, 18 Jun 2020 03:56:48 -0400
X-MC-Unique: cs2lyJsGNGGfBEqYLpA-Bw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9025991164;
 Thu, 18 Jun 2020 07:56:46 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-113-60.ams2.redhat.com
 [10.36.113.60])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 56E4B79303;
 Thu, 18 Jun 2020 07:56:41 +0000 (UTC)
Subject: Re: ovmf / PCI passthrough impaired due to very limiting PCI64
 aperture
To: Guilherme Piccoli <gpiccoli@canonical.com>
References: <99779e9c-f05f-501b-b4be-ff719f140a88@canonical.com>
 <20200616165043.24y2cp53axk7uggy@sirius.home.kraxel.org>
 <20200616165746.GH2788@work-vm>
 <CAHD1Q_zGu4Q63HjHx3aZKu3wh8NppuP6T4kgnUN3j=-ZDufVZA@mail.gmail.com>
 <b423f4a4-2552-bdc8-7c9f-41f200aef672@redhat.com>
 <CAHD1Q_zmTatErCefeh349sSYsQJUVT3KB+VMDheEgBn5r7QGjA@mail.gmail.com>
 <084e2640-d71e-d4ec-efdd-3f7947a6b511@redhat.com>
 <CAHD1Q_x6E4Oggq_HnKH4xYX_CGY0dRQWRD-J-DGqh42diLy5og@mail.gmail.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <1f955c4b-96ea-6751-127a-3590347066e7@redhat.com>
Date: Thu, 18 Jun 2020 09:56:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Firefox/52.0 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAHD1Q_x6E4Oggq_HnKH4xYX_CGY0dRQWRD-J-DGqh42diLy5og@mail.gmail.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=lersek@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/18 01:21:16
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Pedro Principeza <pedro.principeza@canonical.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Dann Frazier <dann.frazier@canonical.com>, qemu-devel@nongnu.org,
 Christian Ehrhardt <christian.ehrhardt@canonical.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, fw@gpiccoli.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 06/17/20 18:01, Guilherme Piccoli wrote:
> On Wed, Jun 17, 2020 at 12:57 PM Laszlo Ersek <lersek@redhat.com> wrote:
>> [...]
>> I don't necessarily see compat issues -- large-BAR PCI device assignment
>> might simply stop working under those circumstances, because you could
>> no longer use X-PciMmio64Mb, and the new way wouldn't be supported by
>> (old) QEMU.
>>
>> This would indeed be a regression relative to "X-PciMmio64Mb", but
>> that's exactly why there's an "X" in "X-PciMmio64Mb".
>>
> 
> Are you planning to remove that option, with this improvement?

Yes.

> I think
> we could keep it for a while, as a way to override the automatic
> mechanism we might implement. This is even for "safe" purposes, in
> case there's some corner case with the auto-sized aperture that we
> ignore upfront.

I disagree. The knob is called "experimental" specifically so we don't
have to introduce even worse complexity for compatibility's sake than
what we have now. Graceful deprecation is for options that used to be
supported; "X-PciMmio64Mb" has been explicitly experimental from the start.

I'm not saying that I'll kill "X-PciMmio64Mb" for sure, just that I very
likely will.

Thanks
Laszlo


