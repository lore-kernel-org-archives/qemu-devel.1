Received: from eggs.gnu.org ([2001:4830:134:3::10]:50747)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <s1seetee@linux.vnet.ibm.com>) id 1eOyzp-00056H-HR
	for qemu-devel@nongnu.org; Tue, 12 Dec 2017 23:50:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <s1seetee@linux.vnet.ibm.com>) id 1eOyzm-0006yq-DS
	for qemu-devel@nongnu.org; Tue, 12 Dec 2017 23:50:17 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:58356)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <s1seetee@linux.vnet.ibm.com>)
	id 1eOyzm-0006ww-2j
	for qemu-devel@nongnu.org; Tue, 12 Dec 2017 23:50:14 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vBD4nv26067488
	for <qemu-devel@nongnu.org>; Tue, 12 Dec 2017 23:50:09 -0500
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2etrs7terw-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 12 Dec 2017 23:50:08 -0500
Received: from localhost
	by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <s1seetee@linux.vnet.ibm.com>;
	Tue, 12 Dec 2017 23:50:07 -0500
References: <1511273358-21789-1-git-send-email-s1seetee@linux.vnet.ibm.com>
	<20171212164114.GF2409@work-vm>
From: seeteena <s1seetee@linux.vnet.ibm.com>
Date: Wed, 13 Dec 2017 10:20:01 +0530
MIME-Version: 1.0
In-Reply-To: <20171212164114.GF2409@work-vm>
Content-Language: en-US
Message-Id: <e37d8871-544f-3c4f-3a59-bb66dc5c8b67@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1] hmp: 'info snapshots' not showing the id
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, lma@suse.com
Cc: qemu-devel@nongnu.org, mreitz@redhat.com

Hi David,

While creating snapshots when tag name '0' used in the very first and followed by tag name '1' then snapshot created with tag name '0' is getting erased.
A snapshot is identified by a name computed either from an id, which is basically a numerical counter starting at 1 for qcow2, or from a tag, which is a string (provided
by the user or automatically computed).

(qemu) savevm 0

This creates a snapshot with tag '0' and id '1'.

> (qemu) savevm 1

This deletes snapshot with name '1' (ie, with id '1') and creates snapshot with tag '1' and id '1'.

 From the output of 'info snapshots' id '1' is not seen for tag '0' instead seeing an empty field.

ID        TAG                 VM SIZE                DATE       VM CLOCK
--        0                      338M 2017-10-16 13:44:35   00:02:07.491

If an ID shown as '1' in the above then user can understand the above documented stuff i.e "If there is already a snapshot with the same tag or ID, it is replaced".
The '--' in ID field is annoying.


On 12/12/2017 10:11 PM, Dr. David Alan Gilbert wrote:
> * Seeteena Thoufeek (s1seetee@linux.vnet.ibm.com) wrote:
>> (qemu) info snapshots
>> List of snapshots present on all disks:
>> ID        TAG                 VM SIZE                DATE       VM CLOCK
>> --         1                      314M 2017-11-15 15:22:18   00:02:25.695
>> --         2                      319M 2017-11-15 15:23:03   00:02:45.970
>> --         3                      319M 2017-11-15 15:23:37   00:02:56.328
>>
>> ID field is showing -- with no information.
>>
>> Signed-off-by: Seeteena Thoufeek <s1seetee@linux.vnet.ibm.com>
> Hi Seeteena,
>    Your change doesn't seem to be consistent with the comment above it.
> I don't know the detailed history of snapshots, but that comment and the
> pstrcpy comes from Lin Ma's commit 3a1ee711 which seems to be saying the
> ID can't be trusted.
>
> Dave
>
>> ---
>>   hmp.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/hmp.c b/hmp.c
>> index 35a7041..1921b3b 100644
>> --- a/hmp.c
>> +++ b/hmp.c
>> @@ -1454,7 +1454,7 @@ void hmp_info_snapshots(Monitor *mon, const QDict *qdict)
>>               /* The ID is not guaranteed to be the same on all images, so
>>                * overwrite it.
>>                */
>> -            pstrcpy(sn->id_str, sizeof(sn->id_str), "--");
>> +            pstrcpy(sn->id_str, sizeof(sn->id_str), sn->id_str);
>>               bdrv_snapshot_dump((fprintf_function)monitor_printf, mon, sn);
>>               monitor_printf(mon, "\n");
>>           }
>> -- 
>> 1.8.3.1
>>
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
>
