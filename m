Return-Path: <SRS0=xVqP=Z2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9F47C43603
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2019 12:34:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF44C20833
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2019 12:34:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF44C20833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37898 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1icTqz-00048J-LK
	for qemu-devel@archiver.kernel.org; Wed, 04 Dec 2019 07:34:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37553)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <frankja@linux.ibm.com>) id 1icSte-0004JL-1K
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 06:32:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <frankja@linux.ibm.com>) id 1icSta-0001YG-Ta
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 06:32:40 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:32660)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <frankja@linux.ibm.com>)
 id 1icStY-0001JH-Uf
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 06:32:37 -0500
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 xB4BVrbI190057
 for <qemu-devel@nongnu.org>; Wed, 4 Dec 2019 06:32:34 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2wkm491tdn-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 04 Dec 2019 06:32:33 -0500
Received: from localhost
 by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <frankja@linux.ibm.com>;
 Wed, 4 Dec 2019 11:32:31 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
 by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Wed, 4 Dec 2019 11:32:30 -0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
 by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 xB4BWSTm58261660
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 4 Dec 2019 11:32:28 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id ADAD442047;
 Wed,  4 Dec 2019 11:32:28 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 621794203F;
 Wed,  4 Dec 2019 11:32:28 +0000 (GMT)
Received: from dyn-9-152-224-146.boeblingen.de.ibm.com (unknown
 [9.152.224.146])
 by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Wed,  4 Dec 2019 11:32:28 +0000 (GMT)
Subject: Re: [PATCH v2 03/13] s390x: protvirt: Support unpack facility
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
References: <20191129094809.26684-1-frankja@linux.ibm.com>
 <20191129094809.26684-4-frankja@linux.ibm.com>
 <3f891828-f7d1-91a4-08de-71ac2ed00ad1@redhat.com>
From: Janosch Frank <frankja@linux.ibm.com>
Autocrypt: addr=frankja@linux.ibm.com; prefer-encrypt=mutual; keydata=
 mQINBFubpD4BEADX0uhkRhkj2AVn7kI4IuPY3A8xKat0ihuPDXbynUC77mNox7yvK3X5QBO6
 qLqYr+qrG3buymJJRD9xkp4mqgasHdB5WR9MhXWKH08EvtvAMkEJLnqxgbqf8td3pCQ2cEpv
 15mH49iKSmlTcJ+PvJpGZcq/jE42u9/0YFHhozm8GfQdb9SOI/wBSsOqcXcLTUeAvbdqSBZe
 zuMRBivJQQI1esD9HuADmxdE7c4AeMlap9MvxvUtWk4ZJ/1Z3swMVCGzZb2Xg/9jZpLsyQzb
 lDbbTlEeyBACeED7DYLZI3d0SFKeJZ1SUyMmSOcr9zeSh4S4h4w8xgDDGmeDVygBQZa1HaoL
 Esb8Y4avOYIgYDhgkCh0nol7XQ5i/yKLtnNThubAcxNyryw1xSstnKlxPRoxtqTsxMAiSekk
 0m3WJwvwd1s878HrQNK0orWd8BzzlSswzjNfQYLF466JOjHPWFOok9pzRs+ucrs6MUwDJj0S
 cITWU9Rxb04XyigY4XmZ8dywaxwi2ZVTEg+MD+sPmRrTw+5F+sU83cUstuymF3w1GmyofgsU
 Z+/ldjToHnq21MNa1wx0lCEipCCyE/8K9B9bg9pUwy5lfx7yORP3JuAUfCYb8DVSHWBPHKNj
 HTOLb2g2UT65AjZEQE95U2AY9iYm5usMqaWD39pAHfhC09/7NQARAQABtCVKYW5vc2NoIEZy
 YW5rIDxmcmFua2phQGxpbnV4LmlibS5jb20+iQI3BBMBCAAhBQJbm6Q+AhsjBQsJCAcCBhUI
 CQoLAgQWAgMBAh4BAheAAAoJEONU5rjiOLn4p9gQALjkdj5euJVI2nNT3/IAxAhQSmRhPEt0
 AmnCYnuTcHRWPujNr5kqgtyER9+EMQ0ZkX44JU2q7OWxTdSNSAN/5Z7qmOR9JySvDOf4d3mS
 bMB5zxL9d8SbnSs1uW96H9ZBTlTQnmLfsiM9TetAjSrR8nUmjGhe2YUhJLR1v1LguME+YseT
 eXnLzIzqqpu311/eYiiIGcmaOjPCE+vFjcXL5oLnGUE73qSYiujwhfPCCUK0850o1fUAYq5p
 CNBCoKT4OddZR+0itKc/cT6NwEDwdokeg0+rAhxb4Rv5oFO70lziBplEjOxu3dqgIKbHbjza
 EXTb+mr7VI9O4tTdqrwJo2q9zLqqOfDBi7NDvZFLzaCewhbdEpDYVu6/WxprAY94hY3F4trT
 rQMHJKQENtF6ZTQc9fcT5I3gAmP+OEvDE5hcTALpWm6Z6SzxO7gEYCnF+qGXqp8sJVrweMub
 UscyLqHoqdZC2UG4LQ1OJ97nzDpIRe0g6oJ9ZIYHKmfw5jjwH6rASTld5MFWajWdNsqK15k/
 RZnHAGICKVIBOBsq26m4EsBlfCdt3b/6emuBjUXR1pyjHMz2awWzCq6/6OWs5eANZ0sdosNq
 dq2v0ULYTazJz2rlCXV89qRa7ukkNwdBSZNEwsD4eEMicj1LSrqWDZMAALw50L4jxaMD7lPL
 jJbauQINBFubpD4BEADAcUTRqXF/aY53OSH7IwIK9lFKxIm0IoFkOEh7LMfp7FGzaP7ANrZd
 cIzhZi38xyOkcaFY+npGEWvko7rlIAn0JpBO4x3hfhmhBD/WSY8LQIFQNNjEm3vzrMo7b9Jb
 JAqQxfbURY3Dql3GUzeWTG9uaJ00u+EEPlY8zcVShDltIl5PLih20e8xgTnNzx5c110lQSu0
 iZv2lAE6DM+2bJQTsMSYiwKlwTuv9LI9Chnoo6+tsN55NqyMxYqJgElk3VzlTXSr3+rtSCwf
 tq2cinETbzxc1XuhIX6pu/aCGnNfuEkM34b7G1D6CPzDMqokNFbyoO6DQ1+fW6c5gctXg/lZ
 602iEl4C4rgcr3+EpfoPUWzKeM8JXv5Kpq4YDxhvbitr8Dm8gr38+UKFZKlWLlwhQ56r/zAU
 v6LIsm11GmFs2/cmgD1bqBTNHHcTWwWtRTLgmnqJbVisMJuYJt4KNPqphTWsPY8SEtbufIlY
 HXOJ2lqUzOReTrie2u0qcSvGAbSfec9apTFl2Xko/ddqPcZMpKhBiXmY8tJzSPk3+G4tqur4
 6TYAm5ouitJsgAR61Cu7s+PNuq/pTLDhK+6/Njmc94NGBcRA4qTuysEGE79vYWP2oIAU4Fv6
 gqaWHZ4MEI2XTqH8wiwzPdCQPYsSE0fXWiYu7ObeErT6iLSTZGx4rQARAQABiQIfBBgBCAAJ
 BQJbm6Q+AhsMAAoJEONU5rjiOLn4DDEP/RuyckW65SZcPG4cMfNgWxZF8rVjeVl/9PBfy01K
 8R0hajU40bWtXSMiby7j0/dMjz99jN6L+AJHJvrLz4qYRzn2Ys843W+RfXj62Zde4YNBE5SL
 jJweRCbMWKaJLj6499fctxTyeb9+AMLQS4yRSwHuAZLmAb5AyCW1gBcTWZb8ON5BmWnRqeGm
 IgC1EvCnHy++aBnHTn0m+zV89BhTLTUal35tcjUFwluBY39R2ux/HNlBO1GY3Z+WYXhBvq7q
 katThLjaQSmnOrMhzqYmdShP1leFTVbzXUUIYv/GbynO/YrL2gaQpaP1bEUEi8lUAfXJbEWG
 dnHFkciryi092E8/9j89DJg4mmZqOau7TtUxjRMlBcIliXkzSLUk+QvD4LK1kWievJse4mte
 FBdkWHfP4BH/+8DxapRcG1UAheSnSRQ5LiO50annOB7oXF+vgKIaie2TBfZxQNGAs3RQ+bga
 DchCqFm5adiSP5+OT4NjkKUeGpBe/aRyQSle/RropTgCi85pje/juYEn2P9UAgkfBJrOHvQ9
 Z+2Sva8FRd61NJLkCJ4LFumRn9wQlX2icFbi8UDV3do0hXJRRYTWCxrHscMhkrFWLhYiPF4i
 phX7UNdOWBQ90qpHyAxHmDazdo27gEjfvsgYMdveKknEOTEb5phwxWgg7BcIDoJf9UMC
Date: Wed, 4 Dec 2019 12:32:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <3f891828-f7d1-91a4-08de-71ac2ed00ad1@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="nbuhs3saqINEX7xNApv5rV5AsxygYwgMU"
X-TM-AS-GCONF: 00
x-cbid: 19120411-0028-0000-0000-000003C4AAE9
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19120411-0029-0000-0000-00002487C8D9
Message-Id: <a58e50cf-ebbe-fc83-6405-592617e05d1e@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-04_03:2019-12-04,2019-12-04 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0
 spamscore=0 priorityscore=1501 lowpriorityscore=0 clxscore=1015
 impostorscore=0 adultscore=0 suspectscore=3 mlxlogscore=999 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912040092
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 148.163.158.5
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
Cc: pmorel@linux.ibm.com, david@redhat.com, cohuck@redhat.com,
 borntraeger@de.ibm.com, qemu-s390x@nongnu.org, mihajlov@linux.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--nbuhs3saqINEX7xNApv5rV5AsxygYwgMU
Content-Type: multipart/mixed; boundary="GtM5qLXM81TwJ1u1PJPlYmPFya9bPcM5g"

--GtM5qLXM81TwJ1u1PJPlYmPFya9bPcM5g
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 12/4/19 11:48 AM, Thomas Huth wrote:
> On 29/11/2019 10.47, Janosch Frank wrote:
>> When a guest has saved a ipib of type 5 and call diagnose308 with
>> subcode 10, we have to setup the protected processing environment via
>> Ultravisor calls. The calls are done by KVM and are exposed via an API=
=2E
>>
>> The following steps are necessary:
>> 1. Create a VM (register it with the Ultravisor)
>> 2. Create secure CPUs for all of our current cpus
>> 3. Forward the secure header to the Ultravisor (has all information on=

>> how to decrypt the image and VM information)
>> 4. Protect image pages from the host and decrypt them
>> 5. Verify the image integrity
>>
>> Only after step 5 a protected VM is allowed to run.
>>
>> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
>> ---
> [...]
>> +++ b/hw/s390x/pv.c
>> @@ -0,0 +1,118 @@
>> +/*
>> + * Secure execution functions
>> + *
>> + * Copyright IBM Corp. 2019
>> + * Author(s):
>> + *  Janosch Frank <frankja@linux.ibm.com>
>> + *
>> + * This work is licensed under the terms of the GNU GPL, version 2 or=
 (at
>> + * your option) any later version. See the COPYING file in the top-le=
vel
>> + * directory.
>> + */
>> +#include "qemu/osdep.h"
>> +#include <sys/ioctl.h>
>> +
>> +#include <linux/kvm.h>
>> +
>> +#include "qemu/error-report.h"
>> +#include "sysemu/kvm.h"
>> +#include "pv.h"
>> +
>> +static int s390_pv_cmd(uint32_t cmd, void *data)
>> +{
>> +    int rc;
>> +    struct kvm_pv_cmd pv_cmd =3D {
>> +        .cmd =3D cmd,
>> +        .data =3D (uint64_t)data,
>> +    };
>> +
>> +    rc =3D kvm_vm_ioctl(kvm_state, KVM_S390_PV_COMMAND, &pv_cmd);
>> +    if (rc) {
>> +        error_report("KVM PV command failed cmd: %d rc: %d", cmd, rc)=
;
>> +        exit(1);
>> +    }
>> +    return rc;
>> +}
>> +
>> +static int s390_pv_cmd_vcpu(CPUState *cs, uint32_t cmd, void *data)
>> +{
>> +    int rc;
>> +    struct kvm_pv_cmd pv_cmd =3D {
>> +        .cmd =3D cmd,
>> +        .data =3D (uint64_t)data,
>> +    };
>> +
>> +    rc =3D kvm_vcpu_ioctl(cs, KVM_S390_PV_COMMAND_VCPU, &pv_cmd);
>> +    if (rc) {
>> +        error_report("KVM PV VCPU command failed cmd: %d rc: %d", cmd=
, rc);
>> +        exit(1);
>> +    }
>> +    return rc;
>> +}
>> +
>> +int s390_pv_vm_create(void)
>> +{
>> +    return s390_pv_cmd(KVM_PV_VM_CREATE, NULL);
>> +}
>> +
>> +int s390_pv_vm_destroy(void)
>> +{
>> +    return s390_pv_cmd(KVM_PV_VM_DESTROY, NULL);
>> +}
>> +
>> +int s390_pv_vcpu_create(CPUState *cs)
>> +{
>> +    return s390_pv_cmd_vcpu(cs, KVM_PV_VCPU_CREATE, NULL);
>> +}
>> +
>> +int s390_pv_vcpu_destroy(CPUState *cs)
>> +{
>> +    S390CPU *cpu =3D S390_CPU(cs);
>> +    CPUS390XState *env =3D &cpu->env;
>> +    int rc;
>> +
>> +    rc =3D s390_pv_cmd_vcpu(cs, KVM_PV_VCPU_DESTROY, NULL);
>> +    if (!rc) {
>> +        env->pv =3D false;
>> +    }
>> +    return rc;
>> +}
>> +
>> +int s390_pv_set_sec_parms(uint64_t origin, uint64_t length)
>> +{
>> +    struct kvm_s390_pv_sec_parm args =3D {
>> +        .origin =3D origin,
>> +        .length =3D length,
>> +    };
>> +
>> +    return s390_pv_cmd(KVM_PV_VM_SET_SEC_PARMS, &args);
>> +}
>> +
>> +/*
>> + * Called for each component in the SE type IPL parameter block 0.
>> + */
>> +int s390_pv_unpack(uint64_t addr, uint64_t size, uint64_t tweak)
>> +{
>> +    struct kvm_s390_pv_unp args =3D {
>> +        .addr =3D addr,
>> +        .size =3D size,
>> +        .tweak =3D tweak,
>> +    };
>> +
>> +    return s390_pv_cmd(KVM_PV_VM_UNPACK, &args);
>> +}
>> +
>> +int s390_pv_perf_clear_reset(void)
>> +{
>> +    return s390_pv_cmd(KVM_PV_VM_PERF_CLEAR_RESET, NULL);
>> +}
>> +
>> +int s390_pv_verify(void)
>> +{
>> +    return s390_pv_cmd(KVM_PV_VM_VERIFY, NULL);
>> +}
>> +
>> +int s390_pv_unshare(void)
>> +{
>> +    return s390_pv_cmd(KVM_PV_VM_UNSHARE, NULL);
>> +}
>> diff --git a/hw/s390x/pv.h b/hw/s390x/pv.h
>> new file mode 100644
>> index 0000000000..eb074e4bc9
>> --- /dev/null
>> +++ b/hw/s390x/pv.h
>> @@ -0,0 +1,26 @@
>> +/*
>> + * Protected Virtualization header
>> + *
>> + * Copyright IBM Corp. 2019
>> + * Author(s):
>> + *  Janosch Frank <frankja@linux.ibm.com>
>> + *
>> + * This work is licensed under the terms of the GNU GPL, version 2 or=
 (at
>> + * your option) any later version. See the COPYING file in the top-le=
vel
>> + * directory.
>> + */
>> +
>> +#ifndef HW_S390_PV_H
>> +#define HW_S390_PV_H
>> +
>> +int s390_pv_vm_create(void);
>> +int s390_pv_vm_destroy(void);
>> +int s390_pv_vcpu_destroy(CPUState *cs);
>> +int s390_pv_vcpu_create(CPUState *cs);
>> +int s390_pv_set_sec_parms(uint64_t origin, uint64_t length);
>> +int s390_pv_unpack(uint64_t addr, uint64_t size, uint64_t tweak);
>> +int s390_pv_perf_clear_reset(void);
>> +int s390_pv_verify(void);
>> +int s390_pv_unshare(void);
>=20
> I still think you should make all those functions returning "void"
> instead of "int" - since errors results in an exit() in s390_pv_cmd()
> and s390_pv_cmd_vcpu() anyway...

Hey Thomas,

I have requested an error code for diag 308 subcode 10 that tells the
VM, that we didn't succeed starting a secure guest. Once that is in
place, I'll need to check the return codes.

Although I'm a bit unsure how I should hook that up because of the
diag308/reset handler split.



>=20
>> +
>> +#endif /* HW_S390_PV_H */
>> diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
>> index c1d1440272..f9481ccace 100644
>> --- a/hw/s390x/s390-virtio-ccw.c
>> +++ b/hw/s390x/s390-virtio-ccw.c
>> @@ -41,6 +41,7 @@
>>  #include "hw/qdev-properties.h"
>>  #include "hw/s390x/tod.h"
>>  #include "sysemu/sysemu.h"
>> +#include "hw/s390x/pv.h"
>> =20
>>  S390CPU *s390_cpu_addr2state(uint16_t cpu_addr)
>>  {
>> @@ -322,6 +323,7 @@ static void s390_machine_reset(MachineState *machi=
ne)
>>  {
>>      enum s390_reset reset_type;
>>      CPUState *cs, *t;
>> +    S390CPU *cpu;
>> =20
>>      /* get the reset parameters, reset them once done */
>>      s390_ipl_get_reset_request(&cs, &reset_type);
>> @@ -329,6 +331,8 @@ static void s390_machine_reset(MachineState *machi=
ne)
>>      /* all CPUs are paused and synchronized at this point */
>>      s390_cmma_reset();
>> =20
>> +    cpu =3D S390_CPU(cs);
>> +
>>      switch (reset_type) {
>>      case S390_RESET_EXTERNAL:
>>      case S390_RESET_REIPL:
>> @@ -357,6 +361,28 @@ static void s390_machine_reset(MachineState *mach=
ine)
>>          run_on_cpu(cs, s390_do_cpu_initial_reset, RUN_ON_CPU_NULL);
>>          run_on_cpu(cs, s390_do_cpu_load_normal, RUN_ON_CPU_NULL);
>>          break;
>> +    case S390_RESET_PV: /* Subcode 10 */
>> +        subsystem_reset();
>> +        s390_crypto_reset();
>> +
>> +        CPU_FOREACH(t) {
>> +            run_on_cpu(t, s390_do_cpu_full_reset, RUN_ON_CPU_NULL);
>> +        }
>> +
>> +        /* Create SE VM */
>> +        s390_pv_vm_create();
>> +        CPU_FOREACH(t) {
>> +            s390_pv_vcpu_create(t);
>> +        }
>> +
>> +        /* Set SE header and unpack */
>> +        s390_ipl_prepare_pv_header();
>> +        /* Decrypt image */
>> +        s390_ipl_pv_unpack();
>> +        /* Verify integrity */
>> +        s390_pv_verify();
>> +        s390_cpu_set_state(S390_CPU_STATE_OPERATING, cpu);
>> +        break;
>=20
> ... and here you completely ignore the return codes of all the new
> functions.
>=20
>  Thomas
>=20



--GtM5qLXM81TwJ1u1PJPlYmPFya9bPcM5g--

--nbuhs3saqINEX7xNApv5rV5AsxygYwgMU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEwGNS88vfc9+v45Yq41TmuOI4ufgFAl3nmUwACgkQ41TmuOI4
ufiM2w/9Hlsv61Fk/YCA/wwwkQfjuS99zgsEynjUX/h+bHEltby2rQt1pwzqeEx7
akKKXVMz3DKnNmYg9ODIiUYx0waSyAqoPqGr1QIRSbMZ4rhX157nkcvlGaY6ZT8R
TwNdJdaTemNyQvQFmpOBgICm1pL86RqmvRGAdwZu46lXm4I7a4DkS7Yfhfm9KbI4
1+XbuGH/IVyh66osZfGqVmrsgKT8lo9buTM8akBPvrrxEiDJ6nfpLH8JwNTHDMm1
Xa8v2UmBvzagJh47FCUoVKjCy/2/y89CtSCuT7ZnwA/ho7EkcSyixvJ1jwUXVCgT
BY+WU3gY33b4N8nqmzQ7bUDLqd9IxcyZFZiPyojGExmrVhggxZauIXDXTDEKVt3O
uM+DawfXFRYbU1wR3k62Ln0ltZaVKol/EKsPtLO6foKHN/+tcBGdRLo3lpW5r2OS
sVLtbs/9cfVoX0qiBZy2RFX27MTDBrgQ9x+T7AtQ+TIPGtTuQpzoOPFqKKYM2k2F
68wBlxW24JW30jsvKl+mWUAw1RnDFgs+5bdDImaBqr2TPKtJ84AfHhdNhz0GF1C7
U2SuVwpLV3VGl+LVF1ydWuwtEltT4ox4VCqg6V6OzMJZbTvfSyfZkafgtqGre+vv
pcbqC4as5W+Il/5j4A6NhZdldlKLD5pknLMZuQ623x/1D6CYBXo=
=nt5j
-----END PGP SIGNATURE-----

--nbuhs3saqINEX7xNApv5rV5AsxygYwgMU--


