Received: from eggs.gnu.org ([2001:4830:134:3::10]:37068)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zyimin@linux.ibm.com>) id 1fJx6j-0002Pa-I2
	for qemu-devel@nongnu.org; Sat, 19 May 2018 04:20:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zyimin@linux.ibm.com>) id 1fJx6f-0004QW-H7
	for qemu-devel@nongnu.org; Sat, 19 May 2018 04:20:53 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:51824)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <zyimin@linux.ibm.com>)
	id 1fJx6f-0004Pz-81
	for qemu-devel@nongnu.org; Sat, 19 May 2018 04:20:49 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w4J8IiMF004282
	for <qemu-devel@nongnu.org>; Sat, 19 May 2018 04:20:47 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2j2e8nkm5p-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Sat, 19 May 2018 04:20:46 -0400
Received: from localhost
	by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <zyimin@linux.ibm.com>;
	Sat, 19 May 2018 04:20:45 -0400
References: <20180515113348.10516-1-zyimin@linux.ibm.com>
	<20180515113348.10516-2-zyimin@linux.ibm.com>
	<20180517124109.GJ17734@vader>
	<20180518075212.GE3416@dnr> <20180518091916.GA22292@vader>
	<20180518130729.GF3416@dnr>
From: Yi Min Zhao <zyimin@linux.ibm.com>
Date: Sat, 19 May 2018 16:20:37 +0800
MIME-Version: 1.0
In-Reply-To: <20180518130729.GF3416@dnr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Message-Id: <7149dfa9-7d3a-a2ff-b326-7e9ba71f8fe1@linux.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 1/1] sandbox: disable -sandbox if
 CONFIG_SECCOMP undefined
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?J=c3=a1n_Tomko?= <jtomko@redhat.com>, Eduardo Otubo <otubo@redhat.com>
Cc: fiuczy@linux.ibm.com, borntraeger@de.ibm.com, qemu-devel@nongnu.org



=E5=9C=A8 2018/5/18 =E4=B8=8B=E5=8D=889:07, J=C3=A1n Tomko =E5=86=99=E9=81=
=93:
> On Fri, May 18, 2018 at 11:19:16AM +0200, Eduardo Otubo wrote:
>> On 18/05/2018 - 09:52:12, J=C3=A1n Tomko wrote:
>>> On Thu, May 17, 2018 at 02:41:09PM +0200, Eduardo Otubo wrote:
>>> > On 15/05/2018 - 19:33:48, Yi Min Zhao wrote:
>>> > > If CONFIG_SECCOMP is undefined, the option 'elevateprivileges'=20
>>> remains
>>> > > compiled. This would make libvirt set the corresponding=20
>>> capability and
>>> > > then trigger the guest startup fails. So this patch excludes the=20
>>> code
>>> > > regarding seccomp staff if CONFIG_SECCOMP is undefined.
>>> >
>>> > Just a sugestion for the next patch you send: If it's a single=20
>>> patch, you don't
>>> > need to format it with a cover-letter. Just put all the=20
>>> description in the body,
>>> > or if you need to add a text that shouldn't be included in the=20
>>> commit message,
>>> > just add it after the "---" after Signed-off-by.
>>> >
>>> > >
>>> > > Signed-off-by: Yi Min Zhao <zyimin@linux.ibm.com>
>>> > > ---
>>> > >=C2=A0 vl.c | 13 ++++++++-----
>>> > >=C2=A0 1 file changed, 8 insertions(+), 5 deletions(-)
>>> > >
>>>
>
> [...]
>
>>> Current libvirt logic assumes the -sandbox option is always present.
>>> (IIRC it was introduced in QEMU 1.1 and when we switched from help
>>> scraping to capability probing via QMP for QEMU 1.2, there was no
>>> way to detect it)
>>>
>>> This patch fixes the usage of QEMU new enough for seccomp blacklist
>>> (where libvirt enables the sandbox by default),
>>> but breaks the usage of QEMU with compiled out sandbox and
>>> setting
>>> =C2=A0seccomp_sandbox =3D 0
>>> in libvirt's qemu.conf:
>>>
>>> error: internal error: process exited while connecting to monitor:
>>> qemu-git: -sandbox off: There is no option group 'sandbox'
>>>
>>>
>>> But now libvirt requires QEMU >=3D 1.5.0 which already supports
>>> query-command-line-options, so if you want the option gone completely
>>> --without-seccomp, I can add the code that probes for it and
>>> make seccomp_sandbox =3D 0 a no-op if it's compiled out.
>>
>> This looks like a good solution for the libvirt side. Can you add=20
>> this support
>> so we can merge this fix?
>>
>
> Patches proposed:
> https://www.redhat.com/archives/libvir-list/2018-May/msg01430.html
>
> Jano
Thanks for your work!
