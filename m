Received: from eggs.gnu.org ([2001:4830:134:3::10]:40421)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eoSYF-00050S-0x
	for qemu-devel@nongnu.org; Wed, 21 Feb 2018 06:27:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eoSYA-0008Jp-TT
	for qemu-devel@nongnu.org; Wed, 21 Feb 2018 06:27:07 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:52654 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1eoSYA-0008Je-Ok
	for qemu-devel@nongnu.org; Wed, 21 Feb 2018 06:27:02 -0500
References: <1519208316-18812-1-git-send-email-thuth@redhat.com>
	<556ae8d1-bb6c-d9cc-2b2b-d28fad96aa7b@ilande.co.uk>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <7e5993f0-2e92-97cf-00fb-2daaf32f905c@redhat.com>
Date: Wed, 21 Feb 2018 12:26:45 +0100
MIME-Version: 1.0
In-Reply-To: <556ae8d1-bb6c-d9cc-2b2b-d28fad96aa7b@ilande.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 0/7] Improvements and clean-ups related
 to -net
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org, Jason Wang <jasowang@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>

On 21.02.2018 11:41, Mark Cave-Ayland wrote:
> On 21/02/18 10:18, Thomas Huth wrote:
>=20
>> "-net" is a legacy option that often causes confusion and
>> misconfigurations for the users, since most people are not aware
>> of the underlying "vlan" (i.e. hub) concept that is used for this
>> parameter. The prefered way of configuring your network stack is
>> to use "--netdev" instead, which gives you a clean 1:1 connection
>> between your emulated guest hardware and the host network backend.
>>
>> However, there are two reasons why we could not completely deprecate
>> "-net" yet:
>>
>> 1) Convenience:
>> In some cases, it's more convenient to use "-net" instead of "--netdev=
",
>> e.g. if you just want to have a "tap" network connection, it's faster
>> to type "-net nic -net tap" instead of "--device e1000,netdev=3Dn1
>> --netdev tap,id=3Dn1".
>>
>> 2) On-board NICs:
>> Currently the "-net nic" parameter is the only way to configure on-
>> board NICs on certain (embedded) machines via the nd_table[] array.
>>
>> So beside some generic clean-ups and removal of code that has been
>> marked as deprecated since QEMU 2.10 already, this patch series intro-
>> duces a new parameter "--nic" (in patch 7) which should be able to re-
>> place "-net" in the long run completely: This new convenience paramete=
r
>> can be used to configure the default/on-board guest HW together with a
>> host network backend in a very compact way. To configure a tap backend
>> for the default NIC, you just have to type "--nic tap" here for exampl=
e.
>=20
> Hi Thomas,
>=20
> This is a great improvement for configuring on-board NICs! I do have a
> couple of questions about your patchset based on personal experience:
>=20
> 1) Does the new -nic syntax support multiple on-board NICs? I remember
> seeing this on some of the ARM boards I was studying when trying to
> implement something similar for SPARC.

Yes, that's possible. If you specify the "--nic" parameter multiple
times, it populates multiple entries in the nd_table[] array, so boards
can pick up multiple NICs from there. For example hw/arm/xlnx-zynqmp.c
initializes up to 4 (XLNX_ZYNQMP_NUM_GEMS) on-board NICs this way.

> 2) Is it possible to provide a convenient wrapper function to handle th=
e
> logic related to determining whether a specified NIC is on-board or not=
?
>=20
> For example take a look at
> https://git.qemu.org/?p=3Dqemu.git;a=3Dblob;f=3Dhw/sparc64/sun4u.c;h=3D=
da28ab9413efdbe0bf0e1d3bf2b545577b83d88a;hb=3Da6e0344fa0e09413324835ae122=
c4cadd7890231#l596
> where we have a nice dance to check whether the device specified is
> on-board or not, and if it isn't to plug it in as an extra PCI device
> instead. The complication here is that nd_tables[] is populated by
> default (and also with -net nic -net user) but not when someone
> specifies a single card via -netdev.
>=20
> From memory this was derived from the code in
> https://git.qemu.org/?p=3Dqemu.git;a=3Dblob;f=3Dhw/arm/realview.c;h=3D8=
7cd1e583cd20b6d8a2beeef1cba6977496d4477;hb=3Da6e0344fa0e09413324835ae122c=
4cadd7890231#l259
> if having another example helps?

Do you have something in mind how the interface to such a function
should look like?
Not sure whether there is a easy, magic solution for all boards ...
there are multiple problems, e.g. that you can normally not specify
on-board NICs via --device yet...
Anyway, that would be subject to another clean-up patch series - this
series here only focuses on the net/* files, not on the files in the hw/
folder.

 Thomas
