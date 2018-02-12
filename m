Received: from eggs.gnu.org ([2001:4830:134:3::10]:37158)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <muriloo@linux.vnet.ibm.com>) id 1elJdm-0001Ic-Qb
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 14:19:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <muriloo@linux.vnet.ibm.com>) id 1elJdi-0005Hk-Uq
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 14:19:50 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:44296
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <muriloo@linux.vnet.ibm.com>)
	id 1elJdi-0005HR-Pm
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 14:19:46 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w1CJFrNB132136
	for <qemu-devel@nongnu.org>; Mon, 12 Feb 2018 14:19:46 -0500
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2g3dsqg2xd-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 12 Feb 2018 14:19:45 -0500
Received: from localhost
	by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <muriloo@linux.vnet.ibm.com>;
	Mon, 12 Feb 2018 12:19:44 -0700
References: <20180212142506.28445-1-danielhb@linux.vnet.ibm.com>
	<20180212142506.28445-2-danielhb@linux.vnet.ibm.com>
	<98934c2f-2210-83d7-d629-157e5a7cee8e@linux.vnet.ibm.com>
	<b4cafa8f-efac-00e1-683a-304a91c695ca@redhat.com>
From: Murilo Opsfelder Araujo <muriloo@linux.vnet.ibm.com>
Date: Mon, 12 Feb 2018 17:19:38 -0200
MIME-Version: 1.0
In-Reply-To: <b4cafa8f-efac-00e1-683a-304a91c695ca@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Message-Id: <49dd3029-ceee-8ca7-5da2-b257ffabe74e@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 1/1] dump.c: allow fd_write_vmcore to
 return errno on failure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>, qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com>, Yasmin Beatriz <yasmins@linux.vnet.ibm.com>

On 02/12/2018 03:31 PM, Eric Blake wrote:
> On 02/12/2018 08:46 AM, Murilo Opsfelder Araujo wrote:
>> On 02/12/2018 12:25 PM, Daniel Henrique Barboza wrote:
>>> From: Yasmin Beatriz <yasmins@linux.vnet.ibm.com>
>>>
>>> fd_write_vmcore can fail to execute for a lot of reasons that can be
>>> retrieved by errno, but it only returns -1. This makes difficult for
>>> the caller to know what happened and only a generic error message is
>>> propagated back to the user. This is an example using dump-guest-memo=
ry:
>>>
>=20
>>> +++ b/dump.c
>>> @@ -107,7 +107,7 @@ static int fd_write_vmcore(const void *buf,
>>> size_t size, void *opaque)
>>>
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 written_size =3D qemu_write_full(s->fd=
, buf, size);
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (written_size !=3D size) {
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -1;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -errno;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
>>> @@ -140,7 +140,7 @@ static void write_elf64_header(DumpState *s,
>>> Error **errp)
>>>
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D fd_write_vmcore(&elf_header, s=
izeof(elf_header), s);
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret < 0) {
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_setg(errp, "dump: f=
ailed to write elf header");
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_setg_errno(errp, -r=
et, "dump: failed to write elf
>>> header");
>>
>> Do we need -ret passed to error_setg_errno()? fd_write_vmcore() return=
s
>> negative errno in case of error.
>=20
> Yes, this usage is correct.=C2=A0 error_setg_errno() takes a positive e=
rrno
> value (using strerror, which only decodes positive values into useful
> strings); but we typically return negative errno values (as was
> correctly done in fd_write_vmcore), so the extra layer of negation here
> is needed.
>=20

For some reason I assumed "non-zero" in the error_setg_errno()
description as negative.

Thanks Daniel and Eric.
