Return-Path: <SRS0=hU7S=42=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 651ADC10F27
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 15:41:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 318BA21D56
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 15:41:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iaCNI781"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 318BA21D56
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45250 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBKWo-0004l9-Cj
	for qemu-devel@archiver.kernel.org; Mon, 09 Mar 2020 11:41:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38297)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jBKOz-00005v-08
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 11:33:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1jBKOx-0007bp-4D
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 11:33:08 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:40529
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1jBKOw-0007VN-VQ
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 11:33:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583767982;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hwpwsNQV3T7sHDRqSbMqtR4I62MKE2coSd7c9aSwEZY=;
 b=iaCNI781Tcrv0mlcPkR7+gDrAdFHM0ehHqRpTlKSM6QfBqGqDTVeMOqSnWFpamKPNzMfpT
 NNez2y2zGmUu8HMYo5G/8oL+y827eAgIE9h/4rVEMzCSz5PZTrcODleZJjnuhiSE6vujgW
 vuHOPYxtzqJ09x6tIHeyrohMYgjnKrM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-441-OnX6_pfaNb-xRebpxGBx6g-1; Mon, 09 Mar 2020 11:32:58 -0400
X-MC-Unique: OnX6_pfaNb-xRebpxGBx6g-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1966F13EA;
 Mon,  9 Mar 2020 15:32:57 +0000 (UTC)
Received: from [10.3.116.177] (ovpn-116-177.phx2.redhat.com [10.3.116.177])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 51B235C3F8;
 Mon,  9 Mar 2020 15:32:53 +0000 (UTC)
Subject: Re: [PATCH v3 1/4] block: Add trivial backing_fmt support to qcow,
 sheepdog, vmdk
To: Kevin Wolf <kwolf@redhat.com>
References: <20200306225121.3199279-1-eblake@redhat.com>
 <20200306225121.3199279-2-eblake@redhat.com>
 <20200309152112.GC6478@linux.fritz.box>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <7b7f12f8-ca03-12d4-b93d-2edefb51cb42@redhat.com>
Date: Mon, 9 Mar 2020 10:32:52 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200309152112.GC6478@linux.fritz.box>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Fam Zheng <fam@euphon.net>, pkrempa@redhat.com,
 "open list:Sheepdog" <sheepdog@lists.wpkg.org>, qemu-block@nongnu.org,
 libvir-list@redhat.com, Michael Tokarev <mjt@tls.msk.ru>,
 qemu-devel@nongnu.org, mreitz@redhat.com,
 "open list:Trivial patches" <qemu-trivial@nongnu.org>,
 Liu Yuan <namei.unix@gmail.com>, Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/9/20 10:21 AM, Kevin Wolf wrote:
> Am 06.03.2020 um 23:51 hat Eric Blake geschrieben:
>> For qcow2 and qed, we want to encourage the use of -F always, as these
>> formats can suffer from data corruption or security holes if backing
>> format is probed.  But for other formats, the backing format cannot be
>> recorded.  Making the user decide on a per-format basis whether to
>> supply a backing format string is awkward, better is to just blindly
>> accept a backing format argument even if it is ignored by the
>> contraints of the format at hand.
>>
>> Signed-off-by: Eric Blake <eblake@redhat.com>
> 
> I'm not sure if I agree with this reasoning. Accepting and silently
> ignoring -F could give users a false sense of security. If I specify a
> -F raw and QEMU later probes qcow2, that would be very surprising.

Do we know what formats qcow, sheepdog, and vmdk expect to probe?  I'm 
wondering if we can compromise by checking that the requested backing 
image has the specified format, and error if it is not, rather than 
completely ignoring it - but at the same time, the image formats have no 
where to record a backing format.

I'm guessing that qcow works with either raw or qcow as backing format 
(and anything else is odd - a qcow2 backing to a qcow is unusual, and 
would be better to reject).  I'm not sure if sheepdog can be backed by 
anything but another sheepdog, similarly, I'm not sure if a vmdk can be 
backed by anything but another vmdk.  If so, it should be simple enough 
to do a v4 of this patch which requires -F to be a known-acceptable 
probe type for these images.

Still, the point of this patch is that I want to add -F into all the 
iotests, and without something along the lines of this patch, all of 
those iotests are broken for these image formats.  Patch 2 is a lot 
harder to write if we have to make our use of -F conditional on the 
image format in question.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


