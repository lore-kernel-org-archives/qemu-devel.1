Received: from eggs.gnu.org ([2001:4830:134:3::10]:50134)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eqcUV-00015d-5Z
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 05:28:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eqcUQ-0003jU-58
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 05:28:11 -0500
References: <1519725913-24852-1-git-send-email-thuth@redhat.com>
	<d638aa33-2102-e6a4-d79a-05591693de07@linux.vnet.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <c2e86ee8-e86a-3e02-71c6-66f45ce153d7@redhat.com>
Date: Tue, 27 Feb 2018 11:27:46 +0100
MIME-Version: 1.0
In-Reply-To: <d638aa33-2102-e6a4-d79a-05591693de07@linux.vnet.ibm.com>
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
To: Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>, Cornelia Huck <cohuck@redhat.com>, qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, David Hildenbrand <david@redhat.com>

On 27.02.2018 11:16, Viktor Mihajlovski wrote:
> On 27.02.2018 11:05, Thomas Huth wrote:
>> If QEMU fails to load 's390-netboot.img', the guest firmware currently
>> loops forever and just floods the console with "Network boot device
>> detected" messages. The code in ipl.c apparently already tried to stop
>> the VM with vm_stop() in this case, but this is in vain since the run
>> state is later reset due to a call to vm_start() from vl.c again.
>> To avoid the ugly firmware loop, let's simply exit QEMU directly inste=
ad
>> since it just does not make sense to continue if the required firmware
>> image can not be loaded. While we're at it, also add the file name of
>> the netboot binary to the error message, so that the user has a better
>> hint about what is missing.
>>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>  hw/s390x/ipl.c | 5 +++--
>>  1 file changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c
>> index 0d06fc1..ff8308e 100644
>> --- a/hw/s390x/ipl.c
>> +++ b/hw/s390x/ipl.c
>> @@ -322,7 +322,8 @@ static int load_netboot_image(Error **errp)
>>
>>      netboot_filename =3D qemu_find_file(QEMU_FILE_TYPE_BIOS, ipl->net=
boot_fw);
>>      if (netboot_filename =3D=3D NULL) {
>> -        error_setg(errp, "Could not find network bootloader");
>> +        error_setg(errp, "Could not find network bootloader '%s'",> +=
                   ipl->netboot_fw);
>>          goto unref_mr;
>>      }
>>
>> @@ -416,7 +417,7 @@ void s390_ipl_prepare_cpu(S390CPU *cpu)
>>      if (ipl->netboot) {
>>          if (load_netboot_image(&err) < 0) {
>>              error_report_err(err);
>> -            vm_stop(RUN_STATE_INTERNAL_ERROR);
> Should we print something like 'exiting' or 'terminating' here, to make
> clear that the situation is terminal?
No, we normally don't print out "exiting" or "terminating" in such a
case. For example:

hw/alpha/dp264.c:    error_report("could not load palcode '%s'", palcode_=
filename);
hw/alpha/dp264.c:    exit(1);

hw/arm/boot.c:       error_report("failed to load \"%s\"", image_name);
hw/arm/boot.c:       exit(1);

hw/mips/mips_jazz.c: error_report("Could not load MIPS bios '%s'", bios_n=
ame);
hw/mips/mips_jazz.c: exit(1);

hw/ppc/spapr.c:      error_report("Could not load LPAR rtas '%s'", filena=
me);
hw/ppc/spapr.c:      exit(1);

etc.

 Thomas
