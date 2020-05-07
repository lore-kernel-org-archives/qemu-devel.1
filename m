Return-Path: <SRS0=s5cl=6V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5906CC38A24
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 17:13:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 265142083B
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 17:13:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eoQC+tRa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 265142083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39426 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWk56-00046Z-BU
	for qemu-devel@archiver.kernel.org; Thu, 07 May 2020 13:13:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51860)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jWjyL-00012H-F0
 for qemu-devel@nongnu.org; Thu, 07 May 2020 13:06:09 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:26078
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jWjyK-0003vC-Cm
 for qemu-devel@nongnu.org; Thu, 07 May 2020 13:06:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588871166;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=24ji67Wto9wg2Nq2pqFsOTJiytmyJPV+loSdhjvC0Ts=;
 b=eoQC+tRakcgOJ2ZHkV7wZyl6UGyTqM7jPVHbnMe0fFWdeYzth2MS+t0wseysTUgmieISmo
 AeY3DQwT9aCj8Fnit+y0rKqlV8jG5F7sDVMEX7FtN+8tTB/AIPJ9mi1JVEaNC8NJtX6kcd
 RmtHGQ19wn1MaSKXcW0/1Cb3ty1l9WQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-428-6QNNYhRRN_mkYB_NpI0pgQ-1; Thu, 07 May 2020 13:06:01 -0400
X-MC-Unique: 6QNNYhRRN_mkYB_NpI0pgQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6D08C835B40
 for <qemu-devel@nongnu.org>; Thu,  7 May 2020 17:06:00 +0000 (UTC)
Received: from [10.3.114.73] (ovpn-114-73.phx2.redhat.com [10.3.114.73])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8FC7F1002380;
 Thu,  7 May 2020 17:05:54 +0000 (UTC)
Subject: Re: device hotplug & file handles
To: Gerd Hoffmann <kraxel@redhat.com>, libvir-list@redhat.com,
 qemu-devel@nongnu.org
References: <20200507144914.4zg3753uh3kytz6g@sirius.home.kraxel.org>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <8da20458-af1f-f80a-e4d4-97ed77754d76@redhat.com>
Date: Thu, 7 May 2020 12:05:54 -0500
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
Received-SPF: pass client-ip=205.139.110.61; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/07 02:00:54
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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

On 5/7/20 9:49 AM, Gerd Hoffmann wrote:
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

Qemu already has -add-fd (both a CLI version, and a QMP version when a 
Unix socket can pass fds), at which point any existing interface that 
uses qemu_open() will understand the magic syntax /dev/fdset/NNN to 
refer to the existing fd previously passed in via -add-fd.  Libvirt is 
already able to use this feature for some cases (for example, see 
src/qemu/qemu_command.c:qemuBuildChrChardevFileStr).  So all that 
remains is making sure -device usb-host uses qemu_open(), and if it 
didn't already do so, also making sure libvirt can find a way to 
introspect when usb-host started supporting fdset usage.

Or put another way, let's use the generic fd mechanism that qemu already 
supports, rather than inventing yet another syntax.

> 
> thanks,
>    Gerd
> 
> PS: background: https://bugzilla.redhat.com/show_bug.cgi?id=1595525
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


