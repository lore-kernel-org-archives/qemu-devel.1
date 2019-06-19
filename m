Return-Path: <SRS0=PARU=US=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0303FC43613
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2019 20:51:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA9172080C
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2019 20:51:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="jK5HXuB8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA9172080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41946 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdhYL-0001Ka-Gj
	for qemu-devel@archiver.kernel.org; Wed, 19 Jun 2019 16:51:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45212)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <maran.wilson@oracle.com>) id 1hdhXT-0000vN-5i
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 16:50:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <maran.wilson@oracle.com>) id 1hdhXR-0004yN-RV
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 16:50:39 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:44102)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <maran.wilson@oracle.com>)
 id 1hdhXR-0004wY-IA
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 16:50:37 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5JKnfPM049856;
 Wed, 19 Jun 2019 20:50:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=HpbFU3Fg71oAhWBsVHsm31dRVVdyYsHIxPUVSzfOZVg=;
 b=jK5HXuB87oL5BcRvaiZO1HCNmI7SNLWVaJXOrgn24Ajp5MEBJ83jvp3Tt9HeWtcBt286
 CctZuKb4QZvaPgctpWFMcTNymjEyvp3Up4okRa7jmdOAnTZtudKduK2EYMlN33STA2Qa
 GR7ItYf7o/xf28cA0+nnpRGK9s/bftaABm3IouksqkOgw0EnRGGEXCCdF7cFz2KN4FMn
 yTJ80bGznBMz/sszvZs4c4HrXNS57ODaOyDIZHfim6LeN6ysJ8cP5s2fEwRxHgbLYgNi
 s/jpiuonBlMVEFPQVqAt1UpbEATEv1eS3ZBscYMhuGUCSpJOgMgKVYphPOHJItLgIWqV Jg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by aserp2120.oracle.com with ESMTP id 2t7809dk2v-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 19 Jun 2019 20:50:33 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5JKlFdq092829;
 Wed, 19 Jun 2019 20:48:32 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
 by aserp3030.oracle.com with ESMTP id 2t7rdwup7r-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 19 Jun 2019 20:48:32 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
 by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x5JKmVIV000740;
 Wed, 19 Jun 2019 20:48:31 GMT
Received: from [10.141.197.71] (/10.141.197.71)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Wed, 19 Jun 2019 13:48:31 -0700
To: Liran Alon <liran.alon@oracle.com>
References: <20190619162140.133674-1-liran.alon@oracle.com>
 <20190619162140.133674-2-liran.alon@oracle.com>
 <d7cf4dd5-13ca-9ba1-2424-25d0d2de8c58@oracle.com>
 <A469CD35-A0D9-4FB3-B9B5-3D3B97B32063@oracle.com>
From: Maran Wilson <maran.wilson@oracle.com>
Organization: Oracle Corporation
Message-ID: <f1966924-eb54-95a9-847c-a5b6aafe0caf@oracle.com>
Date: Wed, 19 Jun 2019 13:48:28 -0700
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <A469CD35-A0D9-4FB3-B9B5-3D3B97B32063@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9293
 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906190170
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9293
 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906190171
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by aserp2120.oracle.com id
 x5JKnfPM049856
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 141.146.126.78
Subject: Re: [Qemu-devel] [QEMU PATCH v4 01/10] target/i386: kvm: Delete VMX
 migration blocker on vCPU init failure
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
Cc: ehabkost@redhat.com, kvm@vger.kernel.org, mtosatti@redhat.com,
 qemu-devel@nongnu.org, dgilbert@redhat.com, pbonzini@redhat.com,
 rth@twiddle.net, jmattson@google.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/19/2019 1:33 PM, Liran Alon wrote:
>> On 19 Jun 2019, at 23:30, Maran Wilson <maran.wilson@oracle.com> wrote=
:
>>
>> On 6/19/2019 9:21 AM, Liran Alon wrote:
>>> Commit d98f26073beb ("target/i386: kvm: add VMX migration blocker")
>>> added migration blocker for vCPU exposed with Intel VMX because QEMU
>>> doesn't yet contain code to support migration of nested virtualizatio=
n
>>> workloads.
>>>
>>> However, that commit missed adding deletion of the migration blocker =
in
>>> case init of vCPU failed. Similar to invtsc_mig_blocker. This commit =
fix
>>> that issue.
>>>
>>> Fixes: d98f26073beb ("target/i386: kvm: add VMX migration blocker")
>>> Signed-off-by: Liran Alon <liran.alon@oracle.com>
>>> ---
>>>   target/i386/kvm.c | 7 +++++--
>>>   1 file changed, 5 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/target/i386/kvm.c b/target/i386/kvm.c
>>> index 3b29ce5c0d08..7aa7914a498c 100644
>>> --- a/target/i386/kvm.c
>>> +++ b/target/i386/kvm.c
>>> @@ -940,7 +940,7 @@ int kvm_arch_init_vcpu(CPUState *cs)
>>>         r =3D kvm_arch_set_tsc_khz(cs);
>>>       if (r < 0) {
>>> -        goto fail;
>>> +        return r;
>>>       }
>>>         /* vcpu's TSC frequency is either specified by user, or follo=
wing
>>> @@ -1295,7 +1295,7 @@ int kvm_arch_init_vcpu(CPUState *cs)
>>>               if (local_err) {
>>>                   error_report_err(local_err);
>>>                   error_free(invtsc_mig_blocker);
>>> -                return r;
>>> +                goto fail2;
>>>               }
>>>           }
>>>       }
>>> @@ -1346,6 +1346,9 @@ int kvm_arch_init_vcpu(CPUState *cs)
>>>      fail:
>>>       migrate_del_blocker(invtsc_mig_blocker);
>>> + fail2:
>>> +    migrate_del_blocker(vmx_mig_blocker);
>>> +
>> At the risk of being a bit pedantic...
>>
>> Your changes don't introduce this problem, but they do make it worse -=
- Since [vmx|invtsc]_mig_blocker are both global in scope, isn't it possi=
ble you end up deleting one or both valid blockers that were created by a=
 previous invocation of kvm_arch_init_vcpu() ?  Seems to me that you woul=
d need something like an additional pair of local boolean variables named=
 created_[vmx|invtsc]_mig_blocker and condition the calls to migrate_del_=
blocker() accordingly. On the positive side, that would simplify some of =
the logic around when and if it's ok to jump to "fail" (and you wouldn't =
need the "fail2").
>>
>> Thanks,
>> -Maran
> I actually thought about this as-well when I encountered this issue.
> In general one can argue that every vCPU should introduce it=E2=80=99s =
own migration blocker on init (if required) and remove it=E2=80=99s own m=
igration blocker on deletion (on vCPU destroy).
> On 99% of the time, all of this shouldn=E2=80=99t matter as all vCPUs o=
f a given VM have exactly the same properties.

The example I was thinking about is a VM that is created with a bunch of=20
vCPUs -- all of which require installation of the blocker(s). Then at=20
some point in the future, a failed CPU hotplug attempt wipes out all the=20
pre-existing blockers and leaves the VM exposed.

But I agree that the problem wasn't introduced by this patch series and=20
so it is reasonable to argue that you shouldn't have to fix it here. As=20
such:

Reviewed-by: Maran Wilson <maran.wilson@oracle.com>

Thanks,
-Maran

> Anyway, I decided that this is entirely not relevant for this patch-ser=
ies and therefore if this should be addressed further, let it be another =
unrelated patch-series.
> QEMU have too many issues to fix all at once :P. I need to filter.
>
> -Liran
>
>>>       return r;
>>>   }
>>>  =20
>


