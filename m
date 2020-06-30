Return-Path: <SRS0=gXk/=AL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21BA5C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 10:37:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF36C20675
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 10:37:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gCsKaKg1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF36C20675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53332 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqDdv-0005lN-73
	for qemu-devel@archiver.kernel.org; Tue, 30 Jun 2020 06:37:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39430)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lvivier@redhat.com>)
 id 1jqDcR-0003oU-NH
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 06:36:03 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:29302
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <lvivier@redhat.com>)
 id 1jqDcP-0001zS-8e
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 06:36:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593513360;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=izLaZZy0I0ElMze9qozpDReWvDsuvhCzvl2nLOvoRiY=;
 b=gCsKaKg14UxgZfY3lCK266vyHDRONN7s4MmiaiG44+2eLcdQfMFIZCGXLATgWIHFLhabBg
 Vfyy8XuUGqR5FW/OxL2oc4/s9deH/oezjHJ3nevqY8t4wg0VYAq+mnfk0Y6DrTtgqaGbmB
 DrDhpQd5j5HHqgztZxIbqEoa9ZHSwwE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-4-cy3CEOaeNjGPI4rDCx_JGQ-1; Tue, 30 Jun 2020 06:35:56 -0400
X-MC-Unique: cy3CEOaeNjGPI4rDCx_JGQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5B2F58015CE;
 Tue, 30 Jun 2020 10:35:55 +0000 (UTC)
Received: from [10.36.114.211] (ovpn-114-211.ams2.redhat.com [10.36.114.211])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 10BB128573;
 Tue, 30 Jun 2020 10:35:46 +0000 (UTC)
Subject: Re: [PATCH] net: tap: check if the file descriptor is valid before
 using it
To: Jason Wang <jasowang@redhat.com>, =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?=
 <berrange@redhat.com>
References: <20200624190009.300069-1-lvivier@redhat.com>
 <20200625084835.GB1009994@redhat.com>
 <541b40c5-ee72-d37d-1c30-664775812d1b@redhat.com>
 <929203d2-20d2-7caf-e487-6bfe5b851974@redhat.com>
 <ea94fa3c-edb5-220e-e0e0-4b7fca7b90e8@redhat.com>
 <b912e24c-8dc5-7022-6ed2-cf10d72ef6e7@redhat.com>
 <20200630092318.GE1370404@redhat.com> <20200630093148.GF1370404@redhat.com>
 <247f4aa8-1846-c5ec-4fe3-1d344979ad52@redhat.com>
 <d24b43e9-5a8c-1cc0-9d1c-4ee01a8cbbca@redhat.com>
From: Laurent Vivier <lvivier@redhat.com>
Autocrypt: addr=lvivier@redhat.com; prefer-encrypt=mutual; keydata=
 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
 D+Ofp0T3KOr1RUHvCZoLURfFhSQ=
Message-ID: <7a110325-0123-53da-604d-8a9374903782@redhat.com>
Date: Tue, 30 Jun 2020 12:35:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <d24b43e9-5a8c-1cc0-9d1c-4ee01a8cbbca@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=lvivier@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=lvivier@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/30 03:55:26
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: qemu-devel@nongnu.org, Stefan Weil <sw@weilnetz.de>,
 Gerd Hoffmann <kraxel@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 30/06/2020 12:03, Jason Wang wrote:
> 
> On 2020/6/30 下午5:45, Laurent Vivier wrote:
>> On 30/06/2020 11:31, Daniel P. Berrangé wrote:
>>> On Tue, Jun 30, 2020 at 10:23:18AM +0100, Daniel P. Berrangé wrote:
>>>> On Tue, Jun 30, 2020 at 05:21:49PM +0800, Jason Wang wrote:
>>>>> On 2020/6/30 上午3:30, Laurent Vivier wrote:
>>>>>> On 28/06/2020 08:31, Jason Wang wrote:
>>>>>>> On 2020/6/25 下午7:56, Laurent Vivier wrote:
>>>>>>>> On 25/06/2020 10:48, Daniel P. Berrangé wrote:
>>>>>>>>> On Wed, Jun 24, 2020 at 09:00:09PM +0200, Laurent Vivier wrote:
>>>>>>>>>> qemu_set_nonblock() checks that the file descriptor can be
>>>>>>>>>> used and, if
>>>>>>>>>> not, crashes QEMU. An assert() is used for that. The use of
>>>>>>>>>> assert() is
>>>>>>>>>> used to detect programming error and the coredump will allow
>>>>>>>>>> to debug
>>>>>>>>>> the problem.
>>>>>>>>>>
>>>>>>>>>> But in the case of the tap device, this assert() can be
>>>>>>>>>> triggered by
>>>>>>>>>> a misconfiguration by the user. At startup, it's not a real
>>>>>>>>>> problem,
>>>>>>>>>> but it
>>>>>>>>>> can also happen during the hot-plug of a new device, and here
>>>>>>>>>> it's a
>>>>>>>>>> problem because we can crash a perfectly healthy system.
>>>>>>>>> If the user/mgmt app is not correctly passing FDs, then there's
>>>>>>>>> a whole
>>>>>>>>> pile of bad stuff that can happen. Checking whether the FD is
>>>>>>>>> valid is
>>>>>>>>> only going to catch a small subset. eg consider if fd=9 refers
>>>>>>>>> to the
>>>>>>>>> FD that is associated with the root disk QEMU has open. We'll
>>>>>>>>> fail to
>>>>>>>>> setup the TAP device and close this FD, breaking the healthy
>>>>>>>>> system
>>>>>>>>> again.
>>>>>>>>>
>>>>>>>>> I'm not saying we can't check if the FD is valid, but lets be
>>>>>>>>> clear that
>>>>>>>>> this is not offering very much protection against a broken mgmt
>>>>>>>>> apps
>>>>>>>>> passing bad FDs.
>>>>>>>>>
>>>>>>>> I agree with you, but my only goal here is to avoid the crash in
>>>>>>>> this
>>>>>>>> particular case.
>>>>>>>>
>>>>>>>> The punishment should fit the crime.
>>>>>>>>
>>>>>>>> The user can think the netdev_del doesn't close the fd, and he
>>>>>>>> can try
>>>>>>>> to reuse it. Sending back an error is better than crashing his
>>>>>>>> system.
>>>>>>>> After that, if the system crashes, it will be for the good
>>>>>>>> reasons, not
>>>>>>>> because of an assert.
>>>>>>> Yes. And on top of this we may try to validate the TAP via st_dev
>>>>>>> through fstat[1].
>>>>>> I agree, but the problem I have is to know which major(st_dev) we can
>>>>>> allow to use.
>>>>>>
>>>>>> Do we allow only macvtap major number?
>>>>>
>>>>> Macvtap and tuntap.
>>>>>
>>>>>
>>>>>> How to know the macvtap major number at user level?
>>>>>> [it is allocated dynamically: do we need to parse /proc/devices?]
>>>>>
>>>>> I think we can get them through fstat for /dev/net/tun and
>>>>> /dev/macvtapX.
>>>> Don't assume QEMU has any permission to access to these device nodes,
>>>> only the pre-opened FDs it is given by libvirt.
>>> Actually permissions are the least of the problem - the device nodes
>>> won't even exist, because QEMU's almost certainly running in a private
>>> mount namespace with a minimal /dev populated
>>>
>> I'm working on a solution using /proc/devices.
> 
> 
> Similar issue with /dev. There's no guarantee that qemu can access
> /proc/devices or it may not exist (CONFIG_PROCFS).

There is a lot of things that will not work without /proc (several tools
rely on /proc, like ps, top, lsof, mount, ...). Some information are
only available from /proc, and if /proc is there, I think /proc/devices
is always readable by everyone. Moreover /proc is already used by qemu
in several places.

It can also a best effort check.

The problem with fstat() on /dev files is to guess the /dev/macvtapX as
X varies (the same with /dev/tapY)..

> 
>> macvtap has its own major number, but tuntap use "misc" (10) major
>> number.

Another question: it is possible to use the "fd=" parameter with macvtap
as macvtap creates a /dev/tapY device, but how to do that with tuntap
that does not create a /dev/tapY device?

Thanks,
Laurent


