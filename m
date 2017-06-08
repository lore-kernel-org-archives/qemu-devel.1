Received: from eggs.gnu.org ([2001:4830:134:3::10]:39280)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <haoqf@linux.vnet.ibm.com>) id 1dIpvg-0005h5-Gt
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 01:24:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <haoqf@linux.vnet.ibm.com>) id 1dIpvd-0005im-BO
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 01:24:20 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:45744
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <haoqf@linux.vnet.ibm.com>)
	id 1dIpvd-0005ih-4P
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 01:24:17 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v585OEXo019234
	for <qemu-devel@nongnu.org>; Thu, 8 Jun 2017 01:24:16 -0400
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2axxd6chpu-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 08 Jun 2017 01:24:15 -0400
Received: from localhost
	by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <haoqf@linux.vnet.ibm.com>;
	Thu, 8 Jun 2017 01:24:15 -0400
References: <20170606052438.35405-1-haoqf@linux.vnet.ibm.com>
	<20170606052438.35405-2-haoqf@linux.vnet.ibm.com>
	<20170606124953.GD5448@noname.redhat.com>
	<a908cc58-3001-0d8a-0415-887b5cbae4e7@linux.vnet.ibm.com>
	<20170607121840.GE2099@work-vm>
From: QingFeng Hao <haoqf@linux.vnet.ibm.com>
Date: Thu, 8 Jun 2017 13:23:54 +0800
MIME-Version: 1.0
In-Reply-To: <20170607121840.GE2099@work-vm>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <0ae1a5d4-6ebc-fe08-a794-bab5b2063e4e@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 1/1] qemu/migration: fix the double free
 problem on from_src_file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org, peterx@redhat.com, borntraeger@de.ibm.com, cornelia.huck@de.ibm.com, liujbjl@linux.vnet.ibm.com, famz@redhat.com



=E5=9C=A8 2017/6/7 20:18, Dr. David Alan Gilbert =E5=86=99=E9=81=93:
> * QingFeng Hao (haoqf@linux.vnet.ibm.com) wrote:
>>
>> =E5=9C=A8 2017/6/6 20:49, Kevin Wolf =E5=86=99=E9=81=93:
>>> Am 06.06.2017 um 07:24 hat QingFeng Hao geschrieben:
> <snip>
>
>>> I can't tell for postcopy_ram_listen_thread() - commit 660819b didn't
>>> seem to remove a qemu_fclose() call there, but I can't see one left
>>> behind either. Was the file leaked before commit 660819b or am I
>>> missing something?
>> I don't think so because loadvm_postcopy_handle_listen creates thread
>> postcopy_ram_listen_thread
>> and passes mis->from_src_file as its arg, which will be closed by
>> migration_incoming_state_destroy.
>> What confuses me is in the series function calls of qemu_loadvm_state_=
main
>> etc, argument f looks
>> to be redundant as mis already contains from_src_file which equals to =
f.
> In postcopy qemu_loadvm_state_main is called with two different file
> arguments but the same mis argument;  see loadvm_handle_cmd_packaged fo=
r
> the other case where it's called on a packaged-file blob.
yes, you are right, I missed that one. :)
>
>> Furthermore, mis may be
>> also redundant as it can be got via migration_incoming_get_current. Th=
anks!
> We keep changing our minds about the preferred style.  Sometimes we
> think it's best to pass the pointer, sometimes we think it's best
> to call get_current.
Got it. Thanks!
>
> Dave
>
>>> Kevin
>>>
>> --=20
>> Regards
>> QingFeng Hao
>>
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
>

--=20
Regards
QingFeng Hao
