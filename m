Return-Path: <SRS0=f7ls=75=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01683C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 15:26:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C3536208B3
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 15:26:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MHPD5VA/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3536208B3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36536 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlDTO-0005N1-2V
	for qemu-devel@archiver.kernel.org; Tue, 16 Jun 2020 11:26:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45738)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1jlDRV-0003PA-9E
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 11:24:05 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:56685
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1jlDRU-0003kg-5l
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 11:24:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592321042;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SaSmVfTnTer0Sknay32MRp1VvIbcgOVrouh8IpTcbO0=;
 b=MHPD5VA/UQQx2RV0lYPeuUN5J8139DBpFzs/sr5++C1OcJE6yqOIBJbusBCnCXsEtxe7dp
 GN5JM0VNkmD8e9fL5dguCp6YeLM94bZGIyFRF64WDdH19cRHi8PKh8alyK9EeVfR/hj1+i
 b5aQPjGuPGivQanu7g+A0AmguT+Z4bI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-241-uzkSIDA8MniNmQsokhr0rA-1; Tue, 16 Jun 2020 11:23:59 -0400
X-MC-Unique: uzkSIDA8MniNmQsokhr0rA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E6C7F1185FA5;
 Tue, 16 Jun 2020 15:23:42 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-113-248.ams2.redhat.com
 [10.36.113.248])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9C9835D9D3;
 Tue, 16 Jun 2020 15:23:41 +0000 (UTC)
Subject: Re: [PATCH v7 2/5] softmmu/vl: Let -fw_cfg option take a 'gen_id'
 argument
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>
References: <20200528173141.17495-1-philmd@redhat.com>
 <20200528173141.17495-3-philmd@redhat.com>
 <f3f6154e-bbc1-98bd-0f44-77b28c74915f@redhat.com>
 <20200609155050.GT2880@minyard.net>
 <6e4b9540-7d5b-0951-2870-bada03e29d83@redhat.com>
 <20200615144527.w2637fq5jzpk7jtt@sirius.home.kraxel.org>
 <dbb5766d-ffd6-df64-09f6-0a78efe6e46c@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <cc3dda60-30eb-0442-6570-2a5477702635@redhat.com>
Date: Tue, 16 Jun 2020 17:23:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Firefox/52.0 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <dbb5766d-ffd6-df64-09f6-0a78efe6e46c@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=lersek@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/16 02:46:07
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>,
 qemu-devel@nongnu.org, minyard@acm.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 06/15/20 17:02, Philippe Mathieu-Daudé wrote:
> On 6/15/20 4:45 PM, Gerd Hoffmann wrote:
>>   Hi,
>>
>>>> I can explain the rationale for that change, but I'm not sure of the
>>>> answer to your question.  That changes makes sure that the fw_cfg data
>>>> remains exactly the same even on newer versions of qemu if the machine
>>>> is set the same.  This way you can do migrations to newer qemu versions
>>>> and anything using fw_cfg won't get confused because the data changes.
>>>>
>>>> The reason that change was so complex was preserving the order for
>>>> migrating from older versions.
>>>>
>>>> This is only about migration.  I'm not sure what gen_id is, but if it's
>>>> migrated, it better be future proof.
>>>
>>> Whenever introducing a new fw_cfg file (*any* new named file), how do we
>>> decide whether we need fw_cfg_set_order_override()?
>>
>> The whole point of the sorting is to make sure the fw_cfg directory
>> listing entry (FW_CFG_FILE_DIR) is stable and doesn't change underneath
>> the guest when it gets live-migrated.
>>
>> That sorting was added in qemu 2.6, to make sure things don't chance by
>> accident in case the initialization order changes.  Now you've got a
>> problem when you migrate from qemu 2.5 (+older) to qemu 2.6 (+newer),
>> because 2.5 has the entries in initialization order and 2.6 has the
>> entries in alphabetical order.  To deal with that machine types for 2.5
>> & older keep the old sort order.  This is the reason why
>> legacy_fw_cfg_order exists.
>>
>> For new features and files you can completely ignore the whole legacy
>> sorting mess.  cross-version live migration works only for features
>> supported by both qemu versions, therefore the legacy sorting is only
>> relevant for features & files already supported by qemu 2.5.
> 
> Thanks you Gerd for the whole explanation. I added an entry to
> my TODO list to document this, based on your comment (and Corey's).

Yes, please!

Apparently, I've been confused by commit bab47d9a75a3 ("Sort the fw_cfg
file list", 2016-04-07) before (in January 2018):

http://mid.mail-archive.com/5367c8a4-91bd-7712-525d-0a1ed6e6acab@redhat.com

(See in particular my question which I believe remains relevant:

"is the idea that the same machine type on a new QEMU release may only
reorder the additions of the preexistent fw_cfg files across the source
code, but must not expose *new* fw_cfg files?"

And I think Gerd just answered that above (in the positive), namely,
"cross-version live migration works only for features supported by both
qemu versions". So indeed we must not have a new fw_cfg file appear in
an old machine type on a new QEMU release, without the user explicitly
asking for it on the command line.)

> I'll address it later, as you confirmed it doesn't impact this
> series.

That's my understanding too. Thanks for explaining, Gerd!

Laszlo


