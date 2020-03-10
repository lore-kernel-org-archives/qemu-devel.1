Return-Path: <SRS0=ZRpO=43=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B1BEC10F27
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 18:03:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 114D621927
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 18:03:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IC+L5b+Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 114D621927
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37978 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBjE8-0006BA-9K
	for qemu-devel@archiver.kernel.org; Tue, 10 Mar 2020 14:03:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48626)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eric.auger@redhat.com>) id 1jBjCt-0005by-BW
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 14:02:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eric.auger@redhat.com>) id 1jBjCr-0003ru-OM
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 14:02:18 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:54222
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eric.auger@redhat.com>)
 id 1jBjCn-0003Yn-IS
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 14:02:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583863327;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3bPxUy2EcaU0ypCm1YQuIIqo9A/ro6me+r8HBiJeNNo=;
 b=IC+L5b+ZmNeyMNDSjOn5Kyu2WlpkPJdr6tBK4riLlfl8qLm0TJYH2ANOIkYDF0SOYoLKcg
 4ZmHqS29NvL8+EzCI09Resbvbqad3v8/tgAmlOoDFD5hvyuV1Of60xWzs7BFL1tVjmc4ik
 I7OFgY5+GD3w787IVlhwPe3VzQkW+Pk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-464-3WPwxFC-PaqWf0O45R4Xtw-1; Tue, 10 Mar 2020 14:02:05 -0400
X-MC-Unique: 3WPwxFC-PaqWf0O45R4Xtw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 93787107ACCA;
 Tue, 10 Mar 2020 18:02:04 +0000 (UTC)
Received: from [10.36.117.85] (ovpn-117-85.ams2.redhat.com [10.36.117.85])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 187BE10013A1;
 Tue, 10 Mar 2020 18:02:02 +0000 (UTC)
Subject: Re: [PATCH v3 5/6] hw/arm/virt: kvm: Check the chosen gic version is
 supported by the host
To: Peter Maydell <peter.maydell@linaro.org>
References: <20200302105516.5972-1-eric.auger@redhat.com>
 <20200302105516.5972-6-eric.auger@redhat.com>
 <CAFEAcA-XD9LiokquaHj+kCYWA3N=7k3V3R8r5gA1HZM9Adus1A@mail.gmail.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <1370e0bc-ae17-c891-72b5-4cbc58ff3247@redhat.com>
Date: Tue, 10 Mar 2020 19:02:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-XD9LiokquaHj+kCYWA3N=7k3V3R8r5gA1HZM9Adus1A@mail.gmail.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: Marc Zyngier <maz@kernel.org>, Andrew Jones <drjones@redhat.com>,
 qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>,
 Eric Auger <eric.auger.pro@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Peter,

On 3/9/20 2:28 PM, Peter Maydell wrote:
> On Mon, 2 Mar 2020 at 10:55, Eric Auger <eric.auger@redhat.com> wrote:
>>
>> Restructure the finalize_gic_version with switch cases and, in
>> KVM mode, explictly check whether the chosen version is supported
>> by the host.
>>
>> if the end-user explicitly sets v2/v3 and this is not supported by
>> the host, then the user gets an explicit error message.
>>
>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>> Reviewed-by: Andrew Jones <drjones@redhat.com>
>>
>> ---
>>
>> v2 -> v3:
>> - explictly list V2 and V3 in the switch/case
>> - fix indent
>> ---
>>  hw/arm/virt.c | 77 +++++++++++++++++++++++++++++++++++----------------
>>  1 file changed, 53 insertions(+), 24 deletions(-)
>>
>> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
>> index eb8c57c85e..aeb6c45e51 100644
>> --- a/hw/arm/virt.c
>> +++ b/hw/arm/virt.c
>> @@ -1542,33 +1542,62 @@ static void virt_set_memmap(VirtMachineState *vms)
>>   */
>>  static void finalize_gic_version(VirtMachineState *vms)
>>  {
>> -    if (vms->gic_version == VIRT_GIC_VERSION_HOST ||
>> -        vms->gic_version == VIRT_GIC_VERSION_MAX) {
>> -        if (!kvm_enabled()) {
>> -            if (vms->gic_version == VIRT_GIC_VERSION_HOST) {
>> -                error_report("gic-version=host requires KVM");
>> -                exit(1);
>> -            } else {
>> -                /* "max": currently means 3 for TCG */
>> -                vms->gic_version = VIRT_GIC_VERSION_3;
>> -            }
>> -        } else {
>> -            int probe_bitmap = kvm_arm_vgic_probe();
>> +    if (kvm_enabled()) {
>> +        int probe_bitmap = kvm_arm_vgic_probe();
> 
> Previously we would only do kvm_arm_vgic_probe() if the
> user asked for 'host' or 'max'. Now we do it always,
> which means that if the user is on a really old kernel
> where the CREATE_DEVICE ioctl doesn't exist then we
> will now fail if the user specifically asked for gicv2,
> where previously we (probably) would have succeeded.
> I don't think we should put too much weight on continuing
> to theoretically support ancient kernels which we're not
> actually testing against, but it does seem a bit odd to
> probe even if we don't need to know the answer.
> 
> More relevant to actual plausible use cases, if
> kvm_irqchip_in_kernel() == false, we shouldn't be
> probing the kernel to ask what kind of GIC to use.
I think the existing code also does the same:
kvm_arm_vgic_probe() gets called as soon as vms->gic_version <= 0 &&
kvm_enabled() whatever the state of kvm_irqchip_in_kernel().

So in case the host only supports GICv2, in kvm mode with userspace
irqchip we would use GICV2 in host/max mode. If host supports GICv3 we
would select GICv3 which is not supported in !kvm_irqchip_in_kernel().

So do I understand correctly that you want me to change that behavior
and always set v2 in KVM/!kvm_irqchip_in_kernel() max/host mode?

Thanks

Eric

> 
> thanks
> -- PMM
> 


