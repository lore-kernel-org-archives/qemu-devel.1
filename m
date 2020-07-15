Return-Path: <SRS0=mmJ2=A2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 061BAC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2020 17:39:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C2BF020656
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2020 17:39:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KwabuZiq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2BF020656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45936 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvlNp-0005KM-0U
	for qemu-devel@archiver.kernel.org; Wed, 15 Jul 2020 13:39:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50690)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1jvlN6-0004tr-Hz
 for qemu-devel@nongnu.org; Wed, 15 Jul 2020 13:39:08 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:49754
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1jvlN2-0002N9-LE
 for qemu-devel@nongnu.org; Wed, 15 Jul 2020 13:39:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594834743;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=+xlLva0eKpMVDEVGY5RTB6JZwsUe9KvRR46L+7DiHsk=;
 b=KwabuZiqFB8PKxVFjxl497btx5KUMl6YnV1eLhmNmgcPo5/nECxTEJyArZPWZzImBl2J+R
 X99oEQ/z4dOHTIBw3xGA1uI8DFu1qn7+B0X5xnjCpwD7Ay4VKYd+TdJxkYOS7eJr/LI2dR
 nqlL24SXBKU85A3paUrUtAhKAzOMIxo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-255--rX7a0UBNyOQZ9ekWf5EkQ-1; Wed, 15 Jul 2020 13:38:58 -0400
X-MC-Unique: -rX7a0UBNyOQZ9ekWf5EkQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 31DE88014D4;
 Wed, 15 Jul 2020 17:38:56 +0000 (UTC)
Received: from [10.36.112.109] (ovpn-112-109.ams2.redhat.com [10.36.112.109])
 by smtp.corp.redhat.com (Postfix) with ESMTP id ED83E2B6D6;
 Wed, 15 Jul 2020 17:38:50 +0000 (UTC)
Subject: Re: [PATCH RFC 2/5] s390x: implement diag260
To: Heiko Carstens <hca@linux.ibm.com>
References: <20200713091243.GB4359@osiris>
 <07E9FD5B-F07F-415B-9C00-A2A882F07CBC@redhat.com>
 <92b1a2a6-2348-d4ff-6d20-35f3bfef710a@de.ibm.com>
 <a0b52f65-d253-c51b-6dfc-0a61f939c759@redhat.com>
 <20200715104348.GB6927@osiris>
 <3c163740-6299-a3dd-8b4d-58a5be123b0e@redhat.com>
 <20200715113426.GD6927@osiris>
 <30ba06e7-5e84-9683-5b37-623f40b3a6db@redhat.com>
 <20200715161451.GB3934@osiris>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; prefer-encrypt=mutual; keydata=
 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
 WNyWQQ==
Organization: Red Hat GmbH
Message-ID: <d612da2a-c8fb-ffa6-0913-6cc0ec9b0f7f@redhat.com>
Date: Wed, 15 Jul 2020 19:38:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200715161451.GB3934@osiris>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=david@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/15 05:07:28
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=unavailable autolearn_force=no
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
Cc: Thomas Huth <thuth@redhat.com>, Janosch Frank <frankja@linux.ibm.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 qemu-devel@nongnu.org, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
 Claudio Imbrenda <imbrenda@linux.ibm.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 15.07.20 18:14, Heiko Carstens wrote:
> On Wed, Jul 15, 2020 at 01:42:02PM +0200, David Hildenbrand wrote:
>>> So, are you saying that even at IPL time there might already be memory
>>> devices attached to the system? And the kernel should _not_ treat them
>>> as normal memory?
>>
>> Sorry if that was unclear. Yes, we can have such devices (including
>> memory areas) on a cold boot/reboot/kexec. In addition, they might pop
>> up at runtime (e.g., hotplugging a virtio-mem device). The device is in
>> charge of exposing that area and deciding what to do with it.
>>
>> The kernel should never treat them as normal memory (IOW, system RAM).
>> Not during a cold boot, not during a reboot. The device driver is
>> responsible for deciding how to use that memory (e.g., add it as system
>> RAM), and which parts of that memory are actually valid to be used (even
>> if a tprot might succeed it might not be valid to use just yet - I guess
>> somewhat similar to doing a tport on a dcss area - AFAIK, you also don't
>> want to use it like normal memory).
>>
>> E.g., on x86-64, memory exposed via virtio-mem or virtio-pmem is never
>> exposed via the e820 map. The only trace that there might be *something*
>> now/in the future is indicated via ACPI SRAT tables. This takes
>> currently care of indicating the maximum possible PFN.
> 
> Ok, but all of this needa to be documented somewhere. This raises a
> couple of questions to me:

I assume this mostly targets virtio-mem, because the semantics of
virtio-mem provided memory are extra-weird (in contrast to rather static
virtio-pmem, which is essentially just an emulated NVDIMM - a disk
mapped into physical memory).

Regarding documentation (some linked in the cover letter), so far I have
(generic/x86-64)

1. https://virtio-mem.gitlab.io/
2. virtio spec proposal [1]
3. QEMU 910b25766b33 ("virtio-mem: Paravirtualized memory hot(un)plug")
4. Linux 5f1f79bbc9 ("virtio-mem: Paravirtualized memory hotplug")
5. Linux cover letter [2]
6. KVM forum talk [3] [4]

As your questions go quite into technical detail, and I don't feel like
rewriting the doc here :) , I suggest looking at [2], 1, and 5.

> 
> What happens on

I'll stick to virtio-mem when answering regarding "special memory". As I
noted, there might be more in the future.

> 
> - IPL Clear with this special memory? Will it be detached/away afterwards?

A diag308(0x3) - load clear - will usually* zap all virtio-mem provided
memory (discard backing storage in the hypervisor) and logically turn
the state of all virtio-mem memory inside the device-assigned memory
region to "unplugged" - just as during a cold boot. The semantics of
"unplugged" blocks depend on the "usable region" (see the virtio-spec if
you're curious - the memory might still be accessible). Starting "fresh"
with all memory logically unplugged is part of the way virtio-mem works.

* there are corner cases while a VM is getting migrated, where we cannot
perform this (similar, to us not being able to clear ordinary memory
during a load clear in QEMU while migrating). In this case, the memory
is left untouched.

> - IPL Normal? "Obviously" it must stay otherwise kdump would never see
>   that memory.

Only diag308(0x3) will mess with virtio-mem memory. For the other types
of resets, its left untouched. So yes, "obviously" is correct :)

> 
> And when you write it's up to the device driver what to with that
> memory: is there any documentation available what all of this is good
> for? I would assume _most likely_ this extra memory is going to be
> added to ZONE_MOVABLE _somehow_ so that it can be taken away also. But
> since it is not normal memory, like you say, I'm wondering how that is
> supposed to work.

For now

1. virtio-mem adds all (possible) aligned memory via add_memory() to Linux
2. Requires user space to online the memory blocks / configure a zone.

For 2., only ZONE_NORMAL really works right now and is recommended to
use. As you correctly note, that does not give you any guarantees how
much memory you can unplug again (e.g, fragmentation with unmovable
data), but is good enough for the first version (with focus on memory
hotplug, not unplug). ZONE_MOVABLE support is in the works.

However, we cannot blindly expose all memory to ZONE_MOVABLE (zone
imbalances leading to rashes), and sometimes also don't want to (e.g.,
gigantic pages). Without spoilering too much, a mixture would be nice.

> 
> As far as I can tell there would be a lot of inconsistencies in
> userspace interfaces which provide memory / zone information. Or I'm
> not getting the point of all of this at all.

All memory/zone stats are properly fixed up (similar to ballooning). The
only visible inconsistency that *might* happen when unplugging memory /
hotplugging memory in <256MB on s390x, is that the number of memory
block devices (/sys/devices/system/memory/...) might indicate more
memory than actually available (e.g., via lsmem).


[1]
https://lists.oasis-open.org/archives/virtio-comment/202006/msg00012.html
[2] https://lore.kernel.org/kvm/20200311171422.10484-1-david@redhat.com/
[3]
https://events19.linuxfoundation.org/wp-content/uploads/2017/12/virtio-mem-Paravirtualized-Memory-David-Hildenbrand-Red-Hat-1.pdf
[4] https://www.youtube.com/watch?v=H65FDUDPu9s

-- 
Thanks,

David / dhildenb


