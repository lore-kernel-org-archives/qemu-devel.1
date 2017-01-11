Received: from eggs.gnu.org ([2001:4830:134:3::10]:48632)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <joserz@linux.vnet.ibm.com>) id 1cRNDh-0007nb-H4
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 13:01:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <joserz@linux.vnet.ibm.com>) id 1cRNDd-0004ea-K4
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 13:01:57 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:46302
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <joserz@linux.vnet.ibm.com>)
	id 1cRNDd-0004eT-Dv
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 13:01:53 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
	v0BHxEQ4065715
	for <qemu-devel@nongnu.org>; Wed, 11 Jan 2017 13:01:52 -0500
Received: from e24smtp01.br.ibm.com (e24smtp01.br.ibm.com [32.104.18.85])
	by mx0b-001b2d01.pphosted.com with ESMTP id 27wmx5e3d2-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 11 Jan 2017 13:01:52 -0500
Received: from localhost
	by e24smtp01.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <joserz@linux.vnet.ibm.com>;
	Wed, 11 Jan 2017 16:01:49 -0200
Received: from d24relay03.br.ibm.com (d24relay03.br.ibm.com [9.18.232.225])
	by d24dlp01.br.ibm.com (Postfix) with ESMTP id 31C8F352005F
	for <qemu-devel@nongnu.org>; Wed, 11 Jan 2017 13:01:16 -0500 (EST)
Received: from d24av05.br.ibm.com (d24av05.br.ibm.com [9.18.232.44])
	by d24relay03.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
	v0BI1kPV34078878
	for <qemu-devel@nongnu.org>; Wed, 11 Jan 2017 16:01:46 -0200
Received: from d24av05.br.ibm.com (localhost [127.0.0.1])
	by d24av05.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
	v0BE1kUS012399
	for <qemu-devel@nongnu.org>; Wed, 11 Jan 2017 12:01:46 -0200
Date: Wed, 11 Jan 2017 16:01:42 -0200
From: joserz@linux.vnet.ibm.com
References: <20170111164105.27164.30697.malonedeb@chaenomeles.canonical.com>
	<4fc41772-1607-7e55-ffa1-80e3579b964d@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4fc41772-1607-7e55-ffa1-80e3579b964d@redhat.com>
Message-Id: <20170111180142.GA8281@pacoca>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Bug 1655708] [NEW] target/ppc/int_helper.c:2806:
 strange expression ?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <1655708@bugs.launchpad.net>
Cc: qemu-devel@nongnu.org

On Wed, Jan 11, 2017 at 05:12:38PM -0000, Eric Blake wrote:
> On 01/11/2017 10:41 AM, dcb wrote:
> > Public bug reported:
> >=20
> > target/ppc/int_helper.c:2806:25: warning: =E2=80=98*=E2=80=99 in bool=
ean context,
> > suggest =E2=80=98&&=E2=80=99 instead [-Wint-in-bool-context]
> >=20
> > Source code is
> >=20
> >        zone_digit =3D (i * 2) ? b->u8[BCD_DIG_BYTE(i * 2)] >> 4 :
> > zone_lead;
>=20
> Also, looking at BCD_DIG_BYTE():
>=20
> #if defined(HOST_WORDS_BIGENDIAN)
> #define BCD_DIG_BYTE(n) (15 - (n/2))
> #else
> #define BCD_DIG_BYTE(n) (n/2)
> #endif
>=20
> Oops. n is under-parenthesized, and will cause invalid expansions for
> some expressions.  Let's fix that as well.
>=20
Hello guys!!

Do you mean something like:

BCD_DIG_BYTE(n) (15 - ((n)/2)) and BCD_DIG_BYTE(n) ((n)/2) ?

to avoid issues like BCD_DIG_BYTE(i + 3) that will expand to (i + 3/2)
instead of ((i + 3)/2), right?

>=20
> > so I think the compiler warning is for the i * 2 lhs of the ?.
>=20
> Yes - the compiler is complaining that 'i * 2' can only be non-zero if
> 'i' was non-zero (given that the code occurs in a loop for i between 0
> and 16), so it is just as easy to write 'i ? ...' instead of the weirde=
r
> '(i * 2) ? ...'.
>=20

Yes, Eric is correct it's meant to be "(i) ? .. : .." because the sign
is located at position 0. I'm improving it. I'll send a patch for them
today.

Thanks!
