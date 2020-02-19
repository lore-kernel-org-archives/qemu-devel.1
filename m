Return-Path: <SRS0=HiY9=4H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CE19C34031
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 03:03:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 270FC22B48
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 03:03:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K394O9gk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 270FC22B48
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44888 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4Fdr-0004J9-9U
	for qemu-devel@archiver.kernel.org; Tue, 18 Feb 2020 22:03:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56774)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laine@redhat.com>) id 1j4FdF-0003nj-HG
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 22:02:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laine@redhat.com>) id 1j4FdD-00019c-Rh
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 22:02:36 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:40970
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <laine@redhat.com>) id 1j4FdD-00016J-Lk
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 22:02:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582081354;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=l4ZIpewIRJ8wnM01zZGbxaKtYylb08NNxAPHUWOMTPQ=;
 b=K394O9gkPhN2y3baCgR3MePOjzi1LXPQbi3FmzRcJDDNGTFBYDzHq6FImdmHYaV4kSrcPk
 ilbHJPq/TBv2RA7/nr2XYJpyRr/vR0pT1mziqorqfRBfRILsj/0MoHJHZIwqVmJMY+ZnhZ
 BEyuAa452+aoIQVQv01pvGQqRc6qQsw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-113-Txn-Vgh2NlGeaDX4cioJKA-1; Tue, 18 Feb 2020 22:02:30 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CBABAA0CC0
 for <qemu-devel@nongnu.org>; Wed, 19 Feb 2020 03:02:29 +0000 (UTC)
Received: from [10.10.125.146] (ovpn-125-146.rdu2.redhat.com [10.10.125.146])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 11B9A90533;
 Wed, 19 Feb 2020 03:02:21 +0000 (UTC)
Subject: Re: [PATCH] pcie_root_port: Add disable_hotplug option
To: QEMU Developers <qemu-devel@nongnu.org>
References: <20200218161717.386723-1-jusual@redhat.com>
 <d872dcc7-9275-1354-ce6a-7dd52ac33929@redhat.com>
 <CAMDeoFVQis-UXKpGZNJkD9NqyozwUxW+nn_h6iv+f-EgkLeRKw@mail.gmail.com>
From: Laine Stump <laine@redhat.com>
Message-ID: <9ea6a6b9-778d-78a8-1909-dce1ed98a24d@redhat.com>
Date: Tue, 18 Feb 2020 22:02:19 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CAMDeoFVQis-UXKpGZNJkD9NqyozwUxW+nn_h6iv+f-EgkLeRKw@mail.gmail.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: Txn-Vgh2NlGeaDX4cioJKA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
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
Cc: Igor Mammedov <imammedo@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Julia Suvorova <jusual@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/18/20 1:40 PM, Julia Suvorova wrote:
> On Tue, Feb 18, 2020 at 6:18 PM Laine Stump <laine@redhat.com> wrote:
>>
>> On 2/18/20 11:17 AM, Julia Suvorova wrote:
>>> Make hot-plug/hot-unplug on PCIe Root Ports optional to allow libvirt
>>> to manage it and restrict unplug for the entire machine. This is going
>>> to prevent user-initiated unplug in guests (Windows mostly).
>>> Usage:
>>>       -device pcie-root-port,disable-hotplug=true,...
>>
>> Double negatives (e.g. "disable-hotplug=false") tend to confuse simple
>> minds like mine. Would it be any more difficult to make the name of the
>> option positive instead (e.g. "enable-hotplug") with the default set to
>> "true"?
> 
> disable-hotplug=false will not be used, because it's default. And it
> follows previous naming (''disable-acs').

Yeah, I don't like the name of that one either (or of "disable-modern" 
or "disable-legacy") but I don't follow qemu-devel closely so I didn't 
see them when their patches went by. But now is my chance to complain :-)

I can live with it either way, but still think it's much better to not 
have "negative" option names. Feel free to ignore, and I'll just be 
happy that I didn't accept it silently.

Also, is there a rhyme/reason for some options having true/false, and 
some being off/on? disable-acs seems to be true/false, but 
disable-modern is on/off. Doesn't make any difference to me in the end, 
but just thought I'd bring it up in case there might be a reason to use 
on/off instead of true/false for this one.


