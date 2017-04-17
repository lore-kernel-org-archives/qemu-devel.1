Received: from eggs.gnu.org ([2001:4830:134:3::10]:52510)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhang.zhanghailiang@huawei.com>) id 1d00EA-0005Yt-4U
	for qemu-devel@nongnu.org; Mon, 17 Apr 2017 02:33:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhang.zhanghailiang@huawei.com>) id 1d00E9-0000f0-37
	for qemu-devel@nongnu.org; Mon, 17 Apr 2017 02:33:34 -0400
References: <1492005921-15664-1-git-send-email-zhang.zhanghailiang@huawei.com>
	<1492005921-15664-3-git-send-email-zhang.zhanghailiang@huawei.com>
	<4125e702-1298-f7c6-5152-fbf3b5d06f57@redhat.com>
From: Hailiang Zhang <zhang.zhanghailiang@huawei.com>
Message-ID: <58F46159.3060103@huawei.com>
Date: Mon, 17 Apr 2017 14:31:53 +0800
MIME-Version: 1.0
In-Reply-To: <4125e702-1298-f7c6-5152-fbf3b5d06f57@redhat.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 2/6] replication: add shared-disk and
 shared-disk-id options
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, stefanha@redhat.com, qemu-devel@nongnu.org
Cc: xuquan8@huawei.com, kwolf@redhat.com, xiecl.fnst@cn.fujitsu.com, zhangchen.fnst@cn.fujitsu.com, Wen Congyang <wency@cn.fujitsu.com>, qemu-block@nongnu.org

On 2017/4/12 22:28, Eric Blake wrote:
> On 04/12/2017 09:05 AM, zhanghailiang wrote:
>> We use these two options to identify which disk is
>> shared
>>
>> Signed-off-by: zhanghailiang <zhang.zhanghailiang@huawei.com>
>> Signed-off-by: Wen Congyang <wency@cn.fujitsu.com>
>> Signed-off-by: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
>> ---
>> v4:
>> - Add proper comment for primary_disk (Stefan)
>> v2:
>> - Move g_free(s->shared_disk_id) to the common fail process place (Stefan)
>> - Fix comments for these two options
>> ---
>> +++ b/qapi/block-core.json
>> @@ -2661,12 +2661,20 @@
>>   #          node who owns the replication node chain. Must not be given in
>>   #          primary mode.
>>   #
>> +# @shared-disk-id: Id of shared disk while is replication mode, if @shared-disk
>> +#                  is true, this option is required (Since: 2.10)
>> +#
>> +# @shared-disk: To indicate whether or not a disk is shared by primary VM
>> +#               and secondary VM. (The default is false) (Since: 2.10)
>> +#
>>   # Since: 2.9
>>   ##
>>   { 'struct': 'BlockdevOptionsReplication',
>>     'base': 'BlockdevOptionsGenericFormat',
>>     'data': { 'mode': 'ReplicationMode',
>> -            '*top-id': 'str' } }
>> +            '*top-id': 'str',
>> +            '*shared-disk-id': 'str',
>> +            '*shared-disk': 'bool' } }
> Do we need a separate bool and string? Or is it sufficient to say that
> if shared-disk is omitted, we are not sharing, and that if a shared-disk
> string is present, then we are sharing and it names the id of the shared
> disk.

Er,  Yes, We need both of them, the command line of secondary sides is like:

  -drive if=virtio,id=active-disk0,driver=replication,mode=secondary,\
         file.driver=qcow2,top-id=active-disk0,\
         file.file.filename=/mnt/ramfs/active_disk.img,\
         file.backing=hidden_disk0,shared-disk=on
We only need the bool shared-disk to indicate whether disk is sharing or not, but
for primary side, we need to the blockdev-add command to tell primary which disk is shared.
   { 'execute': 'blockdev-add',
     'arguments': {
         'driver': 'replication',
         'node-name': 'rep',
         'mode': 'primary',
         'shared-disk-id': 'primary_disk0',
         'shared-disk': true,
         'file': {
             'driver': 'nbd',
             'export': 'hidden_disk0',
             'server': {
                 'type': 'inet',
                 'data': {
                     'host': 'xxx.xxx.xxx.xxx',
                     'port': 'yyy'
                 }
             }
         }
      }
   }
