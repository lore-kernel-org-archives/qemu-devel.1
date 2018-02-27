Received: from eggs.gnu.org ([2001:4830:134:3::10]:57193)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eqkfj-0001tv-Ul
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 14:12:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eqkff-0000fi-0J
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 14:12:19 -0500
References: <1519725913-24852-1-git-send-email-thuth@redhat.com>
	<d638aa33-2102-e6a4-d79a-05591693de07@linux.vnet.ibm.com>
	<b0d960d5-6f08-ffd0-a3af-e2b689580bc1@linux.vnet.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <7a16dcde-b3eb-5b4a-da87-bfa1eab985a8@redhat.com>
Date: Tue, 27 Feb 2018 20:11:54 +0100
MIME-Version: 1.0
In-Reply-To: <b0d960d5-6f08-ffd0-a3af-e2b689580bc1@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] hw/s390x/ipl: Bail out if the network
 bootloader can not be found
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Farhan Ali <alifm@linux.vnet.ibm.com>, Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>, Cornelia Huck <cohuck@redhat.com>, qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, David Hildenbrand <david@redhat.com>

On 27.02.2018 18:26, Farhan Ali wrote:
>=20
>=20
> On 02/27/2018 05:16 AM, Viktor Mihajlovski wrote:
>> On 27.02.2018 11:05, Thomas Huth wrote:
>>> If QEMU fails to load 's390-netboot.img', the guest firmware currentl=
y
>>> loops forever and just floods the console with "Network boot device
>>> detected" messages. The code in ipl.c apparently already tried to sto=
p
>>> the VM with vm_stop() in this case, but this is in vain since the run
>>> state is later reset due to a call to vm_start() from vl.c again.
>>> To avoid the ugly firmware loop, let's simply exit QEMU directly inst=
ead
>>> since it just does not make sense to continue if the required firmwar=
e
>>> image can not be loaded. While we're at it, also add the file name of
>>> the netboot binary to the error message, so that the user has a bette=
r
>>> hint about what is missing.
>>>
>>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>>> ---
>>> =C2=A0 hw/s390x/ipl.c | 5 +++--
>>> =C2=A0 1 file changed, 3 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c
>>> index 0d06fc1..ff8308e 100644
>>> --- a/hw/s390x/ipl.c
>>> +++ b/hw/s390x/ipl.c
>>> @@ -322,7 +322,8 @@ static int load_netboot_image(Error **errp)
>>>
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 netboot_filename =3D qemu_find_file(QE=
MU_FILE_TYPE_BIOS,
>>> ipl->netboot_fw);
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (netboot_filename =3D=3D NULL) {
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_setg(errp, "Could n=
ot find network bootloader");
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_setg(errp, "Could n=
ot find network bootloader '%s'",>
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ipl->netboot_fw);
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto unref_mr;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>
>>> @@ -416,7 +417,7 @@ void s390_ipl_prepare_cpu(S390CPU *cpu)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ipl->netboot) {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (load_netbo=
ot_image(&err) < 0) {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 error_report_err(err);
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 v=
m_stop(RUN_STATE_INTERNAL_ERROR);
>> Should we print something like 'exiting' or 'terminating' here, to mak=
e
>> clear that the situation is terminal? Sometimes errors are reported an=
d
>> processing continues nonetheless.
>=20
>=20
> I had to go through my old notes to see why I didn't just exit when I
> wrote it, and the reason was so we could put the guest in wait state so
> we can do some diagnostics....
>=20
> Do we want to change this behavior?

That intended behavior obviously does not work, since the guest is
started anyway here.

And in this case, it does not make much sense to put the guest into wait
state, since the problem is simply that a firmware image could not be
loaded by QEMU, i.e. it's a problem in the host, not in the guest. Or
which kind of guest diagnostics would you expect here? ... Putting the
guest into stopped state only makes sense if the guest crashed /
panicked, so you could analyze the reason for the crash.

 Thomas
