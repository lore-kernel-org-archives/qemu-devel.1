Received: from eggs.gnu.org ([2001:4830:134:3::10]:44120)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <muriloo@linux.vnet.ibm.com>) id 1eXTHK-00020S-3g
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 09:47:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <muriloo@linux.vnet.ibm.com>) id 1eXTHG-0001Pz-51
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 09:47:26 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:52210)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <muriloo@linux.vnet.ibm.com>)
	id 1eXTHF-0001PJ-ST
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 09:47:22 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	w05EinAO057330
	for <qemu-devel@nongnu.org>; Fri, 5 Jan 2018 09:47:20 -0500
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2fab7nrj7q-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 05 Jan 2018 09:47:20 -0500
Received: from localhost
	by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <muriloo@linux.vnet.ibm.com>;
	Fri, 5 Jan 2018 07:47:19 -0700
References: <20180105133241.14141-1-muriloo@linux.vnet.ibm.com>
	<20180105133241.14141-2-muriloo@linux.vnet.ibm.com>
	<07c8789d-bebb-deed-b64c-806edf17f99c@redhat.com>
From: =?UTF-8?Q?Murilo_Opsfelder_Ara=c3=bajo?= <muriloo@linux.vnet.ibm.com>
Date: Fri, 5 Jan 2018 12:47:10 -0200
MIME-Version: 1.0
In-Reply-To: <07c8789d-bebb-deed-b64c-806edf17f99c@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Message-Id: <fb11ac10-0b17-b9d6-0e2a-540cac882900@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH 1/1] block/nbd: fix segmentation fault when
 .desc is not null-terminated
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-ppc@nongnu.org, qemu-block@nongnu.org, qemu-stable <qemu-stable@nongnu.org>, Max Reitz <mreitz@redhat.com>, R Nageswara Sastry <nasastry@in.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>

On 01/05/2018 11:57 AM, Eric Blake wrote:
> On 01/05/2018 07:32 AM, Murilo Opsfelder Araujo wrote:
>> The find_desc_by_name() from util/qemu-option.c relies on the .name not being
>> NULL to call strcmp(). This check becomes unsafe when the list is not
>> NULL-terminated, which is the case of nbd_runtime_opts in block/nbd.c, and can
>> result in segmentation fault when strcmp() tries to access an invalid memory:
> 
> Thanks for the report and patch.  Adding qemu-stable in cc.
> 
>>
>> This patch fixes the segmentation fault in strcmp() by adding a NULL element at
>> the end of nbd_runtime_opts.desc list, which is the common practice to most of
>> other structs like runtime_opts in block/null.c. Thus, the desc[i].name != NULL
>> check becomes safe because it will not evaluate to true when .desc list reached
>> its end.
>>
>> Reported-by: R. Nageswara Sastry <nasastry@in.ibm.com>
>> Buglink: https://bugs.launchpad.net/qemu/+bug/1727259
>> Signed-off-by: Murilo Opsfelder Araujo <muriloo@linux.vnet.ibm.com>
> 
> I'll update the commit message to add in the commit id that introduced
> the problem, as well as check that other QemuOptsList do not have a
> similar problem; I'm queueing this on the NBD tree and will submit a
> pull request soon.
> 
> Reviewed-by: Eric Blake <eblake@redhat.com>

Hi, Eric.

A quick look brought my attention to:

block/ssh.c
530:static QemuOptsList ssh_runtime_opts = {

I've sent a patch to fix it too.

Thanks.
-- 
Murilo
