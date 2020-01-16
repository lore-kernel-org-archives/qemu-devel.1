Return-Path: <SRS0=QWrs=3F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F3F3C33CB1
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 13:05:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE2DF20730
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 13:05:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aFugRGkK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE2DF20730
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41686 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1is4px-0001Ui-1F
	for qemu-devel@archiver.kernel.org; Thu, 16 Jan 2020 08:05:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39133)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mprivozn@redhat.com>) id 1is4oM-0008VZ-9L
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 08:03:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mprivozn@redhat.com>) id 1is4oI-0005hY-T7
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 08:03:46 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:24947
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mprivozn@redhat.com>) id 1is4oI-0005fo-O0
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 08:03:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579179820;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZpCtwniMcjmPDzOfIN1E21y1btQf8P8owQQZ5F/0kQw=;
 b=aFugRGkKSCNZr2J5peDWc35prwVLtfJOxEnbqGI/ZPc4/B8FZPFDeu9AFKOK8gzPH+jCyd
 yKrxfEzPe6zENnSOV56LgLEGCro122OT2UckmGQ6htMxSZkfI9UdgDK5m3JSCjIzRRSECN
 oq61BVVYlnh6vPSaZ2Iwudjoep2Nhww=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-389-0KTUJ0lfPJCA0GoeGiKlEg-1; Thu, 16 Jan 2020 08:03:38 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 122E8800D48;
 Thu, 16 Jan 2020 13:03:37 +0000 (UTC)
Received: from [10.43.2.30] (unknown [10.43.2.30])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 72D87845AA;
 Thu, 16 Jan 2020 13:03:13 +0000 (UTC)
Subject: Re: [libvirt] [PATCH v2 82/86] numa: forbid '-numa node, mem' for 5.0
 and newer machine types
To: Igor Mammedov <imammedo@redhat.com>
References: <1579100861-73692-1-git-send-email-imammedo@redhat.com>
 <1579100861-73692-83-git-send-email-imammedo@redhat.com>
 <20200115153453.GL3243410@angien.pipo.sk>
 <20200115175237.325055f3@redhat.com>
 <8b9be103-d550-853a-86ff-1dc504daab64@redhat.com>
 <20200116133703.11248ead@redhat.com>
From: Michal Privoznik <mprivozn@redhat.com>
Message-ID: <5db41e0c-866d-0662-a2a3-f2c71ebff103@redhat.com>
Date: Thu, 16 Jan 2020 14:03:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200116133703.11248ead@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: 0KTUJ0lfPJCA0GoeGiKlEg-1
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
Cc: peter.maydell@linaro.org, Peter Krempa <pkrempa@redhat.com>,
 ehabkost@redhat.com, mst@redhat.com, libvir-list@redhat.com,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, qemu-ppc@nongnu.org,
 pbonzini@redhat.com, rth@twiddle.net, david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/16/20 1:37 PM, Igor Mammedov wrote:
> On Thu, 16 Jan 2020 11:42:09 +0100
> Michal Privoznik <mprivozn@redhat.com> wrote:
> 
>> On 1/15/20 5:52 PM, Igor Mammedov wrote:
>>> On Wed, 15 Jan 2020 16:34:53 +0100
>>> Peter Krempa <pkrempa@redhat.com> wrote:
>>>    
>>>> On Wed, Jan 15, 2020 at 16:07:37 +0100, Igor Mammedov wrote:
>>>>> Deprecation period is ran out and it's a time to flip the switch
>>>>> introduced by cd5ff8333a.
>>>>> Disable legacy option for new machine types and amend documentation.
>>>>>
>>>>> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
>>>>> ---
>>>>> CC: peter.maydell@linaro.org
>>>>> CC: ehabkost@redhat.com
>>>>> CC: marcel.apfelbaum@gmail.com
>>>>> CC: mst@redhat.com
>>>>> CC: pbonzini@redhat.com
>>>>> CC: rth@twiddle.net
>>>>> CC: david@gibson.dropbear.id.au
>>>>> CC: libvir-list@redhat.com
>>>>> CC: qemu-arm@nongnu.org
>>>>> CC: qemu-ppc@nongnu.org
>>>>> ---
>>>>>    hw/arm/virt.c        |  2 +-
>>>>>    hw/core/numa.c       |  6 ++++++
>>>>>    hw/i386/pc.c         |  1 -
>>>>>    hw/i386/pc_piix.c    |  1 +
>>>>>    hw/i386/pc_q35.c     |  1 +
>>>>>    hw/ppc/spapr.c       |  2 +-
>>>>>    qemu-deprecated.texi | 16 ----------------
>>>>>    qemu-options.hx      |  8 ++++----
>>>>>    8 files changed, 14 insertions(+), 23 deletions(-)
>>>>
>>>> I'm afraid nobody bothered to fix it yet:
>>>>
>>>> https://bugzilla.redhat.com/show_bug.cgi?id=1783355
>>>
>>> It's time to start working on it :)
>>> (looks like just deprecating stuff isn't sufficient motivation,
>>> maybe actual switch flipping would work out better)
>>>    
>>
>> So how was the upgrade from older to newer version resolved? I mean, if
>> the old qemu used -numa node,mem=XXX and it is migrated to a host with
>> newer qemu, the cmd line can't be switched to -numa node,memdev=node0,
>> can it? I'm asking because I've just started working on this.
> 
> see commit cd5ff8333a3c87 for detailed info.
> Short answer is it's not really resolved [*],
> -numa node,mem will keep working on newer QEMU but only for old machine types
> new machine types will accept only -numa node,memdev.
> 
> One can check if "mem=' is supported by using QAPI query-machines
> and checking numa-mem-supported field. That field is flipped to false
> for 5.0 and later machine types in this patch.

Alright, so what we can do is the following:

1) For new machine types (pc-5.0/q35-5.0 and newer) use memdev= always.

2) For older machine types, we are stuck with mem= until qemu is capable 
of migrating from mem= to memdev=

I think this is a safe thing to do since migrating from one version of a 
machine type to another is not supported (since it can change guest 
ABI). And we will see how much 2) bothers us. Does this sound reasonable?

Michal


