Received: from eggs.gnu.org ([2001:4830:134:3::10]:47631)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <gmoro@suse.de>) id 1e43Nj-0006P4-AW
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 07:16:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <gmoro@suse.de>) id 1e43Nf-0003xc-9C
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 07:16:27 -0400
Received: from mx2.suse.de ([195.135.220.15]:37740)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <gmoro@suse.de>) id 1e43Nf-0003x1-2R
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 07:16:23 -0400
References: <58f74661-3830-4127-e30b-37baebeba532@suse.de>
	<20171014094543.GA32099@lemon>
From: Guilherme Moro <gmoro@suse.de>
Message-ID: <c4aed20a-7109-6ec3-d27d-d84d1986d36e@suse.de>
Date: Mon, 16 Oct 2017 12:16:19 +0100
MIME-Version: 1.0
In-Reply-To: <20171014094543.GA32099@lemon>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] qemu-img convert to VMDK
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org

On 10/14/2017 10:45 AM, Fam Zheng wrote:
> On Fri, 10/13 15:20, Guilherme Moro wrote:
>> Hi,
>>
>> I'm trying to convert some images from raw to vmdk to run in a ESXi6.5
>> server but I need to rectify the image before being able to run.
>>
>> The scenario goes like that:
>>
>> qemu-img convert -f raw image.raw -O vmdk -o compat6 image.vmdk
>> ESXi complains with "Failed - File system specific implementation of
>> LookupAndOpen"[file] failed
>> running vmkfstools -x repair on the image make it bootable
>>
>>  =C2=A0I checked the changes, vmkfstools is basically removing the sec=
ond
>> descriptor from the end of the file, I'm not familiar enough with the =
code
>> and the format to know what this means, maybe compat6 should make qemu=
-img
>> avoid to put that in the end of the file (again, mostly guessing).
>>
>> Anyway we would need an option to make sure that this second descripto=
r does
>> not end in the final image.
> What do you mean by "second descriptor"? The one at offset 0x200? But o=
ther than
> this descriptor I don't see a second one. Maybe I'm missing something?
>
> Fam

Hi,

maybe there's something else happening on my side, I will double check,=20
but my converted image have descriptors in the end and in the beginning=20
of the file:

linux-kv33:/data/NFS # tail -c 512=20
SLES15-JeOS-for-VMware.x86_64-1.3.0-Build.vmdk
encoding=3D"UTF-8"
# Disk DescriptorFile
version=3D1
CID=3Df7105bc0
parentCID=3Dffffffff
createType=3D"monolithicSparse"

# Extent description
RW 50331648 SPARSE "SLES15-JeOS-for-VMware.x86_64-1.3.0.vmdk"

# The Disk Data Base
#DDB

ddb.virtualHWVersion =3D "4"
ddb.geometry.cylinders =3D "49932"
ddb.geometry.heads =3D "16"
ddb.geometry.sectors =3D "63"
ddb.adapterType =3D "ide"

ddb.toolsInstallType =3D "4"
ddb.toolsVersion =3D "10282"


linux-kv33:/data/NFS # head -c 1024=20
SLES15-JeOS-for-VMware.x86_64-1.3.0-Build.vmdk
KDMV=01=03=03=EF=BF=BD=01=14=02=15=1B
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 =EF=BF=BD=18

# Disk DescriptorFile
version=3D1
CID=3Df7105bc0
parentCID=3Dffffffff
createType=3D"monolithicSparse"

# Extent description
RW 50331648 SPARSE "SLES15-JeOS-for-VMware.x86_64-1.3.0.vmdk"

# The Disk Data Base
#DDB

ddb.virtualHWVersion =3D "4"
ddb.geometry.cylinders =3D "49932"
ddb.geometry.heads =3D "16"
ddb.geometry.sectors =3D "63"
ddb.adapterType =3D "ide"


Again, not acquainted with the code as much, but the code seems to=20
indicate VMDK4 files having a footer. Specifically the function=20
vmdk_open_vmdk4 inside block/vmdk.c .

I couldn't trace further if there's any other code *writing*=C2=A0 a foot=
er.

Guilherme
