Received: from eggs.gnu.org ([2001:4830:134:3::10]:47939)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alifm@linux.ibm.com>) id 1gSojS-0000VH-O5
	for Qemu-devel@nongnu.org; Fri, 30 Nov 2018 14:45:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alifm@linux.ibm.com>) id 1gSojN-0007bc-FP
	for Qemu-devel@nongnu.org; Fri, 30 Nov 2018 14:45:46 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:44952
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alifm@linux.ibm.com>) id 1gSojN-0007bD-AJ
	for Qemu-devel@nongnu.org; Fri, 30 Nov 2018 14:45:41 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	wAUJeBTd014418
	for <Qemu-devel@nongnu.org>; Fri, 30 Nov 2018 14:45:40 -0500
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2p3a3nuu8j-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <Qemu-devel@nongnu.org>; Fri, 30 Nov 2018 14:45:39 -0500
Received: from localhost
	by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <Qemu-devel@nongnu.org> from <alifm@linux.ibm.com>;
	Fri, 30 Nov 2018 19:45:39 -0000
References: <cover.1543593569.git.alifm@linux.ibm.com>
	<cb554c04ee50ac970fa10edaa090982bef18f673.1543593569.git.alifm@linux.ibm.com>
	<eaba14ba-5c92-34d4-ab7c-3cc5aefdcccb@redhat.com>
From: Farhan Ali <alifm@linux.ibm.com>
Date: Fri, 30 Nov 2018 14:45:35 -0500
MIME-Version: 1.0
In-Reply-To: <eaba14ba-5c92-34d4-ab7c-3cc5aefdcccb@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Message-Id: <0f3919ee-ff47-6552-1f13-6c2cb68ba27b@linux.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC for 3.1? or 4 v2 1/1] qemu-iotests: Don't run
 the test when user is root
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org
Cc: kwolf@redhat.com, "Qemu-devel@nongnu.org" <Qemu-devel@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>



On 11/30/2018 12:50 PM, Eric Blake wrote:
> Adding qemu-devel - all patches should go there, especially if you want=
=20
> to get Peter's attention that this might be a 3.1 candidate if we have=20
> other reasons to spin -rc4.
>=20
> On 11/30/18 10:04 AM, Farhan Ali wrote:
>> Test 232 creates image files with read-only permission and
>> expects an error message when trying to access the image
>> files with read-only and auto-read-only turned off.
>>
>> Don't run as root user, since root can open files with read/write
>> access for read-only files.
>>
>> Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
>> ---
>> =C2=A0 tests/qemu-iotests/232 | 8 ++++++++
>> =C2=A0 1 file changed, 8 insertions(+)
>>
>> diff --git a/tests/qemu-iotests/232 b/tests/qemu-iotests/232
>> index 0708b8b..05d5f2f 100755
>> --- a/tests/qemu-iotests/232
>> +++ b/tests/qemu-iotests/232
>> @@ -41,6 +41,14 @@ _supported_fmt generic
>> =C2=A0 _supported_proto file
>> =C2=A0 _supported_os Linux
>> +tmp=3D'file'
>> +touch $tmp
>> +chmod a-w $tmp
>> +if [ -w $tmp ]
>> +then
>> +=C2=A0=C2=A0=C2=A0 _notrun "Cannot run this test as root user"
>> +fi
>> +
>=20
> I know you just copied from my suggestion, but now looking at it, this=20
> leaves 'tmp' around in the directory for both success and skip. Better=20
> might be to just check whether $TEST_IMG is writable, immediately after=
=20
> the existing 'chmod a-w $TEST_IMG' line (Hmm - that line is already=20
> broken for not quoting "$TEST_IMG" in case it contains whitespace).

Ah yes, I forgot about the fact the 'file' will linger around. I will=20
spin up a v3.

>=20
> I don't see this being a reason for -rc4 on its own (most people don't=20
> run iotests as root); and the fact that we're still working on the fina=
l=20
> contents of what the patch should contain, as well as the fact that the=
=20
> patch doesn't affect the main binaries, means that if it were up to me,=
=20
> I'd defer it to 4.0. Kevin may have a different opinion, though, since=20
> it is his test, and new to 3.1.
>=20
