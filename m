Received: from eggs.gnu.org ([2001:4830:134:3::10]:47734)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gF4f0-0002X3-CQ
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 17:56:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gF4Ze-0001sl-0F
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 17:50:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39040)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gF4Zb-0001pu-QL
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 17:50:48 -0400
References: <1540243704-17090-1-git-send-email-george.kennedy@oracle.com>
	<596ea83a-279e-3a76-ead3-14aa8efe0a1d@redhat.com>
	<43e65c7a-f44d-797b-ab0c-389eaa0c0f82@oracle.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <0e52d605-871e-cdac-c1ae-b0da912611ba@redhat.com>
Date: Tue, 23 Oct 2018 23:50:36 +0200
MIME-Version: 1.0
In-Reply-To: <43e65c7a-f44d-797b-ab0c-389eaa0c0f82@oracle.com>
Content-Type: text/plain; charset=utf-8
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
To: George Kennedy <george.kennedy@oracle.com>, Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org

On 23/10/2018 23:36, George Kennedy wrote:
>=20
>=20
> On 10/23/2018 10:33 AM, Paolo Bonzini wrote:
>> On 22/10/2018 23:28, George Kennedy wrote:
>>> As you suggested I moved the loading of "s->resel_dsp" down to the
>>> "Wait Reselect"
>>> case. The address of the Reselection Scripts, though, is contained in
>>> "s->dsp - 8"
>>> and not in s->dnad.
>> Are you sure?=C2=A0 s->dsp - 8 should be the address of the Wait Resel=
ect
>> instruction itself.=C2=A0 But you're right that s->dnad is the address=
 at
>> which to jump "if the LSI53C895A is selected before being reselected"
>> (as the spec puts it) so the reselection DSP should be just s->dsp.
>=20
> See within the 1st 25 lines of lsi_execute_script() where dsp is bumped
> up by 8, "s->dsp +=3D 8", so it needs to be adjusted back to what it wa=
s.

The spec says "If the LSI53C895A is reselected, it fetches the next
instruction from the address pointed to by the DMA
SCRIPTS Pointer (DSP) register".  The first instruction of the
reselection scripts is the one after WAIT RESELECT, i.e. s->dsp.


>> Reselection should only happen when the target needs access to the bus=
,
>> which is when I/O has finished.=C2=A0 There should be no need for such=
 a
>> deadline; reselection should already be happening at the right time wh=
en
>> lsi_transfer_data calls lsi_queue_req, which in turn calls lsi_reselec=
t.
> Agree that it should happen as you describe, but under heavy IO (fio),
> it does not.
>=20
> When it works as expected the check for "s->waiting =3D=3D 1" (Wait Res=
elect
> instruction has been issued) in lsi_transfer_data() is true. Under heav=
y
> IO, s->waiting is not "1" for an extended period of time

What about "req->hba_private !=3D s->current"?  That should cause a call
to lsi_queue_req, and then you can check s->want_resel in lsi_queue_req.

> I am not strongly attached to my proposed fix. If an alternative fix ca=
n
> be suggested, I'd be more than willing to try that.

The problem is that the timeout has no explanation under the SCSI
protocol, so I would like to understand where the logic is wrong in the
Parallel SCSI emulation.

Paolo
