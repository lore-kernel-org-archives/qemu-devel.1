Return-Path: <SRS0=Z1O7=DF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CF85C2D0A8
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 14:10:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0BDE42072E
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 14:10:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P/pC5zPM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BDE42072E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57080 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kMtrU-0001TX-0L
	for qemu-devel@archiver.kernel.org; Mon, 28 Sep 2020 10:10:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47806)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kMtpr-0000Zi-FP
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 10:09:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:39873)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kMtpl-0001XU-Jp
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 10:08:58 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601302132;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GOhkvWRgj0ofZ/i5j9UKTGrIoSa/zfgmcFeF808iNrs=;
 b=P/pC5zPM9i3/ur8bCs1a8c0q+D+pYU5D8xr+tiryFKVww+CJyGutB4Kvsi7Y5qaUq85ioB
 0z0HRSiQk0fZUgfVdKIUwEFtPfwFj2fZzLxtTy2bzy7HpNyxdTlpOKWRmThvto2ckbaAYr
 /DvpDxBYk50QaTiQo+uHFnQqdd1tKTI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-147-6792NafiM9aLzngzBN0BIA-1; Mon, 28 Sep 2020 10:08:48 -0400
X-MC-Unique: 6792NafiM9aLzngzBN0BIA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 26450807352;
 Mon, 28 Sep 2020 14:08:45 +0000 (UTC)
Received: from [10.10.119.140] (ovpn-119-140.rdu2.redhat.com [10.10.119.140])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CDD885C1BB;
 Mon, 28 Sep 2020 14:08:43 +0000 (UTC)
Subject: Re: [PATCH v2 28/38] qapi/gen.py: update write() to be more idiomatic
To: Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>
References: <20200922210101.4081073-1-jsnow@redhat.com>
 <20200922210101.4081073-29-jsnow@redhat.com>
 <20200923152624.GO3312949@habkost.net>
 <c0b8ed9e-c66a-a6fa-43e1-c3c61581d928@redhat.com>
 <20200924155959.GC191229@localhost.localdomain>
 <87r1qqro8i.fsf@dusky.pond.sub.org> <20200925132458.GJ2178035@redhat.com>
 <874knmq7yg.fsf@dusky.pond.sub.org>
 <ee3b6aca-2e2d-c562-6b3e-e9344682694b@redhat.com>
 <87y2kugl1z.fsf@dusky.pond.sub.org>
From: John Snow <jsnow@redhat.com>
Message-ID: <eaa8193e-9109-6205-c14d-ed38c78281ae@redhat.com>
Date: Mon, 28 Sep 2020 10:08:43 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <87y2kugl1z.fsf@dusky.pond.sub.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jsnow@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/28 03:29:35
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org,
 Michael Roth <mdroth@linux.vnet.ibm.com>, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/28/20 8:09 AM, Markus Armbruster wrote:
> Eric Blake <eblake@redhat.com> writes:
> 
>> On 9/25/20 8:52 AM, Markus Armbruster wrote:
>>
>>>>> This was my best attempt to open the file read/write, creating it if it
>>>>> doesn't exist.
>>>>>
>>>>> Plain
>>>>>
>>>>>           f = open(pathname, "r+", encoding='utf-8')
>>>>>
>>>>> fails instead of creates, and
>>>>>
>>>>>           f = open(pathname, "w+", encoding='utf-8')
>>>>>
>>>>> truncates.
>>>>>
>>>>> If you know a better way, tell me!
>>>>
>>>> IIUC, you need  "a+" as the mode, rather than "w+"
>>> Sure this lets me do
>>>               f.seek(0)
>>>               f.truncate(0)
>>>               f.write(text)
>>> to overwrite the old contents on all systems?
>>
>> As long as you do a single pass over the output (you issue a stream of
>> f.write() after the truncate, but never a seek), then this will work.
> 
> Well, I do seek(), right before the truncate.
> 
>>> Documentation cautions:
>>>       [...] 'a' for appending (which on some Unix systems, means that
>>> all
>>>       writes append to the end of the file regardless of the current seek
>>>       position).
>>
>> Yes, that means that random access is impossible on such a stream.
>> But not all file creation patterns require random access.
> 
> To be honest, I still prefer the code I wrote, because there the reader
> only wonders why I didn't just open(), while here we get to argue about
> subtleties of mode "a+".
> 

I kept your os.open, I agree with you here.

(I still rewrote to use the context managers, though.)


