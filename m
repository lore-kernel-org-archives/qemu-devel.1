Return-Path: <SRS0=DUFB=AZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7010BC433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 12:42:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E53B208FE
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 12:42:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S0RIIerz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E53B208FE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56934 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvKGK-000869-J8
	for qemu-devel@archiver.kernel.org; Tue, 14 Jul 2020 08:42:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43920)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1jvKFj-0007g4-R9
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 08:41:43 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:34625
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1jvKFi-0001lR-4T
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 08:41:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594730501;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=x1b5ik12p1ZMB1X/XLRf7mLZRuVu31unkxpCPuSSAWo=;
 b=S0RIIerzofJ44Fn3atxgUpVxOOVPGKCL7IUulcaKw5jmskSaYmFhKzpKB8iuCxCARcqxx+
 42Ei4OYvTB97j7DeSnki8jwNT/aDvRTdn623La1tc9E5cYoTRIqe/wZ3fl40mUrixKmI0Q
 kSgC0cEA4kA19cjTLHUrYVTNAq4X9z0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-191-p69yoXpANmiiHJuoEAKyqQ-1; Tue, 14 Jul 2020 08:41:37 -0400
X-MC-Unique: p69yoXpANmiiHJuoEAKyqQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3F89E800FED;
 Tue, 14 Jul 2020 12:41:36 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-114-110.ams2.redhat.com
 [10.36.114.110])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7F59E1053B25;
 Tue, 14 Jul 2020 12:41:29 +0000 (UTC)
Subject: Re: [RFC 3/3] x68: acpi: trigger SMI before scanning for hotplugged
 CPUs
From: Laszlo Ersek <lersek@redhat.com>
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
References: <20200710161704.309824-1-imammedo@redhat.com>
 <20200710161704.309824-4-imammedo@redhat.com>
 <515cc231-858a-a626-31a9-d74e1f6b4e38@redhat.com>
Message-ID: <b31defc1-a147-3dd3-b1de-b5f7651018b7@redhat.com>
Date: Tue, 14 Jul 2020 14:41:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Firefox/52.0 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <515cc231-858a-a626-31a9-d74e1f6b4e38@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=lersek@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/14 03:06:09
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: boris.ostrovsky@oracle.com, Peter Krempa <pkrempa@redhat.com>,
 liran.alon@oracle.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 07/14/20 14:28, Laszlo Ersek wrote:
> (CC'ing Peter Krempa due to virsh setvcpu (singular) / setvcpus (plural)
> references)
> 
> On 07/10/20 18:17, Igor Mammedov wrote:
>> In case firmware has negotiated CPU hotplug SMI feature, generate
>> AML to describe SMI IO port region and send SMI to firmware
>> on each CPU hotplug SCI.
>>
>> It might be not really usable, but should serve as a starting point to
>> discuss how better to deal with split hotplug sequence during hot-add
>> (
>> ex scenario where it will break is:
>>    hot-add
>>       -> (QEMU) add CPU in hotplug regs
>>       -> (QEMU) SCI
>>            -1-> (OS) scan
>>                -1-> (OS) SMI
>>                -1-> (FW) pull in CPU1 ***
>>                -1-> (OS) start iterating hotplug regs
>>    hot-add
>>       -> (QEMU) add CPU in hotplug regs
>>       -> (QEMU) SCI
>>             -2-> (OS) scan (blocked on mutex till previous scan is finished)
>>                -1-> (OS) 1st added CPU1 send device check event -> INIT/SIPI
>>                -1-> (OS) 1st added CPU2 send device check event -> INIT/SIPI
>>                        that's where it explodes, since FW didn't see CPU2
>>                        when SMI was called
>> )
>>
>> hot remove will throw in yet another set of problems, so lets discuss
>> both here and see if we can  really share hotplug registers block between
>> FW and AML or we should do something else with it.
> 
> This issue is generally triggered by management applications such as
> libvirt that issue device_add commands in quick succession. For libvirt,
> the command is "virsh setvcpus" (plural) with multiple CPUs specified
> for plugging. The singular "virsh setvcpu" command, which is more
> friendly towards guest NUMA, does not run into the symptom.
> 
> The scope of the scan method lock is not large enough, with SMI in the
> picture.
> 
> I suggest that we not uproot the existing AML code or the hotplug
> register block. Instead, I suggest that we add serialization at a higher
> level, with sufficient scope.
> 
> QEMU:
> 
> - introduce a new flag standing for "CPU plug operation in progress"
> 
> - if ICH9_LPC_SMI_F_BROADCAST_BIT has been negotiated:
> 
>   - "device_add" and "device_del" should enforce
>     ICH9_LPC_SMI_F_CPU_HOTPLUG_BIT and
>     ICH9_LPC_SMI_F_CPU_HOT_UNPLUG_BIT, respectively
> 
>   - both device_add and device_del (for VCPUs) should set check the
>     "in progress" flag.
> 
>     - If set, reject the request synchronously
> 
>     - Otherwise, set the flag, and commence the operation
> 
>   - in cpu_hotplug_wr(), where we emit the ACPI_DEVICE_OST event with
>     qapi_event_send_acpi_device_ost(), clear the "in-progress" flag.
> 
> - If QEMU executes the QMP command processing and the cpu_hotplug_wr()
> function on different (host OS) threads, then perhaps we should use an
> atomic type for the flag. (Not sure about locking between QEMU threads,
> sorry.) I don't really expect race conditions, but in case we ever get
> stuck with the flag, we should make sure that the stuck state is "in
> progress", and not "not in progress". (The former state can prevent
> further plug operations, but cannot cause the guest to lose state.)

Furthermore, the "CPU plug operation in progress" flag should be:
- either migrated,
- or a migration blocker.

Because on the destination host, device_add should be possible if and
only if the plug operation completed (either still on the source host,
or on the destination host).

I guess that the "migration blocker" option is easier.

Anyway I assume this is already handled with memory hotplug somehow
(i.e., migration attempt between device_add and ACPI_DEVICE_OST).

Thanks,
Laszlo


