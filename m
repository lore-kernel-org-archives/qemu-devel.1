Return-Path: <SRS0=dYSx=4M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49822C11D2F
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 16:09:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 10E172084E
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 16:09:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SXNMtebs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10E172084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38544 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6GIj-0005iQ-62
	for qemu-devel@archiver.kernel.org; Mon, 24 Feb 2020 11:09:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38107)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1j6GHl-0004m8-9B
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 11:08:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1j6GHj-0005Vh-Th
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 11:08:45 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:21039
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1j6GHj-0005VM-QE
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 11:08:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582560523;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=duLz6/20Fy5wZho4E9qN/lk2XjaDEdr+/aAVWLCkBho=;
 b=SXNMtebsIeW4uBCl+UT3fnLeoompUUKZw3Y50lWJ5loIKs++SVDTJp6LEeKI6VvW4Yg8zC
 p3meZam9DGM0pHT1IZJhZruyiTxKDvLCniAkQ4ZSoNV0dHZck253DGu2l1aGR9xFlFwhbH
 ioIfczETbo28GEYZ8stP0131YLhCrDc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-340-ElfeYob4P_y8pVe3_0AYBw-1; Mon, 24 Feb 2020 11:08:35 -0500
X-MC-Unique: ElfeYob4P_y8pVe3_0AYBw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DABD7802B61;
 Mon, 24 Feb 2020 16:08:34 +0000 (UTC)
Received: from [10.3.116.90] (ovpn-116-90.phx2.redhat.com [10.3.116.90])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9F0B38B759;
 Mon, 24 Feb 2020 16:08:31 +0000 (UTC)
Subject: Re: [PATCH 3/3] qemu-img: Deprecate use of -b without -F
To: Peter Krempa <pkrempa@redhat.com>
References: <20200222112341.4170045-1-eblake@redhat.com>
 <20200222112341.4170045-4-eblake@redhat.com>
 <20200224113827.GC3296@andariel.pipo.sk>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <1125d96f-27f5-1882-9591-538e644a9a49@redhat.com>
Date: Mon, 24 Feb 2020 10:08:31 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200224113827.GC3296@andariel.pipo.sk>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: libvir-list@redhat.com, Kevin Wolf <kwolf@redhat.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/24/20 5:38 AM, Peter Krempa wrote:
> On Sat, Feb 22, 2020 at 05:23:41 -0600, Eric Blake wrote:
>> Creating an image that requires format probing of the backing image is
>> inherently unsafe (we've had several CVEs over the years based on
>> probes leaking information to the guest on a subsequent boot).  If our
>> probing algorithm ever changes, or if other tools like libvirt
>> determine a different probe result than we do, then subsequent use of
>> that backing file under a different format will present corrupted data
>> to the guest.  Start a deprecation clock so that future qemu-img can
>> refuse to create unsafe backing chains that would rely on probing.
>>
>> However, there is one time where probing is safe: when we first create
>> an image, no guest has yet used the new image, so as long as we record
>> what we probed, all future uses of the image will see the same data -
> 
> I disagree. If you are creating an overlay on top of an existing image
> it's not safe to probe the format any more generally. (obviously you'd
> have to trust the image and express the trust somehow)
> 
> The image may have been used in a VM as raw and that means that the VM
> might have recorded a valid qcow2 header into it. Creating the overlay
> with probing would legitimize this.
> 
> Let's assume we have a malicious image written by the guest but we
> simulate it by:
> 

> b) Now with this patchset:
> 
> $ ./qemu-img create -f qcow2 -b /tmp/malicious /tmp/post-patch.qcow2
> qemu-img: warning: Deprecated use of non-raw backing file without explicit backing format, using detected format of qcow2
> Formatting '/tmp/post-patch.qcow2', fmt=qcow2 size=2560 backing_file=/tmp/malicious backing_fmt=qcow2 cluster_size=65536 lazy_refcounts=off refcount_bits=16

> 
> You now get a warning, but "backing file format" is now recorded in the
> overlay. Now this is WAY worse than it was before. The overlay now
> legitimizes the format recorded by the malicious guest which circumvents
> libvirt's protections. The warning is very easy to miss, and if you run
> it in scripts you might never get to see it. We can't allow that.

Good point.  I'll respin this series where v2 never writes the implicit 
format except for a raw image (because probing raw is not only safe to 
record, but also prevents the guest from ever changing that probe, and 
the real risk we are interested in preventing is when a formerly raw 
image later probes as non-raw).

> 
> 
>> so the code now records the probe results as if the user had passed
>> -F.  When this happens, it is unconditionally safe to record a probe
>> of 'raw', but any other probe is still worth warning the user in case
> 
> While it's safe I don't think it should be encouraged. IMO -F should be
> made mandatory with -b.

Making it mandatory will require the completion of the deprecation 
period.  For 5.0 and 5.1, the best we can do is the warning, but for 5.2 
(assuming v2 of this series is acceptable), it WILL become a hard error.

> 
>> our probe differed from their expectations.  Similarly, if the backing
>> file name uses the json: psuedo-protocol, the backing name includes
>> the format.
> 
> Not necessarily. The backing store string can be e.g.:
> 
> $ ./qemu-img create -f qcow1 -b 'json:{"driver":"file","filename":"/tmp/malicious"}' /tmp/json.qcow2
> Formatting '/tmp/json.qcow1', fmt=qcow2 size=197120 backing_file=json:{"driver":"file",,"filename":"/tmp/malicious"} cluster_size=65536 lazy_refcounts=off refcount_bits=16
> $ qemu-img info /tmp/json.qcow1
> image: /tmp/json.qcow1
> file format: qcow1
> virtual size: 191 KiB (197120 bytes)
> disk size: 195 KiB
> cluster_size: 65535
> backing file: json:{"driver":"file","filename":"/tmp/malicious"}
> Format specific information:
>      compat: 0.1
>      lazy refcounts: false
>      refcount bits: 15
>      corrupt: false
> 
> Now this has the old semantics but we didn't even get the warning. But
> at least the backing file format is not written into the overlay.

Hmm.  json:{"driver":"qcow2",...} encodes the format, but your argument 
is that json:{"driver":"file",...} encodes only the protocol but not the 
format.  We want the warning when there is no format, but with json:, it 
becomes harder to tell if a format is present or not.  I'll have to 
think about what to do in that case.


>> +++ b/block.c
>> @@ -6013,6 +6013,15 @@ void bdrv_img_create(const char *filename, const char *fmt,
>>                                 "Could not open backing image to determine size.\n");
>>               goto out;
>>           } else {
>> +            if (!backing_fmt && !strstart(backing_file, "json:", NULL)) {
>> +                backing_fmt = bs->drv->format_name;
>> +                qemu_opt_set(opts, BLOCK_OPT_BACKING_FMT, backing_fmt, NULL);
> 
> We must never write the detected format into the overlay. Not even when
> we print a warning. This can legitimize a malicious file if the user
> mises the warning.
> 

Point taken. v2 will address this differently.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


