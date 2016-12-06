Received: from eggs.gnu.org ([2001:4830:134:3::10]:41848)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1cE8qT-0007FV-TL
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 01:03:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1cE8qQ-0004bw-Qe
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 01:03:17 -0500
Received: from 001b2d01.pphosted.com ([148.163.156.1]:38904
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <nikunj@linux.vnet.ibm.com>)
	id 1cE8qQ-0004be-Hz
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 01:03:14 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
	uB65wVoT072205
	for <qemu-devel@nongnu.org>; Tue, 6 Dec 2016 01:03:13 -0500
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
	by mx0a-001b2d01.pphosted.com with ESMTP id 275pux36a6-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 06 Dec 2016 01:03:12 -0500
Received: from localhost
	by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <nikunj@linux.vnet.ibm.com>;
	Tue, 6 Dec 2016 16:03:10 +1000
From: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
In-Reply-To: <f4a37b42-8854-bbbb-08f9-1b39d44c4849@twiddle.net>
References: <1480937130-24561-1-git-send-email-nikunj@linux.vnet.ibm.com>
	<1480937130-24561-7-git-send-email-nikunj@linux.vnet.ibm.com>
	<f4a37b42-8854-bbbb-08f9-1b39d44c4849@twiddle.net>
Date: Tue, 06 Dec 2016 11:33:02 +0530
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Message-Id: <874m2hioh5.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
Subject: Re: [Qemu-devel] [PATCH 06/13] target-ppc: implement stxvll
 instructions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au
Cc: qemu-devel@nongnu.org, bharata@linux.vnet.ibm.com

Richard Henderson <rth@twiddle.net> writes:

> On 12/05/2016 03:25 AM, Nikunj A Dadhania wrote:
>> +    getVSR(xt_num, &xt, env);
>> +    if (msr_le) {
>> +        for (i =3D 0; i < end; i++) {
>> +            cpu_stb_data_ra(env, addr, xt.u8[i], GETPC());
>> +            addr =3D addr_add(env, addr, 1);
>> +        }
>> +    } else {
>> +        for (i =3D 15; i > 15 - end; i--) {
>> +            cpu_stb_data_ra(env, addr, xt.u8[i], GETPC());
>> +            addr =3D addr_add(env, addr, 1);
>> +        }
>> +    }
>
> Have you accidentally swapped the implementations of stxvl and stxvll?

Now I am in doubt :-)
Let me put my understanding here.

In case of stxvl if we have following vector:
        +---+---+---+---+---+---+---+---+---+---+---+---+---+---+--+--+
    BE  |=E2=80=9CT=E2=80=9D|=E2=80=9Ch=E2=80=9D|=E2=80=9Ci=E2=80=9D|=E2=80=
=9Cs=E2=80=9D|=E2=80=9C =E2=80=9D|=E2=80=9Ci=E2=80=9D|=E2=80=9Cs=E2=80=9D|=
=E2=80=9C =E2=80=9D|=E2=80=9Ca=E2=80=9D|=E2=80=9C =E2=80=9D|=E2=80=9CT=E2=
=80=9D|=E2=80=9CE=E2=80=9D|=E2=80=9CS=E2=80=9D|=E2=80=9CT=E2=80=9D|00|00|
        +---+---+---+---+---+---+---+---+---+---+---+---+---+---+--+--+=20=
=20=20=20=20=20=20=20=20
        +--+--+---+---+---+---+---+---+---+---+---+---+---+---+---+---+
    LE  |00|00|=E2=80=9CT=E2=80=9D|=E2=80=9CS=E2=80=9D|=E2=80=9CE=E2=80=9D|=
=E2=80=9CT=E2=80=9D|=E2=80=9C =E2=80=9D|=E2=80=9Ca=E2=80=9D|=E2=80=9C =E2=
=80=9D|=E2=80=9Cs=E2=80=9D|=E2=80=9Ci=E2=80=9D|=E2=80=9C =E2=80=9D|=E2=80=
=9Cs=E2=80=9D|=E2=80=9Ci=E2=80=9D|"h"|"T"|
        +--+--+---+---+---+---+---+---+---+---+---+---+---+---+---+---+

    So for LE/BE: u[0] =3D "T", u[1] =3D "h", u[2] =3D "i", u[3] =3D "s", .=
...
=20=20=20=20
    Storage should be of following order:
        +---+---+---+---+---+---+---+---+---+---+---+---+---+---+--+--+
        |=E2=80=9CT=E2=80=9D|=E2=80=9Ch=E2=80=9D|=E2=80=9Ci=E2=80=9D|=E2=80=
=9Cs=E2=80=9D|=E2=80=9C =E2=80=9D|=E2=80=9Ci=E2=80=9D|=E2=80=9Cs=E2=80=9D|=
=E2=80=9C =E2=80=9D|=E2=80=9Ca=E2=80=9D|=E2=80=9C =E2=80=9D|=E2=80=9CT=E2=
=80=9D|=E2=80=9CE=E2=80=9D|=E2=80=9CS=E2=80=9D|=E2=80=9CT=E2=80=9D|FF|FF|
        +---+---+---+---+---+---+---+---+---+---+---+---+---+---+--+--+

While in case of stxvll
       +---+---+---+---+---+---+---+---+---+---+---+---+---+---+--+--+
BE/LE  |=E2=80=9CT=E2=80=9D|=E2=80=9Ch=E2=80=9D|=E2=80=9Ci=E2=80=9D|=E2=80=
=9Cs=E2=80=9D|=E2=80=9C =E2=80=9D|=E2=80=9Ci=E2=80=9D|=E2=80=9Cs=E2=80=9D|=
=E2=80=9C =E2=80=9D|=E2=80=9Ca=E2=80=9D|=E2=80=9C =E2=80=9D|=E2=80=9CT=E2=
=80=9D|=E2=80=9CE=E2=80=9D|=E2=80=9CS=E2=80=9D|=E2=80=9CT=E2=80=9D|00|00|
       +---+---+---+---+---+---+---+---+---+---+---+---+---+---+--+--+
=20=20=20=20
    For LE: u[0] =3D 0, u[1] =3D 0, u[2] =3D "T", u[3] =3D "S", ....=20
    For BE: u[0] =3D "T", u[1] =3D "h", u[2]=3D"i", u[3]=3D"s", ....
=20=20=20=20
    Storage should be of following order:
       +---+---+---+---+---+---+---+---+---+---+---+---+---+---+--+--+
       |=E2=80=9CT=E2=80=9D|=E2=80=9Ch=E2=80=9D|=E2=80=9Ci=E2=80=9D|=E2=80=
=9Cs=E2=80=9D|=E2=80=9C =E2=80=9D|=E2=80=9Ci=E2=80=9D|=E2=80=9Cs=E2=80=9D|=
=E2=80=9C =E2=80=9D|=E2=80=9Ca=E2=80=9D|=E2=80=9C =E2=80=9D|=E2=80=9CT=E2=
=80=9D|=E2=80=9CE=E2=80=9D|=E2=80=9CS=E2=80=9D|=E2=80=9CT=E2=80=9D|FF|FF|
       +---+---+---+---+---+---+---+---+---+---+---+---+---+---+--+--+

Please let me know your thoughts.

While discussing here with Bharata, I think I will need to handle host
endian here?

Regards,
Nikunj
=20=20=20=20
