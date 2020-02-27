Return-Path: <SRS0=0TZc=4P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09A88C4BA24
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 13:14:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C8AA22469C
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 13:14:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OPBkyIn8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8AA22469C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59376 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7Izt-0008Tl-0n
	for qemu-devel@archiver.kernel.org; Thu, 27 Feb 2020 08:14:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55963)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1j7Iz8-00082k-TZ
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 08:13:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1j7Iz7-00008Y-Hw
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 08:13:50 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:37913
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1j7Iz7-00007r-Cw
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 08:13:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582809228;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TgODs2ZV/ZseqmmgbES5jOYp1Z14NQ6YyDoUgT9cCHY=;
 b=OPBkyIn8RFuCEQGHC+BGcqN0CcdDteacrDsgRipbcckWmxyqwXuxgiXDVnbkQgs/R0z/a8
 DdDnThSscUeGghnC37JW2Ss4Wy1CeXHKGpBFtMF+U6siNAksJCgf7bYPflyksqttCRl6Yl
 KDQ8m+PmsgfF5KC34JOBr9pWUbpSJZ8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-412-8mAaAddaNyGKKuULrCAMwA-1; Thu, 27 Feb 2020 08:13:47 -0500
X-MC-Unique: 8mAaAddaNyGKKuULrCAMwA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 18C1E8017CC;
 Thu, 27 Feb 2020 13:13:46 +0000 (UTC)
Received: from [10.3.116.57] (ovpn-116-57.phx2.redhat.com [10.3.116.57])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A087F87B08;
 Thu, 27 Feb 2020 13:13:42 +0000 (UTC)
Subject: Re: [PATCH v2 3/3] qemu-img: Deprecate use of -b without -F
To: Peter Krempa <pkrempa@redhat.com>
References: <20200227023928.1021959-1-eblake@redhat.com>
 <20200227023928.1021959-4-eblake@redhat.com>
 <20200227070925.GB2110@andariel.pipo.sk>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <821448ee-0b0d-75a3-66c5-9f35a6f44048@redhat.com>
Date: Thu, 27 Feb 2020 07:13:42 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200227070925.GB2110@andariel.pipo.sk>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
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

On 2/27/20 1:09 AM, Peter Krempa wrote:
> On Wed, Feb 26, 2020 at 20:39:28 -0600, Eric Blake wrote:
>> Creating an image that requires format probing of the backing image is
>> inherently unsafe (we've had several CVEs over the years based on
>> probes leaking information to the guest on a subsequent boot).  If our
>> probing algorithm ever changes, or if other tools like libvirt
>> determine a different probe result than we do, then subsequent use of
>> that backing file under a different format will present corrupted data
>> to the guest.  Start a deprecation clock so that future qemu-img can
>> refuse to create unsafe backing chains that would rely on probing.
>>
>> However, there is one time where probing is safe: if we probe raw,
>> then it is safe to record that implicitly in the image (but we still
>> warn, as it's better to teach the user to supply -F always than to
>> make them guess when it is safe).
>>
>> iotest 114 specifically wants to create an unsafe image for later
>> amendment rather than defaulting to our new default of recording a
>> probed format, so it needs an update.
>>
>> Signed-off-by: Eric Blake <eblake@redhat.com>
>> ---
>>   qemu-deprecated.texi       | 15 +++++++++++++++
>>   block.c                    | 21 ++++++++++++++++++++-
>>   qemu-img.c                 |  8 +++++++-
>>   tests/qemu-iotests/114     |  4 ++--
>>   tests/qemu-iotests/114.out |  1 +
>>   5 files changed, 45 insertions(+), 4 deletions(-)
>>
>> diff --git a/qemu-deprecated.texi b/qemu-deprecated.texi
>> index 66eca3a1dede..f99b49addccc 100644
>> --- a/qemu-deprecated.texi
>> +++ b/qemu-deprecated.texi
>> @@ -309,6 +309,21 @@ The above, converted to the current supported format:
>>
>>   @section Related binaries
>>
>> +@subsection qemu-img backing file without format (since 5.0.0)
>> +
>> +The use of @command{qemu-img create}, @command{qemu-img rebase},
>> +@command{qemu-img convert}, or @command{qemu-img ament} to create or
> 
> s/ament/amend/
> 

Fixing.  (Do you ever wonder if I leave a typo in, just to check that 
reviewers were actually reviewing?  But in this case, it was a symptom 
of me posting a series late at night to start the review process, even 
though I _really_ need to post a v3 that adds even more iotest coverage 
of every new deprecation warning made possible in this patch)

>> +modify an image that depends on a backing file now recommends that an
>> +explicit backing format be provided.  This is for safety - if qemu
>> +probes a different format than what you thought, the data presented to
>> +the guest will be corrupt; similarly, presenting a raw image to a
>> +guest allows the guest a potential security exploit if a future probe
>> +sees non-raw.  To avoid warning messages, or even future refusal to
>> +create an unsafe image, you must pass @option{-o backing_fmt=} (or
>> +shorthand @option{-F}) to specify the intended backing format.  You
>> +may use @command{qemu-img rebase -u} to retroactively add a backing
>> +format to an existing image.
> 
> I'd add a note for users who wish to fix existing images (and I need
> to add it to libvirt's knowledge base too) that when the user is unsure
> of the backing image format and desn't trust that the image was handled
> in a trusted way, they must not use the format detected by qemu-img info
> if the image specifies a backing file, unless they also trust the
> backing file. (Sorry as a non-native English speaker I can't express
> this in a more elegant way.).

Good idea.  How about:

...to retroactively add a backing format to an existing image.  However, 
be aware that there are already potential security risks to using 
'qemu-img info' to probe the format of an untrusted backing image, when 
deciding what format to write into an image with 'qemu-img rebase -u'.


> 
>>   @subsection qemu-img convert -n -o (since 4.2.0)
>>
>>   All options specified in @option{-o} are image creation options, so
> 
> [...]
> 
>> diff --git a/qemu-img.c b/qemu-img.c
>> index b9375427404d..e75ec1bdb555 100644
>> --- a/qemu-img.c
>> +++ b/qemu-img.c
>> @@ -3637,7 +3637,13 @@ static int img_rebase(int argc, char **argv)
>>        * doesn't change when we switch the backing file.
>>        */
>>       if (out_baseimg && *out_baseimg) {
>> -        ret = bdrv_change_backing_file(bs, out_baseimg, out_basefmt, false);
>> +        if (blk_new_backing && !out_basefmt) {
>> +            out_basefmt = blk_bs(blk_new_backing)->drv->format_name;
>> +            warn_report("Deprecated use of backing file "
>> +                        "without explicit backing format, using "
>> +                        "detected format of %s", out_basefmt);
> 
> Isn't this a similar instance to what I've reported in the previous
> version? You warn that the format is missing, but set out_basefmt to the
> detected format , thus bdrv_change_backing_file will then write the
> detected format into the overlay even when it previously did not?
> 
> I think this has to have the same check for raw-only as above.

Yes, I think I missed a spot (blame the late-night push to get the patch 
out the door).  I'll wait to see if I get review from the qemu side 
before posting v3, though.

> 
>> +        }
>> +        ret = bdrv_change_backing_file(bs, out_baseimg, out_basefmt, true);
> 
> or just the above line.
> 
>>       } else {
>>           ret = bdrv_change_backing_file(bs, NULL, NULL, false);
>>       }
> 
> I feel that this deprecation will be at least partially controversial,
> but in my opinion it's the correct thing to do.
> 
> Reviewed-by: Peter Krempa <pkrempa@redhat.com>
> 
> after you address the issue above.
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


