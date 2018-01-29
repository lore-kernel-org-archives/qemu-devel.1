Received: from eggs.gnu.org ([2001:4830:134:3::10]:46289)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <walling@linux.vnet.ibm.com>) id 1egAZa-0002XT-4l
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 09:38:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <walling@linux.vnet.ibm.com>) id 1egAZW-00086P-3N
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 09:38:14 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:37828)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <walling@linux.vnet.ibm.com>)
	id 1egAZV-00086C-QM
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 09:38:09 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w0TEYFTH040354
	for <qemu-devel@nongnu.org>; Mon, 29 Jan 2018 09:38:07 -0500
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2ft4rttk0r-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 29 Jan 2018 09:38:06 -0500
Received: from localhost
	by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <walling@linux.vnet.ibm.com>;
	Mon, 29 Jan 2018 09:38:05 -0500
References: <1516732013-18272-1-git-send-email-walling@linux.vnet.ibm.com>
	<1516732013-18272-10-git-send-email-walling@linux.vnet.ibm.com>
	<00a86803-1978-db18-f076-60eb3c27de74@redhat.com>
From: "Collin L. Walling" <walling@linux.vnet.ibm.com>
Date: Mon, 29 Jan 2018 09:38:01 -0500
MIME-Version: 1.0
In-Reply-To: <00a86803-1978-db18-f076-60eb3c27de74@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Message-Id: <65835736-9e6b-ad58-9693-2f268aada3fd@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH v4 09/10] s390-ccw: read user
 input for boot index via the SCLP console
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: alifm@linux.vnet.ibm.com, frankja@linux.vnet.ibm.com, thuth@redhat.com, cohuck@redhat.com, borntraeger@de.ibm.com

On 01/29/2018 08:08 AM, David Hildenbrand wrote:
> On 23.01.2018 19:26, Collin L. Walling wrote:
>> Implements an sclp_read function to capture input from the
>> console and a wrapper function that handles parsing certain
>> characters and adding input to a buffer. The input is checked
>> for any erroneous values and is handled appropriately.
>>
>> A prompt will persist until input is entered or the timeout
>> expires (if one was set). Example:
>>
>>      Please choose (default will boot in 10 seconds):
>>
>> Correct input will boot the respective boot index. If the
>> user's input is empty, 0, or if the timeout expires, then
>> the default zipl entry will be chosen. If the input is
>> within the range of available boot entries, then the
>> selection will be booted. Any erroneous input will cancel
>> the timeout and re-prompt the user.
>>
>> Signed-off-by: Collin L. Walling <walling@linux.vnet.ibm.com>
>> ---
> Also, a very nasty thing to take care of is the following:
>
> SCLP and ckc interrupt at the same time pending.
>
> -> We only dequeue one, the other remains pending and is presented to
> the guest
>

If I understand the assembler correctly, consume_sclp_int() takes care=20
of enabling /
disabling the service interrupts for us.

However, I /do/like the refactoring suggestion you made in a previous=20
reply.=C2=A0 It makes
things easier to read.

If it makes sense to do so (such that the refactoring doesn't end up=20
taking me down a
rabbit hole) I'll spin up another patch that refactors the enabling /=20
disabling of
the service interrupt.

--=20
- Collin L Walling
