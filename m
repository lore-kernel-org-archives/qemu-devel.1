Return-Path: <SRS0=2JTU=UU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B514C43613
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2019 02:31:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 28151206E0
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2019 02:31:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com header.i=@bytedance-com.20150623.gappssmtp.com header.b="edNO7Egw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28151206E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bytedance.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54276 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1he9KQ-0005oH-AO
	for qemu-devel@archiver.kernel.org; Thu, 20 Jun 2019 22:31:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47438)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <pizhenwei@bytedance.com>) id 1he8j6-0003zF-Rn
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 21:52:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pizhenwei@bytedance.com>) id 1he8j3-000687-Sp
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 21:52:28 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:34475)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <pizhenwei@bytedance.com>)
 id 1he8j2-00062u-Ty
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 21:52:25 -0400
Received: by mail-pl1-x642.google.com with SMTP id i2so2182076plt.1
 for <qemu-devel@nongnu.org>; Thu, 20 Jun 2019 18:52:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance-com.20150623.gappssmtp.com; s=20150623;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language;
 bh=ErT/AdEca57HhNANwgVGMyROutCXCJlnyaa0iXRyYJE=;
 b=edNO7EgwcipilzaA8yD8OnNrQt6oVCM9tjqOBp8e3a/VHaEeEwpzKEVZOjdd8wQJOy
 qVhYvAGR0V74PTvDY6OvnMk7t9oM5lqfvxE34l6IirqWEwPhXFC0pWP2Z1yZR/nLgpCi
 zl5yANNzxEJvVcC71SPfo4Ph3EUs4xo0rv0SctRTpNFPZBNgTz7qm7miQ5N2UxwZWZD5
 xWrUrh6mzrITkvgNcuHzZeopucIXDCOfrLfqQTp8AYeLhkUOLwmrnkrHtvIdtWUjThM2
 ek0aTukMXjwcShhx1X7ZILI8X9aB8LbET9GJNeYa8wWfsIrL8yuwRpdK1gUuD/f1atn5
 PPsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language;
 bh=ErT/AdEca57HhNANwgVGMyROutCXCJlnyaa0iXRyYJE=;
 b=DiLTe0/V0P9VErBUQkePNRbTXHYwql28UNKvaa/R8fALZbcJrEbZm/9lrpnmedBH3m
 uvOfkwqywKWdpOBCQfklIIe1GcRv6FniFW0QiKJ7iz82ig4lKW9edylRfnoY1kANJEj6
 J9Wt2REh4DKNR4QueeEq9jV7oGKsC0WoDxy/7XaLDX34Lk6JTbQLNCqe18fmni6krufK
 HUBCp9QDAoMKBUurUNCt5C43cz2rx/AMMuaT1MU7HW/zJRpRt9tQ9jYOIADPFfW2m12v
 swxT4e7ZdBlsJZbzpuhXXoErfrdI7uZXqRJhsWaVCgDFievQUTUFraFGxQD/2micBmwE
 tVOQ==
X-Gm-Message-State: APjAAAUqQDt2rm+pUKVQI+q0OFQKHW/lndJexb7Vir6pKUKGoUTLfvNn
 lurcnFukvqNweFOF9mleb0d7zB5FwgE=
X-Google-Smtp-Source: APXvYqxr5nNVOZVaut8qNUf2N3DLOfelJAiXeDx157oXLdEqfENRBBHSbEEH8/aHK8keO3TYDZD8Tw==
X-Received: by 2002:a17:902:e490:: with SMTP id
 cj16mr125859727plb.136.1561081940730; 
 Thu, 20 Jun 2019 18:52:20 -0700 (PDT)
Received: from [10.92.144.180] ([61.120.150.76])
 by smtp.gmail.com with ESMTPSA id z20sm829445pfk.72.2019.06.20.18.52.17
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 20 Jun 2019 18:52:19 -0700 (PDT)
To: Eric Blake <eblake@redhat.com>, kwolf@redhat.com, mreitz@redhat.com
References: <1561020872-6214-1-git-send-email-pizhenwei@bytedance.com>
 <1561020872-6214-4-git-send-email-pizhenwei@bytedance.com>
 <cdb81887-5d68-9de5-e72b-3df8a45e52b4@redhat.com>
From: zhenwei pi <pizhenwei@bytedance.com>
Message-ID: <3e4acc6e-9439-6007-9d08-de6878ab8ee6@bytedance.com>
Date: Fri, 21 Jun 2019 09:52:15 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <cdb81887-5d68-9de5-e72b-3df8a45e52b4@redhat.com>
Content-Language: en-US
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::642
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: Re: [Qemu-devel] [External Email] Re: [PATCH 3/3] qapi: add block
 size histogram interface
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
Cc: fam@euphon.net, vsementsov@virtuozzo.com, qemu-devel@nongnu.org,
 qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/20/19 10:03 PM, Eric Blake wrote:

> On 6/20/19 3:54 AM, zhenwei pi wrote:
>> Set/Clear block size histograms through new command
>> x-block-size-histogram-set and show new statistics in
>> query-blockstats results.
>>
> I'm guessing this is modeled after the existing
> block-latency-histogram-set command?

zhenwei: Yes, it is.

>> Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
>> ---
>>   block/qapi.c         |  24 ++++++++++++
>>   blockdev.c           |  56 +++++++++++++++++++++++++++
>>   qapi/block-core.json | 105 ++++++++++++++++++++++++++++++++++++++++++++++++++-
>>   3 files changed, 184 insertions(+), 1 deletion(-)
>> +++ b/qapi/block-core.json
>> @@ -633,6 +633,100 @@
>>              '*boundaries-flush': ['uint64'] } }
>>   
>>   ##
>> +# @BlockSizeHistogramInfo:
>> +#
>> +# Block size histogram.
>> +#
>> +# @boundaries: list of interval boundary values in nanoseconds, all greater
>> +#              than zero and in ascending order.
>> +#              For example, the list [8193, 32769, 131073] produces the
>> +#              following histogram intervals:
>> +#              [0, 8193), [8193, 32769), [32769, 131073), [131073, +inf).
>> +#
>> +# @bins: list of io request counts corresponding to histogram intervals.
>> +#        len(@bins) = len(@boundaries) + 1
>> +#        For the example above, @bins may be something like [6, 3, 7, 9],
>> +#        and corresponding histogram looks like:
>> +#
>> +# Since: 4.0
> You've missed 4.0; the next release is 4.1.

zhenwei: OK, I will fix all the version info.

>> +##
>> +{ 'struct': 'BlockSizeHistogramInfo',
>> +  'data': {'boundaries': ['uint64'], 'bins': ['uint64'] } }
> This is identical to struct BlockLatencyHistogramInfo; can we instead
> rename the type (which does not affect API) and share it between both
> implementations, instead of duplicating it?
>
zhenwei: Good idea. But I am confused about the compatibility of the
structure BlockLatencyHistogramInfo. If I rename BlockLatencyHistogramInfo
to BlockHistogramInfo, it will be common.

>> +
>> +##
>> +# @x-block-size-histogram-set:
> Does this need to be experimental from the get-go? Or can it be stable
> by dropping 'x-' since it matches the fact that
> block-latency-histogram-set is stable?

zhenwei: OK, I will drop 'x-' prefix.

>> +#
>> +# Manage read, write and flush size histograms for the device.
>> +#
>> +# If only @id parameter is specified, remove all present size histograms
>> +# for the device. Otherwise, add/reset some of (or all) size histograms.
>> +#
>> +# @id: The name or QOM path of the guest device.
>> +#
>> +# @boundaries: list of interval boundary values (see description in
>> +#              BlockSizeHistogramInfo definition). If specified, all
>> +#              size histograms are removed, and empty ones created for all
>> +#              io types with intervals corresponding to @boundaries (except for
>> +#              io types, for which specific boundaries are set through the
>> +#              following parameters).
>> +#
>> +# @boundaries-read: list of interval boundary values for read size
>> +#                   histogram. If specified, old read size histogram is
>> +#                   removed, and empty one created with intervals
>> +#                   corresponding to @boundaries-read. The parameter has higher
>> +#                   priority then @boundaries.
>> +#
>> +# @boundaries-write: list of interval boundary values for write size
>> +#                    histogram.
>> +#
>> +# @boundaries-flush: list of interval boundary values for flush size
>> +#                    histogram.
>> +#
>> +# Returns: error if device is not found or any boundary arrays are invalid.
>> +#
>> +# Since: 4.0
> 4.1
>
>> +#
>> +# Example: set new histograms for all io types with intervals
>> +# [0, 8193), [8193, 32769), [32769, 131073), [131073, +inf):
>> +#
>> +# -> { "execute": "x-block-size-histogram-set",
>> +#      "arguments": { "id": "drive0",
>> +#                     "boundaries": [8193, 32769, 131073] } }
>> +# <- { "return": {} }
>> +#
>> +# Example: set new histogram only for write, other histograms will remain
>> +# not changed (or not created):
>> +#
>> +# -> { "execute": "x-block-size-histogram-set",
>> +#      "arguments": { "id": "drive0",
>> +#                     "boundaries-write": [8193, 32769, 131073] } }
>> +# <- { "return": {} }
>> +#
>> +# Example: set new histograms with the following intervals:
>> +#   read, flush: [0, 8193), [8193, 32769), [32769, 131073), [131073, +inf)
>> +#   write: [0, 4097), [4097, 8193), [8193, 32769), [32769, +inf)
>> +#
>> +# -> { "execute": "x-block-size-histogram-set",
>> +#      "arguments": { "id": "drive0",
>> +#                     "boundaries": [8193, 32769, 131073],
>> +#                     "boundaries-write": [4097, 8193, 32769] } }
>> +# <- { "return": {} }
>> +#
>> +# Example: remove all size histograms:
>> +#
>> +# -> { "execute": "x-block-size-histogram-set",
>> +#      "arguments": { "id": "drive0" } }
>> +# <- { "return": {} }
>> +##
>> +{ 'command': 'x-block-size-histogram-set',
>> +  'data': {'id': 'str',
>> +           '*boundaries': ['uint64'],
>> +           '*boundaries-read': ['uint64'],
>> +           '*boundaries-write': ['uint64'],
>> +           '*boundaries-flush': ['uint64'] } }
> Again, this copies heavily from block-latency-histogram-set.  But
> changing the command name is not API compatible.  Should we have a
> single new command 'block-histogram-set' which takes an enum choosing
> between 'latency' and 'size', and start the deprecation clock on
> 'block-latency-histogram-set'?
>   (and defaulting to 'latency' for back-compat
>
zhenwei: this actually copies from block-latency-histogram-set, because the
two APIs have the similar logic but different structure
BlockLatencyHistogramInfo and BlockSizeHistogramInfo.
For further extension, a single new command 'block-histogram-set' with
enum operation is better.
So, should I remove 'block-latency-histogram-set' and add 'block-histogram-set'?

>> +
>> +
>> +##
>>   # @BlockInfo:
>>   #
>>   # Block device information.  This structure describes a virtual device and
>> @@ -918,6 +1012,12 @@
>>   #
>>   # @flush_latency_histogram: @BlockLatencyHistogramInfo. (Since 4.0)
>>   #
>> +# @x_rd_size_histogram: @BlockSizeHistogramInfo. (Since 4.0)
>> +#
>> +# @x_wr_size_histogram: @BlockSizeHistogramInfo. (Since 4.0)
>> +#
>> +# @x_flush_size_histogram: @BlockSizeHistogramInfo. (Since 4.0)
> since 4.1 on all of these additions.
>
>> +#
>>   # Since: 0.14.0
>>   ##
>>   { 'struct': 'BlockDeviceStats',
>> @@ -933,7 +1033,10 @@
>>              'timed_stats': ['BlockDeviceTimedStats'],
>>              '*rd_latency_histogram': 'BlockLatencyHistogramInfo',
>>              '*wr_latency_histogram': 'BlockLatencyHistogramInfo',
>> -           '*flush_latency_histogram': 'BlockLatencyHistogramInfo' } }
>> +           '*flush_latency_histogram': 'BlockLatencyHistogramInfo',
>> +           '*x_rd_size_histogram': 'BlockSizeHistogramInfo',
>> +           '*x_wr_size_histogram': 'BlockSizeHistogramInfo',
>> +           '*x_flush_size_histogram': 'BlockSizeHistogramInfo' } }
>>   
>>   ##
>>   # @BlockStats:
>>

-- 
Thanks and Best Regards,
zhenwei pi

