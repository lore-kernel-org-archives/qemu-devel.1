Return-Path: <SRS0=qU7A=VV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E429C7618F
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jul 2019 14:52:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 000D320665
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jul 2019 14:52:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ro3VxLN7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 000D320665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52358 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqIdI-0003iX-6S
	for qemu-devel@archiver.kernel.org; Wed, 24 Jul 2019 10:52:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36642)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.weiyang@gmail.com>) id 1hqId7-0003KJ-7f
 for qemu-devel@nongnu.org; Wed, 24 Jul 2019 10:52:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.weiyang@gmail.com>) id 1hqId5-0000PI-VR
 for qemu-devel@nongnu.org; Wed, 24 Jul 2019 10:52:33 -0400
Received: from mail-ed1-x541.google.com ([2a00:1450:4864:20::541]:34883)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.weiyang@gmail.com>)
 id 1hqId5-0000Op-Oc
 for qemu-devel@nongnu.org; Wed, 24 Jul 2019 10:52:31 -0400
Received: by mail-ed1-x541.google.com with SMTP id w20so47354396edd.2
 for <qemu-devel@nongnu.org>; Wed, 24 Jul 2019 07:52:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=nOcCaCVJpbcjxskNtvRoL6Twd/kC3KL4liKi3M6J80Y=;
 b=Ro3VxLN7e9pJlHU5RVDNswAw7RPjvkp2oMaWlBWm9SIcZZp0m3KYqNz2PmgLkOOYc4
 1rAvdkhqPGnRWtIzJnTDmyoFLfA7ywEGkiA7mQyF6IUeaUXp5oUnHJxv2a91GrBBBjVy
 FThdC63s0riQuSq10j00w0oBiVGs1phm3MvtCXJci0Ank1ZsspMRCHpcMwApT9h1uKrg
 FAqQaDMyKmnE3smGYF0e0iVPPyAkFd6nn7sai+2O3U8nh06Mg1j9xnTHRG+lxESdmWtI
 RYn19VZsuBH+1VOKQ1bx94tqtKj+SdUEUEdXAy9JZvZaZ4IVjhDtoHGEr1/PXtSUWeZd
 Fa4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
 :references:mime-version:content-disposition:in-reply-to:user-agent;
 bh=nOcCaCVJpbcjxskNtvRoL6Twd/kC3KL4liKi3M6J80Y=;
 b=DI0LlO6eOJg6lRsGoD2cAaXAEC6m89WspjYgVkg7aLXTq0/HRxsmUlHRDIaRbl7hsg
 WngB2scVMdrh7rNsMUCOjobqB6dc2erPAmEdx8/eXgKj/QmLRfzb0bzkSW3HRL45FbmT
 N22SrOlvGu2q6v2ItQPJtdxIjMbUBNEPUtAQkwe9NxG38nt1WycZUt51F1LVPNpz3PaU
 aAu8j97DlwMY7OnKGKIy0e3mk2R+LZ5Lz61JlUxSoClVxhzWpXziqr6n6gOgndPF+33b
 MN+k4+CSRRoPf7xYDZmt3fh08K310RKUOc1IPIIekVZcg3SYgPyvljntd/L3GytXKa8Y
 e/lQ==
X-Gm-Message-State: APjAAAWhZSPXqFlvc5K5LZg/hmrCo5iOd393gfL4IXmGNA9Kokzs0GjC
 rUOvzsMKFBwRDeWOdkaSy/w=
X-Google-Smtp-Source: APXvYqxHBizU0NTvyHOqg6pLa5uvFVIGKeH8nopT2AZ5tuacVtKkseFser54WWyOGxeU9KEv/eVTPQ==
X-Received: by 2002:a17:906:cec9:: with SMTP id
 si9mr35938086ejb.38.1563979950389; 
 Wed, 24 Jul 2019 07:52:30 -0700 (PDT)
Received: from localhost ([185.92.221.13])
 by smtp.gmail.com with ESMTPSA id x21sm13054167edb.0.2019.07.24.07.52.29
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 24 Jul 2019 07:52:29 -0700 (PDT)
Date: Wed, 24 Jul 2019 14:52:28 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: Pankaj Gupta <pagupta@redhat.com>
Message-ID: <20190724145228.jkcruug5ikhorycv@master>
References: <20190724070307.12568-1-richardw.yang@linux.intel.com>
 <127005664.4113094.1563963451244.JavaMail.zimbra@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <127005664.4113094.1563963451244.JavaMail.zimbra@redhat.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::541
Subject: Re: [Qemu-devel] [PATCH] docs/nvdimm: add example on persistent
 backend setup
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
Reply-To: Wei Yang <richard.weiyang@gmail.com>
Cc: qemu-devel@nongnu.org, ross zwisler <ross.zwisler@linux.intel.com>,
 xiaoguangrong eric <xiaoguangrong.eric@gmail.com>,
 Wei Yang <richardw.yang@linux.intel.com>, mst@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jul 24, 2019 at 06:17:31AM -0400, Pankaj Gupta wrote:
>
>> 
>> Persistent backend setup requires some knowledge about nvdimm and ndctl
>> tool. Some users report they may struggle to gather these knowledge and
>> have difficulty to setup it properly.
>> 
>> Here we provide two examples for persistent backend and gives the link
>> to ndctl. By doing so, user could try it directly and do more
>> investigation on persistent backend setup with ndctl.
>> 
>> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
>> ---
>>  docs/nvdimm.txt | 28 ++++++++++++++++++++++++++++
>>  1 file changed, 28 insertions(+)
>> 
>> diff --git a/docs/nvdimm.txt b/docs/nvdimm.txt
>> index b531cacd35..baba7a940d 100644
>> --- a/docs/nvdimm.txt
>> +++ b/docs/nvdimm.txt
>> @@ -171,6 +171,32 @@ guest software that this vNVDIMM device contains a
>> region that cannot
>>  accept persistent writes. In result, for example, the guest Linux
>>  NVDIMM driver, marks such vNVDIMM device as read-only.
>>  
>> +Backend File Setup Example
>> +..........................
>> +
>> +Here is two examples for how to setup these persistent backend on
>> +linux, which leverages the tool ndctl [3].
>> +
>> +It is easy to setup DAX device backend file.
>> +
>> +A. DAX device
>> +
>> +    ndctl create-namespace -f -e namespace0.0 -m devdax
>> +
>> +The /dev/dax0.0 could be used directly in "mem-path" option.
>> +
>> +For DAX file, it is more than creating the proper namespace. The
>> +block device should be partitioned and mounted (with dax option).
>> +
>> +B. DAX file
>> +
>> +    ndctl create-namespace -f -e namespace0.0 -m fsdax
>> +    (partition /dev/pmem0 with name pmem0p1)
>> +    mount -o dax /dev/pmem0p1 /mnt
>> +    (dd a file with proper size in /mnt)
>
>This is not clear to me. why 'dd' file is required in /mnt?
>You mean for creating a backend file?
>

Yes, create a backend file. You need to give a file instead of a directory to
qemu command line.

>> +
>> +Then the new file in /mnt could be used in "mem-path" option.
>> +
>>  NVDIMM Persistence
>>  ------------------
>>  
>> @@ -212,3 +238,5 @@ References
>>      https://www.snia.org/sites/default/files/technical_work/final/NVMProgrammingModel_v1.2.pdf
>>  [2] Persistent Memory Development Kit (PMDK), formerly known as NVML
>>  project, home page:
>>      http://pmem.io/pmdk/
>> +[3] ndctl-create-namespace - provision or reconfigure a namespace
>> +    http://pmem.io/ndctl/ndctl-create-namespace.html
>> --
>
>Looks good to me. Just a small comment above. 
>Other than that: Reviewed-by: Pankaj Gupta <pagupta@redhat.com>
>

Thanks

>> 2.17.1
>> 
>> 
>> 

-- 
Wei Yang
Help you, Help me

