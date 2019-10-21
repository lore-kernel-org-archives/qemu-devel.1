Return-Path: <SRS0=8ZcK=YO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C485CA9EB5
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 09:56:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 47A292070B
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 09:56:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RptpwOJb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47A292070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36876 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMUQG-0001vk-GV
	for qemu-devel@archiver.kernel.org; Mon, 21 Oct 2019 05:56:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38687)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <david@redhat.com>) id 1iMUOw-00019p-3G
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 05:54:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <david@redhat.com>) id 1iMUOu-000618-W8
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 05:54:58 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:46712
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <david@redhat.com>) id 1iMUOu-00060m-Rr
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 05:54:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571651696;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GFmur51y2TEPYGEBGid+K4QwtArQy0CFPL/V1kxr6io=;
 b=RptpwOJbGgHcfEMFeHIc9hrZUIhWqU9EUFwquV1pRH5FyoWRgawZBweOR8ie0XSk+BpnCZ
 pIyEWY6Q5A/1CoxUGrYS3xFNOwz/HohIyTSDIkhozjitlECsp0ixDhkkBWzhHb7i/zkaO+
 4WflROA6XCCuWJpJtguMrEx6J2U5LsI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-329-JuonsR8tMiyKNKxgOJHdzA-1; Mon, 21 Oct 2019 05:54:50 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7AF59107AD31;
 Mon, 21 Oct 2019 09:54:49 +0000 (UTC)
Received: from [10.36.116.198] (ovpn-116-198.ams2.redhat.com [10.36.116.198])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 80C2260606;
 Mon, 21 Oct 2019 09:54:47 +0000 (UTC)
Subject: Re: [PATCH v1] s390x/kvm: Set default cpu model for all machine
 classes
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
References: <20191021093456.6168-1-david@redhat.com>
 <96381cf8-a6cf-9583-7eb2-92ad9d333c1b@redhat.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <e8ef32ee-de10-0015-6a45-de3d5bba4ff8@redhat.com>
Date: Mon, 21 Oct 2019 11:54:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <96381cf8-a6cf-9583-7eb2-92ad9d333c1b@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: JuonsR8tMiyKNKxgOJHdzA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Janosch Frank <frankja@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
 Igor Mammedov <imammedo@redhat.com>, Jiri Denemark <jdenemar@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 21.10.19 11:52, Thomas Huth wrote:
> On 21/10/2019 11.34, David Hildenbrand wrote:
>> We have to set the default model of all machine classes, not just for
>> the active one. Otherwise, "query-machines" will indicate the wrong
>> CPU model ("qemu-s390x-cpu" instead of "host-s390x-cpu") as
>> "default-cpu-type".
>>
>> Doing a
>>      {"execute":"query-machines"}
>> under KVM now results in
>>      {"return": [
>>          {
>>              "hotpluggable-cpus": true,
>>              "name": "s390-ccw-virtio-4.0",
>>              "numa-mem-supported": false,
>>              "default-cpu-type": "host-s390x-cpu",
>>              "cpu-max": 248,
>>              "deprecated": false},
>>          {
>>              "hotpluggable-cpus": true,
>>              "name": "s390-ccw-virtio-2.7",
>>              "numa-mem-supported": false,
>>              "default-cpu-type": "host-s390x-cpu",
>>              "cpu-max": 248,
>>              "deprecated": false
>>          } ...
>>
>> Reported-by: Jiri Denemark <jdenemar@redhat.com>
>> Fixes: b6805e127c6b ("s390x: use generic cpu_model parsing")
>> Cc: Igor Mammedov <imammedo@redhat.com>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
>> ---
>>   target/s390x/kvm.c | 10 ++++++++--
>>   1 file changed, 8 insertions(+), 2 deletions(-)
>>
>> diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
>> index c24c869e77..5966ab0d37 100644
>> --- a/target/s390x/kvm.c
>> +++ b/target/s390x/kvm.c
>> @@ -320,11 +320,17 @@ void kvm_s390_set_max_pagesize(uint64_t pagesize, =
Error **errp)
>>       cap_hpage_1m =3D 1;
>>   }
>>  =20
>> -int kvm_arch_init(MachineState *ms, KVMState *s)
>> +static void ccw_machine_class_foreach(ObjectClass *klass, void *opaque)
>>   {
>> -    MachineClass *mc =3D MACHINE_GET_CLASS(ms);
>> +    MachineClass *mc =3D MACHINE_CLASS(klass);
>=20
> I think we rather wanted to avoid using "klass" in new code... maybe use
> "oc" instead of "klass" ?

Can do, this was a copy and paste :)

>=20
>>       mc->default_cpu_type =3D S390_CPU_TYPE_NAME("host");
>> +}
>> +
>> +int kvm_arch_init(MachineState *ms, KVMState *s)
>> +{
>> +    object_class_foreach(ccw_machine_class_foreach, TYPE_S390_CCW_MACHI=
NE,
>> +                         false, NULL);
>>  =20
>>       if (!kvm_check_extension(kvm_state, KVM_CAP_DEVICE_CTRL)) {
>>           error_report("KVM is missing capability KVM_CAP_DEVICE_CTRL - =
"
>>
>=20
> Weird, if you start an older machine, you still get the "host" CPU
> without your patch, too:
>=20
> echo -e "info qom-tree \n quit" | \
>   qemu-system-s390x -display none -monitor stdio -no-shutdown \
>     -accel kvm -M s390-ccw-virtio-3.0 | grep s390x-cpu
>=20
> Results in:
>=20
>      /device[0] (host-s390x-cpu)
>=20
> ... so I wonder why that differs from the "query-machines" command?

query-machines probes with the "none" machine all other machines.=20
Current code only fixes up the active machine.

(that's why you won't notice when starting a machine - you will always=20
get "host" for the active one)

>=20
> Anyway, your patch sounds fine, so (with "klass" replaced by "oc"):
>=20
> Reviewed-by: Thomas Huth <thuth@redhat.com>
>=20


--=20

Thanks,

David / dhildenb


