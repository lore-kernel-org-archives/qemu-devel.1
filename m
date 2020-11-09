Return-Path: <SRS0=6joO=EP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 791A2C4741F
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 10:03:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D5320206E5
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 10:03:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YNrann23"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5320206E5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54368 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kc41V-0003sI-JC
	for qemu-devel@archiver.kernel.org; Mon, 09 Nov 2020 05:03:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36262)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kc40J-0002zf-Od
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 05:02:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:46133)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kc40F-0000Px-Ru
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 05:02:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604916143;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZlIU6Rmluo9k29e2ssGBg36MjRoEHSncGgiOjbYZPYE=;
 b=YNrann232w4k+qXn6ah2n0lNB5j8hxiXAV8yvsY2VQgvsSt+YPFMXs466gNbXxM/rjMX/s
 wNeokf9e/jgDw7BxJyyNxnAkKQAqrEAoO0Hb2s/7aMrZQcmeOEM/Gj1V7SfLgbnrvdx+EV
 SP2c7egkdEeovgPXNOLRPO7gqCfSnXQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-376-ccyNcz85OsO7B36D8GPSoQ-1; Mon, 09 Nov 2020 05:02:18 -0500
X-MC-Unique: ccyNcz85OsO7B36D8GPSoQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 64E4C1084C87;
 Mon,  9 Nov 2020 10:02:17 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-112-53.ams2.redhat.com [10.36.112.53])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 82D385C22B;
 Mon,  9 Nov 2020 10:02:15 +0000 (UTC)
Subject: Re: [PATCH v2 5/6] macio: don't reference serial_hd() directly within
 the device
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, armbru@redhat.com,
 david@gibson.dropbear.id.au, atar4qemu@gmail.com, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org
References: <20200926140216.7368-1-mark.cave-ayland@ilande.co.uk>
 <20200926140216.7368-6-mark.cave-ayland@ilande.co.uk>
 <16f13e17-37cb-a238-4e2a-9a945649cafd@redhat.com>
 <24aca485-fe87-8aab-7554-ba8dc1a3bbb3@ilande.co.uk>
 <19068e17-21f0-75a5-f7df-1b11404008c6@redhat.com>
 <eda03864-cbd5-4205-8b69-06fa20321b49@ilande.co.uk>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <53c02ed9-c21a-a628-753c-09f3f4e632f4@redhat.com>
Date: Mon, 9 Nov 2020 11:02:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <eda03864-cbd5-4205-8b69-06fa20321b49@ilande.co.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/09 01:25:23
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1,
 RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 06/11/2020 08.35, Mark Cave-Ayland wrote:
> On 05/11/2020 05:31, Thomas Huth wrote:
> 
>>> (goes and looks)
>>>
>>> Ah okay it appears to be because the object property link to the PIC is
>>> missing, which is to be expected as it is only present on the Mac machines.
>>>
>>> With the latest round of QOM updates I can see the solution but it's
>>> probably a bit much now that we've reached rc-0. The easiest thing for the
>>> moment is to switch user_creatable back to false if this is causing an
>>> issue.
>>
>> +1 for setting user_creatable back to false ... can you send a patch or
>> shall I prepare one?
> 
> No that's fine, I can come up with a fix over the next couple of days.

Thanks!

>>> Just out of interest how did you find this? My new workflow involves a local
>>> "make check" with all ppc targets and a pass through Travis-CI and it didn't
>>> show up there for me (or indeed Peter's pre-merge tests).
>>
>> I've found it with the scripts/device-crash-test script. (You currently need
>> to apply Eduardo's patch "Check if path is actually an executable file" on
>> top first to run it)
> 
> Have you got a link for this? I've tried doing some basic searches in my
> email client and couldn't easily spot it...

https://lists.gnu.org/archive/html/qemu-devel/2020-10/msg07549.html

 Thomas


