Received: from eggs.gnu.org ([2001:4830:134:3::10]:53560)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liujbjl@linux.vnet.ibm.com>) id 1daI6i-0008GS-9I
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 04:55:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liujbjl@linux.vnet.ibm.com>) id 1daI6d-0002ZW-EL
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 04:55:52 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:50307
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <liujbjl@linux.vnet.ibm.com>)
	id 1daI6d-0002Y9-9D
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 04:55:47 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v6Q8rgo2102954
	for <qemu-devel@nongnu.org>; Wed, 26 Jul 2017 04:55:46 -0400
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2bxpk23wxn-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 26 Jul 2017 04:55:45 -0400
Received: from localhost
	by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <liujbjl@linux.vnet.ibm.com>;
	Wed, 26 Jul 2017 02:55:45 -0600
References: <20170721034730.25612-1-crosa@redhat.com>
	<20170721034730.25612-4-crosa@redhat.com>
	<ddf57b6c-42b2-0ec1-7d53-71d5266727fe@linux.vnet.ibm.com>
	<20170725154546.GR23343@stefanha-x1.localdomain>
	<20170725154854.GS26394@redhat.com>
From: Jing Liu <liujbjl@linux.vnet.ibm.com>
Date: Wed, 26 Jul 2017 16:55:39 +0800
MIME-Version: 1.0
In-Reply-To: <20170725154854.GS26394@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <7343a904-6f31-b8b1-c721-267c66e4cb75@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 3/3] qemu-iotests: require
 CONFIG_LINUX_AIO for test 087
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>
Cc: Cleber Rosa <crosa@redhat.com>, qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>



On 2017/7/25 =E4=B8=8B=E5=8D=8811:48, Daniel P. Berrange wrote:
> On Tue, Jul 25, 2017 at 04:45:46PM +0100, Stefan Hajnoczi wrote:
>> On Mon, Jul 24, 2017 at 02:44:13PM +0800, Jing Liu wrote:
>>> On 2017/7/21 =E4=B8=8A=E5=8D=8811:47, Cleber Rosa wrote:
>>>> One of the "sub-"tests of test 087 requires CONFIG_LINUX_AIO.
>>>>
>>>> As a PoC/RFC, this goes the easy route and skips the test as a whole
>>>> when that feature is missing.  Other approaches include splitting
>>>> the test and adding extra filtering.
>>>>
>>>> Signed-off-by: Cleber Rosa <crosa@redhat.com>
>>>> ---
>>>>    tests/qemu-iotests/087 | 1 +
>>>>    1 file changed, 1 insertion(+)
>>>>
>>>> diff --git a/tests/qemu-iotests/087 b/tests/qemu-iotests/087
>>>> index f8e4903..a2fb7de 100755
>>>> --- a/tests/qemu-iotests/087
>>>> +++ b/tests/qemu-iotests/087
>>>> @@ -34,6 +34,7 @@ status=3D1	# failure is the default!
>>>>    _supported_fmt qcow2
>>>>    _supported_proto file
>>>>    _supported_os Linux
>>>> +_require_feature CONFIG_LINUX_AIO
>>> I tested that CONFIG_NETTLE_KDF is also a necessary for 087.
>>>
>>> +_require_feature CONFIG_NETTLE_KDF
>> Are you sure?  Looks like either nettle or gcrypt is needed:
> Correct, it works with either.
Ah, because I just found out nettle which related to KDF.
why can not find out gcrypt.h in qemu?
How to compile config_gcrypt_kdf into qemu?
>
>> crypto/Makefile.objs:crypto-obj-$(CONFIG_NETTLE_KDF) +=3D pbkdf-nettle=
.o
>> crypto/Makefile.objs:crypto-obj-$(if $(CONFIG_NETTLE_KDF),n,$(CONFIG_G=
CRYPT_KDF)) +=3D pbkdf-gcrypt.o
>>
>> But this shows why the compile-time testing of features is ugly:
>>
>> 1. It duplicates build dependency logic into the test cases.
>>
>> 2. The test cases don't care about nettle vs gcrypt and they shouldn't
>>     have to know about it.  They just care whether LUKS is available o=
r
>>     not.
> Yeah that knowledge is messy and fragile wrt future changes.
>
>
> Regards,
> Daniel
