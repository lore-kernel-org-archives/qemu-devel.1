Received: from eggs.gnu.org ([2001:4830:134:3::10]:40772)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1cUaDW-0003Q3-Oj
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 09:31:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1cUaDS-00059K-R1
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 09:31:02 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41584)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1cUaDS-00058h-LG
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 09:30:58 -0500
References: <20170117010204.4909-1-ehabkost@redhat.com>
	<309bd499-204d-df07-aa99-9a999cfecabc@linux.vnet.ibm.com>
	<20170118170049.GB3491@thinpad.lan.raisama.net>
	<45e82b29-1ebe-3f34-0cc1-35d60c6044da@linux.vnet.ibm.com>
	<20170118173406.GF3491@thinpad.lan.raisama.net>
	<fd9074e6-8b39-9139-415e-cec2a8970a5e@redhat.com>
	<20170119104837.GL3491@thinpad.lan.raisama.net>
	<c0d8a827-5999-51b5-73fc-aa781b77fe8f@redhat.com>
	<20170119174559.GI16641@redhat.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <c682e80b-23e5-544e-c78e-c633b7d6259f@redhat.com>
Date: Fri, 20 Jan 2017 15:30:54 +0100
MIME-Version: 1.0
In-Reply-To: <20170119174559.GI16641@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [libvirt] [PATCH 0/9] i386:
 query-cpu-model-expansion test script
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>, libvir-list@redhat.com, qemu-devel@nongnu.org, Christian Borntraeger <borntraeger@de.ibm.com>, "Collin L. Walling" <walling@linux.vnet.ibm.com>, "Jason J. Herne" <jjherne@linux.vnet.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Igor Mammedov <imammedo@redhat.com>, Jiri Denemark <jdenemar@redhat.com>, Richard Henderson <rth@twiddle.net>

Am 19.01.2017 um 18:45 schrieb Daniel P. Berrange:
> On Thu, Jan 19, 2017 at 06:21:22PM +0100, David Hildenbrand wrote:
>>
>>>> Also think about "query-cpu-model-expansion model=host type=static",
>>>> which will primarily be used by libvirt on s390x. There is no way to
>>>> expand this into a static cpu model. Faking anything will just hide errors.
>>>
>>> Yes, static expansion of host model must always return an error
>>> if it's not possible to expand.
>>>
>>>>
>>>> If "host" can't be expanded, QEMU has to be treated like there is no CPU
>>>> model support (as for older QEMU versions).
>>>
>>> OK. I will propose a patch updating the query-cpu-model-expansion
>>> documentation to be more explicit about it.
>>
>> The only real alternative I see would be disabling the query-cpu-model-*
>> interface completely if KVM support is not available.
>>
>> This would however mean, that the same QEMU binary would have the
>> interface when running under TCG, but not when running under KVM on an
>> old KVM version.
>>
>> That also doesn't really feel right, or what do you think?
> 
> Yeah that really isn't good.  query-cpu-model-* needs to work on TCG
> and *not* have a dependancy on KVM in that case, since you can be
> running TCG s390 on a x86_64 host, so the host CPU is totally irrelevant
> for TCG
> 

Actually what I meant was:

TCG: query-cpu-model-* interface always provided
KVM (with cpu model support): query-cpu-model-* interface provided
KVM (without cpu model support): no query-cpu-model-* interface provided

This would avoid having to report an error when expanding "host" in the
third case (KVM without cpu model support) but would lead to one QEMU
binary having a different set of supported qmp calls when called from
TCG and KVM.

> Regards,
> Daniel
> 


-- 

David
