Return-Path: <SRS0=X6L9=YD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55EBAC10F14
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2019 09:22:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 207952064A
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2019 09:22:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=greensocs.com header.i=@greensocs.com header.b="tchtendE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 207952064A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=greensocs.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35572 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIUeL-0001vk-5p
	for qemu-devel@archiver.kernel.org; Thu, 10 Oct 2019 05:22:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36007)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <damien.hedde@greensocs.com>) id 1iIUaT-0000rR-Au
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 05:18:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <damien.hedde@greensocs.com>) id 1iIUaS-0002Q3-6v
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 05:18:21 -0400
Received: from beetle.greensocs.com ([5.135.226.135]:35972)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <damien.hedde@greensocs.com>)
 id 1iIUaR-0002Oj-9A
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 05:18:20 -0400
Received: from [172.16.11.102] (crumble.bar.greensocs.com [172.16.11.102])
 by beetle.greensocs.com (Postfix) with ESMTPSA id 4077E96F51;
 Thu, 10 Oct 2019 09:18:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com;
 s=mail; t=1570699096;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VXgZNvFEvBq9bipsOFNgdnF18T5jVE3t7BbVhV80a4E=;
 b=tchtendEzROdl0b/8mJ7VEnX14UJ1OVHg9y8QzJqdxdZtQNmsVX6fb68pKYn9QW6PWtnA5
 mDsD08WOyRxLK7uL5YDy8JLxA3KHhj1fa9sXWlv9vSK3pl6p4TrJkGS2a/gPRtqT0PXi9v
 vCBngJFrKGtwSUGMHlUZ1GZAwUYZh0o=
Subject: Re: [PATCH v4 02/10] hw/core: create Resettable QOM interface
To: Peter Maydell <peter.maydell@linaro.org>
References: <20190821163341.16309-1-damien.hedde@greensocs.com>
 <20190821163341.16309-3-damien.hedde@greensocs.com>
 <20190911080642.GC13785@umbus.fritz.box>
 <1a3b4d7b-77a9-46af-e6f4-dc7b3ba13b4f@greensocs.com>
 <20190918091135.GA22790@umbus.fritz.box>
 <f482912f-9541-f90c-bd80-5c95322e670d@greensocs.com>
 <CAFEAcA8pja6bOh4vwqWco=1ZtqR0mJFUuZT+WjJwYuA5AZZuQg@mail.gmail.com>
From: Damien Hedde <damien.hedde@greensocs.com>
Message-ID: <e609c0a6-849c-57b5-aa5c-a261797cdc30@greensocs.com>
Date: Thu, 10 Oct 2019 11:18:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8pja6bOh4vwqWco=1ZtqR0mJFUuZT+WjJwYuA5AZZuQg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US-large
Content-Transfer-Encoding: 7bit
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com; 
 s=mail; t=1570699096;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VXgZNvFEvBq9bipsOFNgdnF18T5jVE3t7BbVhV80a4E=;
 b=vI87+iCvo/K4kVw6KeSpMuzfiufQ9ByrVqIXQxr04oAXV670whfTb/kH3adaDkLInJmRvt
 8Ynq6OHQri3pFDxgwQdGYZ4YvJNCZTcf5Iu81sPJVY6vfSUPEL8WzFR7phjxESw0GjvEUh
 P0hEtlzXaHL1Jb6/MbEZmINMX7kzoMI=
ARC-Seal: i=1; s=mail; d=greensocs.com; t=1570699096; a=rsa-sha256; cv=none;
 b=SSz7wUw4EdzYPRjVaSI9kjYS5fIhzOQHi7Dsm0dhSh/hnkR2z/4oFT2MJjH/xB55yDqKHe
 aITVXkVTltA8Vfvp6bfazt6qkc2vh/iIrpIDVb+AFl8GQgtzGx7i1hRI6cVmTgf6+MbKWW
 lyP7QvNdNhJSIJq1+tuYNjhTTYiLBFc=
ARC-Authentication-Results: i=1; ORIGINATING;
 auth=pass smtp.auth=damien smtp.mailfrom=damien.hedde@greensocs.com
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 5.135.226.135
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
Cc: Edgar Iglesias <edgar.iglesias@xilinx.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Mark Burton <mark.burton@greensocs.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/27/19 3:07 PM, Peter Maydell wrote:
> On Tue, 24 Sep 2019 at 12:21, Damien Hedde <damien.hedde@greensocs.com> wrote:
> 
> My takes:
>  * I think we should keep the reset type. Among other things,
>    we probably want a reset type for "PCI bus reset" and
>    "SCSI bus reset", when we come to conversion of those
>  * I don't have an opinion about the phase names
>  * I think we should look at what we're doing for dynamic
>    changes of the reset tree. This falls into two parts,
>    both of which have come up in this thread:
>     - hotplug, ie what state should a hotplugged device
>       get set up to if it's plugged into a bus that's
>       currently in reset
>     - the modification of the qbus tree during reset,
>       like the raspi sd card thing
>    These feel related to me, so maybe handling the first
>    gives a better answer to handling the second ?
> 

Sorry for the delayed answer, I did not had much time to work on this
last week.

Regarding hotplug, right now hotplugged device are reset during the
'realize' step. So here is what I propose:
+ we always do the phase 1 and 2.
+ do the 3rd phase (to leave reset) if the device is not plugged in a
bus under reset.

For general case, like the raspi, it can be handled in set_parent_bus()
qdev function.

Damien

