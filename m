Received: from eggs.gnu.org ([2001:4830:134:3::10]:43993)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jmattson@google.com>) id 1gIcpG-0002d9-Mp
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 13:01:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jmattson@google.com>) id 1gIcp7-0000aC-9U
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 13:01:34 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:37365)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jmattson@google.com>) id 1gIcp1-0000Vq-84
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 13:01:25 -0400
Received: by mail-oi1-x243.google.com with SMTP id w66-v6so2141793oiw.4
	for <qemu-devel@nongnu.org>; Fri, 02 Nov 2018 10:01:21 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20181102165807.GG21191@redhat.com>
References: <CALMp9eQ5zWxb2N9fyYz=WcQshwk0L6qQ4D6L6+p_dzMo4H=txA@mail.gmail.com>
	<20181102034649.43559-1-liran.alon@oracle.com>
	<12c26c34-8dd1-a442-7826-86b93ff978f8@redhat.com>
	<95850543-FE41-404F-9775-23E792F6428E@oracle.com>
	<CALMp9eSSe2ZBQrAsyLDfOSiWydXhphcj6xe0x1yZ8Dg_yXnpUQ@mail.gmail.com>
	<20181102165807.GG21191@redhat.com>
From: Jim Mattson <jmattson@google.com>
Date: Fri, 2 Nov 2018 10:01:19 -0700
Message-ID: <CALMp9eRw-0JCpwfEGU6ximLMSNfgKsvBEfKpLOq_MGgTq+81Rw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [QEMU PATCH v2 0/2]: KVM: i386: Add support for
 save and restore nested state
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Liran Alon <liran.alon@oracle.com>, Eduardo Habkost <ehabkost@redhat.com>, kvm list <kvm@vger.kernel.org>, mtosatti@redhat.com, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, rth@twiddle.net

On Fri, Nov 2, 2018 at 9:58 AM, Daniel P. Berrang=C3=A9 <berrange@redhat.co=
m> wrote:
> On Fri, Nov 02, 2018 at 09:44:54AM -0700, Jim Mattson via Qemu-devel wrot=
e:
>> On Fri, Nov 2, 2018 at 5:59 AM, Liran Alon <liran.alon@oracle.com> wrote=
:
>> >
>>
>> >>> Therefore, I don't think that we want this versioning to be based on=
 KVM_CAP at all.
>> >>> It seems that we would want the process to behave as follows:
>> >>> 1) Mgmt-layer at dest queries dest host max supported nested_state s=
ize.
>> >>>   (Which should be returned from kvm_check_extension(KVM_CAP_NESTED_=
STATE))
>> >>> 2) Mgmt-layer at source initiate migration to dest with requesting Q=
EMU to send nested_state
>> >>>   matching dest max supported nested_state size.
>> >>>   When saving nested state using KVM_GET_NESTED_STATE IOCTL, QEMU wi=
ll specify in nested_state->size
>> >>>   the *requested* size to be saved and KVM should be able to save on=
ly the information which matches
>> >>>   the version that worked with that size.
>> >>> 3) After some sanity checks on received migration stream, dest host =
use KVM_SET_NESTED_STATE IOCTL.
>> >>>   This IOCTL should deduce which information it should deploy based =
on given nested_state->size.
>>
>> I have to object to any proposal which requires the management later
>> to communicate with the source and the destination to determine what
>> should be done.
>
> Can you elaborate on why you object ?

We don't currently have this requirement, and I don't want to be
encumbered by it.
