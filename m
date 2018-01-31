Received: from eggs.gnu.org ([2001:4830:134:3::10]:39800)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1egrHh-0006Op-Ew
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 07:14:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1egrHf-0001xD-Bw
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 07:14:37 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:45086
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1egrHf-0001wW-6P
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 07:14:35 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w0VCCANQ132493
	for <qemu-devel@nongnu.org>; Wed, 31 Jan 2018 07:14:34 -0500
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2fuafjrf9h-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 31 Jan 2018 07:14:34 -0500
Received: from localhost
	by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Wed, 31 Jan 2018 12:14:31 -0000
References: <20180130133828.77336-1-borntraeger@de.ibm.com>
	<20180130133828.77336-2-borntraeger@de.ibm.com>
	<fb70731d-b857-8adb-0dc7-cd072a2c50b1@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Wed, 31 Jan 2018 13:14:28 +0100
MIME-Version: 1.0
In-Reply-To: <fb70731d-b857-8adb-0dc7-cd072a2c50b1@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <34c2cdf6-b773-61b6-64de-943cb2cf8ace@de.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v2 1/1] Fix configure for s390 qemu on
 alpine and other busybox environments
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Eric Blake <eblake@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Alice Frosi <alice@linux.vnet.ibm.com>, qemu-s390x <qemu-s390x@nongnu.org>, Cornelia Huck <cohuck@redhat.com>, qemu-devel <qemu-devel@nongnu.org>



On 01/30/2018 04:41 PM, Eric Blake wrote:
> On 01/30/2018 07:38 AM, Christian Borntraeger wrote:
>> From: Alice Frosi <alice@linux.vnet.ibm.com>
>>
>> In alpine docker image the qemu-system-s390x build is broken and
>> it throws this error:
>> qemu-system-s390x: Initialization of device s390-ipl failed: could not
>> load bootloader 's390-ccw.img'
>>
>> The grep command of busybox uses regex. This fails on binary data
>> (e.g. stops on every \0), so it does not identify the string
>> BiGeNdIaN in the test case big/little. Therefore, it assumes
>> that the architecture is little endian.
>>
>> This fix solves the grep problem by printing the content of
>> TMPO with strings
>>
>> Signed-off-by: Alice Frosi <alice@linux.vnet.ibm.com>
>> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
>> [some changes to patch description, add -a option to strings]
>> ---
>> v1->v2:
>> - Fix email address of Alice
>> - Fix patch prefix
> 
> Oh, that reminds me I still have an old patch to qobject_from_jsonf that
> probed $TMPO using strings [1].  It does look like 'strings -a' is
> portable, so I'll have to update my patch when I dig it back out of storage.
> 
> [1] https://lists.gnu.org/archive/html/qemu-devel/2017-07/msg07963.html
> 
>> +++ b/configure
>> @@ -1906,9 +1906,9 @@ int main(int argc, char *argv[]) {
>>  EOF
>>  
>>  if compile_object ; then
>> -    if grep -q BiGeNdIaN $TMPO ; then
>> +    if strings -a $TMPO | grep -q BiGeNdIaN ; then
>>          bigendian="yes"
>> -    elif grep -q LiTtLeEnDiAn $TMPO ; then
>> +    elif strings -a $TMPO | grep -q LiTtLeEnDiAn ; then
> 
> Yes, this is indeed a more portable way to grep binary files (it's also
> possible to do:
> 
> tr -d '\0' < $TMPO | grep -q ...
> 
> if we're worried about the availability of strings, but I don't see that
> being a problem if no one reports it actually failing).
> 
> Reviewed-by: Eric Blake <eblake@redhat.com>

Peter, does that patch work on MacOS and Windows? If yes we could
get this patch in via the s390 tree.
