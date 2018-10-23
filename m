Received: from eggs.gnu.org ([2001:4830:134:3::10]:59587)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <george.kennedy@oracle.com>) id 1gF4zp-0001Xh-Mf
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 18:17:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <george.kennedy@oracle.com>) id 1gF4u7-00063n-UN
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 18:12:05 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:48046)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <george.kennedy@oracle.com>)
	id 1gF4ty-0005oG-Ji
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 18:11:54 -0400
References: <1540243704-17090-1-git-send-email-george.kennedy@oracle.com>
	<596ea83a-279e-3a76-ead3-14aa8efe0a1d@redhat.com>
	<43e65c7a-f44d-797b-ab0c-389eaa0c0f82@oracle.com>
	<0e52d605-871e-cdac-c1ae-b0da912611ba@redhat.com>
From: George Kennedy <george.kennedy@oracle.com>
Message-ID: <adc9e69a-487b-44a6-7029-bff65f25801b@oracle.com>
Date: Tue, 23 Oct 2018 18:11:38 -0400
MIME-Version: 1.0
In-Reply-To: <0e52d605-871e-cdac-c1ae-b0da912611ba@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2] lsi: Reselection needed to remove
 pending commands from queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org



On 10/23/2018 5:50 PM, Paolo Bonzini wrote:
> On 23/10/2018 23:36, George Kennedy wrote:
>>
>> On 10/23/2018 10:33 AM, Paolo Bonzini wrote:
>>> On 22/10/2018 23:28, George Kennedy wrote:
>>>> As you suggested I moved the loading of "s->resel_dsp" down to the
>>>> "Wait Reselect"
>>>> case. The address of the Reselection Scripts, though, is contained i=
n
>>>> "s->dsp - 8"
>>>> and not in s->dnad.
>>> Are you sure?=C2=A0 s->dsp - 8 should be the address of the Wait Rese=
lect
>>> instruction itself.=C2=A0 But you're right that s->dnad is the addres=
s at
>>> which to jump "if the LSI53C895A is selected before being reselected"
>>> (as the spec puts it) so the reselection DSP should be just s->dsp.
>> See within the 1st 25 lines of lsi_execute_script() where dsp is bumpe=
d
>> up by 8, "s->dsp +=3D 8", so it needs to be adjusted back to what it w=
as.
> The spec says "If the LSI53C895A is reselected, it fetches the next
> instruction from the address pointed to by the DMA
> SCRIPTS Pointer (DSP) register".  The first instruction of the
> reselection scripts is the one after WAIT RESELECT, i.e. s->dsp.
>
>
>>> Reselection should only happen when the target needs access to the bu=
s,
>>> which is when I/O has finished.=C2=A0 There should be no need for suc=
h a
>>> deadline; reselection should already be happening at the right time w=
hen
>>> lsi_transfer_data calls lsi_queue_req, which in turn calls lsi_resele=
ct.
>> Agree that it should happen as you describe, but under heavy IO (fio),
>> it does not.
>>
>> When it works as expected the check for "s->waiting =3D=3D 1" (Wait Re=
select
>> instruction has been issued) in lsi_transfer_data() is true. Under hea=
vy
>> IO, s->waiting is not "1" for an extended period of time
> What about "req->hba_private !=3D s->current"?  That should cause a cal=
l
> to lsi_queue_req, and then you can check s->want_resel in lsi_queue_req.

For the extended period of time where lsi_queue_req() is not being=20
called from lsi_transfer_data(), my debug shows "s->waiting" is not "1"=20
and req->hba_private is equal to s->current.

req->hba_private is set to NULL in lsi_command_complete() and that's=20
where I tried to add a call to lsi_reselect(), but the Scripts are not=20
in the correct state to allow the call.

lsi_transfer_data() or lsi_command_complete() are probably the 2=20
potential places where a fix could be added if the Script state would=20
allow it.
>
>> I am not strongly attached to my proposed fix. If an alternative fix c=
an
>> be suggested, I'd be more than willing to try that.
> The problem is that the timeout has no explanation under the SCSI
> protocol, so I would like to understand where the logic is wrong in the
> Parallel SCSI emulation.

Agreed. That's why I'm hoping for an alternate fix.

Thank you,
George
>
> Paolo
