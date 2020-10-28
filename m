Return-Path: <SRS0=Un+l=ED=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B94E5C388F7
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 10:27:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F1FAB246B1
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 10:27:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CLJlCuAj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1FAB246B1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60566 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXiff-0005bD-Ph
	for qemu-devel@archiver.kernel.org; Wed, 28 Oct 2020 06:27:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35368)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kXieE-0004gj-6o
 for qemu-devel@nongnu.org; Wed, 28 Oct 2020 06:25:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:27283)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kXieA-00064a-Fw
 for qemu-devel@nongnu.org; Wed, 28 Oct 2020 06:25:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603880733;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=e1MUSYb84ey+x+LXWVZ0UuiGGwhLDRyjrn79FhM+9t8=;
 b=CLJlCuAj+5Vxvb2aWm27+UmvZBtrQkSvqyHL3++tgs9cKPg2XZgwosWqBOI5oOfol+vPmm
 lzY1LMfaPchyiAfpWpUAJ92cmXXIUwqtV5v5vZjh/yfR1WvCMcTHI5PCwF+WhrukHHevgv
 IHkadNGIFIEEx39w1tgpmxT7J3LQWNg=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-458-UqKZheOfP9u-i5OzpRe3fg-1; Wed, 28 Oct 2020 06:25:31 -0400
X-MC-Unique: UqKZheOfP9u-i5OzpRe3fg-1
Received: by mail-ej1-f71.google.com with SMTP id t1so1946622ejb.21
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2020 03:25:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=e1MUSYb84ey+x+LXWVZ0UuiGGwhLDRyjrn79FhM+9t8=;
 b=UE/vJ88YGJV02QHBDjY3TATgNzceVreZ+qu+VKf45exj50AI+ZW8hHgMnSkNtBLebh
 VQKI7pHYcjMXLTDgXtPZklUn7gaVBz4GTgP7FcRL/2V9GhgBAG9S+NqAsa5DVpJ8F9Sv
 zplLsX7x7SjHM8+U7YQYkUWc1RN+oJkEgfkKx11g9myMa7i2tj62DXREZlllLK673lxo
 NbmYfGlhtwTby0mHhlylKGGaPDOG+SunIMRgAun9QvF2GY57BMJovwkAbrajXIpxhiq8
 2oucfBMMm26JHvqlXI+aFF7V0w/HtETXdnGIoXrNoH5Kch2VXvMCtIbvipEEm1I6JUbP
 fKNw==
X-Gm-Message-State: AOAM531SA2Ic/02LMoZ5PhIBdFsAfUT2bTkDS+DBkqbb/+QTLhnJQpft
 pu+5kUszVmhXpKkk6SIsZB2D4HMUZ4gfdpckf8KXpfjcJAyi0b+M14yda6if7uWoDbTrpis5iAw
 swn5YUAP5D2tTHJg=
X-Received: by 2002:a17:906:4705:: with SMTP id
 y5mr6819565ejq.112.1603880730261; 
 Wed, 28 Oct 2020 03:25:30 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxKtX4Ql1fs9YIqIUqgj8f/bG3KQeO7k8kUjcSwswNhW7RSkpIEOrFHM6EH7hz2IldHGL2mCA==
X-Received: by 2002:a17:906:4705:: with SMTP id
 y5mr6819539ejq.112.1603880729996; 
 Wed, 28 Oct 2020 03:25:29 -0700 (PDT)
Received: from [192.168.1.36] (237.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.237])
 by smtp.gmail.com with ESMTPSA id bx24sm2709519ejb.51.2020.10.28.03.25.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 28 Oct 2020 03:25:29 -0700 (PDT)
Subject: Re: [PATCH 04/25] block/nvme: Trace controller capabilities
To: Auger Eric <eric.auger@redhat.com>, qemu-devel@nongnu.org
References: <20201027135547.374946-1-philmd@redhat.com>
 <20201027135547.374946-5-philmd@redhat.com>
 <1d71f170-3681-e923-da32-581f90262be1@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <55af0d24-a98b-840f-c60d-e290c6cbeee3@redhat.com>
Date: Wed, 28 Oct 2020 11:25:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <1d71f170-3681-e923-da32-581f90262be1@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/28 01:51:10
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-2.167, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Keith Busch <kbusch@kernel.org>, Stefan Hajnoczi <stefanha@redhat.com>,
 Klaus Jensen <its@irrelevant.dk>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/28/20 11:20 AM, Auger Eric wrote:
> Hi Philippe,
> 
> On 10/27/20 2:55 PM, Philippe Mathieu-Daudé wrote:
>> Controllers have different capabilities and report them in the
>> CAP register. We are particularly interested by the page size
>> limits.
>>
>> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
>> ---
>>  block/nvme.c       | 13 +++++++++++++
>>  block/trace-events |  2 ++
>>  2 files changed, 15 insertions(+)
>>
>> diff --git a/block/nvme.c b/block/nvme.c
>> index 6f1d7f9b2a1..361b5772b7a 100644
>> --- a/block/nvme.c
>> +++ b/block/nvme.c
>> @@ -727,6 +727,19 @@ static int nvme_init(BlockDriverState *bs, const char *device, int namespace,
>>       * Initialization". */
>>  
>>      cap = le64_to_cpu(regs->cap);
>> +    trace_nvme_controller_capability_raw(cap);
>> +    trace_nvme_controller_capability("Maximum Queue Entries Supported",
>> +                                     1 + NVME_CAP_MQES(cap));
>> +    trace_nvme_controller_capability("Contiguous Queues Required",
>> +                                     NVME_CAP_CQR(cap));
> I think this should be +1 too (0's based value)

This is a boolean:

  Contiguous Queues Required (CQR): This field is set to ‘1’ if
  the controller requires that I/O Submission Queues and I/O
  Completion Queues are required to be physically contiguous.
  This field is cleared to ‘0’ if the controller supports I/O
  Submission Queues and I/O Completion Queues that are not
  physically contiguous. If this field is set to ‘1’, then the
  Physically Contiguous bit (CDW11.PC) in the Create I/O Submission
  Queue and Create I/O Completion Queue commands shall be set to ‘1’.

>> +    trace_nvme_controller_capability("Doorbell Stride",
>> +                                     2 << (2 + NVME_CAP_DSTRD(cap)));
>> +    trace_nvme_controller_capability("Subsystem Reset Supported",
>> +                                     NVME_CAP_NSSRS(cap));
>> +    trace_nvme_controller_capability("Memory Page Size Minimum",
>> +                                     1 << (12 + NVME_CAP_MPSMIN(cap)));
>> +    trace_nvme_controller_capability("Memory Page Size Maximum",
>> +                                     1 << (12 + NVME_CAP_MPSMAX(cap)));
>>      if (!NVME_CAP_CSS(cap)) {
>>          error_setg(errp, "Device doesn't support NVMe command set");
>>          ret = -EINVAL;
>> diff --git a/block/trace-events b/block/trace-events
>> index 0955c85c783..b90b07b15fa 100644
>> --- a/block/trace-events
>> +++ b/block/trace-events
>> @@ -134,6 +134,8 @@ qed_aio_write_postfill(void *s, void *acb, uint64_t start, size_t len, uint64_t
>>  qed_aio_write_main(void *s, void *acb, int ret, uint64_t offset, size_t len) "s %p acb %p ret %d offset %"PRIu64" len %zu"
>>  
>>  # nvme.c
>> +nvme_controller_capability_raw(uint64_t value) "0x%08"PRIx64
>> +nvme_controller_capability(const char *desc, uint64_t value) "%s: %"PRIu64
>>  nvme_kick(void *s, int queue) "s %p queue %d"
>>  nvme_dma_flush_queue_wait(void *s) "s %p"
>>  nvme_error(int cmd_specific, int sq_head, int sqid, int cid, int status) "cmd_specific %d sq_head %d sqid %d cid %d status 0x%x"
>>
> Besides
> Reviewed-by: Eric Auger <eric.auger@redhat.com>
> 
> Thanks
> 
> Eric
> 


