Return-Path: <SRS0=5yua=6H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 654C2C2BA19
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 09:07:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 30D5B2075A
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 09:07:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WuAE1jef"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30D5B2075A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39360 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRXpr-0000jY-Ae
	for qemu-devel@archiver.kernel.org; Thu, 23 Apr 2020 05:07:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37744)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jasowang@redhat.com>) id 1jRXpF-00005o-5S
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 05:07:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <jasowang@redhat.com>) id 1jRXpE-00054e-Is
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 05:07:16 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:49595)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1jRXpE-00054P-6E
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 05:07:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587632835;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TXWZjAT+oByJ2lQWekbmWmxURSiLqB0NrgFYdNz/C90=;
 b=WuAE1jefTKQj+PpJ6pvVMheb2AzGL+fFI2+7j+WZTe6NQy6CR2p9RgUTIPJgIjAA1Mkmcm
 eWqhoGigHRs+MbOa9FoP5zsq3+m/qRckztYfQOav+O+Zto5zH5xIlPUR4maBVkFZsnd3ax
 HXvhYvYQOx5epUc8DMOjOrTP4A0Y658=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-14-O5pDUDYjNl6Lh02gv7MvUQ-1; Thu, 23 Apr 2020 05:07:13 -0400
X-MC-Unique: O5pDUDYjNl6Lh02gv7MvUQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8C373100CCC1;
 Thu, 23 Apr 2020 09:07:12 +0000 (UTC)
Received: from [10.72.13.168] (ovpn-13-168.pek2.redhat.com [10.72.13.168])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 49F0019D9E;
 Thu, 23 Apr 2020 09:07:10 +0000 (UTC)
Subject: Re: [PATCH 0/2] net/colo-compare.c: Expose "max_queue_size" to users
 and clean up
To: "Zhang, Chen" <chen.zhang@intel.com>, qemu-dev <qemu-devel@nongnu.org>
References: <20200411033824.19389-1-chen.zhang@intel.com>
 <716ca2bcd9e64c37a79509c468e18485@intel.com>
 <18466058-4184-2c6e-d740-2a1479395506@redhat.com>
 <310162af410e43ea9e0d0a22012e1929@intel.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <d5e9799e-49bc-82ee-4159-4a5602db015e@redhat.com>
Date: Thu, 23 Apr 2020 17:07:09 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <310162af410e43ea9e0d0a22012e1929@intel.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.61; envelope-from=jasowang@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/23 03:23:21
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: Zhang Chen <zhangckid@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 2020/4/23 =E4=B8=8B=E5=8D=884:59, Zhang, Chen wrote:
>
>> -----Original Message-----
>> From: Jason Wang <jasowang@redhat.com>
>> Sent: Thursday, April 23, 2020 4:54 PM
>> To: Zhang, Chen <chen.zhang@intel.com>; qemu-dev <qemu-
>> devel@nongnu.org>
>> Cc: Zhang Chen <zhangckid@gmail.com>
>> Subject: Re: [PATCH 0/2] net/colo-compare.c: Expose "max_queue_size" to
>> users and clean up
>>
>>
>> On 2020/4/23 =E4=B8=8B=E5=8D=883:31, Zhang, Chen wrote:
>>> Hi Jason,
>>>
>>> Please review this series when you free.
>>>
>>> Thanks
>>> Zhang Chen
>>>
>> Sure.
>>
>> I wonder maybe it's better e.g you can review and collect the patches th=
at
>> looks good and send them to me periodically?
> OK, I will queue COLO related patch as one series to you.
> Do I need send a pull request? or just a big patch set?


I prefer big patch set.

Thanks


>
> Thanks
> Zhang Chen
>
>> Thanks


