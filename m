Received: from eggs.gnu.org ([2001:4830:134:3::10]:48513)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jtomko@redhat.com>) id 1fGQ0c-0006a7-Cg
	for qemu-devel@nongnu.org; Wed, 09 May 2018 10:23:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jtomko@redhat.com>) id 1fGQ0Y-0000rn-EO
	for qemu-devel@nongnu.org; Wed, 09 May 2018 10:23:58 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54954 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jtomko@redhat.com>) id 1fGQ0Y-0000qD-6C
	for qemu-devel@nongnu.org; Wed, 09 May 2018 10:23:54 -0400
Date: Wed, 9 May 2018 16:23:47 +0200
From: =?iso-8859-1?B?SuFu?= Tomko <jtomko@redhat.com>
Message-ID: <20180509142347.GD25952@dnr>
References: <20180507033214.19219-1-zyimin@linux.ibm.com>
	<20180507033214.19219-2-zyimin@linux.ibm.com>
	<e4041508-c6ba-5e83-8bd8-50a4bd996009@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="k4f25fnPtRuIRUb3"
Content-Disposition: inline
In-Reply-To: <e4041508-c6ba-5e83-8bd8-50a4bd996009@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 1/1] sandbox: avoid to compile options if
 CONFIG_SECCOMP undefined
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Yi Min Zhao <zyimin@linux.ibm.com>, qemu-devel@nongnu.org, otubo@redhat.com, fiuczy@linux.ibm.com, borntraeger@de.ibm.com, jferlan@redhat.com


--k4f25fnPtRuIRUb3
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Mon, May 07, 2018 at 01:04:17PM -0500, Eric Blake wrote:
>On 05/06/2018 10:32 PM, Yi Min Zhao wrote:
>
>In the subject line: s/avoid to compile/avoid compiling/
>
>> If CONFIG_SECCOMP is undefined, the option 'elevatorprivileges' remains
>
>s/elevator/elevate/
>
>> complied. This would make libvirt set the corresponding capability and
>
>s/complied/compiled/
>
>> then trigger the guest startup fails. So let's wrap the options with
>> CONFIG_SECCOMP.
>>
>> Signed-off-by: Yi Min Zhao <zyimin@linux.ibm.com>
>> ---
>>   vl.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/vl.c b/vl.c
>> index fce1fd12d8..cb07b19c02 100644
>> --- a/vl.c
>> +++ b/vl.c
>> @@ -268,6 +268,7 @@ static QemuOptsList qemu_sandbox_opts = {
>>               .name = "enable",
>>               .type = QEMU_OPT_BOOL,
>>           },
>> +#ifdef CONFIG_SECCOMP
>>           {
>>               .name = "obsolete",
>>               .type = QEMU_OPT_STRING,
>> @@ -284,6 +285,7 @@ static QemuOptsList qemu_sandbox_opts = {
>>               .name = "resourcecontrol",
>>               .type = QEMU_OPT_STRING,
>>           },
>> +#endif
>
>The commit message mentions only 'elevateprivileges' (once the typo is
>fixed), but you are also crippling 'obsolete', 'spawn', and
>'resourcecontrol'.  Perhaps the commit message should call that out
>better?  Or, since libvirt is looking at just 'elevateprivileges', per
>this line in libvirt's qemu_capabilities.c:
>
>src/qemu/qemu_capabilities.c:    { "sandbox", "elevateprivileges",
>QEMU_CAPS_SECCOMP_BLACKLIST },
>
>is it sufficient to just mask out that one option?

That would be inconsistent. I picked one option randomly, because they
were added at the same time, but compiling out just one out of four
is just odd. And with leaving them in even though the functionality is
compiled out, libvirt has no way to tell upfront whether it's usable.

By that logic, removing the -sandbox option without CONFIG_SECCOMP makes
sense, but libvirt already assumes this option is present on all supported
QEMUs (>= 1.5.0), so please cc: me on that change if you decide to
remove it as well.

Jano

--k4f25fnPtRuIRUb3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEyAry0cRMFDoj9m/ZyvpdPXT/AmkFAlrzBGwACgkQyvpdPXT/
AmmI/BAAkEbez+4tNIUCoeZVF+t41ymQVFhQR9CxBd9GjivZZwciXEWZSdgFsQAu
VopxLRnDsfALxVM32Liu98/IyjmpA935D+JydLO5zpCfH4UpGu26xTUJ/PASoKJg
rnA16FAcPQmdaWnDVm6qpHRpi885u8wSDAaD1BTRZf0uOLgQQCcI808+42fKr1eX
wA+z4EMqwBudboVNhprucsZZsZt5SURPp2ZE2hfPP7grKnWMVpQFAYvoWvJRQwoK
BrQC5Vf1EkfYHocnVSR6RJkN5M7dQBuaDTdXsVjxVFj7MDpbrXnV4iK92LM1AxzU
7KSZzrI1wgT1jABuURl1uRox3Uj4phxsTCGeXjyjRDSslgpd8b6WuzmC5M6zm0To
ofKxQyk1Pufhg2SqjPoPDi50t4c/lCj0uOlMxJmCzEoRERqjlO+vavNbN3p6qlR8
/YPx8cWOLbMvpaGW115tX26w7glitBgNMZGIF777lE3gy3eUQ1yhrTQWfh0lTFRy
PHZQBi1M2Gviwip8elq4AVBumzIQO+i2IvIIyx2VQ1pbLyiKc+0lTxeOSwtAUcCR
JsJAKMJ0Vk0wxVYef9+o6Serq8U7X420ED5nSGKH7VnNCPAVxaYawiH6VAdazGxG
MDkIHslLN0I0uoie9tXUpOVvy7dS275ZD4VFPr/SdzInD4Qm1IM=
=0x1Z
-----END PGP SIGNATURE-----

--k4f25fnPtRuIRUb3--
