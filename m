Return-Path: <SRS0=hU7S=42=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 808A3C10F27
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 15:43:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4958A20578
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 15:43:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fL+3aK3P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4958A20578
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45312 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBKZS-0000hv-D3
	for qemu-devel@archiver.kernel.org; Mon, 09 Mar 2020 11:43:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40054)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jBKYA-0007DL-4g
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 11:42:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1jBKY8-0000lp-3p
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 11:42:38 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:43068
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1jBKY7-0000l9-VK
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 11:42:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583768554;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8qlAcVKIFwNG/f7cUCkPGwrSBuAIkiy9AGz28vFbp6g=;
 b=fL+3aK3PdD+y2HMOxMdudbJ9n1ViP+K8+v+XwhP/PFHL2Dg5obNUeWt4O+1dnEblr9+uus
 mMUC+YiMPgzQkcmW/pys2B9ClWYM7yDg7yf9Rnt5ngoj33uo5iEm66KIYd7D0FLS1fJtKh
 Mski4dUNYIZ9YcDt8R1tDFstX05U6Kg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-82-HpFqivUzNrCxPFik-YDAWA-1; Mon, 09 Mar 2020 11:42:30 -0400
X-MC-Unique: HpFqivUzNrCxPFik-YDAWA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 17FF9A0CC1;
 Mon,  9 Mar 2020 15:42:29 +0000 (UTC)
Received: from [10.3.116.177] (ovpn-116-177.phx2.redhat.com [10.3.116.177])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id BD24A272C4;
 Mon,  9 Mar 2020 15:42:25 +0000 (UTC)
Subject: Re: [PATCH v3 4/4] qemu-img: Deprecate use of -b without -F
To: Kashyap Chamarthy <kchamart@redhat.com>
References: <20200306225121.3199279-1-eblake@redhat.com>
 <20200306225121.3199279-5-eblake@redhat.com> <20200309153119.GA20640@paraplu>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <11ba06c9-fa1e-3168-0322-1859040b655e@redhat.com>
Date: Mon, 9 Mar 2020 10:42:25 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200309153119.GA20640@paraplu>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
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
Cc: Kevin Wolf <kwolf@redhat.com>, pkrempa@redhat.com, qemu-block@nongnu.org,
 libvir-list@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/9/20 10:31 AM, Kashyap Chamarthy wrote:

> After (with the patch series applied to QEMU Git):
> 
>      $> git describe
>      v4.2.0-2204-gd6c7830114
> 
>      # Create; *without* specifying "-F raw"
>      $> ~/build/qemu/qemu-img create -f qcow2 -b ./base.raw ./overlay2.qcow2
>      qemu-img: warning: Deprecated use of backing file without explicit backing format (detected format of raw)
>      Formatting './overlay2.qcow2', fmt=qcow2 size=4294967296 backing_file=./base.raw backing_fmt=raw cluster_size=65536 lazy_refcounts=off refcount_bits=16

If you'll note, this case _did_ write an implied backing_fmt=raw into 
the image.  Constrast that with creating an image on a qcow2 backing 
file, which tells you it detected a format of qcow2, but does NOT write 
backing_fmt=qcow2 into the image (this was a change from v2, at Peter's 
request).  Thus, when the backing is raw, we warn but future use of the 
image is now safe where it previously was not; when the backing file is 
non-raw, we warn but do not change our behavior, but because the backing 
file is non-raw any future probes will not be any less safe than before.

> 
>      # Rebase; *without* specifying "-F raw"
>      $> ~/build/qemu/qemu-img rebase -b base.raw overlay1.qcow2
>      qemu-img: warning: Deprecated use of backing file without explicit backing format, use of this image requires potentially unsafe format probing
> 
> 
> However, for the "Convert" case, is it correct that no warning is thrown
> for the below?
> 
>      $> ~/build/qemu/qemu-img info overlay1.qcow2
>      image: overlay1.qcow2
>      file format: qcow2
>      virtual size: 4 GiB (4294967296 bytes)
>      disk size: 196 KiB
>      cluster_size: 65536
>      backing file: base.raw
>      Format specific information:
>          compat: 1.1
>          lazy refcounts: false
>          refcount bits: 16
>          corrupt: false

We have an image with no backing format, so we had to probe.  This patch 
series did not change the behavior of opening an existing image, only 
for creating a new image (or amending an image in-place).  So the lack 
of a warning on opening the unsafe image may be desirable, but it would 
be via even more patches.

>      
>      
>      $> ~/build/qemu/qemu-img convert -f qcow2 -O qcow2 overlay1.qcow2 flattened.raw

Ouch - you are creating a qcow2 destination file named 'flattened.raw', 
which is rather confusing on your part.

However, as your destination file is being created without a backing 
image, it is to be expected that there is no warning (when there is no 
backing file, -F makes no sense).  To provoke the warning during 
convert, you'll have to also pass -B (or -o backing_file), without -o 
backing_fmt (since convert lacks the -F shorthand).

> 
>      $> echo $?
>      0
> 
>> diff --git a/docs/system/deprecated.rst b/docs/system/deprecated.rst
>> index 6c1d9034d9e3..a8ffacf54a52 100644
>> --- a/docs/system/deprecated.rst
>> +++ b/docs/system/deprecated.rst
>> @@ -376,6 +376,25 @@ The above, converted to the current supported format::
>>   Related binaries
>>   ----------------
>>
>> +qemu-img backing file without format (since 5.0.0)
>> +''''''''''''''''''''''''''''''''''''''''''''''''''
>> +
>> +The use of ``qemu-img create``, ``qemu-img rebase``, ``qemu-img
>> +convert``, or ``qemu-img amend`` to create or modify an image that
>> +depends on a backing file now recommends that an explicit backing
>> +format be provided.  This is for safety: if qemu probes a different
>> +format than what you thought, the data presented to the guest will be
>> +corrupt; similarly, presenting a raw image to a guest allows a
>> +potential security exploit if a future probe sees a non-raw image
>> +based on guest writes.  To avoid the warning message, or even future
>> +refusal to create an unsafe image, you must pass ``-o backing_fmt=``
>> +(or the shorthand ``-F`` during create) to specify the intended
>> +backing format.  You may use ``qemu-img rebase -u`` to retroactively
>> +add a backing format to an existing image.  However, be aware that
>> +there are already potential security risks to blindly using ``qemu-img
>> +info`` to probe the format of an untrusted backing image, when
>> +deciding what format to add into an existing image.
> 
> Nit: s/qemu/QEMU/g/
> 
> Ultra Nit: should this paragraph be broken down into two?  Experience
> tells people usually feel deterred read "substantial paragraphs" :-)

Could do, right before 'To avoid the warning'.

> 
> I'll report back the Amend case.  (And once I get clarification on the
> Convert scenario, I'll be happy to give Tested-by.)
> 
> [...]
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


