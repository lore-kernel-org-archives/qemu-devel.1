Return-Path: <SRS0=xv4c=6Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17FD0C54E4B
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 10:21:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D82022075E
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 10:21:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Wdw4SXGv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D82022075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40482 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jY5Z2-0002Au-1t
	for qemu-devel@archiver.kernel.org; Mon, 11 May 2020 06:21:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48244)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mprivozn@redhat.com>)
 id 1jY5YM-0001Tr-5l
 for qemu-devel@nongnu.org; Mon, 11 May 2020 06:20:54 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:52601
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mprivozn@redhat.com>)
 id 1jY5YL-0003SS-BT
 for qemu-devel@nongnu.org; Mon, 11 May 2020 06:20:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589192451;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VjmQHhVMcUm20e38DUZZKfoXauzZsIWn3wSRQEQWl7Y=;
 b=Wdw4SXGvwGSpJc6HCLLJ7a8n6v3EzbhQDxVCqOfGB5jtTtGCvGhoXJXr3PaI4x2FB0Cy0Z
 W32+xl/gecNWhyUEZIMCshR7xkqqybAbxs8zBca6ByVlbOBrtefR9xsx5EI+RrqiPQyQ/Z
 i6mcF/F+CfPcqsANuEp4m+5jcuVXib0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-372-jZ1eBfpYNQSfbWgK7i2CSw-1; Mon, 11 May 2020 06:20:49 -0400
X-MC-Unique: jZ1eBfpYNQSfbWgK7i2CSw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 27848107ACCA
 for <qemu-devel@nongnu.org>; Mon, 11 May 2020 10:20:49 +0000 (UTC)
Received: from [10.40.192.119] (unknown [10.40.192.119])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 62B3F1002394;
 Mon, 11 May 2020 10:20:43 +0000 (UTC)
Subject: Re: device hotplug & file handles
To: Gerd Hoffmann <kraxel@redhat.com>, libvir-list@redhat.com,
 qemu-devel@nongnu.org
References: <20200507144914.4zg3753uh3kytz6g@sirius.home.kraxel.org>
From: Michal Privoznik <mprivozn@redhat.com>
Message-ID: <b717c50a-aea6-6da6-6d1d-ed5f559325ac@redhat.com>
Date: Mon, 11 May 2020 12:20:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200507144914.4zg3753uh3kytz6g@sirius.home.kraxel.org>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=mprivozn@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/11 03:10:56
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/7/20 4:49 PM, Gerd Hoffmann wrote:
>    Hi,
> 
> For usb device pass-through (aka -device usb-host) it would be very
> useful to pass file handles from libvirt to qemu.  The workflow would
> change from ...
> 
>    (1) libvirt enables access to /dev/usb/$bus/$dev
>    (2) libvirt passes $bus + $dev (using hostbus + hostaddr properties)
>        to qemu.
>    (3) qemu opens /dev/usb/$bus/$dev
> 
> ... to ...
> 
>    (1) libvirt opens /dev/usb/$bus/$dev
>    (2) libvirt passes filehandle to qemu.
> 
> Question is how can we pass the file descriptor best?  My idea would be
> to simply add an fd property to usb-host:
> 
>   * Coldplug would be "-device usb-host,fd=<nr>" (cmd line).
>   * Hotplug would be "device_add usb-host,fd=<getfd-name>" (monitor).
> 
> Will that work from libvirt point of view?
> Or does anyone have an better idea?
> 
> thanks,
>    Gerd
> 
> PS: background: https://bugzilla.redhat.com/show_bug.cgi?id=1595525
> 

I don't have a better idea, but a little background on why libvirt even 
invented private /dev in the first place. The reason was that 
occasionally, when udev ran its rules it would overwrite the security 
labels on /dev nodes set by libvirt and thus denying access to QEMU. See:

https://bugzilla.redhat.com/show_bug.cgi?id=1354251

Now, I think there is the same risk with what you are proposing. This 
isn't problem for DAC where permissions are checked during open(), but 
it may be a problem for SELinux where each individual operation with the 
FD is inspected.

Having said that, I am not against this approach, in fact I'm in favour 
of it. Let's hope that people learned that having udev overwriting 
seclabels is a bad idea and the bug won't appear again.

Michal


