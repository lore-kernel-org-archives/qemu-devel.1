Received: from eggs.gnu.org ([2001:4830:134:3::10]:34018)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1eUCWw-0007mS-2p
	for qemu-devel@nongnu.org; Wed, 27 Dec 2017 09:18:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1eUCWs-0007aa-Cx
	for qemu-devel@nongnu.org; Wed, 27 Dec 2017 09:18:02 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:37528)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1eUCWs-0007Xl-40
	for qemu-devel@nongnu.org; Wed, 27 Dec 2017 09:17:58 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vBREHO7T125047
	for <qemu-devel@nongnu.org>; Wed, 27 Dec 2017 09:17:56 -0500
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2f4cdpapkf-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 27 Dec 2017 09:17:55 -0500
Received: from localhost
	by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Wed, 27 Dec 2017 07:17:55 -0700
References: <1510323112-2207-1-git-send-email-stefanb@linux.vnet.ibm.com>
	<1510323112-2207-10-git-send-email-stefanb@linux.vnet.ibm.com>
	<CAJ+F1CKOq2p_Nsz6EFQCHGhfj7ntD6z2aohWPadrKXtEJS8WAw@mail.gmail.com>
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Wed, 27 Dec 2017 09:17:51 -0500
MIME-Version: 1.0
In-Reply-To: <CAJ+F1CKOq2p_Nsz6EFQCHGhfj7ntD6z2aohWPadrKXtEJS8WAw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <92aeaca3-9004-4133-b514-f341367175ab@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 09/13] tpm: Introduce condition to
 notify waiters of completed command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>
Cc: QEMU <qemu-devel@nongnu.org>, Amarnath Valluri <amarnath.valluri@intel.com>

On 12/22/2017 08:24 AM, Marc-Andr=C3=A9 Lureau wrote:
> On Fri, Nov 10, 2017 at 3:11 PM, Stefan Berger
> <stefanb@linux.vnet.ibm.com> wrote:
>> Introduce a lock and a condition to notify anyone waiting for the comp=
letion
>> of the execution of a TPM command by the backend (thread). The backend
>> uses the condition to signal anyone waiting for command completion.
>> We need to place the condition in two locations: one is invoked by the
>> backend thread, the other by the bottom half thread.
>> We will use the signaling to wait for command completion before VM
>> suspend.
>>
>> Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
>> ---
>>   hw/tpm/tpm_tis.c | 12 ++++++++++++
>>   1 file changed, 12 insertions(+)
>>
>> diff --git a/hw/tpm/tpm_tis.c b/hw/tpm/tpm_tis.c
>> index 035c6ef..86e9a92 100644
>> --- a/hw/tpm/tpm_tis.c
>> +++ b/hw/tpm/tpm_tis.c
>> @@ -80,6 +80,9 @@ typedef struct TPMState {
>>       TPMVersion be_tpm_version;
>>
>>       size_t be_buffer_size;
>> +
>> +    QemuMutex state_lock;
>> +    QemuCond cmd_complete;
> Looks like the cond is unused in the following patches.

You are right. I will drop this patch. It may have been needed before=20
the refactoring you did.

    Stefan
