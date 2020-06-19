Return-Path: <SRS0=Yszf=AA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96294C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 09:44:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F7372080C
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 09:44:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cpQPtDFF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F7372080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58878 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jmDZr-0003mK-K2
	for qemu-devel@archiver.kernel.org; Fri, 19 Jun 2020 05:44:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43990)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1jmDZG-0003ET-8c
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 05:44:14 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:21840
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1jmDZE-0007ta-6e
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 05:44:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592559851;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=H3TsA6fI1WLgb9bEHMMoene8nUem6Wd814KLQ/MXmUg=;
 b=cpQPtDFFs8ToReI5naac9LeWlEjyS3ucwvWfZSXxzrmEUBFRdwvCfDO1Se+crwc2YElBjS
 w7/YCP1YPMxQJ+5YxPkPurEpVzD73Q2bX5R7UvkSZsnlfsrl0hqTEPhLsnIDRFYusEBnWZ
 vtr+zE2QdvbgCq/z8UZfNlBjQMc++LI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-190-T-BTURmpMN6CI7aGStc1xw-1; Fri, 19 Jun 2020 05:44:09 -0400
X-MC-Unique: T-BTURmpMN6CI7aGStc1xw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D0D6D8018AB;
 Fri, 19 Jun 2020 09:44:07 +0000 (UTC)
Received: from [10.36.114.197] (ovpn-114-197.ams2.redhat.com [10.36.114.197])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7679271677;
 Fri, 19 Jun 2020 09:43:55 +0000 (UTC)
Subject: Re: [PATCH v4 1/5] acpi: Convert build_tpm2() to build_append* API
To: Laszlo Ersek <lersek@redhat.com>, Stefan Berger <stefanb@linux.ibm.com>,
 Igor Mammedov <imammedo@redhat.com>
References: <20200611135917.18300-1-eric.auger@redhat.com>
 <20200611135917.18300-2-eric.auger@redhat.com>
 <20200616143327.2ee38a48@redhat.com>
 <3c3b466a-c965-e3f6-9bd6-74fce9c424c8@linux.ibm.com>
 <ed1b453d-2568-2134-3e86-c268e82a90f8@redhat.com>
 <ded58c6b-dcea-67ef-4f3c-b8af9f149ae8@redhat.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <44663542-8352-2398-a297-3e1fe7f4bfd5@redhat.com>
Date: Fri, 19 Jun 2020 11:43:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <ded58c6b-dcea-67ef-4f3c-b8af9f149ae8@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.120;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/19 05:19:18
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: peter.maydell@linaro.org, drjones@redhat.com, mst@redhat.com,
 qemu-devel@nongnu.org, shannon.zhaosl@gmail.com, qemu-arm@nongnu.org,
 marcandre.lureau@redhat.com, philmd@redhat.com, ardb@kernel.org,
 eric.auger.pro@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Laszlo,

On 6/19/20 11:38 AM, Laszlo Ersek wrote:
> On 06/18/20 09:50, Auger Eric wrote:
>> Hi Stefan, Igor,
>>
>> On 6/16/20 4:11 PM, Stefan Berger wrote:
>>> On 6/16/20 8:33 AM, Igor Mammedov wrote:
>>>>
>>>> nevertheless looks like faithfull conversion,
>>>> btw why you didn't drop Acpi20TPM2 structure definition?
>>>>
>>> If we get rid of the table we should keep a reference to this document,
>>> table 7: "TCG ACPI Specification; Family 1.2 and 2.0; Level 00 Revision
>>> 00.37, December 19, 2014"
>>>
>>> https://trustedcomputinggroup.org/wp-content/uploads/TCG_ACPIGeneralSpecification_1-10_0-37-Published.pdf
>>>
>>>
>>>
>> Further looking at this spec, the log_area_minimum_length and
>> log_area_start_address only are described in
>> - Table 2 (TCG Hardware InterfaceDescription Table Format for TPM 1.2
>> Clients)
>> - Table 4 (TCG Hardware Interface Description Table Format for TPM 1.2
>> Servers)
>> but not in Table 7, ie. not for TPM 2.0.
>>
>> Are they really needed for TPM2 or what do I miss?
> 
> (side comment:
> 
> LASA and LAML are optional with TPM-2.0. From the discussion at
> <https://bugzilla.tianocore.org/show_bug.cgi?id=978>.

Thank you for the pointer and info. I failed to find this info in the
spec. Given the risk of confusion, I would personally keep struct
Acpi20TPM2 and maybe add a comment. Stefan?

Thanks

Eric
> 
> )
> 
> Thanks
> Laszlo
> 


