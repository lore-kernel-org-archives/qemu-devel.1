Return-Path: <SRS0=z35Y=A3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 844AFC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 06:44:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 56246206F5
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 06:44:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56246206F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=ispras.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39986 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvxcp-0007vL-LL
	for qemu-devel@archiver.kernel.org; Thu, 16 Jul 2020 02:44:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58316)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pavel.dovgalyuk@ispras.ru>)
 id 1jvxc9-0007U8-8h
 for qemu-devel@nongnu.org; Thu, 16 Jul 2020 02:43:29 -0400
Received: from mail.ispras.ru ([83.149.199.84]:39932)
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pavel.dovgalyuk@ispras.ru>)
 id 1jvxc6-00080A-5j
 for qemu-devel@nongnu.org; Thu, 16 Jul 2020 02:43:28 -0400
Received: from [192.168.0.183] (unknown [62.118.151.149])
 by mail.ispras.ru (Postfix) with ESMTPSA id 1414440AAD8E;
 Thu, 16 Jul 2020 06:43:23 +0000 (UTC)
Subject: Re: [PATCH 02/13] qcow2: introduce icount field for snapshots
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
References: <159316678008.10508.6615172353109944370.stgit@pasha-ThinkPad-X280>
 <159316679154.10508.16814264064541947914.stgit@pasha-ThinkPad-X280>
 <6882cb05-8533-d6ac-d41b-95c3d19ca496@redhat.com>
From: Pavel Dovgalyuk <pavel.dovgalyuk@ispras.ru>
Message-ID: <307693af-4dfd-17d3-0efa-1acb30158e35@ispras.ru>
Date: Thu, 16 Jul 2020 09:43:22 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <6882cb05-8533-d6ac-d41b-95c3d19ca496@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=83.149.199.84;
 envelope-from=pavel.dovgalyuk@ispras.ru; helo=mail.ispras.ru
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/16 02:00:58
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: kwolf@redhat.com, ehabkost@redhat.com, philmd@redhat.com,
 mtosatti@redhat.com, stefanha@redhat.com, armbru@redhat.com, mreitz@redhat.com,
 wrampazz@redhat.com, crosa@redhat.com, pbonzini@redhat.com,
 alex.bennee@linaro.org, zhiwei_liu@c-sky.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 06.07.2020 23:17, Eric Blake wrote:
> On 6/26/20 5:19 AM, Pavel Dovgalyuk wrote:
>> From: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
>>
>> This patch introduces the icount field for saving within the snapshot.
>> It is required for navigation between the snapshots in record/replay 
>> mode.
>>
>> Signed-off-by: Pavel Dovgalyuk <Pavel.Dovgalyuk@ispras.ru>
>> Acked-by: Kevin Wolf <kwolf@redhat.com>
>> ---
>>   0 files changed
>>
> 
> That's an odd diffstat; you may want to investigate why git isn't 
> showing the usual diffstat that makes it easier to see which files are 
> touched and the relative size of the changes.

Thanks for noticing, that was a stgit bug.

>> +++ b/docs/interop/qcow2.txt
>> @@ -645,6 +645,11 @@ Snapshot table entry:
>>                       Byte 48 - 55:   Virtual disk size of the 
>> snapshot in bytes
>> +                    Byte 56 - 63:   icount value which corresponds to
>> +                                    the record/replay instruction count
>> +                                    when the snapshot was taken. Set 
>> to -1
>> +                                    if icount was disabled
>> +
>>                       Version 3 images must include extra data at 
>> least up to
>>                       byte 55.
> 
> Should we have additional text here, similar to what was added to the 
> overall header in 3ae3fcfa, about how to properly add additional 
> optional fields while maintaining back-compat considerations?  Maybe 
> just a one sentence reference that the rules in that section apply here 
> too?

Your proposal is adding more details about header extension in that patch?
But I didn't get what exactly is needed, because there is already
the following text in the beginning of "variable" part:

variable:   Extra data for future extensions. Unknown fields must be
             ignored. Currently defined are (offset relative to snapshot
             table entry):


Pavel Dovgalyuk

