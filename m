Return-Path: <SRS0=6iUH=ZY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 333BCC432C0
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2019 11:10:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EDE872071F
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2019 11:10:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=greensocs.com header.i=@greensocs.com header.b="IwMknjXk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDE872071F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=greensocs.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34074 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ibjbS-0007SN-RW
	for qemu-devel@archiver.kernel.org; Mon, 02 Dec 2019 06:10:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39759)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <damien.hedde@greensocs.com>) id 1ibjYf-0006Dm-BP
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 06:08:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <damien.hedde@greensocs.com>) id 1ibjYa-000571-2c
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 06:08:01 -0500
Received: from beetle.greensocs.com ([5.135.226.135]:50072)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <damien.hedde@greensocs.com>)
 id 1ibjYW-00053H-0V; Mon, 02 Dec 2019 06:07:52 -0500
Received: from [172.16.11.102] (crumble.bar.greensocs.com [172.16.11.102])
 by beetle.greensocs.com (Postfix) with ESMTPSA id 286D096EF0;
 Mon,  2 Dec 2019 11:07:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com;
 s=mail; t=1575284864;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VgBiRzmN073Vt3AzJ9rm6Cx1Gcb36ZBoNwgbMrTiU+8=;
 b=IwMknjXkDLtrvdHaZyxhRACIvQFjk55icM9LvYUSHcazLx66RDyaVeAcjF4v3xGEsB3wgH
 LSdk0tdDVohQXzT4OKI8bLxxHtYVwnPv8o9oQUvp4ij5A9B0DTvAkzBmdXMcc6GcSadSNE
 H9EwwcdXqGAJKksmiE6+1sbogmSnL9c=
Subject: Re: [PATCH v5 03/13] hw/core: create Resettable QOM interface
To: Peter Maydell <peter.maydell@linaro.org>
References: <20191018150630.31099-1-damien.hedde@greensocs.com>
 <20191018150630.31099-4-damien.hedde@greensocs.com>
 <CAFEAcA9kc1-=DkYSqL6DOrLCNKt5uuxnf6-XYJ97g15T--1NvA@mail.gmail.com>
From: Damien Hedde <damien.hedde@greensocs.com>
Message-ID: <20402bef-d615-3258-bde9-12d42c9b1029@greensocs.com>
Date: Mon, 2 Dec 2019 12:07:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9kc1-=DkYSqL6DOrLCNKt5uuxnf6-XYJ97g15T--1NvA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US-large
Content-Transfer-Encoding: 7bit
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com; 
 s=mail; t=1575284865;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VgBiRzmN073Vt3AzJ9rm6Cx1Gcb36ZBoNwgbMrTiU+8=;
 b=EduGSw3JMDJG1Sn0lWOS4xD/qCTqnAe1EDmixxcw/wDW2HokGjApZ+oY50/E1hA+ovnJSp
 F6vxS/giWXu4cyDxhS9TSpxpUmGFhFzXBKnNGa1hRSzQ7YXSROnUQ6m/ev6OlHwIH4S7Lk
 N5IgVUYXwAhAmXoN8xql2dv0Hrty7BU=
ARC-Seal: i=1; s=mail; d=greensocs.com; t=1575284865; a=rsa-sha256; cv=none;
 b=DK378j0q4oF3AN+WuCUGrN6wsxVONTwWkMYG0ySpG4lnjDJAp/jj/eTOSwaCKmPJSYqoYQ
 /tANyc0d2QZkQ4kpgZcOAvhFchWCuQS3D516Hg6bnt84htG6abXi5B2eJy3tyG2fZlxKoF
 OjDGnAVD5ZCezPXjZLjuldVhMsWb2Lg=
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
Cc: "Daniel P. Berrange" <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-s390x <qemu-s390x@nongnu.org>,
 Cornelia Huck <cohuck@redhat.com>, Mark Burton <mark.burton@greensocs.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Edgar Iglesias <edgari@xilinx.com>,
 qemu-arm <qemu-arm@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 11/29/19 7:32 PM, Peter Maydell wrote:
> On Fri, 18 Oct 2019 at 16:07, Damien Hedde <damien.hedde@greensocs.com> wrote:
>>
>> This commit defines an interface allowing multi-phase reset. This aims
>> to solve a problem of the actual single-phase reset (built in
>> DeviceClass and BusClass): reset behavior is dependent on the order
>> in which reset handlers are called. In particular doing external
>> side-effect (like setting an qemu_irq) is problematic because receiving
>> object may not be reset yet.
>>
>> The Resettable interface divides the reset in 3 well defined phases.
>> To reset an object tree, all 1st phases are executed then all 2nd then
>> all 3rd. See the comments in include/hw/resettable.h for a more complete
>> description. The interface defines 3 phases to let the future
>> possibility of holding an object into reset for some time.
>>
>> The qdev/qbus reset in DeviceClass and BusClass will be modified in
>> following commits to use this interface. A mechanism is provided
>> to allow executing a transitional reset handler in place of the 2nd
>> phase which is executed in children-then-parent order inside a tree.
>> This will allow to transition devices and buses smoothly while
>> keeping the exact current qdev/qbus reset behavior for now.
>>
>> Documentation will be added in a following commit.
>>
>> Signed-off-by: Damien Hedde <damien.hedde@greensocs.com>
>> ---
>>
>> In this patch only a single reset type is supported, but the interface
>> allows for more to be defined.
>>
>> I had some thought about problems which may arise when having multiple
>> reset types:
> 
> [snip]
> 
> Yeah, these all seem right. We clearly need to think a bit
> more before we add multiple reset types. Let's get this basic
> just-cold-reset in for now and come back to the rest later.
> 
> 
> Almost all of my comments below are just grammar/typo fixes
> for comments. The only substantives are:
>  * globals
>  * copyright/licensing comment needed in the .h file
> and they're pretty minor items.
> 
>> +/**
>> + * enter_phase_in_progress:
>> + * Flag telling whether we are currently in an enter phase where side
>> + * effects are forbidden. This flag allows us to catch if reset is called
>> + * again during during this phase.
>> + */
>> +static bool enter_phase_in_progress;
> 
> This looks weird -- I don't think a global for this works,
> because you might have several distinct subtrees of
> devices, and be doing reset on them both at once.
> I think that we only use this for an assert, though -- is
> that right? If so, we could just drop this.

We say that we need to own the iothread mutex for any reset, so global
should be ok. Thought, I just checked, it's only mentioned in the
documentation not in the header file. I should probably add a comment
there too along with the link to the documentation file.

If we want to drop the iothread mutex constraint. I think we need to
carefully check there is no hidden problem. In particular in hold and
exit phases we allow to have external effects like setting gpios and we
have no way to control what it provokes.

You're right it is just for assert: to avoid any miss-use of the api
which could lead to being in bad reset state. So we can indeed drop it.

> 
>> +void resettable_assert_reset(Object *obj, ResetType type)
>> +{
>> +    assert(!enter_phase_in_progress);
>> +    /* TODO: change that assert when adding support for other reset types */
> 
> I'm not sure which assert this is referring to -- the one above
> the comment, or the one below ?

It refers to the assert(type == RESET_TYPE_COLD).
I added theses because we cannot just add items in the enum to have
working multiple reset types.
A comment like this will be more clear:
/*
 * TODO: Additional reset types need support in phases handling
 * functions (resettable_phase_enter/hold/exit()) before allowing more
 * enum entries. Remove the following assert when it is done.
 */

> 
>> +    assert(type == RESET_TYPE_COLD);
>> +    trace_resettable_reset_assert_begin(obj, type);
>> +    enter_phase_in_progress = true;
>> +    resettable_phase_enter(obj, NULL, type);
>> +    enter_phase_in_progress = false;
>> +    resettable_phase_hold(obj, NULL, type);
>> +    trace_resettable_reset_assert_end(obj);
>> +}
>> +
>> +void resettable_release_reset(Object *obj, ResetType type)
>> +{
>> +    assert(!enter_phase_in_progress);
>> +    /* TODO: change that assert when adding support for other reset types */
> 
> Ditto.
> 
> 
> 
>> --- /dev/null
>> +++ b/include/hw/resettable.h
>> @@ -0,0 +1,199 @@
>> +#ifndef HW_RESETTABLE_H
>> +#define HW_RESETTABLE_H
>> +
> 
> All new files, including even small header files, should have
> the usual copyright-and-license comment at the top. (Can you
> check also whether this needs adding for any other new files the
> patchset creates, please?)

I'll do that and fix all the typos

Thanks for the review,
--
Damien

