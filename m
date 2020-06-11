Return-Path: <SRS0=U615=7Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74C53C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 11:32:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D90220760
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 11:32:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F95zLJLq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D90220760
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41804 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjLRk-000438-II
	for qemu-devel@archiver.kernel.org; Thu, 11 Jun 2020 07:32:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46786)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1jjLQs-00033T-G8
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 07:31:42 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:30440
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1jjLQq-0007KF-Ho
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 07:31:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591875098;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bb5MbMUt7rfx56ny1QmggNavflgbu2RsHY+5CyxxMbk=;
 b=F95zLJLq0lz30rH+VhQyqQ/qDWTrC3/JeZcFvlK0MdUDn27nWkQsE2fD4pqTFnq29TqS+Q
 huSaCB8WI2CoACTAnwcxBFSgDzG649EvhD5jPCRV0pdKZPjYyyZbaX3ebu8rUR4vJkRCS/
 51W+1LFY/X/OL7V1/4RAIpY/sqhKNOo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-426-UulC92iDPlmgC3iBK9k_eA-1; Thu, 11 Jun 2020 07:31:34 -0400
X-MC-Unique: UulC92iDPlmgC3iBK9k_eA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 854891845160;
 Thu, 11 Jun 2020 11:31:33 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-114-21.ams2.redhat.com
 [10.36.114.21])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1B3B98929B;
 Thu, 11 Jun 2020 11:31:28 +0000 (UTC)
Subject: Re: [PATCH v7 2/5] softmmu/vl: Let -fw_cfg option take a 'gen_id'
 argument
To: minyard@acm.org
References: <20200528173141.17495-1-philmd@redhat.com>
 <20200528173141.17495-3-philmd@redhat.com>
 <f3f6154e-bbc1-98bd-0f44-77b28c74915f@redhat.com>
 <20200609155050.GT2880@minyard.net>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <6e4b9540-7d5b-0951-2870-bada03e29d83@redhat.com>
Date: Thu, 11 Jun 2020 13:31:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200609155050.GT2880@minyard.net>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=lersek@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/11 03:29:33
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 06/09/20 17:50, Corey Minyard wrote:
> On Fri, May 29, 2020 at 11:50:24AM +0200, Laszlo Ersek wrote:
>> Gerd, Corey: there's a question for you near the end, please.
>>
>> On 05/28/20 19:31, Philippe Mathieu-Daudé wrote:
> 
> snip...
> 
>>
>>
>> (3) I've noticed another *potential* issue, from looking at the larger
>> context. I apologize for missing it in v6.
>>
>> See commit bab47d9a75a3 ("Sort the fw_cfg file list", 2016-04-07). (I'm
>> copying Corey; Gerd is already copied.) From that commit, we have, at
>> the end of this function:
>>
>>     /* For legacy, keep user files in a specific global order. */
>>     fw_cfg_set_order_override(fw_cfg, FW_CFG_ORDER_OVERRIDE_USER);
>>     fw_cfg_add_file(fw_cfg, name, buf, size);
>>     fw_cfg_reset_order_override(fw_cfg);
>>
>> This takes effect for "file" and "string", but not for "gen_id". Should
>> we apply it to "gen_id" as well? (Sorry, I really don't understand what
>> commit bab47d9a75a3 is about!)
> 
> I can explain the rationale for that change, but I'm not sure of the
> answer to your question.  That changes makes sure that the fw_cfg data
> remains exactly the same even on newer versions of qemu if the machine
> is set the same.  This way you can do migrations to newer qemu versions
> and anything using fw_cfg won't get confused because the data changes.
> 
> The reason that change was so complex was preserving the order for
> migrating from older versions.
> 
> This is only about migration.  I'm not sure what gen_id is, but if it's
> migrated, it better be future proof.

Whenever introducing a new fw_cfg file (*any* new named file), how do we
decide whether we need fw_cfg_set_order_override()?

Thanks
Laszlo


> 
> -corey
> 
>>
>> *IF* we want to apply the same logic to "gen_id", then we should
>> *perhaps* do, on the "nonempty_str(gen_id)" branch:
>>
>>         size_t fw_cfg_size;
>>
>>         fw_cfg_set_order_override(fw_cfg, FW_CFG_ORDER_OVERRIDE_USER);
>>         fw_cfg_size = fw_cfg_add_from_generator(fw_cfg, name, gen_id, errp);
>>         fw_cfg_reset_order_override(fw_cfg);
>>         return (fw_cfg_size > 0) ? 0 : -1;
>>
>> I think???
>>
>> Or maybe even use FW_CFG_ORDER_OVERRIDE_DEVICE rather than
>> FW_CFG_ORDER_OVERRIDE_USER? I don't have the slightest clue.
>>
>> (I guess if I understood what commit bab47d9a75a3 was about, I'd be less
>> in doubt now. But that commit only hints at "avoid[ing] any future
>> issues of moving the file creation" -- I don't know what those issues
>> were in the first place!)
>>
>> With (1) optionally fixed, and (2) fixed, I'd be willing to R-b this
>> patch; but I'm really thrown off by (3).
>>
>> Thanks,
>> Laszlo
>>
>>
>>>      } else {
>>>          GError *err = NULL;
>>>          if (!g_file_get_contents(file, &buf, &size, &err)) {
>>>
>>
> 


