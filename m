Received: from eggs.gnu.org ([2001:4830:134:3::10]:40123)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alifm@linux.vnet.ibm.com>) id 1eqnHK-0007mk-I9
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 16:59:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alifm@linux.vnet.ibm.com>) id 1eqnHH-0005RV-Gt
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 16:59:18 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:35666
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alifm@linux.vnet.ibm.com>)
	id 1eqnHH-0005RA-B3
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 16:59:15 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w1RLs8Cx100945
	for <qemu-devel@nongnu.org>; Tue, 27 Feb 2018 16:59:14 -0500
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2gdec633q1-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 27 Feb 2018 16:59:13 -0500
Received: from localhost
	by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <alifm@linux.vnet.ibm.com>;
	Tue, 27 Feb 2018 14:59:13 -0700
References: <1519725913-24852-1-git-send-email-thuth@redhat.com>
	<d638aa33-2102-e6a4-d79a-05591693de07@linux.vnet.ibm.com>
	<b0d960d5-6f08-ffd0-a3af-e2b689580bc1@linux.vnet.ibm.com>
	<7a16dcde-b3eb-5b4a-da87-bfa1eab985a8@redhat.com>
From: Farhan Ali <alifm@linux.vnet.ibm.com>
Date: Tue, 27 Feb 2018 16:59:07 -0500
MIME-Version: 1.0
In-Reply-To: <7a16dcde-b3eb-5b4a-da87-bfa1eab985a8@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Message-Id: <fa0e05ad-8d73-0495-40f4-a1f9dacc9be8@linux.vnet.ibm.com>
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
To: Thomas Huth <thuth@redhat.com>, Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>, Cornelia Huck <cohuck@redhat.com>, qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, David Hildenbrand <david@redhat.com>



On 02/27/2018 02:11 PM, Thomas Huth wrote:
> On 27.02.2018 18:26, Farhan Ali wrote:
>>
>>
>> On 02/27/2018 05:16 AM, Viktor Mihajlovski wrote:
>>> On 27.02.2018 11:05, Thomas Huth wrote:
>>>> If QEMU fails to load 's390-netboot.img', the guest firmware current=
ly
>>>> loops forever and just floods the console with "Network boot device
>>>> detected" messages. The code in ipl.c apparently already tried to st=
op
>>>> the VM with vm_stop() in this case, but this is in vain since the ru=
n
>>>> state is later reset due to a call to vm_start() from vl.c again.
>>>> To avoid the ugly firmware loop, let's simply exit QEMU directly ins=
tead
>>>> since it just does not make sense to continue if the required firmwa=
re
>>>> image can not be loaded. While we're at it, also add the file name o=
f
>>>> the netboot binary to the error message, so that the user has a bett=
er
>>>> hint about what is missing.
>>>>
>>>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>>>> ---
>>>>  =C2=A0 hw/s390x/ipl.c | 5 +++--
>>>>  =C2=A0 1 file changed, 3 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c
>>>> index 0d06fc1..ff8308e 100644
>>>> --- a/hw/s390x/ipl.c
>>>> +++ b/hw/s390x/ipl.c
>>>> @@ -322,7 +322,8 @@ static int load_netboot_image(Error **errp)
>>>>
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 netboot_filename =3D qemu_find_file(=
QEMU_FILE_TYPE_BIOS,
>>>> ipl->netboot_fw);
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (netboot_filename =3D=3D NULL) {
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_setg(errp, "Could =
not find network bootloader");
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_setg(errp, "Could =
not find network bootloader '%s'",>
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ipl->netboot_fw);
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto unref_m=
r;
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>>
>>>> @@ -416,7 +417,7 @@ void s390_ipl_prepare_cpu(S390CPU *cpu)
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ipl->netboot) {
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (load_net=
boot_image(&err) < 0) {
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 error_report_err(err);
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
vm_stop(RUN_STATE_INTERNAL_ERROR);
>>> Should we print something like 'exiting' or 'terminating' here, to ma=
ke
>>> clear that the situation is terminal? Sometimes errors are reported a=
nd
>>> processing continues nonetheless.
>>
>>
>> I had to go through my old notes to see why I didn't just exit when I
>> wrote it, and the reason was so we could put the guest in wait state s=
o
>> we can do some diagnostics....
>>
>> Do we want to change this behavior?
>=20
> That intended behavior obviously does not work, since the guest is
> started anyway here.
>=20
> And in this case, it does not make much sense to put the guest into wai=
t
> state, since the problem is simply that a firmware image could not be
> loaded by QEMU, i.e. it's a problem in the host, not in the guest. Or
> which kind of guest diagnostics would you expect here? ... Putting the
> guest into stopped state only makes sense if the guest crashed /
> panicked, so you could analyze the reason for the crash.
>=20
>   Thomas
>=20

You are right and this would be the right thing to do.

Reviewed-by: Farhan Ali <alifm@linux.vnet.ibm.com>
