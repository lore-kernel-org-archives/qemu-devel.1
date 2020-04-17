Return-Path: <SRS0=Zx28=6B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 049CAC38A29
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2020 21:58:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C445120656
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2020 21:58:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i/zsI3Fb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C445120656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52376 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jPZ0g-0003cD-0N
	for qemu-devel@archiver.kernel.org; Fri, 17 Apr 2020 17:58:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50055)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laine@redhat.com>) id 1jPYzr-0002uR-NN
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 17:58:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laine@redhat.com>) id 1jPYzp-0002rv-VE
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 17:58:02 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:30195
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <laine@redhat.com>) id 1jPYzp-0002qp-OA
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 17:58:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587160681;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FzpBcCb22UO7GewrILBPX7C8PEQZ9ZtbSaYBY8gI9ps=;
 b=i/zsI3FbfeIuT4Ti3Ho1g7PPGySDhPeszfXHOH19DdOiWjZVeX5yxGG19Loh8EzbbJN1SB
 CnpHQ7JwcZgSsHsSuHpeI6DAzEfzPU1VzS6rykOXm017miTcXrmo3MHf1dytRPsEZd+0m1
 ylbPimZwP7PUFX1KbKk6GiPdIn9I63Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-259-uC6u5ygAMa2leANkQBIXHw-1; Fri, 17 Apr 2020 17:56:20 -0400
X-MC-Unique: uC6u5ygAMa2leANkQBIXHw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B7AB1DB60;
 Fri, 17 Apr 2020 21:56:19 +0000 (UTC)
Received: from [10.10.112.96] (ovpn-112-96.rdu2.redhat.com [10.10.112.96])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A9D225C1C3;
 Fri, 17 Apr 2020 21:56:09 +0000 (UTC)
Subject: Re: [PATCH] Add a new PIIX option to control PCI hot unplugging of
 devices on non-root buses
To: Ani Sinha <ani.sinha@nutanix.com>, "Michael S. Tsirkin" <mst@redhat.com>
References: <1587136411-200885-1-git-send-email-ani.sinha@nutanix.com>
 <20200417112620-mutt-send-email-mst@kernel.org>
 <2A13ACCD-BD24-41FB-B6EA-2804F7C1FF1D@nutanix.com>
 <20200417120732-mutt-send-email-mst@kernel.org>
 <56B4E13C-DCAA-4E40-A821-6C043844A253@nutanix.com>
From: Laine Stump <laine@redhat.com>
Message-ID: <0e15c8e7-7b32-985e-c182-2868273a1bd7@redhat.com>
Date: Fri, 17 Apr 2020 17:56:08 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <56B4E13C-DCAA-4E40-A821-6C043844A253@nutanix.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/17/20 12:35 PM, Ani Sinha wrote:
> +Laine
> 
>> On Apr 17, 2020, at 9:39 PM, Michael S. Tsirkin <mst@redhat.com> wrote:
>>
>> Problem is, I think this is not something we can support with pcie or shpc.
>> I'm reluctant to add features that only ACPI can support,
>> we are trying to phase that out.
> 
> Hmm. I see. We use conventional PCI and hence was looking for providing this feature for conventional PCI only. Laine might be able to throw some lights as to feasibility of the in PCIE world.
> 

Sorry, my knowledge doesn't go that low. If there's a qemu option I can 
expose it in libvirt, but am by no means an expert of qemu internals or 
the pci/pcie specs :-)

(BTW, I think in the past people have prevented enabling hot-unplug by 
unprivileged users in Windows with some sort of a "system policy" in 
Windows. (whatever that is - I don't use Windows, and have just heard 
this from others when discussing the problem).


