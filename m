Return-Path: <SRS0=ZOtl=62=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BA0CC2D0F7
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 19:45:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6ABA4206DD
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 19:45:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U8VlwAi9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6ABA4206DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49922 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYaqY-0002GK-JS
	for qemu-devel@archiver.kernel.org; Tue, 12 May 2020 15:45:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48036)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jYaka-00020F-BR
 for qemu-devel@nongnu.org; Tue, 12 May 2020 15:39:36 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:57219
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jYakX-0004Wb-AZ
 for qemu-devel@nongnu.org; Tue, 12 May 2020 15:39:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589312371;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bm6HrfLGZTnVY9Po1BzA0B+xVviZJXW6NnTxU7Bp2nI=;
 b=U8VlwAi9NLhIeGM0FaoMZsGH55Zb0rDTw2jocymOMLikUbKoNV/iJujam1Clp1VH85aLlW
 o+MhinDjPepAvUoF6zRhIV5XiY7OS8u4VafOwD9S8OdEWB3cy0rBQLNfEsJ36Ga/M3+wwj
 JRIQJJG1JXrDi9PGw9ZrfnF8GIwoaFw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-385-eIXQ9seZOvOJ7lr2nSkwlg-1; Tue, 12 May 2020 15:39:26 -0400
X-MC-Unique: eIXQ9seZOvOJ7lr2nSkwlg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5D907EC1A1;
 Tue, 12 May 2020 19:39:25 +0000 (UTC)
Received: from [10.3.116.145] (ovpn-116-145.phx2.redhat.com [10.3.116.145])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CCEB41A923;
 Tue, 12 May 2020 19:39:24 +0000 (UTC)
Subject: Re: [PATCH v3 7/9] qcow2: Expose bitmaps' size during measure
To: Max Reitz <mreitz@redhat.com>, Nir Soffer <nsoffer@redhat.com>
References: <20200508180340.675712-1-eblake@redhat.com>
 <20200508180340.675712-8-eblake@redhat.com>
 <CAMRbyytP9LvMVJ1R1EEnjHJGKOXtOYg_=ywqn-yVDLBeqFff4g@mail.gmail.com>
 <d0c62eef-acf6-0996-4928-1836940e2901@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <1a9f1d01-5b9a-ac35-334e-1fe090682621@redhat.com>
Date: Tue, 12 May 2020 14:39:24 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <d0c62eef-acf6-0996-4928-1836940e2901@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/12 01:41:59
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
Cc: Kevin Wolf <kwolf@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 qemu-block <qemu-block@nongnu.org>, Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/12/20 6:10 AM, Max Reitz wrote:


>> This does not break old code since previously we always reported only
>> guest visible content
>> here, but it changes the semantics, and now you cannot allocate
>> "required" size, you need
>> to allocate "required" size with "bitmaps" size.
> 
> Only if you copy the bitmaps, though, which requires using the --bitmaps
> switch for convert.

First, a usage question: would you rather that 'qemu-img convert 
--bitmaps' silently succeeds even when the image being converted has no 
bitmaps, or would you rather that it fails loudly when there are no 
bitmaps to be copied over?  As implemented in this patch series, patch 8 
currently silently succeeds.  But in order to make patch 7 and 8 
consistent with one another, I need to know which behavior is easier to 
use: failing convert if the source lacks bitmaps (and thus measure would 
suppress the bitmaps:0 output), or treating lack of bitmaps as nothing 
additional to copy and thereby succeeding (and thus measure should 
output bitmaps:0 to show that no additional space is needed because 
nothing else will be copied, successfully).

>> If we add a new
>> extension all users will have to
>> change the calculation again.
> 
> It was my impression that existing users won’t have to do that, because
> they don’t use --bitmaps yet.
> 
> In contrast, if we included the bitmap size in @required or
> @fully-allocated, then previous users that didn’t copy bitmaps to the
> destination (which they couldn’t) would allocate too much space.
> 
> ...revisiting this after reading more of your mail: With a --bitmaps
> switch, existing users wouldn’t suffer from such compatibility problems.
>   However, then users (that now want to copy bitmaps) will have to pass
> the new --bitmaps flag in the command line, and I don’t see how that’s
> less complicated than just adding @bitmaps to @required.

More concretely, suppose down the road that we add the ability to copy 
internal snapshots (not that you want to mix internal and external 
snapshots, but that such information already exists and therefore can be 
used as an example).  Which is easier:

$ qemu-img measure -f qcow2 image.qcow2
required size: 8716288
fully allocated size: 8716288
bitmaps size: 1024
internal snapshot size: 2048

where you now have to add three numbers prior to creating dest.qcow2 and 
calling:

$ qemu-img convert image.qcow2 -f dest.qcow2 --bitmaps --snapshots

or using:

$ qemu-img measure --bitmaps --snapshots -f qcow2 image.qcow2
required size: 8719360
fully allocated size: 8719360

where you then call:

$ qemu-img convert image.qcow2 -f dest.qcow2 --bitmaps --snapshots

with a single size that matches the same arguments you pass to qemu-img 
convert?  What about failure cases?  What happens when qemu-img doesn't 
understand --snapshots but does understand --bitmaps?  Do you have to 
try a series of up to three calls to find how much information is supported:

$ qemu-img measure -f qcow2 image.qcow2 --bitmaps --snapshots
error: unknown argument
$ qemu-img measure -f qcow2 image.qcow2 --bitmaps
error: unknown argument
$ qemu-img measure -f qcow2 image.qcow2
data given, now you know that neither --bitmaps nor --snapshots will work

or is it nicer to issue just one measure without options, getting 
separate output lines, and seeing which output lines exist to know which 
convert options are supported, at the minor expense of having to add 
values yourself?

And then back to my question: should 'measure --bitmaps' fail if there 
are no bitmaps to be measured, or silently succeed and not change the 
output size?


>> With the current way, to measure an image we need to do:
>>
>> qemu-img info --output json ...
>> check if image contains bitmaps
>> qemu-img measure --output json ...
>> check if bitmaps are reported.

Why do you have to check 'qemu-img info' first?  If measure reports 
bitmaps, then you know bitmaps can be copied; if it doesn't, then you 
can check info as a fallback path to compute size yourself - but 
computing the size yourself doesn't help unless you also have fallbacks 
to copy the bitmaps via QMP commands, because that qemu-img will also 
lack 'qemu-img convert --bitmaps' or 'qemu-img bitmaps' to do it via 
qemu-img.

>>
>> If image has bitmaps and bitmaps are not reported, we know that we have an old
>> version of qemu-img that does not know how to measure bitmaps.
> 
> Well, but you’ll also see that convert --bitmaps will fail.  But I can
> see that you probably want to know about that before you create the
> target image.
> 
>> If bitmaps are reported in both commands we will use the value when creating
>> block devices.
> 
> And otherwise?  Do you error out, or do you just omit --bitmaps from
> convert?
> 
>> If we always report bitmaps even when they are zero, we don't need to
>> run "qemu-img info".
>>
>> But  my preferred interface is:
>>
>>     qemu-img measure --bitmaps ...
>>
>> And report bitmaps only if the user asked to get the value. In this
>> case the required and
>> fully-allocated values will include bitmaps.
> 
> Well, it would be consistent with the convert interface.  If you specify
> it for one, you specify it for the other.
> 
> OTOH, this would mean having to pass around the @bitmaps bool in the
> block layer, which is a bit more difficult than just adding a new field
> in BlockMeasureInfo.  It would also mean to add a new bool every time we
> add a new extension (which you hinted at above that it might happen).

Or, that could be a CLI-only feature: the QMP interface _always_ reports 
bitmaps separately, but if 'qemu-img measure --bitmaps' is used, the CLI 
then adds that value in on your behalf after the QMP command but before 
printing to the end user.

> 
> (We could also let img_measure() in qemu-img add @bitmaps to @required
> if --bitmaps was given, so we wouldn’t have to pass the bool around; but
> I think letting qemu-img fix up a QAPI object filled by the block driver
> sounds wrong.  (Because that means the block driver didn’t fill it
> correctly.))

If we only touch it up in the CLI, then we would have two forms of CLI 
output:

$ qemu-img measure -f qcow2 image.qcow2
required size: 8716288
fully allocated size: 8716288
bitmaps size: 1024
$ qemu-img measure -f qcow2 image.qcow2 --bitmaps
required size: 8717312
fully allocated size: 8717312

> 
> And I don’t see how the interface proposed here by Eric (or rather, what
> I think we had agreed on for the next version) poses any problems for
> users.  If you want to copy bitmaps, you just use @required + @bitmaps.
>   (If @bitmaps isn’t present, you can’t copy bitmaps, so that should be
> an error.)  If you don’t want to copy bitmaps, you just use @required.
> 
> (And if you want to copy bitmaps if present, you use @required +
> @bitmaps, and treat @bitmaps as 0 if not present.)
> 
>> To learn if qemu-img measure understand bitmaps we can check --help
>> output, like we did
>> in the past until we can require the version on all platforms.
>>
>> An advantage is not having to change old tests.
> I personally don’t really consider that a significant advantage...  (On
> the contrary, seeing the field in all old tests means the code path is
> exercised more often, even though it’s supposed to always just report 0.)
> 
> So all in all the main benefit I see in your proposal, i.e. having
> @bitmaps be included in @required with --bitmaps given, is that it would
> give a symmetrical interface between measure and convert: For simple
> cases, you can just replace the “convert” in your command line by
> “measure”, retrieve @required/@fully-allocated, create the target image
> based on that, and then re-run the same command line, but with “convert”
> this time.
> 
> But I’m not sure whether that’s really an advantage in practice or more
> of a gimmick.  With Eric’s proposal, if you want to convert with
> bitmaps, just add @bitmaps to the target size.  If you don’t, don’t.  If
> you’d prefer to but don’t really care, add “@bitmaps ?: 0”.
> 
> The benefit of Eric’s proposal (not including @bitmaps in @required or
> @fully-allocated) is that it doesn’t require passing an additional
> parameter to the block driver.  It also makes the definition of
> BlockMeasureInfo simpler.  With your proposal, it would need to be
> parameterized.  (As in, @required sometimes includes the bitmaps,
> sometimes it doesn’t, depending on the parameter used to retrieve
> BlockMeasureInfo.)  I’m not sure whether that even makes sense in the
> QAPI definition.

I'm leaning towards making v4 try a CLI-only 'measure --bitmaps', to see 
if I can speed the discussion along with concrete patches for comparison.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


