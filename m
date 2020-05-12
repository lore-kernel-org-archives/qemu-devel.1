Return-Path: <SRS0=ZOtl=62=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 989C6C2D0F7
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 21:07:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5CBDD20769
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 21:07:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H9aYp186"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CBDD20769
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50240 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYc7Z-0003x7-Gw
	for qemu-devel@archiver.kernel.org; Tue, 12 May 2020 17:07:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59706)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jYc57-0007N1-MX
 for qemu-devel@nongnu.org; Tue, 12 May 2020 17:04:53 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:44569
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jYc55-000198-L1
 for qemu-devel@nongnu.org; Tue, 12 May 2020 17:04:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589317490;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=P9B0sbw1X4GyXzJiRg7w3Q0mw8vV5uc72qRScrO7Jxw=;
 b=H9aYp186kwZGrHr46qqRxX7GYV48F7CDsZqHYMzS51egLrlVDyW4Q8AaORMO8HUmM16woY
 yeJmRikyQ7N7rZ4NllG5PleXYZ78vmWadzLwcNCWw0B9xs048SYddLcI2gGHgg6g4/VlJN
 hq058mdSvHNN+J4tw3B9CeMvDw46PlI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-397-okk4afP3Ob2hR8yT9KPLoQ-1; Tue, 12 May 2020 17:04:46 -0400
X-MC-Unique: okk4afP3Ob2hR8yT9KPLoQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6FFDC18FF660;
 Tue, 12 May 2020 21:04:45 +0000 (UTC)
Received: from [10.3.116.145] (ovpn-116-145.phx2.redhat.com [10.3.116.145])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 494B310027A6;
 Tue, 12 May 2020 21:04:36 +0000 (UTC)
Subject: Re: [PATCH v3 7/9] qcow2: Expose bitmaps' size during measure
To: Nir Soffer <nsoffer@redhat.com>
References: <20200508180340.675712-1-eblake@redhat.com>
 <20200508180340.675712-8-eblake@redhat.com>
 <CAMRbyytP9LvMVJ1R1EEnjHJGKOXtOYg_=ywqn-yVDLBeqFff4g@mail.gmail.com>
 <d0c62eef-acf6-0996-4928-1836940e2901@redhat.com>
 <1a9f1d01-5b9a-ac35-334e-1fe090682621@redhat.com>
 <CAMRbyyu=Q-EZoQcY8_JUQQOvMQ+K7W22wRf+BX+tGbShWweNYA@mail.gmail.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <ec6180be-7f1b-d230-71c1-1d624e3008e7@redhat.com>
Date: Tue, 12 May 2020 16:04:35 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAMRbyyu=Q-EZoQcY8_JUQQOvMQ+K7W22wRf+BX+tGbShWweNYA@mail.gmail.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=eblake@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/12 17:04:50
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
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
Cc: Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, qemu-block <qemu-block@nongnu.org>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/12/20 3:35 PM, Nir Soffer wrote:

>> First, a usage question: would you rather that 'qemu-img convert
>> --bitmaps' silently succeeds even when the image being converted has no
>> bitmaps, or would you rather that it fails loudly when there are no
>> bitmaps to be copied over?
> 
> I think the meaning of --bitmaps should be "copy also bitmaps".
> 
> This request makes sense only for qcow2 images, since other images do
> not have bitmaps, so failing loudly when the source format does not support
> bitmaps seems right.
> 
> Same for the target format does not support bitmaps, this is invalid request
> and it should fail loudly.
> 
> If the source and target are qcow2, and there are no bitmaps in source, I don't
> see any reason to fail. We don't want to check if an image has bitmaps before
> we copy the image, it does not help us.
> 
>> As implemented in this patch series, patch 8
>> currently silently succeeds.
> 
> Sounds good for qcow2 format.

So, to make sure I'm clear, you'll be happy with something like:

- no source
$ qemu-img measure --bitmaps -O qcow2 1G
error: --bitmaps requires source file

- src cannot support bitmaps
$ qemu-img measure --bitmaps -f raw -O qcow2 file.raw
error: raw source does not support bitmaps
$ qemu-img measure -f raw -O qcow2 file.raw
success, totals are unchanged (since there are no bitmaps)
$ qemu-img convert --bitmaps -f raw -O qcow2 file.raw file.qcow2
error: raw source does not support bitmaps

- dest cannot support bitmaps
$ qemu-img measure --bitmaps -f qcow2 -O raw file.qcow2
error: raw destination does not support bitmaps
$ qemu-img measure -f qcow2 -O raw file.qcow2
success, totals are unchanged (since there are no bitmaps)
$ qemu-img convert --bitmaps -f qcow2 -O raw file.qcow2 file.raw
error: raw destination does not support bitmaps

- another way dest cannot support bitmaps
$ qemu-img convert --bitmaps -f qcow2 -O qcow2 -o compat=0.10 \
   src.qcow2 dst.qcow2
error: v2 qcow2 destination does not support bitmaps

- src and dest support bitmaps, but there are none
$ qemu-img measure --bitmaps -f qcow2 -O qcow2 file.qcow2
success, no modification to totals since no bitmaps to copy
$ qemu-img measure -f qcow2 -O qcow2 file.qcow2
success, separate line item for 'bitmap size: 0'
$ qemu-img convert --bitmaps -f qcow2 -O qcow2 src.qcow2 dst.qcow2
success, even though no bitmaps to copy

- src and dest support bitmaps, and there are some
$ qemu-img measure --bitmaps -f qcow2 -O qcow2 file.qcow2
success, totals modified in place to include bitmaps without separate line
$ qemu-img measure -f qcow2 -O qcow2 file.qcow2
success, separate line item added for 'bitmap size: NNN'
$ qemu-img convert --bitmaps -f qcow2 -O qcow2 src.qcow2 dst.qcow2
success, and bitmaps were copied

> 
>> But in order to make patch 7 and 8
>> consistent with one another, I need to know which behavior is easier to
>> use: failing convert if the source lacks bitmaps (and thus measure would
>> suppress the bitmaps:0 output), or treating lack of bitmaps as nothing
>> additional to copy and thereby succeeding (and thus measure should
>> output bitmaps:0 to show that no additional space is needed because
>> nothing else will be copied, successfully).
> 
> I don't think showing "bitmaps: 0" in measure is related to how --bitmaps
> behave in convert. If we will have --bitmaps in measure, we don't need to
> show "bitmaps" at all since "required" will include it.

Showing 'bitmaps: 0' in the QMP is how the CLI will know whether it was 
an error to request measuring with bitmaps.

> 
> If we want to show bitmaps in measure, I think using the same logic is fine:
> - if format does not support bitmaps - fail
> - if format suppots bitmaps, show what we have - zero is valid result when
>    image does not have any bitmap.

More precisely, fail in QMP if either the source being measured cannot 
support bitmaps at all, or if the destination that determines the 
measurements cannot support bitmaps. But if both support bitmaps, then 
the QMP will output 0 if there happen to be no bitmaps to copy, and the 
CLI can add 'measure --bitmaps' to silently fold in a present bitmaps 
number (be it 0 or non-zero) into the other fields, or error if QMP did 
not include a bitmaps field.

>> And then back to my question: should 'measure --bitmaps' fail if there
>> are no bitmaps to be measured, or silently succeed and not change the
>> output size?
> 
> For raw file yes (invalid request), for qcow2 file no, it should just
> add 0 since this is the actual
> size required for bitmaps in this image.

Okay, that is slightly different than what Max was describing (which was 
to output 'bitmaps: 0' in QMP even if the source is raw), but easy 
enough to be consistent on, and as this is your feature request, I can 
make v4 along those lines.

> 
>>>> With the current way, to measure an image we need to do:
>>>>
>>>> qemu-img info --output json ...
>>>> check if image contains bitmaps
>>>> qemu-img measure --output json ...
>>>> check if bitmaps are reported.
>>
>> Why do you have to check 'qemu-img info' first?  If measure reports
>> bitmaps, then you know bitmaps can be copied;
> 
> This works only if qemu-img measure will report "bitmaps": 0 when there
> are no bitmaps. Otherwise I don't know if this version does not report bitmaps
> because it does not understand them, or because there are no bitmaps.
> 
> Using qemu-img info I can tell the difference if measure does not report 0.

But similarly, with the above rules, 'qemu-img measure --bitmaps' will 
either fail because qemu is too old, or fail because the source format 
cannot support bitmaps to be copied; and succeed if 'qemu-img convert 
--bitmaps' will also succeed.  All without having to check 'qemu-img 
info' to see if there were bitmaps.

> 
>> if it doesn't, then you
>> can check info as a fallback path to compute size yourself - but
>> computing the size yourself doesn't help unless you also have fallbacks
>> to copy the bitmaps via QMP commands, because that qemu-img will also
>> lack 'qemu-img convert --bitmaps' or 'qemu-img bitmaps' to do it via
>> qemu-img.
> 
> When we started to work on this it was not clear that we will have a
> way to measure
> bitmaps. If we are going to have support both in convert and measure,
> we can check
> capability only in convert or only in measure.

Yes, the point of this series is that it is an all-or-none improvement 
to qemu-img: all of the bitmap manipulations you are wanting will be 
included at the same time in qemu 5.1, and likely backported at the same 
time by whatever downstream distros that want backports included. 
Existing qemu-img 5.0 cannot manipulate bitmaps in any reasonable 
manner, at most it has 'qemu-img info' that tells you that bitmaps 
exist, but you're still stuck with a non-qemu-img fallback if there is 
no qemu-img support for manipulating bitmaps at all (including the 
fallback of just declaring incremental backups unsupported, and using 
full backups instead).


>>> (We could also let img_measure() in qemu-img add @bitmaps to @required
>>> if --bitmaps was given, so we wouldn’t have to pass the bool around; but
>>> I think letting qemu-img fix up a QAPI object filled by the block driver
>>> sounds wrong.  (Because that means the block driver didn’t fill it
>>> correctly.))
>>
>> If we only touch it up in the CLI, then we would have two forms of CLI
>> output:
>>
>> $ qemu-img measure -f qcow2 image.qcow2
>> required size: 8716288
>> fully allocated size: 8716288
>> bitmaps size: 1024
>> $ qemu-img measure -f qcow2 image.qcow2 --bitmaps
>> required size: 8717312
>> fully allocated size: 8717312
> 
> I hope we will not have 2 forms. qemu-img is complicated enough ;-)

2 forms is the easiest way to add it.  And it is not that hard to 
explain.  Either you pass --bitmaps up front (no extra lines, but 
success only if measure saw bitmap support, even if the bitmaps occupy 0 
spze), or you don't pass --bitmaps up front (an extra bitmaps: line if 
bitmaps are supported, even if the size is 0, and no change to existing 
lines).  Just because 2 forms exist does not mean you are required to 
use both forms.

>> I'm leaning towards making v4 try a CLI-only 'measure --bitmaps', to see
>> if I can speed the discussion along with concrete patches for comparison.
> 
> Thanks, that would be useful.

Okay, that's the 2-form approach.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


