Return-Path: <SRS0=bzpH=76=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 883F3C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 10:43:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 160B32082F
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 10:43:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SPf6WUNG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 160B32082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56918 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlVXX-0002bE-4U
	for qemu-devel@archiver.kernel.org; Wed, 17 Jun 2020 06:43:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58278)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jlVWx-0002Ax-2z
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 06:42:55 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:26883
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jlVWu-0001tu-Ja
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 06:42:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592390571;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=L3E51P1F6tOTVd+pdpCEPNsEWH7FEVLZBQ64ExdzXaA=;
 b=SPf6WUNGijn82CID9dGB9eSMP4Z8SVeYQgfU8w/jk379bQmdEV5HG7dSuK1RAdlJusIYEW
 HLauz9wlkabJqOvKOwq96PMeBFzYjJaGO/9QbMgQJIi48Ii8ZeZyivFXOG1vD0BIr6bKPU
 vlpD0w7OQs6SlaMntwFA+Xe0yBTQ198=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-357-2lSJNCAHPryIyr_dkDfPbQ-1; Wed, 17 Jun 2020 06:42:49 -0400
X-MC-Unique: 2lSJNCAHPryIyr_dkDfPbQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 01D8918A8236;
 Wed, 17 Jun 2020 10:42:48 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-112-131.ams2.redhat.com [10.36.112.131])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 53A9D104B4C1;
 Wed, 17 Jun 2020 10:42:46 +0000 (UTC)
Subject: Re: Core dump happened when starting a VM on arm64 server
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Andrew Jones <drjones@redhat.com>, Haibo Xu <haibo.xu@linaro.org>
References: <CAJc+Z1Eb815hroFPY+9Ai_9hh=+eje+X2ENtGj9XA+_F0XUPqg@mail.gmail.com>
 <20200611091419.e2rfcurztmlajlwr@kamzik.brq.redhat.com>
 <a6740274-1bd7-460c-7011-244cdf2fc945@redhat.com>
 <e47664d7-a13e-7f60-975d-97f085036067@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <5f1d1d2b-7a85-f50e-1f74-b74ab17324ac@redhat.com>
Date: Wed, 17 Jun 2020 12:42:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <e47664d7-a13e-7f60-975d-97f085036067@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=thuth@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/17 01:42:04
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: Markus Armbruster <armbru@redhat.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 17/06/2020 12.32, Philippe Mathieu-Daudé wrote:
> On 6/17/20 10:23 AM, Philippe Mathieu-Daudé wrote:
>> On 6/11/20 11:14 AM, Andrew Jones wrote:
>>> On Thu, Jun 11, 2020 at 04:46:45PM +0800, Haibo Xu wrote:
>>>> Hi,
>>>>
>>>> I met a qemu core dump issue when starting a VM with cpu feature
>>>> "pmu=on" on an arm server.
>>>> The commands to start the machine is:
>>>>
>>>>   ./qemu-system-aarch64 \
>>>>            -cpu host,pmu=on -M virt,accel=kvm,gic-version=3 -nographic
>>>> -m 2048M \
>>>>            -kernel ./Image \
>>>>            -initrd /boot/initrd.img-5.6.0-rc2+ \
>>>>            -append "root=/dev/vda rw console=ttyAMA0" -nodefaults -serial stdio\
>>>>            -drive if=none,file=./xenial.rootfs.ext4,id=hd0,format=raw \
>>>>            -device virtio-blk-device,drive=hd0
>>>>
>>>>
>>>> And here is the stack dump:
>>>>
>>>>  Core was generated by `./qemu-system-aarch64 -cpu host,pmu=on -M
>>>> virt,accel=kvm,gic-version=3 -nograph'.
>>>>  Program terminated with signal SIGSEGV, Segmentation fault.
>>>>  #0  kvm_ioctl (s=0x0, type=type@entry=44547) at
>>>
>>> s=0x0 means cpu->kvm_state is NULL
>>>
>>>> The root cause is in the arm_get_pmu() operation which was introduced
>>>> in ae502508f83.
>>>
>>> Actually the root cause is d70c996df23f ("target/arm/kvm: Use
>>> CPUState::kvm_state in kvm_arm_pmu_supported()"). ae502508f83 used
>>> the machine kvm_state, not the cpu kvm_state, and that allows pmu=on
>>> to work. d70c996df23f changed that saying that "KVMState is already
>>> accessible via CPUState::kvm_state, use it.", but I'm not sure why,
>>> since kvm_init_vcpu() doesn't run until the vcpu thread is created.
>>>
>>> Philippe?
>>
>> Sorry for some reason I missed this email. I'll look at this today.
> 
> Quick reproducer:
> 
> $ qemu-system-aarch64 -cpu host,pmu=on -M virt,accel=kvm,gic-version=3
> Segmentation fault (core dumped)
> 
> Eduardo, I thought we had a 'machine' qtest testing for various
> combination of properties, but I can't find it, do you remember?
> Or maybe it was Thomas? Or Markus? =)

You probably remember the scripts/device-crash-test script? ... that's
a) only testing -device options as far as I know, and b) is not run
automatically during "make check", so it certainly is not suitable to
detect these kind of errors automatically.

 Thomas


