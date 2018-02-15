Received: from eggs.gnu.org ([2001:4830:134:3::10]:51760)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1emDCX-0000dX-6e
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 01:39:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1emDCU-0005ts-3e
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 01:39:25 -0500
References: <1517864246-11101-1-git-send-email-walling@linux.vnet.ibm.com>
	<1517864246-11101-7-git-send-email-walling@linux.vnet.ibm.com>
	<a7e79b24-7baa-2a8b-0659-cb03c68c75fd@linux.vnet.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <f97e6b7b-0765-c12b-b93d-a42470e470e2@redhat.com>
Date: Thu, 15 Feb 2018 07:38:48 +0100
MIME-Version: 1.0
In-Reply-To: <a7e79b24-7baa-2a8b-0659-cb03c68c75fd@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH v5 06/12] s390-ccw: parse and
 set boot menu options
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Collin L. Walling" <walling@linux.vnet.ibm.com>, qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: frankja@linux.vnet.ibm.com, cohuck@redhat.com, david@redhat.com, alifm@linux.vnet.ibm.com, mihajlov@linux.vnet.ibm.com, borntraeger@de.ibm.com, eblake@redhat.com

On 14.02.2018 18:46, Collin L. Walling wrote:
> I'm beginning to like the usage of splash-time to represent a timeout
> for the boot menu
> less and less.=C2=A0 It is really meant for how long a _splash_ _image_
> should appear during boot.
>=20
> I'd like to suggest adding a new boot option "menu-timeout".=C2=A0 An
> alternative would be
> documenting in qemu-options.hx that s390 treats "splash-time" as the
> menu-timeout.
>=20
> Thoughts?

I think you should keep splash-time and not introduce a new option.
Libvirt seems to map the timeout from <bootmenu enable=3D'yes'
timeout=3D'X'/> to the splash-time option, and according to the libvirt
documentation: "Additional attribute timeout takes the number of
milliseconds the boot menu should wait until it times out."

So it seems like splash-time is already expected to define the amount of
time for the boot menu. We should not confuse libvirt or the users by
introducing yet another option here.

 Thomas


> On 02/05/2018 03:57 PM, Collin L. Walling wrote:
>> Set boot menu options for an s390 guest and store them in
>> the iplb. These options are set via the QEMU command line
>> option:
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0 -boot menu=3Don|off[,splash-time=3DX]
>>
>> or via the libvirt domain xml:
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0 <os>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 <bootmenu enable=3D'yes|no' timeo=
ut=3D'X'/>
>> =C2=A0=C2=A0=C2=A0=C2=A0 </os>
>>
>> Where X represents some positive integer representing
>> milliseconds.
>>
>> Any value set for loadparm will override all boot menu options.
>> If loadparm=3DPROMPT, then the menu will be enabled without a
>> timeout.
>>
>> The absence of any boot options on the command line will flag
>> to later use the zipl boot loader values.
>>
>> Signed-off-by: Collin L. Walling <walling@linux.vnet.ibm.com>
>> Reviewed-by: Janosch Frank <frankja@linux.vnet.ibm.com>
>> Reviewed-by: Thomas Huth <thuth@redhat.com>
>> ---
>> [...]
