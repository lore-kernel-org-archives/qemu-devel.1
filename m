Received: from eggs.gnu.org ([2001:4830:134:3::10]:33101)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alexander.boettcher@genode-labs.com>)
	id 1ceM5v-0005js-Bh
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 08:27:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alexander.boettcher@genode-labs.com>)
	id 1ceM5s-0005ah-8r
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 08:27:35 -0500
Received: from mail.genode-labs.com ([88.198.56.169]:53770)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alexander.boettcher@genode-labs.com>)
	id 1ceM5s-0005aQ-2E
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 08:27:32 -0500
References: <efb89578-ba8c-1f42-0ec3-79f769b3f1f1@genode-labs.com>
	<1266688981.22789860.1487246005187.JavaMail.zimbra@redhat.com>
	<f40048d0-23bc-a4c7-8b18-00d6d3fd04b5@genode-labs.com>
	<ae235b6f-3e43-c132-c2ff-fd220c8c9dde@redhat.com>
From: Alexander Boettcher <alexander.boettcher@genode-labs.com>
Message-ID: <d5d84caf-3669-7be7-29ac-85d3e3ea8621@genode-labs.com>
Date: Thu, 16 Feb 2017 14:27:30 +0100
MIME-Version: 1.0
In-Reply-To: <ae235b6f-3e43-c132-c2ff-fd220c8c9dde@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] x86 tlb_fill in memory_helper.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: rth@twiddle.net, qemu-devel@nongnu.org, ehabkost@redhat.com

On 16.02.2017 13:57, Paolo Bonzini wrote:
>=20
>=20
> On 16/02/2017 13:57, Alexander Boettcher wrote:
>> Hello Paolo,
>>
>> On 16.02.2017 12:53, Paolo Bonzini wrote:
>>> As you noticed, the problem is that now cpu_vmexit is called without =
a
>>> cpu_restore_state before.
>>>
>>> The right fix is to pass the retaddr to cpu_vmexit (via
>>> cpu_svm_check_intercept_param); something like this untested patch:
>>
>> ...
>>
>>>
>>> If it works for you we can include it.
>>
>> thank you for the quick patch. It works like a charm.
>>
>> Do you take care of adding the patch, please ? (I can of course also d=
o.)
>=20
> Great, I will look at it.  Have you debugged the exact failure mode to
> include something in the commit message?

I'm not familiar with the SVM model, but what I did was to

compare mainly the output of the svm exceptions on Qemu 2.4.1 and
2.5.0++ as reported by the Nova hypervisor runing in Qemu.

There one gets mysterious SVM exception 0x4e (PF), where

virtaddr =3D cr2 =3D VMCB::exitinfo2

cr2 is around the 0 address - where actually is nothing in the guest VM.

Later on one gets a SVM exception of 0x7f, and then your VM is gone.

Hope it helps to make up a useful commit message,

Alex.

--=20
Alexander Boettcher
Genode Labs

http://www.genode-labs.com - http://www.genode.org

Genode Labs GmbH - Amtsgericht Dresden - HRB 28424 - Sitz Dresden
Gesch=C3=A4ftsf=C3=BChrer: Dr.-Ing. Norman Feske, Christian Helmuth
