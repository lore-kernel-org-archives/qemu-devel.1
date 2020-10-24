Return-Path: <SRS0=SOuJ=D7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDEF7C4363A
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Oct 2020 19:45:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D9A9F20BED
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Oct 2020 19:45:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QzY9yNmW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9A9F20BED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50932 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kWPTI-0005OE-SW
	for qemu-devel@archiver.kernel.org; Sat, 24 Oct 2020 15:45:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56686)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kWPSP-0004ik-87
 for qemu-devel@nongnu.org; Sat, 24 Oct 2020 15:44:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:51652)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kWPSI-0006yH-Ki
 for qemu-devel@nongnu.org; Sat, 24 Oct 2020 15:44:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603568636;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=V4yE9dLrwfZ7DK8pvRkM0dBsxw+Cusk0Ni+JYE+MMps=;
 b=QzY9yNmW3vIDp61mFNFMDHTiOhRez5VSmRP8W09q9c/tjNbuPSQCsajIgURDGZBEXo1HOQ
 tDXOjNpVogzB4ZbGXcv59roekhV+GpKnwJWQlMKMOpwoBvPGZL0Srah+b8BoCTCr8xDRSR
 RA80waDh8AWiL3uXWf/R/TXLasBID/4=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-478-SaCrhxMEN9yePoTEM4RBKg-1; Sat, 24 Oct 2020 15:43:54 -0400
X-MC-Unique: SaCrhxMEN9yePoTEM4RBKg-1
Received: by mail-wr1-f71.google.com with SMTP id h8so3645737wrt.9
 for <qemu-devel@nongnu.org>; Sat, 24 Oct 2020 12:43:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=V4yE9dLrwfZ7DK8pvRkM0dBsxw+Cusk0Ni+JYE+MMps=;
 b=rf07nMcOEodxbj8zV3jt/IRQ5AVJ4BzjFJ9NG9+0PIjS7bFi8VLbY72qVIdTRz5EKL
 Qo/vgJVnEGI7LLPJ18vdOM2+o46B7nhcv/89kZ6/PI6xkvmxSQvzcbhIQNPLIvdUIEDY
 FMqLxxwGwAszopUORSEkG+Wb37uS1szSu7O4HcKyb5a49krTXWPnIvDM1vYlBMFfMsWx
 GEnqfD/qrblqelIgfdsckazfryteqDSI5THhogqezruL9nYwpnOnFjkwtfl3gKeqm7sx
 lO+5guo7mMHpbQlOmcTw8WWj1nXVEK3S5zTsRm4JJ4asR/ohiOp6iKunjNPWCMvnLLbs
 vsEQ==
X-Gm-Message-State: AOAM531+7xBS3rWlTzRxYQbODim/+8L3GVpkLazYchKOlNIwC4ALR4U3
 6Dof/YexNyr6N3mWrZldmkpBtFWhC3+i/APSuG7Kgkbzq2UxPhLqHrmhMWU1sCBZMKbbecYs7Q1
 LtN6gr9DG42k17/g=
X-Received: by 2002:adf:d0cf:: with SMTP id z15mr9747997wrh.213.1603568633502; 
 Sat, 24 Oct 2020 12:43:53 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyhAmzSSQLpO2sn28QmIFrreVrz4Tj7kSIHVDnGejtA48a8Px4xbRBBqpR4o1es2z98rmFCFg==
X-Received: by 2002:adf:d0cf:: with SMTP id z15mr9747961wrh.213.1603568633180; 
 Sat, 24 Oct 2020 12:43:53 -0700 (PDT)
Received: from [192.168.1.36] (237.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.237])
 by smtp.gmail.com with ESMTPSA id o7sm179706wrp.23.2020.10.24.12.43.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 24 Oct 2020 12:43:52 -0700 (PDT)
Subject: Re: [PATCH v28 00/17] Add migration support for VFIO devices
To: Kirti Wankhede <kwankhede@nvidia.com>, alex.williamson@redhat.com,
 cjia@nvidia.com
References: <1603449643-12851-1-git-send-email-kwankhede@nvidia.com>
 <5e8b3347-ba20-7511-1e84-a9e42a6ab430@redhat.com>
 <4561712d-1770-8850-24fe-0578efcf4646@nvidia.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <f223d058-c89a-8a65-73de-59c08cf6f1e0@redhat.com>
Date: Sat, 24 Oct 2020 21:43:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <4561712d-1770-8850-24fe-0578efcf4646@nvidia.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/24 15:43:56
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.107, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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
Cc: zhi.wang.linux@gmail.com, aik@ozlabs.ru, Zhengxiao.zx@Alibaba-inc.com,
 shuangtai.tst@alibaba-inc.com, qemu-devel@nongnu.org, peterx@redhat.com,
 eauger@redhat.com, artemp@nvidia.com, yi.l.liu@intel.com, quintela@redhat.com,
 ziye.yang@intel.com, armbru@redhat.com, mlevitsk@redhat.com,
 pasic@linux.ibm.com, felipe@nutanix.com, zhi.a.wang@intel.com,
 mcrossley@nvidia.com, kevin.tian@intel.com, yan.y.zhao@intel.com,
 eskultet@redhat.com, dgilbert@redhat.com, changpeng.liu@intel.com,
 cohuck@redhat.com, Ken.Xue@amd.com, jonathan.davies@nutanix.com,
 pbonzini@redhat.com, dnigam@nvidia.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/24/20 7:48 PM, Kirti Wankhede wrote:
> On 10/24/2020 10:26 PM, Philippe Mathieu-Daudé wrote:
>> Hi Kirti,
>>
>> On 10/23/20 12:40 PM, Kirti Wankhede wrote:
>>> Hi,
>>>
>>> This Patch set adds migration support for VFIO devices in QEMU.
>> ...
>>
>>> Since there is no device which has hardware support for system memmory
>>> dirty bitmap tracking, right now there is no other API from vendor 
>>> driver
>>> to VFIO IOMMU module to report dirty pages. In future, when such 
>>> hardware
>>> support will be implemented, an API will be required in kernel such that
>>> vendor driver could report dirty pages to VFIO module during 
>>> migration phases.
>>>
>>> Below is the flow of state change for live migration where states in 
>>> brackets
>>> represent VM state, migration state and VFIO device state as:
>>>      (VM state, MIGRATION_STATUS, VFIO_DEVICE_STATE)
>>>
>>> Live migration save path:
>>>          QEMU normal running state
>>>          (RUNNING, _NONE, _RUNNING)
>>>                          |
>>>      migrate_init spawns migration_thread.
>>>      (RUNNING, _SETUP, _RUNNING|_SAVING)
>>>      Migration thread then calls each device's .save_setup()
>>>                          |
>>>      (RUNNING, _ACTIVE, _RUNNING|_SAVING)
>>>      If device is active, get pending bytes by .save_live_pending()
>>>      if pending bytes >= threshold_size,  call save_live_iterate()
>>>      Data of VFIO device for pre-copy phase is copied.
>>>      Iterate till total pending bytes converge and are less than 
>>> threshold
>>>                          |
>>>      On migration completion, vCPUs stops and calls 
>>> .save_live_complete_precopy
>>>      for each active device. VFIO device is then transitioned in
>>>       _SAVING state.
>>>      (FINISH_MIGRATE, _DEVICE, _SAVING)
>>>      For VFIO device, iterate in .save_live_complete_precopy until
>>>      pending data is 0.
>>>      (FINISH_MIGRATE, _DEVICE, _STOPPED)
>>>                          |
>>>      (FINISH_MIGRATE, _COMPLETED, _STOPPED)
>>>      Migraton thread schedule cleanup bottom half and exit
>>>
>>> Live migration resume path:
>>>      Incomming migration calls .load_setup for each device
>>>      (RESTORE_VM, _ACTIVE, _STOPPED)
>>>                          |
>>>      For each device, .load_state is called for that device section data
>>>      (RESTORE_VM, _ACTIVE, _RESUMING)
>>>                          |
>>>      At the end, called .load_cleanup for each device and vCPUs are 
>>> started.
>>>                          |
>>>          (RUNNING, _NONE, _RUNNING)
>>>
>>> Note that:
>>> - Migration post copy is not supported.
>>
>> Can you commit this ^^^ somewhere in docs/devel/ please?
>> (as a patch on top of this series)
>>
> 
> Philippe, Alex,
> I'm going to respin this series with r-bs and fix suggested by Yan.
> Should this doc be part of this series or we can add it later after 
> 10/27 if again review of this doc would need some iterations?

I suppose it is up to the maintainer, no objection from my part.

This information seems valuable and wouldn't like it be lost.
If by 10/27 you refer to the "soft freeze", then there is no
problem to add documentation patches after this date :)

Regards,

Phil.


