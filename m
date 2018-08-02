Received: from eggs.gnu.org ([2001:4830:134:3::10]:48389)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <frankja@linux.ibm.com>) id 1fl7Uc-00008S-0J
	for qemu-devel@nongnu.org; Thu, 02 Aug 2018 02:53:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <frankja@linux.ibm.com>) id 1fl7UY-0005Rk-Sb
	for qemu-devel@nongnu.org; Thu, 02 Aug 2018 02:53:49 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:33342
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <frankja@linux.ibm.com>)
	id 1fl7UY-0005RT-Ku
	for qemu-devel@nongnu.org; Thu, 02 Aug 2018 02:53:46 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w726ml0a106079
	for <qemu-devel@nongnu.org>; Thu, 2 Aug 2018 02:53:45 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2kktprvxk6-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 02 Aug 2018 02:53:45 -0400
Received: from localhost
	by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <frankja@linux.ibm.com>;
	Thu, 2 Aug 2018 07:53:43 +0100
References: <20180801131905.148778-1-frankja@linux.ibm.com>
	<20180801131905.148778-3-frankja@linux.ibm.com>
	<2da970ab-276f-f792-54d8-c696e899cac5@redhat.com>
From: Janosch Frank <frankja@linux.ibm.com>
Date: Thu, 2 Aug 2018 08:53:18 +0200
MIME-Version: 1.0
In-Reply-To: <2da970ab-276f-f792-54d8-c696e899cac5@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="kTWHupgxdByrEm3BDLrgxo8ee5kIft0bG"
Message-Id: <1889220a-b804-23a2-26ef-1a319da01d26@linux.ibm.com>
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH v4 2/2] s390x: Enable KVM huge
 page backing support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: borntraeger@de.ibm.com, qemu-s390x@nongnu.org, cohuck@redhat.com, david@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--kTWHupgxdByrEm3BDLrgxo8ee5kIft0bG
From: Janosch Frank <frankja@linux.ibm.com>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: borntraeger@de.ibm.com, qemu-s390x@nongnu.org, cohuck@redhat.com,
 david@redhat.com
Message-ID: <1889220a-b804-23a2-26ef-1a319da01d26@linux.ibm.com>
Subject: Re: [qemu-s390x] [PATCH v4 2/2] s390x: Enable KVM huge page backing
 support
References: <20180801131905.148778-1-frankja@linux.ibm.com>
 <20180801131905.148778-3-frankja@linux.ibm.com>
 <2da970ab-276f-f792-54d8-c696e899cac5@redhat.com>
In-Reply-To: <2da970ab-276f-f792-54d8-c696e899cac5@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01.08.2018 18:47, Thomas Huth wrote:
> On 08/01/2018 03:19 PM, Janosch Frank wrote:
>> +static int kvm_s390_configure_mempath_backing(KVMState *s)
>> +{
>> +    size_t path_psize =3D qemu_mempath_getpagesize(mem_path);
>> +
>> +    if (path_psize =3D=3D 4 * KiB)
>> +        return 0;
>=20
> Missing curly braces.

urgh, right, this is not the kernel.

>=20
>> +    if (path_psize !=3D 1 * MiB) {
>> +        error_report("Memory backing with 2G pages was specified, "
>> +                     "but KVM does not support this memory backing");=

>=20
> May I suggest to use a text that rather matches the condition of the
> if-statement (just in case there will be other sizes in the future...),=

> e.g. "Memory backing is only supported for 1 MiB huge pages" or
> something similar.
>=20
>  Thomas
>=20

That's actually the gist of it. s390 supports 4k, 1M and 2G and looking
at the POP I don't see a big chance of having any more sizes, as there
are not a lot of software bits left and adding support in OSs is a pain.
Also don't hold your breath for 2G, it would need a rewrite of gmap.c.

Also this is more explicit.




--kTWHupgxdByrEm3BDLrgxo8ee5kIft0bG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJbYqpzAAoJEBcO/8Q8ZEV5lmwQALCgGh4TVbBWGmDxuKQn9Ljw
b7HekXwGQ0S7eyj709javFXiVZUdWSN5oVLc8lNN9vQlt/C5eQsab3rb84QUhgjx
CInTyfO7SmFR7/K+kcqQoQXrcTZXHXhoo5MtyQRhAk2UvzljxMrNGXtZBuvW7qj5
VCe//oj0iThcvAi9Iq2r374uWjM84xZ71wiCFyaec5PJHfilbQdXnMNaBeTsLHaB
QXI2xHsZniqX2j/mT6sJqLO606IeZ8dvAUoVCnyEHguMk8N0c6dJkzAL5ip1G1re
ukp92rlmkSpxOx1V/30ZEiWa5J+/zbkEKzNAzesR61P6UwWIwEW0LRup7RAgwfLu
FYe0l9Zu1BMj8xd48j3V6Ymz35cnJHu7EgbDlItE+Q8+zIMdJP8UMMpAaInE+cJA
WDeN0+2PD6Mps51QpX214PJoCmxW76MwzCCfspHTia0yyUKl7TRId6v7CmKorFQi
lFXirR3rJiRukro4FPTIhUrRXi/D+IP4iRjBSkloQS2k8J6u9+iTiNMO/2DQ99au
23RMz974M0toaKrWhL8ml/1yXI7UdgzRytsAG6oigLi3aQwoTYADOPyOrLAyL8Kx
ZnsNH/40lp2mdSYG5SH09RFZZ0G6iQ6hMgkRFWsawIZRbitHwhFhp0LqD6MXWIrz
xWxjZQQjm8ksQbsCql+O
=TVvS
-----END PGP SIGNATURE-----

--kTWHupgxdByrEm3BDLrgxo8ee5kIft0bG--
